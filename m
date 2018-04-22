Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48jhTYvHuWb9tmyGgX9nCYF0m0uQjFcjLGAeYuHIoQkjNkb0zQggrSe59WBgdaLhta2StB6
ARC-Seal: i=1; a=rsa-sha256; t=1524406807; cv=none;
        d=google.com; s=arc-20160816;
        b=1D0aYYpoQW29c1P7aSSH205YybNEhyJIPM8EyAHRU4VVH/fvFj/UTkWbG90XsxMaB6
         KqXtJjOWmSnROK3VK7VJM1eh7PIF9m/QA6/vH64shkszBTrOkJFm5rhAF42u8cUplnpZ
         SWC9OXmCuGkIUnbVjii48/S3uuVf5IQ38emAjqhfvb8qSMjoGutlXHPeeKx2AimwuXSJ
         gL1puLK3Ethz+H9c7wf6fzYsSAJf0uyhcLvx9ImRLh0baj3hM+mgDDMfo/MAOrrt8jb9
         KvOrwazbOIKd5ZvxVsdrVLgy9OZn88HlSYJr01rVwB0Oq7hTOny7iJdCmqrYPhrfc4GQ
         wJSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=o5rARGrr6uGJZzGj7EAGW20kg5ny44iGdVThDRfbtOc=;
        b=0X3UwCFB4OzL7wwY2da4Ebvx8MfQuZDm2tyqLAc4EnljDXgJ2q5SgNpUT2tJzsylA8
         JjdkvveY5hXjZNuCa/VgtxXyGa+Dl4sN49JZJUSBmvZhW9aO19Ee0mjsYmqcHkQtKwcJ
         Xdy8EXco814Rkq31C/3WEx+bqNdElWzIh8Dlbd7NWcHrS6NrK0Rsn6Y4EN8SRMtLGyAd
         EjKR+J9j4uWWLXZyJrdZkCH8eiH3okS5PCzF1mbRVwqv+LIQDw4QIVEBsXpAXCiqr0xG
         xNiE6wzt4jdBULrBz8D4txPg29AVtu7BSgkHVEIBpncbiqLSddRvsYot+yKVU++kzI1P
         T1sg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Heinrich Schuchardt <xypron.glpk@gmx.de>,
	Bin Liu <b-liu@ti.com>
Subject: [PATCH 3.18 12/52] usb: musb: gadget: misplaced out of bounds check
Date: Sun, 22 Apr 2018 15:53:45 +0200
Message-Id: <20180422135315.820545450@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135315.254787616@linuxfoundation.org>
References: <20180422135315.254787616@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598454813951848255?=
X-GMAIL-MSGID: =?utf-8?q?1598456392699301903?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Heinrich Schuchardt <xypron.glpk@gmx.de>

commit af6f8529098aeb0e56a68671b450cf74e7a64fcd upstream.

musb->endpoints[] has array size MUSB_C_NUM_EPS.
We must check array bounds before accessing the array and not afterwards.

Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
Signed-off-by: Bin Liu <b-liu@ti.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/musb/musb_gadget_ep0.c |   14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

--- a/drivers/usb/musb/musb_gadget_ep0.c
+++ b/drivers/usb/musb/musb_gadget_ep0.c
@@ -114,15 +114,19 @@ static int service_tx_status_request(
 		}
 
 		is_in = epnum & USB_DIR_IN;
-		if (is_in) {
-			epnum &= 0x0f;
+		epnum &= 0x0f;
+		if (epnum >= MUSB_C_NUM_EPS) {
+			handled = -EINVAL;
+			break;
+		}
+
+		if (is_in)
 			ep = &musb->endpoints[epnum].ep_in;
-		} else {
+		else
 			ep = &musb->endpoints[epnum].ep_out;
-		}
 		regs = musb->endpoints[epnum].regs;
 
-		if (epnum >= MUSB_C_NUM_EPS || !ep->desc) {
+		if (!ep->desc) {
 			handled = -EINVAL;
 			break;
 		}
