Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A0C7C1B0F1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 03:04:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D4AD2083D
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 03:04:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="V/n4e+yY";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="V/n4e+yY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D4AD2083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754529AbeFTDEq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 23:04:46 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:60224 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753862AbeFTDEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 23:04:41 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id B58EC60AD8; Wed, 20 Jun 2018 03:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529463880;
        bh=OlvWZhG8jq3tmce/eiioOt6XaXNYnDscrnLU7aB/Y2I=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=V/n4e+yY/5cXEF2gDUa37uv/MCGAi0Q1PJKDgWwBG/KkSzoIJE9/iO1PGFyqK4I/T
         N+L1NaZpPk2fujb2jqYgPqBAhu17185vJCpEw2IrtyLJmn/5wWOH4VRvQ+mV0DUmUE
         aPlLrDZPH5mF+rZUynRa7NnOyLG1qFRr42k0aSow=
Received: from [192.168.0.106] (cpe-174-109-247-98.nc.res.rr.com [174.109.247.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: okaya@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3AD2B60558;
        Wed, 20 Jun 2018 03:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529463880;
        bh=OlvWZhG8jq3tmce/eiioOt6XaXNYnDscrnLU7aB/Y2I=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=V/n4e+yY/5cXEF2gDUa37uv/MCGAi0Q1PJKDgWwBG/KkSzoIJE9/iO1PGFyqK4I/T
         N+L1NaZpPk2fujb2jqYgPqBAhu17185vJCpEw2IrtyLJmn/5wWOH4VRvQ+mV0DUmUE
         aPlLrDZPH5mF+rZUynRa7NnOyLG1qFRr42k0aSow=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3AD2B60558
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
Subject: Re: [PATCH V2] PCI: Enable PASID when End-to-End TLP is supported by
 all bridges
To:     Timur Tabi <timur@codeaurora.org>, linux-pci@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        open list <linux-kernel@vger.kernel.org>
References: <1529460886-23722-1-git-send-email-okaya@codeaurora.org>
 <dafc272d-0748-90ee-5d34-be5b2a2e5725@codeaurora.org>
From:   Sinan Kaya <okaya@codeaurora.org>
Message-ID: <843fd601-0b81-d29f-0aa8-13a261a0b931@codeaurora.org>
Date:   Tue, 19 Jun 2018 23:04:38 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <dafc272d-0748-90ee-5d34-be5b2a2e5725@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/19/2018 11:02 PM, Timur Tabi wrote:
> On 6/19/18 9:14 PM, Sinan Kaya wrote:
>> +    if (!(cap & PCI_EXP_DEVCAP2_E2ETLP))
>> +        return;
>> +
>> +    dev->eetlp_prefix = 1;
> 
> How about:
> 
>     if (cap & PCI_EXP_DEVCAP2_E2ETLP)
>         dev->eetlp_prefix = 1;
> 

Both works. I'll wait until I get more feedback.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
