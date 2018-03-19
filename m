Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELskmC5l3Z7z4cSTHZJ7O0UXs0Scn4RURh9Kn90RiL0dT1GLQ9XJznk7Zelub67qYCsx9ZOb
ARC-Seal: i=1; a=rsa-sha256; t=1521483363; cv=none;
        d=google.com; s=arc-20160816;
        b=WxuUACK/gQ+zY9+ObGNTC5DQy1UWDk3F7z7hXuXrwFNXeC69S85frAk3AZj22k80aB
         B+ABZYRhQyPgIIqH0gH5DjU4ppOxPjNmqf0+SXcUQ+uQiKSfD4IpDj4lkF9PsR7MAVTf
         PYX1Og+HIwhkDl0HwsgtGCqGnfBX7J6xZIQBK5kHz+XcE3chd0P8va7FKW7BzN86DHgR
         G2DdDFFGDnS42OJbafRYsKfC/liiwYF+CttTLb5uqtX6/CIvUbcgmYxaJmwZ4YVxsGxO
         iJZ5g8B1YYCHqOUnMVGZpVIzKZs6fiGeCMYY27peknadej6q4LJiDxhEwxhhNGA0e2oP
         dN6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=zFictjqTi60zinbDczVqg5q2qb8+AAub/CzgtMe+7+4=;
        b=Dtg9WCAwFMpSEePvAKA6CIUF3lqPk7xdS69P+IobO+BOq/H8b52C427ur9wn6S0Bt8
         NhFUbhMVlOT9cOb4RmUR8zEJWaDQxLw7ZO9MjbXPi9kt6vYetX2iPQ5imnUvJsKdTHa4
         1jX6w9WzyMz0Cf6NVQb13M7KSB28HJdL7YKFvJaGBRP8L28mJvYPr7ECnVMYxziQXpBI
         OaU9onoF0Csatc6zfa/VV7jDacGRbBKT0I950F3THMvIzQEPVKO6u6sig87IDIqSYbLM
         xS8E04TimDwlOMpsXmSIgAnNUZYRjgsy1a9PgqWnznUm4vo/MvUMtHSQ+YSrGNIul3a4
         0Qeg==
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
Subject: [PATCH 4.4 096/134] spi: sun6i: disable/unprepare clocks on remove
Date: Mon, 19 Mar 2018 19:06:19 +0100
Message-Id: <20180319171903.140193645@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319171849.024066323@linuxfoundation.org>
References: <20180319171849.024066323@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390617085307752?=
X-GMAIL-MSGID: =?utf-8?q?1595390939685312342?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -457,7 +457,7 @@ err_free_master:
 
 static int sun6i_spi_remove(struct platform_device *pdev)
 {
-	pm_runtime_disable(&pdev->dev);
+	pm_runtime_force_suspend(&pdev->dev);
 
 	return 0;
 }
