Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752627AbeDLBlI (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 21:41:08 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:14445 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751870AbeDLBlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 21:41:07 -0400
X-IronPort-AV: E=Sophos;i="5.43,368,1503331200";
   d="scan'208";a="38797416"
From: Dou Liyang <douly.fnst@cn.fujitsu.com>
To: <x86@kernel.org>, <linux-kernel@vger.kernel.org>
CC: <tglx@linutronix.de>, <mingo@redhat.com>, <hpa@zytor.com>,
        <rjw@rjwysocki.net>, <len.brown@intel.com>,
        Dou Liyang <douly.fnst@cn.fujitsu.com>
Subject: [PATCH] x86/acpi: Prevent X2APIC id 0xffffffff from being accounted
Date: Thu, 12 Apr 2018 09:40:52 +0800
Message-ID: <20180412014052.25186-1-douly.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 2.14.3
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.167.226.106]
X-yoursite-MailScanner-ID: 864464724003.A6C74
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: douly.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RongQing reported that there are some X2APIC id 0xffffffff in his machine's
ACPI MADT table, which made the number of possible CPU inaccuracy.

The reason is that the ACPI X2APIC parser has no sanity check for
apicid 0xffffffff, which is an invalid id in all APIC types. See
"Intel® 64 Architecture x2APIC Specification", Chapter 2.4.1.

Add a sanity check to acpi_parse_x2apic() which ignores the invalid id.

Reported-by: Li RongQing <lirongqing@baidu.com>
Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
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
-- 
2.14.3
