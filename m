Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48myn484fcNkJx070n0e59QhW6lJlv1JaE8Y231MhC7UfoqzHmk7I5TSK8uXA2UUZ4aaNd8
ARC-Seal: i=1; a=rsa-sha256; t=1523472576; cv=none;
        d=google.com; s=arc-20160816;
        b=PCrxZT+zcXj0gt32mkXBN7lnlIjKnZnAeYh9E6EGgn7gdgzmFbZ0TqviTcMF9hg+I3
         K9dAj26I36PsMlc0QSkcP0xNb/gf8VPhNViwWtVARhObd4farNAT/hCIu8iu5DrxV07x
         x5VqFhCUpJ1Xp2hHpdmXa6jpW0KQcTplQrv4lZ74pjgdZXIOXYldFWgoEygiFbzU1Etk
         mF1kdW/Fj+p9zGFk2h2qzlUN7HwJR7hUP9wcTT9qqjc75aM9fV7WY/jit/iTAYp+GOOJ
         5oOFU+XSqrJ9/qWVMp+UhPQ9f9NX9d/syiCmnElR2DKNftKtTaq/kY/Y8H+5jXiBsl9u
         YeHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=st8zv/8jdu+4yIxdFIUL8Ah9gCUn8f+KzvKp8M9TY1E=;
        b=PiKWKeMbeW/Jt+FEmbTw8wvIcNoTiqIuxn5p9DHstb2MT7izj8xCoNGpVvuhnEWvrA
         wQKlGGQNlZPtki0/7mqUzzpchrLEc1GkFXTeCOfQkmYcmQZLszzK9l/AgRIEJmanQViO
         oGiZJ0KA8teR1ZetweU3XyolpPSGCIobJgHwVg4/v7B5l/8bmEKjoTx+g8ZUF9K3HGnq
         NNKliA/lCpb8lYuPckKjEj9sTtWfPKFBA3GG31vF0r1wnaLugXN2O0V2nebYRmONeULU
         wLRBepSiH7MhdoQSbV0z+XHjK3QKf+NH+UIXaflFzIXOVnCbtAnUNw6Ck/CS0yFEShWL
         GuQA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Arjun Vynipadath <arjun@chelsio.com>,
	Casey Leedom <leedom@chelsio.com>,
	Ganesh Goudar <ganeshgr@chelsio.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 101/190] cxgb4: FW upgrade fixes
Date: Wed, 11 Apr 2018 20:35:47 +0200
Message-Id: <20180411183556.461692322@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183550.114495991@linuxfoundation.org>
References: <20180411183550.114495991@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476779888019576?=
X-GMAIL-MSGID: =?utf-8?q?1597476779888019576?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arjun Vynipadath <arjun@chelsio.com>


[ Upstream commit 26747211486c5bc7dd014c3caab206576e00c0d0 ]

Disable FW_OK flag while flashing Firmware. This will help to fix any
potential mailbox timeouts during Firmware flash.

Grab new devlog parameters after Firmware restart. When we FLASH new
Firmware onto an adapter, the new Firmware may have the Firmware Device Log
located at a different memory address or have a different size for it.

Signed-off-by: Arjun Vynipadath <arjun@chelsio.com>
Signed-off-by: Casey Leedom <leedom@chelsio.com>
Signed-off-by: Ganesh Goudar <ganeshgr@chelsio.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/chelsio/cxgb4/t4_hw.c |   21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

--- a/drivers/net/ethernet/chelsio/cxgb4/t4_hw.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/t4_hw.c
@@ -6076,13 +6076,18 @@ int t4_fw_upgrade(struct adapter *adap,
 	if (!t4_fw_matches_chip(adap, fw_hdr))
 		return -EINVAL;
 
+	/* Disable FW_OK flag so that mbox commands with FW_OK flag set
+	 * wont be sent when we are flashing FW.
+	 */
+	adap->flags &= ~FW_OK;
+
 	ret = t4_fw_halt(adap, mbox, force);
 	if (ret < 0 && !force)
-		return ret;
+		goto out;
 
 	ret = t4_load_fw(adap, fw_data, size);
 	if (ret < 0)
-		return ret;
+		goto out;
 
 	/*
 	 * Older versions of the firmware don't understand the new
@@ -6093,7 +6098,17 @@ int t4_fw_upgrade(struct adapter *adap,
 	 * its header flags to see if it advertises the capability.
 	 */
 	reset = ((be32_to_cpu(fw_hdr->flags) & FW_HDR_FLAGS_RESET_HALT) == 0);
-	return t4_fw_restart(adap, mbox, reset);
+	ret = t4_fw_restart(adap, mbox, reset);
+
+	/* Grab potentially new Firmware Device Log parameters so we can see
+	 * how healthy the new Firmware is.  It's okay to contact the new
+	 * Firmware for these parameters even though, as far as it's
+	 * concerned, we've never said "HELLO" to it ...
+	 */
+	(void)t4_init_devlog_params(adap);
+out:
+	adap->flags |= FW_OK;
+	return ret;
 }
 
 /**
