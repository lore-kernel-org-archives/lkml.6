Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvJk0YYERX2yzBdzGVk6vtnalpgvD9byPNyGMhKcUG0i5b4fHORoBxOncxn2htFYdVodvQf
ARC-Seal: i=1; a=rsa-sha256; t=1520954889; cv=none;
        d=google.com; s=arc-20160816;
        b=icd5YDMC9StfM4g60PEkXCwmiUmdgssQ2KrDAADqqgpZPtSyWpT5NyIP1KtS+I+iiW
         8ukUC7FhNwYWZYIpmsgCtw7kdI4rPo5qHk9j4P1xlUwIIHBVeAq5j2ftKcDQcEmV4IEJ
         uw/BeTBIFlD75U2bwbPbjTxOzE2s/4JgEoc5xqaWwULrSh2wpqzhnMUxb/gzBjDPF9h4
         N3dz7fn6siv7blF4ZTr/OVMNA7gGRI8atowEMasDyop5frivZmUp8LfV9lfoVdPXXviO
         mHwA9u46u89ESWPVMC8q/kH88lRJ/VLWoQsTb2JhyS9w1J2rnmWrbKSY42R7exUNnpLc
         lVHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=9rphx8PBOSSwXUoELe2gcAp3+07qASwgUKr5gOUqjfI=;
        b=C0ZyU79DCdk90H6u8bu6ZbXTdnYrwpNVY8R3DlRD84eeFOOeBOEN7btELvaNsrZFMT
         w9vcGSypgvnxvfGeAwBi5HSTI7l1YtcFHCpEY8ujQwwVT/P/2VQCpdA7qyFMLflCCb6H
         O49DNqvcIMYrGUkKjMZEZWND0/HeAZ7yd0pbvX2jrbrNtsM4xGO3/W+P9Dti83qMnJZG
         HZ+WniQVctbVeulQJDF7O23x1wf8DB4pHkpYmZolqVEvvI8qYMhpxN341MV2flgS7t1M
         XgHNXE/NsbCDaRoZjkU6QepUtBHneK2yX4e8e+LDf+Y9ujXiTEiO2hzXuHc9zsjcJjM+
         2MCQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Fabrice Gasnier <fabrice.gasnier@st.com>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 4.15 008/146] regulator: stm32-vrefbuf: fix check on ready flag
Date: Tue, 13 Mar 2018 16:22:55 +0100
Message-Id: <20180313152321.251254349@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152320.439085687@linuxfoundation.org>
References: <20180313152320.439085687@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594836794091924222?=
X-GMAIL-MSGID: =?utf-8?q?1594836794091924222?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Fabrice Gasnier <fabrice.gasnier@st.com>

commit f63248fac563125fd5a2f0bc780ce7a299872cab upstream.

stm32_vrefbuf_enable() wrongly checks VRR bit: 0 stands for not ready,
1 for ready. It currently checks the opposite.
This makes enable routine to exit immediately without waiting for ready
flag.

Fixes: 0cdbf481e927 ("regulator: Add support for stm32-vrefbuf")
Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/regulator/stm32-vrefbuf.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/regulator/stm32-vrefbuf.c
+++ b/drivers/regulator/stm32-vrefbuf.c
@@ -51,7 +51,7 @@ static int stm32_vrefbuf_enable(struct r
 	 * arbitrary timeout.
 	 */
 	ret = readl_poll_timeout(priv->base + STM32_VREFBUF_CSR, val,
-				 !(val & STM32_VRR), 650, 10000);
+				 val & STM32_VRR, 650, 10000);
 	if (ret) {
 		dev_err(&rdev->dev, "stm32 vrefbuf timed out!\n");
 		val = readl_relaxed(priv->base + STM32_VREFBUF_CSR);
