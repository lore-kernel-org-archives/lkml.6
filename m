Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BD58C677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 18:50:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A03A32075C
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 18:50:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A03A32075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mail.parknet.co.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729727AbeJLCS5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 22:18:57 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:47992 "EHLO
        mail.parknet.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727944AbeJLCS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 22:18:57 -0400
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
        by mail.parknet.co.jp (Postfix) with ESMTPSA id BCF0312B6A4;
        Fri, 12 Oct 2018 03:50:28 +0900 (JST)
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
        by ibmpc.myhome.or.jp (8.15.2/8.15.2/Debian-12) with ESMTPS id w9BIoR4J008860
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 Oct 2018 03:50:28 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
        by devron.myhome.or.jp (8.15.2/8.15.2/Debian-12) with ESMTPS id w9BIoQJY015523
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 Oct 2018 03:50:26 +0900
Received: (from hirofumi@localhost)
        by devron.myhome.or.jp (8.15.2/8.15.2/Submit) id w9BIoQXT015522;
        Fri, 12 Oct 2018 03:50:26 +0900
From:   OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Khazhismel Kumykov <khazhy@google.com>
Subject: Re: [PATCH] fs/fat: add cond_resched to fat_count_free_clusters
References: <20181010172623.57033-1-khazhy@google.com>
Date:   Fri, 12 Oct 2018 03:50:26 +0900
In-Reply-To: <20181010172623.57033-1-khazhy@google.com> (Khazhismel Kumykov's
        message of "Wed, 10 Oct 2018 10:26:23 -0700")
Message-ID: <875zy85nd9.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Khazhismel Kumykov <khazhy@google.com> writes:

> On non-preempt kernels this loop can take a long time (more than 50
> ticks) processing through entries.
>
> Signed-off-by: Khazhismel Kumykov <khazhy@google.com>
> ---
>  fs/fat/fatent.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/fs/fat/fatent.c b/fs/fat/fatent.c
> index defc2168de91..f58c0cacc531 100644
> --- a/fs/fat/fatent.c
> +++ b/fs/fat/fatent.c
> @@ -682,6 +682,7 @@ int fat_count_free_clusters(struct super_block *sb)
>  			if (ops->ent_get(&fatent) == FAT_ENT_FREE)
>  				free++;
>  		} while (fat_ent_next(sbi, &fatent));
> +		cond_resched();
>  	}
>  	sbi->free_clusters = free;
>  	sbi->free_clus_valid = 1;

Acked-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

Thanks, looks good. 
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
