Return-Path: <amit.pundir@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1525283299; cv=none;
        d=google.com; s=arc-20160816;
        b=zCl3LaoZSOxCel6l5JS5XMj+N0eOd++yoNBIV7lZxJcWQKaY9jlmuvo/yQ+iNwAhjT
         bFInURtyNYxDj6yLDftnXahEQ7baZVfbR1SFxmag3bDy2zYf9YBLKDs/bFJM/w0QdMJW
         K/HoDm/tNx2GsmWduwVfJucCfqyJqzU15FhKxf2lJmNh7HqXV3lWFI0PDPQaMgTHnob9
         LDybfm1+g3PSUNx4wCXLOdrsMvkfNn3jxPGl/z2feamMpZOCkWyq0kjgWRBFD0IaV7fS
         GNWAQ/8KXsomAOMgpScjyIL112piIhtjdYy+5Q/plb4wKKeSnDSbHKdSKl6UogblqNIE
         w55A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=4fymCIn5kQ1t0qy2gJd1+DqIl18DKdeO5ToUU0ZKRTg=;
        b=PI82NUIoF2ZmUT2i/Wz1rBZbmhZuj+TNaaHfyPgo5pazOLautPZfil0UT5TCOR+Dg/
         tvOGCRkFnCRuRAqhT5zGKhgyexaKwLR+rJgUjCOvHwnrU4a75rLHULOniwJ9ZDyhTrZR
         WwNZbTguP1s86L12h8Q1oWB/B6NUIvTiVLcHzWvjmHl3Fzmg1t5ldS+5KpqWgamcH6Kk
         QbmcxNkAxHM+bE7XERbtyWNKEU73HoSrY23Uhfey5Z08i0IyG+8WGqK69uUwrvg5Q7hs
         1mh/ThaDJxdpza7OKApNGtXdlnCCf/Z7wBnOHTmt/+GyBl9sx9weKiXaSJwF49ANNZjb
         Mysg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=adzPT/Fw;
       spf=pass (google.com: domain of amit.pundir@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=amit.pundir@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=adzPT/Fw;
       spf=pass (google.com: domain of amit.pundir@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=amit.pundir@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AB8JxZqECjJoxkgfcz+tLfYSPTkFwC28TJUJiXW/dCJELcoo9aMyHXsJ6xuxKpZA+zbTEXKhPaeGLA==
From: Amit Pundir <amit.pundir@linaro.org>
To: lkml <linux-kernel@vger.kernel.org>,
	linux-wireless@vger.kernel.org
Cc: Suren Baghdasaryan <surenb@google.com>,
	Samuel Ortiz <sameo@linux.intel.com>,
	Christophe Ricard <christophe.ricard@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	John Stultz <john.stultz@linaro.org>,
	Dmitry Shmidt <dimitrysh@google.com>,
	Todd Kjos <tkjos@google.com>,
	Android Kernel Team <kernel-team@android.com>
Subject: [PATCH v2 1/3] NFC: st21nfca: Fix out of bounds kernel access when handling ATR_REQ
Date: Wed,  2 May 2018 23:18:06 +0530
Message-Id: <1525283288-7027-2-git-send-email-amit.pundir@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1525283288-7027-1-git-send-email-amit.pundir@linaro.org>
References: <1525283288-7027-1-git-send-email-amit.pundir@linaro.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599375461113955842?=
X-GMAIL-MSGID: =?utf-8?q?1599375461113955842?=
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
v2:
Resend. No changes.

 drivers/nfc/st21nfca/dep.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nfc/st21nfca/dep.c b/drivers/nfc/st21nfca/dep.c
index fd08be2..3420c51 100644
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
