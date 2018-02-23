Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227OKIffXyNqq5Xi/TqGdzuXyhvw1LMfPWBdRi92K3Ng4noojxbaZ/2mJbd7p0HcrxdpOqQm
ARC-Seal: i=1; a=rsa-sha256; t=1519412139; cv=none;
        d=google.com; s=arc-20160816;
        b=DBwpo642qfhrQmjk1uSrTNvLP9O2+BTMn9zzHxloQfeB76LX63Uppvxa0Vl7XvZG0x
         7xoi82GgloiPrjCw8E9kT0KlP3gyW2BFKeIOPV1BgXrLFx7G9LQJ54Stv8jOnxBJvYRl
         8QtctssDbBOTUeFPO+kndwhf+jIT++MFLl9de/hY/NzHvoiLK0BuItQc+RW1ipAfAKhq
         eu3UCp1tbn+TX95DHWVHL7fa7kOkZ8pZZLfMrmriAifnojG3v8yHdnlc0s0sKZFGA8R7
         npre3sv4bV0gkMP4EY2gpQGccYCCCTDFrBwjS8YbCkryBDZ0ZtVDsyoaNbt3I6ofVOmU
         W8mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=3m1sr0LrL+PjOqHPfk+lF4hS37R2gKR3corz4Zp2ZWc=;
        b=p2eSSE34VCby12pdvsG/neGIEL3T9tcb+kh3kKq/PdvVnXLC8BE/sOb504YOklr96V
         yxsO9P3YLFqI7bxJw/KXqGvdeQxOGEK6Ud76KWm8jCM4S1tBgz6pVp9X8TSwy6s7FTKg
         dhC7tI0VxHYw4r91Td7FibOHpvb5pbT+5RD8HLE/DoIP208dLjNDB90DmWNb1cYNka+E
         Knik+gxdANu+OfLnrxBFGtTdHzdbVL23gN142nE0EAafPvkpi9mjMh0Ndctj6vpBpqMW
         T0LMtuhwylqIGypd0t5HpZP49AYGJh9oj0v5R10leYZziposaUGYWFFaQZeDtUlRbivg
         BGfQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Takuo Koguchi <takuo.koguchi.sw@hitachi.com>,
	Maxime Ripard <maxime.ripard@free-electrons.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 138/159] spi: sun4i: disable clocks in the remove function
Date: Fri, 23 Feb 2018 19:27:26 +0100
Message-Id: <20180223170759.750887009@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170743.086611315@linuxfoundation.org>
References: <20180223170743.086611315@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593217615746323655?=
X-GMAIL-MSGID: =?utf-8?q?1593219103081558668?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takuo Koguchi <takuo.koguchi@gmail.com>


[ Upstream commit c810daba0ab5226084a56893a789af427a801146 ]

mclk and hclk need to be disabled. Since pm_runtime_disable does
not disable the clocks, use pm_runtime_force_suspend instead.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Takuo Koguchi <takuo.koguchi.sw@hitachi.com>
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/spi/spi-sun4i.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/spi/spi-sun4i.c
+++ b/drivers/spi/spi-sun4i.c
@@ -525,7 +525,7 @@ err_free_master:
 
 static int sun4i_spi_remove(struct platform_device *pdev)
 {
-	pm_runtime_disable(&pdev->dev);
+	pm_runtime_force_suspend(&pdev->dev);
 
 	return 0;
 }
