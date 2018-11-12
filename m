Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17671C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 09:57:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B568B22419
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 09:57:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZP8OFRu+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B568B22419
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728205AbeKLTtc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 14:49:32 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34800 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbeKLTtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 14:49:31 -0500
Received: by mail-wm1-f65.google.com with SMTP id f1-v6so8445933wmg.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 01:57:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=5NCEbWQclgX8xpLbb2pIjqCBIH5tuRRK++nUd6E0vSs=;
        b=ZP8OFRu+RKvhSzcVJmFuKWdyLaxPvw6eJ3EoE01vT0OKpBzf+TDowOhoLsELgoToEh
         UmcuzB9EvofHfDSk03ybYmYu3hZ4Wy6Qj0WPxyBAcwv/44Y3lMhbiGDjp/HtoYmdM3xf
         pJBhg8N82vVmwFfbxWmgNNVjs6jE8ICrnjhZY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5NCEbWQclgX8xpLbb2pIjqCBIH5tuRRK++nUd6E0vSs=;
        b=r5ACUERr0Ds2IOvukTagP/Avd8+zTivs9aSNlTskc+jrbMODN7MS11mqQBvwrLJFG7
         ErsM1/S9ZJ7GIvd9Sm3rhKGHwgHDO/lOnLptoe4dtXT/2a+ps480DOn2akaHkfSZt5Ar
         XfcM6yS1bnk5bINhD6zUwSJlIj5lfpq3p7WLSOIY93jXj3UZ/5xMufUQPxrPh32opoVf
         SPydXNrIMfejARtKXjXLf5M0c44gRJmz4cOuvUCRW1rypuP4yJM6IgCLfgB5pm2v+7hb
         pZVdj9QdMpRQNbiOyIMBQBAFKxeT2Y029IsfKkRs/CYqyO7Ldu7UsmBsfGt1k5N/63Hm
         qeog==
X-Gm-Message-State: AGRZ1gJC89/2dxDbGtIrjMFnQzN+URmJRH93K9bGZ75Ir4KuxiypfJOp
        6TT/BMLZ9BQeQMMe/i8VCO1Qdg==
X-Google-Smtp-Source: AJdET5eSr+7ZdF7m6qW85OJdeLWzSOehikjAZ1tfBRbDmoA7VnB7eLjRjZe+gSFFG0p4U6wEATRgSw==
X-Received: by 2002:a1c:38c5:: with SMTP id f188-v6mr6871687wma.19.1542016622433;
        Mon, 12 Nov 2018 01:57:02 -0800 (PST)
Received: from localhost.localdomain ([93.68.220.21])
        by smtp.gmail.com with ESMTPSA id r14-v6sm21273089wro.8.2018.11.12.01.56.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Nov 2018 01:57:01 -0800 (PST)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Angelo Ruocco <angeloruocco90@gmail.com>,
        Dennis Zhou <dennis@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Liu Bo <bo.liu@linux.alibaba.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        broonie@kernel.org, bfq-iosched@googlegroups.com,
        oleksandr@natalenko.name, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH 00/12] unify the interface of the proportional-share policy in blkio/io
Date:   Mon, 12 Nov 2018 10:56:20 +0100
Message-Id: <20181112095632.69114-1-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.16.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens, Tejun, all,
about nine months ago, we agreed on a solution for unifying the
interface of the proportional-share policy in blkio/io [1].  Angelo
and I finally completed it.  Let me briefly recall the problem and the
solution.

The current implementation of cgroups doesn't allow two or more
entities, e.g., I/O schedulers, to share the same files.  So, if CFQ
creates its files for the proportional-share policy, such as, e.g,
weight files for blkio/io groups, BFQ cannot attach somehow to them.
Thus, to enable people to set group weights with BFQ, I resorted to
making BFQ create its own version of these common files, by prepending
a bfq prefix.

Actually, no legacy code uses these different names, or is likely to
do so.  Having these two sets of names is simply a source of
confusion, as pointed out also, e.g., by Lennart Poettering (CCed
here), and acknowledged by Tejun [2].

In [1] we agreed on a solution that solves this problem, by actually
making it possible to share cgroups files.  Both writing to and
reading from a shared file trigger the appropriate operation for each
of the entities that share the file.  In particular, in case of
reading,
- if all entities produce the same output, the this common output is
  shown only once;
- if the outputs differ, then every per-entity output is shown,
  preceded by the name of the entity that produced that output.

With this solution, legacy code that, e.g., sets group weights, just
works, regardless of the I/O scheduler actually implementing
proportional share.

But note that this extension is not restricted to only blkio/io.  The
general group interface now enables files to be shared among multiple
entities of any kind.

(I have also added a patch to fix some clerical errors in bfq doc,
which I found while making the latter consistent with the new
interface.)

Thanks,
Paolo

[1] https://lkml.org/lkml/2018/1/4/667
[2] https://github.com/systemd/systemd/issues/7057

Angelo Ruocco (7):
  kernfs: add function to find kernfs_node without increasing ref
    counter
  cgroup: link cftypes of the same subsystem with the same name
  cgroup: add owner name to cftypes
  block, bfq: align min and default weights with cfq
  cgroup: make all functions of all cftypes be invoked
  block, cfq: allow cgroup files to be shared
  block, throttle: allow sharing cgroup statistic files

Paolo Valente (5):
  cgroup: add hook seq_show_cft with also the owning cftype as parameter
  block, cgroup: pass cftype to functions that need to use it
  block, bfq: use standard file names for the proportional-share policy
  doc, bfq-iosched: fix a few clerical errors
  doc, bfq-iosched: make it consistent with the new cgroup interface

 Documentation/block/bfq-iosched.txt |  31 +++--
 block/bfq-cgroup.c                  | 148 +++++++++++++-------
 block/bfq-iosched.h                 |   4 +-
 block/blk-cgroup.c                  |  22 +--
 block/blk-throttle.c                |  24 ++--
 block/cfq-iosched.c                 | 105 +++++++++++----
 fs/kernfs/dir.c                     |  13 ++
 include/linux/blk-cgroup.h          |  10 +-
 include/linux/cgroup-defs.h         |  14 +-
 include/linux/cgroup.h              |  13 ++
 include/linux/kernfs.h              |   7 +
 kernel/cgroup/cgroup.c              | 262 +++++++++++++++++++++++++++++-------
 12 files changed, 483 insertions(+), 170 deletions(-)

--
2.16.1
