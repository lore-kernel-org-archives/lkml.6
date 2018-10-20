Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C75BEECDE3D
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 18:56:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BA10215E5
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 18:56:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BA10215E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727634AbeJUDHq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 23:07:46 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:40396 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727350AbeJUDHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 23:07:46 -0400
Received: by mail-yb1-f196.google.com with SMTP id w7-v6so14585695ybm.7;
        Sat, 20 Oct 2018 11:56:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=rkdP/SDB6tKFV4oYMZiWk9dFrzIYzeYwYUcXwPb7M8A=;
        b=QexyJyJiRlLCNBKylhaK5FcHkp/e/U3xtpB6EIM+4kmZIRso90tfJc2Txwlbje99YR
         iODna1Mrpkyer/AjAwXxqttdvbHiZ26mLflo+enDKmj71UwOoOSTsgPeObf/zCchRBG6
         NTV1ZHkPbIhpS0AXvPYygsCA7+nsx2P3FbsGfhU6+AMPWf1wHpQCwdRO+c67g4bPe8a2
         FIxj5O1AQoRyB1j12Sh1uoOSOMa10pVmCX3QK6uPRCTYUc13HkpEoKsx35lg/F/jZUpj
         H0iWBrgoayouA8+9pbHnTLGqbzfmDLPsNM/JuPgB9r4y75MaPN1dBHC0Q1K7jDyGzW8H
         0j8g==
X-Gm-Message-State: ABuFfog2e4IPQhSCe+9Zup4J9yLn53qDAk9wZ1+YioD57zOMV1MwIu9L
        aGozXref7ZzgtdPQEgpNA2k=
X-Google-Smtp-Source: ACcGV61f4tC2d2YDjezPBhDsP5mLcuQw8H/opf+XpskqFmVz7z99xspEFoafQfXo+rw27+9rjXGvNQ==
X-Received: by 2002:a25:58c6:: with SMTP id m189-v6mr25817809ybb.80.1540061784079;
        Sat, 20 Oct 2018 11:56:24 -0700 (PDT)
Received: from dennisz-mbp.thefacebook.com ([199.201.65.3])
        by smtp.gmail.com with ESMTPSA id h63-v6sm1977456ywb.110.2018.10.20.11.56.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 20 Oct 2018 11:56:23 -0700 (PDT)
From:   Dennis Zhou <dennis@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tejun Heo <tj@kernel.org>,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>, kernel-team@fb.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dennis Zhou <dennis@kernel.org>
Subject: [PATCH 0/2] block: fixes for always associate blkg
Date:   Sat, 20 Oct 2018 14:56:10 -0400
Message-Id: <20181020185612.51587-1-dennis@kernel.org>
X-Mailer: git-send-email 2.13.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

It was reported in [1] that blk_get_rl() cleanup patch was causing a
null pointer dereference. After some back and forth debugging with
Valdis, it turns out I wasn't properly handling association with
recursive calls to make_request().

Another issue was identified with the blk_get_rl() update as it is
possible under certain circumstances that a blkg cannot be allocated
when called in blk_get_rl(). This could result in the blkcg_root being
returned. However, the blkcg_root is a special case where all blkgs
share the request_queue's request_list.

The original series can be found at [2].

[1] https://lore.kernel.org/lkml/13987.1539646128@turing-police.cc.vt.edu/
[2] https://lore.kernel.org/lkml/20180911184137.35897-1-dennisszhou@gmail.com/

This patchset contains the following 2 patches:
  0001-blkcg-fix-edge-case-for-blk_get_rl-under-memory-pres.patch
  0002-blkcg-reassociate-bios-when-make_request-is-called-r.patch

0001 addresses an edge case where a blkg cannot be created and can
possibly return a blkg associated with the blkcg_root. 0002 fixes the
stale association when make_request() is called recursively.

This patchset is on top of axboe#for-4.20/block bbc152825afc.

diffstats below:

Dennis Zhou (2):
  blkcg: fix edge case for blk_get_rl() under memory pressure
  blkcg: reassociate bios when make_request() is called recursively

 block/bio.c                | 20 ++++++++++++++++++++
 block/blk-core.c           |  1 +
 include/linux/bio.h        |  3 +++
 include/linux/blk-cgroup.h |  2 +-
 4 files changed, 25 insertions(+), 1 deletion(-)

Thanks,
Dennis
