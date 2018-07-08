Return-Path: <SRS0=ZPnh=JY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4079C3279B
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 21:05:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88027208AF
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 21:05:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iyy49HJo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88027208AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933084AbeGHVFe (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 17:05:34 -0400
Received: from mail-pf0-f175.google.com ([209.85.192.175]:46159 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933074AbeGHVFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 17:05:32 -0400
Received: by mail-pf0-f175.google.com with SMTP id l123-v6so12138256pfl.13;
        Sun, 08 Jul 2018 14:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=F1HxcWVqaSjbuP+zXThSIlCffhKigykTlbf2ywMqFS8=;
        b=iyy49HJoPZpoqiJBhDI2SLPfCaWFEBzSSB0DAgUNAItodEIDzgp47pPu7lGihM+oce
         BFy+vWS48D5SW1GJ1leiyVBA8PX4OWjvPeJLG2NCOAw3gd3U3+pyaoAT8WbvSOtqgc4O
         0JvhY9RNRvs587+qU83CBnqiqapmgnHilFV4DSqkycu7OhVl970cO4ARGZTDO7VvCG+R
         XDgH178NHbDSJtky0KH3u5w0E7eDIX/VPo1Ppdiq+flFeAIXLZAgP9BZ4/8dqHy9AXWC
         AKcrf1TVPAYSdVaK2rmDvvZqi2j1LdgZhAEPIgDUMxNA348WTmvCr+fcL0feKk+paJAJ
         PKZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=F1HxcWVqaSjbuP+zXThSIlCffhKigykTlbf2ywMqFS8=;
        b=Evf5EVjHfbVjESNF40Tiu0nasA62OKP4dRlirhwDw8Sb6307niuJuTZ9oc3ePJmtvB
         TsJUqr3jhukvThd0fp/Ki0U0ZfMk9HbJj5h1YEB6ZBaFQBeyHSLQBxKbLBSOCB+svRhW
         OvWNiKxB+75pyRptQnB99C6FXP0FYLp8d2Z2s14sfws+yxDv45zJiKgLJJ4kZIlZNneA
         V3iVNPC8GMC+GeV4oOzuqjRwH+jjqJwUoKaJvUvghsBPhNfc/A5SKrTB9dXp7LWwEZxS
         FXp7rYKroy2ekMp+cyuEA92LvMaSy/inKtF36pF0k1qRdoxKqrleibP2mhUmnmaa6Hpn
         yBhg==
X-Gm-Message-State: APt69E3j247rShg8Rq+yiqTRDZQ7FtZnM7JfPxKfXKruBd18FxGXr8Eg
        vQz8htxoea8RhRNx/NfMBKY=
X-Google-Smtp-Source: AAOMgpeFumi/7UHqcWtLNDk1R33rCmywrk9eWt7GGbdSwC5yErOUr66Zs5+LlpVeBEpflarf0JMjqA==
X-Received: by 2002:a65:5683:: with SMTP id v3-v6mr16122054pgs.176.1531083931572;
        Sun, 08 Jul 2018 14:05:31 -0700 (PDT)
Received: from sol.localdomain (c-67-185-97-198.hsd1.wa.comcast.net. [67.185.97.198])
        by smtp.gmail.com with ESMTPSA id x68-v6sm23355681pfb.138.2018.07.08.14.05.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Jul 2018 14:05:30 -0700 (PDT)
From:   Eric Biggers <ebiggers3@gmail.com>
To:     David Howells <dhowells@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Eric Biggers <ebiggers3@gmail.com>
Subject: [PATCH vfs/for-next 00/18] fs_context fixes
Date:   Sun,  8 Jul 2018 14:01:36 -0700
Message-Id: <20180708210154.10423-1-ebiggers3@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David and Al, here are some fixes for the fs_context patches.

Feel free to fold these into the original patches if you want.

Patches 13-18 are cleanups only.

Eric Biggers (18):
  sysfs: check return value of kernfs_get_tree()
  fs_context: fix shrinker leak in sget_fc()
  fs_context: fix detecting full log buffer
  fs_context: fix fs_context leak in simple_pin_fs()
  fs_context: fix mount option blacklist
  fs_context: fix memory leak with 's' (source) command
  fs_context: fix double free of legacy_fs_context data
  fsmount: pass up error code from dentry_open()
  fsmount: fix handling FSMOUNT_CLOEXEC
  fsmount: fix bypassing SB_MANDLOCK permission check
  fspick: fix path leak
  fspick: add missing permission check
  fsmount: removed unused variable 'inode'
  fsopen,fspick: factor out log allocation
  fsopen,fspick: rename fsopen_create_fd() to fscontext_create_fd()
  fs_context: de-obfuscate control flow in fscontext_read()
  fs_context: de-obfuscate command validation
  fs_context: fix fscontext_write() comment

 fs/fs_context.c  | 47 ++++++++++++++++++--------------
 fs/fsopen.c      | 71 +++++++++++++++++++++++++-----------------------
 fs/libfs.c       |  4 ++-
 fs/namespace.c   | 20 ++++++++------
 fs/super.c       |  2 +-
 fs/sysfs/mount.c |  3 ++
 6 files changed, 81 insertions(+), 66 deletions(-)

-- 
2.18.0

