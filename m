Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36365ECDFB8
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 17:53:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3ECA2086A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 17:53:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="AOkQOaSm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3ECA2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730216AbeGVSuk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 14:50:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:57256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729826AbeGVSuk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 14:50:40 -0400
Received: from mail-wm0-f45.google.com (mail-wm0-f45.google.com [74.125.82.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2FC462086A
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jul 2018 17:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532281992;
        bh=lQuGGICul5bHm8yu2mgw2leTeBi55unFv/zUyBSBNlc=;
        h=From:Date:Subject:To:From;
        b=AOkQOaSmwNkbwfVofQya2ypwhFv016JnudPiBVr1GlhPY3yXOWyEAeXQTDJ7sj59R
         Eko3cv6Ch0iUglDCH+sMCnXl+4CGV3zt9Er82+5FpM65sZ0NeO2iVimGmx0hYK1Z2t
         ZQCLsyaGRStWVOtaioYJHufrddHYlB0lLzTXhLYA=
Received: by mail-wm0-f45.google.com with SMTP id s9-v6so13774421wmh.3
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jul 2018 10:53:12 -0700 (PDT)
X-Gm-Message-State: AOUpUlHlQDlcZbeJKcEOOVJs//Z2aWw9Hg8cwoAO5TiTDQSpy8wWLUVG
        efe9Ceo1H2jY/0rFQ7mDpFZPnu1HXvTmeo6IAaHkaw==
X-Google-Smtp-Source: AAOMgpduR73DPVt/vNVkthRIKoqe7IGVd4B3k4lgzXlSpumCTYu1WlVzsYrLdftFPWdy/xbbJbxSdQ0TA5NxIRK0TMQ=
X-Received: by 2002:a1c:ef0f:: with SMTP id n15-v6mr5461897wmh.116.1532281990712;
 Sun, 22 Jul 2018 10:53:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:d548:0:0:0:0:0 with HTTP; Sun, 22 Jul 2018 10:52:50
 -0700 (PDT)
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sun, 22 Jul 2018 10:52:50 -0700
X-Gmail-Original-Message-ID: <CALCETrW4F33LWWA=cWYZ2N9=veCmVfjhCCLnSv2qh=32fOAf-w@mail.gmail.com>
Message-ID: <CALCETrW4F33LWWA=cWYZ2N9=veCmVfjhCCLnSv2qh=32fOAf-w@mail.gmail.com>
Subject: Making KASAN compatible with VMAP_STACK
To:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all-

It would be really nice to make KASAN compatible with VMAP_STACK.
Both are valuable memory debugging features, and the fact that you
can't use both is disappointing.

As far as I know, there are only two problems:

1. The KASAN shadow population code is a mess, and adding *anything*
to the KASAN shadow requires magical, fragile incantations.  It should
be cleaned up so that ranges can be easily populated without needing
to very carefully align things, call helpers in the right order, etc.
The core KASAN code should figure it out by itself.

2. The vmalloc area is potentially extremely large.  It might be
necessary to have a way to *depopulate* shadow space when stacks get
freed or, more generally, when vmap areas are freed.  Ideally KASAN
would integrate with the core vmalloc/vmap code and it would Just Work
(tm).  And, as a bonus, we'd get proper KASAN protection of vmalloced
memory.

Any volunteers to fix this?

--Andy
