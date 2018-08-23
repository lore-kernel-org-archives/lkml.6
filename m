Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 024B6C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 11:14:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B242420841
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 11:13:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B242420841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731166AbeHWOnJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 10:43:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:58842 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726360AbeHWOnJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 10:43:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E1A08AE69;
        Thu, 23 Aug 2018 11:13:55 +0000 (UTC)
Date:   Thu, 23 Aug 2018 13:13:55 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Weikang Shi <swkhack@gmail.com>
Cc:     akpm@linux-foundation.org, alexander.h.duyck@intel.com,
        vbabka@suse.cz, mgorman@suse.de, l.stach@pengutronix.de,
        vdavydov.dev@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, my_email@gmail.com
Subject: Re: [PATCH] fs: fix local var type
Message-ID: <20180823111355.GD29735@dhcp22.suse.cz>
References: <1535014754-31918-1-git-send-email-swkhack@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1535014754-31918-1-git-send-email-swkhack@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 23-08-18 01:59:14, Weikang Shi wrote:
> In the seq_hex_dump function,the remaining variable is int, but it receive a type of size_t argument.
> So I change the type of remaining

The changelog should explain _why_ we need this fix. Is any of the code
path overflowing?

Besides that I do not think this fix is complete. What about linelen?

Why do we even need len to be size_t? Why it cannot be int as well. I
strongly doubt we need more than 32b here.
 
> Signed-off-by: Weikang Shi <swkhack@gmail.com>
> ---
>  fs/seq_file.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/seq_file.c b/fs/seq_file.c
> index 1dea7a8..d0e8bec 100644
> --- a/fs/seq_file.c
> +++ b/fs/seq_file.c
> @@ -847,7 +847,8 @@ void seq_hex_dump(struct seq_file *m, const char *prefix_str, int prefix_type,
>  		  bool ascii)
>  {
>  	const u8 *ptr = buf;
> -	int i, linelen, remaining = len;
> +	int i, linelen;
> +	size_t remaining = len;
>  	char *buffer;
>  	size_t size;
>  	int ret;
> -- 
> 2.7.4
> 

-- 
Michal Hocko
SUSE Labs
