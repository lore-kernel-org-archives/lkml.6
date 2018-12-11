Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0638C6783B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 21:53:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0E7120672
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 21:53:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0E7120672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbeLKVxV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 16:53:21 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:44884 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726209AbeLKVxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 16:53:21 -0500
Received: by mail-qt1-f194.google.com with SMTP id n32so18257474qte.11
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 13:53:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4iNAYTw+5oqFyyzTQHdI60zXkOGgUyhw+emjW/uoGSk=;
        b=WCj9K4ar4Ccjc/vik2pIZV4ZsmA7bbKnP8NGTFHjbAtFgL+kXrAm8SKzwvh9GiilTc
         QsgntNakhCbNoPruNbUBCtKWHsm7VsQ58ho7LOhQtYTCSO8ouBLHVIpBClnPUQ/rDdnw
         2Uq2UWJYJ1K3gUKuZ4ruXgweHZtaIHnJVFtLOeJZ8Y6OaoXGOJ9p4AqqVOk1katN/n6F
         ag33D3PtrLu829KcmrULcV2FQSfx7h+t0X17y99+N5HxCV/zsntRTlwE/O/nFvS91s2o
         mYgm3AmsYQnmtdhhe7F1vdpct76MgxVEY0/ZZ3/GG+z+XeTx1BkuifQwRXeXTAF/sPtv
         fB3w==
X-Gm-Message-State: AA+aEWZjcBRZcUo4yZ8Nx3YrhMjv77YhEFSEXIN905+kffO+8TUamfvz
        9dT2TOW4ktm93nmcF7btc27c+qRuqVK9+oRWO1o=
X-Google-Smtp-Source: AFSGD/XACUEsaYE/5CSRduyEkcN+PnEm6s3o040VE8t092qXBYgTa+EMxTvdzcPpO+9cJ+KhgJLkVs7PRdH3XWBcPsU=
X-Received: by 2002:a0c:f50c:: with SMTP id j12mr16734587qvm.149.1544565200047;
 Tue, 11 Dec 2018 13:53:20 -0800 (PST)
MIME-Version: 1.0
References: <20181211200526.3868586-1-arnd@arndb.de> <20181211201909.GA6478@redhat.com>
 <alpine.DEB.2.21.1812111310320.87855@chino.kir.corp.google.com>
 <20181211213636.GB6478@redhat.com> <alpine.DEB.2.21.1812111341280.97190@chino.kir.corp.google.com>
In-Reply-To: <alpine.DEB.2.21.1812111341280.97190@chino.kir.corp.google.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 11 Dec 2018 22:53:03 +0100
Message-ID: <CAK8P3a1yn7RAp7Q29dx5Rcb0mCoDpcHPzxSGqKHdgfJd+=iiNw@mail.gmail.com>
Subject: Re: [PATCH] mm/mmu_notifier: fix mmu_notifier_range_init warning
To:     David Rientjes <rientjes@google.com>
Cc:     =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 10:43 PM David Rientjes <rientjes@google.com> wrote:
>
> On Tue, 11 Dec 2018, Jerome Glisse wrote:

>
> Hmm, strange that Arnd's build failure is only reporting about an unused
> variable instead of MMU_NOTIFY_CLEAR being undefined :/
>
> I think this should be done so that anybody using
> mmu_notifier_range_init() doesn't need to worry about the implications of
> *any* unused formal parameter as a result of how the #define is formed:

Your patch below is more or less what I tried at first, and that resulted
in another build failure for

mm/hugetlb.c:   mmu_notifier_range_init(&range, mm, start, end,
MMU_NOTIFY_CLEAR);
mm/hugetlb.c-   adjust_range_if_pmd_sharing_possible(vma,
&range.start, &range.end);

where range.end refers to a nonexisting member of range.

          Arnd
