Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752141AbeEGJIc (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 05:08:32 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:42462 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751940AbeEGJIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 05:08:22 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Mon, 07 May 2018 14:38:20 +0530
From: kgunda@codeaurora.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: kbuild@01.org, kbuild-all@01.org, bjorn.andersson@linaro.org,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-arm-msm-owner@vger.kernel.org
Subject: Re: [PATCH V1 3/5] backlight: qcom-wled: Add support for short
 circuit handling
In-Reply-To: <20180507080638.enmel5keygu5ag3h@mwanda>
References: <20180507080638.enmel5keygu5ag3h@mwanda>
Message-ID: <4bd09b09c514825785c3e9486b3d6c78@codeaurora.org>
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-05-07 13:36, Dan Carpenter wrote:
> Hi Kiran,
> 
> Thank you for the patch! Perhaps something to improve:
> 
> [auto build test WARNING on backlight/for-backlight-next]
> [also build test WARNING on v4.17-rc3 next-20180504]
> [if your patch is applied to the wrong git tree, please drop us a note
> to help improve the system]
> 
> url:
> https://github.com/0day-ci/linux/commits/Kiran-Gunda/backlight-qcom-wled-Support-for-QCOM-wled-driver/20180504-011042
> base:
> https://git.kernel.org/pub/scm/linux/kernel/git/lee/backlight.git
> for-backlight-next
> 
> smatch warnings:
> drivers/video/backlight/qcom-wled.c:304 wled_update_status() warn:
> inconsistent returns 'mutex:&wled->lock'.
>   Locked on:   line 287
>   Unlocked on: line 304
> 
Will fix it in the next series.
> #
> https://github.com/0day-ci/linux/commit/3856199804123df89ef9a712f0740978ec71ddf6
> git remote add linux-review https://github.com/0day-ci/linux
> git remote update linux-review
> git checkout 3856199804123df89ef9a712f0740978ec71ddf6
> vim +304 drivers/video/backlight/qcom-wled.c
> 
> 18e7abb8 drivers/video/backlight/qcom-wled.c Kiran Gunda    2018-05-03  
> 263
> 18e7abb8 drivers/video/backlight/qcom-wled.c Kiran Gunda    2018-05-03
>  264  static int wled_update_status(struct backlight_device *bl)
> 18e7abb8 drivers/video/backlight/qcom-wled.c Kiran Gunda    2018-05-03  
> 265  {
> 18e7abb8 drivers/video/backlight/qcom-wled.c Kiran Gunda    2018-05-03
>  266  	struct wled *wled = bl_get_data(bl);
> 18e7abb8 drivers/video/backlight/qcom-wled.c Kiran Gunda    2018-05-03
>  267  	u16 brightness = bl->props.brightness;
> 18e7abb8 drivers/video/backlight/qcom-wled.c Kiran Gunda    2018-05-03
>  268  	int rc = 0;
> 18e7abb8 drivers/video/backlight/qcom-wled.c Kiran Gunda    2018-05-03  
> 269
> 18e7abb8 drivers/video/backlight/qcom-wled.c Kiran Gunda    2018-05-03
>  270  	if (bl->props.power != FB_BLANK_UNBLANK ||
> 18e7abb8 drivers/video/backlight/qcom-wled.c Kiran Gunda    2018-05-03
>  271  	    bl->props.fb_blank != FB_BLANK_UNBLANK ||
> 18e7abb8 drivers/video/backlight/qcom-wled.c Kiran Gunda    2018-05-03
>  272  	    bl->props.state & BL_CORE_FBBLANK)
> 18e7abb8 drivers/video/backlight/qcom-wled.c Kiran Gunda    2018-05-03
>  273  		brightness = 0;
> 18e7abb8 drivers/video/backlight/qcom-wled.c Kiran Gunda    2018-05-03  
> 274
> 38561998 drivers/video/backlight/qcom-wled.c Kiran Gunda    2018-05-03
>  275  	mutex_lock(&wled->lock);
> 18e7abb8 drivers/video/backlight/qcom-wled.c Kiran Gunda    2018-05-03
>  276  	if (brightness) {
> 18e7abb8 drivers/video/backlight/qcom-wled.c Kiran Gunda    2018-05-03
>  277  		rc = wled->wled_set_brightness(wled, brightness);
> 18e7abb8 drivers/video/backlight/qcom-wled.c Kiran Gunda    2018-05-03
>  278  		if (rc < 0) {
> 18e7abb8 drivers/video/backlight/qcom-wled.c Kiran Gunda    2018-05-03
>  279  			dev_err(wled->dev, "wled failed to set brightness rc:%d\n",
> 18e7abb8 drivers/video/backlight/qcom-wled.c Kiran Gunda    2018-05-03
>  280  				rc);
> 38561998 drivers/video/backlight/qcom-wled.c Kiran Gunda    2018-05-03
>  281  			goto unlock_mutex;
> 18e7abb8 drivers/video/backlight/qcom-wled.c Kiran Gunda    2018-05-03  
> 282  		}
> 18e7abb8 drivers/video/backlight/qcom-wled.c Kiran Gunda    2018-05-03  
> 283
> 18e7abb8 drivers/video/backlight/qcom-wled.c Kiran Gunda    2018-05-03
>  284  		rc = wled->wled_sync_toggle(wled);
> 18e7abb8 drivers/video/backlight/qcom-wled.c Kiran Gunda    2018-05-03
>  285  		if (rc < 0) {
> 18e7abb8 drivers/video/backlight/qcom-wled.c Kiran Gunda    2018-05-03
>  286  			dev_err(wled->dev, "wled sync failed rc:%d\n", rc);
> 93c64f1e drivers/leds/leds-pm8941-wled.c     Courtney Cavin 2015-03-12
>  287  			return rc;
> 18e7abb8 drivers/video/backlight/qcom-wled.c Kiran Gunda    2018-05-03  
> 288  		}
> 18e7abb8 drivers/video/backlight/qcom-wled.c Kiran Gunda    2018-05-03  
> 289  	}
> 18e7abb8 drivers/video/backlight/qcom-wled.c Kiran Gunda    2018-05-03  
> 290
> 18e7abb8 drivers/video/backlight/qcom-wled.c Kiran Gunda    2018-05-03
>  291  	if (!!brightness != !!wled->brightness) {
> 18e7abb8 drivers/video/backlight/qcom-wled.c Kiran Gunda    2018-05-03
>  292  		rc = wled_module_enable(wled, !!brightness);
> 18e7abb8 drivers/video/backlight/qcom-wled.c Kiran Gunda    2018-05-03
>  293  		if (rc < 0) {
> 18e7abb8 drivers/video/backlight/qcom-wled.c Kiran Gunda    2018-05-03
>  294  			dev_err(wled->dev, "wled enable failed rc:%d\n", rc);
> 38561998 drivers/video/backlight/qcom-wled.c Kiran Gunda    2018-05-03
>  295  			goto unlock_mutex;
> 18e7abb8 drivers/video/backlight/qcom-wled.c Kiran Gunda    2018-05-03  
> 296  		}
> 18e7abb8 drivers/video/backlight/qcom-wled.c Kiran Gunda    2018-05-03  
> 297  	}
> 18e7abb8 drivers/video/backlight/qcom-wled.c Kiran Gunda    2018-05-03  
> 298
> 18e7abb8 drivers/video/backlight/qcom-wled.c Kiran Gunda    2018-05-03
>  299  	wled->brightness = brightness;
> 18e7abb8 drivers/video/backlight/qcom-wled.c Kiran Gunda    2018-05-03  
> 300
> 38561998 drivers/video/backlight/qcom-wled.c Kiran Gunda    2018-05-03
>  301  unlock_mutex:
> 38561998 drivers/video/backlight/qcom-wled.c Kiran Gunda    2018-05-03
>  302  	mutex_unlock(&wled->lock);
> 38561998 drivers/video/backlight/qcom-wled.c Kiran Gunda    2018-05-03  
> 303
> 18e7abb8 drivers/video/backlight/qcom-wled.c Kiran Gunda    2018-05-03
> @304  	return rc;
> 18e7abb8 drivers/video/backlight/qcom-wled.c Kiran Gunda    2018-05-03  
> 305  }
> 18e7abb8 drivers/video/backlight/qcom-wled.c Kiran Gunda    2018-05-03  
> 306
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology 
> Center
> https://lists.01.org/pipermail/kbuild-all                   Intel 
> Corporation
> --
> To unsubscribe from this list: send the line "unsubscribe 
> linux-arm-msm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
