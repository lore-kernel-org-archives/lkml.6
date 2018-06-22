Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23BBFC43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 13:53:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D01822430B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 13:53:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ZPvoBQa/";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="exOfqTd6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D01822430B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932936AbeFVNxD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 09:53:03 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:59960 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751369AbeFVNxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 09:53:00 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 450456063F; Fri, 22 Jun 2018 13:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529675580;
        bh=COHpKdPgSpx45S3AcK+J5oM3sHLC+5QVC3waiGZ9imY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ZPvoBQa/p8v6MGluJHxzNrk9tm3ic97rXyEc9D2q6ArLPaGrbbR0aG893UbWLRuFV
         vBq8L0r9bGmLJJaaLoWLp87/PhZlCXiu12ztIPrTqGrNtlLBXRoYWjIHf/KqHKtw5b
         YlHZdK0+QyXxcxKwXk7HE8fPgX/V+kGAR8LgDfQ4=
Received: from [192.168.0.117] (cpe-174-109-247-98.nc.res.rr.com [174.109.247.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: okaya@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 59B3160264;
        Fri, 22 Jun 2018 13:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529675579;
        bh=COHpKdPgSpx45S3AcK+J5oM3sHLC+5QVC3waiGZ9imY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=exOfqTd6OOkwF9DtmTid2FdxdwkU4fF9U6gk2dbYPql7O+wTnS2lCMYbN+HGd2e9B
         EKfGkzIxuCN3IL17zB2lBcuBrZIEbURyZmSOj1/5oyBufm9sZvfo3ywhpNySk3CjRR
         cj4CO4/IthTVlbTOiUKzhBAeK07EytKp4mjLFKSQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 59B3160264
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
Subject: Re: [PATCH V2 2/2] efi/fb: Convert PCI bus address to resource if
 translated by the bridge
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     "open list:EFIFB FRAMEBUFFER DRIVER" <linux-fbdev@vger.kernel.org>,
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
From:   Sinan Kaya <okaya@codeaurora.org>
Message-ID: <2a805337-c0b5-e134-7695-5a543ecaa26a@codeaurora.org>
Date:   Fri, 22 Jun 2018 09:52:54 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu_voOZ7YUL8pckww4mTt4PVcu7y69mf-z7ZZe1bJ81Shw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ard,

On 6/22/2018 7:21 AM, Ard Biesheuvel wrote:
> Apologies for only bringing this up now, but I think this patch is
> wrong after all.
> 
> screen_info.lfb_base is supposed to be a CPU address, and so
> translating it like this is wrong. If you end up with a PCI address
> here, you have made a mistake in hacking support for PCI outbound
> translations into UEFI. Other users such as UEFI itself or GRUB will
> treat this as a CPU physical address as well, so the kernel should not
> treat it any differently.

The behavior I'm seeing is from a UEFI BIOS vendor. I did not write the
code for it...

I was asked to debug it.

I'd like to dive into your statement about UEFI and GRUB using this address
as physical addresses.

AFAIK, all PCI outbound requests go through PCI IO protocol in UEFI and the
translation information is hidden inside the UEFI PCI Host Bridge driver.
Drivers are not allowed to access PCI resources directly especially as a
memory mapped address.

This particular vendor is programming the BAR address into the GOP protocol.
Since the host bridge driver is doing a translation, we are hitting this
issue.

Is there a UEFI spec reference about the definition of this field?

Sinan

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
