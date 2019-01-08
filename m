Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C06D6C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 10:32:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85BD6218B0
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 10:32:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="kiVUd5EK";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="TPBMPO+Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728620AbfAHKcx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 05:32:53 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:40238 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727651AbfAHKcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 05:32:53 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E5A9160588; Tue,  8 Jan 2019 10:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1546943571;
        bh=VP0U24lShbrnoz0810cDBQvRk46HfXb3A6KzJgjcBjY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kiVUd5EKf6fStYYzPtynJOoxHML+DZSWotGTP3ylntxdiEvkU+fVc2FqIFZIVmIDt
         U6ObmorxW7gcf9Sz0sRZyHDmv9BpIqOQVKAz3ak4RSPUiE70Rm2KLWxCrUcwHt1al7
         h9aZjLbfJYkRXj77UnguK4uxN98YfiaBxMdA5Chk=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 35B72601EA;
        Tue,  8 Jan 2019 10:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1546943570;
        bh=VP0U24lShbrnoz0810cDBQvRk46HfXb3A6KzJgjcBjY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TPBMPO+Q0W98hO6CR1yggf4BnIuCtS+g8ZcIDnFJQ7jrJ9Np4m7seDwPNCym4GKNA
         uCawIWJjXLBPLZjprxbfTUCiQJxduGMj37qfnym6C2ooOSdv+Yw9lWjqCR9jgAH5mT
         B3P+BPuD2u+nXvtMgR4EXEmtSKvDMq17SmwL1fZ8=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 08 Jan 2019 16:02:50 +0530
From:   Sibi Sankar <sibis@codeaurora.org>
To:     Brian Norris <briannorris@chromium.org>
Cc:     bjorn.andersson@linaro.org, david.brown@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, andy.gross@linaro.org,
        akdwived@codeaurora.org, clew@codeaurora.org,
        linux-kernel@vger.kernel.org, linux-arm-msm-owner@vger.kernel.org,
        ohad@wizery.com, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/2] remoteproc: qcom: Add support for parsing fw dt
 bindings
In-Reply-To: <20190103234426.GB181833@google.com>
References: <20181228044819.5697-1-sibis@codeaurora.org>
 <20181228044819.5697-3-sibis@codeaurora.org>
 <20190103234426.GB181833@google.com>
Message-ID: <02d8f877e830f40d2e688d7d6c3ae805@codeaurora.org>
X-Sender: sibis@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Brian,
Thanks for the review!

On 2019-01-04 05:14, Brian Norris wrote:
> On Fri, Dec 28, 2018 at 10:18:19AM +0530, Sibi Sankar wrote:
>> Add support for parsing "firmware-name" dt bindings which specifies
>> the relative paths of mba/modem/pas image as strings. Fallback to
>> the default paths for mba/modem/pas image on -EINVAL.
>> 
>> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
>> ---
>>  drivers/remoteproc/qcom_q6v5_mss.c | 46 
>> +++++++++++++++++++++++-------
>>  drivers/remoteproc/qcom_q6v5_pas.c | 11 ++++++-
>>  2 files changed, 46 insertions(+), 11 deletions(-)
>> 
>> diff --git a/drivers/remoteproc/qcom_q6v5_mss.c 
>> b/drivers/remoteproc/qcom_q6v5_mss.c
>> index 01be7314e176..c75179006e24 100644
>> --- a/drivers/remoteproc/qcom_q6v5_mss.c
>> +++ b/drivers/remoteproc/qcom_q6v5_mss.c
>> @@ -188,6 +188,7 @@ struct q6v5 {
>>  	bool has_alt_reset;
>>  	int mpss_perm;
>>  	int mba_perm;
>> +	const char *hexagon_mdt_image;
>>  	int version;
>>  };
>> 
>> @@ -860,17 +861,27 @@ static int q6v5_mpss_load(struct q6v5 *qproc)
>>  	phys_addr_t min_addr = PHYS_ADDR_MAX;
>>  	phys_addr_t max_addr = 0;
>>  	bool relocate = false;
>> -	char seg_name[10];
>> +	char *fw_name;
>> +	size_t fw_name_len;
>>  	ssize_t offset;
>>  	size_t size = 0;
>>  	void *ptr;
>>  	int ret;
>>  	int i;
>> 
>> -	ret = request_firmware(&fw, "modem.mdt", qproc->dev);
>> +	fw_name_len = strlen(qproc->hexagon_mdt_image);
>> +	if (fw_name_len <= 4)
>> +		return -EINVAL;
>> +
>> +	fw_name = kstrdup(qproc->hexagon_mdt_image, GFP_KERNEL);
>> +	if (!fw_name)
>> +		return -ENOMEM;
>> +
>> +	ret = request_firmware(&fw, qproc->hexagon_mdt_image, qproc->dev);
>>  	if (ret < 0) {
>> -		dev_err(qproc->dev, "unable to load modem.mdt\n");
>> -		return ret;
>> +		dev_err(qproc->dev, "unable to load %s\n",
>> +			qproc->hexagon_mdt_image);
>> +		goto out;
>>  	}
>> 
>>  	/* Initialize the RMB validator */
>> @@ -918,10 +929,12 @@ static int q6v5_mpss_load(struct q6v5 *qproc)
>>  		ptr = qproc->mpss_region + offset;
>> 
>>  		if (phdr->p_filesz) {
>> -			snprintf(seg_name, sizeof(seg_name), "modem.b%02d", i);
>> -			ret = request_firmware(&seg_fw, seg_name, qproc->dev);
>> +			snprintf(fw_name + fw_name_len - 3, fw_name_len,
>> +				 "b%02d", i);
> 
> So, you're assuming that 'fw_name' ends in '.XXX' (for some 3-char 
> value
> of 'XXX')? Seems a bit odd. But if you really want this, it feels like
> you should enforce this, and either comment on what you're doing or 
> else
> use a proper computation that makes it clear (e.g., strlen("bin")).
> 
> Brian

we want to construct the names of the fw blobs
incrementally i.e xxx.xxx to xxx.bxx. Given
that we restrict the fw_name_len to be greater
than 4 at the beginning, I'll probably do
something like this.

/* Replace "xxx.xxx" with "xxx.bxx" */
sprintf(fw_name + fw_name_len - 3, "b%02d", i);

> 
>> +			ret = request_firmware(&seg_fw, fw_name, qproc->dev);
>>  			if (ret) {
>> -				dev_err(qproc->dev, "failed to load %s\n", seg_name);
>> +				dev_err(qproc->dev, "failed to load %s\n",
>> +					fw_name);
>>  				goto release_firmware;
>>  			}
>> 
>> @@ -960,6 +973,8 @@ static int q6v5_mpss_load(struct q6v5 *qproc)
>> 
>>  release_firmware:
>>  	release_firmware(fw);
>> +out:
>> +	kfree(fw_name);
>> 
>>  	return ret < 0 ? ret : 0;
>>  }
>> @@ -1075,9 +1090,10 @@ static int 
>> qcom_q6v5_register_dump_segments(struct rproc *rproc,
>>  	unsigned long i;
>>  	int ret;
>> 
>> -	ret = request_firmware(&fw, "modem.mdt", qproc->dev);
>> +	ret = request_firmware(&fw, qproc->hexagon_mdt_image, qproc->dev);
>>  	if (ret < 0) {
>> -		dev_err(qproc->dev, "unable to load modem.mdt\n");
>> +		dev_err(qproc->dev, "unable to load %s\n",
>> +			qproc->hexagon_mdt_image);
>>  		return ret;
>>  	}
>> 
>> @@ -1253,6 +1269,8 @@ static int q6v5_probe(struct platform_device 
>> *pdev)
>>  	const struct rproc_hexagon_res *desc;
>>  	struct q6v5 *qproc;
>>  	struct rproc *rproc;
>> +	const char *mba_image;
>> +	const char *fw_name[2];
>>  	int ret;
>> 
>>  	desc = of_device_get_match_data(&pdev->dev);
>> @@ -1262,8 +1280,15 @@ static int q6v5_probe(struct platform_device 
>> *pdev)
>>  	if (desc->need_mem_protection && !qcom_scm_is_available())
>>  		return -EPROBE_DEFER;
>> 
>> +	ret = of_property_read_string_array(pdev->dev.of_node, 
>> "firmware-name",
>> +					    fw_name, 2);
>> +	if (ret != -EINVAL && ret != 2)
>> +		return ret > 0 ? -EINVAL : ret;
>> +
>> +	mba_image = (ret != 2) ? desc->hexagon_mba_image : fw_name[0];
>> +
>>  	rproc = rproc_alloc(&pdev->dev, pdev->name, &q6v5_ops,
>> -			    desc->hexagon_mba_image, sizeof(*qproc));
>> +			    mba_image, sizeof(*qproc));
>>  	if (!rproc) {
>>  		dev_err(&pdev->dev, "failed to allocate rproc\n");
>>  		return -ENOMEM;
>> @@ -1272,6 +1297,7 @@ static int q6v5_probe(struct platform_device 
>> *pdev)
>>  	qproc = (struct q6v5 *)rproc->priv;
>>  	qproc->dev = &pdev->dev;
>>  	qproc->rproc = rproc;
>> +	qproc->hexagon_mdt_image = (ret != 2) ? "modem.mdt" : fw_name[1];
>>  	platform_set_drvdata(pdev, qproc);
>> 
>>  	ret = q6v5_init_mem(qproc, pdev);
>> diff --git a/drivers/remoteproc/qcom_q6v5_pas.c 
>> b/drivers/remoteproc/qcom_q6v5_pas.c
>> index b1e63fcd5fdf..141c7da29e9a 100644
>> --- a/drivers/remoteproc/qcom_q6v5_pas.c
>> +++ b/drivers/remoteproc/qcom_q6v5_pas.c
>> @@ -258,6 +258,8 @@ static int adsp_probe(struct platform_device 
>> *pdev)
>>  	const struct adsp_data *desc;
>>  	struct qcom_adsp *adsp;
>>  	struct rproc *rproc;
>> +	const char *fw_name;
>> +	const char *of_fw_name;
>>  	int ret;
>> 
>>  	desc = of_device_get_match_data(&pdev->dev);
>> @@ -267,8 +269,15 @@ static int adsp_probe(struct platform_device 
>> *pdev)
>>  	if (!qcom_scm_is_available())
>>  		return -EPROBE_DEFER;
>> 
>> +	ret = of_property_read_string(pdev->dev.of_node, "firmware-name",
>> +				      &of_fw_name);
>> +	if (ret && ret != -EINVAL)
>> +		return ret;
>> +
>> +	fw_name = ret ? desc->firmware_name : of_fw_name;
>> +
>>  	rproc = rproc_alloc(&pdev->dev, pdev->name, &adsp_ops,
>> -			    desc->firmware_name, sizeof(*adsp));
>> +			    fw_name, sizeof(*adsp));
>>  	if (!rproc) {
>>  		dev_err(&pdev->dev, "unable to allocate remoteproc\n");
>>  		return -ENOMEM;
>> --
>> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
>> Forum,
>> a Linux Foundation Collaborative Project
>> 

-- 
-- Sibi Sankar --
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project.
