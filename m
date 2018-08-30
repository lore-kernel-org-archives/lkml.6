Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A7A5C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 17:24:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB6502083B
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 17:24:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="GR8+RLsV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB6502083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbeH3V1f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 17:27:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:56608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726122AbeH3V1f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 17:27:35 -0400
Received: from tleilax.poochiereds.net (cpe-71-70-156-158.nc.res.rr.com [71.70.156.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB9E520661;
        Thu, 30 Aug 2018 17:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535649865;
        bh=aU8yEm4QZGbkJuL+4KJk9CQ1HjLwTKdsg/67jBX+750=;
        h=From:To:Cc:Subject:Date:From;
        b=GR8+RLsVRvyi6HJ0jBPu+3qQi+2P5IiXmujOe+MBSLlbjcx8uPsqLrqCCCfwWwPJP
         i1K7AXjui74dDhqEyGXeYhr4yhPNxzekINGNAUJMeyb87oBsTrC4OqYndCxv7rzj6L
         BZR3inSN6y4LBPnBzsn2R4Zm3UrwB/ODQgw51nY4=
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] exec: fix passing of file locks across execve in multithreaded processes
Date:   Thu, 30 Aug 2018 13:24:20 -0400
Message-Id: <20180830172423.21964-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2: fix displaced_files cleanup in __do_execve_file

I've done a bit more testing (now with the error handling fixed and it
seems to work ok. I have not looked at performance regressions here,
as I'm not sure how best to test for that.

My main question at this point is whether this is the correct way to
fix it. Cover letter from the RFC set follows:

-------------------------8<----------------------
A few months ago, Dan reported that when you call execve in process that
is multithreaded, any traditional POSIX locks are silently dropped.

The problem is that we end up unsharing the files_struct from the
process very early during exec, when it looks like it's shared between
tasks. Eventually, when the other, non-exec'ing tasks are killed, we
tear down the old files_struct. That ends up tearing down the old
files_struct, which ends up looking like a close() was issues on each
open fd and that causes the locks to be dropped.

This patchset is a second stab at fixing this issue, this time following
the method suggested by Eric Biederman. The idea here is to move the
unshare_files() call after de_thread(), which helps ensure that we only
unshare the files_struct when it's truly shared between different
processes, and not just when the exec'ing process is multithreaded.

This seems to fix the originally reported problem (now known as xfstest
generic/484), and basic testing doesn't seem to show any issues.

During the original discussion though, Al had mentioned that this could
be problematic due to the fdtable being modifiable by other threads
(or even processes) during the binfmt probe. That may make this idea
non-viable.

I'm also not terribly thrilled with the way this sprinkles the
files_struct->file_lock all over the place. It may be possible to do
some of this with atomic ops if the basic approach turns out to be
reasonable.

Comments and suggestions welcome.

Jeff Layton (3):
  exec: separate thread_count for files_struct
  exec: delay clone(CLONE_FILES) if task associated with current
    files_struct is exec'ing
  exec: do unshare_files after de_thread

 fs/exec.c               | 25 ++++++++++++++++++-------
 fs/file.c               | 18 ++++++++++++++++++
 include/linux/binfmts.h |  1 +
 include/linux/fdtable.h |  2 ++
 kernel/fork.c           | 26 ++++++++++++++++++++++----
 5 files changed, 61 insertions(+), 11 deletions(-)

-- 
2.17.1

