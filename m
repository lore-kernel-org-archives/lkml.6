Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2E2AC5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 19:24:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CD1D20851
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 19:24:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CD1D20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726938AbeLKTYp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 14:24:45 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41935 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbeLKTYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 14:24:44 -0500
Received: by mail-wr1-f67.google.com with SMTP id x10so15272106wrs.8
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 11:24:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language;
        bh=Cy1I1QIv6l6AkYbB4UhpvdYY/8HkxsvTQ/OyW6wCDxw=;
        b=ifGDsTX6vd6vgKpeIaNHf/b4xT3ppzNb+Pyr/zNpPSJp66bE69os93EQSnJ4/VI7Fd
         353kpwvOgwj0C5QiNQZkGxMHu/ZWceDPPlFUO04FyO/n7D9lju13wWkN3vgCJogzSdAh
         4yfRs8TqurcIke5M6qjk9fjI7tA2h9J2R0ZQ5j4rJiRpdyYSurUSCBFF2uWUuvGh86eX
         gKYvloD15q6beC3y0KR4StPbUvjm7tOylnrqV1OnEFKNIcKL/+ZxmKWiXdWMb8aQwEJN
         AbEm/DGn5KIu2rvIOjk8KeVWu0TBpUTJ+Zju6LIbt1gjswEcjcQ1QI3kXiMiTGgI4bnd
         0IAA==
X-Gm-Message-State: AA+aEWYp4r3iqgt22iW/mji9bCMeBXo4ZC6Aj6vo34GOThgQ5b09Z+Zs
        x6Q9mgv7/Zy50fRDPpRGecJua65bPWw=
X-Google-Smtp-Source: AFSGD/UhgQLuY5A8IY7OAVkOXUXdeNoBwxf4VYEL1opYV16P9NVPvvTQBOMTfwsdEsEQ42J/LxOcug==
X-Received: by 2002:adf:e383:: with SMTP id e3mr14379189wrm.31.1544556281905;
        Tue, 11 Dec 2018 11:24:41 -0800 (PST)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id r77sm1303450wmd.22.2018.12.11.11.24.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 11:24:41 -0800 (PST)
Subject: Re: [RFC/RFT 00/10] i2c: move handling of suspended adapters to the
 core
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-i2c@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org
References: <20181210210310.12677-1-wsa+renesas@sang-engineering.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <2094a0d4-733f-7f74-abd2-bdb28edd0f80@redhat.com>
Date:   Tue, 11 Dec 2018 20:24:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181210210310.12677-1-wsa+renesas@sang-engineering.com>
Content-Type: multipart/mixed;
 boundary="------------5EB9D799064076BC26E44817"
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------5EB9D799064076BC26E44817
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Wolfram,

On 10-12-18 22:02, Wolfram Sang wrote:
> Finally, here is the implementation Hans and I agreed on. Plus, all potential
> users I could spot already converted. Renesas R-Car driver was added on top.
> This series was tested on a Renesas Lager board (R-Car H2). I had to hack some
> error cases into the code to verify the workings. I couldn't create an error
> case otherwise, this is why further testing with more complex setups is very
> welcome.
> 
> For my taste, there is still too much boilerplate code for drivers left. Plus,
> it is also too easy to put it too early or too late. But I haven't come up with
> a better idea yet. And it is time to get this somehow forward.
> 
> Please comment, review, test... a branch can be found here:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/i2c/core-pm-helpers

So I've been testing this patch-set on some Intel devices with
an i2c-designware controller, combined with a patch to make the
suspend/resume methods of the controller call i2c_mark_adapter_suspended()

The results were ... interesting:

Take 1:
4.20-rc6 + your branch + i2c-designw-patch (+ some unrelated patches which are in my personal tree).
*i2c transfers no longer work*, because the controller runtime suspends and the pm_runtime_get_sync
to undo this is called from the driver's master_xfer function and the
is_suspended check happens before this.

Take 2:
Kernel from 1 with a patch added (attached) to make the core call
pm_runtime_get_sync from __i2c_transfer() if a flag is set +
i2c-designware changes to set this flag
*i2c transfers still do not work*, because __i2c_transfer is
called with the bus-lock held and the pm_runtime_get_sync calls
the adapters resume callback which calls i2c_mark_adapter_suspended()
which tries to take the bus-lock again -> deadlock

Take 3:
Kernel from 2 with the i2c-designware suspend/callback patches
modified to directly set adapter.is_suspended. To avoid the deadlock.
Ok, this works.  Note I've not tested reverting one of my recent
ACPI suspend ordering patches yet, which should actually trigger the
WARN_ON, I've ran out of steam just getting things to work with
the patches present.

I'm attaching 2 patches as I'm using them in Take 3.

Note that the i2c-sprd driver changes in your patchset also get close
to triggering this problem, but they dodge the bullet because there
are separate system-wide and runtime suspend handlers and only the
system-wide handlers call the new i2c_mark_adapter_suspended() function.

As I explain in the commit message of the first attached patch
simply always using split handlers is not really an option because
of adapter drivers using DPM_FLAG_SMART_PREPARE or
DPM_FLAG_SMART_SUSPEND.

So I'm afraid that this is way messier then I would like it to be,
we could go with my flag solution combined with not protecting
the is_suspended flag under the bus lock. That would make the
WARN_ON slightly racy, so we might fail to trigger the warning
under some rare circumstances, reverting to the old behavior of
continuing with the transfer on a suspended adapter, but I don't
think that is all that bad.

Regards,

Hans



> Wolfram Sang (10):
>    i2c: add 'is_suspended' flag for i2c adapters
>    i2c: reject new transfers when adapters are suspended
>    i2c: synquacer: remove unused is_suspended flag
>    i2c: brcmstb: use core helper to mark adapter suspended
>    i2c: zx2967: use core helper to mark adapter suspended
>    i2c: sprd: don't use pdev as variable name for struct device *
>    i2c: sprd: use core helper to mark adapter suspended
>    i2c: exynos5: use core helper to mark adapter suspended
>    i2c: s3c2410: use core helper to mark adapter suspended
>    i2c: rcar: add suspend/resume support
> 
>   drivers/i2c/busses/i2c-brcmstb.c   | 13 ++-----------
>   drivers/i2c/busses/i2c-exynos5.c   | 11 ++---------
>   drivers/i2c/busses/i2c-rcar.c      | 25 +++++++++++++++++++++++++
>   drivers/i2c/busses/i2c-s3c2410.c   |  8 ++------
>   drivers/i2c/busses/i2c-sprd.c      | 34 ++++++++++++----------------------
>   drivers/i2c/busses/i2c-synquacer.c |  5 -----
>   drivers/i2c/busses/i2c-zx2967.c    |  8 ++------
>   drivers/i2c/i2c-core-base.c        |  3 +++
>   include/linux/i2c.h                |  9 +++++++++
>   9 files changed, 57 insertions(+), 59 deletions(-)
> 

--------------5EB9D799064076BC26E44817
Content-Type: text/x-patch;
 name="0001-i2c-add-I2C_AQ_RUNTIME_PM-adapter-quirk-flag.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-i2c-add-I2C_AQ_RUNTIME_PM-adapter-quirk-flag.patch"

From 7781ff0b5033436c1d2740570364b1739017e03d Mon Sep 17 00:00:00 2001
From: Hans de Goede <hdegoede@redhat.com>
Date: Tue, 11 Dec 2018 19:19:17 +0100
Subject: [PATCH 1/2] i2c: add I2C_AQ_RUNTIME_PM adapter quirk flag

Add a new I2C_AQ_RUNTIME_PM adapter quirk flag, when this flag is set
then the i2c-core will all pm_runtime_get_sync() before calling an
adapter's master_xfer function and call pm_runtime_mark_last_busy() +
pm_runtime_put_autosuspend() after the master_xfer function.

Moving these runtime pm calls into the core for adapters which use them
is necessary for the WARN_ON(adap->is_suspended) to not trigger when
runtime-suspend is used. Another approach would be to only call
i2c_mark_adapter_suspended() from the adapter's regular suspend/resume
callbacks and not from the runtime-resume ones, but that would circumvent
the check also on system suspend when using DPM_FLAG_SMART_PREPARE or
DPM_FLAG_SMART_SUSPEND.

Note that of the 20 adapter drivers which call pm_runtime_get_sync() from
there master_xfer function, 16 call pm_runtime_put_autosuspend() when done.
i2c-nomadik.c and i2c-sh_mobile.c use pm_runtime_put_sync() and
i2c-tegra.c and i2c-rcar.c use pm_runtime_put(), so these will need to be
modified to use these new flag, or they will need another flag for their
special case.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/i2c/i2c-core-base.c | 16 ++++++++++++++--
 include/linux/i2c.h         |  2 ++
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index 5b2078a902f8..acff1e4c09d9 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -1866,12 +1866,18 @@ int __i2c_transfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
 
 	if (WARN_ON(!msgs || num < 1))
 		return -EINVAL;
-	if (WARN_ON(adap->is_suspended))
-		return -ESHUTDOWN;
 
 	if (adap->quirks && i2c_check_for_quirks(adap, msgs, num))
 		return -EOPNOTSUPP;
 
+	if (adap->quirks && (adap->quirks->flags & I2C_AQ_RUNTIME_PM))
+		pm_runtime_get_sync(adap->dev.parent);
+
+	if (WARN_ON(adap->is_suspended)) {
+		ret = -ESHUTDOWN;
+		goto out;
+	}
+
 	/*
 	 * i2c_trace_msg_key gets enabled when tracepoint i2c_transfer gets
 	 * enabled.  This is an efficient way of keeping the for-loop from
@@ -1904,6 +1910,12 @@ int __i2c_transfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
 		trace_i2c_result(adap, num, ret);
 	}
 
+out:
+	if (adap->quirks && (adap->quirks->flags & I2C_AQ_RUNTIME_PM)) {
+		pm_runtime_mark_last_busy(adap->dev.parent);
+		pm_runtime_put_autosuspend(adap->dev.parent);
+	}
+
 	return ret;
 }
 EXPORT_SYMBOL(__i2c_transfer);
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 9852038ee3a7..96b9cac6c01e 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -661,6 +661,8 @@ struct i2c_adapter_quirks {
 #define I2C_AQ_NO_ZERO_LEN_READ		BIT(5)
 #define I2C_AQ_NO_ZERO_LEN_WRITE	BIT(6)
 #define I2C_AQ_NO_ZERO_LEN		(I2C_AQ_NO_ZERO_LEN_READ | I2C_AQ_NO_ZERO_LEN_WRITE)
+/* core must call pm_runtime_get_sync / put_autosuspend around master_xfer */
+#define I2C_AQ_RUNTIME_PM		BIT(7)
 
 /*
  * i2c_adapter is the structure used to identify a physical i2c bus along
-- 
2.19.2


--------------5EB9D799064076BC26E44817
Content-Type: text/x-patch;
 name="0002-i2c-designware-Set-is_suspended-flag-when-suspended.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0002-i2c-designware-Set-is_suspended-flag-when-suspended.pat";
 filename*1="ch"

From ba156b9419629a24fd2a82cc34d6d588585f637f Mon Sep 17 00:00:00 2001
From: Hans de Goede <hdegoede@redhat.com>
Date: Tue, 11 Dec 2018 15:29:44 +0100
Subject: [PATCH 2/2] i2c: designware: Set is_suspended flag when suspended

Set the is_suspended flag when suspended so that the i2c-core will warn
if we get called while the controller is (system-wide) suspended. Note
this also switches the runtime-pm handling in i2c-designware-master.c
to the new I2C_AQ_RUNTIME_PM flag, as this is required for the
is_suspended flag to work properly in combination with runtime-pm.

On most Intel Bay- and Cherry-Trail systems the PMIC is connected over I2C
and the PMIC is accessed through various means by the _PS0 and _PS3 ACPI
methods (power on / off methods) of various devices.

This leads to suspend/resume ordering problems where a device may be
resumed and get its _PS0 method executed before the I2C controller is
resumed. On Cherry Trail this leads to errors like these:

     i2c_designware 808622C1:06: controller timed out
     ACPI Error: AE_ERROR, Returned by Handler for [UserDefinedRegion]
     ACPI Error: Method parse/execution failed \_SB.P18W._ON, AE_ERROR
     video LNXVIDEO:00: Failed to change power state to D0

But on Bay Trail this caused I2C reads to seem to succeed, but they end
up returning wrong data, which ends up getting written back by the typical
read-modify-write cycle done to turn on various power-resources.

Debugging the problems caused by this silent data corruption is quite
nasty.

This commit properly marks the adapter as suspended until our resume
callback has run, triggering the i2c-core's WARN_ON when i2c_transfer gets
called on a suspended adapter.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/i2c/busses/i2c-designware-master.c  | 11 ++---------
 drivers/i2c/busses/i2c-designware-platdrv.c |  4 ++++
 2 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-master.c b/drivers/i2c/busses/i2c-designware-master.c
index 8d1bc44d2530..ebb2b8368f6f 100644
--- a/drivers/i2c/busses/i2c-designware-master.c
+++ b/drivers/i2c/busses/i2c-designware-master.c
@@ -424,8 +424,6 @@ i2c_dw_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
 
 	dev_dbg(dev->dev, "%s: msgs: %d\n", __func__, num);
 
-	pm_runtime_get_sync(dev->dev);
-
 	reinit_completion(&dev->cmd_complete);
 	dev->msgs = msgs;
 	dev->msgs_num = num;
@@ -439,7 +437,7 @@ i2c_dw_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
 
 	ret = i2c_dw_acquire_lock(dev);
 	if (ret)
-		goto done_nolock;
+		return ret;
 
 	ret = i2c_dw_wait_bus_not_busy(dev);
 	if (ret < 0)
@@ -493,11 +491,6 @@ i2c_dw_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
 
 done:
 	i2c_dw_release_lock(dev);
-
-done_nolock:
-	pm_runtime_mark_last_busy(dev->dev);
-	pm_runtime_put_autosuspend(dev->dev);
-
 	return ret;
 }
 
@@ -507,7 +500,7 @@ static const struct i2c_algorithm i2c_dw_algo = {
 };
 
 static const struct i2c_adapter_quirks i2c_dw_quirks = {
-	.flags = I2C_AQ_NO_ZERO_LEN,
+	.flags = I2C_AQ_NO_ZERO_LEN | I2C_AQ_RUNTIME_PM,
 };
 
 static u32 i2c_dw_read_clear_intrbits(struct dw_i2c_dev *dev)
diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index 9eaac3be1f63..e220336f34ae 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -454,6 +454,8 @@ static int dw_i2c_plat_suspend(struct device *dev)
 {
 	struct dw_i2c_dev *i_dev = dev_get_drvdata(dev);
 
+	i_dev->adapter.is_suspended = true;
+
 	if (i_dev->shared_with_punit)
 		return 0;
 
@@ -472,6 +474,8 @@ static int dw_i2c_plat_resume(struct device *dev)
 
 	i_dev->init(i_dev);
 
+	i_dev->adapter.is_suspended = false;
+
 	return 0;
 }
 
-- 
2.19.2


--------------5EB9D799064076BC26E44817--
