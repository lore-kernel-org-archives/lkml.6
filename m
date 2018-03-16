Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtL1fAM6YQGs7swsS6VMSNU2G4oWOxXeMx0X9NMGFa+VK9w7vHhlNHoOZNZi1G4EIMI5n73
ARC-Seal: i=1; a=rsa-sha256; t=1521214539; cv=none;
        d=google.com; s=arc-20160816;
        b=GyjbmjoepFgNz7q7iuCewg2V9KRFzV2KGbNRFzM9lJUtsKFugZh3XPzULApHOKhmf5
         ppt6u6wt+KvDW8PMC9xcM3yH1tfLNAzynJrDJdCy0ltFRLhrLi/2gjM/eKPuqRJRm2vY
         9BuSYlXYxOldlgg7THEy4Db3dCKj2yyo0ZEiewBD7QZ73D8b/M9gJgjH85SeMTNobUU0
         2SPxbZHHt4roCs0KCVrgTfqBSycJIDdIV3pPSKokNfA790w4i73nG2nxAbc4nywbX3ZA
         CERr/9VVeh/gE04WyctrgBZ1Gw5B0GAJJ2JY7cPErMv4CRROmltSTxXjB9IUnyWA3nJg
         lt3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=+4BwCB/h9AJ/hJt0PmQhwKGCIovR/ubPNIyOrPJb02k=;
        b=mY0O62DKoMr6sVa7vv38sRKUv84zgzzjhXt1hrGRSTmktoxDh5xGjc0AtacfyZDRy5
         73QtF6DSbbSirG5gl3fk58Qpbi4INC+6l9TWfo2XIm4mve0kBu3pozPEIMoNKFfxVB8F
         7CngpkXA45XNR6WpFJBAvjT/aWO2KzJ35jB9dCovJINepzlwahRSf95XmrhWnEq6xoY4
         /53v3Q3zehor/6ULpjJxR3eISadOHEb0i0FzartZGpYnzGcD821qyvJpjimdpMuanzPv
         xHsfnjF7VXhy9OUjZZ2EijsXeUPKbOYTuTyWQx2r7OGQ27jSHslW0cuWAx0xpFgecICO
         rS2A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Colin Ian King <colin.king@canonical.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 043/109] crypto: cavium - fix memory leak on info
Date: Fri, 16 Mar 2018 16:23:12 +0100
Message-Id: <20180316152332.314598267@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152329.844663293@linuxfoundation.org>
References: <20180316152329.844663293@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595109057362691680?=
X-GMAIL-MSGID: =?utf-8?q?1595109057362691680?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Colin Ian King <colin.king@canonical.com>


[ Upstream commit 87aae50af730a28dc1d8846d86dca5e9aa724a9f ]

The object info is being leaked on an error return path, fix this
by setting ret to -ENOMEM and exiting via the request_cleanup path
that will free info.

Detected by CoverityScan, CID#1408439 ("Resource Leak")

Fixes: c694b233295b ("crypto: cavium - Add the Virtual Function driver for CPT")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/crypto/cavium/cpt/cptvf_reqmanager.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/crypto/cavium/cpt/cptvf_reqmanager.c
+++ b/drivers/crypto/cavium/cpt/cptvf_reqmanager.c
@@ -459,7 +459,8 @@ int process_request(struct cpt_vf *cptvf
 	info->completion_addr = kzalloc(sizeof(union cpt_res_s), GFP_KERNEL);
 	if (unlikely(!info->completion_addr)) {
 		dev_err(&pdev->dev, "Unable to allocate memory for completion_addr\n");
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto request_cleanup;
 	}
 
 	result = (union cpt_res_s *)info->completion_addr;
