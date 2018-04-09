Return-Path: <kernel-hardening-return-12937-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx48kGoeQRm/ki8/tPX3x3BwPb0nnrsRKJKKwsvjtN28ePaxx2Q41V+kdxhkYdULkITJ5MAVi
ARC-Seal: i=1; a=rsa-sha256; t=1523308033; cv=none;
        d=google.com; s=arc-20160816;
        b=pIT84T63g5iIXy1DFcZ1ptTgvmV5yekkaZqLfh94Rhj6qSk/bPFAEOLVtT/nXWXzlA
         9nkH7kpHFp3HnK2CPp2b9fmQqsfvpgedwsZTvlTDr1kzZOinIFPxkRN4sz78Eo9fttqI
         2FChbukXmHKusNgbScOrlNbjACy9PpZ7mkLCxWXPstBrkDRCfXBurbC0UWYlYwHO4b70
         a7T79DGVO0uMY1wL0I6tn9szqJLRDv88cA+7EGyBdGBmYqWp5beX0aKWhrrttotqsSAz
         Iptvjg6fG6zT4HBwjXj7hmxqCF3mwGb81cIMkbzVtS0vo395CtNl/vKvWBXUGBcAywhw
         Vufg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=JabFw4XiOs7FstGNqpfRhCpveZoXSN450e4MjJLUX78=;
        b=TSmykZh98hQmfB5kJn7/3NujxcucXjHZW10dm+CMfg7mwb8v6eMByS28uW2pKaVtAF
         5GXfwwWANE9HdSgpQNb4gPVPnUCCsMttypWiEcM9+zlIOm2jI5iVqPh/GGSaiK3zfDhR
         +NCuyWU+000E/1vdmisgHBcIRZ0X1xH8LKEj53w9XzYGEBmXpHHAv7hk/dBkw9I5KXxC
         7fQcD1qNOanQeErRUUUY1SNfSx4SBZ4D6IYyZnb1z3pPtvump6DTn4Fmz51fV0VgrT3W
         oA3Oez5w/S5JRuZpTtNpJIPTIz7S2wdO+WGG531YrLaXuA5h0AZ8XvqxCT2NT+MjP7+e
         cTNA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12937-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12937-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12937-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12937-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
From: Laura Abbott <labbott@redhat.com>
To: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Cc: Laura Abbott <labbott@redhat.com>,
	David Airlie <airlied@linux.ie>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	kernel-hardening@lists.openwall.com,
	Kees Cook <keescook@chromium.org>
Subject: [PATCH] drm/gma500: Remove VLA
Date: Mon,  9 Apr 2018 14:06:47 -0700
Message-Id: <20180409210647.3718-1-labbott@redhat.com>
X-Mailer: git-send-email 2.14.3
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597304244682025717?=
X-GMAIL-MSGID: =?utf-8?q?1597304244682025717?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


There's an ongoing effort to remove VLAs[1] from the kernel to eventually
turn on -Wvla. Switch to a reasonable upper bound for the VLAs in
the gma500 driver.

[1] https://lkml.org/lkml/2018/3/7/621

Signed-off-by: Laura Abbott <labbott@redhat.com>
---
This was a little hard to figure out but I think 32 should be a
comfortable upper bound based on all the structures I saw. Of course I
can't test it.
---
 drivers/gpu/drm/gma500/psb_intel_sdvo.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/gma500/psb_intel_sdvo.c b/drivers/gpu/drm/gma500/psb_intel_sdvo.c
index 84507912be84..3d4fa9f6b94c 100644
--- a/drivers/gpu/drm/gma500/psb_intel_sdvo.c
+++ b/drivers/gpu/drm/gma500/psb_intel_sdvo.c
@@ -429,13 +429,20 @@ static const char *cmd_status_names[] = {
 	"Scaling not supported"
 };
 
+#define MAX_ARG_LEN 32
+
 static bool psb_intel_sdvo_write_cmd(struct psb_intel_sdvo *psb_intel_sdvo, u8 cmd,
 				 const void *args, int args_len)
 {
-	u8 buf[args_len*2 + 2], status;
-	struct i2c_msg msgs[args_len + 3];
+	u8 buf[MAX_ARG_LEN*2 + 2], status;
+	struct i2c_msg msgs[MAX_ARG_LEN + 3];
 	int i, ret;
 
+	if (args_len > MAX_ARG_LEN) {
+		DRM_ERROR("Need to increase arg length\n");
+		return false;
+	}
+
 	psb_intel_sdvo_debug_write(psb_intel_sdvo, cmd, args, args_len);
 
 	for (i = 0; i < args_len; i++) {
-- 
2.14.3
