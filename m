Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELs2H0sL2HsOc0+DQom+exl4Nq68DtkY9PB3UNEE16r4BW+SvNwuZZw+F3moC5QqhpcNTbe5
ARC-Seal: i=1; a=rsa-sha256; t=1521215014; cv=none;
        d=google.com; s=arc-20160816;
        b=J74SCq9q+LEBBHe7YvXv6bhJxzHbFasHJFl9AV9zi9LOXm2Y6jqoNc42nLQ73wvlU2
         Uf2FKFGDtFIvkNzv+LkZIUu0XAbWS1dIWa4rhJYb/TX4EzTV59/gVF7EmWMhBsVkfZVN
         0UGsnwaGbz+JzjAfz1T5rrhiKXNoK24vtpT73nyqkaOQFv0vwfujf64WL+nIay/E13/H
         6n/GaZxImqLICElNBZIhCIo4anbogcA73pFFQszbgkJ1WPG0DMp3Q9AdkRNxxgRy9ZU5
         x2y9KdviOf8QapnTPiGe1oZoep0a1pgRdOUfndHBTafdy6gfHNsEO9+R2r84naKs1tKg
         jTJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=DU156U4cPJprZu/pfnnCxFVftZgx0wDFcILFs0GkNc8=;
        b=A24pxHC+bFLqQVvBvPSxouzWJbb/b9zN13+LURgiUBcjK7P5eOLlA04pnScjyKrABa
         FCIXBHT/ulRj+tvj0bJ1mrtgCXaRwSqiJXHOCuUKLYDZ21uebd/IGtQmgGpE5IG4QX/s
         t/higWj2Q37HkSi7/diCh00jaioeGAagYu6+cmODlJQ0k+UVZr89Vqdl5VqvOzKm0eYX
         hwDAPunhOD8XLBU9YepVSK1eG8f4uBFFb9Z5f8CIP2YEpyVGru+qM9CHXhhyuR5KWkym
         7nHc53PTRDU0OC79TZGLBMLcbuip3nZFy4ucpO+IQvDaWRREQs6BcqQYjMLF/YxAtwC7
         QFdw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Tobias Jordan <Tobias.Jordan@elektrobit.com>,
	Maxime Ripard <maxime.ripard@free-electrons.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 097/128] spi: sun6i: disable/unprepare clocks on remove
Date: Fri, 16 Mar 2018 16:23:58 +0100
Message-Id: <20180316152341.389442285@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152336.199007505@linuxfoundation.org>
References: <20180316152336.199007505@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595109179268049737?=
X-GMAIL-MSGID: =?utf-8?q?1595109554719434222?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tobias Jordan <Tobias.Jordan@elektrobit.com>


[ Upstream commit 2d9bbd02c54094ceffa555143b0d68cd06504d63 ]

sun6i_spi_probe() uses sun6i_spi_runtime_resume() to prepare/enable
clocks, so sun6i_spi_remove() should use sun6i_spi_runtime_suspend() to
disable/unprepare them if we're not suspended.
Replacing pm_runtime_disable() by pm_runtime_force_suspend() will ensure
that sun6i_spi_runtime_suspend() is called if needed.

Found by Linux Driver Verification project (linuxtesting.org).

Fixes: 3558fe900e8af (spi: sunxi: Add Allwinner A31 SPI controller driver)
Signed-off-by: Tobias Jordan <Tobias.Jordan@elektrobit.com>
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/spi/spi-sun6i.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/spi/spi-sun6i.c
+++ b/drivers/spi/spi-sun6i.c
@@ -541,7 +541,7 @@ err_free_master:
 
 static int sun6i_spi_remove(struct platform_device *pdev)
 {
-	pm_runtime_disable(&pdev->dev);
+	pm_runtime_force_suspend(&pdev->dev);
 
 	return 0;
 }
