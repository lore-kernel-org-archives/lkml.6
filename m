Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F365BC00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 13:44:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADC4C20684
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 13:44:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="aUHhjkzJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADC4C20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbeJCUcn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 16:32:43 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:8093 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726694AbeJCUcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 16:32:43 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5bb4c7960000>; Wed, 03 Oct 2018 06:43:50 -0700
Received: from HQMAIL101.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 03 Oct 2018 06:44:14 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 03 Oct 2018 06:44:14 -0700
Received: from [10.21.132.143] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 3 Oct
 2018 13:44:12 +0000
Subject: Re: [PATCH V2 3/5] usb: xhci: tegra: Add genpd support
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>
References: <1538143910-24400-1-git-send-email-jonathanh@nvidia.com>
 <1538143910-24400-4-git-send-email-jonathanh@nvidia.com>
 <CAPDyKFrfcQX0-QrMKy=E=rif9-SjSfxc+LTMBUn5oqOquRdqRg@mail.gmail.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <4f532f84-4991-6916-b53d-036e7e98be97@nvidia.com>
Date:   Wed, 3 Oct 2018 14:44:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAPDyKFrfcQX0-QrMKy=E=rif9-SjSfxc+LTMBUn5oqOquRdqRg@mail.gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1538574230; bh=6j3IWV2p81h9Xqb2FuIIzULA4BXOu8oC3jw19ppoV9Y=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=aUHhjkzJj6hHLVmunj8EqFM4NBrvIias0f5vjwjT/3+cOnDYDIOOHFVPPqgf/iyG0
         qib8r71+23BfC0gN4D75OGd+mr5kPIcsMzNwWjqXioQe5PsIbLoiv0XjplNgz26uhD
         gxGIfLwB3A8vIsFxN9BjOVITyAekWnNimI7XsiEyC6+fnrqxDq8VidV7m75SqSmV++
         q/Rz0cuBb32By4wRDB+Ur8HG0HRp/PU9Cuswy9QabPEaNzOvGeXPgRr5i1OsDP+yG3
         pq6YnB80jxi23GFep5h2Fc3z3GT4AInglM0r42aDQxnqkGK74WbWp6imHm/LHtfAUl
         dMp2Lzk4gPdTA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 03/10/18 10:52, Ulf Hansson wrote:
> [...]
> 
>>  static int tegra_xusb_probe(struct platform_device *pdev)
>>  {
>>         struct tegra_xusb_mbox_msg msg;
>> @@ -1038,7 +1095,7 @@ static int tegra_xusb_probe(struct platform_device *pdev)
>>                 goto put_padctl;
>>         }
>>
>> -       if (!pdev->dev.pm_domain) {
>> +       if (!of_property_read_bool(pdev->dev.of_node, "power-domains")) {
> 
> I am assuming the original check was because allowing the two
> power-domains to be (wrongly) modeled as one (or as a
> master+subdomain)?

Actually, the original check was added to prepare for supporting
multiple power-domains and that once we had proper support in place the
'pdev->dev.domain' would then be populated. However, given that this is
not used in the case of multiple power-domains, I simply changed the test.

> I was thinking that, perhaps we should add a new OF helper function,
> where one can get the number of specifiers being listed in the
> power-domains property. Would that help to easier distinguish what to
> do when dealing with backwards compatibility?

We could do, but it is not necessary here, because we never had any form
of genpd support for the Tegra xHCI driver.

Cheers
Jon

-- 
nvpublic
