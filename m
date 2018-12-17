Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 357B2C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 13:19:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 031EF2133F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 13:19:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u8j8tnNp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732688AbeLQNTk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 08:19:40 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37256 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727464AbeLQNTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 08:19:39 -0500
Received: by mail-wr1-f68.google.com with SMTP id s12so11806858wrt.4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 05:19:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ip5BmdZstjjtN4Gm4aUBEZsIw09OJgstzH3h1XowCYk=;
        b=u8j8tnNpEjWOfVQYuDw3B5VgPuI8m1TMw3ogMVoOFlDLmAiOd1MTyKTbfDKXO/nAn0
         +1tFdrStFtZZxrMZ15npE9UsvkDmztQwb/gfs043REuSWK7MlswBo7r31mqwAiljxRKh
         QjfhX1l7tlz7P6N5dcJ2bYWAMHWuboP9GTeoNUBzJuVdl1w8BrxqMT2T1H7kcjaCEvmd
         bczd16r4jHTBumwd98UQwDvUR0+/uqSUlPxZMmg2xTHp7dQxMiXSqrVJcdC1na0XIwFh
         wCjAxcYVT7KHlj4fGJBgFtYyK9ivRhNecrdHaoSPDDryoWlCmvWkOfYuFM04zy6gLIPd
         WiyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ip5BmdZstjjtN4Gm4aUBEZsIw09OJgstzH3h1XowCYk=;
        b=Dzjp4DiQCOazjEwygnSEII1wY9vn5lKoHLup3fZ1CmyWjrGjGjlXWtDen8bkDdghx/
         cnVdOvv6/j3hszgpEnt7SV5U4MiGQo0ApnEtNbK8K6W1Ak1T4hvrFjCmo6mEhq5Ol/CI
         SZpHxr0lhyGAdtj+JuwpSfI9jrjjDykEmM0w/zvYuhiJr737l1VlUFayCdi2FR9SjEoN
         qbzFEDaOP3RAjLGYxbrvJlN5rlToHp1ulhmXoBMnX/e4tsb2WiRauda75F3EuzzJDSZs
         xQ5y7jOf0DTGxW+3CVG68/MyHJkKQJMNqDJyChbpmZ5wl00uochKTU+z30O1fgW+UvC0
         eh/A==
X-Gm-Message-State: AA+aEWbW7lE2V3Pj038anNHitkx6ceIHee9qvtoZuyrqT+ZJWjVxgQeV
        DSLahNBR+7ED8cZYgLqdkg==
X-Google-Smtp-Source: AFSGD/XekhacZDKNDmkyrzoiRk1NT5u2/YnP1NfETBjTkLPP9r03pO0RYTf1XVq/4BuS37Fb4Fov7g==
X-Received: by 2002:a5d:488f:: with SMTP id g15mr10690237wrq.15.1545052777351;
        Mon, 17 Dec 2018 05:19:37 -0800 (PST)
Received: from kmo-pixel.syslink.intern ([93.240.4.121])
        by smtp.gmail.com with ESMTPSA id x20sm20406120wme.6.2018.12.17.05.19.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Dec 2018 05:19:36 -0800 (PST)
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Cc:     Kent Overstreet <kent.overstreet@gmail.com>
Subject: [PATCH 0/7] generic radix trees; drop flex arrays
Date:   Mon, 17 Dec 2018 08:19:22 -0500
Message-Id: <20181217131929.11727-1-kent.overstreet@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

this has been sitting on my todo list for far too long; let's try and get it
merged before flex arrays grow any new users.

The only significant change since the last time I mailed this out is that it's
now safe to use a genradix from multiple threads, including when new nodes are
being allocated.

Since we never _free_ nodes on a genradix while it's in use (only when the
entire tree is being freed), this adds very little code - we just use cmpxchg
for adding pointers to new nodes, there's no need to use rcu_read_lock() or
anything like that. And for the types of things we seem to want to use it for
it's quite useful.

Andrew, would you mind picking up this series, or would someone else be more
suitable? The patch series has been sent out a few times and seen a fair amoun
of review.

Kent Overstreet (7):
  openvswitch: convert to kvmalloc
  md: convert to kvmalloc
  selinux: convert to kvmalloc
  Generic radix trees
  proc: commit to genradix
  sctp: Convert to genradix
  Drop flex_arrays

 Documentation/core-api/flexible-arrays.rst    | 130 ------
 Documentation/core-api/generic-radix-tree.rst |  12 +
 Documentation/core-api/index.rst              |   1 +
 Documentation/flexible-arrays.txt             | 123 ------
 drivers/md/raid5-ppl.c                        |   6 +-
 drivers/md/raid5.c                            |  87 ++--
 drivers/md/raid5.h                            |   9 +-
 fs/proc/base.c                                |  43 +-
 include/linux/flex_array.h                    | 149 -------
 include/linux/generic-radix-tree.h            | 231 ++++++++++
 include/linux/poison.h                        |   3 -
 include/net/sctp/structs.h                    |  15 +-
 lib/Makefile                                  |   5 +-
 lib/flex_array.c                              | 398 ------------------
 lib/generic-radix-tree.c                      | 217 ++++++++++
 net/openvswitch/flow.h                        |   1 -
 net/openvswitch/flow_netlink.h                |   1 -
 net/openvswitch/flow_table.c                  |  51 +--
 net/openvswitch/flow_table.h                  |   3 +-
 net/sctp/stream.c                             | 106 +----
 net/sctp/stream_interleave.c                  |   2 +-
 security/selinux/ss/avtab.c                   |  40 +-
 security/selinux/ss/avtab.h                   |   4 +-
 security/selinux/ss/conditional.c             |   6 +-
 security/selinux/ss/policydb.c                | 122 ++----
 security/selinux/ss/policydb.h                |  12 +-
 security/selinux/ss/services.c                |  22 +-
 tools/include/linux/poison.h                  |   3 -
 28 files changed, 628 insertions(+), 1174 deletions(-)
 delete mode 100644 Documentation/core-api/flexible-arrays.rst
 create mode 100644 Documentation/core-api/generic-radix-tree.rst
 delete mode 100644 Documentation/flexible-arrays.txt
 delete mode 100644 include/linux/flex_array.h
 create mode 100644 include/linux/generic-radix-tree.h
 delete mode 100644 lib/flex_array.c
 create mode 100644 lib/generic-radix-tree.c

-- 
2.20.1

