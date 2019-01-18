Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B78DAC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 10:24:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86B252087E
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 10:24:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="kYZfn6ld";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="kYZfn6ld"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbfARKYk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 05:24:40 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:38028 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725983AbfARKYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 05:24:40 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id C392660585; Fri, 18 Jan 2019 10:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547807078;
        bh=inbUf2rQzWW+lxUgtiTxzNvPxjd2jbLX8rRSJp03ZEI=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=kYZfn6ldrO9XZ96OOJ1sOK1P5ZIRzbRez2oylv0CPrDsuEoUjQxYMx9NWfZfhZpVs
         jF4NKbPhO0Pw7H+CAI64++mQUiAZOQcwJpDd2VkePsOTSr32QIWHxFIOZuh0qTYRay
         T8u8yySW3x0mu+H8vJMaWJXUNaEltjGrtuhksGIc=
Received: from [10.79.129.0] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 011D26024C;
        Fri, 18 Jan 2019 10:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547807078;
        bh=inbUf2rQzWW+lxUgtiTxzNvPxjd2jbLX8rRSJp03ZEI=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=kYZfn6ldrO9XZ96OOJ1sOK1P5ZIRzbRez2oylv0CPrDsuEoUjQxYMx9NWfZfhZpVs
         jF4NKbPhO0Pw7H+CAI64++mQUiAZOQcwJpDd2VkePsOTSr32QIWHxFIOZuh0qTYRay
         T8u8yySW3x0mu+H8vJMaWJXUNaEltjGrtuhksGIc=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 011D26024C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=saiprakash.ranjan@codeaurora.org
Subject: Re: Need help: how to locate failure from irq_chip subsystem
To:     Pintu Agarwal <pintu.ping@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        linux-mm@kvack.org, linux-pm@vger.kernel.org,
        kernelnewbies@kernelnewbies.org
References: <CAOuPNLj4QzNDt0npZn2LhZTFgDNJ1CsWPw3=wvUuxnGtQW308g@mail.gmail.com>
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Message-ID: <bceb32be-d508-c2a4-fa81-ab8b90323d3f@codeaurora.org>
Date:   Fri, 18 Jan 2019 15:54:33 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAOuPNLj4QzNDt0npZn2LhZTFgDNJ1CsWPw3=wvUuxnGtQW308g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pintu-san,

On 1/18/2019 3:38 PM, Pintu Agarwal wrote:
> Hi All,
> 
> Currently, I am trying to debug a boot up crash on some qualcomm
> snapdragon arm64 board with kernel 4.9.
> I could find the cause of the failure, but I am unable to locate from
> which subsystem/drivers this is getting triggered.
> If you have any ideas or suggestions to locate the issue, please let me know.
> 
> This is the snapshot of crash logs:
> [    6.907065] Unable to handle kernel NULL pointer dereference at
> virtual address 00000000
> [    6.973938] PC is at 0x0
> [    6.976503] LR is at __ipipe_ack_fasteoi_irq+0x28/0x38
> [    7.151078] Process qmp_aop (pid: 24, stack limit = 0xfffffffbedc18000)
> [    7.242668] [<          (null)>]           (null)
> [    7.247416] [<ffffff9469f8d2e0>] __ipipe_dispatch_irq+0x78/0x340
> [    7.253469] [<ffffff9469e81564>] __ipipe_grab_irq+0x5c/0xd0
> [    7.341538] [<ffffff9469e81d68>] gic_handle_irq+0xc0/0x154
> 
> [    6.288581] [PINTU]: __ipipe_ack_fasteoi_irq - called
> [    6.293698] [PINTU]: __ipipe_ack_fasteoi_irq:
> desc->irq_data.chip->irq_hold is NULL
> 
> When I check, I found that the irq_hold implementation is missing in
> one of the irq_chip driver (expected by ipipe), which I am supposed to
> implement.
> 
> But I am unable to locate which irq_chip driver.
> If there are any good techniques to locate this in kernel, please help.
> 

Could you please tell which QCOM SoC this board is based on?

Thanks,
Sai

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
