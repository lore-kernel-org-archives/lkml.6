Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224ySd8oSgj9FZCH7RTnvKxGluF8eYFlXud/nUqYqvrOkhNQLcK9uFNyjjeDJ+xGEJwGPd2Z
ARC-Seal: i=1; a=rsa-sha256; t=1519411148; cv=none;
        d=google.com; s=arc-20160816;
        b=00oEk3ofTVZcfNiZm/F/Zw3apWAt+qs4hqk8DTQgq4B8JEm+2tGqnN2w4VuiPwfsTK
         JBXJze29nU7IhyFKX+Vv86Y1BUEd1z/J7x3G9lg0EiFpJ8/Aa9CNlmLe4RGiUDp6p/B/
         8r0wCl9+x9IzY16KEB65IMWAapCbufGhtCV8YnUlDOPvWJWOZro7MqWUjgOs2sczVp12
         nfmxslPAHuQvo4NjekyFUmLwdPM8KS0IDY3VSZ8hpAUld6xW2baFh4my65I6NegjHbSx
         bKRydMqKYu9cOdfJ9BWx9tt/cOuk93oRLHhEF7KkKPpGLf3i4uOiCrYruFMuhZM3VRvn
         acig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=19hXn8mEQ1F11MjN0JLWUAacC0hEeAun2msoTTxN2+8=;
        b=fcYTkkjOUlkBcl2LiOCuus2rSxwg3waRAnk6ZOXeyy/i3JRStXWdX3euzoBBEb95fL
         1QfZLADPgq5qWX8y1SPBeRfLYICboFXGFJH4hl72TDz4s/CoprsfGzZB0kKt3vkPZpLl
         s9BgrTxqUfBRM2zgtSBz5CIB0drcyc38k6aBpoYKSpc+kF5JtoQ3uQqMFpn0nUBugNj8
         9ip/MQWK5qwScs+x50B/jE52oJHifL6rPNe5pWuz9ahvV1ArrboDXAO3BKed+fnEsBBm
         AQiY8OXdWmbYKFOvYLWzCn0pr8nbrNuKyZ1Ssgge74TTm0CuXfaxTQTmwX/f/O/5zZk5
         Wc8w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 4.4 137/193] ASoC: rockchip: use __maybe_unused to hide st_irq_syscfg_resume
Date: Fri, 23 Feb 2018 19:26:10 +0100
Message-Id: <20180223170347.263000474@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593218063798398780?=
X-GMAIL-MSGID: =?utf-8?q?1593218063798398780?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit d8fc2198aab117a4bc16ee305caef19c4c7e7f5c upstream.

The rockchip spdif driver uses SIMPLE_DEV_PM_OPS to conditionally
set its power management functions, but we get a warning
about rk_spdif_runtime_resume being unused when CONFIG_PM is not
set:

sound/soc/rockchip/rockchip_spdif.c:67:12: error: 'rk_spdif_runtime_resume' defined but not used [-Werror=unused-function]

This adds a __maybe_unused annotation so the compiler knows
it can silently drop it instead of warning.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/soc/rockchip/rockchip_spdif.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/sound/soc/rockchip/rockchip_spdif.c
+++ b/sound/soc/rockchip/rockchip_spdif.c
@@ -54,7 +54,7 @@ static const struct of_device_id rk_spdi
 };
 MODULE_DEVICE_TABLE(of, rk_spdif_match);
 
-static int rk_spdif_runtime_suspend(struct device *dev)
+static int __maybe_unused rk_spdif_runtime_suspend(struct device *dev)
 {
 	struct rk_spdif_dev *spdif = dev_get_drvdata(dev);
 
@@ -64,7 +64,7 @@ static int rk_spdif_runtime_suspend(stru
 	return 0;
 }
 
-static int rk_spdif_runtime_resume(struct device *dev)
+static int __maybe_unused rk_spdif_runtime_resume(struct device *dev)
 {
 	struct rk_spdif_dev *spdif = dev_get_drvdata(dev);
 	int ret;
