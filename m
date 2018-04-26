Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754452AbeDZTTy (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 15:19:54 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:37555 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751372AbeDZTTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 15:19:51 -0400
X-Google-Smtp-Source: AIpwx49sQj7kktYaHkVxbG8CK46Ics7OgHt/FAnZScvVZoxxSEcn5jCtrapp0nUwEBhqdg4zCEXnrg==
Date: Thu, 26 Apr 2018 12:19:47 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        kernel-janitors@vger.kernel.org, Vladimir Zapolskiy <vz@mleia.com>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        Rakesh Iyer <riyer@nvidia.com>, Laxman Dewangan <ldewangan@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>, linux-input@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH 20/61] input: keyboard: simplify getting .drvdata
Message-ID: <20180426191947.GC162443@dtor-ws>
References: <20180419140641.27926-1-wsa+renesas@sang-engineering.com>
 <20180419140641.27926-21-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180419140641.27926-21-wsa+renesas@sang-engineering.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wolfram,

On Thu, Apr 19, 2018 at 04:05:50PM +0200, Wolfram Sang wrote:
> We should get drvdata from struct device directly. Going via
> platform_device is an unneeded step back and forth.

I consider the fact that platform device's driver data is accessible via
device driver data being implementation detail that may or may not change
in the future, so I'd prefer keep using the proper accessors for the
objects we are dealing with.

Thanks.

> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
> 
> Build tested only. buildbot is happy. Please apply individually.
> 
>  drivers/input/keyboard/ep93xx_keypad.c   | 10 ++++------
>  drivers/input/keyboard/imx_keypad.c      | 10 ++++------
>  drivers/input/keyboard/lpc32xx-keys.c    |  6 ++----
>  drivers/input/keyboard/matrix_keypad.c   | 10 ++++------
>  drivers/input/keyboard/omap4-keypad.c    | 10 ++++------
>  drivers/input/keyboard/pmic8xxx-keypad.c |  6 ++----
>  drivers/input/keyboard/pxa27x_keypad.c   | 10 ++++------
>  drivers/input/keyboard/samsung-keypad.c  | 12 ++++--------
>  drivers/input/keyboard/snvs_pwrkey.c     | 10 ++++------
>  drivers/input/keyboard/spear-keyboard.c  | 10 ++++------
>  drivers/input/keyboard/st-keyscan.c      |  6 ++----
>  drivers/input/keyboard/tegra-kbc.c       | 10 ++++------
>  12 files changed, 42 insertions(+), 68 deletions(-)
> 
> diff --git a/drivers/input/keyboard/ep93xx_keypad.c b/drivers/input/keyboard/ep93xx_keypad.c
> index f77b295e0123..7584a03db4b3 100644
> --- a/drivers/input/keyboard/ep93xx_keypad.c
> +++ b/drivers/input/keyboard/ep93xx_keypad.c
> @@ -185,8 +185,7 @@ static void ep93xx_keypad_close(struct input_dev *pdev)
>  #ifdef CONFIG_PM_SLEEP
>  static int ep93xx_keypad_suspend(struct device *dev)
>  {
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct ep93xx_keypad *keypad = platform_get_drvdata(pdev);
> +	struct ep93xx_keypad *keypad = dev_get_drvdata(dev);
>  	struct input_dev *input_dev = keypad->input_dev;
>  
>  	mutex_lock(&input_dev->mutex);
> @@ -198,7 +197,7 @@ static int ep93xx_keypad_suspend(struct device *dev)
>  
>  	mutex_unlock(&input_dev->mutex);
>  
> -	if (device_may_wakeup(&pdev->dev))
> +	if (device_may_wakeup(dev))
>  		enable_irq_wake(keypad->irq);
>  
>  	return 0;
> @@ -206,11 +205,10 @@ static int ep93xx_keypad_suspend(struct device *dev)
>  
>  static int ep93xx_keypad_resume(struct device *dev)
>  {
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct ep93xx_keypad *keypad = platform_get_drvdata(pdev);
> +	struct ep93xx_keypad *keypad = dev_get_drvdata(dev);
>  	struct input_dev *input_dev = keypad->input_dev;
>  
> -	if (device_may_wakeup(&pdev->dev))
> +	if (device_may_wakeup(dev))
>  		disable_irq_wake(keypad->irq);
>  
>  	mutex_lock(&input_dev->mutex);
> diff --git a/drivers/input/keyboard/imx_keypad.c b/drivers/input/keyboard/imx_keypad.c
> index 25d61d8d4fc4..56328ced81e2 100644
> --- a/drivers/input/keyboard/imx_keypad.c
> +++ b/drivers/input/keyboard/imx_keypad.c
> @@ -532,8 +532,7 @@ static int imx_keypad_probe(struct platform_device *pdev)
>  
>  static int __maybe_unused imx_kbd_suspend(struct device *dev)
>  {
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct imx_keypad *kbd = platform_get_drvdata(pdev);
> +	struct imx_keypad *kbd = dev_get_drvdata(dev);
>  	struct input_dev *input_dev = kbd->input_dev;
>  
>  	/* imx kbd can wake up system even clock is disabled */
> @@ -544,7 +543,7 @@ static int __maybe_unused imx_kbd_suspend(struct device *dev)
>  
>  	mutex_unlock(&input_dev->mutex);
>  
> -	if (device_may_wakeup(&pdev->dev))
> +	if (device_may_wakeup(dev))
>  		enable_irq_wake(kbd->irq);
>  
>  	return 0;
> @@ -552,12 +551,11 @@ static int __maybe_unused imx_kbd_suspend(struct device *dev)
>  
>  static int __maybe_unused imx_kbd_resume(struct device *dev)
>  {
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct imx_keypad *kbd = platform_get_drvdata(pdev);
> +	struct imx_keypad *kbd = dev_get_drvdata(dev);
>  	struct input_dev *input_dev = kbd->input_dev;
>  	int ret = 0;
>  
> -	if (device_may_wakeup(&pdev->dev))
> +	if (device_may_wakeup(dev))
>  		disable_irq_wake(kbd->irq);
>  
>  	mutex_lock(&input_dev->mutex);
> diff --git a/drivers/input/keyboard/lpc32xx-keys.c b/drivers/input/keyboard/lpc32xx-keys.c
> index 1dd57ac0e7a2..0831a6f2a9d4 100644
> --- a/drivers/input/keyboard/lpc32xx-keys.c
> +++ b/drivers/input/keyboard/lpc32xx-keys.c
> @@ -279,8 +279,7 @@ static int lpc32xx_kscan_probe(struct platform_device *pdev)
>  #ifdef CONFIG_PM_SLEEP
>  static int lpc32xx_kscan_suspend(struct device *dev)
>  {
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct lpc32xx_kscan_drv *kscandat = platform_get_drvdata(pdev);
> +	struct lpc32xx_kscan_drv *kscandat = dev_get_drvdata(dev);
>  	struct input_dev *input = kscandat->input;
>  
>  	mutex_lock(&input->mutex);
> @@ -297,8 +296,7 @@ static int lpc32xx_kscan_suspend(struct device *dev)
>  
>  static int lpc32xx_kscan_resume(struct device *dev)
>  {
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct lpc32xx_kscan_drv *kscandat = platform_get_drvdata(pdev);
> +	struct lpc32xx_kscan_drv *kscandat = dev_get_drvdata(dev);
>  	struct input_dev *input = kscandat->input;
>  	int retval = 0;
>  
> diff --git a/drivers/input/keyboard/matrix_keypad.c b/drivers/input/keyboard/matrix_keypad.c
> index 41614c185918..73ca55e4babe 100644
> --- a/drivers/input/keyboard/matrix_keypad.c
> +++ b/drivers/input/keyboard/matrix_keypad.c
> @@ -276,12 +276,11 @@ static void matrix_keypad_disable_wakeup(struct matrix_keypad *keypad)
>  
>  static int matrix_keypad_suspend(struct device *dev)
>  {
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct matrix_keypad *keypad = platform_get_drvdata(pdev);
> +	struct matrix_keypad *keypad = dev_get_drvdata(dev);
>  
>  	matrix_keypad_stop(keypad->input_dev);
>  
> -	if (device_may_wakeup(&pdev->dev))
> +	if (device_may_wakeup(dev))
>  		matrix_keypad_enable_wakeup(keypad);
>  
>  	return 0;
> @@ -289,10 +288,9 @@ static int matrix_keypad_suspend(struct device *dev)
>  
>  static int matrix_keypad_resume(struct device *dev)
>  {
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct matrix_keypad *keypad = platform_get_drvdata(pdev);
> +	struct matrix_keypad *keypad = dev_get_drvdata(dev);
>  
> -	if (device_may_wakeup(&pdev->dev))
> +	if (device_may_wakeup(dev))
>  		matrix_keypad_disable_wakeup(keypad);
>  
>  	matrix_keypad_start(keypad->input_dev);
> diff --git a/drivers/input/keyboard/omap4-keypad.c b/drivers/input/keyboard/omap4-keypad.c
> index 940d38b08e6b..13578b884ace 100644
> --- a/drivers/input/keyboard/omap4-keypad.c
> +++ b/drivers/input/keyboard/omap4-keypad.c
> @@ -422,11 +422,10 @@ MODULE_DEVICE_TABLE(of, omap_keypad_dt_match);
>  #ifdef CONFIG_PM_SLEEP
>  static int omap4_keypad_suspend(struct device *dev)
>  {
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct omap4_keypad *keypad_data = platform_get_drvdata(pdev);
> +	struct omap4_keypad *keypad_data = dev_get_drvdata(dev);
>  	int error;
>  
> -	if (device_may_wakeup(&pdev->dev)) {
> +	if (device_may_wakeup(dev)) {
>  		error = enable_irq_wake(keypad_data->irq);
>  		if (!error)
>  			keypad_data->irq_wake_enabled = true;
> @@ -437,10 +436,9 @@ static int omap4_keypad_suspend(struct device *dev)
>  
>  static int omap4_keypad_resume(struct device *dev)
>  {
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct omap4_keypad *keypad_data = platform_get_drvdata(pdev);
> +	struct omap4_keypad *keypad_data = dev_get_drvdata(dev);
>  
> -	if (device_may_wakeup(&pdev->dev) && keypad_data->irq_wake_enabled) {
> +	if (device_may_wakeup(dev) && keypad_data->irq_wake_enabled) {
>  		disable_irq_wake(keypad_data->irq);
>  		keypad_data->irq_wake_enabled = false;
>  	}
> diff --git a/drivers/input/keyboard/pmic8xxx-keypad.c b/drivers/input/keyboard/pmic8xxx-keypad.c
> index 98b24ed18752..048a39321298 100644
> --- a/drivers/input/keyboard/pmic8xxx-keypad.c
> +++ b/drivers/input/keyboard/pmic8xxx-keypad.c
> @@ -636,8 +636,7 @@ static int pmic8xxx_kp_probe(struct platform_device *pdev)
>  #ifdef CONFIG_PM_SLEEP
>  static int pmic8xxx_kp_suspend(struct device *dev)
>  {
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct pmic8xxx_kp *kp = platform_get_drvdata(pdev);
> +	struct pmic8xxx_kp *kp = dev_get_drvdata(dev);
>  	struct input_dev *input_dev = kp->input;
>  
>  	if (device_may_wakeup(dev)) {
> @@ -656,8 +655,7 @@ static int pmic8xxx_kp_suspend(struct device *dev)
>  
>  static int pmic8xxx_kp_resume(struct device *dev)
>  {
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct pmic8xxx_kp *kp = platform_get_drvdata(pdev);
> +	struct pmic8xxx_kp *kp = dev_get_drvdata(dev);
>  	struct input_dev *input_dev = kp->input;
>  
>  	if (device_may_wakeup(dev)) {
> diff --git a/drivers/input/keyboard/pxa27x_keypad.c b/drivers/input/keyboard/pxa27x_keypad.c
> index d0bdaeadf86d..1f54a3162124 100644
> --- a/drivers/input/keyboard/pxa27x_keypad.c
> +++ b/drivers/input/keyboard/pxa27x_keypad.c
> @@ -666,14 +666,13 @@ static void pxa27x_keypad_close(struct input_dev *dev)
>  #ifdef CONFIG_PM_SLEEP
>  static int pxa27x_keypad_suspend(struct device *dev)
>  {
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct pxa27x_keypad *keypad = platform_get_drvdata(pdev);
> +	struct pxa27x_keypad *keypad = dev_get_drvdata(dev);
>  
>  	/*
>  	 * If the keypad is used a wake up source, clock can not be disabled.
>  	 * Or it can not detect the key pressing.
>  	 */
> -	if (device_may_wakeup(&pdev->dev))
> +	if (device_may_wakeup(dev))
>  		enable_irq_wake(keypad->irq);
>  	else
>  		clk_disable_unprepare(keypad->clk);
> @@ -683,8 +682,7 @@ static int pxa27x_keypad_suspend(struct device *dev)
>  
>  static int pxa27x_keypad_resume(struct device *dev)
>  {
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct pxa27x_keypad *keypad = platform_get_drvdata(pdev);
> +	struct pxa27x_keypad *keypad = dev_get_drvdata(dev);
>  	struct input_dev *input_dev = keypad->input_dev;
>  	int ret = 0;
>  
> @@ -692,7 +690,7 @@ static int pxa27x_keypad_resume(struct device *dev)
>  	 * If the keypad is used as wake up source, the clock is not turned
>  	 * off. So do not need configure it again.
>  	 */
> -	if (device_may_wakeup(&pdev->dev)) {
> +	if (device_may_wakeup(dev)) {
>  		disable_irq_wake(keypad->irq);
>  	} else {
>  		mutex_lock(&input_dev->mutex);
> diff --git a/drivers/input/keyboard/samsung-keypad.c b/drivers/input/keyboard/samsung-keypad.c
> index 316414465c77..27790a8a44f5 100644
> --- a/drivers/input/keyboard/samsung-keypad.c
> +++ b/drivers/input/keyboard/samsung-keypad.c
> @@ -466,8 +466,7 @@ static int samsung_keypad_remove(struct platform_device *pdev)
>  #ifdef CONFIG_PM
>  static int samsung_keypad_runtime_suspend(struct device *dev)
>  {
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct samsung_keypad *keypad = platform_get_drvdata(pdev);
> +	struct samsung_keypad *keypad = dev_get_drvdata(dev);
>  	unsigned int val;
>  	int error;
>  
> @@ -490,8 +489,7 @@ static int samsung_keypad_runtime_suspend(struct device *dev)
>  
>  static int samsung_keypad_runtime_resume(struct device *dev)
>  {
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct samsung_keypad *keypad = platform_get_drvdata(pdev);
> +	struct samsung_keypad *keypad = dev_get_drvdata(dev);
>  	unsigned int val;
>  
>  	if (keypad->stopped)
> @@ -535,8 +533,7 @@ static void samsung_keypad_toggle_wakeup(struct samsung_keypad *keypad,
>  
>  static int samsung_keypad_suspend(struct device *dev)
>  {
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct samsung_keypad *keypad = platform_get_drvdata(pdev);
> +	struct samsung_keypad *keypad = dev_get_drvdata(dev);
>  	struct input_dev *input_dev = keypad->input_dev;
>  
>  	mutex_lock(&input_dev->mutex);
> @@ -553,8 +550,7 @@ static int samsung_keypad_suspend(struct device *dev)
>  
>  static int samsung_keypad_resume(struct device *dev)
>  {
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct samsung_keypad *keypad = platform_get_drvdata(pdev);
> +	struct samsung_keypad *keypad = dev_get_drvdata(dev);
>  	struct input_dev *input_dev = keypad->input_dev;
>  
>  	mutex_lock(&input_dev->mutex);
> diff --git a/drivers/input/keyboard/snvs_pwrkey.c b/drivers/input/keyboard/snvs_pwrkey.c
> index 53c768b95939..f439f7bd2f5f 100644
> --- a/drivers/input/keyboard/snvs_pwrkey.c
> +++ b/drivers/input/keyboard/snvs_pwrkey.c
> @@ -180,10 +180,9 @@ static int imx_snvs_pwrkey_probe(struct platform_device *pdev)
>  
>  static int __maybe_unused imx_snvs_pwrkey_suspend(struct device *dev)
>  {
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct pwrkey_drv_data *pdata = platform_get_drvdata(pdev);
> +	struct pwrkey_drv_data *pdata = dev_get_drvdata(dev);
>  
> -	if (device_may_wakeup(&pdev->dev))
> +	if (device_may_wakeup(dev))
>  		enable_irq_wake(pdata->irq);
>  
>  	return 0;
> @@ -191,10 +190,9 @@ static int __maybe_unused imx_snvs_pwrkey_suspend(struct device *dev)
>  
>  static int __maybe_unused imx_snvs_pwrkey_resume(struct device *dev)
>  {
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct pwrkey_drv_data *pdata = platform_get_drvdata(pdev);
> +	struct pwrkey_drv_data *pdata = dev_get_drvdata(dev);
>  
> -	if (device_may_wakeup(&pdev->dev))
> +	if (device_may_wakeup(dev))
>  		disable_irq_wake(pdata->irq);
>  
>  	return 0;
> diff --git a/drivers/input/keyboard/spear-keyboard.c b/drivers/input/keyboard/spear-keyboard.c
> index 7d25fa338ab4..a0276a3376d2 100644
> --- a/drivers/input/keyboard/spear-keyboard.c
> +++ b/drivers/input/keyboard/spear-keyboard.c
> @@ -288,8 +288,7 @@ static int spear_kbd_remove(struct platform_device *pdev)
>  
>  static int __maybe_unused spear_kbd_suspend(struct device *dev)
>  {
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct spear_kbd *kbd = platform_get_drvdata(pdev);
> +	struct spear_kbd *kbd = dev_get_drvdata(dev);
>  	struct input_dev *input_dev = kbd->input;
>  	unsigned int rate = 0, mode_ctl_reg, val;
>  
> @@ -300,7 +299,7 @@ static int __maybe_unused spear_kbd_suspend(struct device *dev)
>  
>  	mode_ctl_reg = readl_relaxed(kbd->io_base + MODE_CTL_REG);
>  
> -	if (device_may_wakeup(&pdev->dev)) {
> +	if (device_may_wakeup(dev)) {
>  		if (!enable_irq_wake(kbd->irq))
>  			kbd->irq_wake_enabled = true;
>  
> @@ -341,13 +340,12 @@ static int __maybe_unused spear_kbd_suspend(struct device *dev)
>  
>  static int __maybe_unused spear_kbd_resume(struct device *dev)
>  {
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct spear_kbd *kbd = platform_get_drvdata(pdev);
> +	struct spear_kbd *kbd = dev_get_drvdata(dev);
>  	struct input_dev *input_dev = kbd->input;
>  
>  	mutex_lock(&input_dev->mutex);
>  
> -	if (device_may_wakeup(&pdev->dev)) {
> +	if (device_may_wakeup(dev)) {
>  		if (kbd->irq_wake_enabled) {
>  			kbd->irq_wake_enabled = false;
>  			disable_irq_wake(kbd->irq);
> diff --git a/drivers/input/keyboard/st-keyscan.c b/drivers/input/keyboard/st-keyscan.c
> index babcfb165e4f..3b4727e4b411 100644
> --- a/drivers/input/keyboard/st-keyscan.c
> +++ b/drivers/input/keyboard/st-keyscan.c
> @@ -218,8 +218,7 @@ static int keyscan_probe(struct platform_device *pdev)
>  #ifdef CONFIG_PM_SLEEP
>  static int keyscan_suspend(struct device *dev)
>  {
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct st_keyscan *keypad = platform_get_drvdata(pdev);
> +	struct st_keyscan *keypad = dev_get_drvdata(dev);
>  	struct input_dev *input = keypad->input_dev;
>  
>  	mutex_lock(&input->mutex);
> @@ -235,8 +234,7 @@ static int keyscan_suspend(struct device *dev)
>  
>  static int keyscan_resume(struct device *dev)
>  {
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct st_keyscan *keypad = platform_get_drvdata(pdev);
> +	struct st_keyscan *keypad = dev_get_drvdata(dev);
>  	struct input_dev *input = keypad->input_dev;
>  	int retval = 0;
>  
> diff --git a/drivers/input/keyboard/tegra-kbc.c b/drivers/input/keyboard/tegra-kbc.c
> index 875205f445b5..861bfcbd817d 100644
> --- a/drivers/input/keyboard/tegra-kbc.c
> +++ b/drivers/input/keyboard/tegra-kbc.c
> @@ -744,11 +744,10 @@ static void tegra_kbc_set_keypress_interrupt(struct tegra_kbc *kbc, bool enable)
>  
>  static int tegra_kbc_suspend(struct device *dev)
>  {
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct tegra_kbc *kbc = platform_get_drvdata(pdev);
> +	struct tegra_kbc *kbc = dev_get_drvdata(dev);
>  
>  	mutex_lock(&kbc->idev->mutex);
> -	if (device_may_wakeup(&pdev->dev)) {
> +	if (device_may_wakeup(dev)) {
>  		disable_irq(kbc->irq);
>  		del_timer_sync(&kbc->timer);
>  		tegra_kbc_set_fifo_interrupt(kbc, false);
> @@ -781,12 +780,11 @@ static int tegra_kbc_suspend(struct device *dev)
>  
>  static int tegra_kbc_resume(struct device *dev)
>  {
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct tegra_kbc *kbc = platform_get_drvdata(pdev);
> +	struct tegra_kbc *kbc = dev_get_drvdata(dev);
>  	int err = 0;
>  
>  	mutex_lock(&kbc->idev->mutex);
> -	if (device_may_wakeup(&pdev->dev)) {
> +	if (device_may_wakeup(dev)) {
>  		disable_irq_wake(kbc->irq);
>  		tegra_kbc_setup_wakekeys(kbc, false);
>  		/* We will use fifo interrupts for key detection. */
> -- 
> 2.11.0
> 

-- 
Dmitry
