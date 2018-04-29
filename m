Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753685AbeD2O7s (ORCPT <rfc822;w@1wt.eu>);
        Sun, 29 Apr 2018 10:59:48 -0400
Received: from bh-25.webhostbox.net ([208.91.199.152]:48083 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753393AbeD2O7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Apr 2018 10:59:46 -0400
Date: Sun, 29 Apr 2018 07:59:43 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, Brian Woods <brian.woods@amd.com>
Subject: Re: [1/2] hwmon: (k10temp) Fix reading critical temperature register
Message-ID: <20180429145943.GA13646@roeck-us.net>
References: <1524798789-2239-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1524798789-2239-1-git-send-email-linux@roeck-us.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Authenticated_sender: guenter@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: authenticated_id: guenter@roeck-us.net
X-Authenticated-Sender: bh-25.webhostbox.net: guenter@roeck-us.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 26, 2018 at 08:13:08PM -0700, Guenter Roeck wrote:
> The HTC (Hardware Temperature Control) register has moved
> for recent chips.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> Compile tested only.

No idea what I did here. I had the same patch in the standalone driver and
it was reported working ... but this version is missing the code to actually
call the new function from show_temp_crit(). I'll send a v2.

Guenter

> 
>  drivers/hwmon/k10temp.c | 37 +++++++++++++++++++++++++++++--------
>  1 file changed, 29 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
> index d2cc55e21374..b06bb1f90853 100644
> --- a/drivers/hwmon/k10temp.c
> +++ b/drivers/hwmon/k10temp.c
> @@ -63,10 +63,12 @@ static DEFINE_MUTEX(nb_smu_ind_mutex);
>  #define  NB_CAP_HTC			0x00000400
>  
>  /*
> - * For F15h M60h, functionality of REG_REPORTED_TEMPERATURE
> - * has been moved to D0F0xBC_xD820_0CA4 [Reported Temperature
> - * Control]
> + * For F15h M60h and M70h, REG_HARDWARE_THERMAL_CONTROL
> + * and REG_REPORTED_TEMPERATURE have been moved to
> + * D0F0xBC_xD820_0C64 [Hardware Temperature Control]
> + * D0F0xBC_xD820_0CA4 [Reported Temperature Control]
>   */
> +#define F15H_M60H_HARDWARE_TEMP_CTRL_OFFSET	0xd8200c64
>  #define F15H_M60H_REPORTED_TEMP_CTRL_OFFSET	0xd8200ca4
>  
>  /* F17h M01h Access througn SMN */
> @@ -74,6 +76,7 @@ static DEFINE_MUTEX(nb_smu_ind_mutex);
>  
>  struct k10temp_data {
>  	struct pci_dev *pdev;
> +	void (*read_htcreg)(struct pci_dev *pdev, u32 *regval);
>  	void (*read_tempreg)(struct pci_dev *pdev, u32 *regval);
>  	int temp_offset;
>  	u32 temp_adjust_mask;
> @@ -98,6 +101,11 @@ static const struct tctl_offset tctl_offset_table[] = {
>  	{ 0x17, "AMD Ryzen Threadripper 1910", 10000 },
>  };
>  
> +static void read_htcreg_pci(struct pci_dev *pdev, u32 *regval)
> +{
> +	pci_read_config_dword(pdev, REG_HARDWARE_THERMAL_CONTROL, regval);
> +}
> +
>  static void read_tempreg_pci(struct pci_dev *pdev, u32 *regval)
>  {
>  	pci_read_config_dword(pdev, REG_REPORTED_TEMPERATURE, regval);
> @@ -114,6 +122,12 @@ static void amd_nb_index_read(struct pci_dev *pdev, unsigned int devfn,
>  	mutex_unlock(&nb_smu_ind_mutex);
>  }
>  
> +static void read_htcreg_nb_f15(struct pci_dev *pdev, u32 *regval)
> +{
> +	amd_nb_index_read(pdev, PCI_DEVFN(0, 0), 0xb8,
> +			  F15H_M60H_HARDWARE_TEMP_CTRL_OFFSET, regval);
> +}
> +
>  static void read_tempreg_nb_f15(struct pci_dev *pdev, u32 *regval)
>  {
>  	amd_nb_index_read(pdev, PCI_DEVFN(0, 0), 0xb8,
> @@ -181,13 +195,18 @@ static umode_t k10temp_is_visible(struct kobject *kobj,
>  	struct pci_dev *pdev = data->pdev;
>  
>  	if (index >= 2) {
> -		u32 reg_caps, reg_htc;
> +		u32 reg;
> +
> +		if (!data->read_htcreg)
> +			return 0;
>  
>  		pci_read_config_dword(pdev, REG_NORTHBRIDGE_CAPABILITIES,
> -				      &reg_caps);
> -		pci_read_config_dword(pdev, REG_HARDWARE_THERMAL_CONTROL,
> -				      &reg_htc);
> -		if (!(reg_caps & NB_CAP_HTC) || !(reg_htc & HTC_ENABLE))
> +				      &reg);
> +		if (!(reg & NB_CAP_HTC))
> +			return 0;
> +
> +		data->read_htcreg(data->pdev, &reg);
> +		if (!(reg & HTC_ENABLE))
>  			return 0;
>  	}
>  	return attr->mode;
> @@ -268,11 +287,13 @@ static int k10temp_probe(struct pci_dev *pdev,
>  
>  	if (boot_cpu_data.x86 == 0x15 && (boot_cpu_data.x86_model == 0x60 ||
>  					  boot_cpu_data.x86_model == 0x70)) {
> +		data->read_htcreg = read_htcreg_nb_f15;
>  		data->read_tempreg = read_tempreg_nb_f15;
>  	} else if (boot_cpu_data.x86 == 0x17) {
>  		data->temp_adjust_mask = 0x80000;
>  		data->read_tempreg = read_tempreg_nb_f17;
>  	} else {
> +		data->read_htcreg = read_htcreg_pci;
>  		data->read_tempreg = read_tempreg_pci;
>  	}
>  
