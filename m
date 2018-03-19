Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtwW0Pfn+3I7bli2XOBzx7/BJe+Kzm1j88s1J6tpFrI/e/nvkdAILpwbsNRQ3UMywsTIXnM
ARC-Seal: i=1; a=rsa-sha256; t=1521483406; cv=none;
        d=google.com; s=arc-20160816;
        b=bxP6zbHIxM0PG38B9O1wPIqlZqjyGX8O/dFUFYTs21PZJ5W3uHt6QrJk9qLmkSCdt9
         BErVmJntixpri+HFpk+0kvyKH1HWUJX8LB4B5D9j6+OTvIfaY4sej9yWjim0t5TJdghL
         ctYW9sWUq9gMOeBh3Cm1yppabu9Taa5sTwBO5L0U8C/11VPkB61VKjpx9QDaGz19GA+j
         nod4ucRtQQvPDgQZpHsk41cqOf0ygC5BzqUKY0cibpv80s8xpPHH0mvZs17cUqGrmNc/
         21YHR7/Cv3yEydhPyd6UCTUb36qb1dLPVQ3Hzw90z6wr7cRQexcLfzRqk1GtYaOT9Bur
         IEJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=h04dD/GypLRZwSKIS2sLMLCkKvA1nriEMHrdRTbLB3s=;
        b=PoU1LS2rT2PbSFsFumIkLLnD1uT3CYCVCU9I7KGXz3UfuqMn/nBGS2LBkdwJQ6CXl9
         8hTrBvzf0ZaAZo6uxkoyX3M3OIlO+Ck06AHx+zowZgpjvWeeX7gOjvFPlUvD42yTTuGY
         iXa7HfJcUDgko6lh7tMLIZ4Wv+D3lfdo2+UUVCUA57ZjlQZg3lP7W0YRJomgkCbOp0Eq
         GS9IbPx4HgFSe+A/qWtscKrSnd0M1pSO02u7XaQYACStixPMxwOtGz3sf4lceTFw1LBC
         ZlJ3og7dngl/1N15B+8cLOWmgIAQuKiuLzhlWtWMVDYKx/DrgpVSyKIUXAOYo0TZkR1p
         yuBQ==
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
Subject: [PATCH 4.4 078/134] wil6210: fix memory access violation in wil_memcpy_from/toio_32
Date: Mon, 19 Mar 2018 19:06:01 +0100
Message-Id: <20180319171900.560753155@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319171849.024066323@linuxfoundation.org>
References: <20180319171849.024066323@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390681603963623?=
X-GMAIL-MSGID: =?utf-8?q?1595390984787163059?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -125,9 +125,15 @@ void wil_memcpy_fromio_32(void *dst, con
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
@@ -136,8 +142,16 @@ void wil_memcpy_toio_32(volatile void __
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
 
 static void wil_disconnect_cid(struct wil6210_priv *wil, int cid,
