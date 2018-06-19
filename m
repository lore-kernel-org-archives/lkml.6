Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 197B6C1B0F1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 22:15:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C55C020693
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 22:15:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="PedjQRDn";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="hDLC+qaH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C55C020693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935869AbeFSWPG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 18:15:06 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:50024 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755448AbeFSWO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 18:14:59 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E529560AD8; Tue, 19 Jun 2018 22:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529446499;
        bh=1Vjl39tLmeWbAQlnCL3SxfLl17ip8C8gZdW1QC7AxPM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=PedjQRDn7xr3zn09I2bMsfe/oYlv5us2TYtAaAqxUvRV2ynCZLUNxTYew7ML80YTy
         VpkXtarMU6Pg8I2h3Zt0svUKyUwQ51QvavRwDY9dw4j2DL6PtfNiaulVD/VHwviBAG
         NKXAv74QQK6sBVzVKMvI+hV4s3zG3OZ+9tbLPogI=
Received: from [192.168.0.106] (cpe-174-109-247-98.nc.res.rr.com [174.109.247.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: okaya@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CF30B60AD9;
        Tue, 19 Jun 2018 22:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529446498;
        bh=1Vjl39tLmeWbAQlnCL3SxfLl17ip8C8gZdW1QC7AxPM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=hDLC+qaHE8xhlzPO8zI70KSt0avo1vn1tuTd4dy4OQf1YnJtrY1UGfdzcukztOZQQ
         t7Mm7dN45sGgPnMwT45ADcQX7nt0yr3/CTDLC6VpEejd4XHOvrcOxK0ht0Pg1TDFmO
         LBUM0WPGsOZm4k2l64mNKOtH2w0jw2ZFtFeEhrmo=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CF30B60AD9
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
Subject: Re: [PATCH] efi/fb: Convert PCI bus address to resource if translated
 by the bridge
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Robin Murphy <robin.murphy@arm.com>, linux-pci@vger.kernel.org,
        timur@codeaurora.org, ard.biesheuvel@linaro.org,
        "open list:EFIFB FRAMEBUFFER DRIVER" <linux-fbdev@vger.kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-arm-msm@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        "open list:FRAMEBUFFER LAYER" <dri-devel@lists.freedesktop.org>,
        Peter Jones <pjones@redhat.com>,
        linux-arm-kernel@lists.infradead.org
References: <1526563343-28721-1-git-send-email-okaya@codeaurora.org>
 <36cf3f12-bfe8-1c38-4d2c-b785fc64a3f6@arm.com>
 <733101d0-9051-a5a6-ef64-162d8d1e10a1@codeaurora.org>
 <20180619215955.GF33049@bhelgaas-glaptop.roam.corp.google.com>
From:   Sinan Kaya <okaya@codeaurora.org>
Message-ID: <61384244-49f9-2020-04f0-6e188cf6a6b7@codeaurora.org>
Date:   Tue, 19 Jun 2018 18:14:55 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180619215955.GF33049@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

On 6/19/2018 5:59 PM, Bjorn Helgaas wrote:
> On Fri, May 18, 2018 at 10:20:29AM -0400, Sinan Kaya wrote:
>> On 5/18/2018 6:42 AM, Robin Murphy wrote:
>>>
>>> FWIW, now that I've actually gone and looked, it appears you could simplify the whole function quite a bit by getting rid of these and just using the new local resource directly, especially since the only actual use of size is an open-coded resource_contains().
>>
>> Posted V2 a minute ago. I did the simplification on a prior patch in order not to
>> mix the issues.
> 
> I don't see the V2 on linux-pci, but it sounds like Ard would merge this
> anyway.  So I'll drop this and you can let me know if there's anything you
> need from me.
> 

It is planned to go through fbdev tree for 4.19. 

https://patchwork.kernel.org/patch/10410895/

Feel free to review/ACK.

Sinan

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
