Return-Path: <labbott@redhat.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523308060; cv=none;
        d=google.com; s=arc-20160816;
        b=a/TmwQWYgjVxytA46tCAbJ3n/theMcSCxuGW/Q3PX9+rzHHto8LFKs9Jf1rVBJiu6U
         DVzveG7BUEmW3pkYT2zLZtLTHCzJ5DpHZyIqiMlGPEzng6szt/NJEX3VPJZKOnwhAr8N
         MvdvIdI0DgyMMH5qrZ0XwOQLFWxarPvnrO9n8j++EZPMOuZTZCf0Nhzg5m8bOb0B/94J
         0vhNHtu7dTh1TsfKNz8K1iVCI3bXE7qR/yQYUbW+fHRW8DPNPlbnEgee8nHgHjvLLgaM
         7ciOqN8Fxv04Qlg7gycE8jE59K+ovaMzzOwMPCofsiNnAj4IlQy2KWJtx2H3kmfeSXf7
         uxnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=NpxMcA4s0kNbESxlWiedvYkAALnJZrKIfvWJzlsBvZo=;
        b=EifbDKyvBTn5VNHReFnf2Sf+U5D8FcPb2vzs7Cvh2OvtKuQSuYEliGz2CRvhEDp5Jb
         B2c7BAysjQvVR8M8oCeKbK/uxVZqU+k8MWNK/bajHiDikEg94JT2CzJoDOR1OiYPn6tT
         iylbjHMtTyEDXS4gBROSc9xF2CuASXeCTR/FDp0IOx/P4mgd3pe84BWmj08JetNFJStT
         j4yuaIEaTdf1m1NlOg2b9mUUhZEN/NOrvKnAJcMFmHSX3u2VIxkefgtqpCH1bP4CqYtt
         HKboPZRmMOeVjp1xEtdwlkgynL9Ijj45TGtlJeyY81EM62wZKa0GwusynN/UAwkBwBIU
         rb+g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of labbott@redhat.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=labbott@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of labbott@redhat.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=labbott@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
X-Google-Smtp-Source: AIpwx4/AxJJ57xlXcouxLgY58SJtBMlGKkL4efmvWTEUFLdXBdoHHl8WRnwPlKV+VSrY9i4NWKBL0A==
From: Laura Abbott <labbott@redhat.com>
To: Alex Dubov <oakad@yahoo.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Laura Abbott <labbott@redhat.com>,
	linux-kernel@vger.kernel.org,
	kernel-hardening@lists.openwall.com
Subject: [PATCH] misc: tifm: Remove VLA
Date: Mon,  9 Apr 2018 14:07:32 -0700
Message-Id: <20180409210732.3919-1-labbott@redhat.com>
X-Mailer: git-send-email 2.14.3
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597304272703650108?=
X-GMAIL-MSGID: =?utf-8?q?1597304272703650108?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

There's an ongoing effort to remove VLAs[1] from the kernel to eventually
turn on -Wvla. The single VLA can either take a value of 2 or 4 so switch
to the upper bound.

[1] https://lkml.org/lkml/2018/3/7/621

Signed-off-by: Laura Abbott <labbott@redhat.com>
---
 drivers/misc/tifm_7xx1.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/tifm_7xx1.c b/drivers/misc/tifm_7xx1.c
index e5f108713dd8..690eaaea5ce4 100644
--- a/drivers/misc/tifm_7xx1.c
+++ b/drivers/misc/tifm_7xx1.c
@@ -239,7 +239,8 @@ static int tifm_7xx1_resume(struct pci_dev *dev)
 	unsigned long timeout;
 	unsigned int good_sockets = 0, bad_sockets = 0;
 	unsigned long flags;
-	unsigned char new_ids[fm->num_sockets];
+	/* Maximum number of entries is 4 */
+	unsigned char new_ids[4];
 	DECLARE_COMPLETION_ONSTACK(finish_resume);
 
 	pci_set_power_state(dev, PCI_D0);
-- 
2.14.3
