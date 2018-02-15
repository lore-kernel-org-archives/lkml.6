Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227zOlK2mhJKaYh+5HJOMC06virX74eQFBt8sL7n6zjh3pzML3Yl+pqFEUpNEMo34q/SFJJZ
ARC-Seal: i=1; a=rsa-sha256; t=1518708123; cv=none;
        d=google.com; s=arc-20160816;
        b=RaxCBJ6iGlJc9Ihw/0kdzoTvIctVsm6Lj7Mpx4gBT06eht4dO9GYU4+Xp/wfmwFv8A
         r1zpkJ93u6P2EDR1iH49sjxK35l4/hxiaKLYvR0y3+V0NZH6P+JKRouhKVud7ESjPIZL
         cvDAB4zDourwSHor0hw3k2h8WkNez5wPNzL7K+4t7KMNt2G9tbGFOVVkdlAqyyPVhN3i
         pZT6N1tKMwJezHWCoN1ILEokPDouwhmid9mQgGDkncXq/FGFdiwuU9YWY6kHWH+gCzyn
         3dOxUeyp7WQt4utyyD3yS/WHkRphW/y2W6EXOzWggy3lqmvOThVhULF0Jc7gV+ufdKlk
         cx+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=OEz1fse0Ge4pIXHLbY85EBTPgfXc2mKuGde7Q3q/xm4=;
        b=YKDgFrXHNT9yQXUTwYtxwc7QHW5cWfz9pwqWOKwuKYvQMIL8fCH5oEAcyeYMNA6NRm
         FTGoZ7H5WZJSw5bMaxBgPsexTNp0/cT6Ylun2zDf2sXV9s0fdlRf9Vr61QXnMpqv94AF
         +VywtRFd3tyMlxCMNsbnwiONTWw0qFkgbFhkDQlRmp+vgFczGyMdtfyjj3hk9/YPloBj
         dw6hHIEw82U29JL4dFzXiNHfLVFCtlblG6lQQ2ycsDhuAmGfmj7e295UI3cguCiWCAkV
         juK9+CiR0biPfRSFnVidXXtXsmi5wOc9jI5hqV07Ohy6ddWkuljWk6auczB1EMBpDVBR
         qavA==
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
Subject: [PATCH 4.4 036/108] crypto: tcrypt - fix S/G table for test_aead_speed()
Date: Thu, 15 Feb 2018 16:16:33 +0100
Message-Id: <20180215151227.455498108@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151222.267507937@linuxfoundation.org>
References: <20180215151222.267507937@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592480888459249398?=
X-GMAIL-MSGID: =?utf-8?q?1592480888459249398?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -291,11 +291,13 @@ static void sg_init_aead(struct scatterl
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
