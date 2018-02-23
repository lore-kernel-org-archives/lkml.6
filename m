Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224+etKJDCfRkyx2r55ylmACO1gd2lRsDKvObxYBbg7usnSfKMdR4y8fcR65Cen7fD/i3Ps9
ARC-Seal: i=1; a=rsa-sha256; t=1519410908; cv=none;
        d=google.com; s=arc-20160816;
        b=VhiyFxlYFELoYSsl1ZricSNY78abhQQAUk/UsGeQR8Zd+WuxasyNRFBiv9Jx2TQIjG
         F4tGSP1jD8pJyDheJBrcg+1CPUyaMX0+R3mV+MBv/5lmo+lZlUW+nU2zigYWQ7DIgZNs
         SV9ynURty6GWg9Oh56Tq3M5ip4/NxPRsdpL08npviZy8CGBty3shvl6VuR7V1p2g8Z+D
         ihvshYWSiOjJALNb6LEq+560sGXLd3hCyg3QFjo0Iu9DpwjOxCs2HizLvG5LpGXteRar
         r1CV5lJrPoh41ZHqEOt0TS6MHKSlsfTMk9yitmqMr/orH/vyGIMb7PJg6I3F7bHBT5+V
         rr4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Ms70K5zx6A7MN4u+p0/Gll3fepV6zNSsEJMBwt8le6Y=;
        b=ruXqyafndE8iKzX+1YP52gt5c8VU6F5ANeWCzpwPEh1mqPoQ0olKhxwm6krUcwZMK0
         FZiXpkH8xDu9AKFZmuTL9W28hocAuxpN0jHece8xe8OwOFPjpIy58fDMY17zcC4xCUEi
         Qc/pCD7oLq/RN6ERox+lDNItofLhKJgtZbI92axgUdPpKF7hExX3+IEHZxHDnYthO63w
         bZ2zKgQtghic+AE5fuYoCFARNLNyR3JN0xt8WJzXOSZL/OfoTKVZ/ZNMeYlviuvZAgjJ
         ArAn91FFPuLKn4XCHcAGb4LOII58r4cWAWNrL7cT/edJpJqMh6pVdeJL44SVyxdxQ2No
         /HsA==
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
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 054/193] spi: sun4i: disable clocks in the remove function
Date: Fri, 23 Feb 2018 19:24:47 +0100
Message-Id: <20180223170334.482991456@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593217615746323655?=
X-GMAIL-MSGID: =?utf-8?q?1593217812413761245?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takuo Koguchi <takuo.koguchi@gmail.com>


[ Upstream commit c810daba0ab5226084a56893a789af427a801146 ]

mclk and hclk need to be disabled. Since pm_runtime_disable does
not disable the clocks, use pm_runtime_force_suspend instead.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Takuo Koguchi <takuo.koguchi.sw@hitachi.com>
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/spi/spi-sun4i.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/spi/spi-sun4i.c
+++ b/drivers/spi/spi-sun4i.c
@@ -458,7 +458,7 @@ err_free_master:
 
 static int sun4i_spi_remove(struct platform_device *pdev)
 {
-	pm_runtime_disable(&pdev->dev);
+	pm_runtime_force_suspend(&pdev->dev);
 
 	return 0;
 }
