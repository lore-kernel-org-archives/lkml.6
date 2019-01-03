Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40AD3C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 23:10:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA2D921871
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 23:10:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YNK291+R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbfACXKf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 18:10:35 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34223 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726549AbfACXKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 18:10:34 -0500
Received: by mail-pg1-f195.google.com with SMTP id j10so16630172pga.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jan 2019 15:10:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bgPlSEX1NNlfds0XlPeP6KfkO5xHPBhjSe4RYyLZb2k=;
        b=YNK291+Rb3VtbdQC5ujxx6Z6dPBtlJYgod0Kgn7D6/f3dKMYlZ14aEZg6ZeeO8ugy4
         bY/FIpEdvtzX4yDPssElSogdgM1+wQZTK+9T/33Np6QjJ9IbPJZ9glpdyW8yfg1JKYmC
         IO263aDrkiZ0zr5zh6exyJnhHALeBI8kVrE+M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bgPlSEX1NNlfds0XlPeP6KfkO5xHPBhjSe4RYyLZb2k=;
        b=nrj+e2ejN8zeci+KO+ZVTDDFHa6isYil1sIoSwtBdupi7A5qVEAaZdDWKbuoknmzHA
         3+oRYT72rNM6yAZQ2SZWRGBzDN88o1YPHT8keitzx6aJt+1ePqWEnXEMXjV+WQ/JjXOf
         OnCXZ1s6DjygGdLTNcqKHas08n1YkEo2S/5TYVcmNdk+7LbIokFS99nBlz7w4hwDW5rL
         q+QvOiP/5HOyV4V7t3v8lC4UKT/iMT1pSpWo4f6REPW/6i5WYwuuxPV4uJWKTzgAcuUU
         TcTHpclj/fMM/p7XV6HFJ0mbBpZIiRDkL2/j1e+8psHNEPUS0WrD8hiE1KX8/rXVpcCZ
         8M7A==
X-Gm-Message-State: AJcUukdWkXXV6jgcNhRpcZkURNM4jFnmrkFpozo/uE6Ej5ob0A/kbxMe
        mmQJUazMzQB9VjB777SSumpSSw==
X-Google-Smtp-Source: AFSGD/VzUsLYNRfhern4Ej+auXbABbEa4q9EtHebPz1Q3pUb53N6UNtYAEGf6a/jiKI2f5H5lgUezA==
X-Received: by 2002:a62:c302:: with SMTP id v2mr50507921pfg.155.1546557033364;
        Thu, 03 Jan 2019 15:10:33 -0800 (PST)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id l184sm85622488pfc.112.2019.01.03.15.10.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 03 Jan 2019 15:10:32 -0800 (PST)
Date:   Thu, 3 Jan 2019 15:09:28 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     david.brown@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        andy.gross@linaro.org, briannorris@chromium.org,
        akdwived@codeaurora.org, clew@codeaurora.org,
        linux-kernel@vger.kernel.org, linux-arm-msm-owner@vger.kernel.org,
        ohad@wizery.com, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/2] remoteproc: qcom: Add support for parsing fw dt
 bindings
Message-ID: <20190103230928.GF31596@builder>
References: <20181228044819.5697-1-sibis@codeaurora.org>
 <20181228044819.5697-3-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181228044819.5697-3-sibis@codeaurora.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 27 Dec 20:48 PST 2018, Sibi Sankar wrote:

> Add support for parsing "firmware-name" dt bindings which specifies
> the relative paths of mba/modem/pas image as strings. Fallback to
> the default paths for mba/modem/pas image on -EINVAL.
> 
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>

Thanks Sibi, just some minor style issues I would prefer to have fixed.

I picked patch 1, so no need to resend that.

> ---
>  drivers/remoteproc/qcom_q6v5_mss.c | 46 +++++++++++++++++++++++-------
>  drivers/remoteproc/qcom_q6v5_pas.c | 11 ++++++-
>  2 files changed, 46 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/remoteproc/qcom_q6v5_mss.c b/drivers/remoteproc/qcom_q6v5_mss.c
> index 01be7314e176..c75179006e24 100644
> --- a/drivers/remoteproc/qcom_q6v5_mss.c
> +++ b/drivers/remoteproc/qcom_q6v5_mss.c
> @@ -188,6 +188,7 @@ struct q6v5 {
>  	bool has_alt_reset;
>  	int mpss_perm;
>  	int mba_perm;
> +	const char *hexagon_mdt_image;
>  	int version;
>  };
>  
> @@ -860,17 +861,27 @@ static int q6v5_mpss_load(struct q6v5 *qproc)
>  	phys_addr_t min_addr = PHYS_ADDR_MAX;
>  	phys_addr_t max_addr = 0;
>  	bool relocate = false;
> -	char seg_name[10];
> +	char *fw_name;
> +	size_t fw_name_len;
>  	ssize_t offset;
>  	size_t size = 0;
>  	void *ptr;
>  	int ret;
>  	int i;
>  
> -	ret = request_firmware(&fw, "modem.mdt", qproc->dev);
> +	fw_name_len = strlen(qproc->hexagon_mdt_image);
> +	if (fw_name_len <= 4)
> +		return -EINVAL;
> +
> +	fw_name = kstrdup(qproc->hexagon_mdt_image, GFP_KERNEL);
> +	if (!fw_name)
> +		return -ENOMEM;
> +
> +	ret = request_firmware(&fw, qproc->hexagon_mdt_image, qproc->dev);

Use fw_name here.

>  	if (ret < 0) {
> -		dev_err(qproc->dev, "unable to load modem.mdt\n");
> -		return ret;
> +		dev_err(qproc->dev, "unable to load %s\n",
> +			qproc->hexagon_mdt_image);
> +		goto out;
>  	}
>  
>  	/* Initialize the RMB validator */
> @@ -918,10 +929,12 @@ static int q6v5_mpss_load(struct q6v5 *qproc)
>  		ptr = qproc->mpss_region + offset;
>  
>  		if (phdr->p_filesz) {
> -			snprintf(seg_name, sizeof(seg_name), "modem.b%02d", i);
> -			ret = request_firmware(&seg_fw, seg_name, qproc->dev);
> +			snprintf(fw_name + fw_name_len - 3, fw_name_len,
> +				 "b%02d", i);
> +			ret = request_firmware(&seg_fw, fw_name, qproc->dev);
>  			if (ret) {
> -				dev_err(qproc->dev, "failed to load %s\n", seg_name);
> +				dev_err(qproc->dev, "failed to load %s\n",
> +					fw_name);

Follow my lead and break the 80-char limit.

>  				goto release_firmware;
>  			}
>  
> @@ -960,6 +973,8 @@ static int q6v5_mpss_load(struct q6v5 *qproc)
>  
>  release_firmware:
>  	release_firmware(fw);
> +out:
> +	kfree(fw_name);
>  
>  	return ret < 0 ? ret : 0;
>  }
> @@ -1075,9 +1090,10 @@ static int qcom_q6v5_register_dump_segments(struct rproc *rproc,
>  	unsigned long i;
>  	int ret;
>  
> -	ret = request_firmware(&fw, "modem.mdt", qproc->dev);
> +	ret = request_firmware(&fw, qproc->hexagon_mdt_image, qproc->dev);
>  	if (ret < 0) {
> -		dev_err(qproc->dev, "unable to load modem.mdt\n");
> +		dev_err(qproc->dev, "unable to load %s\n",
> +			qproc->hexagon_mdt_image);
>  		return ret;
>  	}
>  
> @@ -1253,6 +1269,8 @@ static int q6v5_probe(struct platform_device *pdev)
>  	const struct rproc_hexagon_res *desc;
>  	struct q6v5 *qproc;
>  	struct rproc *rproc;
> +	const char *mba_image;
> +	const char *fw_name[2];
>  	int ret;
>  
>  	desc = of_device_get_match_data(&pdev->dev);
> @@ -1262,8 +1280,15 @@ static int q6v5_probe(struct platform_device *pdev)
>  	if (desc->need_mem_protection && !qcom_scm_is_available())
>  		return -EPROBE_DEFER;
>  
> +	ret = of_property_read_string_array(pdev->dev.of_node, "firmware-name",
> +					    fw_name, 2);
> +	if (ret != -EINVAL && ret != 2)
> +		return ret > 0 ? -EINVAL : ret;
> +
> +	mba_image = (ret != 2) ? desc->hexagon_mba_image : fw_name[0];

Use the fact that of_property_read_string_index() leaves the output
parameter untouched if it doesn't succeed in parsing the property.

I.e. do:

mba_image = desc->hexagon_mba_image;
ret = of_property_read_string_index(pdev->dev.of_node, "firmware-name",
				    0, &mba_image);
if (ret < 0 && ret != -EINVAL)
	fail();

and

qproc->hexagon_mdt_image = "modem.mdt";
ret = of_property_read_string_index(pdev->dev.of_node, "firmware-name",
				    1, &qproc->hexagon_mdt_image);
if (ret < 0 && ret != -EINVAL)
	fail();

> +
>  	rproc = rproc_alloc(&pdev->dev, pdev->name, &q6v5_ops,
> -			    desc->hexagon_mba_image, sizeof(*qproc));
> +			    mba_image, sizeof(*qproc));
>  	if (!rproc) {
>  		dev_err(&pdev->dev, "failed to allocate rproc\n");
>  		return -ENOMEM;
> @@ -1272,6 +1297,7 @@ static int q6v5_probe(struct platform_device *pdev)
>  	qproc = (struct q6v5 *)rproc->priv;
>  	qproc->dev = &pdev->dev;
>  	qproc->rproc = rproc;
> +	qproc->hexagon_mdt_image = (ret != 2) ? "modem.mdt" : fw_name[1];
>  	platform_set_drvdata(pdev, qproc);
>  
>  	ret = q6v5_init_mem(qproc, pdev);
> diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
> index b1e63fcd5fdf..141c7da29e9a 100644
> --- a/drivers/remoteproc/qcom_q6v5_pas.c
> +++ b/drivers/remoteproc/qcom_q6v5_pas.c
> @@ -258,6 +258,8 @@ static int adsp_probe(struct platform_device *pdev)
>  	const struct adsp_data *desc;
>  	struct qcom_adsp *adsp;
>  	struct rproc *rproc;
> +	const char *fw_name;
> +	const char *of_fw_name;
>  	int ret;
>  
>  	desc = of_device_get_match_data(&pdev->dev);
> @@ -267,8 +269,15 @@ static int adsp_probe(struct platform_device *pdev)
>  	if (!qcom_scm_is_available())
>  		return -EPROBE_DEFER;
>  
> +	ret = of_property_read_string(pdev->dev.of_node, "firmware-name",
> +				      &of_fw_name);
> +	if (ret && ret != -EINVAL)
> +		return ret;
> +
> +	fw_name = ret ? desc->firmware_name : of_fw_name;

As above, please use the fact that the last parameter of
of_property_read_string() doesn't modify the output if it fails.

> +
>  	rproc = rproc_alloc(&pdev->dev, pdev->name, &adsp_ops,
> -			    desc->firmware_name, sizeof(*adsp));
> +			    fw_name, sizeof(*adsp));
>  	if (!rproc) {
>  		dev_err(&pdev->dev, "unable to allocate remoteproc\n");
>  		return -ENOMEM;

Regards,
Bjorn
