Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E113C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 12:42:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E0562084A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 12:42:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E0562084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbeLKMmm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 07:42:42 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:45666 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbeLKMmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 07:42:42 -0500
Received: by mail-qk1-f196.google.com with SMTP id y78so8442633qka.12
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 04:42:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gD8f9A+yOrKSkam/K81qSn+sZ/zk2aeP124oDPQh7j8=;
        b=f+tEblF8n7ijq+Wjf++xHtwZkoaM93VLcaBHLMqd9Wm/BJdmPmOEx/oocjEtzN59Si
         1vIrjJWmRrskbDU3JYLpgJ6hazlxZuPXrqIVSenvySJTjl0FWiMN8yhU9FEn8/6aRKfT
         c2TmU/oL+6F8LwU6vGiQuJ/tfPZpWCYFGTGeRoP4O8sKornxfM5uTkelCTYS9li/3T+A
         GJXgZtHknMJEpM0MZ6dRdafJe5WD1fqbHSvzpQt5szkwBYL+KMGYmtlAJZ8ee/b/W8LY
         r8qJ6Na0qFobYhVajP4s+5wP2uvddm/LnnMRtprgT5kck8qdY8IDnAkLt1O6TtyaS/ga
         a/8g==
X-Gm-Message-State: AA+aEWbyOWnVrYlBt8ZsmsXIURuFvCMjb4sz/LdJrJNCU54u0T8reoWf
        dx5l2UempX1r+niBo+4NAhIXnuv7g2Ci7LtG9wY=
X-Google-Smtp-Source: AFSGD/Vd1BIXINShufesnfmxbgu3Uq+GOP9+W8KyfUFd1gvLvE01bT4ekpquPDaZ24IdORmlr0adyRros9sOjzDWghA=
X-Received: by 2002:a37:324a:: with SMTP id y71mr14519413qky.291.1544532161273;
 Tue, 11 Dec 2018 04:42:41 -0800 (PST)
MIME-Version: 1.0
References: <721E7B42-2D55-4866-9C1A-3E8D64F33F9C@gmx.us> <20181207223449.38808-1-cai@lca.pw>
In-Reply-To: <20181207223449.38808-1-cai@lca.pw>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 11 Dec 2018 13:42:24 +0100
Message-ID: <CAK8P3a20kRDrkS1YFLp6cYeKcUoC9s+O_tnYNbKEMWGukia1Tg@mail.gmail.com>
Subject: Re: [PATCH] arm64: increase stack size for KASAN_EXTRA
To:     cai@lca.pw
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 7, 2018 at 11:35 PM Qian Cai <cai@lca.pw> wrote:
>
> If the kernel is configured with KASAN_EXTRA, the stack size is
> increasted significantly due to enable this option will set
> -fstack-reuse to "none" in GCC [1]. As the results, it could trigger
> stack overrun quite often with 32k stack size compiled using GCC 8. For
> example, this reproducer

>
> size
> 7536 shrink_inactive_list
> 7440 shrink_page_list
> 6560 fscache_stats_show
> 3920 jbd2_journal_commit_transaction
> 3216 try_to_unmap_one
> 3072 migrate_page_move_mapping
> 3584 migrate_misplaced_transhuge_page
> 3920 ip_vs_lblcr_schedule
> 4304 lpfc_nvme_info_show
> 3888 lpfc_debugfs_nvmestat_data.constprop
>
> There are other 49 functions are over 2k in size while compiling kernel
> with "-Wframe-larger-than=" on this machine. Hence, it is too much work
> to change Makefiles for each object to compile without
> -fsanitize-address-use-after-scope individually.
>
> [1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=81715#c23

Could you clarify: are the numbers you see with or without the bugfix
from that bugzilla?

       Arnd
