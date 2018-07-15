Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FC0CECDFB1
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 14:30:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA7922124D
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 14:30:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA7922124D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbeGOOx6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 10:53:58 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:50410 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726274AbeGOOx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 10:53:58 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fei2t-0003Bw-M7; Sun, 15 Jul 2018 14:30:43 +0000
Date:   Sun, 15 Jul 2018 15:30:43 +0100
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Anatoly Trosinenko <anatoly.trosinenko@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: FAT: Operating on broken FAT FS causes the write syscall to
 return negative number not equal to -1
Message-ID: <20180715143043.GM30522@ZenIV.linux.org.uk>
References: <CAE5jQCe4nX8m1f5jPL57GeU32CftNv+NvgNmZxufH85nun1o7w@mail.gmail.com>
 <878t6c7f8p.fsf@mail.parknet.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878t6c7f8p.fsf@mail.parknet.co.jp>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 15, 2018 at 11:20:06PM +0900, OGAWA Hirofumi wrote:
> +static inline bool fat_valid_entry(struct msdos_sb_info *sbi, int entry)
> +{
> +	if (entry < FAT_START_ENT || sbi->max_cluster <= entry)
> +		return false;
> +	return true;
> +}

Pet peeve: if (...) return false; return true; instead of return !....;

In this case,
	return entry >= FAT_START_ENT && entry < sb->max_cluster;
