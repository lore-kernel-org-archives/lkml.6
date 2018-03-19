Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuRAynTVGkWP8iD2pqpxKoN1CLMd1i3naMYDjytPsVjvvMXL6IU2/B9A703+y+8Z3ifGREL
ARC-Seal: i=1; a=rsa-sha256; t=1521483908; cv=none;
        d=google.com; s=arc-20160816;
        b=p4YkhzBKz3bH0Q/DdXEwSh7WNMqZ2eJ8sV1FikV5MEezkhxpYb7ufPJu8Q8vZfPnEk
         BpugeLP8VVqbgXvaE48H84Eq0yqaUtQzaJMViSqM4jlAIgGXmQHqkdcTUwkuhyy1Pk3i
         jFbEcdJexE22objjGyK/gFTqhrciLMjCDU38XGaN8ETpzt54D6DIkqPESYU7fMbzKKUU
         6r7+qYvEIZsyvSmkidXH9/nCmBNyEUlHnAfwjkmpVS9efYUIge1qhexySnb1oc68fyxL
         Q6mU36u3BeHmTkDmULcNkkmLZwtrZObkTTtyAFACmAIkUswzrvkz7u6EH3PSc46GEkvr
         P/tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=15uYaYbL7FH7jWx31/m2mQhE9pKC7thxW5vg0tJ3bEo=;
        b=Oie1K5A2pgCY9ikGOb5GCq1XyiJSoOfO0/VZwUZvLCX3fPjQGI/pMRrYrvbHBr20xe
         r2HrNY6KovcMPjcfmHxoMy5ml48G4ZFRLMZGqojelwQNqp4Yqd/nLVF+NP6VxiHI5jNI
         74OJ7RO8PlBQnx2ZgQqosTpIS1ozakM3NIHtm0+N+n2Oksrk+7qBTmm/XnTS9f0oq9F0
         nfLeSfWiiOpNSuxtLszbWDZZuEbR804GkX8MQo/CwGwKIFWNHj68vGFVgMVssnM7qWlV
         3Lci/c0EiqHs4ZsoUbFDH6ks5a/3EDITB0q6M+LQs7Rq36IUbNxl81Wn6FYIqY4ouYOI
         XsHQ==
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
Subject: [PATCH 4.9 161/241] wil6210: fix memory access violation in wil_memcpy_from/toio_32
Date: Mon, 19 Mar 2018 19:07:06 +0100
Message-Id: <20180319180757.833009819@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390681603963623?=
X-GMAIL-MSGID: =?utf-8?q?1595391510610889002?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -129,9 +129,15 @@ void wil_memcpy_fromio_32(void *dst, con
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
 
 void wil_memcpy_fromio_halp_vote(struct wil6210_priv *wil, void *dst,
@@ -148,8 +154,16 @@ void wil_memcpy_toio_32(volatile void __
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
 
 void wil_memcpy_toio_halp_vote(struct wil6210_priv *wil,
