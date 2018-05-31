Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755059AbeEaNO7 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 09:14:59 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:45326 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754197AbeEaNO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 09:14:56 -0400
X-Google-Smtp-Source: ADUXVKJYd6zt3iNxc0fTtQXFw1cL+KWqHZuzemkOM/PczrG7vZXlk0cRydTfhrrIZi2qWMPnwkPRHA==
Subject: Re: [PATCH v1 2/2] hwmon: npcm-pwm: add NPCM7xx PWM driver
To: kbuild test robot <lkp@intel.com>, Tomer Maimon <tmaimon77@gmail.com>
Cc: kbuild-all@01.org, robh+dt@kernel.org, mark.rutland@arm.com,
        jdelvare@suse.com, avifishman70@gmail.com, yuenn@google.com,
        brendanhiggins@google.com, venture@google.com, joel@jms.id.au,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, openbmc@lists.ozlabs.org
References: <1527588141-18639-3-git-send-email-tmaimon77@gmail.com>
 <201805311515.VL3llohd%fengguang.wu@intel.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <6843f9d0-55e6-725e-456b-533123c2d9c4@roeck-us.net>
Date: Thu, 31 May 2018 06:14:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <201805311515.VL3llohd%fengguang.wu@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/31/2018 12:16 AM, kbuild test robot wrote:
> Hi Tomer,
> 
> I love your patch! Perhaps something to improve:
> 
> [auto build test WARNING on hwmon/hwmon-next]
> [also build test WARNING on v4.17-rc7]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Tomer-Maimon/dt-binding-hwmon-Add-NPCM7xx-PWM-documentation/20180531-034040
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-next
> config: x86_64-allmodconfig
> compiler: gcc-7 (Debian 7.3.0-16) 7.3.0
> reproduce:
>          make ARCH=x86_64  allmodconfig
>          make ARCH=x86_64
> 
> All warnings (new ones prefixed by >>):
> 
> 
> vim +277 drivers/hwmon/npcm7xx-pwm.c
> 
>     250	
>     251	static int npcm7xx_pwm_probe(struct platform_device *pdev)
>     252	{
>     253		struct device *dev = &pdev->dev;
>     254		struct npcm7xx_pwm_data *data;
>     255		struct resource res[NPCM7XX_PWM_MAX_MODULES];
>     256		struct device *hwmon;
>     257		struct clk *clk;
>     258		int m, ch, res_cnt, ret;
>     259		u32 Prescale_val, output_freq;
>     260	
>     261		data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
>     262		if (!data)
>     263			return -ENOMEM;
>     264	
>     265		for (res_cnt = 0; res_cnt < NPCM7XX_PWM_MAX_MODULES  ; res_cnt++) {
>     266			ret = of_address_to_resource(dev->of_node, res_cnt,
>     267						     &res[res_cnt]);
>     268			if (ret) {
>     269				pr_err("PWM of_address_to_resource fail ret %d\n",
>     270				       ret);
>     271				return -EINVAL;
>     272			}
>     273	
>     274			data->pwm_base[res_cnt] =
>     275				devm_ioremap_resource(dev, &(res[res_cnt]));
>   > 276			pr_debug("pwm%d base is 0x%08X, res.start 0x%08X , size 0x%08X\n",
>   > 277				 res_cnt, (u32)data->pwm_base[res_cnt],
>     278				 res[res_cnt].start, resource_size(&(res[res_cnt])));
>     279

No idea what the tool is complaining about, but the messages should use dev_ functions.

>     280			if (!data->pwm_base[res_cnt]) {
>     281				pr_err("pwm probe failed: can't read pwm base address for resource %d.\n",
>     282				       res_cnt);
>     283				return -ENOMEM;
>     284			}
>     285	
>     286			mutex_init(&data->npcm7xx_pwm_lock[res_cnt]);
>     287		}
>     288	
>     289		clk = devm_clk_get(dev, NULL);
>     290		if (IS_ERR(clk))
>     291			return -ENODEV;
>     292	
>     293		data->clk_freq = clk_get_rate(clk);
>     294	
>     295		/* Adjust NPCM7xx PWMs output frequency to ~25Khz */
>     296		output_freq = data->clk_freq / PWN_CNT_DEFAULT;
>     297		Prescale_val = DIV_ROUND_CLOSEST(output_freq, PWM_OUTPUT_FREQ_25KHZ);
>     298	
>     299		/* If Prescale_val = 0, then the prescale output clock is stopped */
>     300		if (Prescale_val < MIN_PRESCALE1)
>     301			Prescale_val = MIN_PRESCALE1;
>     302		/*
>     303		 * Prescale_val need to decrement in one because in the PWM Prescale
>     304		 * register the Prescale value increment by one
>     305		 */
>     306		Prescale_val--;
>     307	
>     308		/* Setting PWM Prescale Register value register to both modules */
>     309		Prescale_val |= (Prescale_val << NPCM7XX_PWM_PRESCALE_SHIFT_CH01);
>     310	
>     311		for (m = 0; m < NPCM7XX_PWM_MAX_MODULES  ; m++) {
>     312			iowrite32(Prescale_val,
>     313				  data->pwm_base[m] + NPCM7XX_PWM_REG_PR);
>     314			iowrite32(NPCM7XX_PWM_PRESCALE2_DEFALUT,
>     315				  data->pwm_base[m] + NPCM7XX_PWM_REG_CSR);
>     316			iowrite32(NPCM7XX_PWM_CTRL_MODE_DEFALUT,
>     317				  data->pwm_base[m] + NPCM7XX_PWM_REG_CR);
>     318	
>     319			for (ch = 0; ch < NPCM7XX_PWM_MAX_CHN_NUM; ch++) {
>     320				iowrite32(NPCM7XX_PWM_COUNTER_DEFALUT_NUM,
>     321					  data->pwm_base[m] + NPCM7XX_PWM_REG_CNRx(ch));
>     322				iowrite32(NPCM7XX_PWM_COMPARATOR_DEFALUT_NUM,
>     323					  data->pwm_base[m] + NPCM7XX_PWM_REG_CMRx(ch));
>     324			}
>     325	
>     326			iowrite32(NPCM7XX_PWM_CTRL_MODE_DEFALUT |
>     327				  NPCM7XX_PWM_CTRL_EN_DEFALUT,
>     328				  data->pwm_base[m] + NPCM7XX_PWM_REG_CR);
>     329		}
>     330	
>     331		hwmon = devm_hwmon_device_register_with_info(dev, "npcm7xx_pwm", data,
>     332							     &npcm7xx_chip_info, NULL);
>     333	
>     334		if (IS_ERR(hwmon)) {
>     335			pr_err("PWM Driver failed - devm_hwmon_device_register_with_groups failed\n");
>     336			return PTR_ERR(hwmon);
>     337		}
>     338	
>     339		pr_info("NPCM7XX PWM Driver probed, PWM output Freq %dHz\n",
>     340			output_freq / ((Prescale_val & 0xf) + 1));
>     341	
>     342		return 0;
>     343	}
>     344	
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
> --
> To unsubscribe from this list: send the line "unsubscribe linux-hwmon" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
