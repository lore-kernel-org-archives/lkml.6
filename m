Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752064AbeEGIHN (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 04:07:13 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:54539 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752045AbeEGIHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 04:07:03 -0400
X-Google-Smtp-Source: AB8JxZokYysOphns7s8ljyRazWDM03LV3GMU2LSOVqQTc5NHh9oERJJ+ktauuO5FlKLLQ2zpCp6APD6GpAQNqrEqk6E=
MIME-Version: 1.0
In-Reply-To: <CAPpJ_ed-JPOzQPtyCdH4_C7dzEeM3fznus8XDuaojaiM_4nFpw@mail.gmail.com>
References: <CAPpJ_ed-JPOzQPtyCdH4_C7dzEeM3fznus8XDuaojaiM_4nFpw@mail.gmail.com>
From: Chris Chiu <chiu@endlessm.com>
Date: Mon, 7 May 2018 16:07:01 +0800
Message-ID: <CAB4CAwcKu88xP0R9P-3csd6SE2fZ-Vb6OrQD9AmBDh6p77VFDQ@mail.gmail.com>
Subject: Re: [BUG] i2c-hid: ELAN Touchpad does not work on ASUS X580GD
To: Jian-Hong Pan <jian-hong@endlessm.com>
Cc: Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Adrian Salido <salidoa@google.com>,
        Jason Gerecke <killertofu@gmail.com>, linux-input@vger.kernel.org,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Daniel Drake <drake@endlessm.com>,
        Linux Upstreaming Team <linux@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 4, 2018 at 2:55 PM, Jian-Hong Pan <jian-hong@endlessm.com> wrote:
> Hi,
>
> We have an ASUS X580GD (Intel(R) Core(TM) i5-8300H CPU @ 2.30GHz) laptop
> equipped with ELAN1200 touchpad which does not work totally, but the
> external mouse works fine.
>
> We have checked the input devices by "cat /proc/bus/input/devices", and
> the touchpad does not appear in the list.
>
> According to ASUS' information, the ELAN touchpad is attached to the i2c
> bus of the system.  Then, we do find the corresponding error messages in
> dmesg:
>
> with kernel 4.15.15
> [   10.290192] i2c_hid i2c-ELAN1200:00: i2c-ELAN1200:00 supply vdd not
> found, using dummy regulator
> [   10.290818] i2c_hid i2c-ELAN1200:00: can't add hid device: -22
> [   10.290852] i2c_hid: probe of i2c-ELAN1200:00 failed with error -22
>
> with kernel 4.16.7
> [   10.638729] i2c_hid i2c-ELAN1200:00: i2c-ELAN1200:00 supply vdd not
> found, using dummy regulator
> [   10.639304] i2c_hid i2c-ELAN1200:00: unexpected HID descriptor
> bcdVersion (0xff00)
>
> Then check the i2c bus and get:
> i2c-7
>   name: Synopsys DesignWare I2C adapter
>   firmware_path: \_SB_.PCI0.I2C1
>   driver: i2c_designware
>
> i2c-ELAN1200:00
>   name: ELAN1200:00
>   firmware_path: \_SB_.PCI0.I2C1.ETPD
>
> Besides, according to ASUS's input, they observed that after entering
> the OS, the frequency of SCL is too fast (about 600kHz) and the SCL High
> time is around 450ns, not following I2C spec which is 0.6us.
> https://pasteboard.co/HjzSWXd.png
>
> so, we get the kernel 4.17-rc3 and add some debug message:
>
> diff --git a/drivers/i2c/busses/i2c-designware-master.c
> b/drivers/i2c/busses/i2c-designware-master.c
> index fd36c39ddf4e..bbe76e033133 100644
> --- a/drivers/i2c/busses/i2c-designware-master.c
> +++ b/drivers/i2c/busses/i2c-designware-master.c
> @@ -88,10 +88,12 @@ static int i2c_dw_init_master(struct dw_i2c_dev *dev)
>         sda_falling_time = dev->sda_falling_time ?: 300; /* ns */
>         scl_falling_time = dev->scl_falling_time ?: 300; /* ns */
>
> +printk("%s sda falling %u scl falling %u\n", __func__,
> sda_falling_time, scl_falling_time);
>         /* Set SCL timing parameters for standard-mode */
>         if (dev->ss_hcnt && dev->ss_lcnt) {
>                 hcnt = dev->ss_hcnt;
>                 lcnt = dev->ss_lcnt;
> +printk("%s ss set hcnt %u lcnt %u\n", __func__, hcnt, lcnt);
>         } else {
>                 hcnt = i2c_dw_scl_hcnt(i2c_dw_clk_rate(dev),
>                                         4000,   /* tHD;STA = tHIGH = 4.0 us */
> @@ -102,10 +104,11 @@ static int i2c_dw_init_master(struct dw_i2c_dev *dev)
>                                         4700,   /* tLOW = 4.7 us */
>                                         scl_falling_time,
>                                         0);     /* No offset */
> +printk("%s ss no hcnt %u lcnt %u\n", __func__, hcnt, lcnt);
>         }
>         dw_writel(dev, hcnt, DW_IC_SS_SCL_HCNT);
>         dw_writel(dev, lcnt, DW_IC_SS_SCL_LCNT);
> -       dev_dbg(dev->dev, "Standard-mode HCNT:LCNT = %d:%d\n", hcnt, lcnt);
> +       dev_err(dev->dev, "Standard-mode HCNT:LCNT = %d:%d\n", hcnt, lcnt);
>
>         /* Set SCL timing parameters for fast-mode or fast-mode plus */
>         if ((dev->clk_freq == 1000000) && dev->fp_hcnt && dev->fp_lcnt) {
> @@ -114,6 +117,7 @@ static int i2c_dw_init_master(struct dw_i2c_dev *dev)
>         } else if (dev->fs_hcnt && dev->fs_lcnt) {
>                 hcnt = dev->fs_hcnt;
>                 lcnt = dev->fs_lcnt;
> +printk("%s fs set hcnt %u lcnt %u\n", __func__, hcnt, lcnt);
>         } else {
>                 hcnt = i2c_dw_scl_hcnt(i2c_dw_clk_rate(dev),
>                                         600,    /* tHD;STA = tHIGH = 0.6 us */
> @@ -124,10 +128,11 @@ static int i2c_dw_init_master(struct dw_i2c_dev *dev)
>                                         1300,   /* tLOW = 1.3 us */
>                                         scl_falling_time,
>                                         0);     /* No offset */
> +printk("%s fs no hcnt %u lcnt %u\n", __func__, hcnt, lcnt);
>         }
>         dw_writel(dev, hcnt, DW_IC_FS_SCL_HCNT);
>         dw_writel(dev, lcnt, DW_IC_FS_SCL_LCNT);
> -       dev_dbg(dev->dev, "Fast-mode HCNT:LCNT = %d:%d\n", hcnt, lcnt);
> +       dev_err(dev->dev, "Fast-mode HCNT:LCNT = %d:%d\n", hcnt, lcnt);
>
>         if ((dev->master_cfg & DW_IC_CON_SPEED_MASK) ==
>                 DW_IC_CON_SPEED_HIGH) {
> @@ -141,7 +146,7 @@ static int i2c_dw_init_master(struct dw_i2c_dev *dev)
>                         lcnt = dev->hs_lcnt;
>                         dw_writel(dev, hcnt, DW_IC_HS_SCL_HCNT);
>                         dw_writel(dev, lcnt, DW_IC_HS_SCL_LCNT);
> -                       dev_dbg(dev->dev, "HighSpeed-mode HCNT:LCNT = %d:%d\n",
> +                       dev_err(dev->dev, "HighSpeed-mode HCNT:LCNT = %d:%d\n",
>                                 hcnt, lcnt);
>                 }
>         }
> @@ -152,6 +157,7 @@ static int i2c_dw_init_master(struct dw_i2c_dev *dev)
>                 if (!dev->sda_hold_time) {
>                         /* Keep previous hold time setting if no one set it */
>                         dev->sda_hold_time = dw_readl(dev, DW_IC_SDA_HOLD);
> +printk("%s no sda hold time and read from reg %u\n", __func__,
> dev->sda_hold_time);
>                 }
>                 /*
>                  * Workaround for avoiding TX arbitration lost in case I2C
> @@ -163,7 +169,9 @@ static int i2c_dw_init_master(struct dw_i2c_dev *dev)
>                 if (!(dev->sda_hold_time & DW_IC_SDA_HOLD_RX_MASK))
>                         dev->sda_hold_time |= 1 << DW_IC_SDA_HOLD_RX_SHIFT;
>                 dw_writel(dev, dev->sda_hold_time, DW_IC_SDA_HOLD);
> +printk("%s new ver sda hold time %u\n", __func__, dev->sda_hold_time);
>         } else if (dev->sda_hold_time) {
> +printk("%s old sda hold time %u\n", __func__, dev->sda_hold_time);
>                 dev_warn(dev->dev,
>                         "Hardware too old to adjust SDA hold time.\n");
>         }
> diff --git a/drivers/i2c/busses/i2c-designware-pcidrv.c
> b/drivers/i2c/busses/i2c-designware-pcidrv.c
> index 86e1bd0b82e9..55ac4a6d31da 100644
> --- a/drivers/i2c/busses/i2c-designware-pcidrv.c
> +++ b/drivers/i2c/busses/i2c-designware-pcidrv.c
> @@ -277,6 +277,7 @@ static int i2c_dw_pci_probe(struct pci_dev *pdev,
>         dev->tx_fifo_depth = controller->tx_fifo_depth;
>         dev->rx_fifo_depth = controller->rx_fifo_depth;
>
> +printk("%s have scl sda config %s\n", __func__,
> controller->scl_sda_cfg?"true":"false");
>         adap = &dev->adapter;
>         adap->owner = THIS_MODULE;
>         adap->class = 0;
> diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c
> b/drivers/i2c/busses/i2c-designware-platdrv.c
> index 5660daf6c92e..90b443c6b472 100644
> --- a/drivers/i2c/busses/i2c-designware-platdrv.c
> +++ b/drivers/i2c/busses/i2c-designware-platdrv.c
> @@ -115,6 +115,7 @@ static int dw_i2c_acpi_configure(struct
> platform_device *pdev)
>         dw_i2c_acpi_params(pdev, "HSCN", &dev->hs_hcnt, &dev->hs_lcnt, &hs_ht);
>         dw_i2c_acpi_params(pdev, "FMCN", &dev->fs_hcnt, &dev->fs_lcnt, &fs_ht);
>
> +printk("%s: freq %u and ss_ht %u fp_ht %u hs_ht %u fs_ht %u\n",
> __func__, dev->clk_freq, ss_ht, fp_ht, hs_ht, fs_ht);
>         switch (dev->clk_freq) {
>         case 100000:
>                 dev->sda_hold_time = ss_ht;
> @@ -310,6 +311,7 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
>         if (has_acpi_companion(&pdev->dev))
>                 dw_i2c_acpi_configure(pdev);
>
> +printk("%s clk freq %u\n", __func__, dev->clk_freq);
>         /*
>          * Only standard mode at 100kHz, fast mode at 400kHz,
>          * fast mode plus at 1MHz and high speed mode at 3.4MHz are supported.
> @@ -333,6 +335,9 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
>                 i2c_dw_configure_master(dev);
>
>         dev->clk = devm_clk_get(&pdev->dev, NULL);
> +printk("%s parent clk freq %u\n", __func__, clk_get_rate(dev->clk));
> +if (dev->sda_hold_time)
> +       printk("sda hold time %u\n", dev->sda_hold_time);
>         if (!i2c_dw_prepare_clk(dev, true)) {
>                 dev->get_clk_rate_khz = i2c_dw_get_clk_rate_khz;
>
> Rebuild kernel, reboot and check dmesg again:
> (the touchpad still not work)
>
> [    5.004195] acpi PNP0C14:03: duplicate WMI GUID
> 05901221-D566-11D1-B2F0-00A0C9062910 (first instance was on
> PNP0C14:02)
> [    5.004250] acpi PNP0C14:04: duplicate WMI GUID
> 05901221-D566-11D1-B2F0-00A0C9062910 (first instance was on
> PNP0C14:02)
> [    5.022086] intel-lpss 0000:00:15.0: enabling device (0000 -> 0002)
> [    5.056084] idma64 idma64.0: Found Intel integrated DMA 64-bit
> [    5.057994] dw_i2c_acpi_configure: freq 400000 and ss_ht 0 fp_ht 0
> hs_ht 0 fs_ht 0
> [    5.057995] dw_i2c_plat_probe clk freq 400000
> [    5.058001] dw_i2c_plat_probe parent clk freq 120000000
> [    5.058025] i2c_dw_init_master sda falling 300 scl falling 300
> [    5.058026] i2c_dw_init_master ss no hcnt 513 lcnt 599
> [    5.058028] i2c_designware i2c_designware.0: Standard-mode
> HCNT:LCNT = 513:599
> [    5.058028] i2c_dw_init_master fs no hcnt 105 lcnt 191
> [    5.058029] i2c_designware i2c_designware.0: Fast-mode HCNT:LCNT = 105:191
> [    5.058033] i2c_dw_init_master new ver sda hold time 28
> [    5.060998] Adding 7776500k swap on /dev/zram0.  Priority:-2
> extents:1 across:7776500k SSFS
> [    5.091397] cfg80211: Loading compiled-in X.509 certificates for
> regulatory database
> [    5.094840] cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
> [    5.097905] RAPL PMU: API unit is 2^-32 Joules, 5 fixed counters,
> 655360 ms ovfl timer
> [    5.097907] RAPL PMU: hw unit of domain pp0-core 2^-14 Joules
> [    5.097907] RAPL PMU: hw unit of domain package 2^-14 Joules
> [    5.097908] RAPL PMU: hw unit of domain dram 2^-14 Joules
> [    5.097908] RAPL PMU: hw unit of domain pp1-gpu 2^-14 Joules
> [    5.097909] RAPL PMU: hw unit of domain psys 2^-14 Joules
> [    5.098206] intel-lpss 0000:00:15.1: enabling device (0000 -> 0002)
> [    5.098570] idma64 idma64.1: Found Intel integrated DMA 64-bit
> [    5.098676] media: Linux media interface: v0.10
> [    5.100423] dw_i2c_acpi_configure: freq 400000 and ss_ht 0 fp_ht 0
> hs_ht 0 fs_ht 0
> [    5.100424] dw_i2c_plat_probe clk freq 400000
> [    5.100427] dw_i2c_plat_probe parent clk freq 120000000
> [    5.100435] i2c_dw_init_master sda falling 300 scl falling 300
> [    5.100436] i2c_dw_init_master ss no hcnt 513 lcnt 599
> [    5.100437] i2c_designware i2c_designware.1: Standard-mode
> HCNT:LCNT = 513:599
> [    5.100438] i2c_dw_init_master fs no hcnt 105 lcnt 191
> [    5.100439] i2c_designware i2c_designware.1: Fast-mode HCNT:LCNT = 105:191
> [    5.100443] i2c_dw_init_master new ver sda hold time 28
> [    5.102504] platform regulatory.0: Direct firmware load for
> regulatory.db failed with error -2
> [    5.102508] cfg80211: failed to load regulatory.db
>
> According to the information "dw_i2c_plat_probe clk freq 400000" in the
> dmesg, the system has the right SCL clock with 400K Hz.  But why it is
> apparently not taking effect?
>
> Thnaks,
> Jian-Hong Pan

Some update, we can make the touchpad work by simply modifying the
clk_rate of spt_i2c_info from 120000000 to 133000000 in intel-lpss-pci.c for
specific PCI ID 8086:a368 ~ a36a (CoffeeLake). Is the clock setting different
for the CoffeeLake series?
