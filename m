Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751693AbeDYUkf (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 16:40:35 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:37273 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751022AbeDYUka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 16:40:30 -0400
X-Google-Smtp-Source: AIpwx4/C6W2BlK2ApE7xWm/sPuwmE6bA5UXJvjbRp4bub+eU08r5LLlmsOtSE2fTMMZxqrOrju9qdQ==
From: Alexandru Gagniuc <mr.nuke.me@gmail.com>
To: linux-acpi@vger.kernel.org, linux-edac@vger.kernel.org
Cc: Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>,
        Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Erik Schmauss <erik.schmauss@intel.com>,
        Tyler Baicar <tbaicar@codeaurora.org>,
        Will Deacon <will.deacon@arm.com>, James Morse <james.morse@arm.com>,
        Shiju Jose <shiju.jose@huawei.com>,
        "Jonathan (Zhixiong) Zhang" <zjzhang@codeaurora.org>,
        Dongjiu Geng <gengdongjiu@huawei.com>, linux-kernel@vger.kernel.org,
        devel@acpica.org
Subject: [RFC PATCH v3 3/3] acpi: apei: Warn when GHES marks correctable errors as "fatal"
Date: Wed, 25 Apr 2018 15:39:51 -0500
Message-Id: <20180425203957.18224-4-mr.nuke.me@gmail.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180425203957.18224-1-mr.nuke.me@gmail.com>
References: <20180416215903.7318-1-mr.nuke.me@gmail.com>
 <20180425203957.18224-1-mr.nuke.me@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There seems to be a culture amongst BIOS teams to want to crash the
OS when an error can't be handled in firmware. Marking GHES errors as
"fatal" is a very common way to do this.

However, a number of errors reported by GHES may be fatal in the sense
a device or link is lost, but are not fatal to the system. When there
is a disagreement with firmware about the handleability of an error,
print a warning message.

Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
---
 drivers/acpi/apei/ghes.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 8ccb9cc10fc8..34d0da692dd0 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -539,6 +539,12 @@ static void ghes_do_proc(struct ghes *ghes,
 					       sec_sev, err,
 					       gdata->error_data_length);
 		}
+
+	}
+
+	if ((sev >= GHES_SEV_PANIC) && (ghes_actual_severity(ghes) < sev)) {
+		pr_warn("FIRMWARE BUG: Firmware sent fatal error that we were able to correct");
+		pr_warn("BROKEN FIRMWARE: Complain to your hardware vendor");
 	}
 }
 
-- 
2.14.3
