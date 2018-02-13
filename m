Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934725AbeBMJaZ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 04:30:25 -0500
Received: from mail-wm0-f43.google.com ([74.125.82.43]:51573 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934322AbeBMJaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 04:30:17 -0500
X-Google-Smtp-Source: AH8x225sqt0zhHHqYfd9JwdsDEYbkSp6VHI4Sfk9V5tMPhCSZmn0NhN+geQQ9aXhtXYElg3ZZMJ7Ow==
Date: Tue, 13 Feb 2018 09:30:13 +0000
From: Lee Jones <lee.jones@linaro.org>
To: kbuild test robot <fengguang.wu@intel.com>
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, kbuild-all@01.org,
        linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Subject: Re: drivers/watchdog/rave-sp-wdt.c:278: undefined reference to
 `nvmem_cell_get'
Message-ID: <20180213093013.rsoprhs5aoimyy2r@dell>
References: <201802131728.QBRqHsyy%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <201802131728.QBRqHsyy%fengguang.wu@intel.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Feb 2018, kbuild test robot wrote:

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   178e834c47b0d01352c48730235aae69898fbc02
> commit: c3bb333457218ca4ed9553be47c0f567b4ef8a38 watchdog: Add RAVE SP watchdog driver
> date:   5 weeks ago
> config: x86_64-randconfig-u0-02131401 (attached as .config)
> compiler: gcc-5 (Debian 5.5.0-3) 5.4.1 20171010
> reproduce:
>         git checkout c3bb333457218ca4ed9553be47c0f567b4ef8a38
>         # save the attached .config to linux build tree
>         make ARCH=x86_64 
> 
> All errors (new ones prefixed by >>):
> 
>    drivers/watchdog/rave-sp-wdt.o: In function `rave_sp_wdt_probe':
> >> drivers/watchdog/rave-sp-wdt.c:278: undefined reference to `nvmem_cell_get'
> >> drivers/watchdog/rave-sp-wdt.c:281: undefined reference to `nvmem_cell_read'
> >> drivers/watchdog/rave-sp-wdt.c:287: undefined reference to `nvmem_cell_put'
>    make[2]: *** [vmlinux] Error 1

Looks like the RAVE Watchdog driver should select NVMEM?

> vim +278 drivers/watchdog/rave-sp-wdt.c
> 
>    252	
>    253	static int rave_sp_wdt_probe(struct platform_device *pdev)
>    254	{
>    255		struct device *dev = &pdev->dev;
>    256		struct watchdog_device *wdd;
>    257		struct rave_sp_wdt *sp_wd;
>    258		struct nvmem_cell *cell;
>    259		__le16 timeout = 0;
>    260		int ret;
>    261	
>    262		sp_wd = devm_kzalloc(dev, sizeof(*sp_wd), GFP_KERNEL);
>    263		if (!sp_wd)
>    264			return -ENOMEM;
>    265	
>    266		sp_wd->variant = of_device_get_match_data(dev);
>    267		sp_wd->sp      = dev_get_drvdata(dev->parent);
>    268	
>    269		wdd              = &sp_wd->wdd;
>    270		wdd->parent      = dev;
>    271		wdd->info        = &rave_sp_wdt_info;
>    272		wdd->ops         = &rave_sp_wdt_ops;
>    273		wdd->min_timeout = sp_wd->variant->min_timeout;
>    274		wdd->max_timeout = sp_wd->variant->max_timeout;
>    275		wdd->status      = WATCHDOG_NOWAYOUT_INIT_STATUS;
>    276		wdd->timeout     = 60;
>    277	
>  > 278		cell = nvmem_cell_get(dev, "wdt-timeout");
>    279		if (!IS_ERR(cell)) {
>    280			size_t len;
>  > 281			void *value = nvmem_cell_read(cell, &len);
>    282	
>    283			if (!IS_ERR(value)) {
>    284				memcpy(&timeout, value, min(len, sizeof(timeout)));
>    285				kfree(value);
>    286			}
>  > 287			nvmem_cell_put(cell);
>    288		}
>    289		watchdog_init_timeout(wdd, le16_to_cpu(timeout), dev);
>    290		watchdog_set_restart_priority(wdd, 255);
>    291		watchdog_stop_on_unregister(wdd);
>    292	
>    293		sp_wd->reboot_notifier.notifier_call = rave_sp_wdt_reboot_notifier;
>    294		ret = devm_register_reboot_notifier(dev, &sp_wd->reboot_notifier);
>    295		if (ret) {
>    296			dev_err(dev, "Failed to register reboot notifier\n");
>    297			return ret;
>    298		}
>    299	
>    300		/*
>    301		 * We don't know if watchdog is running now. To be sure, let's
>    302		 * start it and depend on watchdog core to ping it
>    303		 */
>    304		wdd->max_hw_heartbeat_ms = wdd->max_timeout * 1000;
>    305		ret = rave_sp_wdt_start(wdd);
>    306		if (ret) {
>    307			dev_err(dev, "Watchdog didn't start\n");
>    308			return ret;
>    309		}
>    310	
>    311		ret = devm_watchdog_register_device(dev, wdd);
>    312		if (ret) {
>    313			dev_err(dev, "Failed to register watchdog device\n");
>    314			rave_sp_wdt_stop(wdd);
>    315			return ret;
>    316		}
>    317	
>    318		return 0;
>    319	}
>    320	
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation



-- 
Lee Jones
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
