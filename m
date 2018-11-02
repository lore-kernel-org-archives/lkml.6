Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7942DC65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:37:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4663F2081B
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:37:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="R+vcTgvf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4663F2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728705AbeKCDqG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 23:46:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:39762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727556AbeKCDqF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 23:46:05 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1421F2081B;
        Fri,  2 Nov 2018 18:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541183874;
        bh=73l5uNxngE695yBOsWE+pg//hxV7LCRd9cUqm/yteIQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R+vcTgvfZ4Wr+TVR4HHF9Iy6pALdr0Akg7CQfEiJDQn4dyzLUyiuxCZtkAgwOn3r9
         eYXzOgsHdVkrQ6ERuutnuH+DI8JDfjFSe1o7jipakLJiNxVWxVTLIyTUlev3ej31zm
         jsjVI8QgQrjlwUPUf0yYDOeH/Sl+TtQpA8hNA9z8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Joseph Myers <joseph@codesourcery.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 23/24] sparc64: Wire up compat getpeername and getsockname.
Date:   Fri,  2 Nov 2018 19:34:56 +0100
Message-Id: <20181102182843.299795461@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181102182839.725385066@linuxfoundation.org>
References: <20181102182839.725385066@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "David S. Miller" <davem@davemloft.net>

[ Upstream commit 1f2b5b8e2df4591fbca430aff9c5a072dcc0f408 ]

Fixes: 8b30ca73b7cc ("sparc: Add all necessary direct socket system calls.")
Reported-by: Joseph Myers  <joseph@codesourcery.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/sparc/kernel/systbls_64.S |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/sparc/kernel/systbls_64.S
+++ b/arch/sparc/kernel/systbls_64.S
@@ -47,9 +47,9 @@ sys_call_table32:
 	.word sys_recvfrom, sys_setreuid16, sys_setregid16, sys_rename, compat_sys_truncate
 /*130*/	.word compat_sys_ftruncate, sys_flock, compat_sys_lstat64, sys_sendto, sys_shutdown
 	.word sys_socketpair, sys_mkdir, sys_rmdir, compat_sys_utimes, compat_sys_stat64
-/*140*/	.word sys_sendfile64, sys_nis_syscall, compat_sys_futex, sys_gettid, compat_sys_getrlimit
+/*140*/	.word sys_sendfile64, sys_getpeername, compat_sys_futex, sys_gettid, compat_sys_getrlimit
 	.word compat_sys_setrlimit, sys_pivot_root, sys_prctl, sys_pciconfig_read, sys_pciconfig_write
-/*150*/	.word sys_nis_syscall, sys_inotify_init, sys_inotify_add_watch, sys_poll, sys_getdents64
+/*150*/	.word sys_getsockname, sys_inotify_init, sys_inotify_add_watch, sys_poll, sys_getdents64
 	.word compat_sys_fcntl64, sys_inotify_rm_watch, compat_sys_statfs, compat_sys_fstatfs, sys_oldumount
 /*160*/	.word compat_sys_sched_setaffinity, compat_sys_sched_getaffinity, sys_getdomainname, sys_setdomainname, sys_nis_syscall
 	.word sys_quotactl, sys_set_tid_address, compat_sys_mount, compat_sys_ustat, sys_setxattr


