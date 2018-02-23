Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2253fGohg3zlSmtU/4SW2HC4kiHScYhckEMOBmQJjAZbti/iZkEILqVViedRTB33eiTkj5P9
ARC-Seal: i=1; a=rsa-sha256; t=1519412133; cv=none;
        d=google.com; s=arc-20160816;
        b=WDsPZ1Wy3s1E6bCdC+ZGkCS21dk6U+Fh+ql36uU6mS+qB9uiRUcYJD5sbhW8oWnF3w
         upW2NmDonm++dG1TKtjtCkmmhXf4UikS0bi2zFcF3BVeec+y8w7kXNtCO91vuymB8FCs
         3jWUcdPissPiVDyvHjfP63cH0Ex4DEHry5nbNf4ScbyxZV1tQ2KIdcirlSOyt9r0eE3Y
         6sR3kF9Rs0sF3fZDKMiQ8/uxuqaBj/mHDLIYeFKoFhyte+LQST15Dp4J15V2bUjBRqQY
         7i4oqhh3S5eFaRzXtRPfIWn7cgFiLZPWw26tuIA6GFiooOKdd+0qumWmr7JwPTOsT89P
         A9WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=c+At81a4nff7X0pG/8ho0H4CHvMrkZYbDtAXJRq3hns=;
        b=q7s1J8T9vQrDlDVPXIEqqvJCI/OzxXJx4U5MwqnYS0xk4dUlLrKDlCzt+SmFpQqdzR
         7hybsp5XaSdH908yb6xe0BVQ7bIzutVXUf232QbErxsfbfKKoaYsUK6av9NP/c2glcWz
         Puvpfdj411R9OZFwHDVS23wXq8Nfhe4urCZg0MY5GmJnih8tQpREjwtbTJvL+gCEgn5Z
         4xDuQ6FQaxNLNPlpzsn7KsdTkQ8j4h0pR6+/EQZHCmFq4HzegQ4ch1eI/IJV6achi1YT
         tRxlHeh5kEFvFaq0W0M2Md+AjvL36mMKmSGWFWJRnBiNrbTg1BnF+YcyVxYkxh9lI7Hx
         wt/A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 136/159] staging: ccree: Uninitialized return in ssi_ahash_import()
Date: Fri, 23 Feb 2018 19:27:24 +0100
Message-Id: <20180223170759.540294728@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170743.086611315@linuxfoundation.org>
References: <20180223170743.086611315@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593219098164593277?=
X-GMAIL-MSGID: =?utf-8?q?1593219098164593277?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Carpenter <dan.carpenter@oracle.com>


[ Upstream commit aece09024414b54158e03aa45f4a4436e7cb996c ]

The return value isn't initialized on some success paths.

Fixes: c5f39d07860c ("staging: ccree: fix leak of import() after init()")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/staging/ccree/ssi_hash.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/staging/ccree/ssi_hash.c
+++ b/drivers/staging/ccree/ssi_hash.c
@@ -1781,7 +1781,7 @@ static int ssi_ahash_import(struct ahash
 	struct device *dev = &ctx->drvdata->plat_dev->dev;
 	struct ahash_req_ctx *state = ahash_request_ctx(req);
 	u32 tmp;
-	int rc;
+	int rc = 0;
 
 	memcpy(&tmp, in, sizeof(u32));
 	if (tmp != CC_EXPORT_MAGIC) {
