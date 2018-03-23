Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuad3dVt91mD+mcteYUBCnOGGhP/gWVzNrXhZCqREWjhxQ9ljid+TkxR6QkoyBuBRSpW4fd
ARC-Seal: i=1; a=rsa-sha256; t=1521800257; cv=none;
        d=google.com; s=arc-20160816;
        b=hCPu3ELIHeYt2yQR8JLOwQQobE5GPul11y77bbHQLm5TA8sEEqqkhMRVqCqPHAbmTr
         +Umhd86Qv5LntBQrVXq2mO38vAtwpYzQmkxoSAWTzGI2+A+dTPolKqSLWHn9aExASZ7q
         aIXtVS6nQK84dDV32HqMGvof6uP8KKnmBWu3r7sneUGBunNDt2qYLBvRTQVCe8DSXF11
         Y8IESCGJy9I4s5WPlh9RBi/FZGuuPeNafTEdOuWxWvPZDsn3PTkX6Ae20fhPRlaxS6ut
         6L3gjx0fef5Wh/KOxv6s2bLOxcTldhri/6iKiuAsIzcqWtGpCURkYZNCA2eaZKmK0wpv
         CH6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=x7+ziCtadCvLkodyaE/E7EsqdVOk/j1l0nzK0wqrPB4=;
        b=WCPx7JXMiES3bqglFUrOcOHXaqfav2uk4e+1I7w3Vk75OpDjfHYlTO3dVd9e/bTTya
         uaRaX7xzRZNOuqpslHyy/UK7xCiVa1r6GUY0UO9rtpdsIU7JYd4huORLKFKUGnO+IIhx
         yh41LtiBaXxpE45M13jW4+0DEogogPUM+mlFqEP8ii6hilEr8TASCqFL49k/RtUSlvlI
         93wrSBbB6TLximYEpud4odQtXq96eVEQBDdd7jf/UViwQlwoeherzhf7cOqw/EgAZSSY
         BGecEb71TWpFkaJGkql0fkk4zEe6lzPfwB4sEpfPNCWRULNoJOX9jzUVwbOVRWl2aLiw
         Bojw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Robert Walker <robert.walker@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 89/97] coresight: Fix disabling of CoreSight TPIU
Date: Fri, 23 Mar 2018 10:55:16 +0100
Message-Id: <20180323094202.472118669@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094157.535925724@linuxfoundation.org>
References: <20180323094157.535925724@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595722035673432219?=
X-GMAIL-MSGID: =?utf-8?q?1595723226589631414?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Robert Walker <robert.walker@arm.com>


[ Upstream commit 11595db8e17faaa05fadc25746c870e31276962f ]

The CoreSight TPIU should be disabled when tracing to other sinks to allow
them to operate at full bandwidth.

This patch fixes tpiu_disable_hw() to correctly disable the TPIU by
configuring the TPIU to stop on flush, initiating a manual flush, waiting
for the flush to complete and then waits for the TPIU to indicate it has
stopped.

Signed-off-by: Robert Walker <robert.walker@arm.com>
Tested-by: Mike Leach <mike.leach@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hwtracing/coresight/coresight-tpiu.c |   13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

--- a/drivers/hwtracing/coresight/coresight-tpiu.c
+++ b/drivers/hwtracing/coresight/coresight-tpiu.c
@@ -45,8 +45,11 @@
 #define TPIU_ITATBCTR0		0xef8
 
 /** register definition **/
+/* FFSR - 0x300 */
+#define FFSR_FT_STOPPED		BIT(1)
 /* FFCR - 0x304 */
 #define FFCR_FON_MAN		BIT(6)
+#define FFCR_STOP_FI		BIT(12)
 
 /**
  * @base:	memory mapped base address for this component.
@@ -85,10 +88,14 @@ static void tpiu_disable_hw(struct tpiu_
 {
 	CS_UNLOCK(drvdata->base);
 
-	/* Clear formatter controle reg. */
-	writel_relaxed(0x0, drvdata->base + TPIU_FFCR);
+	/* Clear formatter and stop on flush */
+	writel_relaxed(FFCR_STOP_FI, drvdata->base + TPIU_FFCR);
 	/* Generate manual flush */
-	writel_relaxed(FFCR_FON_MAN, drvdata->base + TPIU_FFCR);
+	writel_relaxed(FFCR_STOP_FI | FFCR_FON_MAN, drvdata->base + TPIU_FFCR);
+	/* Wait for flush to complete */
+	coresight_timeout(drvdata->base, TPIU_FFCR, FFCR_FON_MAN, 0);
+	/* Wait for formatter to stop */
+	coresight_timeout(drvdata->base, TPIU_FFSR, FFSR_FT_STOPPED, 1);
 
 	CS_LOCK(drvdata->base);
 }
