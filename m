Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+dEVP7Re+OM6g9Y0D0CAXAAHamJ9upU9ctoLZ/nF7IQNvAsjB1Rujwnqkrng/02yEjsc/V
ARC-Seal: i=1; a=rsa-sha256; t=1523981437; cv=none;
        d=google.com; s=arc-20160816;
        b=ZehCDAN+wQ07qqZjvqpCJ5j+sKi9ta/Y0iheq7feDIZVehxPyeIxD7ciVjw7c1jn0/
         y9vsprdw+7liKg2Cvtl5g2BkgnKd6kHl6751bk/uWYqFvBaNsuMPf6NISXqVm/JU0h6P
         k3pQz4MXbMTWIyG7hifEwaEQGRVAm6pUlEiCbH1LA2mbYCdc1LihggxSCjmoaMR9LsEL
         LPgPaqyKpNCl7gB1nfJwgkrQko1Knk7WlwUgdgD0B6BKR8lXvSo+nKe5IkWL+jDZdYBY
         d4S1ZQWnMPPlLBIAjvvDecSn1cPUe24qK4/4l0UKoRNC/Vf+nsHd1HA8SAskR8P+Dtxp
         8X7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=jON3sulnWoxrWzWmXB+Wn7F2oq9S4NqvaTiz+Z4XYo8=;
        b=oZhZNsCUIk3ZXfeRH6pIfCS8UZRPINhQwAIwcXf1yaDEwahzc25WNQi0Ajr99xHxxw
         0pjeJJaoVBiAAynEQVgnoavejok1k4WnMqQ1P6N7DMKtXxU1tPXiH2GCvfycNxd52GjW
         lTpP3KSLUavsYFN65s2/GcTJvYD5MfYJ5kK1KvYQFQRpjrtYU/VIrVpM5m6AKX2t27oX
         sKUAAjDUA0qOdGkNiyiKSoqk84YQ2Xs7APT/V9IL/AoX2z2JZJ1FHP8YsDq1YyuZDauA
         YBZ2zlxCJQeC/F6GssndKiB6cC/YCGJmr+ghc79x/T1kl8tJINky3sUKummI6mJkbyRI
         yOdQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 4.9 61/66] hwmon: (ina2xx) Fix access to uninitialized mutex
Date: Tue, 17 Apr 2018 17:59:34 +0200
Message-Id: <20180417155648.514470317@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155645.868055442@linuxfoundation.org>
References: <20180417155645.868055442@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598009936138504780?=
X-GMAIL-MSGID: =?utf-8?q?1598010359596501387?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marek Szyprowski <m.szyprowski@samsung.com>

commit 0c4c5860e9983eb3da7a3d73ca987643c3ed034b upstream.

Initialize data->config_lock mutex before it is used by the driver code.

This fixes following warning on Odroid XU3 boards:

INFO: trying to register non-static key.
the code is fine but needs lockdep annotation.
turning off the locking correctness validator.
CPU: 5 PID: 1 Comm: swapper/0 Not tainted 4.15.0-rc7-next-20180115-00001-gb75575dee3f2 #107
Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
[<c0111504>] (unwind_backtrace) from [<c010dbec>] (show_stack+0x10/0x14)
[<c010dbec>] (show_stack) from [<c09b3f74>] (dump_stack+0x90/0xc8)
[<c09b3f74>] (dump_stack) from [<c0179528>] (register_lock_class+0x1c0/0x59c)
[<c0179528>] (register_lock_class) from [<c017bd1c>] (__lock_acquire+0x78/0x1850)
[<c017bd1c>] (__lock_acquire) from [<c017de30>] (lock_acquire+0xc8/0x2b8)
[<c017de30>] (lock_acquire) from [<c09ca59c>] (__mutex_lock+0x60/0xa0c)
[<c09ca59c>] (__mutex_lock) from [<c09cafd0>] (mutex_lock_nested+0x1c/0x24)
[<c09cafd0>] (mutex_lock_nested) from [<c068b0d0>] (ina2xx_set_shunt+0x70/0xb0)
[<c068b0d0>] (ina2xx_set_shunt) from [<c068b218>] (ina2xx_probe+0x88/0x1b0)
[<c068b218>] (ina2xx_probe) from [<c0673d90>] (i2c_device_probe+0x1e0/0x2d0)
[<c0673d90>] (i2c_device_probe) from [<c053a268>] (driver_probe_device+0x2b8/0x4a0)
[<c053a268>] (driver_probe_device) from [<c053a54c>] (__driver_attach+0xfc/0x120)
[<c053a54c>] (__driver_attach) from [<c05384cc>] (bus_for_each_dev+0x58/0x7c)
[<c05384cc>] (bus_for_each_dev) from [<c0539590>] (bus_add_driver+0x174/0x250)
[<c0539590>] (bus_add_driver) from [<c053b5e0>] (driver_register+0x78/0xf4)
[<c053b5e0>] (driver_register) from [<c0675ef0>] (i2c_register_driver+0x38/0xa8)
[<c0675ef0>] (i2c_register_driver) from [<c0102b40>] (do_one_initcall+0x48/0x18c)
[<c0102b40>] (do_one_initcall) from [<c0e00df0>] (kernel_init_freeable+0x110/0x1d4)
[<c0e00df0>] (kernel_init_freeable) from [<c09c8120>] (kernel_init+0x8/0x114)
[<c09c8120>] (kernel_init) from [<c01010b4>] (ret_from_fork+0x14/0x20)

Fixes: 5d389b125186 ("hwmon: (ina2xx) Make calibration register value fixed")
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
[backport to v4.4.y/v4.9.y: context changes]
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/hwmon/ina2xx.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/drivers/hwmon/ina2xx.c
+++ b/drivers/hwmon/ina2xx.c
@@ -447,6 +447,7 @@ static int ina2xx_probe(struct i2c_clien
 
 	/* set the device type */
 	data->config = &ina2xx_config[id->driver_data];
+	mutex_init(&data->config_lock);
 
 	if (of_property_read_u32(dev->of_node, "shunt-resistor", &val) < 0) {
 		struct ina2xx_platform_data *pdata = dev_get_platdata(dev);
@@ -473,8 +474,6 @@ static int ina2xx_probe(struct i2c_clien
 		return -ENODEV;
 	}
 
-	mutex_init(&data->config_lock);
-
 	data->groups[group++] = &ina2xx_group;
 	if (id->driver_data == ina226)
 		data->groups[group++] = &ina226_group;
