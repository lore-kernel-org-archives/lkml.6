Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752231AbeDQKBb (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 06:01:31 -0400
Received: from terminus.zytor.com ([198.137.202.136]:42987 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751810AbeDQKBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 06:01:30 -0400
Date: Tue, 17 Apr 2018 03:00:59 -0700
From: tip-bot for Dou Liyang <tipbot@zytor.com>
Message-ID: <tip-10daf10ab154e31237a8c07242be3063fb6a9bf4@git.kernel.org>
Cc: hpa@zytor.com, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        lirongqing@baidu.com, mingo@kernel.org, douly.fnst@cn.fujitsu.com
Reply-To: douly.fnst@cn.fujitsu.com, mingo@kernel.org, lirongqing@baidu.com,
        hpa@zytor.com, tglx@linutronix.de, linux-kernel@vger.kernel.org
In-Reply-To: <20180412014052.25186-1-douly.fnst@cn.fujitsu.com>
References: <20180412014052.25186-1-douly.fnst@cn.fujitsu.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/acpi: Prevent X2APIC id 0xffffffff from being
 accounted
Git-Commit-ID: 10daf10ab154e31237a8c07242be3063fb6a9bf4
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

Commit-ID:  10daf10ab154e31237a8c07242be3063fb6a9bf4
Gitweb:     https://git.kernel.org/tip/10daf10ab154e31237a8c07242be3063fb6a9bf4
Author:     Dou Liyang <douly.fnst@cn.fujitsu.com>
AuthorDate: Thu, 12 Apr 2018 09:40:52 +0800
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 17 Apr 2018 11:56:31 +0200

x86/acpi: Prevent X2APIC id 0xffffffff from being accounted

RongQing reported that there are some X2APIC id 0xffffffff in his machine's
ACPI MADT table, which makes the number of possible CPU inaccurate.

The reason is that the ACPI X2APIC parser has no sanity check for APIC ID
0xffffffff, which is an invalid id in all APIC types. See "Intel® 64
Architecture x2APIC Specification", Chapter 2.4.1.

Add a sanity check to acpi_parse_x2apic() which ignores the invalid id.

Reported-by: Li RongQing <lirongqing@baidu.com>
Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Cc: len.brown@intel.com
Cc: rjw@rjwysocki.net
Cc: hpa@zytor.com
Link: https://lkml.kernel.org/r/20180412014052.25186-1-douly.fnst@cn.fujitsu.com

---
 arch/x86/kernel/acpi/boot.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index dde444f932c1..3b20607d581b 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -215,6 +215,10 @@ acpi_parse_x2apic(struct acpi_subtable_header *header, const unsigned long end)
 	apic_id = processor->local_apic_id;
 	enabled = processor->lapic_flags & ACPI_MADT_ENABLED;
 
+	/* Ignore invalid ID */
+	if (apic_id == 0xffffffff)
+		return 0;
+
 	/*
 	 * We need to register disabled CPU as well to permit
 	 * counting disabled CPUs. This allows us to size
