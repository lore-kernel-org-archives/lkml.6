Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D9D6C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:40:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0E362083A
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:40:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0E362083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732286AbeHWMJS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:09:18 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49734 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731298AbeHWMJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:09:17 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A568C8B1;
        Thu, 23 Aug 2018 08:40:40 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 014/324] selftests/bpf: test offloads even with BPF programs present
Date:   Thu, 23 Aug 2018 09:51:20 +0200
Message-Id: <20180823074956.626730286@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823074955.885811006@linuxfoundation.org>
References: <20180823074955.885811006@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jakub Kicinski <jakub.kicinski@netronome.com>

[ Upstream commit 47cf52a246e526e2092d60ac01c54af9bd45dcc9 ]

Modern distroes increasingly make use of BPF programs.  Default
Ubuntu 18.04 installation boots with a number of cgroup_skb
programs loaded.

test_offloads.py tries to check if programs and maps are not
leaked on error paths by confirming the list of programs on the
system is empty between tests.

Since we can no longer expect the system to have no BPF objects
at boot try to remember the programs and maps present at the start,
and skip those when scanning the system.

Signed-off-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Reviewed-by: Quentin Monnet <quentin.monnet@netronome.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/bpf/test_offload.py |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

--- a/tools/testing/selftests/bpf/test_offload.py
+++ b/tools/testing/selftests/bpf/test_offload.py
@@ -163,6 +163,10 @@ def bpftool(args, JSON=True, ns="", fail
 
 def bpftool_prog_list(expected=None, ns=""):
     _, progs = bpftool("prog show", JSON=True, ns=ns, fail=True)
+    # Remove the base progs
+    for p in base_progs:
+        if p in progs:
+            progs.remove(p)
     if expected is not None:
         if len(progs) != expected:
             fail(True, "%d BPF programs loaded, expected %d" %
@@ -171,6 +175,10 @@ def bpftool_prog_list(expected=None, ns=
 
 def bpftool_map_list(expected=None, ns=""):
     _, maps = bpftool("map show", JSON=True, ns=ns, fail=True)
+    # Remove the base maps
+    for m in base_maps:
+        if m in maps:
+            maps.remove(m)
     if expected is not None:
         if len(maps) != expected:
             fail(True, "%d BPF maps loaded, expected %d" %
@@ -585,8 +593,8 @@ skip(os.getuid() != 0, "test must be run
 # Check tools
 ret, progs = bpftool("prog", fail=False)
 skip(ret != 0, "bpftool not installed")
-# Check no BPF programs are loaded
-skip(len(progs) != 0, "BPF programs already loaded on the system")
+base_progs = progs
+_, base_maps = bpftool("map")
 
 # Check netdevsim
 ret, out = cmd("modprobe netdevsim", fail=False)


