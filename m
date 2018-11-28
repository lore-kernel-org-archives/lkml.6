Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C6A8C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 17:57:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17068205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 17:57:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marek-ca.20150623.gappssmtp.com header.i=@marek-ca.20150623.gappssmtp.com header.b="efK7I162"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17068205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=marek.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbeK2FAY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 00:00:24 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:35486 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725760AbeK2FAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 00:00:24 -0500
Received: by mail-qk1-f194.google.com with SMTP id w204so17372105qka.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 09:57:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=/NsrvL0kRhjUGNViE+wd/oY81//GuP2wqxtY04IAz2U=;
        b=efK7I162xP7d8jbNyBE7kkzs5EzdGNlkIpmXGLUcYLrKqPkVwYhDzjih5ntfLnXTMl
         uREt7uF28mTGNA11P/zYAhqbusTWlIV2hiwbqgU52UzFG2azMPKrhKC/yAdKBxnHj8xE
         nhTLGzNa3Ps2Jh8w5ROkqPd5vvVBtYzmqvJkH4FkD6epp9JKJ0Ykw7ulWvR3ioZGGTC+
         VV3DYn7oBEqoa8f6A83/VbmSSOJ6uAZtihnW4JK9QlGsNFxW9psqOsrVDNik3CnKzBd8
         tt94sECRqoCG8F4lUUwsJSUGe1tCHJnQpvJBjdxxzB92d3i8DwoCSd7i9RC0vaSkdET5
         2YfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/NsrvL0kRhjUGNViE+wd/oY81//GuP2wqxtY04IAz2U=;
        b=ttjHgrsKEp/KycgyayLfQcktGv7ZKqqwqmw1+nJ3h0OK6YbK9hDWauPdavhJqmqXxA
         nnLcPevn5sAKZqIA78DCZw71T6J8LWY8eueGq9zJL5DqZAsycN2YloYEZm/KOysr1Vc7
         woDAEU6R7kt7p2lga/OYuAldGzd2Ydel3nww94FD9554By2Y8/u6TYEvWp2zvvewi6wJ
         HX3gomqVRjAj1url+rsWT+L9M3Jg1u/Yi6SxHKcpdEin1EyigoVAsFtt+Q84shquRCZV
         koKPNhBJznqyef6/Zfn7Ln4hfUt2c6FWeaVGy3mEFO5wDapCe0v+1G6ut1swItEaeqw6
         RGUQ==
X-Gm-Message-State: AA+aEWYBTJ85kWPaXPYDKvytkc0egEz1BwAovMTHJiaSyVhLfxrrv88n
        Epu2q/zqhLne93tfpbqqVdiJSw==
X-Google-Smtp-Source: AFSGD/XK1c6T2iOfViW+SAI0Y9xFoy6yVdx9sZuKNjkmYmo+VgIuEjmpduEqjauhmDu91Y5f4SG59g==
X-Received: by 2002:a37:9281:: with SMTP id u123mr36066650qkd.0.1543427875503;
        Wed, 28 Nov 2018 09:57:55 -0800 (PST)
Received: from [192.168.0.189] (modemcable014.247-57-74.mc.videotron.ca. [74.57.247.14])
        by smtp.gmail.com with ESMTPSA id m49sm4850537qtb.40.2018.11.28.09.57.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Nov 2018 09:57:54 -0800 (PST)
Subject: Re: [Freedreno] [PATCH v2 5/9] drm/msm: add headless gpu device (for
 imx5)
To:     freedreno@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <linux-arm-msm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <dri-devel@lists.freedesktop.org>, Rob Clark <robdclark@gmail.com>,
        Chris.Healy@zii.aero, festevam@gmail.com
References: <20181122015237.14534-1-jonathan@marek.ca>
 <20181122015237.14534-5-jonathan@marek.ca>
 <20181126154820.GJ31792@jcrouse-lnx.qualcomm.com>
From:   Jonathan marek <jonathan@marek.ca>
Message-ID: <7b57657f-6899-5b59-6fb7-cc442518ecd5@marek.ca>
Date:   Wed, 28 Nov 2018 12:55:26 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20181126154820.GJ31792@jcrouse-lnx.qualcomm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/26/2018 10:48 AM, Jordan Crouse wrote:
> On Wed, Nov 21, 2018 at 08:52:31PM -0500, Jonathan Marek wrote:
>> This patch allows using drm/msm without qcom display hardware. This is
>> especially useful for iMX5 hardware, which has a a2xx GPU but uses the
>> imx-drm driver for display.
>>
>> Signed-off-by: Jonathan Marek <jonathan@marek.ca>
>> ---
>> v2: added commit message and removed unnecessary comment
>>
>>   drivers/gpu/drm/msm/Kconfig       |  4 ++--
>>   drivers/gpu/drm/msm/msm_debugfs.c |  2 +-
>>   drivers/gpu/drm/msm/msm_drv.c     | 21 +++++++++++----------
>>   3 files changed, 14 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/msm/Kconfig b/drivers/gpu/drm/msm/Kconfig
>> index 843a9d40c05e..cf549f1ed403 100644
>> --- a/drivers/gpu/drm/msm/Kconfig
>> +++ b/drivers/gpu/drm/msm/Kconfig
>> @@ -2,7 +2,7 @@
>>   config DRM_MSM
>>   	tristate "MSM DRM"
>>   	depends on DRM
>> -	depends on ARCH_QCOM || (ARM && COMPILE_TEST)
>> +	depends on ARCH_QCOM || SOC_IMX5 || (ARM && COMPILE_TEST)
>>   	depends on OF && COMMON_CLK
>>   	depends on MMU
>>   	select QCOM_MDT_LOADER if ARCH_QCOM
>> @@ -11,7 +11,7 @@ config DRM_MSM
>>   	select DRM_PANEL
>>   	select SHMEM
>>   	select TMPFS
>> -	select QCOM_SCM
>> +	select QCOM_SCM if ARCH_QCOM
>>   	select WANT_DEV_COREDUMP
>>   	select SND_SOC_HDMI_CODEC if SND_SOC
>>   	select SYNC_FILE
> 
> This is good - there are probably a handful of others you can add too -
> WANT_DEV_COREDUMP for example (at least for now) but you can audit those later
> as you try to cut down your binary size.
> 
> Also serves as an important reminder for the rest of us that Adreno just isn't
> for Snapdragon anymore.
> 
>> diff --git a/drivers/gpu/drm/msm/msm_debugfs.c b/drivers/gpu/drm/msm/msm_debugfs.c
>> index f0da0d3c8a80..1ca99ca356a4 100644
>> --- a/drivers/gpu/drm/msm/msm_debugfs.c
>> +++ b/drivers/gpu/drm/msm/msm_debugfs.c
>> @@ -235,7 +235,7 @@ int msm_debugfs_init(struct drm_minor *minor)
>>   	debugfs_create_file("gpu", S_IRUSR, minor->debugfs_root,
>>   		dev, &msm_gpu_fops);
>>   
>> -	if (priv->kms->funcs->debugfs_init) {
>> +	if (priv->kms && priv->kms->funcs->debugfs_init) {
>>   		ret = priv->kms->funcs->debugfs_init(priv->kms, minor);
>>   		if (ret)
>>   			return ret;
>> diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
>> index 9f219e02f3c7..3f35e57202ef 100644
>> --- a/drivers/gpu/drm/msm/msm_drv.c
>> +++ b/drivers/gpu/drm/msm/msm_drv.c
>> @@ -344,6 +344,7 @@ static int msm_drm_uninit(struct device *dev)
>>   	return 0;
>>   }
>>   
>> +#define KMS_HEADLESS 1
>>   #define KMS_MDP4 4
>>   #define KMS_MDP5 5
>>   #define KMS_DPU  3
>> @@ -495,6 +496,9 @@ static int msm_drm_init(struct device *dev, struct drm_driver *drv)
>>   	msm_gem_shrinker_init(ddev);
>>   
>>   	switch (get_mdp_ver(pdev)) {
>> +	case KMS_HEADLESS:
>> +		priv->kms = kms = NULL;
>> +		break;
>>   	case KMS_MDP4:
>>   		kms = mdp4_kms_init(ddev);
>>   		priv->kms = kms;
>> @@ -512,12 +516,6 @@ static int msm_drm_init(struct device *dev, struct drm_driver *drv)
>>   	}
>>   
>>   	if (IS_ERR(kms)) {
>> -		/*
>> -		 * NOTE: once we have GPU support, having no kms should not
>> -		 * be considered fatal.. ideally we would still support gpu
>> -		 * and (for example) use dmabuf/prime to share buffers with
>> -		 * imx drm driver on iMX5
>> -		 */
>>   		dev_err(dev, "failed to load kms\n");
>>   		ret = PTR_ERR(kms);
>>   		goto err_msm_uninit;
>> @@ -633,7 +631,7 @@ static int msm_drm_init(struct device *dev, struct drm_driver *drv)
>>   	drm_mode_config_reset(ddev);
>>   
>>   #ifdef CONFIG_DRM_FBDEV_EMULATION
>> -	if (fbdev)
>> +	if (kms && fbdev)
>>   		priv->fbdev = msm_fbdev_init(ddev);
>>   #endif
>>   
>> @@ -1315,9 +1313,11 @@ static int msm_pdev_probe(struct platform_device *pdev)
>>   	struct component_match *match = NULL;
>>   	int ret;
>>   
>> -	ret = add_display_components(&pdev->dev, &match);
>> -	if (ret)
>> -		return ret;
>> +	if (get_mdp_ver(pdev) != KMS_HEADLESS) {
>> +		ret = add_display_components(&pdev->dev, &match);
>> +		if (ret)
>> +			return ret;
>> +	}
>>   
>>   	ret = add_gpu_components(&pdev->dev, &match);
>>   	if (ret)
>> @@ -1342,6 +1342,7 @@ static int msm_pdev_remove(struct platform_device *pdev)
>>   }
>>   
>>   static const struct of_device_id dt_match[] = {
>> +	{ .compatible = "qcom,adreno-headless", .data = (void *)KMS_HEADLESS },
> 
> I feel that this should be more descriptive for your hardware and not just
> generic. You don't need to include the qcom, extension and you'll probably
> want to use a more descriptive vendor if you are adding imx5 specific data to
> the DT.
> 

Perhaps two entries, one for imx and one for qcom? This headless mode 
can be used with any adreno GPU.

>>   	{ .compatible = "qcom,mdp4", .data = (void *)KMS_MDP4 },
>>   	{ .compatible = "qcom,mdss", .data = (void *)KMS_MDP5 },
>>   	{ .compatible = "qcom,sdm845-mdss", .data = (void *)KMS_DPU },
>> -- 
>> 2.17.1
>   
> 
