Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACCAEC46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 19:24:45 +0000 (UTC)
X-Greylist: delayed 86 seconds by postgrey-1.34 at mail.kernel.org; Fri, 10 Aug 2018 19:24:45 UTC
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58139215A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58139215A4
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 19:24:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727219AbeHJVyW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 17:54:22 -0400
Received: from smtprelay0112.hostedemail.com ([216.40.44.112]:33102 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726666AbeHJVyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 17:54:21 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 661A3180A8459;
        Fri, 10 Aug 2018 19:23:09 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: hands99_8fb7cafcbc351
X-Filterd-Recvd-Size: 2126
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf05.hostedemail.com (Postfix) with ESMTPA;
        Fri, 10 Aug 2018 19:23:07 +0000 (UTC)
Message-ID: <9b5b906f42dfab78f382c90f66851717d258a15d.camel@perches.com>
Subject: Re: [PATCH] Performance Improvement in CRC16 Calculations.
From:   Joe Perches <joe@perches.com>
To:     Jeff Lien <jeff.lien@wdc.com>, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org
Cc:     herbert@gondor.apana.org.au, tim.c.chen@linux.intel.com,
        martin.petersen@oracle.com, david.darrington@wdc.com,
        jeff.furlong@wdc.com
Date:   Fri, 10 Aug 2018 12:23:06 -0700
In-Reply-To: <1533928331-21303-1-git-send-email-jeff.lien@wdc.com>
References: <1533928331-21303-1-git-send-email-jeff.lien@wdc.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-08-10 at 14:12 -0500, Jeff Lien wrote:
> This patch provides a performance improvement for the CRC16 calculations done in read/write
> workloads using the T10 Type 1/2/3 guard field.  For example, today with sequential write
> workloads (one thread/CPU of IO) we consume 100% of the CPU because of the CRC16 computation
> bottleneck.  Today's block devices are considerably faster, but the CRC16 calculation prevents
> folks from utilizing the throughput of such devices.  To speed up this calculation and expose
> the block device throughput, we slice the old single byte for loop into a 16 byte for loop,
> with a larger CRC table to match.  The result has shown 5x performance improvements on various
> big endian and little endian systems running the 4.18.0 kernel version.

Thanks.

This seems a sensible tradeoff for the 4k text size increase.

> diff --git a/crypto/crct10dif_common.c b/crypto/crct10dif_common.c

[]

trivia:

> +static const __u16 t10_dif_crc_table[16][256] = {
> +	{
> +	0x0000u, 0x8BB7u, 0x9CD9u, 0x176Eu, 0xB205u, 0x39B2u, 0x2EDCu, 0xA56Bu,

All the 'u's are unnecessary visual noise.

