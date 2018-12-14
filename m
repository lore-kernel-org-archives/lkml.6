Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00707C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 18:07:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B418206E0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 18:07:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hteUcZu1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730506AbeLNSHs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 13:07:48 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35343 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729619AbeLNSHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 13:07:48 -0500
Received: by mail-pl1-f195.google.com with SMTP id p8so3085472plo.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 10:07:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4Ip/0LYnlHlDLXrjJ5WMEPjQEt2PfRgjDNF+8RQ/S5E=;
        b=hteUcZu11WDSxGU22hv9xrRZ43cU5rq/w4ppUOAeo3HOonRX7h5zodYK+kiSvjdWAO
         ZHzGbOL+h/UVNMT2769B1/9Q0fErY7xlPRVQend8O+RvoZwMblSlKJmogPZnckYwTf+y
         YRSI81x2kT9kfF7NSqM47qkmag7azPP7YpE1Fn5mYsLIosGqpL3bpT20wHvOkuh+z+gW
         C26iQWta1h4v/PiGfhPOp57q1ZdX3H14c6F5rRT8BoRLzRvOkXJwPigHt8ylBlosKe5U
         NlUj4doUJwd1ksSgkmrSPNZDniOk2cE12mBFjByL2SVl2V8Ib60TH9TNBLW9cUdY26HJ
         HLIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4Ip/0LYnlHlDLXrjJ5WMEPjQEt2PfRgjDNF+8RQ/S5E=;
        b=rQiggw6YXevNfoYJG+NO4/1SsJlbB8opXPruenXtKKpzD5bmdKNSpvtn21mZOHTW1h
         BxMHSqBziJrtiI3uj6oRUalrVwkBoTMH3FhoenA+YLerv11dJchE/4cCveb3YKDllQV4
         ZWWj+60RYnSYqsOdF/NNCzkz1TAr7QT76WdrgOtk7qF7j2D3iTyA9G5sfIziK4kIzt8l
         1EpCHnFJzjGFysYF3vFceStlKduZVakikBJeSKvvhsvEjVk1Np4NXiaW3tET7+1BowGH
         mVk7FIJ0JmHXcb20rc0TSBiz+0ly0SzHgrBIErFPmixgH3buHwcKxTOcTfTm2cJbBHGP
         xU/A==
X-Gm-Message-State: AA+aEWaodtnSL6bkcBRgFutrmOq+UAzyIEj0HfMXBDo9DDHLB1GFyJki
        kOjK2yNzf5vQ7gfNWU44XAk=
X-Google-Smtp-Source: AFSGD/XOYLSpsZOMc/lgird/uoAM4mCH7iTi1fKcRHmcgg6iawo7SSaNjvxdcj1aGhg4IvATT7zdFw==
X-Received: by 2002:a17:902:2bc5:: with SMTP id l63mr3843864plb.107.1544810867619;
        Fri, 14 Dec 2018 10:07:47 -0800 (PST)
Received: from tower.thefacebook.com ([2620:10d:c090:200::5:3d97])
        by smtp.gmail.com with ESMTPSA id r2sm7180856pgo.18.2018.12.14.10.07.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 14 Dec 2018 10:07:47 -0800 (PST)
From:   Roman Gushchin <guroan@gmail.com>
X-Google-Original-From: Roman Gushchin <guro@fb.com>
To:     linux-mm@kvack.org
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, Roman Gushchin <guro@fb.com>
Subject: [RFC 0/4] vmalloc enhancements
Date:   Fri, 14 Dec 2018 10:07:16 -0800
Message-Id: <20181214180720.32040-1-guro@fb.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patchset contains few changes to the vmalloc code, which are
leading to some performance gains and code simplification.

Also, it exports a number of pages, used by vmalloc(),
in /proc/meminfo.

Patch (1) removes some redundancy on __vunmap().
Patch (2) is a preparation for patch (3).
Patch (3) merges independent 3 metadata allocations into one.
Patch (4) adds vmalloc counter to /proc/meminfo.

Roman Gushchin (4):
  mm: refactor __vunmap() to avoid duplicated call to find_vm_area()
  mm: separate memory allocation and actual work in alloc_vmap_area()
  mm: allocate vmalloc metadata in one allocation
  mm: show number of vmalloc pages in /proc/meminfo

 arch/mips/mm/ioremap.c      |   7 +-
 arch/nios2/mm/ioremap.c     |   4 +-
 arch/sh/kernel/cpu/sh4/sq.c |   5 +-
 arch/sh/mm/ioremap.c        |   8 +-
 arch/x86/mm/ioremap.c       |   4 +-
 fs/proc/meminfo.c           |   2 +-
 include/linux/vmalloc.h     |   6 +-
 mm/vmalloc.c                | 206 ++++++++++++++++++++++--------------
 8 files changed, 140 insertions(+), 102 deletions(-)

-- 
2.19.2

