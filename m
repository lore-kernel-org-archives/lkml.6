Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752668AbeEGRsl (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 13:48:41 -0400
Received: from fllnx209.ext.ti.com ([198.47.19.16]:27830 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752359AbeEGRsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 13:48:38 -0400
Subject: Re: I2C PM overhaul needed? (Re: [PATCH 1/2] i2c: sprd: Prevent i2c
 accesses after suspend is called)
To: Wolfram Sang <wsa@the-dreams.de>
CC: Baolin Wang <baolin.wang@linaro.org>, Mark Brown <broonie@kernel.org>,
        <linux-i2c@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
References: <99031524fa147e72451d26f54b24f36093c0d3fa.1523255712.git.baolin.wang@linaro.org>
 <20180427121417.auv4ppryegkprv32@ninjato>
 <CAMz4kuK3fyBhdrUcLvY0s0N-0yY9_0MrAAi9cWdX1ZfdNW+R0w@mail.gmail.com>
 <20180502052336.i5f4yv2ho3za7qa7@tetsubishi>
 <CAMz4kuJAzr-ybCCmjx_Tcdw6qNYN0wLGQgWsb1H0WEkR4ZpyYg@mail.gmail.com>
 <3485f73f-e356-6db0-89fc-d51bf8bdab71@ti.com>
 <20180504122447.u3xgrkperxz5dpcz@ninjato>
From: Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <bef80500-4727-d324-f0c8-4fc6016f43ed@ti.com>
Date: Mon, 7 May 2018 12:48:32 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180504122447.u3xgrkperxz5dpcz@ninjato>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/04/2018 07:24 AM, Wolfram Sang wrote:
> Hi Grygorii,
> 
> thanks for stepping in.  I kept thinking about better I2C core support
> for such situations and the more input the better.
> 
>> And you have to fix it (touch screen) - not your i2c driver. Otherwise, you can get
>> situation when set of I2C transfers (executed from some kthread/work/threaded_irq/..)
>> will be just interrupted in the middle - usual behavior after this is (I2C timeout) [and/or
>> not-functional I2C client device [and/or I2C bus stuck (worst case)].
> 
> This. I also tend to think that most issues need to be fixed in the
> client drivers ensuring proper states of client devices when suspending
> / resuming.. I wonder, though, if the core shouldn't assist by
> guaranteeing that an on-going transfer has finished before suspending?
> Or more technically, wait for a locked adapter to become unlocked again?

That would be great, but note:
1) only i2c_transfer() operations are locked, so if driver is doing 
i2c_transfer(1)
i2c_transfer(2) <- suspend in the middle
<- suspend in between
i2c_transfer(3)
It will not help.
In other word, one suspend cycle may be done without warnings or issues,
while another may show up broken devices after suspend or even system crash.
Everything depends on timings :( - in my practice 10000 suspend iteration tests
where required to run many times to catch 3 buggy I2C client drivers.

2) It's normal to abort suspend if system is busy, so if I2C core will be able
to catch active I2C operation - it should abort, but again I do not see how it
 can be detected 100% with current I2C core design or without reworking huge number of drivers.

3) So, only one thing I2C core potentially can do - catch invalid access and
report it. "wait for transfer to finish" wouldn't work as for me.

> 
> I still need to set it up and test, yet seeing that the EEPROM driver
> at24.c has no suspend/resume callbacks, I'd assume a big write operation
> will only be partially done when interrupted by a suspend.
> 
>> In case, somebody is trying to access I2C after .suspend_noirq() stage I2C bus driver
>> should produce big fat warning and, most probably, abort suspend.
>> Above, in general, can be part of I2C core functionality.
> 
> Also this. However, there might be an exception of devices like PMICs
> which may need to be accessed to trigger the final suspend state.
> 
> I at least know of some Renesas boards which needed the I2C connected
> PMIC to do a system reset (not sure about suspend, need to recheck
> that). That still today causes problems because interrupts are disabled
> then.

this was triggered few times already (sry, don't have links), as of now,
 and as I know, the only ways to W/A this is:
- to create barametal platform driver (some time in ASM)
- or delegate final suspend operation to another system controller (co-processor),
  as example TI am335x SoCs,
- or implement I2C driver in hw - TI AVS/SmartReflex. 

> 
> To handle that, I imagined an additional adapter callback like
> 'master_xfer_irqless' to be used for such special I2C messages. These
> kind of special messages could be tagged with a new I2C_M_something
> flag.
> 
> And maybe this could be used here, too? Introduce this flag for very
> late/early messages. If they have it, messages are even sent in
> suspend_noirq() phase with the master_xfer_irqless() callback, otherwise
> we will have the WARNing printed out.

Sry, but 99% percent of I2C client drivers *should not* access I2C bus after
.suspend_noirq() stage it's BUG-BUG!! Any W/A will just hide real problems.

"master_xfer_irqless" might be a not bad idea, but, in my opinion, it 
should be used explicitly by platform code only, and each usage should
be proved to exist. 

Some additional info:
static int suspend_enter(suspend_state_t state, bool *wakeup)
{
[...]

	error = dpm_suspend_noirq(PMSG_SUSPEND);
	if (error) {
		pr_err("noirq suspend of devices failed\n");
		goto Platform_early_resume;
	}

^^^ after this no drivers expect to work, unless they are wake up
sources and even in this case - they should handle wake up in
their .suspend_noirq() or even later.

	error = platform_suspend_prepare_noirq(state);
	if (error)
		goto Platform_wake;

	if (suspend_test(TEST_PLATFORM))
		goto Platform_wake;

^^^ before disable_nonboot_cpus() there can be few processes
    running in parallel on SMP: one is suspend, others can be anything  

	error = disable_nonboot_cpus();
	if (error || suspend_test(TEST_CPUS))
		goto Enable_cpus;

	arch_suspend_disable_irqs();
^^^ after this point only suspend process is active
 any regular drivers usage is prohibited,BUG-BUG (at least in regular way,
 but some special irqless APIs still can be used, but only by platform suspend code)

	BUG_ON(!irqs_disabled());

	error = syscore_suspend();
	if (!error) {

^^^ scheduler and systimers are disabled

		*wakeup = pm_wakeup_pending();
		if (!(suspend_test(TEST_CORE) || *wakeup)) {
			trace_suspend_resume(TPS("machine_suspend"),
				state, true);
			error = suspend_ops->enter(state);

^^^ platform code - final suspend stage

			trace_suspend_resume(TPS("machine_suspend"),
				state, false);
		} else if (*wakeup) {
			error = -EBUSY;
		}
		syscore_resume();
	}

	arch_suspend_enable_irqs();
	BUG_ON(irqs_disabled());

 Enable_cpus:
	enable_nonboot_cpus();

 Platform_wake:
	platform_resume_noirq(state);
	dpm_resume_noirq(PMSG_RESUME);

^^^ I2C can be accessible again

[...]

}
> 
> Thoughts? Any other cases missed so far?
> 

I'm attaching some very old patch (don't ask me why it was not sent :()
I did for Android system - which likes suspend very much. Some
part of below diff are obsolete now (like omap_i2c_suspend()),
but .noirq() callback are still valid and can show over all idea.
Really helped to catch min 3 buggy client drivers with timers, delayed
or periodic works.

Huh, hope it's useful :)

By the way, original patch from this thread is ok in general, but 
WARN() after checking is_suspended flag will be helpful. 

+	if (i2c_dev->is_suspended)
^^ WARN()?
+		return -EBUSY;

-- 
regards,
-grygorii

----
commit 125ef8f7016e7b205886f93862288a45a312b1d8
Author: Grygorii Strashko <grygorii.strashko@ti.com>
Date:   Thu Sep 20 19:56:44 2012 +0300

    I2C: OMAP: Fix PM runtime functionality during suspend/resume
    
    The OMAP I2C devices power management is based on Runtime PM only,
    because they are intended to be used at later/earlier stages of System
    wide suspend/resume execution. In addition, OMAP PM framework is based
    on OMAP HWMOD framework which, in turn, connected to Runtime PM
    subsystem.
    But now, the Runtime PM is disabled for I2C devices immediately after
    execution of its .suspend() callback. As result, I2C devices can't be
    accessible during later suspend/early resume stages.


    
    This patch always enables I2C device from .suspend() callback,
    so it can be accessible during later stages of suspending.

^^^^ this part is not valid any more

    Then, I2C 
    device is finally turned off on exit .suspend_noirq() callback by
    omap_device framework, so it can be accessible during later suspending
    stages.
    From other side, the I2C device is unconditionally turned on before
    entering resume_noirq() callback by omap_device framework, so it can be
    accessible during earlier stages of resuming.
    
    More over, the additional check added to ensure that there are no
    activities on I2C bus, because some drivers may still have active kernel
    thread/works which may be executed on another CPU and try to access I2C
    -- this is the BUG and this may cause system crash.
    To prevent such situations additional flag "suspended" is added in
    struct omap_i2c_dev which is used to forbid access to I2C bus after
    .suspend_noirq() callback execution.
   
    Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 5ef9b7e..f5914c9 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -207,6 +207,9 @@ struct omap_i2c_dev {
        u16                     westate;
        u16                     errata;
        int                     dev_lost_count;
+       bool                    suspended;      /* if true - I2C device
+                                                  suspended and can't be
+                                                  accessible*/
 };
 
 static const u8 reg_map_ip_v1[] = {
@@ -643,6 +646,12 @@ omap_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
                return -EINVAL;
        }
 
+       if (dev->suspended) {
+               WARN(true, "%s: Access denied - device already suspended\n",
+                    dev_name(dev->dev));
+               return -EACCES;
+       }
+
        r = omap_i2c_hwspinlock_lock(dev);
        /* To-Do: if we are unable to acquire the lock, we must
        try to recover somehow */
@@ -651,7 +660,6 @@ omap_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
 
        r = pm_runtime_get_sync(dev->dev);
        if (r < 0) {
-               pm_runtime_put_noidle(dev->dev);
                goto err_pm;
        }
 
@@ -690,8 +698,8 @@ omap_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
        omap_i2c_wait_for_bb(dev);
 out:
        disable_irq(dev->irq);
-       pm_runtime_put_sync(dev->dev);
 err_pm:
+       pm_runtime_put_sync(dev->dev);
        omap_i2c_hwspinlock_unlock(dev);
        return r;
 }
@@ -1270,7 +1278,79 @@ static int omap_i2c_runtime_resume(struct device *dev)
 }
 #endif /* CONFIG_PM_RUNTIME */
 
+static int omap_i2c_suspend(struct device *dev)
+{
+       int ret;
+
+       /*
+        *  Enable I2C device, so it will be accessible during
+        * later stages of suspending when device Runtime PM is disabled.
+        * I2C device will be turned off at "noirq" suspend stage.
+        */
+       ret = pm_runtime_resume(dev);
+       if (ret < 0)
+               return ret;
+       return 0;
+}
+
+static int omap_i2c_suspend_noirq(struct device *dev)
+{
+       struct platform_device *pdev = to_platform_device(dev);
+       struct omap_i2c_dev *_dev = platform_get_drvdata(pdev);
+
+       /*
+        * Below code is needed only to ensure that there are no
+        * activities on I2C bus. if at this moment any driver
+        * is trying to use I2C bus - this is the BUG and this
+        * may cause system crash.
+        *
+        * So forbid access to I2C device using _dev->suspended flag.
+        */
+
+       i2c_lock_adapter(&_dev->adapter);
+
+       /* Check for active I2C transaction */
+       if (atomic_read(&dev->power.usage_count) > 1) {
+               dev_info(dev,
+                        "active I2C transaction detected - suspend aborted\n");
+               return -EBUSY;
+       }
+
+       _dev->suspended = true;
+
+       i2c_unlock_adapter(&_dev->adapter);
+
+       /*
+        * I2C device will be turned off by omap_device framework
+        * on exit from .suspend_noirq() callback.
+        * So, it will not be accessible any more.
+        */
+       return 0;
+}
+
+static int omap_i2c_resume_noirq(struct device *dev)
+{
+       struct platform_device *pdev = to_platform_device(dev);
+       struct omap_i2c_dev *_dev = platform_get_drvdata(pdev);
+
+       /*
+        * I2C device  has been turned on already by omap_device framework
+        * unconditionally. So, it will be accessible during earlier
+        * stages of resuming when device Runtime PM is disabled
+        */
+
+       /* Allow access to I2C bus*/
+       i2c_lock_adapter(&_dev->adapter);
+       _dev->suspended = false;
+       i2c_unlock_adapter(&_dev->adapter);
+
+       return 0;
+}
+
 static struct dev_pm_ops omap_i2c_pm_ops = {
+       .suspend_noirq = omap_i2c_suspend_noirq,
+       .resume_noirq = omap_i2c_resume_noirq,
+       SET_SYSTEM_SLEEP_PM_OPS(omap_i2c_suspend, NULL)
        SET_RUNTIME_PM_OPS(omap_i2c_runtime_suspend,
                           omap_i2c_runtime_resume, NULL)
 };
