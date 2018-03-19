Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuwt3puBoH2ZafIuF7GM2s2rbjOXJieu9T48I3zB1eQ6LycHWPY5IXD2eTHhtUc2OOjQZwN
ARC-Seal: i=1; a=rsa-sha256; t=1521483990; cv=none;
        d=google.com; s=arc-20160816;
        b=VHIobMOc+b0YRX0N9BkH+1b07jfsrXnqaLoC99LbkB9Iz69w7CwO3P9/I1YM2ZTdY0
         P8tZCze/ki3+z96UGh2ualsE7uBSVzUrMk3z+h3oWL2wJKfZ3H90U8VG0p3ebcxzakzm
         ghzTljqLIJJ/MHXVqrMrAej8aHV1NhCNb2sIM/BCvFngOynY77tkRqMq3nGeYHq5Y9XY
         FQfMj0byFJlTsbUKE7mbnIaaNaNt7q1+P9VXePEVFHLa8so/4UpCUIdz0j8shsR29RLp
         mw8Rv8v+NaO+INsqJnwfcyDT90EMBFDyN/K74K/8eYC6McrWkVVIKGmGg4uTpb9u2M4X
         NGXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=bqZIqTtjUBBYii5crSqNIpD1Lj5U9r1LkZGsCwp0Iy0=;
        b=RafM4ybfDZWlCP8cJFnN5Xz8UOzTWh/EKVt6S1oScYZVWZ6K/HFI9XIHXpkl/4w5Sg
         eDSwYSHjDijwk73qB2BTYRDpPL8MiAsqE3Wijyk7QHRwSV0LMj4OvuGZQRT7g5ukRr2H
         ol08i0ai4gzW6uEdPhQtteLqo1C1v5yEAMrlIKa7PhbjUNQgp57FGIFzueiL27ozk9Q5
         H05jh2tZV8OyEFBCSX45pPIGaa3UtBEKVo/CmbFPbivlBXIEeN1E6Rc3oJLpnw0vXNya
         gfRecqkHjs22YVdpKOSrekcmJ9zXfQMvpYitAYDvakgBKT7BYnos0z9LN0ToKcD6m/CK
         2K2w==
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
Subject: [PATCH 4.9 192/241] spi: sun6i: disable/unprepare clocks on remove
Date: Mon, 19 Mar 2018 19:07:37 +0100
Message-Id: <20180319180759.096633620@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390617085307752?=
X-GMAIL-MSGID: =?utf-8?q?1595391596667860726?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -464,7 +464,7 @@ err_free_master:
 
 static int sun6i_spi_remove(struct platform_device *pdev)
 {
-	pm_runtime_disable(&pdev->dev);
+	pm_runtime_force_suspend(&pdev->dev);
 
 	return 0;
 }
