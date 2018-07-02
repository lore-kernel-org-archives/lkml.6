Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5F9EC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 20:40:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B7E224FE5
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 20:40:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="C0zhLOUz";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="C0zhLOUz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B7E224FE5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752950AbeGBUkS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 16:40:18 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:35630 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752197AbeGBUkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 16:40:15 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E377A60B27; Mon,  2 Jul 2018 20:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530564014;
        bh=qr2hkAkxy28+jjs5YpZlkpc3t0nMeQanF+TNnwnFI94=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=C0zhLOUzk7Ouswi/WtpbMv4f+xs5+4U09iaVjY+r7NhnrZku6X72tR93ETH5IiFQN
         JhZqj5lKH1NvP7ZpebGzDA5l/1vbCucWQh/TYp7RLkyn3kz5aDtyNySmSWZf/xMAWN
         JFPhluo1ms+my0qhIZ7N9kIQtsSbHzwIZUZzPUyY=
Received: from [192.168.0.117] (cpe-174-109-247-98.nc.res.rr.com [174.109.247.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: okaya@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6DCD36031A;
        Mon,  2 Jul 2018 20:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530564014;
        bh=qr2hkAkxy28+jjs5YpZlkpc3t0nMeQanF+TNnwnFI94=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=C0zhLOUzk7Ouswi/WtpbMv4f+xs5+4U09iaVjY+r7NhnrZku6X72tR93ETH5IiFQN
         JhZqj5lKH1NvP7ZpebGzDA5l/1vbCucWQh/TYp7RLkyn3kz5aDtyNySmSWZf/xMAWN
         JFPhluo1ms+my0qhIZ7N9kIQtsSbHzwIZUZzPUyY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6DCD36031A
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
Subject: Re: [PATCH V4 4/7] PCI: Unify try slot and bus reset API
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Peter Xu <peterx@redhat.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        "open list:HFI1 DRIVER" <linux-rdma@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:VFIO DRIVER" <kvm@vger.kernel.org>
References: <1530214274-21139-1-git-send-email-okaya@codeaurora.org>
 <1530214274-21139-4-git-send-email-okaya@codeaurora.org>
 <CAHp75VcYbeRTiggEiQnEV6DKR=F47RxNR0FZ+E-XKPpq8VNpqw@mail.gmail.com>
From:   Sinan Kaya <okaya@codeaurora.org>
Message-ID: <9674e845-765c-cc16-654e-21036038f2d5@codeaurora.org>
Date:   Mon, 2 Jul 2018 16:40:10 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VcYbeRTiggEiQnEV6DKR=F47RxNR0FZ+E-XKPpq8VNpqw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/29/2018 5:43 PM, Andy Shevchenko wrote:
>> +int pci_try_reset_bus(struct pci_dev *pdev)
>> +{
>> +       bool slot = false;
>> +
>> +       if (!pci_probe_reset_slot(pdev->slot))
>> +               slot = true;
>> +
>> +       return slot ? __pci_try_reset_slot(pdev->slot) :
>> +                       __pci_try_reset_bus(pdev->bus);
> This can be as simple as
> 
>   return pci_probe_reset_slot(pdev->slot) ?
>     __pci_try_reset_bus(pdev->slot) : __pci_try_reset_slot(pdev->bus);
> 
> 

done

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
