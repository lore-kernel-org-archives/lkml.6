Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B814AC5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 17:18:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EA9D20879
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 17:18:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="svMzx1Nh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EA9D20879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lca.pw
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727194AbeLKRSc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 12:18:32 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:44158 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726776AbeLKRSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 12:18:31 -0500
Received: by mail-qt1-f196.google.com with SMTP id n32so17233669qte.11
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 09:18:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h0hsgksLXZZZ+Za4ufYtYeUu6sbcdg1JL7mSLK44kUY=;
        b=svMzx1NhUA9/VSxg+zlHTLuVM1Ssqd+JJ3soT1feYkYRvsGy51GQxFr+fTh2/vEanU
         Vh3X3biNlEDE0T3+3TqTxCgKWoA3IBZaeQKhaH7Y4MRY/dYP95rmNdkMlF6s9VZvL2Up
         i05Lg8dUO8w4zpxnyWrMDxNbQxQs8WV6Mw6r+CojIOzDnUeMhFgYDGmRX+iqCYmtkHEj
         v0cMyZnE6QlWqtyOkrzmHFvdtkfi1qvAgUmuU2uk4wiy8r1+TMG3iZQEJRZZ5oyRVK5n
         TSA9+yGqA0UP3yA786ErRqWFNIBnhwPp+C9sSL8YxAvulCbOfLRUX9Tx9pppJ72twWzP
         Mh7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h0hsgksLXZZZ+Za4ufYtYeUu6sbcdg1JL7mSLK44kUY=;
        b=r265q33Lj3Lq2X3NtsCWPDkcHs5prWbNABuCHsRTRRYOJ3zIFqJJG38L4crKXrIwh3
         LdLKfXtFcHyAUZqHN03EQumS4DDNK6IL7IklpFrBII+wQuEBwxr7CLLt2DyMRS2+eIcg
         heu1FphQu488ic+d8RClBgVJuf8njVplpUzmRgOeMkzI2CFxKhpeWKGkc6FsfGoLUDLu
         eOZx/voG5nnVPR2AeGSQNE4Ghw3NtnupwxGVYHBCORRT44AqkjGcjEoLRnaehCWoxAob
         0bN8xdtvsNV4zteVINFLQ6y7n0sPjtWEjqQpeWtiSsbZ4ev42Wh91oZXYf6BXUOpNLRl
         MVcA==
X-Gm-Message-State: AA+aEWZfEgYcF7SnyVfKvysGW7107mM2GZJy8g5VFJkGCZlT7/raqo4R
        vcJaB0jeve7ftaKXX3KnzjbLXA==
X-Google-Smtp-Source: AFSGD/VjSceHo1CAZ9W5GfynGWR67gmlWIo3i6anGONMRu4EZeLaCyiYEothGKkUaRykwx+4aL7APw==
X-Received: by 2002:ac8:16d8:: with SMTP id y24mr17243898qtk.253.1544548709912;
        Tue, 11 Dec 2018 09:18:29 -0800 (PST)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id e89sm8298135qtb.78.2018.12.11.09.18.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 09:18:29 -0800 (PST)
Message-ID: <1544548707.18411.3.camel@lca.pw>
Subject: Re: [PATCH] arm64: increase stack size for KASAN_EXTRA
From:   Qian Cai <cai@lca.pw>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Tue, 11 Dec 2018 12:18:27 -0500
In-Reply-To: <CAK8P3a20kRDrkS1YFLp6cYeKcUoC9s+O_tnYNbKEMWGukia1Tg@mail.gmail.com>
References: <721E7B42-2D55-4866-9C1A-3E8D64F33F9C@gmx.us>
         <20181207223449.38808-1-cai@lca.pw>
         <CAK8P3a20kRDrkS1YFLp6cYeKcUoC9s+O_tnYNbKEMWGukia1Tg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-12-11 at 13:42 +0100, Arnd Bergmann wrote:
> On Fri, Dec 7, 2018 at 11:35 PM Qian Cai <cai@lca.pw> wrote:
> > 
> > If the kernel is configured with KASAN_EXTRA, the stack size is
> > increasted significantly due to enable this option will set
> > -fstack-reuse to "none" in GCC [1]. As the results, it could trigger
> > stack overrun quite often with 32k stack size compiled using GCC 8. For
> > example, this reproducer
> > 
> > size
> > 7536 shrink_inactive_list
> > 7440 shrink_page_list
> > 6560 fscache_stats_show
> > 3920 jbd2_journal_commit_transaction
> > 3216 try_to_unmap_one
> > 3072 migrate_page_move_mapping
> > 3584 migrate_misplaced_transhuge_page
> > 3920 ip_vs_lblcr_schedule
> > 4304 lpfc_nvme_info_show
> > 3888 lpfc_debugfs_nvmestat_data.constprop
> > 
> > There are other 49 functions are over 2k in size while compiling kernel
> > with "-Wframe-larger-than=" on this machine. Hence, it is too much work
> > to change Makefiles for each object to compile without
> > -fsanitize-address-use-after-scope individually.
> > 
> > [1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=81715#c23
> 
> Could you clarify: are the numbers you see with or without the bugfix
> from that bugzilla?
> 

The numbers were from GCC8 which does NOT contain this patch [1].

GCC9 is awesome which reduced the numbers in half even for KASAN_EXTRA. Only
thing is that GCC9 has not been officially released yet, so it is a bit
inconvenient for users need to compile the compiler by themselves first.

I am fine either way to drop this patch or keep it until GCC9 is GA.

[1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=81715#c35
