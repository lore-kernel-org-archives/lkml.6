Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3F7EC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 15:32:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B01BD20834
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 15:32:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B01BD20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727792AbeJZAFh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 20:05:37 -0400
Received: from smtprelay0077.hostedemail.com ([216.40.44.77]:33526 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727385AbeJZAFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 20:05:37 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id BA8E483777F0;
        Thu, 25 Oct 2018 15:32:19 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: point05_4e4ff12d4dd37
X-Filterd-Recvd-Size: 2749
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Thu, 25 Oct 2018 15:32:18 +0000 (UTC)
Message-ID: <ce7de2909b7c9958ac63c4386e889509926b651b.camel@perches.com>
Subject: Re: [PATCH] scsi: aic7xxx: Fix unintended sign extension issue
From:   Joe Perches <joe@perches.com>
To:     Colin King <colin.king@canonical.com>,
        Hannes Reinecke <hare@suse.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 25 Oct 2018 08:32:16 -0700
In-Reply-To: <20181025151334.15622-1-colin.king@canonical.com>
References: <20181025151334.15622-1-colin.king@canonical.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-10-25 at 16:13 +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> In the expression "ahc_inb(ahc, port+3) << 24", the initial value is a
> u8, but is promoted to a signed int, then sign-extended to uint64_t.  If
> the value read from the port has the upper bit set then the sign
> extension will set all the upper bits of the expression which is probably
> not what was intended.  Cast to uint64_t to avoid the sign extension.
[]
> diff --git a/drivers/scsi/aic7xxx/aic79xx_core.c b/drivers/scsi/aic7xxx/aic79xx_core.c
[]
> @@ -622,7 +622,7 @@ ahd_inq(struct ahd_softc *ahd, u_int port)
>  	return ((ahd_inb(ahd, port))
>  	      | (ahd_inb(ahd, port+1) << 8)
>  	      | (ahd_inb(ahd, port+2) << 16)
> -	      | (ahd_inb(ahd, port+3) << 24)
> +	      | (((uint64_t)ahd_inb(ahd, port+3)) << 24)
>  	      | (((uint64_t)ahd_inb(ahd, port+4)) << 32)
>  	      | (((uint64_t)ahd_inb(ahd, port+5)) << 40)
>  	      | (((uint64_t)ahd_inb(ahd, port+6)) << 48)

Perhaps a different method using two calls to ahd_inl
is clearer and possibly faster like:

uint64_t
ahd_inq(struct ahd_softc *ahd, u_int port)
{
	return ahd_inl(port) | ((uint64_t)ahd_inl(port + 4) << 32);
}

> diff --git a/drivers/scsi/aic7xxx/aic7xxx_core.c b/drivers/scsi/aic7xxx/aic7xxx_core.c
[]
> @@ -493,7 +493,7 @@ ahc_inq(struct ahc_softc *ahc, u_int port)
>  	return ((ahc_inb(ahc, port))
>  	      | (ahc_inb(ahc, port+1) << 8)
>  	      | (ahc_inb(ahc, port+2) << 16)
> -	      | (ahc_inb(ahc, port+3) << 24)
> +	      | (((uint64_t)ahc_inb(ahc, port+3)) << 24)
>  	      | (((uint64_t)ahc_inb(ahc, port+4)) << 32)
>  	      | (((uint64_t)ahc_inb(ahc, port+5)) << 40)
>  	      | (((uint64_t)ahc_inb(ahc, port+6)) << 48)

here too


