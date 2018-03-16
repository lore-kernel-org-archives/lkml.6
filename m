Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELt0YvJTKj5tkUVVQlZ7B5EddLJ3jImBphOzwbbe2sj4KvRc6ykf7Iva6Lset1rjd1znKCUb
ARC-Seal: i=1; a=rsa-sha256; t=1521214656; cv=none;
        d=google.com; s=arc-20160816;
        b=gpDWs0wWZquBm1nDcUsIEyX9p1GRSQ4bMrQ0N3sFWfEdL3nZKSpd6ZJ1LouX7LDaOS
         s3eLl2cY8UC0NBxqPRcLa/v53tSx0Cit9D9F0W0xwodWkccrg6z+9Ylzypdbakq/Ybcl
         2E7/BievB13kM19MZNu3VFTSdAU0T/0ix3oq4s/Iz8K+9t/xdAFPlnZVyygKJOIpTEaV
         U6FRlkCRpxxG6UKT7psTwX3y0Uo654N7+FJRA3mxc3pkibaPmRC6nh/zcHWMmCKhcqD4
         iC2IEuwYoRBcqtABWg6uscUObISXRzffqRM6qO0gtsyClBLL7kR1FBAcudRuzODTvZ7R
         rw5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=bpXkbahbgWXBnvYgKXAnIxJxMMqoKbq9dhWBT5nFHDQ=;
        b=zkPXdROxFQddOeN/lBYyAslCuKTBEJtA85zilj0M8VWipD5Nk9dFwrDrgZzb9iPTC+
         4mHFLt3JHR2Vgk4al6zuxXrGojl/L9PNt3BLHC/GO5CUSDdva9Mern+9cofC+95DI9WU
         iFkmKBBHIElIv/KtabVvHounnWVSqkkFQ5f/OHGY4EdRFkq5dIHMkBDiSTJyRkIozFoe
         XTkZL4lolwUkltVozZL0EepOu8o7tZTxlUGsAPEYMVWOkZsr3u5u5REHMDcFJwB8ilkn
         odkGlAaGXrGPMAXC+e7C1zEto/YVwmvY8ikd/mYGYf0kwRhgrQmjQgvJ36qX5jJWsWmZ
         l6IA==
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
Subject: [PATCH 4.14 080/109] spi: sun6i: disable/unprepare clocks on remove
Date: Fri, 16 Mar 2018 16:23:49 +0100
Message-Id: <20180316152334.307913464@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152329.844663293@linuxfoundation.org>
References: <20180316152329.844663293@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595109179268049737?=
X-GMAIL-MSGID: =?utf-8?q?1595109179268049737?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
