Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 926FAECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 21:55:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BD8F2075A
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 21:55:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cu5A1lB0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BD8F2075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730384AbeGRWfT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 18:35:19 -0400
Received: from mail-wr1-f50.google.com ([209.85.221.50]:43657 "EHLO
        mail-wr1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726834AbeGRWfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 18:35:19 -0400
Received: by mail-wr1-f50.google.com with SMTP id b15-v6so6059134wrv.10
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 14:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=oIqlx1/GJtz8S2AInm4JCTIfttXb+fPy4J+H4TnFMUs=;
        b=cu5A1lB0ecv+QhPmuHo7hgxqODKkIWCDF9SFe8aih8hr0agFSkqU6aKtq/RpMfONjs
         QgEVw7rJuvqdaAf4BzW1Zsr4uzBL87mKoLjF3FBOPAN+3OhBYEI5W/iAWCTJmlAM6VE4
         UVOjzX4o0NZ0ZebrtV8MPq/pQ+e7SxhcsPFmxlwUtNXpp3JA9k+woU8XXpmFe598MHvS
         rcgIgy5pFaGZ3aoM82bSrZpFEQZZUc4HqVaF/3IoRbamla21ljnKQRizSc5I1I/zYgys
         YkMMwZLRBQQ/mqD2t7EXS1uj103HCh8wlK8dKc9ZC2HjJejkkqzvCW9Q8j68cR8RZQcw
         3qkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=oIqlx1/GJtz8S2AInm4JCTIfttXb+fPy4J+H4TnFMUs=;
        b=jt5pR/Ed672S6dicNBU+HbwBczeqnvffOEnPZnD4Mjj1zSHadDIUf/B3VBf4wFEdsX
         spYVaASK9MR/ToBWdvkG1awnr4WcG4THmNheeprvKepIaLHfWmAkrPgidekjac8E/OKR
         ur6SwaIPAhZ2YnzXvJHaqUWGARDbNiCOSq4/zB9EnHzE0a2gUkPaOHfYAttuJ+hfPQsC
         4hlyvC1QbQyz9bdjyYdArzCu/oUEhxv/+xSCbVGqeU67kA1EDoSzPR8NKSLxta3I+vjf
         4XryaM55mruKj8XPKkdwnf5kjT0hxHPWA87AtNXdpziE/MxzlsmQiD8N0u8LODaY2VRE
         RUug==
X-Gm-Message-State: AOUpUlF08BSJIy/aiv60irQCmpayQu+gVGgbm9G8RC9w1CmsVm86kjLi
        4wjAI7qyMhVvDoUIwmQDNX4PPAdsbO71gmwaDwduMKlq
X-Google-Smtp-Source: AAOMgpeI00HJbQS2rAqqgp5jlE1pYULZMUO3MWIK5QPUPwiyDCwgV7JxvihhMAWaD69VK6n94TOmSX5mTXA9V3yzVAY=
X-Received: by 2002:adf:e190:: with SMTP id k16-v6mr5714197wri.36.1531950925650;
 Wed, 18 Jul 2018 14:55:25 -0700 (PDT)
MIME-Version: 1.0
From:   Stephane Eranian <eranian@google.com>
Date:   Wed, 18 Jul 2018 14:55:14 -0700
Message-ID: <CABPqkBT0P=GKNb6ypjaPxe4dEwShHk37mdrX0RtodMm44gaE+Q@mail.gmail.com>
Subject: [RFC] perf annotate: option to report global percentage
To:     Jiri Olsa <jolsa@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

As far as I know, once you go into annotate mode, via perf report TUI
mode, the percentage you see per instruction is relative to the
function. I would like the option to display the total percentage,
i..e, the importance of the instruction for the entire run. Right now,
if I want that, I need to do function_percentage * insn_percentage by
hand. This is not convenient. Having a key toggle would be very
useful, worst case a cmdline option.

What do you think?
Thanks.
