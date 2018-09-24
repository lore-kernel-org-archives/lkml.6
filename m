Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18168C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:40:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D061F2083A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:40:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D061F2083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388535AbeIXSmE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:42:04 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:58912 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729165AbeIXSmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:42:03 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id B1266109A;
        Mon, 24 Sep 2018 12:40:05 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Roman Gushchin <guro@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 152/235] bpf: fix rcu annotations in compute_effective_progs()
Date:   Mon, 24 Sep 2018 13:52:18 +0200
Message-Id: <20180924113120.557117770@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113103.999624566@linuxfoundation.org>
References: <20180924113103.999624566@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Roman Gushchin <guro@fb.com>

[ Upstream commit 3960f4fd6585608e8cc285d9665821985494e147 ]

The progs local variable in compute_effective_progs() is marked
as __rcu, which is not correct. This is a local pointer, which
is initialized by bpf_prog_array_alloc(), which also now
returns a generic non-rcu pointer.

The real rcu-protected pointer is *array (array is a pointer
to an RCU-protected pointer), so the assignment should be performed
using rcu_assign_pointer().

Fixes: 324bda9e6c5a ("bpf: multi program support for cgroup+bpf")
Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/bpf/cgroup.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -95,7 +95,7 @@ static int compute_effective_progs(struc
 				   enum bpf_attach_type type,
 				   struct bpf_prog_array __rcu **array)
 {
-	struct bpf_prog_array __rcu *progs;
+	struct bpf_prog_array *progs;
 	struct bpf_prog_list *pl;
 	struct cgroup *p = cgrp;
 	int cnt = 0;
@@ -120,13 +120,12 @@ static int compute_effective_progs(struc
 					    &p->bpf.progs[type], node) {
 				if (!pl->prog)
 					continue;
-				rcu_dereference_protected(progs, 1)->
-					progs[cnt++] = pl->prog;
+				progs->progs[cnt++] = pl->prog;
 			}
 		p = cgroup_parent(p);
 	} while (p);
 
-	*array = progs;
+	rcu_assign_pointer(*array, progs);
 	return 0;
 }
 


