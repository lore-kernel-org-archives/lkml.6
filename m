Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsiEhq5Wm/kH/5KtJMV2HlvbeMR13wkLltbbatX+Ry4XmkSO7zZ2mxmaJaXqqCYBHUQmJms
ARC-Seal: i=1; a=rsa-sha256; t=1521214879; cv=none;
        d=google.com; s=arc-20160816;
        b=S7ouW82O6q+xt9DheHGDB9XPOURjNfjIZgYdDglDuJBINk9fn+NLhTTCeDDq/03Wzg
         ZPpZNW4hcL8P4xhRTrdZavOXZFCbvXTiV88XW/53sDINUyZRHY5JV8JRXUHaFYJqifkH
         p9pcal8TnaK8v4MCHEsvb9+2Be6nbV80LqXJyUReDoHqBWXQWH+N8PPKLjwqJzU06k7p
         Zv4gV87KajKKhtT/lw/5UvrMmxisA1wuQ8Ruq0+7A4YFV7LJZlG0KxYzLAW+o4naXF8s
         g4Kcfr/zguuFBL3+TuEJUz41ldFEKCVvCtrj8zGSMPcgnUEmq31syM5hlIp+E9+FSyuq
         EoOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=gAS4yuQPHuqxUqBtyGvMz3thGn0YFsfkag8eBF++jbA=;
        b=mXvxAeplx37m8W23Gw5wgDTYjOz7+bCEKRZ3e56osv+PVLdzfcbIugjYuKDbD1OjmN
         jeufoc/PzAhFX4NOyV0TVLlRtSJNvdoeY7yfBD0GGLBZQOGWANwn32Z1aHjarGwI8wtr
         bIUYVpBxHbu+hPlQ2/OwcjAmwXb7aZXRf/NwGkNjZ4dngTB+uedAz36h2TxPJOVEPPfW
         5ViyhTGiq6qVA9ZO1jF2Np29UCCuOrmy6fkqgYIzSXkMoq227P6p1Z6CLC2AbctYpT4l
         IuDKwz4ShAQ0IQqCDUlLrKqXG8Jz4AoXgAmw1/gLiRTZDIQqWI6C1qoV71iItsyQhMTI
         z5KQ==
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
Subject: [PATCH 4.15 051/128] crypto: cavium - fix memory leak on info
Date: Fri, 16 Mar 2018 16:23:12 +0100
Message-Id: <20180316152339.388038370@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152336.199007505@linuxfoundation.org>
References: <20180316152336.199007505@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595109057362691680?=
X-GMAIL-MSGID: =?utf-8?q?1595109413751566200?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
