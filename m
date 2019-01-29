Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E2ACC282C7
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 12:03:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF0E420880
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 12:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548763383;
	bh=jkFoBsBlqrwLYn/0lSb7x7cGrG8WKG8hIuF0o0u1Opg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=H8AejGLSYiP2WWYsVEXkNW+ZCbYfrAejRKz3hyopzrFT7FbbL4hHlqvRzNmmRykQo
	 2LRDEzJreXspV6w0CMlHszjDg9he7ECAU7iyqmyTaWRWNoJzpWPRNmlCnhNylzGCNC
	 y92mo1iV4Qgu2uHmvy/FlEXExmd4j/9aaXBYTfp0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730511AbfA2LoO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:44:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:34378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730496AbfA2LoJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:44:09 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 649B32083B;
        Tue, 29 Jan 2019 11:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548762248;
        bh=jkFoBsBlqrwLYn/0lSb7x7cGrG8WKG8hIuF0o0u1Opg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NAKWtnhMSe6rdTPgE5OF8Cy5KZman0VJEVoumcwO1LRYkKVqdeZA/kEtX8s1mMw5B
         7ErPy8xc3kcrQAgYlb+jFdO6ECQ5KBKF2yVA+DpaBrOf7lbhC8TgtMK3kHPLO2EBEr
         iFsOub+ckR2LndLhA0VpzWXlP3XcVrIlF/z4RNvk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [PATCH 4.19 041/103] s390/smp: fix CPU hotplug deadlock with CPU rescan
Date:   Tue, 29 Jan 2019 12:35:18 +0100
Message-Id: <20190129113201.963851972@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129113159.567154026@linuxfoundation.org>
References: <20190129113159.567154026@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gerald Schaefer <gerald.schaefer@de.ibm.com>

commit b7cb707c373094ce4008d4a6ac9b6b366ec52da5 upstream.

smp_rescan_cpus() is called without the device_hotplug_lock, which can lead
to a dedlock when a new CPU is found and immediately set online by a udev
rule.

This was observed on an older kernel version, where the cpu_hotplug_begin()
loop was still present, and it resulted in hanging chcpu and systemd-udev
processes. This specific deadlock will not show on current kernels. However,
there may be other possible deadlocks, and since smp_rescan_cpus() can still
trigger a CPU hotplug operation, the device_hotplug_lock should be held.

For reference, this was the deadlock with the old cpu_hotplug_begin() loop:

        chcpu (rescan)                       systemd-udevd

 echo 1 > /sys/../rescan
 -> smp_rescan_cpus()
 -> (*) get_online_cpus()
    (increases refcount)
 -> smp_add_present_cpu()
    (new CPU found)
 -> register_cpu()
 -> device_add()
 -> udev "add" event triggered -----------> udev rule sets CPU online
                                         -> echo 1 > /sys/.../online
                                         -> lock_device_hotplug_sysfs()
                                            (this is missing in rescan path)
                                         -> device_online()
                                         -> (**) device_lock(new CPU dev)
                                         -> cpu_up()
                                         -> cpu_hotplug_begin()
                                            (loops until refcount == 0)
                                            -> deadlock with (*)
 -> bus_probe_device()
 -> device_attach()
 -> device_lock(new CPU dev)
    -> deadlock with (**)

Fix this by taking the device_hotplug_lock in the CPU rescan path.

Cc: <stable@vger.kernel.org>
Signed-off-by: Gerald Schaefer <gerald.schaefer@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/s390/kernel/smp.c          |    4 ++++
 drivers/s390/char/sclp_config.c |    2 ++
 2 files changed, 6 insertions(+)

--- a/arch/s390/kernel/smp.c
+++ b/arch/s390/kernel/smp.c
@@ -1152,7 +1152,11 @@ static ssize_t __ref rescan_store(struct
 {
 	int rc;
 
+	rc = lock_device_hotplug_sysfs();
+	if (rc)
+		return rc;
 	rc = smp_rescan_cpus();
+	unlock_device_hotplug();
 	return rc ? rc : count;
 }
 static DEVICE_ATTR_WO(rescan);
--- a/drivers/s390/char/sclp_config.c
+++ b/drivers/s390/char/sclp_config.c
@@ -60,7 +60,9 @@ static void sclp_cpu_capability_notify(s
 
 static void __ref sclp_cpu_change_notify(struct work_struct *work)
 {
+	lock_device_hotplug();
 	smp_rescan_cpus();
+	unlock_device_hotplug();
 }
 
 static void sclp_conf_receiver_fn(struct evbuf_header *evbuf)


