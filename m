Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1FC7C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 17:28:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55DB525F3D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 17:28:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Y6vcJavF";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Y6vcJavF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55DB525F3D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934740AbeFYR2T (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 13:28:19 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:59520 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933920AbeFYR2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 13:28:17 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 9AA4260213; Mon, 25 Jun 2018 17:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529947696;
        bh=lJ0gdfrAvKadxBFsRoWdZYWzC71hXZ67L6wDQiXsagM=;
        h=Subject:From:To:Cc:References:Date:In-Reply-To:From;
        b=Y6vcJavFqndyUpBa4VVxcieEQNW9vOIFunmeyupwzuAp1hqUcaTGp5TbzjOjMlbFV
         TAJ8TCTtGMp84qgLhVhWxZbl1P2latlEmgRDi3kh7FpujiYLD4Ai7pNv+UTHNbf2U5
         PeZZ3Z40NR+/tAMRLTim1ovnxwUJsijZBPx9yAJY=
Received: from [10.235.228.150] (global_nat1_iad_fw.qualcomm.com [129.46.232.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: okaya@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4C06360131;
        Mon, 25 Jun 2018 17:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529947696;
        bh=lJ0gdfrAvKadxBFsRoWdZYWzC71hXZ67L6wDQiXsagM=;
        h=Subject:From:To:Cc:References:Date:In-Reply-To:From;
        b=Y6vcJavFqndyUpBa4VVxcieEQNW9vOIFunmeyupwzuAp1hqUcaTGp5TbzjOjMlbFV
         TAJ8TCTtGMp84qgLhVhWxZbl1P2latlEmgRDi3kh7FpujiYLD4Ai7pNv+UTHNbf2U5
         PeZZ3Z40NR+/tAMRLTim1ovnxwUJsijZBPx9yAJY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4C06360131
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
Subject: Re: [PATCH V2 2/2] efi/fb: Convert PCI bus address to resource if
 translated by the bridge
From:   Sinan Kaya <okaya@codeaurora.org>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        "open list:EFIFB FRAMEBUFFER DRIVER" <linux-fbdev@vger.kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-arm-msm@vger.kernel.org, Timur Tabi <timur@codeaurora.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:FRAMEBUFFER LAYER" <dri-devel@lists.freedesktop.org>,
        Peter Jones <pjones@redhat.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
References: <1526653072-7153-1-git-send-email-okaya@codeaurora.org>
 <1526653072-7153-2-git-send-email-okaya@codeaurora.org>
 <20180619222921.GA90490@bhelgaas-glaptop.roam.corp.google.com>
 <CAKv+Gu_voOZ7YUL8pckww4mTt4PVcu7y69mf-z7ZZe1bJ81Shw@mail.gmail.com>
 <2a805337-c0b5-e134-7695-5a543ecaa26a@codeaurora.org>
 <CAKv+Gu9HAJRHwjYLNjf+gg=1vFoFu3BJphifKKE-aR4o_MW84A@mail.gmail.com>
 <CAKv+Gu-WXLXqHSmiS2MmAMXHLKK_kg+3EK6L2rvO0SzN-c0UMg@mail.gmail.com>
 <37289a27-eb99-6a73-4d32-4a75edd11dcd@codeaurora.org>
 <CAKv+Gu-bwCFhCKiA7P1amMLeBaSxsjk0d6aPjAr9nCvOBPJA6w@mail.gmail.com>
 <CAKv+Gu96HQf0oJ1RC+wVU34FqqcCWrnDGag48vjNP_z86HhLBQ@mail.gmail.com>
 <7777f7bfead902f2f5175d48907fccec@codeaurora.org>
Message-ID: <eb16a77f-7950-7fa1-c436-0ce99a992d3b@codeaurora.org>
Date:   Mon, 25 Jun 2018 13:28:14 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <7777f7bfead902f2f5175d48907fccec@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/25/2018 11:52 AM, okaya@codeaurora.org wrote:
>> Note that this is not the only MMIO translation related change made by
>> Heyi Guo to the generic PCI host bridge and bus drivers, but given
>> that those did not support MMIO translation at all, I take it your
>> affected platforms will already have their own changes to accommodate
>> this.
> 
> Platform has been doing mmio translation for quite a while. Because all accesses go through pci io protocol, the rest of the UEFI never needed to be aware of bar address or do direct access.
> 
> This is the first time I hear of direct access. Maybe, GOP is a special case.
> 
> I started copying your response to the bios vendor.
> 
> They are probably missing that patch. I will pass it along.

I was informed that they fixed the issue in BIOS by presenting CPU physical
address instead of PCI bus address in FrameBufferBase of the AST GOP UEFI driver.

We can drop this patch now.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
