Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933906AbeD0PMa (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 11:12:30 -0400
Received: from terminus.zytor.com ([198.137.202.136]:53515 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933750AbeD0PMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 11:12:16 -0400
Date: Fri, 27 Apr 2018 08:09:44 -0700
From: tip-bot for Petr Tesarik <tipbot@zytor.com>
Message-ID: <tip-3db3eb285259ac129f7aec6b814b3e9f6c1b372b@git.kernel.org>
Cc: ptesarik@suse.cz, thomas.lendacky@amd.com, boris.ostrovsky@oracle.com,
        mpatocka@redhat.com, tglx@linutronix.de, jgross@suse.com,
        luto@kernel.org, ptesarik@suse.com, linux-kernel@vger.kernel.org,
        douly.fnst@cn.fujitsu.com, mingo@kernel.org, jdelvare@suse.de,
        hpa@zytor.com, bp@suse.de
Reply-To: ptesarik@suse.com, linux-kernel@vger.kernel.org,
        douly.fnst@cn.fujitsu.com, mingo@kernel.org, jdelvare@suse.de,
        hpa@zytor.com, bp@suse.de, thomas.lendacky@amd.com, ptesarik@suse.cz,
        boris.ostrovsky@oracle.com, mpatocka@redhat.com, tglx@linutronix.de,
        jgross@suse.com, luto@kernel.org
In-Reply-To: <20180425120835.23cef60c@ezekiel.suse.cz>
References: <20180425120835.23cef60c@ezekiel.suse.cz>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/setup: Do not reserve a crash kernel region if
 booted on Xen PV
Git-Commit-ID: 3db3eb285259ac129f7aec6b814b3e9f6c1b372b
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  3db3eb285259ac129f7aec6b814b3e9f6c1b372b
Gitweb:     https://git.kernel.org/tip/3db3eb285259ac129f7aec6b814b3e9f6c1b372b
Author:     Petr Tesarik <ptesarik@suse.cz>
AuthorDate: Wed, 25 Apr 2018 12:08:35 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 27 Apr 2018 17:06:28 +0200

x86/setup: Do not reserve a crash kernel region if booted on Xen PV

Xen PV domains cannot shut down and start a crash kernel. Instead,
the crashing kernel makes a SCHEDOP_shutdown hypercall with the
reason code SHUTDOWN_crash, cf. xen_crash_shutdown() machine op in
arch/x86/xen/enlighten_pv.c.

A crash kernel reservation is merely a waste of RAM in this case. It
may also confuse users of kexec_load(2) and/or kexec_file_load(2).
When flags include KEXEC_ON_CRASH or KEXEC_FILE_ON_CRASH,
respectively, these syscalls return success, which is technically
correct, but the crash kexec image will never be actually used.

Signed-off-by: Petr Tesarik <ptesarik@suse.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Juergen Gross <jgross@suse.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Dou Liyang <douly.fnst@cn.fujitsu.com>
Cc: Mikulas Patocka <mpatocka@redhat.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: xen-devel@lists.xenproject.org
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Borislav Petkov <bp@suse.de>
Cc: Jean Delvare <jdelvare@suse.de>
Link: https://lkml.kernel.org/r/20180425120835.23cef60c@ezekiel.suse.cz

---
 arch/x86/kernel/setup.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 6285697b6e56..5c623dfe39d1 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -50,6 +50,7 @@
 #include <linux/init_ohci1394_dma.h>
 #include <linux/kvm_para.h>
 #include <linux/dma-contiguous.h>
+#include <xen/xen.h>
 
 #include <linux/errno.h>
 #include <linux/kernel.h>
@@ -534,6 +535,11 @@ static void __init reserve_crashkernel(void)
 		high = true;
 	}
 
+	if (xen_pv_domain()) {
+		pr_info("Ignoring crashkernel for a Xen PV domain\n");
+		return;
+	}
+
 	/* 0 means: find the address automatically */
 	if (crash_base <= 0) {
 		/*
