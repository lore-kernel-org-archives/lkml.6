Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751701AbeFEKs4 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 06:48:56 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:59402 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751498AbeFEKsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 06:48:54 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6AC45601A8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sayalil@codeaurora.org
From: "sayali" <sayalil@codeaurora.org>
To: "'Kyuho Choi'" <chlrbgh0@gmail.com>
Cc: <subhashj@codeaurora.org>, <cang@codeaurora.org>,
        <vivek.gautam@codeaurora.org>, <rnayak@codeaurora.org>,
        <vinholikatti@gmail.com>, <jejb@linux.vnet.ibm.com>,
        <martin.petersen@oracle.com>, <asutoshd@codeaurora.org>,
        <evgreen@chromium.org>, <linux-scsi@vger.kernel.org>,
        "'open list'" <linux-kernel@vger.kernel.org>
References: <1527849774-7623-1-git-send-email-sayalil@codeaurora.org> <1527849774-7623-2-git-send-email-sayalil@codeaurora.org> <CAP2JTQJAyPAJ-uJM3REb02fBLUKkhf28OacEnzNHGidWfu3+YA@mail.gmail.com>
In-Reply-To: <CAP2JTQJAyPAJ-uJM3REb02fBLUKkhf28OacEnzNHGidWfu3+YA@mail.gmail.com>
Subject: RE: [PATCH V1 1/3] scsi: ufs: set the device reference clock setting
Date: Tue, 5 Jun 2018 16:18:46 +0530
Message-ID: <000801d3fcba$cafa3c30$60eeb490$@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKGja9h2+sAa9B7VDYjBpPLWNjYigKV7YTZAlkPtOiixOBpYA==
Content-Language: en-us
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w55An10A004041


-----Original Message-----
From: Kyuho Choi [mailto:chlrbgh0@gmail.com] 
Sent: Saturday, June 02, 2018 11:04 AM
To: Sayali Lokhande <sayalil@codeaurora.org>
Cc: subhashj@codeaurora.org; cang@codeaurora.org; vivek.gautam@codeaurora.org; rnayak@codeaurora.org; vinholikatti@gmail.com; jejb@linux.vnet.ibm.com; martin.petersen@oracle.com; asutoshd@codeaurora.org; evgreen@chromium.org; linux-scsi@vger.kernel.org; open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V1 1/3] scsi: ufs: set the device reference clock setting

Hi Sayali,

On 6/1/18, Sayali Lokhande <sayalil@codeaurora.org> wrote:
> From: Subhash Jadavani <subhashj@codeaurora.org>
>
> UFS host supplies the reference clock to UFS device and UFS device 
> specification allows host to provide one of the 4 frequencies (19.2 
> MHz,
> 26 MHz, 38.4 MHz, 52 MHz) for reference clock. Host should set the 
> device reference clock frequency setting in the device based on what 
> frequency it is supplying to UFS device.
>
> Signed-off-by: Subhash Jadavani <subhashj@codeaurora.org>
> [cang@codeaurora.org: Resolved trivial merge conflicts]
> Signed-off-by: Can Guo <cang@codeaurora.org>
> Signed-off-by: Sayali Lokhande <sayalil@codeaurora.org>
> ---
>  drivers/scsi/ufs/ufs.h    |  9 +++++++
>  drivers/scsi/ufs/ufshcd.c | 62
> +++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/scsi/ufs/ufshcd.h |  1 +
>  3 files changed, 72 insertions(+)
>
> diff --git a/drivers/scsi/ufs/ufs.h b/drivers/scsi/ufs/ufs.h index 
> 14e5bf7..e15deb0 100644
> --- a/drivers/scsi/ufs/ufs.h
> +++ b/drivers/scsi/ufs/ufs.h
> @@ -378,6 +378,15 @@ enum query_opcode {
>  	UPIU_QUERY_OPCODE_TOGGLE_FLAG	= 0x8,
>  };
>
> +/* bRefClkFreq attribute values */
> +enum ref_clk_freq {
> +	REF_CLK_FREQ_19_2_MHZ	= 0x0,
> +	REF_CLK_FREQ_26_MHZ	= 0x1,
> +	REF_CLK_FREQ_38_4_MHZ	= 0x2,
> +	REF_CLK_FREQ_52_MHZ	= 0x3,
> +	REF_CLK_FREQ_MAX	= REF_CLK_FREQ_52_MHZ,
> +};
> +
>  /* Query response result code */
>  enum {
>  	QUERY_RESULT_SUCCESS                    = 0x00,
> diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c 
> index c5b1bf1..3669bc4 100644
> --- a/drivers/scsi/ufs/ufshcd.c
> +++ b/drivers/scsi/ufs/ufshcd.c
> @@ -6297,6 +6297,63 @@ static void ufshcd_def_desc_sizes(struct 
> ufs_hba
> *hba)
>  }
>
>  /**
> + * ufshcd_set_dev_ref_clk - set the device bRefClkFreq
> + * @hba: per-adapter instance
> + * @ref_clk_freq: refrerence clock frequency to be set
> + *
> + * Read the current value of the bRefClkFreq attribute from device 
> + and
> update it
> + * if host is supplying different reference clock frequency than one
> mentioned
> + * in bRefClkFreq attribute.
> + *
> + * Returns zero on success, non-zero error value on failure.
> + */
> +static int ufshcd_set_dev_ref_clk(struct ufs_hba *hba, u32 
> +ref_clk_freq) {
> +	int err = 0;
> +	int ref_clk = -1;
> +	static const char * const ref_clk_freqs[] = {"19.2 MHz", "26 MHz",
> +						     "38.4 MHz", "52 MHz"};
> +
> +	hba->dev_ref_clk_freq = ref_clk_freq;
> +	err = ufshcd_query_attr_retry(hba, UPIU_QUERY_OPCODE_READ_ATTR,
> +			QUERY_ATTR_IDN_REF_CLK_FREQ, 0, 0, &ref_clk);
> +
> +	if (err) {
> +		dev_err(hba->dev, "%s: failed reading bRefClkFreq. err = %d\n",
> +			 __func__, err);
> +		goto out;
> +	}
> +
> +	if ((ref_clk < 0) || (ref_clk > REF_CLK_FREQ_52_MHZ)) {
> +		dev_err(hba->dev, "%s: invalid ref_clk setting = %d\n",
> +			 __func__, ref_clk);
> +		err = -EINVAL;
> +		goto out;
> +	}
> +
> +	if (ref_clk == hba->dev_ref_clk_freq)
> +		goto out; /* nothing to update */
> +
> +	err = ufshcd_query_attr_retry(hba, UPIU_QUERY_OPCODE_WRITE_ATTR,
> +			QUERY_ATTR_IDN_REF_CLK_FREQ, 0, 0,
> +			&hba->dev_ref_clk_freq);
> +
> +	if (err)
> +		dev_err(hba->dev, "%s: bRefClkFreq setting to %s failed\n",
> +			__func__, ref_clk_freqs[hba->dev_ref_clk_freq]);
> +	else
> +		/*
> +		 * It is good to print this out here to debug any later failures
> +		 * related to gear switch.
> +		 */
> +		dev_info(hba->dev, "%s: bRefClkFreq setting to %s succeeded\n",
> +			__func__, ref_clk_freqs[hba->dev_ref_clk_freq]);
> +
> +out:
> +	return err;
> +}
> +
> +/**
>   * ufshcd_probe_hba - probe hba to detect device and initialize
>   * @hba: per-adapter instance
>   *
> @@ -6361,6 +6418,11 @@ static int ufshcd_probe_hba(struct ufs_hba *hba)
>  			"%s: Failed getting max supported power mode\n",
>  			__func__);
>  	} else {
> +		/*
> +		 * Set the right value to bRefClkFreq before attempting to
> +		 * switch to HS gears.
> +		 */
> +		ufshcd_set_dev_ref_clk(hba, REF_CLK_FREQ_19_2_MHZ);

How it works in 26MHz refclk support host like exynos series?. As I understood, there default refclk value are 26MHz for host and device.
In that case, your code maybe set device's refclk to 19.2MHz. It would be need to set same refclk value both host and device for switch to HS.
[Sayali] : As per HPG, we set ref_clk to 19.2 Mhz (for host and device). But as it can vary for others (like exynos as you pointed), I think its better to parse ref_clk frequency from device tree instead of passing hardcoded value. DT approach was present in my previous patchset, I will update/add it again in my next patch set.

>  		ret = ufshcd_config_pwr_mode(hba, &hba->max_pwr_info.info);
>  		if (ret) {
>  			dev_err(hba->dev, "%s: Failed setting power mode, err = %d\n", 
> diff --git a/drivers/scsi/ufs/ufshcd.h b/drivers/scsi/ufs/ufshcd.h 
> index 8110dcd..b026ad8 100644
> --- a/drivers/scsi/ufs/ufshcd.h
> +++ b/drivers/scsi/ufs/ufshcd.h
> @@ -548,6 +548,7 @@ struct ufs_hba {
>  	void *priv;
>  	unsigned int irq;
>  	bool is_irq_enabled;
> +	u32 dev_ref_clk_freq;
>
>  	/* Interrupt aggregation support is broken */
>  	#define UFSHCD_QUIRK_BROKEN_INTR_AGGR			0x1
> --
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
> Forum, a Linux Foundation Collaborative Project
>
>

BR,
Kyuho Choi
