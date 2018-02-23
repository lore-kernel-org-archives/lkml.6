Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224VtnzJCeVrc6rPoloB+DgzlsCFvMs7ygxiyU7ZxFkv42Wbc6DDGjDO/SqDGsQVN0+vUNhK
ARC-Seal: i=1; a=rsa-sha256; t=1519410945; cv=none;
        d=google.com; s=arc-20160816;
        b=slilvsi40uO9xMbzMcb3DlBpUZ4Lt85/1NrZny4r/+oNp57MH9mrgr2/Osfm13yp11
         FyQREW0PtM5ExvKttuHVvd9NHI2JSqGkp9m7ipADahFMJyBsMdj8TZfacSQSgkGUPv/u
         VF/BeHOd7ont6Q5yDTOOCBKsHH+r54HcXU5tlJNBSjAeQ6dbA4SjLChItKPlmxJT4Zrg
         iiOBguWzrUcTiXDqqOou90u0YpLpu1wsIrKcHSmv+FpppZGH00pQLcAkK0N2rLJyNBCn
         J4M7rt6gYiZTAb2ZbvmoJCu24gyKFC+JAF0GBVBOITIwmhA8KqPwRsz7Vk59/vwf0M+L
         NfbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ISCNw3DZOXQ19epW9cYumt8havyVoMKQTQUGY0lkckM=;
        b=oXjICaoDXk6lf/OCszX9scLHesrfAH0/i/gBJkkHFUKJkxT4f0tVZ5NlS/qRdpnV7F
         M0FsVYHclukF2JqgCOzyGn+xTdrqyGjAmAYmQKKUUqMx/qsemKFbc68QhRzyMeDBil48
         70xWiHw9YT5iVtRsZ17m/0Nj30+/++MfKbjjd5TzVsc1T66M89vcd714vnW0mACXzw2t
         /rhGrmZbWJtZlJL2rZAfVXK6xVMvLT+LPjZmBynK6DG3LykWx1M4L9k9u1kZ4gukUqdD
         Z1JzxIJvjGLRLmY6tg0JDh0HvNwKkOngi9EOrgyQ9GZc8nHYWUsWfdrFRqqA470m9OEV
         nhww==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Augusto Mecking Caringi <augustocaringi@gmail.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 4.4 065/193] gpio: intel-mid: Fix build warning when !CONFIG_PM
Date: Fri, 23 Feb 2018 19:24:58 +0100
Message-Id: <20180223170336.172998479@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593217851358846377?=
X-GMAIL-MSGID: =?utf-8?q?1593217851358846377?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Augusto Mecking Caringi <augustocaringi@gmail.com>

commit fbc2a294f29e726787a0f5238b27137904f26b81 upstream.

The only usage of function intel_gpio_runtime_idle() is here (in the
same file):

static const struct dev_pm_ops intel_gpio_pm_ops = {
	SET_RUNTIME_PM_OPS(NULL, NULL, intel_gpio_runtime_idle)
};

And when CONFIG_PM is not set, the macro SET_RUNTIME_PM_OPS expands to
nothing, causing the following compiler warning:

drivers/gpio/gpio-intel-mid.c:324:12: warning: ‘intel_gpio_runtime_idle’
defined but not used [-Wunused-function]
static int intel_gpio_runtime_idle(struct device *dev)

Fix it by annotating the function with __maybe_unused.

Signed-off-by: Augusto Mecking Caringi <augustocaringi@gmail.com>
Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpio/gpio-intel-mid.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpio/gpio-intel-mid.c
+++ b/drivers/gpio/gpio-intel-mid.c
@@ -326,7 +326,7 @@ static void intel_mid_irq_init_hw(struct
 	}
 }
 
-static int intel_gpio_runtime_idle(struct device *dev)
+static int __maybe_unused intel_gpio_runtime_idle(struct device *dev)
 {
 	int err = pm_schedule_suspend(dev, 500);
 	return err ?: -EBUSY;
