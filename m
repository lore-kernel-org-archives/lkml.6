Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227uqO5aY0upsPx2jfVUZRFQqu6laBZmagbV5i7bFmj9B4031vKi26H2oRqWLSBZdEGS10wa
ARC-Seal: i=1; a=rsa-sha256; t=1518183876; cv=none;
        d=google.com; s=arc-20160816;
        b=I9Fbn3RGK19q1iVHyt2JkJNkhRRk0AieQ5ZZglQTdejjmA4FCa3VK4mCN+VbLCiQOf
         qnNk6xMiSTCU7oTLbSFEjct1MRz3piuxZLea7f64VltWJUvvA/+MtjKR/Pgg+/8zt40r
         hqxEG2RlJwpa3/zmisZBp4M7nO+EalvXczWHah3H8xRLw3UME+eB93ZMqBRFyOnDspzn
         Rmj2/gZhifr5B1iJ6jcN7WX6x560/zs5TI0N5GDNtTO3XJNjJ2moSqn9qYL8gbSxuIAB
         K2xogc1cijPbbosMBxY6GiN29Uie1b/igF2ck5xji928HAqzPuZ/vaYgXjz0UfGklIdF
         HKRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=s7VLUh5zQpWCRGJ2xQCnXv2NzGN0rcXngqOFx8ExriQ=;
        b=V4jurl6M2ZqNWIP8pLigILavbPBICRwrghd7b05kizaMoaYZkKRaD6SkK9oAzrUWCB
         TGCDIiuvjNB/tpYGtmM4eEIgDzwmnXiWg94ceLnY1Su5NmV8sPDhiObaA6qhJQRk3F2w
         8cd+sot2X4YI43wrKWpmHx6PAiS41hK0IfnBUK0eEbpaOWfrHZVEwvGQTrYz6Ej2aRSt
         9qT7FTxBGxsdhsHjqsU32rh3dNVFoK69HbcsCA/CNb6ZW20VL4SBit2F3qtotP2HIZU3
         HHqlQ7vxdQQR8u01H7tdnuTmIldMcn+NRRdFzsIfsDqNPHNDkmKqfNm5OupsWj80kDq/
         BW/Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Robert Baronescu <robert.baronescu@nxp.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	=?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>
Subject: [PATCH 4.9 86/92] crypto: tcrypt - fix S/G table for test_aead_speed()
Date: Fri,  9 Feb 2018 14:39:55 +0100
Message-Id: <20180209133937.315400190@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180209133931.211869118@linuxfoundation.org>
References: <20180209133931.211869118@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591931177082123788?=
X-GMAIL-MSGID: =?utf-8?q?1591931177082123788?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Robert Baronescu <robert.baronescu@nxp.com>

commit 5c6ac1d4f8fbdbed65dbeb8cf149d736409d16a1 upstream.

In case buffer length is a multiple of PAGE_SIZE,
the S/G table is incorrectly generated.
Fix this by handling buflen = k * PAGE_SIZE separately.

Signed-off-by: Robert Baronescu <robert.baronescu@nxp.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Horia Geantă <horia.geanta@nxp.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 crypto/tcrypt.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/crypto/tcrypt.c
+++ b/crypto/tcrypt.c
@@ -223,11 +223,13 @@ static void sg_init_aead(struct scatterl
 	}
 
 	sg_init_table(sg, np + 1);
-	np--;
+	if (rem)
+		np--;
 	for (k = 0; k < np; k++)
 		sg_set_buf(&sg[k + 1], xbuf[k], PAGE_SIZE);
 
-	sg_set_buf(&sg[k + 1], xbuf[k], rem);
+	if (rem)
+		sg_set_buf(&sg[k + 1], xbuf[k], rem);
 }
 
 static void test_aead_speed(const char *algo, int enc, unsigned int secs,
