Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+RTmt+yqWJaB20dCCMi+V0OXivD2MtSnDjBS2L92l9b5YB/4SUO135GxkvfA5LNYuMEDRk
ARC-Seal: i=1; a=rsa-sha256; t=1522346904; cv=none;
        d=google.com; s=arc-20160816;
        b=ujueCIgvdDW9RGm/YbfpsJtcDVCDEDV4YVxe2wNPKaXyCr4MjN/M6izvygwe3WnOYH
         wRNF1M4/X5vc23++2viCEXUbsMZiLlTNwmlBWXc6CHf68G/7y9D8LhwBJhRdrKMDBwbX
         qiqizRTUE3EYJeq3cNqmRuapglQqp5JD5tPGkIvFqERWIeYabQLowJe4T3y6NFUo7uw3
         gjkm+MMFDSxJG+5isKP5pNfe5j1cIoxB72v7i+t9dExezEMaHoXq1lOMPxEy5aENgC1U
         Yh1r24HVanDPZsGjK1B071dDx9Wugi4KpTMA36jhX6RzRxZYIaqE1cyLSHf9dqoDSdib
         RHFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=i6Lcc2bLTHSwl5zzGKl+7VfL7RLieU08jO5HaTdZpcc=;
        b=fJFB/JzCOOqPhQEqV/heMfRZj6GXsPWbNhcsywmxMotp1rNgK+OJpSF1eSgkhzyTPq
         /lptB+GK2mnCVDUtYJSgzwYlnidmDQfgBd/FVLqv1/8yEnDwxfuSoFYZLlWgx0PtyRbV
         TXLJGYQHlB0yasQfo1+4GoTimDPAoIlRQuWzXPDSFy9qSLqO5GYBwvJp2O2AucW6Uiqf
         ckUrferiKjdoX3B38rSyVPnxUS+s26ZOJtO54wpyK+1qMwrdASdtpgVPFDTCW+QsKt61
         TbyEroaDlGug9taF0YSshl7jNZglcye0xF+WOJ2fWkOJArDZ9jhYJV6H5rnAIvpCUxEg
         MF5w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 19/20] net: fec: Fix unbalanced PM runtime calls
Date: Thu, 29 Mar 2018 20:00:55 +0200
Message-Id: <20180329175742.846541532@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180329175741.886181131@linuxfoundation.org>
References: <20180329175741.886181131@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596296106771354924?=
X-GMAIL-MSGID: =?utf-8?q?1596296427979484074?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Florian Fainelli <f.fainelli@gmail.com>


[ Upstream commit a069215cf5985f3aa1bba550264907d6bd05c5f7 ]

When unbinding/removing the driver, we will run into the following warnings:

[  259.655198] fec 400d1000.ethernet: 400d1000.ethernet supply phy not found, using dummy regulator
[  259.665065] fec 400d1000.ethernet: Unbalanced pm_runtime_enable!
[  259.672770] fec 400d1000.ethernet (unnamed net_device) (uninitialized): Invalid MAC address: 00:00:00:00:00:00
[  259.683062] fec 400d1000.ethernet (unnamed net_device) (uninitialized): Using random MAC address: f2:3e:93:b7:29:c1
[  259.696239] libphy: fec_enet_mii_bus: probed

Avoid these warnings by balancing the runtime PM calls during fec_drv_remove().

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/freescale/fec_main.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -3539,6 +3539,8 @@ fec_drv_remove(struct platform_device *p
 	fec_enet_mii_remove(fep);
 	if (fep->reg_phy)
 		regulator_disable(fep->reg_phy);
+	pm_runtime_put(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
 	of_node_put(fep->phy_node);
 	free_netdev(ndev);
 
