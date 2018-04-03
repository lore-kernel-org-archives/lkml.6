Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752774AbeDCRJM (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 13:09:12 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:44242 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752622AbeDCRIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 13:08:53 -0400
X-Google-Smtp-Source: AIpwx487ME9ASyz5rGwXJvhEiQq9YUjf6YT/hNgIjwLF+fO3b80aGB029TuHIm9rZAOU0MtWLTuQwA==
From: Alexandru Gagniuc <mr.nuke.me@gmail.com>
To: linux-acpi@vger.kernel.org
Cc: rjw@rjwysocki.net, lenb@kernel.org, tony.luck@intel.com, bp@alien8.de,
        tbaicar@codeaurora.org, will.deacon@arm.com, james.morse@arm.com,
        shiju.jose@huawei.com, zjzhang@codeaurora.org, gengdongjiu@huawei.com,
        linux-kernel@vger.kernel.org, alex_gagniuc@dellteam.com,
        austin_bolen@dell.com, shyam_iyer@dell.com,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>
Subject: [RFC PATCH 4/4] acpi: apei: Warn when GHES marks correctable errors as "fatal"
Date: Tue,  3 Apr 2018 12:08:30 -0500
Message-Id: <20180403170830.29282-5-mr.nuke.me@gmail.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180403170830.29282-1-mr.nuke.me@gmail.com>
References: <20180403170830.29282-1-mr.nuke.me@gmail.com>
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
 drivers/acpi/apei/ghes.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 7243a99ea57e..d9123c5fa3d9 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -521,6 +521,11 @@ static int ghes_do_proc(struct ghes *ghes,
 
 		corrected_sev = max(corrected_sev, sec_sev);
 	}
+
+	if ((sev >= GHES_SEV_PANIC) && (corrected_sev < sev)) {
+		pr_warn("FIRMWARE BUG: Firmware sent fatal error that we were able to correct");
+		pr_warn("BROKEN FIRMWARE: Complain to your hardware vendor");
+	}
 
 	return corrected_sev;
 }
-- 
2.14.3
