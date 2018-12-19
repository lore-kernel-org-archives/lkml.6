Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B177C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 17:37:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE3C1217D9
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 17:37:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t/c3fdvo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730562AbeLSRh5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 12:37:57 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:56241 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728595AbeLSRh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 12:37:57 -0500
Received: by mail-it1-f195.google.com with SMTP id m62so10872936ith.5
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 09:37:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8v7LVRYpkcTeST4uZR40n7405GmVE6ZAOCzwTA4KMag=;
        b=t/c3fdvo4sQLVUorcYgmChi5r98dsnu783+/zj6POe1fi3JdwR5e3ioGH47Kw7Hm5d
         0xqkmbRxVzWknJh43f1DZuFSO6Nc3jOVHX9ClnPk0PrUt3qakQqmhkiwW6gLWZH+8P0n
         MQJZrX7J8RlG0vJWQMfj/dMoEMN0QCfbpuUz/+R4Xq8g9wgq1JCtOmU9sh6w/Ha2S+on
         XHhJM72QB5l0PKtJ04O+zaV5YS+ViyHxL04H7+mveoqaCiN0T451meMlgwldCmq6Aq1q
         bUZdUab7oqOtb7BRkO7xoD8b+AVFJy59e9b4z3jQhFj/CXhitWShwHQJR9dv6NC+dTW4
         nsSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8v7LVRYpkcTeST4uZR40n7405GmVE6ZAOCzwTA4KMag=;
        b=I0qG4wW9K708Xyq3UgqVWgEYoJZ0pM66BlLAUXhDKw2yz5p23RSg+3hx1TgmI+O4Ly
         EVBcezlRgFfZSUtbgNGJieuWwMKiwpOtEfjLIpCIkRp0kB7b2M8PIJFpLFa2ZARMEcct
         R/P46ttDEUFsBKPmBBkifsZcP66KBvuIuPSp53ZEQ23/6On1DvhQrTyHJKByshRT94Xt
         PUCWGaL/2dSLVL0GMLZDnmA07ZjNtLsdK2xbezqjTFY5VCDpotYH2cleA9KEAlgggpW4
         tm3z377aCvVOwt/uprtxOrmuZHNLDKKdPqdANV2nOnrWK4vMgUXMepUOeoxSnxLkSTyp
         shvg==
X-Gm-Message-State: AA+aEWYvFEDWimXcs4pGU4KZummtjNiUToBGBDxSrACPjnQrHOfNVCzO
        PKlnxW7sEaZri4cvMMw/IXo=
X-Google-Smtp-Source: AFSGD/XObQ2BqxV22TcA33trGI9KhsypInghDrwqGTdprS0gO8Gtkk0j44rJTWbb5Okq25A/sHBACQ==
X-Received: by 2002:a24:c105:: with SMTP id e5mr7058918itg.87.1545241076375;
        Wed, 19 Dec 2018 09:37:56 -0800 (PST)
Received: from tower.thefacebook.com ([2620:10d:c090:200::7:bd3e])
        by smtp.gmail.com with ESMTPSA id a10sm3637728itc.3.2018.12.19.09.37.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Dec 2018 09:37:55 -0800 (PST)
From:   Roman Gushchin <guroan@gmail.com>
X-Google-Original-From: Roman Gushchin <guro@fb.com>
To:     linux-mm@kvack.org
Cc:     Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, Roman Gushchin <guro@fb.com>
Subject: [PATCH 0/3] vmalloc enhancements
Date:   Wed, 19 Dec 2018 09:37:48 -0800
Message-Id: <20181219173751.28056-1-guro@fb.com>
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
Patch (2) separates memory allocation and data initialization
  in alloc_vmap_area()
Patch (3) adds vmalloc counter to /proc/meminfo.

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
2.19.2

