Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2259jR/nac0VtOlh7KQvYCw00ABdUNwUc16zzt6Nf/cQ2yyzV0ZFr+aBzLor1Yg69meosSS3
ARC-Seal: i=1; a=rsa-sha256; t=1519410987; cv=none;
        d=google.com; s=arc-20160816;
        b=IWudFiaq/ldujK4rDjE5jwJKpQAmuRIvMDPXsZL1n0nZm0ZQBIvpya9u5ZEpXwjRlT
         h9lMMZUiTZpUFdMGp3QQj6f94BJluW0m33E8LpQY/g6RPiuc+evA2+kv2NpfyLCb1PKb
         Aso3zpuUoh4UngNoOIZPVJVBsoH01psXc3TVBXGSUy3417ad2yjYKBTb2tDeK+Jc3pMC
         c32T4a49JVebx5T8m/J5eeL1o2bvJAUTv+g8gXLUJLOBI2psFiHvssY3kl7U1WM6srcX
         LmuTx2OzM5Psou0//aNWaisO8G0fggns5ztZNNxv/Sij7neRQmT8129E/ekepfNtqqS2
         3OqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=WLduuRkSZl1JmCTw61MWlBa3zpia4u7YpUWPklIbjfg=;
        b=HHq8SyxaaQBUFZKkVvtE7evjMc/NW0K8ZzMWkred859MT59gukGySZ9EirFgxO1LTo
         mEVl615331Zg1UfmrcG4u5Hmk89lRy7VzeNc0OGS0n9u+zhctYeIKZkNa4DaiNmp+X28
         xWiiXJ5UTfA8RtQHizo0OKJ5U73w0hqOaMPlTQq652tMg8vt1C1NAjgEOThF3JDkW9lI
         lkFCpr2rYZf4oHZF74X1tlNp6pjnw75yEEvvNoFz8Y5ZJmtBnxyjHYCde2ROPcIne/II
         MCA5/z/6Ea2wXpqk9vwlbEDZ8KdiJWrt7yO6Jc7bQMZI+i4U1+1xP4XO3N85ItPGszYW
         MBaQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCH 4.4 082/193] thermal: spear: use __maybe_unused for PM functions
Date: Fri, 23 Feb 2018 19:25:15 +0100
Message-Id: <20180223170338.856572963@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593217895277293467?=
X-GMAIL-MSGID: =?utf-8?q?1593217895277293467?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit d612c64d1f4d6b2464993dfeafd9ec319f774188 upstream.

The spear thermal driver hides its suspend/resume function conditionally
based on CONFIG_PM, but references them based on CONFIG_PM_SLEEP, so
we get a warning if the former is set but the latter is not:

thermal/spear_thermal.c:58:12: warning: 'spear_thermal_suspend' defined but not used [-Wunused-function]
thermal/spear_thermal.c:75:12: warning: 'spear_thermal_resume' defined but not used [-Wunused-function]

This removes the #ifdef and instead uses a __maybe_uninitialized
annotation to avoid the warning and improve compile-time coverage.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/thermal/spear_thermal.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

--- a/drivers/thermal/spear_thermal.c
+++ b/drivers/thermal/spear_thermal.c
@@ -54,8 +54,7 @@ static struct thermal_zone_device_ops op
 	.get_temp = thermal_get_temp,
 };
 
-#ifdef CONFIG_PM
-static int spear_thermal_suspend(struct device *dev)
+static int __maybe_unused spear_thermal_suspend(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	struct thermal_zone_device *spear_thermal = platform_get_drvdata(pdev);
@@ -72,7 +71,7 @@ static int spear_thermal_suspend(struct
 	return 0;
 }
 
-static int spear_thermal_resume(struct device *dev)
+static int __maybe_unused spear_thermal_resume(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	struct thermal_zone_device *spear_thermal = platform_get_drvdata(pdev);
@@ -94,7 +93,6 @@ static int spear_thermal_resume(struct d
 
 	return 0;
 }
-#endif
 
 static SIMPLE_DEV_PM_OPS(spear_thermal_pm_ops, spear_thermal_suspend,
 		spear_thermal_resume);
