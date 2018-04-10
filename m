Return-Path: <baijiaju1990@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523349115; cv=none;
        d=google.com; s=arc-20160816;
        b=EcQtISfepcB/K6CJfLTgYuWIbw+FJoOSOp9+eqQwNvDtiz0v2EhzeXurkol7JHxkQK
         z2TXzMAs6DEmrecxH5sfYXC3IObgcJ0IIpeQ172p4YETmBIrQlxJXc9dO0I37xqjlYL7
         eMgcSdXuwDaqLFGsI+y1tSAxSzRdlndJ2au48qhWsD/Qo7sgKnlVcvQrVM7eiEf3WmVF
         6Zzn29suczxiZTNTW7D27OhidRHN/8qq5ehidiFeH5+PXTKG3HnXilIc1fzOsP4s+8vs
         MkcCO7AJpXErAv1Q6iHHa5+ivQYvvBlboQ3DIqUj5WG9dEBzhGVU36sQFKezk7gU9Pnv
         lyCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=PRNd3WQ5KTqLN/obWZagAzEka+HhE7FsLmm4OYIVPDk=;
        b=BbA4LZcP7DlDmAJyo9VpIqtEH2O7UvY0pZAxfSemH5H2fq/1v/Qe8elLX1OtKanKOk
         0WCcX+sYVT96ibr9NSMNBp9R1ZXXYvxYTtdxZwBCCVj8BvxLqC0sv8g79bMRnBvJlhsG
         YcwR+4sTdSQ1pkKnxQPcs5pXpIM2C7tPgKaD1cbIK6eq3UD7Qju4PH+Mf0Pvkmgf8E3i
         5B+6y0+e9ST539u0X4Ksk4vaNfjvfMNvRXSzF8HQVwSRSxZi9WETJ3Kvr1NfkSKbc4dP
         20vfSU9rqkALOBDK3xDFf0vdZSBEb1p3RP8w3AAIEPVxh7uj0OE4OSDhoPLTA0WtHKgZ
         VNWg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=ekWqouU9;
       spf=pass (google.com: domain of baijiaju1990@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=baijiaju1990@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=ekWqouU9;
       spf=pass (google.com: domain of baijiaju1990@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=baijiaju1990@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx49dYJxjuOwHzk7mIYWqGl83r8/1pQruE7JOz+2uxnKHkRgbjrfw/OOiPw8P8cVjaFzU3ZW2zQ==
From: Jia-Ju Bai <baijiaju1990@gmail.com>
To: jikos@kernel.org,
	dsterba@suse.com,
	gregkh@linuxfoundation.org,
	jslaby@suse.com,
	johannes.berg@intel.com,
	stephen@networkplumber.org,
	davem@davemloft.net
Cc: linux-kernel@vger.kernel.org,
	Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] tty: ipwireless: Replace GFP_ATOMIC with GFP_KERNEL in ipwireless_network_create
Date: Tue, 10 Apr 2018 16:31:46 +0800
Message-Id: <1523349106-29584-1-git-send-email-baijiaju1990@gmail.com>
X-Mailer: git-send-email 1.9.1
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597347322364831105?=
X-GMAIL-MSGID: =?utf-8?q?1597347322364831105?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

ipwireless_network_create() is never called in atomic context.

The call chain ending up at ipwireless_network_create() is:
[1] ipwireless_network_create() <- config_ipwireless() <- 
	ipwireless_attach()
ipwireless_attach() is only set as ".probe" in struct pcmcia_driver.

Despite never getting called from atomic context,
ipwireless_network_create() calls kzalloc() with GFP_ATOMIC,
which does not sleep for allocation.
GFP_ATOMIC is not necessary and can be replaced with GFP_KERNEL,
which can sleep and improve the possibility of sucessful allocation.

This is found by a static analysis tool named DCNS written by myself.
And I also manually check it.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
Reviewed-by: David Sterba <dsterba@suse.com>
---
 drivers/tty/ipwireless/network.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/ipwireless/network.c b/drivers/tty/ipwireless/network.c
index c2f9a32..17b04b5 100644
--- a/drivers/tty/ipwireless/network.c
+++ b/drivers/tty/ipwireless/network.c
@@ -415,7 +415,7 @@ void ipwireless_network_packet_received(struct ipw_network *network,
 struct ipw_network *ipwireless_network_create(struct ipw_hardware *hw)
 {
 	struct ipw_network *network =
-		kzalloc(sizeof(struct ipw_network), GFP_ATOMIC);
+		kzalloc(sizeof(struct ipw_network), GFP_KERNEL);
 
 	if (!network)
 		return NULL;
-- 
1.9.1
