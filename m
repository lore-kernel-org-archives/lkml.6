Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F91AC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 16:34:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EC182083B
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 16:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550766856;
	bh=3Fhq3Z4R0m29lUnd5arplGy3KKkrx2XU4n9beCaX0Vk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NH4O+9t9KNmbJsbsQ6eGQjHQSa4u2sULmbif9+f2KNlKsT4MnSlaNVac+kYSpNra9
	 kVFFhzqRngLnNeY1p2h+4wHiAuZXgWqKf5ipbGLdu2Nyxsev93e+kD6MXvYHLUCzRw
	 HN5/+keKMhUMyiSq9aVCd8GLGvLhFHZBWyG8ojgw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbfBUQeP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 11:34:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:47432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725932AbfBUQeO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 11:34:14 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CFEC52084D;
        Thu, 21 Feb 2019 16:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550766853;
        bh=3Fhq3Z4R0m29lUnd5arplGy3KKkrx2XU4n9beCaX0Vk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JWIO7ww3cTkIOLw47iLMZxyMozHAU75Ginl/lKGkFEFft1wxf49LjFVULGsjyc3LB
         sRzKnQUQo3uGGuoL+Eq/zfMmWvos0pz0hpyw6LpZdDxFzebEiDDFNV34HmKmndC47t
         AekM1wwjCPecopPfpVLJi5Qa0ay6CbvIk9FoG1V0=
Date:   Thu, 21 Feb 2019 17:34:10 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Vaishali Thakkar <vaishali.thakkar@linaro.org>
Cc:     andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, bjorn.andersson@linaro.org, vkoul@kernel.org
Subject: Re: [PATCH v3 5/5] soc: qcom: socinfo: Expose image information
Message-ID: <20190221163410.GE8727@kroah.com>
References: <20190221162419.32384-1-vaishali.thakkar@linaro.org>
 <20190221162419.32384-6-vaishali.thakkar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190221162419.32384-6-vaishali.thakkar@linaro.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 09:54:19PM +0530, Vaishali Thakkar wrote:
>  static void socinfo_debugfs_init(struct qcom_socinfo *qcom_socinfo)
>  {
> +	struct smem_image_version *smem_image_version;
> +	size_t size;
> +
>  	qcom_socinfo->dbg_root = debugfs_create_dir("qcom_socinfo", NULL);
>  
>  	DEBUGFS_UINT_ADD(raw_version);
> @@ -314,6 +432,98 @@ static void socinfo_debugfs_init(struct qcom_socinfo *qcom_socinfo)
>  	DEBUGFS_ADD(pmic_model);
>  	DEBUGFS_ADD(platform_subtype);
>  	DEBUGFS_ADD(pmic_die_revision);
> +
> +	smem_image_version = qcom_smem_get(QCOM_SMEM_HOST_ANY,
> +					   SMEM_IMAGE_VERSION_TABLE,
> +					   &size);
> +
> +	qcom_socinfo->boot = debugfs_create_dir("boot",
> +						qcom_socinfo->dbg_root);
> +	if (!qcom_socinfo->boot) {
> +		pr_err("Cannot create boot image directory\n");
> +		return;
> +	}

You do not care, do not check please.  Also, even if you wanted to
check, your error checking was wrong :)

> +	DEBUGFS_IMAGE_NAME(name, boot, SMEM_IMAGE_TABLE_BOOT_INDEX);
> +	DEBUGFS_IMAGE_VARIANT(variant, boot, SMEM_IMAGE_TABLE_BOOT_INDEX);
> +	DEBUGFS_IMAGE_OEM(oem, boot, SMEM_IMAGE_TABLE_BOOT_INDEX);
> +
> +	qcom_socinfo->tz = debugfs_create_dir("tz",
> +					      qcom_socinfo->dbg_root);
> +	if (!qcom_socinfo->tz) {
> +		pr_err("Cannot create tz image directory\n");
> +		return;
> +	}

Same here, no error checking please.

> +	DEBUGFS_IMAGE_NAME(name, tz, SMEM_IMAGE_TABLE_TZ_INDEX);
> +	DEBUGFS_IMAGE_VARIANT(variant, tz, SMEM_IMAGE_TABLE_TZ_INDEX);
> +	DEBUGFS_IMAGE_OEM(oem, tz, SMEM_IMAGE_TABLE_TZ_INDEX);
> +
> +	qcom_socinfo->rpm = debugfs_create_dir("rpm",
> +					       qcom_socinfo->dbg_root);
> +	if (!qcom_socinfo->rpm) {
> +		pr_err("Cannot create rpm image directory\n");
> +		return;
> +	}

And here.

> +	DEBUGFS_IMAGE_NAME(name, rpm, SMEM_IMAGE_TABLE_RPM_INDEX);
> +	DEBUGFS_IMAGE_VARIANT(variant, rpm, SMEM_IMAGE_TABLE_RPM_INDEX);
> +	DEBUGFS_IMAGE_OEM(oem, rpm, SMEM_IMAGE_TABLE_RPM_INDEX);
> +
> +	qcom_socinfo->apps = debugfs_create_dir("apps",
> +						qcom_socinfo->dbg_root);
> +	if (!qcom_socinfo->apps) {
> +		pr_err("Cannot create apps image directory\n");
> +		return;
> +	}

And here.

> +	DEBUGFS_IMAGE_NAME(name, apps, SMEM_IMAGE_TABLE_APPS_INDEX);
> +	DEBUGFS_IMAGE_VARIANT(variant, apps, SMEM_IMAGE_TABLE_APPS_INDEX);
> +	DEBUGFS_IMAGE_OEM(oem, apps, SMEM_IMAGE_TABLE_APPS_INDEX);
> +
> +	qcom_socinfo->mpss = debugfs_create_dir("mpss",
> +						qcom_socinfo->dbg_root);
> +	if (!qcom_socinfo->mpss) {
> +		pr_err("Cannot create mpss image directory\n");
> +		return;
> +	}

Yet again...

> +
> +	DEBUGFS_IMAGE_NAME(name, mpss, SMEM_IMAGE_TABLE_MPSS_INDEX);
> +	DEBUGFS_IMAGE_VARIANT(variant, mpss, SMEM_IMAGE_TABLE_MPSS_INDEX);
> +	DEBUGFS_IMAGE_OEM(oem, mpss, SMEM_IMAGE_TABLE_MPSS_INDEX);
> +
> +	qcom_socinfo->adsp = debugfs_create_dir("adsp",
> +						qcom_socinfo->dbg_root);
> +	if (!qcom_socinfo->adsp) {
> +		pr_err("Cannot create adsp image directory\n");
> +		return;
> +	}

And again...

> +
> +	DEBUGFS_IMAGE_NAME(name, adsp, SMEM_IMAGE_TABLE_ADSP_INDEX);
> +	DEBUGFS_IMAGE_VARIANT(variant, adsp, SMEM_IMAGE_TABLE_ADSP_INDEX);
> +	DEBUGFS_IMAGE_OEM(oem, adsp, SMEM_IMAGE_TABLE_ADSP_INDEX);
> +
> +	qcom_socinfo->cnss = debugfs_create_dir("cnss",
> +						qcom_socinfo->dbg_root);
> +	if (!qcom_socinfo->cnss) {
> +		pr_err("Cannot create cnss image directory\n");
> +		return;
> +	}

And again...

> +
> +	DEBUGFS_IMAGE_NAME(name, cnss, SMEM_IMAGE_TABLE_CNSS_INDEX);
> +	DEBUGFS_IMAGE_VARIANT(variant, cnss, SMEM_IMAGE_TABLE_CNSS_INDEX);
> +	DEBUGFS_IMAGE_OEM(oem, cnss, SMEM_IMAGE_TABLE_CNSS_INDEX);
> +
> +	qcom_socinfo->video = debugfs_create_dir("video",
> +						 qcom_socinfo->dbg_root);
> +	if (!qcom_socinfo->video) {
> +		pr_err("Cannot create video image directory\n");
> +		return;
> +	}

And one last time.

There, you get to delete a bunch of code, that's always fun :)

thanks,

greg k-h
