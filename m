Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86BFEC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 12:18:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A5D220880
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 12:18:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="Auys7/qu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727878AbfBUMSw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 07:18:52 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:33516 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbfBUMSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 07:18:49 -0500
Received: from pendragon.ideasonboard.com (dfj612yhrgyx302h3jwwy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:ce28:277f:58d7:3ca4])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 3CF8D255;
        Thu, 21 Feb 2019 13:18:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1550751526;
        bh=CsV7lB2dzlmOknM6m5cWOORBhapq4+3DdUyNMWJVWPY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Auys7/quCmftGzZphqkw0amGUwM/xVzxLB6HUS0FA91TWUi+9olUmSMtnGZhzTaCp
         9fTtD05FW9WAJu9i0ZVOrWs0Sk+J6l3zqjqHTbi+lXe/fgrxKSMh+u3iwIsv4VFul9
         jQCnNRxF7CX+ssJIg79jB1Wll/sAduYEERtEk0/c=
Date:   Thu, 21 Feb 2019 14:18:41 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Vaishali Thakkar <vaishali.thakkar@linaro.org>
Cc:     andy.gross@linaro.org, david.brown@linaro.org,
        gregkh@linuxfoundation.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, rafael@kernel.org,
        bjorn.andersson@linaro.org, vkoul@kernel.org
Subject: Re: [PATCH v2 3/5] soc: qcom: socinfo: Expose custom attributes
Message-ID: <20190221121841.GA32108@pendragon.ideasonboard.com>
References: <20190220045829.6852-1-vaishali.thakkar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190220045829.6852-1-vaishali.thakkar@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vaishali,

Thank you for the patch.

On Wed, Feb 20, 2019 at 10:28:29AM +0530, Vaishali Thakkar wrote:
> The Qualcomm socinfo provides a number of additional attributes,
> add these to the socinfo driver and expose them via debugfs
> functionality.

What is the use case for these attributes ? I fear they will be used in
production systems, and that would require debugfs in production, which
isn't a good idea. If you need to expose those attributes for anything
else than debugging then we need a proper API, likely sysfs-based.

> Signed-off-by: Vaishali Thakkar <vaishali.thakkar@linaro.org>
> ---
> Changes since v1:
> 	- Remove unnecessary debugfs dir creation check
> 	- Align ifdefs to left
> 	- Fix function signatures for debugfs init/exit
> ---
>  drivers/soc/qcom/socinfo.c | 198 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 198 insertions(+)
> 
> diff --git a/drivers/soc/qcom/socinfo.c b/drivers/soc/qcom/socinfo.c
> index 02078049fac7..5f4bef216ae1 100644
> --- a/drivers/soc/qcom/socinfo.c
> +++ b/drivers/soc/qcom/socinfo.c
> @@ -4,6 +4,7 @@
>   * Copyright (c) 2017-2019, Linaro Ltd.
>   */
>  
> +#include <linux/debugfs.h>
>  #include <linux/err.h>
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
> @@ -29,6 +30,28 @@
>   */
>  #define SMEM_HW_SW_BUILD_ID            137
>  
> +#ifdef CONFIG_DEBUG_FS
> +/* pmic model info */
> +static const char *const pmic_model[] = {
> +	[0]  = "Unknown PMIC model",
> +	[9]  = "PM8994",
> +	[11] = "PM8916",
> +	[13] = "PM8058",
> +	[14] = "PM8028",
> +	[15] = "PM8901",
> +	[16] = "PM8027",
> +	[17] = "ISL9519",
> +	[18] = "PM8921",
> +	[19] = "PM8018",
> +	[20] = "PM8015",
> +	[21] = "PM8014",
> +	[22] = "PM8821",
> +	[23] = "PM8038",
> +	[24] = "PM8922",
> +	[25] = "PM8917",
> +};
> +#endif /* CONFIG_DEBUG_FS */
> +
>  /* Socinfo SMEM item structure */
>  struct socinfo {
>  	__le32 fmt;
> @@ -70,6 +93,10 @@ struct socinfo {
>  struct qcom_socinfo {
>  	struct soc_device *soc_dev;
>  	struct soc_device_attribute attr;
> +#ifdef CONFIG_DEBUG_FS
> +	struct dentry *dbg_root;
> +#endif /* CONFIG_DEBUG_FS */
> +	struct socinfo *socinfo;
>  };
>  
>  struct soc_of_id {
> @@ -133,6 +160,171 @@ static const char *socinfo_machine(struct device *dev, unsigned int id)
>  	return NULL;
>  }
>  
> +#ifdef CONFIG_DEBUG_FS
> +
> +#define UINT_SHOW(name, attr)						\
> +static int qcom_show_##name(struct seq_file *seq, void *p)		\
> +{									\
> +	struct socinfo *socinfo = seq->private;				\
> +	seq_printf(seq, "%u\n", le32_to_cpu(socinfo->attr));		\
> +	return 0;							\
> +}									\
> +static int qcom_open_##name(struct inode *inode, struct file *file)	\
> +{									\
> +	return single_open(file, qcom_show_##name, inode->i_private);	\
> +}									\
> +									\
> +static const struct file_operations qcom_ ##name## _ops = {		\
> +	.open = qcom_open_##name,					\
> +	.read = seq_read,						\
> +	.llseek = seq_lseek,						\
> +	.release = single_release,					\
> +}
> +
> +#define DEBUGFS_UINT_ADD(name)						\
> +	debugfs_create_file(__stringify(name), 0400,			\
> +			    qcom_socinfo->dbg_root,			\
> +			    qcom_socinfo->socinfo, &qcom_ ##name## _ops)
> +
> +#define HEX_SHOW(name, attr)						\
> +static int qcom_show_##name(struct seq_file *seq, void *p)		\
> +{									\
> +	struct socinfo *socinfo = seq->private;				\
> +	seq_printf(seq, "0x%x\n", le32_to_cpu(socinfo->attr));		\
> +	return 0;							\
> +}									\
> +static int qcom_open_##name(struct inode *inode, struct file *file)	\
> +{									\
> +	return single_open(file, qcom_show_##name, inode->i_private);	\
> +}									\
> +									\
> +static const struct file_operations qcom_ ##name## _ops = {		\
> +	.open = qcom_open_##name,					\
> +	.read = seq_read,						\
> +	.llseek = seq_lseek,						\
> +	.release = single_release,					\
> +}
> +
> +#define DEBUGFS_HEX_ADD(name)						\
> +	debugfs_create_file(__stringify(name), 0400,			\
> +			    qcom_socinfo->dbg_root,			\
> +			    qcom_socinfo->socinfo, &qcom_ ##name## _ops)
> +
> +
> +#define QCOM_OPEN(name, _func)						\
> +static int qcom_open_##name(struct inode *inode, struct file *file)	\
> +{									\
> +	return single_open(file, _func, inode->i_private);		\
> +}									\
> +									\
> +static const struct file_operations qcom_ ##name## _ops = {		\
> +	.open = qcom_open_##name,					\
> +	.read = seq_read,						\
> +	.llseek = seq_lseek,						\
> +	.release = single_release,					\
> +}
> +
> +#define DEBUGFS_ADD(name)						\
> +	debugfs_create_file(__stringify(name), 0400,			\
> +			    qcom_socinfo->dbg_root,			\
> +			    qcom_socinfo->socinfo, &qcom_ ##name## _ops)
> +
> +
> +static int qcom_show_build_id(struct seq_file *seq, void *p)
> +{
> +	struct socinfo *socinfo = seq->private;
> +
> +	seq_printf(seq, "%s\n", socinfo->build_id);
> +
> +	return 0;
> +}
> +
> +static int qcom_show_accessory_chip(struct seq_file *seq, void *p)
> +{
> +	struct socinfo *socinfo = seq->private;
> +
> +	seq_printf(seq, "%d\n", le32_to_cpu(socinfo->accessory_chip));
> +
> +	return 0;
> +}
> +
> +static int qcom_show_platform_subtype(struct seq_file *seq, void *p)
> +{
> +	struct socinfo *socinfo = seq->private;
> +	int subtype = le32_to_cpu(socinfo->hw_plat_subtype);
> +
> +	if (subtype < 0)
> +		return -EINVAL;
> +
> +	seq_printf(seq, "%u\n", subtype);
> +
> +	return 0;
> +}
> +
> +static int qcom_show_pmic_model(struct seq_file *seq, void *p)
> +{
> +	struct socinfo *socinfo = seq->private;
> +	int model = SOCINFO_MINOR(le32_to_cpu(socinfo->pmic_model));
> +
> +	if (model < 0)
> +		return -EINVAL;
> +
> +	seq_printf(seq, "%s\n", pmic_model[model]);
> +
> +	return 0;
> +}
> +
> +static int qcom_show_pmic_die_revision(struct seq_file *seq, void *p)
> +{
> +	struct socinfo *socinfo = seq->private;
> +
> +	seq_printf(seq, "%u.%u\n",
> +		   SOCINFO_MAJOR(le32_to_cpu(socinfo->pmic_die_rev)),
> +		   SOCINFO_MINOR(le32_to_cpu(socinfo->pmic_die_rev)));
> +
> +	return 0;
> +}
> +
> +UINT_SHOW(raw_version, raw_ver);
> +UINT_SHOW(hardware_platform, hw_plat);
> +UINT_SHOW(platform_version, plat_ver);
> +UINT_SHOW(foundry_id, foundry_id);
> +HEX_SHOW(chip_family, chip_family);
> +HEX_SHOW(raw_device_family, raw_device_family);
> +HEX_SHOW(raw_device_number, raw_device_num);
> +QCOM_OPEN(build_id, qcom_show_build_id);
> +QCOM_OPEN(accessory_chip, qcom_show_accessory_chip);
> +QCOM_OPEN(pmic_model, qcom_show_pmic_model);
> +QCOM_OPEN(platform_subtype, qcom_show_platform_subtype);
> +QCOM_OPEN(pmic_die_revision, qcom_show_pmic_die_revision);
> +
> +static void socinfo_debugfs_init(struct qcom_socinfo *qcom_socinfo)
> +{
> +	qcom_socinfo->dbg_root = debugfs_create_dir("qcom_socinfo", NULL);
> +
> +	DEBUGFS_UINT_ADD(raw_version);
> +	DEBUGFS_UINT_ADD(hardware_platform);
> +	DEBUGFS_UINT_ADD(platform_version);
> +	DEBUGFS_UINT_ADD(foundry_id);
> +	DEBUGFS_HEX_ADD(chip_family);
> +	DEBUGFS_HEX_ADD(raw_device_family);
> +	DEBUGFS_HEX_ADD(raw_device_number);
> +	DEBUGFS_ADD(build_id);
> +	DEBUGFS_ADD(accessory_chip);
> +	DEBUGFS_ADD(pmic_model);
> +	DEBUGFS_ADD(platform_subtype);
> +	DEBUGFS_ADD(pmic_die_revision);
> +}
> +
> +static void socinfo_debugfs_exit(struct qcom_socinfo *qcom_socinfo)
> +{
> +	debugfs_remove_recursive(qcom_socinfo->dbg_root);
> +}
> +#else
> +static void socinfo_debugfs_init(struct qcom_socinfo *qcom_socinfo) { return 0; }
> +static void socinfo_debugfs_exit(struct qcom_socinfo *qcom_socinfo) {  }
> +#endif /* CONFIG_DEBUG_FS */
> +
>  static int qcom_socinfo_probe(struct platform_device *pdev)
>  {
>  	struct qcom_socinfo *qs;
> @@ -165,6 +357,10 @@ static int qcom_socinfo_probe(struct platform_device *pdev)
>  	if (IS_ERR(qs->soc_dev))
>  		return PTR_ERR(qs->soc_dev);
>  
> +	qs->socinfo = info;
> +
> +	socinfo_debugfs_init(qs);
> +
>  	/* Feed the soc specific unique data into entropy pool */
>  	add_device_randomness(info, item_size);
>  
> @@ -179,6 +375,8 @@ static int qcom_socinfo_remove(struct platform_device *pdev)
>  
>  	soc_device_unregister(qs->soc_dev);
>  
> +	socinfo_debugfs_exit(qs);
> +
>  	return 0;
>  }
> 

-- 
Regards,

Laurent Pinchart
