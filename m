Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224KdbQDU3rnD7culy7Q5LHHIfkGvh64PYk+75l/uJkNchA4ertXyRU7KmuZ5ePqOaBQU3Mn
ARC-Seal: i=1; a=rsa-sha256; t=1517591620; cv=none;
        d=google.com; s=arc-20160816;
        b=atw9bxvZXDDmT991vTrSYa+uB+B/pMvBCe7c362ZqDTx4edOri3nmVvIa3OYk2f4HN
         DNL/ey/pAXqBegzrFmq2lNAp4DQZ1szyWhDR5gVddFI3ExMh8Rytrc8pGHq38aU2x/HP
         hWYaxHV9w6pwsdN88f7zyudwRTAiGQzkNVJ78ZfWLWXU5wVl/kxn5bTFjUxc90gGGhEq
         0gk07/aED4oiSibmSx18v969iB08mHYVAbpOel+CfhjMOMK+nXS9ylSp4LlTHxvn4mIn
         mO0CjTWWpbSST5j5eQyto3fZTpW4NtWW4bfyKBo6bbVZIBng9op6k+FV97MQL1EWlLOG
         c28g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Dyzo8b1hf4VBETuFry9frr4CuogS/KuPoM2pD+utAMQ=;
        b=KTbKFQRH1RlJrbGzxvtbXfFru7oTstrtpSRwOh248U0VQTmKBeBe6Arz6G/RSXpTZ4
         bRhYAAufOwS7AVjjEWdDre+MLXqimiEA9Mgq/URjmVTpQ0l4uQrp276AkQ6GzvvwlNrK
         N89N2gFxng9eHprCZhtOU9ddL3clIVge6RBPq87CwsV6eHcWL+oKIWzY79t1zl7qVX6f
         M7Xa58Pag79jBnaPxQ4FX6+r4XEgrbfeMguDei4nsiaVcumbC7RUT59fSnqFR+Manksl
         EgolMNcUtmXpMcbMZaprzHp0+FH4NLKt+uozY2NIsmMUC9XJaYhIEtIgY0xMz1quMkDD
         sFEg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 4.14 143/156] usb/gadget: Fix "high bandwidth" check in usb_gadget_ep_match_desc()
Date: Fri,  2 Feb 2018 17:58:44 +0100
Message-Id: <20180202140846.842250189@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140840.242829545@linuxfoundation.org>
References: <20180202140840.242829545@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309737270542005?=
X-GMAIL-MSGID: =?utf-8?q?1591310150833270009?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>

commit 11fb37998759c48e4e4c200c974593cbeab25d3e upstream.

The current code tries to test for bits that are masked out by
usb_endpoint_maxp(). Instead, use the proper accessor to access
the new high bandwidth bits.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/gadget/udc/core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/usb/gadget/udc/core.c
+++ b/drivers/usb/gadget/udc/core.c
@@ -923,7 +923,7 @@ int usb_gadget_ep_match_desc(struct usb_
 		return 0;
 
 	/* "high bandwidth" works only at high speed */
-	if (!gadget_is_dualspeed(gadget) && usb_endpoint_maxp(desc) & (3<<11))
+	if (!gadget_is_dualspeed(gadget) && usb_endpoint_maxp_mult(desc) > 1)
 		return 0;
 
 	switch (type) {
