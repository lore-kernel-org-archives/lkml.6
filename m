Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AA2AC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 06:30:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9127204EC
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 06:30:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=aepfle.de header.i=@aepfle.de header.b="ffCahTeD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9127204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aepfle.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727568AbeIGLJz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 07:09:55 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.54]:13588 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbeIGLJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 07:09:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1536301826;
        s=strato-dkim-0002; d=aepfle.de;
        h=Message-Id:Date:Subject:Cc:To:From:X-RZG-CLASS-ID:X-RZG-AUTH:From:
        Subject:Sender;
        bh=cwEJ9C8V6KAN2Ttw1o9DQLmvSmDwpPXA3xq2qVepOkM=;
        b=ffCahTeDft1nuzwN9V4VT0UoGZRJrN3iK0QaQb8TrwUnp17t2QylMWMwc6uH+yQQ3y
        V1hJ1k6qoEPyLUTp75EIqrhHAJtIdCnwNZGEJEIQrolciCGMq9/vdAJmTR+u+f2b/Ogr
        mYB8jPul8gQe2Ok+9GVtdxN5Dk56Jk5ktjQ94BlhPN+zhhAOCJqTMGapvzH71dZzmAlq
        nA/cL9D5A7m7vDjv1mHfRyFtsnUGF12Jg2Q/qvKp6sBqnWS0uJdNPzCcTDth27Pjco+j
        RaId4NjV8GZG0CN33JqpedAwm8LDvpNT2G+GmYJTNsZGtUFGhO3jKBy1ZERZnD45lf5b
        JYyw==
X-RZG-AUTH: ":P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QXkBR9MXjAuzpIG0mv9coXAgc0/lb4QMstw0mqi/C51hpW50R4vli8caicjAbM"
X-RZG-CLASS-ID: mo00
Received: from sender
        by smtp.strato.de (RZmta 44.0 AUTH)
        with ESMTPSA id L0862bu876UPD8e
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Fri, 7 Sep 2018 08:30:25 +0200 (CEST)
From:   Olaf Hering <olaf@aepfle.de>
To:     xen-devel@lists.xenproject.org
Cc:     Olaf Hering <olaf@aepfle.de>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3] xen: avoid crash in disable_hotplug_cpu
Date:   Fri,  7 Sep 2018 08:30:23 +0200
Message-Id: <20180907063023.16913-1-olaf@aepfle.de>
X-Mailer: git-send-email 2.16.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The command 'xl vcpu-set 0 0', issued in dom0, will crash dom0:

BUG: unable to handle kernel NULL pointer dereference at 00000000000002d8
PGD 0 P4D 0
Oops: 0000 [#1] PREEMPT SMP NOPTI
CPU: 7 PID: 65 Comm: xenwatch Not tainted 4.19.0-rc2-1.ga9462db-default #1 openSUSE Tumbleweed (unreleased)
Hardware name: Intel Corporation S5520UR/S5520UR, BIOS S5500.86B.01.00.0050.050620101605 05/06/2010
RIP: e030:device_offline+0x9/0xb0
Code: 77 24 00 e9 ce fe ff ff 48 8b 13 e9 68 ff ff ff 48 8b 13 e9 29 ff ff ff 48 8b 13 e9 ea fe ff ff 90 66 66 66 66 90 41 54 55 53 <f6> 87 d8 02 00 00 01 0f 85 88 00 00 00 48 c7 c2 20 09 60 81 31 f6
RSP: e02b:ffffc90040f27e80 EFLAGS: 00010203
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffff8801f3800000 RSI: ffffc90040f27e70 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffff820e47b3 R09: 0000000000000000
R10: 0000000000007ff0 R11: 0000000000000000 R12: ffffffff822e6d30
R13: dead000000000200 R14: dead000000000100 R15: ffffffff8158b4e0
FS:  00007ffa595158c0(0000) GS:ffff8801f39c0000(0000) knlGS:0000000000000000
CS:  e033 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000000002d8 CR3: 00000001d9602000 CR4: 0000000000002660
Call Trace:
 handle_vcpu_hotplug_event+0xb5/0xc0
 xenwatch_thread+0x80/0x140
 ? wait_woken+0x80/0x80
 kthread+0x112/0x130
 ? kthread_create_worker_on_cpu+0x40/0x40
 ret_from_fork+0x3a/0x50

This happens because handle_vcpu_hotplug_event is called twice. In the
first iteration cpu_present is still true, in the second iteration
cpu_present is false which causes get_cpu_device to return NULL.
In case of cpu#0, cpu_online is apparently always true.

Fix this crash by checking if the cpu can be hotplugged, which is false
for a cpu that was just removed.

Also check if the cpu was actually offlined by device_remove, otherwise
leave the cpu_present state as it is.

Signed-off-by: Olaf Hering <olaf@aepfle.de>
---
 drivers/xen/cpu_hotplug.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/xen/cpu_hotplug.c b/drivers/xen/cpu_hotplug.c
index d4265c8ebb22..68f9f663da08 100644
--- a/drivers/xen/cpu_hotplug.c
+++ b/drivers/xen/cpu_hotplug.c
@@ -19,11 +19,15 @@ static void enable_hotplug_cpu(int cpu)
 
 static void disable_hotplug_cpu(int cpu)
 {
+	if (!cpu_is_hotpluggable(cpu))
+		return;
 	if (cpu_online(cpu)) {
 		lock_device_hotplug();
 		device_offline(get_cpu_device(cpu));
 		unlock_device_hotplug();
 	}
+	if (cpu_online(cpu))
+		return;
 	if (cpu_present(cpu))
 		xen_arch_unregister_cpu(cpu);
 
