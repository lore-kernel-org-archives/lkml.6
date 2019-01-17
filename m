Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22C1BC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 17:43:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E212720652
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 17:43:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qzR3skrK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729413AbfAQRm7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 12:42:59 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46922 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725967AbfAQRm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 12:42:59 -0500
Received: by mail-pf1-f193.google.com with SMTP id c73so5146139pfe.13;
        Thu, 17 Jan 2019 09:42:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wsJOfEv3eqjFJ/DCwtmsLmOF7NCt6G4t55UwqKn1TcU=;
        b=qzR3skrKbpu2BO+UC0uCKqt9X8Q/5NOdQzC7+WynZHa5agGElan+rt3aJEoB/UPqTb
         Gtp/1Mv76YqR+Qm9BitSG40rjqZXcxSMG2oWzzM/7GfCSR8O+1JTTw5kPZIZTX3OAqrI
         GDsutjTqBivUbXp8hyYMhdxFIC33RCXnx/PxX0ow14kxMShREO+XGCeYOXpEshsEPZeW
         h2gFarOVFfW6IjZmNkQXhmWzynOXlrP2DdMWT1dFfb2hU4A9ibTriCqaK3ShYOU9kUey
         3gjb2qF+q7xjRZaCNA33RdcPWZrvlE7y1JEUQur3CgsGKgKVoJ+oGYZ1FAr2CcIQAo+C
         92ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=wsJOfEv3eqjFJ/DCwtmsLmOF7NCt6G4t55UwqKn1TcU=;
        b=md4wPL8RGRAbiD6EU639Zk8ski1EMpi27ymtAeLz5Y17uEwj/feX0twmgzqraYo3AM
         SJ3WNld7HlGdwlKKuUlGqRwC+mDqe6kvJEnOGaXnJdo3UQ2ddygFA2YCxQ/RQYJ8kKBO
         8z6HuN/zVyMNlV70X4vX3LXE3D6Qz8OEImjNdc98ZPvYHo+cfqBDlU3zDMQyIet1BknT
         7Fb7eQtVmiyicPOSs+z6cZK7Tg2MMnBxlMkzY7H7MybjV2TZ9A7RRI0Adi2KLnEyWAdt
         5oN92PSj6x9y4+JKdMZoffHIjXxS2ibnTIDFMihG24z0juleeEv49+MgR2l0UdS3Q96u
         3/PQ==
X-Gm-Message-State: AJcUukeAJG34UVcQVVyhNNdMcDQNbTgA5zwrCgzHHT40WZ5vdgIct7D6
        AQsFnGXfHRc8R+CPiX9Uq5g=
X-Google-Smtp-Source: ALg8bN7WdtD+xgybY7FDMAbobHcZE7Edl2+x3Gj+Bc0nCR/4Ytma1FeREBv+G9SmI6oYyqmNjjV7Ig==
X-Received: by 2002:a62:2e46:: with SMTP id u67mr15555357pfu.3.1547746977885;
        Thu, 17 Jan 2019 09:42:57 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 12sm2144475pgt.33.2019.01.17.09.42.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 09:42:56 -0800 (PST)
Date:   Thu, 17 Jan 2019 09:42:54 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     andy.gross@linaro.org, robh@kernel.org, viresh.kumar@linaro.org,
        sboyd@kernel.org, ulf.hansson@linaro.org, collinsd@codeaurora.org,
        mka@chromium.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        henryc.chen@mediatek.com
Subject: Re: [PATCH v11 4/9] soc: qcom: rpmpd: Add a Power domain driver to
 model corners
Message-ID: <20190117174254.GA17273@roeck-us.net>
References: <20190110040209.6028-1-rnayak@codeaurora.org>
 <20190110040209.6028-5-rnayak@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190110040209.6028-5-rnayak@codeaurora.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 09:32:04AM +0530, Rajendra Nayak wrote:
> The Power domains for corners just pass the performance state set by the
> consumers to the RPM (Remote Power manager) which then takes care
> of setting the appropriate voltage on the corresponding rails to
> meet the performance needs.
> 
> We add all power domain data needed on msm8996 here. This driver can easily
> be extended by adding data for other qualcomm SoCs as well.
> 
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> Acked-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  drivers/soc/qcom/Kconfig  |   9 ++
>  drivers/soc/qcom/Makefile |   1 +
>  drivers/soc/qcom/rpmpd.c  | 282 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 292 insertions(+)
>  create mode 100644 drivers/soc/qcom/rpmpd.c
> 
> diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
> index fcbf8a2e4080..df5cd9fa0d5e 100644
> --- a/drivers/soc/qcom/Kconfig
> +++ b/drivers/soc/qcom/Kconfig
> @@ -98,6 +98,15 @@ config QCOM_RPMH
>  	  of hardware components aggregate requests for these resources and
>  	  help apply the aggregated state on the resource.
>  
> +config QCOM_RPMPD
> +	bool "Qualcomm RPM Power domain driver"
> +	depends on MFD_QCOM_RPM && QCOM_SMD_RPM

Since this is bool, but the dependent configurations are tristate,
configurations such as arm64:allmodconfig result in

CONFIG_QCOM_RPMPD=y
CONFIG_MFD_QCOM_RPM=m
CONFIG_QCOM_SMD_RPM=m

This in turn results in

   arm-linux-gnueabi-ld: drivers/soc/qcom/rpmpd.o: in function `rpmpd_send_enable': 
>> rpmpd.c:(.text+0x64): undefined reference to `qcom_rpm_smd_write' 
   arm-linux-gnueabi-ld: drivers/soc/qcom/rpmpd.o: in function `rpmpd_power_on': 
   rpmpd.c:(.text+0x408): undefined reference to `qcom_rpm_smd_write' 
>> arm-linux-gnueabi-ld: rpmpd.c:(.text+0x460): undefined reference to `qcom_rpm_smd_write' 

as reported by 0day.

Either this needs to change to tristate, or the dependency must be
	depends on MFD_QCOM_RPM=y && QCOM_SMD_RPM=y

Guenter
