Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224li0/tYkS0oJRDRv3WeP5PlEsgKpSLO4xej7RVR+Ym/Mj5aUE/Di/gIUuuDi2rrz9txG1/
ARC-Seal: i=1; a=rsa-sha256; t=1518184014; cv=none;
        d=google.com; s=arc-20160816;
        b=jPxdltR5YxNN0GaU3+tZWPZQVdouUs4AoA7ZHDgdadPv1oLbVcGgbPuwyYXqgBp2Hq
         Wf0IrUFLH2Px8b4YXY1rFbTh/lQ2t3lu1nMFYLF4UIAHgiX+BeotU89cd/EfuX2o6y3Y
         WjVr4peVVaI7jem+pVATrUb+8nX9yzvE6qZqWURHLElr+VOmNuhxSNVHikw98lrEdOOW
         oYwXcLdWoelkCSfgprKyZbjVuLI+A9IQ14XZZGGtWZUbAAyY+ts/uAiwmfim8UJK4dU0
         pj5gfFyr0TNtgglA+WquyaH2rSKJRc3umJ4KoC/ztat0C/dsr3lEV+ZlmEYXsEETHIXF
         0+7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=hIyHmd84XDSilDRkyVWEk+sBs5+q8LZ6N8DonsF8Q2s=;
        b=SievdiMG17CQEfEp35DEYjcPWXZXIz30rywBZZ1h7RajYy14JSCSLR3d64H/Lpm+mH
         Lb24vYPAOmVo6IeFmQhvZomA8Nq/Tq64dEUcJv50pTZzCT6lmTBAFLikg10ZgeqihwOV
         ikk7JhcBiOOSGbRs9ADtH1GAZxZCHQnST/NOZqKsUY/7CqfaJiGAxwNEMYwIj1AmJCep
         tDenJhJ5twMw2M20h1ghhnABdHNdrMOlBx3QrIr18qrcs0uuWdJoU+5osXDlg15A1qta
         w8f0juRZktgNqxeYuutxAlVqdPNlKozr0ibXEt60KEJBbDkQF6lJLmMBgIViXeFdIM8u
         fFAw==
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
Subject: [PATCH 4.15 23/23] crypto: tcrypt - fix S/G table for test_aead_speed()
Date: Fri,  9 Feb 2018 14:40:21 +0100
Message-Id: <20180209133939.450994203@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180209133938.366024920@linuxfoundation.org>
References: <20180209133938.366024920@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591931177082123788?=
X-GMAIL-MSGID: =?utf-8?q?1591931320561141251?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -198,11 +198,13 @@ static void sg_init_aead(struct scatterl
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
