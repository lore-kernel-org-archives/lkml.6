Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 156EDC43144
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 13:12:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C497524EF7
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 13:12:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C497524EF7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751982AbeFXNMg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 09:12:36 -0400
Received: from mail.bootlin.com ([62.4.15.54]:52883 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751637AbeFXNMe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 09:12:34 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id DDC3920734; Sun, 24 Jun 2018 15:12:32 +0200 (CEST)
Received: from bbrezillon (unknown [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id AB6C8206A0;
        Sun, 24 Jun 2018 15:12:32 +0200 (CEST)
Date:   Sun, 24 Jun 2018 15:12:32 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Richard Weinberger <richard@nod.at>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/14] ubi: uapi: Add mode selector to attach request
Message-ID: <20180624151232.4f175fc9@bbrezillon>
In-Reply-To: <20180613212344.11608-13-richard@nod.at>
References: <20180613212344.11608-1-richard@nod.at>
        <20180613212344.11608-13-richard@nod.at>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Jun 2018 23:23:42 +0200
Richard Weinberger <richard@nod.at> wrote:

> This allows userspace, ubiattach, to force a full scan.
> 
> Signed-off-by: Richard Weinberger <richard@nod.at>
> ---
>  include/uapi/mtd/ubi-user.h | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/include/uapi/mtd/ubi-user.h b/include/uapi/mtd/ubi-user.h
> index 5b04a494d139..cc0e54cfa7f9 100644
> --- a/include/uapi/mtd/ubi-user.h
> +++ b/include/uapi/mtd/ubi-user.h
> @@ -235,12 +235,19 @@ enum {
>  	UBI_VOL_PROP_DIRECT_WRITE = 1,
>  };
>  
> +enum {
> +	UBI_ATTACH_MODE_AUTO = 0x0,
> +	UBI_ATTACH_MODE_SCAN = 0x1,
> +	UBI_ATTACH_MODE_MAX = UBI_ATTACH_MODE_SCAN,
> +};
> +
>  /**
>   * struct ubi_attach_req - attach MTD device request.
>   * @ubi_num: UBI device number to create
>   * @mtd_num: MTD device number to attach
>   * @vid_hdr_offset: VID header offset (use defaults if %0)
>   * @max_beb_per1024: maximum expected number of bad PEB per 1024 PEBs
> + * @attach_mode: selects the attach mode
>   * @padding: reserved for future, not used, has to be zeroed
>   *
>   * This data structure is used to specify MTD device UBI has to attach and the
> @@ -276,13 +283,18 @@ enum {
>   * eraseblocks for new bad eraseblocks, but attempts to use available
>   * eraseblocks (if any). The accepted range is 0-768. If 0 is given, the
>   * default kernel value of %CONFIG_MTD_UBI_BEB_LIMIT will be used.
> + *
> + * @attach_mode is %UBI_ATTACH_MODE_AUTO by default, and let's the UBI
> + * implementation decide how to attach. If %UBI_ATTACH_MODE_SCAN is selected
> + * a full scan is forced.
>   */
>  struct ubi_attach_req {
>  	__s32 ubi_num;
>  	__s32 mtd_num;
>  	__s32 vid_hdr_offset;
>  	__s16 max_beb_per1024;
> -	__s8 padding[10];
> +	__s8 attach_mode;
> +	__s8 padding[9];
>  };

Looks like the force full-scan is just a flag, and we might need other
flags to encode things that are not related to attach mode, so how
about creating an __u16 flags field here and defining

#define UBI_ATTACH_FLG_FORCE_FULL_SCAN		0x1

?
