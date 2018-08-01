Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66087C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:32:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24FFD20840
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:32:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24FFD20840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733039AbeHAUTA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 16:19:00 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46076 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404200AbeHATDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:03:35 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 5AA301016;
        Wed,  1 Aug 2018 17:00:06 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sandipan Das <sandipan@linux.vnet.ibm.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 137/336] bpf: fix multi-function JITed dump obtained via syscall
Date:   Wed,  1 Aug 2018 18:47:52 +0200
Message-Id: <20180801165034.371476003@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801165028.930831994@linuxfoundation.org>
References: <20180801165028.930831994@linuxfoundation.org>
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

From: Sandipan Das <sandipan@linux.vnet.ibm.com>

[ Upstream commit 4d56a76ead2fcd856e677cdc9445ad331a409b8c ]

Currently, for multi-function programs, we cannot get the JITed
instructions using the bpf system call's BPF_OBJ_GET_INFO_BY_FD
command. Because of this, userspace tools such as bpftool fail
to identify a multi-function program as being JITed or not.

With the JIT enabled and the test program running, this can be
verified as follows:

  # cat /proc/sys/net/core/bpf_jit_enable
  1

Before applying this patch:

  # bpftool prog list
  1: kprobe  name foo  tag b811aab41a39ad3d  gpl
          loaded_at 2018-05-16T11:43:38+0530  uid 0
          xlated 216B  not jited  memlock 65536B
  ...

  # bpftool prog dump jited id 1
  no instructions returned

After applying this patch:

  # bpftool prog list
  1: kprobe  name foo  tag b811aab41a39ad3d  gpl
          loaded_at 2018-05-16T12:13:01+0530  uid 0
          xlated 216B  jited 308B  memlock 65536B
  ...

  # bpftool prog dump jited id 1
     0:   nop
     4:   nop
     8:   mflr    r0
     c:   std     r0,16(r1)
    10:   stdu    r1,-112(r1)
    14:   std     r31,104(r1)
    18:   addi    r31,r1,48
    1c:   li      r3,10
  ...

Signed-off-by: Sandipan Das <sandipan@linux.vnet.ibm.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/bpf/syscall.c |   37 ++++++++++++++++++++++++++++++++++---
 1 file changed, 34 insertions(+), 3 deletions(-)

--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1946,13 +1946,44 @@ static int bpf_prog_get_info_by_fd(struc
 	 * for offload.
 	 */
 	ulen = info.jited_prog_len;
-	info.jited_prog_len = prog->jited_len;
+	if (prog->aux->func_cnt) {
+		u32 i;
+
+		info.jited_prog_len = 0;
+		for (i = 0; i < prog->aux->func_cnt; i++)
+			info.jited_prog_len += prog->aux->func[i]->jited_len;
+	} else {
+		info.jited_prog_len = prog->jited_len;
+	}
+
 	if (info.jited_prog_len && ulen) {
 		if (bpf_dump_raw_ok()) {
 			uinsns = u64_to_user_ptr(info.jited_prog_insns);
 			ulen = min_t(u32, info.jited_prog_len, ulen);
-			if (copy_to_user(uinsns, prog->bpf_func, ulen))
-				return -EFAULT;
+
+			/* for multi-function programs, copy the JITed
+			 * instructions for all the functions
+			 */
+			if (prog->aux->func_cnt) {
+				u32 len, free, i;
+				u8 *img;
+
+				free = ulen;
+				for (i = 0; i < prog->aux->func_cnt; i++) {
+					len = prog->aux->func[i]->jited_len;
+					len = min_t(u32, len, free);
+					img = (u8 *) prog->aux->func[i]->bpf_func;
+					if (copy_to_user(uinsns, img, len))
+						return -EFAULT;
+					uinsns += len;
+					free -= len;
+					if (!free)
+						break;
+				}
+			} else {
+				if (copy_to_user(uinsns, prog->bpf_func, ulen))
+					return -EFAULT;
+			}
 		} else {
 			info.jited_prog_insns = 0;
 		}


