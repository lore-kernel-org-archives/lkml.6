Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 929CCC004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 14:22:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DC21208AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 14:22:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="KDiePN7R";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="KDiePN7R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DC21208AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935747AbeFMOWK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 10:22:10 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:55484 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935662AbeFMOWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 10:22:08 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id C50AC6074D; Wed, 13 Jun 2018 14:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528899727;
        bh=pjCv40q3ZDtPwzyH7ejOam2wKPclgo2l8LO7NjP0EMM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=KDiePN7RydHW4rM3Ch9zrAMaknh92s1uDprKHUqo+43iM4R6x+4qSI8nBJsMg0xMT
         EKFvJFiA01RRDUtxBWNDPSrMn/E/+UfgKJGnhW4en0xMo0BfeZP6RUiztegrP3YdJl
         oq/k+v7ld5Q7z6P2w70Ffp1jlpyqkFiVLSVyb/1M=
Received: from [192.168.0.106] (cpe-174-109-247-98.nc.res.rr.com [174.109.247.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: okaya@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 15DC6600D0;
        Wed, 13 Jun 2018 14:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528899727;
        bh=pjCv40q3ZDtPwzyH7ejOam2wKPclgo2l8LO7NjP0EMM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=KDiePN7RydHW4rM3Ch9zrAMaknh92s1uDprKHUqo+43iM4R6x+4qSI8nBJsMg0xMT
         EKFvJFiA01RRDUtxBWNDPSrMn/E/+UfgKJGnhW4en0xMo0BfeZP6RUiztegrP3YdJl
         oq/k+v7ld5Q7z6P2w70Ffp1jlpyqkFiVLSVyb/1M=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 15DC6600D0
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
Subject: Re: [PATCH V2 2/2] efi/fb: Convert PCI bus address to resource if
 translated by the bridge
To:     linux-fbdev@vger.kernel.org, timur@codeaurora.org,
        ard.biesheuvel@linaro.org
Cc:     linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Peter Jones <pjones@redhat.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        "open list:FRAMEBUFFER LAYER" <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
References: <1526653072-7153-1-git-send-email-okaya@codeaurora.org>
 <1526653072-7153-2-git-send-email-okaya@codeaurora.org>
From:   Sinan Kaya <okaya@codeaurora.org>
Message-ID: <26470c5c-55db-9dff-3794-4e4a96c8bcb6@codeaurora.org>
Date:   Wed, 13 Jun 2018 10:22:04 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1526653072-7153-2-git-send-email-okaya@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ard,

On 5/18/2018 10:17 AM, Sinan Kaya wrote:
> A host bridge is allowed to remap BAR addresses using _TRA attribute in
> _CRS windows.
> 
> pci_bus 0000:00: root bus resource [mem 0x80100100000-0x8011fffffff window] (bus address [0x00100000-0x1fffffff])
> pci 0000:02:00.0: reg 0x10: [mem 0x8011e000000-0x8011effffff]
> 
> When a VGA device is behind such a host bridge and the resource is
> translated efifb driver is trying to do ioremap against bus address
> rather than the resource address and is failing to probe.
> 
> efifb: probing for efifb
> efifb: cannot reserve video memory at 0x1e000000
> efifb: framebuffer at 0x1e000000, using 1920k, total 1875k
> efifb: mode is 800x600x32, linelength=3200, pages=1
> efifb: scrolling: redraw
> efifb: Truecolor: size=8:8:8:8, shift=24:16:8:0
> 
> Use the host bridge offset information to convert bus address to
> resource address in the fixup.
> 
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> ---

I didn't see any messages about these getting picked up for 4.18.

Are they queued on your own branch?

Sinan

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
