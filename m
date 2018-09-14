Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A742FC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 10:53:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0C2A21479
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 10:53:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="MuiWdFtX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0C2A21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728306AbeINQHK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 12:07:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:48092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727649AbeINQHJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 12:07:09 -0400
Received: from tleilax.poochiereds.net (cpe-71-70-156-158.nc.res.rr.com [71.70.156.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8DCBA20853;
        Fri, 14 Sep 2018 10:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536922393;
        bh=XoaAD4xbhhNm1H+OPLWMnKOdBxEE0GlMQ07B9bf06+s=;
        h=From:To:Cc:Subject:Date:From;
        b=MuiWdFtXGUdIOSLlgMsm0nRjnn5Uy6v6eITW6C2Z7wO2tNP49Xy4KWU6p67YhmDSX
         k3hGlp2J8Yj8mrXIXjgtICyOiESj3N3DFP1bfxNNFp/csdFaIz0j+s9muCjAW7ydii
         7APk6Kc1UCqDoIRFtURCVEvRoue3so2i198jWPTI=
From:   Jeff Layton <jlayton@kernel.org>
To:     viro@zeniv.linux.org.uk
Cc:     ebiederm@xmission.com, berrange@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] exec: fix passing of file locks across execve in multithreaded processes
Date:   Fri, 14 Sep 2018 06:53:07 -0400
Message-Id: <20180914105310.6454-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2: fix displaced_files cleanup in __do_execve_file
v3: fix thread_count handling in unshare syscall
    add new release_files_struct helper

The main difference from the earlier set is some cleanup and fixes for
the thread_count handling in the files_struct. The original looked a
bit more ugly without the new helper function, and didn't get the
refcounting right in the unshare case, which was discovered by the
kernel test robot seeing the new WARN pop up during one test.

At this point, I'm mainly interested in whether this is the correct
approach to fix this at all. It is along the lines of what Eric B.
suggested, but I'm not sure whether it may break other cases that I
haven't considered.

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

 fs/coredump.c           |  2 +-
 fs/exec.c               | 27 +++++++++++++++++++--------
 fs/file.c               | 19 +++++++++++++++++--
 include/linux/binfmts.h |  1 +
 include/linux/fdtable.h |  3 +++
 kernel/fork.c           | 25 ++++++++++++++++++++-----
 6 files changed, 61 insertions(+), 16 deletions(-)

-- 
2.17.1

