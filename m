Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9491C61CE8
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 11:56:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADBD72084C
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 11:56:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728054AbfASL4k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 06:56:40 -0500
Received: from route-level1.fsdata.se ([89.221.252.216]:30728 "EHLO
        route-level1.fsdata.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727868AbfASL4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 06:56:40 -0500
Received: from DAG01.HMC.local (192.168.46.11) by EDGE01LEVEL1.hmc.local
 (192.168.46.33) with Microsoft SMTP Server (TLS) id 15.0.847.32; Sat, 19 Jan
 2019 12:56:13 +0100
Received: from localhost (94.234.47.42) by DAG01.HMC.local (192.168.46.11)
 with Microsoft SMTP Server (TLS) id 15.0.1263.5; Sat, 19 Jan 2019 12:56:16
 +0100
From:   Mattias Jacobsson <2pi@mok.nu>
To:     <yamada.masahiro@socionext.com>, <michal.lkml@markovi.net>,
        <dvhart@infradead.org>, <andy@infradead.org>,
        <pali.rohar@gmail.com>
CC:     <2pi@mok.nu>, <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/3] platform/x86: wmi: add WMI support to MODULE_DEVICE_TABLE()
Date:   Sat, 19 Jan 2019 12:55:54 +0100
Message-ID: <ff56fb53485ec75b5e8a81f306983aa7976574c5.1547827336.git.2pi@mok.nu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1547827336.git.2pi@mok.nu>
References: <cover.1547827336.git.2pi@mok.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [94.234.47.42]
X-ClientProxiedBy: PROXY05.HMC.local (192.168.46.55) To DAG01.HMC.local
 (192.168.46.11)
Received-SPF: Neutral (EDGE01LEVEL1.hmc.local: 192.168.46.11 is neither
 permitted nor denied by domain of 2pi@mok.nu)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add WMI support to MODULE_DEVICE_TABLE() by adding info about struct
wmi_device_id in devicetable-offsets.c and add a WMI entry point in
file2alias.c.

The type argument for MODULE_DEVICE_TABLE(type, name) is wmi.

Signed-off-by: Mattias Jacobsson <2pi@mok.nu>
---

The idea of adding wmi support to MODULE_DEVICE_TABLE() originates from
a suggestion at [1]. However [2] states: "Please note that this tag
should not be added without the reporter's permission, especially if
the idea was not posted in a public forum." about the "Suggested-by:"
tag.
Pali Rohár: May I add a "Suggested-by:" tag?

[1]: https://lore.kernel.org/patchwork/patch/795892/#989423
[2]: Documentation/process/submitting-patches.rst

---
 scripts/mod/devicetable-offsets.c |  3 +++
 scripts/mod/file2alias.c          | 18 ++++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/scripts/mod/devicetable-offsets.c b/scripts/mod/devicetable-offsets.c
index 293004499b4d..99276a422e77 100644
--- a/scripts/mod/devicetable-offsets.c
+++ b/scripts/mod/devicetable-offsets.c
@@ -225,5 +225,8 @@ int main(void)
 	DEVID_FIELD(typec_device_id, svid);
 	DEVID_FIELD(typec_device_id, mode);
 
+	DEVID(wmi_device_id);
+	DEVID_FIELD(wmi_device_id, guid_string);
+
 	return 0;
 }
diff --git a/scripts/mod/file2alias.c b/scripts/mod/file2alias.c
index a37af7d71973..f014a2466ff7 100644
--- a/scripts/mod/file2alias.c
+++ b/scripts/mod/file2alias.c
@@ -1287,6 +1287,23 @@ static int do_typec_entry(const char *filename, void *symval, char *alias)
 	return 1;
 }
 
+/* Looks like: wmi:guid */
+static int do_wmi_entry(const char *filename, void *symval, char *alias)
+{
+	DEF_FIELD_ADDR(symval, wmi_device_id, guid_string);
+	if (strlen(*guid_string) != WMI_GUID_STRING_LEN) {
+		warn("Invalid WMI device id 'wmi:%s' in '%s'\n",
+				*guid_string, filename);
+		return 0;
+	}
+	if (snprintf(alias, 500, WMI_MODULE_PREFIX "%s", *guid_string) < 0) {
+		warn("Could not generate all MODULE_ALIAS's in '%s'\n",
+				filename);
+		return 0;
+	}
+	return 1;
+}
+
 /* Does namelen bytes of name exactly match the symbol? */
 static bool sym_is(const char *name, unsigned namelen, const char *symbol)
 {
@@ -1357,6 +1374,7 @@ static const struct devtable devtable[] = {
 	{"fslmc", SIZE_fsl_mc_device_id, do_fsl_mc_entry},
 	{"tbsvc", SIZE_tb_service_id, do_tbsvc_entry},
 	{"typec", SIZE_typec_device_id, do_typec_entry},
+	{"wmi", SIZE_wmi_device_id, do_wmi_entry},
 };
 
 /* Create MODULE_ALIAS() statements.
-- 
2.20.1

