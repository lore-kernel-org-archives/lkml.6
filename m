Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A544DC46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 09:50:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 673CF21778
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 09:50:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 673CF21778
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729020AbeHMMcU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 08:32:20 -0400
Received: from smtprelay0146.hostedemail.com ([216.40.44.146]:35781 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728610AbeHMMcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 08:32:20 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 7DD60182CED34;
        Mon, 13 Aug 2018 09:50:49 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: farm72_7b797eca9b304
X-Filterd-Recvd-Size: 1649
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf10.hostedemail.com (Postfix) with ESMTPA;
        Mon, 13 Aug 2018 09:50:48 +0000 (UTC)
Message-ID: <a5f29d4ed6098373fb3fe7a0194687d78d3592f7.camel@perches.com>
Subject: Re: [PATCH] Revert "f2fs: use printk_ratelimited for f2fs_msg"
From:   Joe Perches <joe@perches.com>
To:     Chao Yu <yuchao0@huawei.com>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, chao@kernel.org
Date:   Mon, 13 Aug 2018 02:50:47 -0700
In-Reply-To: <20180813062845.25394-1-yuchao0@huawei.com>
References: <20180813062845.25394-1-yuchao0@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-08-13 at 14:28 +0800, Chao Yu wrote:
> Don't limit printing log, so that we will not miss any key messages.
> 
> This reverts commit a36c106dffb616250117efb1cab271c19a8f94ff.
[]
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
[]
> @@ -209,7 +209,7 @@ void f2fs_msg(struct super_block *sb, const char *level, const char *fmt, ...)
>  	va_start(args, fmt);
>  	vaf.fmt = fmt;
>  	vaf.va = &args;
> -	printk_ratelimited("%sF2FS-fs (%s): %pV\n", level, sb->s_id, &vaf);
> +	printk("%sF2FS-fs (%s): %pV\n", level, sb->s_id, &vaf);
>  	va_end(args);
>  }

If there was value in ratelimiting these messages at all,
perhaps there is value in using a specific ratelimit_state
other than

	static DEFINE_RATELIMIT_STATE(_rs,				\
				      DEFAULT_RATELIMIT_INTERVAL,	\
				      DEFAULT_RATELIMIT_BURST);		\



