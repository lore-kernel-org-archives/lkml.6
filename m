Return-Path: <labbott@redhat.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523408661; cv=none;
        d=google.com; s=arc-20160816;
        b=y3iK20CR0V8chwdmjGRXTKfSW9+1LQPnyXnVJiJUGaDR4WUu4gPN8mYFAzn/DgG37A
         tm+XJ64mcibnZlOGVBQH6MfHWHoyBoJsJKZ/nCx/cJtzNlosH4Sh8hx3709Lw1IBmc7z
         06oWFrlGnr00mmsHIXVwJeYu0BMdKuOWjSqGFouS8XxlX+dJzCIU5NHAuIyR2DFee5tx
         i/Q7En61giStC1UpePqcdRvdGU/TzEM7Bueha8aSD3llvUReyqe1MnWx0xUT6SfYzMY1
         +Z7Ljpps784l2jTWho5a1LVHuzaq0HBgXuw7TMdo2bxa4EEs5LbfI1tq1nqD+t42u7LI
         HYmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=wKq7BowXlYKx0270E2z2yatGRuasNAfpSUqQlX2oZu4=;
        b=PnqghvYjFRjkAU1/pJ91H10lO942jSyVksRrEKTo+oc947/Q88Qn0c0PDCsDpQ3/nI
         Sa0n63CVigOvxa/KZnDzWsE6ERdUFfamvy7eLbX89ES34zyl2Ue0sUSfXvLW8Oz5XPRs
         GmNbl9HS0qzU3weeFKZgXWnJS/EOE1RWNlybsfRFJqc4C0ZjoP+rAxJ3IT6vHiYP9qS2
         t2vq4KP2QAGTmbX3CT8DWTE0wFTuoEkBDXhuOA6CtyQaSVEUmd4/VpPq2/7oxv6XTESA
         ZgUwALj/D/Qj2UTOITEWa6KmtnobDcmIE7UKvGcCEdOg0VoRL+qXLftPCaV7L9XJv7+I
         v3eA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of labbott@redhat.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=labbott@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of labbott@redhat.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=labbott@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
X-Google-Smtp-Source: AIpwx4+XE3jvUUwDfmT4F2jFTikZpf1loC6n57/m2RSSyQfucmrEYZEIx3VP0X3QoSC6QEAVovJSmw==
From: Laura Abbott <labbott@redhat.com>
To: Alex Dubov <oakad@yahoo.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Laura Abbott <labbott@redhat.com>,
	linux-kernel@vger.kernel.org,
	kernel-hardening@lists.openwall.com
Subject: [PATCHv2] misc: tifm: Remove VLA
Date: Tue, 10 Apr 2018 18:04:12 -0700
Message-Id: <20180411010412.18006-1-labbott@redhat.com>
X-Mailer: git-send-email 2.14.3
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597304272703650108?=
X-GMAIL-MSGID: =?utf-8?q?1597409760700084953?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

There's an ongoing effort to remove VLAs[1] from the kernel to eventually
turn on -Wvla. The single VLA can either take a value of 2 or 4 so switch
to the upper bound.

[1] https://lkml.org/lkml/2018/3/7/621

Signed-off-by: Laura Abbott <labbott@redhat.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
v2: Add extra bounds check per request of Arnd
---
 drivers/misc/tifm_7xx1.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/tifm_7xx1.c b/drivers/misc/tifm_7xx1.c
index e5f108713dd8..9ac95b48ef92 100644
--- a/drivers/misc/tifm_7xx1.c
+++ b/drivers/misc/tifm_7xx1.c
@@ -239,9 +239,13 @@ static int tifm_7xx1_resume(struct pci_dev *dev)
 	unsigned long timeout;
 	unsigned int good_sockets = 0, bad_sockets = 0;
 	unsigned long flags;
-	unsigned char new_ids[fm->num_sockets];
+	/* Maximum number of entries is 4 */
+	unsigned char new_ids[4];
 	DECLARE_COMPLETION_ONSTACK(finish_resume);
 
+	if (WARN_ON(fm->num_sockets > ARRAY_SIZE(new_ids)))
+		return -ENXIO;
+
 	pci_set_power_state(dev, PCI_D0);
 	pci_restore_state(dev);
 	rc = pci_enable_device(dev);
-- 
2.14.3
