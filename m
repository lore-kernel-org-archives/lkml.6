Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81D3AC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 15:15:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5966220989
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 15:15:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731473AbfA3PPH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 10:15:07 -0500
Received: from proxy03.fsdata.se ([89.221.252.213]:61270 "EHLO
        mail-gw01.fsdata.se" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726332AbfA3PPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 10:15:07 -0500
Received: from localhost (94.234.42.28) by DAG01.HMC.local (192.168.46.11)
 with Microsoft SMTP Server (TLS) id 15.0.1263.5; Wed, 30 Jan 2019 16:14:56
 +0100
From:   Mattias Jacobsson <2pi@mok.nu>
To:     <yamada.masahiro@socionext.com>, <michal.lkml@markovi.net>,
        <dvhart@infradead.org>, <andy@infradead.org>,
        <pali.rohar@gmail.com>
CC:     <2pi@mok.nu>, <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 2/3] platform/x86: wmi: add WMI support to MODULE_DEVICE_TABLE()
Date:   Wed, 30 Jan 2019 16:14:39 +0100
Message-ID: <ae59210f24d66516a0af38c03fd0da923dd0e7da.1548860212.git.2pi@mok.nu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1548860212.git.2pi@mok.nu>
References: <cover.1548860212.git.2pi@mok.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [94.234.42.28]
X-ClientProxiedBy: PROXY04.HMC.local (192.168.46.54) To DAG01.HMC.local
 (192.168.46.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel provides the macro MODULE_DEVICE_TABLE() where driver authors
can specify their device type and their array of device_ids and thereby
trigger the generation of the appropriate MODULE_ALIAS() output. This is
opposed to having to specify one MODULE_ALIAS() for each device. The WMI
device type is currently not supported.

While using MODULE_DEVICE_TABLE() does increase the complexity as well
as spreading out the implementation across the kernel, it does come with
some benefits too;
* It makes different drivers look more similar; if you can specify the
  array of device_ids any device type specific input to MODULE_ALIAS()
  will automatically be generated for you.
* It helps each driver avoid keeping multiple versions of the same
  information in sync. That is, both the array of device_ids and the
  potential multitude of MODULE_ALIAS()'s.

Add WMI support to MODULE_DEVICE_TABLE() by adding info about struct
wmi_device_id in devicetable-offsets.c and add a WMI entry point in
file2alias.c.

The type argument for MODULE_DEVICE_TABLE(type, name) is wmi.

Suggested-by: Pali Rohár <pali.rohar@gmail.com>
Signed-off-by: Mattias Jacobsson <2pi@mok.nu>
---

What do you think about this usage of snprintf()? Now we check if there
is an error or if the printed string tried to exceeded the buffer.
Ideally 500 should be a macro or a parameter, but there isn't one
available. The number 500 comes from a few lines below in the function
do_table().

 scripts/mod/devicetable-offsets.c |  3 +++
 scripts/mod/file2alias.c          | 22 ++++++++++++++++++++++
 2 files changed, 25 insertions(+)

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
index a37af7d71973..abaa6c090564 100644
--- a/scripts/mod/file2alias.c
+++ b/scripts/mod/file2alias.c
@@ -37,6 +37,7 @@ typedef unsigned char	__u8;
 typedef struct {
 	__u8 b[16];
 } uuid_le;
+#define	UUID_STRING_LEN		36
 
 /* Big exception to the "don't include kernel headers into userspace, which
  * even potentially has different endianness and word sizes, since
@@ -1287,6 +1288,26 @@ static int do_typec_entry(const char *filename, void *symval, char *alias)
 	return 1;
 }
 
+/* Looks like: wmi:guid */
+static int do_wmi_entry(const char *filename, void *symval, char *alias)
+{
+	DEF_FIELD_ADDR(symval, wmi_device_id, guid_string);
+	if (strlen(*guid_string) != UUID_STRING_LEN) {
+		warn("Invalid WMI device id 'wmi:%s' in '%s'\n",
+				*guid_string, filename);
+		return 0;
+	}
+
+	int len = snprintf(alias, 500, WMI_MODULE_PREFIX "%s", *guid_string);
+
+	if (len < 0 || len >= 500) {
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
@@ -1357,6 +1378,7 @@ static const struct devtable devtable[] = {
 	{"fslmc", SIZE_fsl_mc_device_id, do_fsl_mc_entry},
 	{"tbsvc", SIZE_tb_service_id, do_tbsvc_entry},
 	{"typec", SIZE_typec_device_id, do_typec_entry},
+	{"wmi", SIZE_wmi_device_id, do_wmi_entry},
 };
 
 /* Create MODULE_ALIAS() statements.
-- 
2.20.1

