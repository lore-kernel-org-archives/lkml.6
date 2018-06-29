Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E690DC43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 11:22:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C75F27E2A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 11:22:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mm-sol.com header.i=@mm-sol.com header.b="NJQkbIyR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C75F27E2A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=mm-sol.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935159AbeF2LWO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 07:22:14 -0400
Received: from ns.mm-sol.com ([37.157.136.199]:57047 "EHLO extserv.mm-sol.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752883AbeF2LWL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 07:22:11 -0400
Received: from [192.168.27.209] (unknown [37.157.136.206])
        by extserv.mm-sol.com (Postfix) with ESMTPSA id 65D50CD38;
        Fri, 29 Jun 2018 14:22:08 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mm-sol.com; s=201706;
        t=1530271328; bh=IDhT5xgXi80VKKkup19IRVa6ZQIjkqqiVm/8g9OTZSE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=NJQkbIyRHQ5PWYFB7ixh9neoURsBK2ufZ/OXFue9GE/2wKY1N8aRdTJBaZDLd6wzN
         NChkaUz0RuqbPrJfZHA8x58bsNnSt+PzZJJ1K4KFTAwOjFR79nsOgLQwH7l8pQj2q+
         V0pmQB9zqaN9zMoE0+2HWflXXCstOvDsfVOVXbpOzokxCuABDK0nPCl7PJVwmI4Fge
         3Yv/LIjTrcoiY4FPT4O3obXaJF7NjliFJ/jKMTwuWEBxmqXyGFGLFyVAeLGQP8X+Ha
         LLuTAcUo1yZFxWJ5Ag7/iLyAQs8uVA98klf0xHRDThgxCTlgAhYHY1ePaRdTEoRrwx
         a2OaTfJrjIJeQ==
Subject: Re: [PATCH] PCI: qcom: Fix error handling in pm_runtime support
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180525190934.1042-1-bjorn.andersson@linaro.org>
From:   Stanimir Varbanov <svarbanov@mm-sol.com>
Message-ID: <5b8b3929-c0dc-527c-b7d4-744e28808dbb@mm-sol.com>
Date:   Fri, 29 Jun 2018 14:22:06 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180525190934.1042-1-bjorn.andersson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

On 05/25/2018 10:09 PM, Bjorn Andersson wrote:
> The driver does not cope with the fact that probe can fail in a number
> of cases after enabling pm_runtime on the device, this results in
> warnings about "Unbalanced pm_runtime_enable". Further more if probe
> fails after invoking host_init the power-domain will be left referenced.
> 
> As it's not possible for the error handling in qcom_pcie_host_init() to
> handle errors happening after returning from that function the
> pm_runtime_get_sync() is moved to probe() as well.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Please add:

Fixes: 854b69efbdd2903991506ac5d5624d2cfb5b4e2f PCI: qcom: add runtime
pm support to pcie_port

> ---
> 
> I'm sorry for not spotting this last week when we discussed the previous patch.
> 
>  drivers/pci/dwc/pcie-qcom.c | 65 ++++++++++++++++++++++++++-----------

the path has been changed to drivers/pci/controller/dwc/pcie-qcom.c

>  1 file changed, 46 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/pci/dwc/pcie-qcom.c b/drivers/pci/dwc/pcie-qcom.c
> index 3f35098b71b1..f2453196278f 100644
> --- a/drivers/pci/dwc/pcie-qcom.c
> +++ b/drivers/pci/dwc/pcie-qcom.c
> @@ -1088,8 +1088,6 @@ static int qcom_pcie_host_init(struct pcie_port *pp)
>  	struct qcom_pcie *pcie = to_qcom_pcie(pci);
>  	int ret;
>  
> -	pm_runtime_get_sync(pci->dev);
> -
>  	qcom_ep_reset_assert(pcie);
>  
>  	ret = pcie->ops->init(pcie);
> @@ -1126,7 +1124,6 @@ static int qcom_pcie_host_init(struct pcie_port *pp)
>  	phy_power_off(pcie->phy);
>  err_deinit:
>  	pcie->ops->deinit(pcie);
> -	pm_runtime_put_sync(pci->dev);
>  
>  	return ret;
>  }
> @@ -1207,7 +1204,6 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>  	struct qcom_pcie *pcie;
>  	int ret;
>  
> -
>  	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
>  	if (!pcie)
>  		return -ENOMEM;
> @@ -1217,6 +1213,7 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  
>  	pm_runtime_enable(dev);
> +	pm_runtime_get_sync(dev);

pm_runtime_get_sync could fail, please check for errors.

With those changes addressed:

Acked-by: Stanimir Varbanov <svarbanov@mm-sol.com>

-- 
regards,
Stan
