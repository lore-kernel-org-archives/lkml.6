Return-Path: <>
X-Google-Smtp-Source: AB8JxZrmeGMdpXMKzwD8BFgkr7ZwPkg3akTD6CA2HFlfpj+7HdsSReD8ROa3kKI3aEHSrs+MHkV2
ARC-Seal: i=1; a=rsa-sha256; t=1524354930; cv=none;
        d=google.com; s=arc-20160816;
        b=SwdY3xl38/Mrzj7yKDaxPUp1VYu8Sayj555OqgViKsDX3oIdBoyNuoKgVluJOx86LD
         YQ3bBUDFMYAVvXMsivM0bmHb9AzWNuZaWCNephsGKG9rNgdWGf7Iiyb1RsZuu2w2k02K
         t83tQIzDtOKNV6IQEBRNU6cayUOpkPk1It3fKy7XC5d30N+rlx8TM7GJvP3shzsYSe6E
         aBectDg/CLg44Y72sFiUJYnP7yS9mLZNOD57XHmeiBMpmPCr3h5VVa8vOLhlXgrc0o4C
         SV6LZVQcYQWiry1kZ0j2SV4a8kMi2B3zjDa5bBaZgAIK62WgJ55P8kxs986nSRuo0ZRJ
         y5wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=sIOAfUp+ar7ZwiaRVKK2YplBnKtdEikdu0ez8sBeK+E=;
        b=tcqDwY22ErI+fPtONMDUGV4xwLlZGaQQhhXOTel4Ll4sxGGWxJGuNMNc9onGXHIe2p
         bimmdqMwjx2papP5EDvqEN61OuzzL7n/4RXDUn351KE1kdChIit6Zm3CBkMBnJcLyIQT
         +BkmDukGzIlWhvZK5XcdvY7eqrMeEx89EZBN5bp0D13ATukX7CXKM2ZztozduLz5rDaW
         Hgdes1Sz7BPUK1efey3UVmS67okG90aHjmTIbug4i+C9HH3oq9BreoOdjTGiTCvbePwd
         QOTInM6KZF5GOR/wTkZxv8NjsOLZGyV3gs74xaRUp2jVjEsbsgFzQdJgVVnenghPMY6B
         ce+w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@ti.com header.s=ti-com-17Q1 header.b=SpFmZ07V;
       spf=pass (google.com: best guess record for domain of postmaster@lelnx194.ext.ti.com designates 198.47.27.80 as permitted sender) smtp.helo=lelnx194.ext.ti.com;
       dmarc=pass (p=QUARANTINE sp=NONE dis=NONE) header.from=ti.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@ti.com header.s=ti-com-17Q1 header.b=SpFmZ07V;
       spf=pass (google.com: best guess record for domain of postmaster@lelnx194.ext.ti.com designates 198.47.27.80 as permitted sender) smtp.helo=lelnx194.ext.ti.com;
       dmarc=pass (p=QUARANTINE sp=NONE dis=NONE) header.from=ti.com
From: "Andrew F. Davis" <afd@ti.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: <linux-kernel@vger.kernel.org>, "Andrew F . Davis" <afd@ti.com>
Subject: [PATCH] rpmsg: Correct support for MODULE_DEVICE_TABLE()
Date: Sat, 21 Apr 2018 18:55:29 -0500
Message-ID: <20180421235529.17243-1-afd@ti.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598401995374666421?=
X-GMAIL-MSGID: =?utf-8?q?1598401995374666421?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Due to missing a missing entry in file2alias.c MODULE_DEVICE_TABLE() are
not generating the proper module aliases. Add the needed entry here.

Fixes: bcabbccabffe ("rpmsg: add virtio-based remote processor messaging bus")
Reported-by: Suman Anna <s-anna@ti.com>
Signed-off-by: Andrew F. Davis <afd@ti.com>
---
 scripts/mod/devicetable-offsets.c |  3 +++
 scripts/mod/file2alias.c          | 11 +++++++++++
 2 files changed, 14 insertions(+)

diff --git a/scripts/mod/devicetable-offsets.c b/scripts/mod/devicetable-offsets.c
index 9fad6afe4c41..6667f7b491d6 100644
--- a/scripts/mod/devicetable-offsets.c
+++ b/scripts/mod/devicetable-offsets.c
@@ -139,6 +139,9 @@ int main(void)
 	DEVID(hv_vmbus_device_id);
 	DEVID_FIELD(hv_vmbus_device_id, guid);
 
+	DEVID(rpmsg_device_id);
+	DEVID_FIELD(rpmsg_device_id, name);
+
 	DEVID(i2c_device_id);
 	DEVID_FIELD(i2c_device_id, name);
 
diff --git a/scripts/mod/file2alias.c b/scripts/mod/file2alias.c
index b9beeaa4695b..52fd54a8fe39 100644
--- a/scripts/mod/file2alias.c
+++ b/scripts/mod/file2alias.c
@@ -944,6 +944,17 @@ static int do_vmbus_entry(const char *filename, void *symval,
 }
 ADD_TO_DEVTABLE("vmbus", hv_vmbus_device_id, do_vmbus_entry);
 
+/* Looks like: rpmsg:S */
+static int do_rpmsg_entry(const char *filename, void *symval,
+			  char *alias)
+{
+	DEF_FIELD_ADDR(symval, rpmsg_device_id, name);
+	sprintf(alias, RPMSG_DEVICE_MODALIAS_FMT, *name);
+
+	return 1;
+}
+ADD_TO_DEVTABLE("rpmsg", rpmsg_device_id, do_rpmsg_entry);
+
 /* Looks like: i2c:S */
 static int do_i2c_entry(const char *filename, void *symval,
 			char *alias)
-- 
2.17.0
