Return-Path: <amit.pundir@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1524045915; cv=none;
        d=google.com; s=arc-20160816;
        b=mr5zoc3ZvMwhDvED9dnfPcK9Nn/pdF2OftmEQMO7CvK2gjAs/WvlxW1i52nvsa9Xjr
         OPGZydsAsWyYa3I2UCTfmJ5z+5AMD18eO/XuQwKlpsS3cTOtHgWnDQDxrqmoFOe91y9i
         iUq2dl4CSAbdmO1yCSYyJ31XHGq2C/sNhUBLG0LdBBtxyWRBT1xRqlxsRz2pghiAiuxx
         p3JuVPdC1+mlfikvdrP6Vv/ZUPmF4PEEqb18IgDoTD1K5pTa2G1lY2M3prZMrARAvc8p
         o/RZfC5X6DsFSEZzeMwQx1gMnOgPHJQzjkFcqKyE9oU9NU4rqXGE4ObL8tCRrCxQdPP0
         lF8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=BSvaSnSaUmVJ7Li8G5jPfvmWzxU8loCxeYaDdT0Atkw=;
        b=IzkFOALXlxSK7tsX/DTZ2Ekhgr/eld6aVZhafJOv3pc1N0m9AowUwqTmOAbJa+OT2k
         Fl+nHQSO5ZEmLBJm6J1I96G67kKhrfHYoJljV4l4iIwX4vhuOfURYrxfOIRxLDNJydMN
         BawAL9xbhmkKnOllahHWAiy7P70fKyDC1/8r4/lgwowJXmMJ4UGlunAcODWT4cCeiLFY
         ynI0RBDq++gI0GZimGVDYYQi/9hy4dtRZ3SNP2jXG5zDrtVzy0zICdWplSjSdV3PElbZ
         O/oYvFNwxa/DZe+CFeh6B4Lq5//AEt2xasHy/1HOyRNVyPMh53ItPFp69LIWIRUa21Ly
         ljWA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=A2Yb2+ds;
       spf=pass (google.com: domain of amit.pundir@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=amit.pundir@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=A2Yb2+ds;
       spf=pass (google.com: domain of amit.pundir@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=amit.pundir@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AIpwx4/SjcYk6SeG8ttnObSIsLzWpl0p5htSA+W5LYt+eoBRdHRJ0rRncjMY+fsjd832tK4Cmnmetg==
From: Amit Pundir <amit.pundir@linaro.org>
To: lkml <linux-kernel@vger.kernel.org>,
	linux-wireless@vger.kernel.org
Cc: Samuel Ortiz <sameo@linux.intel.com>,
	Christophe Ricard <christophe.ricard@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	John Stultz <john.stultz@linaro.org>,
	Dmitry Shmidt <dimitrysh@google.com>,
	Todd Kjos <tkjos@google.com>,
	Android Kernel Team <kernel-team@android.com>,
	Suren Baghdasaryan <surenb@google.com>
Subject: [RESEND][PATCH 1/4] NFC: st21nfca: Fix out of bounds kernel access when handling ATR_REQ
Date: Wed, 18 Apr 2018 15:35:01 +0530
Message-Id: <1524045904-7005-2-git-send-email-amit.pundir@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524045904-7005-1-git-send-email-amit.pundir@linaro.org>
References: <1524045904-7005-1-git-send-email-amit.pundir@linaro.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598077970459959933?=
X-GMAIL-MSGID: =?utf-8?q?1598077970459959933?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Suren Baghdasaryan <surenb@google.com>

Out of bounds kernel accesses in st21nfca's NFC HCI layer
might happen when handling ATR_REQ events if user-specified
atr_req->length is bigger than the buffer size. In
that case memcpy() inside st21nfca_tm_send_atr_res() will
read extra bytes resulting in OOB read from the kernel heap.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
---
 drivers/nfc/st21nfca/dep.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nfc/st21nfca/dep.c b/drivers/nfc/st21nfca/dep.c
index fd08be2917e6..3420c5104c94 100644
--- a/drivers/nfc/st21nfca/dep.c
+++ b/drivers/nfc/st21nfca/dep.c
@@ -217,7 +217,8 @@ static int st21nfca_tm_recv_atr_req(struct nfc_hci_dev *hdev,
 
 	atr_req = (struct st21nfca_atr_req *)skb->data;
 
-	if (atr_req->length < sizeof(struct st21nfca_atr_req)) {
+	if (atr_req->length < sizeof(struct st21nfca_atr_req) ||
+	    atr_req->length > skb->len) {
 		r = -EPROTO;
 		goto exit;
 	}
-- 
2.7.4
