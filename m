Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA7BBC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 21:11:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86D502177E
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 21:11:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="1CYkyUJc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730914AbfAJVLA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 16:11:00 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:50852 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729343AbfAJVK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 16:10:57 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0AL8uEQ192919;
        Thu, 10 Jan 2019 21:10:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : in-reply-to :
 references; s=corp-2018-07-02;
 bh=rxloVUR5hTpog4EkfpKEBfCxP1GI1EsadkVaOQCjD2o=;
 b=1CYkyUJc4Qs2o0butOq1ThTUw0aGOHhtGvgscR/9iH/yWacmRM01oZvKfD4Gt31YBLEM
 ce9ixyvlKWNm/xwoNnMIWXjHRhkJlHhKG7fBtz1G2ss13MtAzB1P+0ZMGeWdtgi4T0dq
 dIcMgf+jX0Jelv8dbvcLwmQz2WNq6a2d+1eNlp91l4a45r45cp5GH4GY4pnQpLkQv2wb
 VcVhVfb4sHJ3GpJ9krKLY7oSD+xhZEwYCYbOWVMEhq0EL+RRT4bkWE+i9wcDPueGbJ7B
 P7HJ8t2860x1dpq4pYilUvGWzzNx1DUnQxLD7dk3BC/9AkpMY9iRoAeGOYUL8Cme3mQO kA== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2ptn7r9f34-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Jan 2019 21:10:17 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x0ALAHxT008490
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Jan 2019 21:10:17 GMT
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x0ALAGV0022904;
        Thu, 10 Jan 2019 21:10:16 GMT
Received: from concerto.internal (/24.9.64.241)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 10 Jan 2019 13:10:15 -0800
From:   Khalid Aziz <khalid.aziz@oracle.com>
To:     juergh@gmail.com, tycho@tycho.ws, jsteckli@amazon.de,
        ak@linux.intel.com, torvalds@linux-foundation.org,
        liran.alon@oracle.com, keescook@google.com, konrad.wilk@oracle.com
Cc:     Tycho Andersen <tycho@docker.com>, deepa.srinivasan@oracle.com,
        chris.hyser@oracle.com, tyhicks@canonical.com, dwmw@amazon.co.uk,
        andrew.cooper3@citrix.com, jcm@redhat.com,
        boris.ostrovsky@oracle.com, kanth.ghatraju@oracle.com,
        joao.m.martins@oracle.com, jmattson@google.com,
        pradeep.vincent@oracle.com, john.haxby@oracle.com,
        tglx@linutronix.de, kirill.shutemov@linux.intel.com, hch@lst.de,
        steven.sistare@oracle.com, kernel-hardening@lists.openwall.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org, x86@kernel.org,
        Khalid Aziz <khalid.aziz@oracle.com>
Subject: [RFC PATCH v7 02/16] x86: always set IF before oopsing from page fault
Date:   Thu, 10 Jan 2019 14:09:34 -0700
Message-Id: <46b0f1a61dabf6440d461c063a32573b96f3a5ce.1547153058.git.khalid.aziz@oracle.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1547153058.git.khalid.aziz@oracle.com>
References: <cover.1547153058.git.khalid.aziz@oracle.com>
In-Reply-To: <cover.1547153058.git.khalid.aziz@oracle.com>
References: <cover.1547153058.git.khalid.aziz@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9132 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=953
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901100164
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tycho Andersen <tycho@docker.com>

Oopsing might kill the task, via rewind_stack_do_exit() at the bottom, and
that might sleep:

Aug 23 19:30:27 xpfo kernel: [   38.302714] BUG: sleeping function called from invalid context at ./include/linux/percpu-rwsem.h:33
Aug 23 19:30:27 xpfo kernel: [   38.303837] in_atomic(): 0, irqs_disabled(): 1, pid: 1970, name: lkdtm_xpfo_test
Aug 23 19:30:27 xpfo kernel: [   38.304758] CPU: 3 PID: 1970 Comm: lkdtm_xpfo_test Tainted: G      D         4.13.0-rc5+ #228
Aug 23 19:30:27 xpfo kernel: [   38.305813] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.1-1ubuntu1 04/01/2014
Aug 23 19:30:27 xpfo kernel: [   38.306926] Call Trace:
Aug 23 19:30:27 xpfo kernel: [   38.307243]  dump_stack+0x63/0x8b
Aug 23 19:30:27 xpfo kernel: [   38.307665]  ___might_sleep+0xec/0x110
Aug 23 19:30:27 xpfo kernel: [   38.308139]  __might_sleep+0x45/0x80
Aug 23 19:30:27 xpfo kernel: [   38.308593]  exit_signals+0x21/0x1c0
Aug 23 19:30:27 xpfo kernel: [   38.309046]  ? blocking_notifier_call_chain+0x11/0x20
Aug 23 19:30:27 xpfo kernel: [   38.309677]  do_exit+0x98/0xbf0
Aug 23 19:30:27 xpfo kernel: [   38.310078]  ? smp_reader+0x27/0x40 [lkdtm]
Aug 23 19:30:27 xpfo kernel: [   38.310604]  ? kthread+0x10f/0x150
Aug 23 19:30:27 xpfo kernel: [   38.311045]  ? read_user_with_flags+0x60/0x60 [lkdtm]
Aug 23 19:30:27 xpfo kernel: [   38.311680]  rewind_stack_do_exit+0x17/0x20

To be safe, let's just always enable irqs.

The particular case I'm hitting is:

Aug 23 19:30:27 xpfo kernel: [   38.278615]  __bad_area_nosemaphore+0x1a9/0x1d0
Aug 23 19:30:27 xpfo kernel: [   38.278617]  bad_area_nosemaphore+0xf/0x20
Aug 23 19:30:27 xpfo kernel: [   38.278618]  __do_page_fault+0xd1/0x540
Aug 23 19:30:27 xpfo kernel: [   38.278620]  ? irq_work_queue+0x9b/0xb0
Aug 23 19:30:27 xpfo kernel: [   38.278623]  ? wake_up_klogd+0x36/0x40
Aug 23 19:30:27 xpfo kernel: [   38.278624]  trace_do_page_fault+0x3c/0xf0
Aug 23 19:30:27 xpfo kernel: [   38.278625]  do_async_page_fault+0x14/0x60
Aug 23 19:30:27 xpfo kernel: [   38.278627]  async_page_fault+0x28/0x30

When a fault is in kernel space which has been triggered by XPFO.

Signed-off-by: Tycho Andersen <tycho@docker.com>
CC: x86@kernel.org
Signed-off-by: Khalid Aziz <khalid.aziz@oracle.com>
---
 arch/x86/mm/fault.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 71d4b9d4d43f..ba51652fbd33 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -748,6 +748,12 @@ no_context(struct pt_regs *regs, unsigned long error_code,
 	/* Executive summary in case the body of the oops scrolled away */
 	printk(KERN_DEFAULT "CR2: %016lx\n", address);
 
+	/*
+	 * We're about to oops, which might kill the task. Make sure we're
+	 * allowed to sleep.
+	 */
+	flags |= X86_EFLAGS_IF;
+
 	oops_end(flags, regs, sig);
 }
 
-- 
2.17.1

