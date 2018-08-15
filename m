Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16327C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 22:43:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 152852156F
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 22:43:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 152852156F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731053AbeHPBhr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 21:37:47 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:39156 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727075AbeHPBhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 21:37:47 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.9.92])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 1840540B;
        Wed, 15 Aug 2018 22:43:35 +0000 (UTC)
Date:   Wed, 15 Aug 2018 15:43:34 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Cc:     linux-mm@kvack.org, Michal Hocko <mhocko@kernel.org>,
        xishi.qiuxishi@alibaba-inc.com, zy.zhengyi@alibaba-inc.com,
        linux-kernel@vger.kernel.org,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: [PATCH v2 0/2] mm: soft-offline: fix race against page
 allocation
Message-Id: <20180815154334.f3eecd1029a153421631413a@linux-foundation.org>
In-Reply-To: <1531805552-19547-1-git-send-email-n-horiguchi@ah.jp.nec.com>
References: <1531805552-19547-1-git-send-email-n-horiguchi@ah.jp.nec.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Jul 2018 14:32:30 +0900 Naoya Horiguchi <n-horiguchi@ah.jp.nec.com> wrote:

> I've updated the patchset based on feedbacks:
> 
> - updated comments (from Andrew),
> - moved calling set_hwpoison_free_buddy_page() from mm/migrate.c to mm/memory-failure.c,
>   which is necessary to check the return code of set_hwpoison_free_buddy_page(),
> - lkp bot reported a build error when only 1/2 is applied.
> 
>   >    mm/memory-failure.c: In function 'soft_offline_huge_page':
>   > >> mm/memory-failure.c:1610:8: error: implicit declaration of function
>   > 'set_hwpoison_free_buddy_page'; did you mean 'is_free_buddy_page'?
>   > [-Werror=implicit-function-declaration]
>   >        if (set_hwpoison_free_buddy_page(page))
>   >            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   >            is_free_buddy_page
>   >    cc1: some warnings being treated as errors
> 
>   set_hwpoison_free_buddy_page() is defined in 2/2, so we can't use it
>   in 1/2. Simply doing s/set_hwpoison_free_buddy_page/!TestSetPageHWPoison/
>   will fix this.
> 
> v1: https://lkml.org/lkml/2018/7/12/968
> 

Quite a bit of discussion on these two, but no actual acks or
review-by's?
