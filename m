Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C850C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 06:25:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D78620894
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 06:25:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D78620894
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728497AbeGZHlE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 03:41:04 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:41240 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbeGZHlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 03:41:04 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 8345D609F825;
        Thu, 26 Jul 2018 08:25:44 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id BmWB_g7agBx0; Thu, 26 Jul 2018 08:25:44 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 2CF0E609F828;
        Thu, 26 Jul 2018 08:25:44 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id tMXL6F6t-lm2; Thu, 26 Jul 2018 08:25:44 +0200 (CEST)
Received: from blindfold.localnet (089144206220.atnat0015.highway.bob.at [89.144.206.220])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id 02C5E609F825;
        Thu, 26 Jul 2018 08:25:44 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     Ben Hutchings <ben.hutchings@codethink.co.uk>
Cc:     martin bayern <Martinbayern@outlook.com>, stable@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4.4 15/47] ubi: fastmap: Correctly handle interrupted erasures in EBA
Date:   Thu, 26 Jul 2018 08:25:36 +0200
Message-ID: <2465050.YMUAORSpTR@blindfold>
In-Reply-To: <1532571174.21552.47.camel@codethink.co.uk>
References: <20180710182337.047502999@linuxfoundation.org> <20180710182337.780349008@linuxfoundation.org> <1532571174.21552.47.camel@codethink.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ben,

Am Donnerstag, 26. Juli 2018, 04:12:54 CEST schrieb Ben Hutchings:
> On Tue, 2018-07-10 at 20:24 +0200, Greg Kroah-Hartman wrote:
> > 4.4-stable review patch.  If anyone has any objections, please let me 
know.
> > 
> > ------------------
> > 
> > From: Richard Weinberger <richard@nod.at>
> > 
> > commit 781932375ffc6411713ee0926ccae8596ed0261c upstream.
> > 
> > Fastmap cannot track the LEB unmap operation, therefore it can
> > happen that after an interrupted erasure the mapping still looks
> > good from Fastmap's point of view, while reading from the PEB will
> > cause an ECC error and confuses the upper layer.
> > 
> > Instead of teaching users of UBI how to deal with that, we read back
> > the VID header and check for errors. If the PEB is empty or shows ECC
> > errors we fixup the mapping and schedule the PEB for erasure.
> [...]
> 
> Isn't there a risk here, that a read error leads to erasing data that
> might be recoverable if the read is retried?

Well, read error means that already something went very wrong. At other places
in UBI wo also don't retry reading headers and consider it as fatal when we 
are unable to read it.
We could also read the EC header, but what do we gain from that?
If the VID header is not readable we cannot check fastmap either.

What case exactly do you have in mind?

Thanks,
//richard
