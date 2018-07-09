Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3085C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 14:24:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57D7220882
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 14:24:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="g0v35urw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57D7220882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933023AbeGIOYA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 10:24:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:43362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932574AbeGIOX7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 10:23:59 -0400
Received: from [192.168.0.101] (unknown [49.77.238.31])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E41CD2087F;
        Mon,  9 Jul 2018 14:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531146238;
        bh=a4Woqj6AeRtHWtrpdp7eeEOFl6ryPeAH492yQ6o27y0=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=g0v35urwGX4Fn7RnvBvh6ctm2JZ+HWLvb3c/FKjr1VcopeXpcnF8fB6rqG9WLtiCT
         zfgkc283E2IjFmG2Bl/S/DHZeTCcCIr5u054qVJsV6t0N3D3ksqKgIoN9yFHclwP02
         pYsyL1I6IVHWNwJe5PnptsSytVQcJqeb7+Ka4J2Y=
Subject: Re: [f2fs-dev] [PATCH 1/4] f2fs: flush journal nat entries for
 nat_bits during unmount
To:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20180706210903.77887-1-jaegeuk@kernel.org>
From:   Chao Yu <chao@kernel.org>
Message-ID: <ee638123-4114-badc-7d82-989e480ed45e@kernel.org>
Date:   Mon, 9 Jul 2018 22:23:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.0
MIME-Version: 1.0
In-Reply-To: <20180706210903.77887-1-jaegeuk@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/7/7 5:09, Jaegeuk Kim wrote:
> Let's flush journal nat entries for speed up in the next run.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/node.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> index 29237aeca041..0f076fb0d828 100644
> --- a/fs/f2fs/node.c
> +++ b/fs/f2fs/node.c
> @@ -2613,6 +2613,13 @@ void f2fs_flush_nat_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc)
>  	nid_t set_idx = 0;
>  	LIST_HEAD(sets);
>  
> +	/* during unmount, let's flush nat_bits before checking dirty_nat_cnt */
> +	if (enabled_nat_bits(sbi, cpc)) {
> +		down_write(&nm_i->nat_tree_lock);
> +		remove_nats_in_journal(sbi);
> +		up_write(&nm_i->nat_tree_lock);
> +	}

The case will cover that nm_i->dirty_nat_cnt is zero and there is cached nats in
journal?

So enabled_nat_bits() below should be removed?

	if (enabled_nat_bits(sbi, cpc) ||
		!__has_cursum_space(journal, nm_i->dirty_nat_cnt, NAT_JOURNAL))
		remove_nats_in_journal(sbi);

Thanks,

> +
>  	if (!nm_i->dirty_nat_cnt)
>  		return;
>  
> 
