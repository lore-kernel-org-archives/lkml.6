Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx486o/Ol5AgweH8uAAzCLhl9N5q1vyYJooNgjJcAo2Pypf/ngcFZfo986XnnhMa5EJ+pEFYE
ARC-Seal: i=1; a=rsa-sha256; t=1523981033; cv=none;
        d=google.com; s=arc-20160816;
        b=HNxaWHTgoWVpKGhx+l11VezNAwA068gpiqH47P5hltKrCyCwzX72Jssiqe8b40CJmX
         TncbDETvw9cNOWYh+TLZjV239TO8wYtQqM3/wwUV97+v0sAHb25w2FdgeNulksU2XZg1
         6eWUtzHj4jg/Oootxebqnmih0LvYbo0w1bScq/JPRYSy2xReUMwGIwzCKsAAEgNh5fnA
         ROtW6+KeY3iOBKLaYM5Svr6Xsw0pAlg3hQ7qmvwv1O6LN4kRNj/xX4xpfyhXbq7CzcSN
         IBGQE5YbPCy6z9SklliuzyIzdZwMlhwC55ASHmMGZPpr/7g6FCcZOzG0bQek9M3N486E
         V8iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=e7hCcqzPIR4vUCtEx9jvfrXmkvjQ2I0otgLqjYnGuy0=;
        b=fipy5q4v+cXXT4pDiIyNAHczwmo3xRCh8HXStPnM2lBSWMhIZyJ4eE9L8c6hPzHxGJ
         f4lqids8YSjag8qlMj7er6Yj23UNDIDItBw7TrxiICCVRY9NKfjv7sFHF9kfeXL0BXdp
         0+4Qwt2kVAeRQAEDN0Ob1/vORSSxsGn9IEUefabdNbeaH5SRP5vlHM5kc3wYOI2C+juR
         IJ5tpAdYqLJOfWCZ4gPLmrDRq1OOtxfh0QmttU6qjgKUSmJQquYcKgE4TyXNFj00gz6v
         HSducMpisf4rzqP8is06q1A2x95DYxsLCctbY8sI7U+DQomuRyT6ETBmZHYbSULYu28i
         Foxw==
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
Subject: [PATCH 4.15 23/53] hwmon: (ina2xx) Fix access to uninitialized mutex
Date: Tue, 17 Apr 2018 17:58:48 +0200
Message-Id: <20180417155724.237672765@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155723.091120060@linuxfoundation.org>
References: <20180417155723.091120060@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598009936138504780?=
X-GMAIL-MSGID: =?utf-8?q?1598009936138504780?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/hwmon/ina2xx.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/drivers/hwmon/ina2xx.c
+++ b/drivers/hwmon/ina2xx.c
@@ -454,6 +454,7 @@ static int ina2xx_probe(struct i2c_clien
 
 	/* set the device type */
 	data->config = &ina2xx_config[chip];
+	mutex_init(&data->config_lock);
 
 	if (of_property_read_u32(dev->of_node, "shunt-resistor", &val) < 0) {
 		struct ina2xx_platform_data *pdata = dev_get_platdata(dev);
@@ -480,8 +481,6 @@ static int ina2xx_probe(struct i2c_clien
 		return -ENODEV;
 	}
 
-	mutex_init(&data->config_lock);
-
 	data->groups[group++] = &ina2xx_group;
 	if (id->driver_data == ina226)
 		data->groups[group++] = &ina226_group;
