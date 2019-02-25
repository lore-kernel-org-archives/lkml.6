Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 426D5C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 20:30:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 126312084D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 20:30:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZHf3nlOY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727481AbfBYUam (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 15:30:42 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35558 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727021AbfBYUam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 15:30:42 -0500
Received: by mail-pg1-f196.google.com with SMTP id e17so2966822pgd.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 12:30:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vH2mkKI4IItKEc8IoojF+FfVZDI5/MhLCKDGa5sz0w0=;
        b=ZHf3nlOYmozfI6iMnmTqQYTrV4iyplfReEUPHfvjJoKgl1aj+1Qs9XepvPzdhQdtzK
         RlLPMdqWA3n3vN/9yB2x0nFI6tPRSn96ebIpqlYG8RZ3pJ5Zjb198LHVI3bGHCrmZtsz
         78d/AmYrnN5mUM8Kazd13HebbQRitKJwY7rNkRWUqUCKzsNTKWZfKvf7CzL04MtNNXem
         LG5VFghNOdF4s+xKJd1prs65XUE0ZGFSClD+O5RVZibIK7v6zO6eKbtMapBmZT8HzryG
         cEaIPBXaSJOXdELPjgaXaKQ+y83PpQ3BQ5zWw+FFR8ATE879v9OKtzodB1SBY1Xoypb6
         kO4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vH2mkKI4IItKEc8IoojF+FfVZDI5/MhLCKDGa5sz0w0=;
        b=aHHAhzSW9C+1/mXZnfsLmqcrAl7o62Ttgqf+jgcMlW/rAPOsZvcuQaLPk73S9e00Qz
         VC7n9NWwSc8RlvyZB5swaVD45DcL5s82fg189n5/kYSj7kSvPxSv7FH0FuXNR/2Q9W4t
         q5YXB9g956oAL2QkWOTpUo8J2lxawV3knsicDkFJ+fqcmf/ImzmK09pzPR7SPUJGO5Xi
         jYtb2c16N0mjnjiB+h9e+5DSU4BVB9Z1Ko7+N2D8pPBVdOK8vfJLdpSlPLeL+GrPE3xI
         9uwkjBwtyKWyvIdhEUGxPhjjXQV+sA1Iey8ZAXP+qfJNVYwhzrzFrFoqR9ue5UtOOaiO
         JRgQ==
X-Gm-Message-State: AHQUAubtHfVgOgqhYanYaMNDcbYcWf91osoTaL5QzO9T5l0Ll6AT6i5m
        fAA1LNpc/AeoXLACtPMj/kM=
X-Google-Smtp-Source: AHgI3Ia14eKm+TAQqiLkj/Yu4ttd46vaiiavPxcnFprQLBn4ByMgY7QCyxGpbBVvJDMzcvpFdScgnQ==
X-Received: by 2002:a63:2c0e:: with SMTP id s14mr1254311pgs.132.1551126641850;
        Mon, 25 Feb 2019 12:30:41 -0800 (PST)
Received: from tower.thefacebook.com ([2620:10d:c090:200::2:d960])
        by smtp.gmail.com with ESMTPSA id s4sm6189885pfe.16.2019.02.25.12.30.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Feb 2019 12:30:40 -0800 (PST)
From:   Roman Gushchin <guroan@gmail.com>
X-Google-Original-From: Roman Gushchin <guro@fb.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>, kernel-team@fb.com,
        Roman Gushchin <guro@fb.com>
Subject: [PATCH 0/3] vmalloc enhancements
Date:   Mon, 25 Feb 2019 12:30:34 -0800
Message-Id: <20190225203037.1317-1-guro@fb.com>
X-Mailer: git-send-email 2.20.1
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
Patch (2) separates memory allocation and data initialization
  in alloc_vmap_area()
Patch (3) adds vmalloc counter to /proc/meminfo.

v3->v2:
  - switched back to atomic after more accurate perf measurements:
  no visible perf difference
  - added perf stacktraces in commmit message of (1)

v2->v1:
  - rebased on top of current mm tree
  - switch from atomic to percpu vmalloc page counter

RFC->v1:
  - removed bogus empty lines (suggested by Matthew Wilcox)
  - made nr_vmalloc_pages static (suggested by Matthew Wilcox)
  - dropped patch 3 from RFC patchset, will post later with
  some other changes
  - dropped RFC

Roman Gushchin (3):
  mm: refactor __vunmap() to avoid duplicated call to find_vm_area()
  mm: separate memory allocation and actual work in alloc_vmap_area()
  mm: show number of vmalloc pages in /proc/meminfo

 fs/proc/meminfo.c       |   2 +-
 include/linux/vmalloc.h |   2 +
 mm/vmalloc.c            | 107 ++++++++++++++++++++++++++--------------
 3 files changed, 73 insertions(+), 38 deletions(-)

-- 
2.20.1

