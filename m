Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AB58C6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 19:36:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4460249BE
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 19:36:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4460249BE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752557AbeGATgA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 15:36:00 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:33598 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752424AbeGATf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 15:35:59 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 54DAC6093333;
        Sun,  1 Jul 2018 21:35:58 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id GFQiw1_grtna; Sun,  1 Jul 2018 21:35:58 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 11DCF6093334;
        Sun,  1 Jul 2018 21:35:58 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id FdaRdrYuih0s; Sun,  1 Jul 2018 21:35:58 +0200 (CEST)
Received: from blindfold.localnet (213-47-184-186.cable.dynamic.surfer.at [213.47.184.186])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id E37386093322;
        Sun,  1 Jul 2018 21:35:57 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     Quentin Schulz <quentin.schulz@bootlin.com>
Cc:     dedekind1@gmail.com, dwmw2@infradead.org,
        computersforpeace@gmail.com, boris.brezillon@bootlin.com,
        marek.vasut@gmail.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com
Subject: Re: [PATCH v3 2/2] ubi: expose the volume CRC check skip flag
Date:   Sun, 01 Jul 2018 21:35:57 +0200
Message-ID: <382648641.QZzOm4Mo72@blindfold>
In-Reply-To: <0ace6202bddb495ae0e632ae2fd0346f99fcdab4.1530169759.git-series.quentin.schulz@bootlin.com>
References: <cover.6d66955e7c1848c8255870deb42eddb69bd276f3.1530169759.git-series.quentin.schulz@bootlin.com> <0ace6202bddb495ae0e632ae2fd0346f99fcdab4.1530169759.git-series.quentin.schulz@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quentin,

Am Donnerstag, 28. Juni 2018, 09:40:53 CEST schrieb Quentin Schulz:
> Now that we have the logic for skipping CRC check for static UBI volumes
> in the core, let's expose it to users.
> 
> This makes use of a padding byte in the volume description data
> structure as a flag. This flag only tell for now whether we should skip
> the CRC check of a volume.
> 
> This checks the UBI volume for which we are trying to skip the CRC check
> is static.
> 
> Suggested-by: Boris Brezillon <boris.brezillon@bootlin.com>
> Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>
> Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>
> ---
>  drivers/mtd/ubi/cdev.c      |  4 ++++
>  drivers/mtd/ubi/vmt.c       |  3 +++
>  include/uapi/mtd/ubi-user.h | 16 ++++++++++++++--
>  3 files changed, 21 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mtd/ubi/cdev.c b/drivers/mtd/ubi/cdev.c
> index 45c3296..3eea1df 100644
> --- a/drivers/mtd/ubi/cdev.c
> +++ b/drivers/mtd/ubi/cdev.c
> @@ -622,6 +622,10 @@ static int verify_mkvol_req(const struct ubi_device *ubi,
>  	    req->vol_type != UBI_STATIC_VOLUME)
>  		goto bad;
>  
> +	if (req->flags & UBI_VOL_SKIP_CRC_CHECK_FLG &&
> +	    req->vol_type != UBI_STATIC_VOLUME)
> +		goto bad;

We should also reject unknown flags here.

Thanks,
//richard
