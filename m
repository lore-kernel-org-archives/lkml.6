Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+V27AfXR8r6Q5jCp0Fs4Z0bnq+XBpV+E5w8TVDlbqeA+7Dm4d2ZrHZ9Dgiy3RNYVWWh/Ht
ARC-Seal: i=1; a=rsa-sha256; t=1523399385; cv=none;
        d=google.com; s=arc-20160816;
        b=wtr1iGe137/tXWvgQtb7UlUBsykis9Eil33WKDheeY0Gt5zoYqZNcjZxhRyVWpwTXB
         LYyE3PkgICD/B5GfCOwt1NpGKKWP8m7aBAbuhbHNvfzbz/+/LrsWk//S4JzJXp0d79jJ
         yxap+FH6AoWqXt/JzioZYmGvDnGBKRb1HLqe1TMGSbdLISMSLR0dKdiMI9AzCXzVievg
         GFAVfe9RHMRrzNltlbMKFKiXC+/IqVUGJpkORQY60wCUlkmXHC53SDjXSe0o5ckF0h+l
         6ll4X+kyBSP3zMrCuNCc3ZrbkkOn+/Xw0xmYBB1Db9z8vdvJ64LJIaDINcBK5as947nl
         C5jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=HKSZF+f/9DTtjKmtdyGr5qmy4ZXBFsthrqPEJ0H530w=;
        b=ivdBOaVuSItP8my0yKcPm5SvCEy/T0LLr5ojJ1bbybcRgPUs3h4lValtNl8yVd4uU6
         EQCxZwcJRzb9HDRmTvsmsv6nHqex18Dv1gNBhoBZ2SLpy4JZ0hakz7BHU5rtBTMpH1LF
         4UT+H5owl24ruy1M3HJIQr3Br68a92qHWp3kKTeF3wCigTEMqvCNDbDS7DlYAZHC+tsa
         FRzOcq0dQ8X9q0eZr4sGb53q9Gfh/YPlbJtQFKO6JkT4XcZQTBgRD14Ga9Ss0sXn8Dxg
         9KznmlFbzkdXSfVY+ZDQGPmuGzQiCmnROg2ebLAzlE0d/3dsUBiSQiyDlprbr/B49Ztz
         WK6Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	=?UTF-8?q?Ronald=20Tschal=C3=A4r?= <ronald@innovation.ch>,
	Lukas Wunner <lukas@wunner.de>,
	Marcel Holtmann <marcel@holtmann.org>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 088/168] Bluetooth: hci_bcm: Validate IRQ before using it
Date: Wed, 11 Apr 2018 00:23:50 +0200
Message-Id: <20180410212804.017495731@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212800.144079021@linuxfoundation.org>
References: <20180410212800.144079021@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597400033850645649?=
X-GMAIL-MSGID: =?utf-8?q?1597400033850645649?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "Ronald Tschal‰r" <ronald@innovation.ch>


[ Upstream commit 4a59f1fab91e9445e34c69d8e4401a0d6bdbe914 ]

The ->close, ->suspend and ->resume hooks assume presence of a valid IRQ
if the device is wakeup capable.  However it's entirely possible that
wakeup was enabled by some other entity besides this driver and in this
case the user will get a WARN splat if no valid IRQ was found.  Avoid by
checking if the IRQ is valid, i.e. > 0.

Case in point:  On recent MacBook Pros, the Bluetooth device lacks an
IRQ (because host wakeup is handled by the SMC, independently of the
operating system), but it does possess a _PRW method (which specifies
the SMC's GPE as wake event).  The ACPI core therefore automatically
marks the physical Bluetooth device wakeup capable upon binding it to
its ACPI companion:

device_set_wakeup_capable+0x96/0xb0
acpi_bind_one+0x28a/0x310
acpi_platform_notify+0x20/0xa0
device_add+0x215/0x690
serdev_device_add+0x57/0xf0
acpi_serdev_add_device+0xc9/0x110
acpi_ns_walk_namespace+0x131/0x280
acpi_walk_namespace+0xf5/0x13d
serdev_controller_add+0x6f/0x110
serdev_tty_port_register+0x98/0xf0
tty_port_register_device_attr_serdev+0x3a/0x70
uart_add_one_port+0x268/0x500
serial8250_register_8250_port+0x32e/0x490
dw8250_probe+0x46c/0x720
platform_drv_probe+0x35/0x90
driver_probe_device+0x300/0x450
bus_for_each_drv+0x67/0xb0
__device_attach+0xde/0x160
bus_probe_device+0x9c/0xb0
device_add+0x448/0x690
platform_device_add+0x10e/0x260
mfd_add_device+0x392/0x4c0
mfd_add_devices+0xb1/0x110
intel_lpss_probe+0x2a9/0x610 [intel_lpss]
intel_lpss_pci_probe+0x7a/0xa8 [intel_lpss_pci]

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Ronald Tschal√§r <ronald@innovation.ch>
[lukas: fix up ->suspend and ->resume as well, add commit message]
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/bluetooth/hci_bcm.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -379,7 +379,7 @@ static int bcm_close(struct hci_uart *hu
 		pm_runtime_disable(bdev->dev);
 		pm_runtime_set_suspended(bdev->dev);
 
-		if (device_can_wakeup(bdev->dev)) {
+		if (bdev->irq > 0) {
 			devm_free_irq(bdev->dev, bdev->irq, bdev);
 			device_init_wakeup(bdev->dev, false);
 		}
@@ -628,7 +628,7 @@ static int bcm_suspend(struct device *de
 	if (pm_runtime_active(dev))
 		bcm_suspend_device(dev);
 
-	if (device_may_wakeup(dev)) {
+	if (device_may_wakeup(dev) && bdev->irq > 0) {
 		error = enable_irq_wake(bdev->irq);
 		if (!error)
 			bt_dev_dbg(bdev, "BCM irq: enabled");
@@ -658,7 +658,7 @@ static int bcm_resume(struct device *dev
 	if (!bdev->hu)
 		goto unlock;
 
-	if (device_may_wakeup(dev)) {
+	if (device_may_wakeup(dev) && bdev->irq > 0) {
 		disable_irq_wake(bdev->irq);
 		bt_dev_dbg(bdev, "BCM irq: disabled");
 	}
