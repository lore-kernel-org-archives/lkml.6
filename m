Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49TXAIIspQJj5AyopJig0IaZiTUHCtRmfqtZeeXen+NOZfUw3R4hL/tSPQCivz7QSZZq5x2
ARC-Seal: i=1; a=rsa-sha256; t=1523022058; cv=none;
        d=google.com; s=arc-20160816;
        b=HjTNmOnCbc/sfba6boXxvWsifpP8963ZrljHI7bCtyYjBq2iHoYBTzXlw0CvaNW3cs
         aTiqReSw+/XKm0POlNYhpEnt+dTYvDo/xnuYl6JIIuW0EV6KeD9jNOb7qAIIz6dSIXjO
         sr3IvVOtfwLcPtFDf0HHZzpXhiX3GzgXc3SC2llz/G37Cjii9Gl6i6VaYQTkuQCF1cQY
         SjP+xMrjY0EkmxLW7Z5QVhofxSxWrZjTMoEwGwhKmquv7H4RHvCgBj8s2RP0CEvI0yf+
         wkx4kBolIwS+JFr5Y9xfXtkkgpmbO+eAtC/Xa261bCNBpXARqwLoUKgDBIsrj4XhG5Yx
         sG0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=7CccnfwMYlK66WN8GR9mdNLAP/fcrsK+Y3dcEXznVpM=;
        b=DNGNR1P9tzR0A2oNV6wbz3+2zVXBqmg/LarPA9bxUIc0HbBAeNOps25HE7c+0OIxaV
         Me7lo/wU6Wr347pP0+pb3dmq1Wfwkh1yQsy4fzldQIlesQesfRYpFG8rL6LvU+exUuPs
         yS0gUCWVeWHg0sWhMWtR7Hm/TyrpLln+fM6cQCnGHu/Pp3mqv5CwuYlqciaFI7e4A163
         /IG7YRSPYJw9HY/v9JQw1hmoV1sKUkDURUJGIrmAwQ0blY6MFNp4XYdfpwuwEDFOUlOb
         v4gyXjmULCMDhZAtXHMKFrQTyjDsapUt0a0scExVM59ZhOKtqcl+cZknqPWmiNGw/SfC
         0bYQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Pierre-Yves MORDRET <pierre-yves.mordret@st.com>,
	Alexandre TORGUE <alexandre.torgue@st.com>,
	Wolfram Sang <wsa@the-dreams.de>,
	stable@kernel.org
Subject: [PATCH 4.15 14/72] i2c: i2c-stm32f7: fix no check on returned setup
Date: Fri,  6 Apr 2018 15:23:49 +0200
Message-Id: <20180406084350.661098580@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084349.367583460@linuxfoundation.org>
References: <20180406084349.367583460@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597004174064141518?=
X-GMAIL-MSGID: =?utf-8?q?1597004378540178623?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>

commit 771b7bf05339081019d22452ebcab6929372e13e upstream.

Before assigning returned setup structure check if not null

Fixes: 463a9215f3ca7600b5ff ("i2c: stm32f7: fix setup structure")
Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
Acked-by: Alexandre TORGUE <alexandre.torgue@st.com>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Cc: stable@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/i2c/busses/i2c-stm32f7.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/i2c/busses/i2c-stm32f7.c
+++ b/drivers/i2c/busses/i2c-stm32f7.c
@@ -888,6 +888,11 @@ static int stm32f7_i2c_probe(struct plat
 	}
 
 	setup = of_device_get_match_data(&pdev->dev);
+	if (!setup) {
+		dev_err(&pdev->dev, "Can't get device data\n");
+		ret = -ENODEV;
+		goto clk_free;
+	}
 	i2c_dev->setup = *setup;
 
 	ret = device_property_read_u32(i2c_dev->dev, "i2c-scl-rising-time-ns",
