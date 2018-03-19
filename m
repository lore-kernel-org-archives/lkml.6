Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvE/8WZIlunir2UZyUvBvAWHwX6cRiUBbeiRr46jJA1QFvyC+jea+f/wrKtn0YKZJ+ML8ms
ARC-Seal: i=1; a=rsa-sha256; t=1521483117; cv=none;
        d=google.com; s=arc-20160816;
        b=GQqyq9u/rDA7FUzX+beEToX7RyMMm1m2VmXn5O0L4d8ZWLo4sbWE6wenza5ZRMb9SW
         oXI2MeLZdxA/Jxajxu8n0fvRCu/IigldJOyEnzd/6r+geZgpuBW0ObxDjx0FF1Wou0IF
         Yrq/n6WPSk9ZnhPWPCILonmg+7Fxl4cBujbMIwet8EimEANKfsZo213CQfDeUFZNGtVo
         DUpBpgJ+RRN4N2jr9XcS3QcnlRiVSCFJicpIbvN5h2lf9SVDsJV5+JCahLj9sHtiFVqc
         xNDYOPlrOQQZo1ih+mXI8l4t9iFklRr8wQF+W5S7iQ4tT9brQcIHVsPYMKYTyhZ85L2J
         vrdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=EAyxD6qFt5LcxD6hOsxZrTbwPRVEQ10GXwyCQsKRCD0=;
        b=B5XAI0ql0YCWNefgHTDydikOA5XavmabRn6xvCJj6Bql1CM92k3Bne2JK/zlNzGw3B
         7EGK7/L/x9TDVg6/jAfIJv1aqHRhNDNuWEdNfthDfL1/bxjtmQHJkUMSA2g/O17yGN2X
         db7B4vnHbDkdgNuqbu0DJELZ8DhMWa+0nFDWyxgwYo/EI5Wf43n5NrIXAFRwU/YD91VR
         je6mxNQTwPbDSzHCfygzidbkbF7XCPVHKRyDJPxzYLQpGdpsxnMSlzfqoi8ARJvLOtxl
         jDTUYxViZ8MBAhFLUKIla+H9RjI6+5qVOa/JUBN5umrrzOH3/4vyu9kQeVPxssXRPCpg
         OhIA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Dedy Lansky <qca_dlansky@qca.qualcomm.com>,
	Maya Erez <qca_merez@qca.qualcomm.com>,
	Kalle Valo <kvalo@qca.qualcomm.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 43/68] wil6210: fix memory access violation in wil_memcpy_from/toio_32
Date: Mon, 19 Mar 2018 19:06:21 +0100
Message-Id: <20180319171833.920667087@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319171827.899658615@linuxfoundation.org>
References: <20180319171827.899658615@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390681603963623?=
X-GMAIL-MSGID: =?utf-8?q?1595390681603963623?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dedy Lansky <qca_dlansky@qca.qualcomm.com>


[ Upstream commit 0f6edfe2bbbb59d161580cb4870fcc46f5490f85 ]

In case count is not multiple of 4, there is a read access in
wil_memcpy_toio_32() from outside src buffer boundary.
In wil_memcpy_fromio_32(), in case count is not multiple of 4, there is
a write access to outside dst io memory boundary.

Fix these issues with proper handling of the last 1 to 4 copied bytes.

Signed-off-by: Dedy Lansky <qca_dlansky@qca.qualcomm.com>
Signed-off-by: Maya Erez <qca_merez@qca.qualcomm.com>
Signed-off-by: Kalle Valo <kvalo@qca.qualcomm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/ath/wil6210/main.c |   20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

--- a/drivers/net/wireless/ath/wil6210/main.c
+++ b/drivers/net/wireless/ath/wil6210/main.c
@@ -59,9 +59,15 @@ void wil_memcpy_fromio_32(void *dst, con
 	u32 *d = dst;
 	const volatile u32 __iomem *s = src;
 
-	/* size_t is unsigned, if (count%4 != 0) it will wrap */
-	for (count += 4; count > 4; count -= 4)
+	for (; count >= 4; count -= 4)
 		*d++ = __raw_readl(s++);
+
+	if (unlikely(count)) {
+		/* count can be 1..3 */
+		u32 tmp = __raw_readl(s);
+
+		memcpy(d, &tmp, count);
+	}
 }
 
 void wil_memcpy_toio_32(volatile void __iomem *dst, const void *src,
@@ -70,8 +76,16 @@ void wil_memcpy_toio_32(volatile void __
 	volatile u32 __iomem *d = dst;
 	const u32 *s = src;
 
-	for (count += 4; count > 4; count -= 4)
+	for (; count >= 4; count -= 4)
 		__raw_writel(*s++, d++);
+
+	if (unlikely(count)) {
+		/* count can be 1..3 */
+		u32 tmp = 0;
+
+		memcpy(&tmp, s, count);
+		__raw_writel(tmp, d);
+	}
 }
 
 static void wil_disconnect_cid(struct wil6210_priv *wil, int cid)
