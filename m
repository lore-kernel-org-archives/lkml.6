Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38BF4C677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:38:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 031D72089D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:38:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="S+HZt3g0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 031D72089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729121AbeJIBvN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 21:51:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:37940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726427AbeJIBvM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 21:51:12 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 302FC2089D;
        Mon,  8 Oct 2018 18:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539023888;
        bh=2cmyj1lopwaOIsTNUYmagnvgE3D4NnWd4iMqM3QSLkw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S+HZt3g0c0c4JeXj/CchHmTLCbaCg7RLxkkVm54lOK0MK3aQJjZQz9Uhd8gLB3hM/
         7MpK8zYxbJ06Os0iIWXqBwV0DuRMLIk0kcAOnwTszq5bOrxWmL36ghbDhLJa1P+Jdw
         lF4ZaRWWjOVcXgALazGTIFn134DhBzccSCqYqLwQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Olaf Hering <olaf@aepfle.de>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 107/113] xen: avoid crash in disable_hotplug_cpu
Date:   Mon,  8 Oct 2018 20:31:48 +0200
Message-Id: <20181008175537.206856121@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181008175530.864641368@linuxfoundation.org>
References: <20181008175530.864641368@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Olaf Hering <olaf@aepfle.de>

[ Upstream commit 3366cdb6d350d95466ee430ac50f3c8415ca8f46 ]

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

Rearrange to code to do all work with device_hotplug_lock held.

Signed-off-by: Olaf Hering <olaf@aepfle.de>
Reviewed-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/xen/cpu_hotplug.c |   15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

--- a/drivers/xen/cpu_hotplug.c
+++ b/drivers/xen/cpu_hotplug.c
@@ -18,15 +18,16 @@ static void enable_hotplug_cpu(int cpu)
 
 static void disable_hotplug_cpu(int cpu)
 {
-	if (cpu_online(cpu)) {
-		lock_device_hotplug();
+	if (!cpu_is_hotpluggable(cpu))
+		return;
+	lock_device_hotplug();
+	if (cpu_online(cpu))
 		device_offline(get_cpu_device(cpu));
-		unlock_device_hotplug();
-	}
-	if (cpu_present(cpu))
+	if (!cpu_online(cpu) && cpu_present(cpu)) {
 		xen_arch_unregister_cpu(cpu);
-
-	set_cpu_present(cpu, false);
+		set_cpu_present(cpu, false);
+	}
+	unlock_device_hotplug();
 }
 
 static int vcpu_online(unsigned int cpu)


