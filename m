Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D194FC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 13:38:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89271208E9
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 13:38:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="IZM6sgtg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89271208E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731168AbeHWRHx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 13:07:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:43440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731028AbeHWRHx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 13:07:53 -0400
Received: from localhost (173-25-171-118.client.mchsi.com [173.25.171.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D87F20837;
        Thu, 23 Aug 2018 13:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535031487;
        bh=sf8dFpHwUQ2c7joZvk7s57A8+J0HgP2Iv+GAKcK3oAg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IZM6sgtgayl+Yo+LKF3vxmw/kezjLG/z6CF4WjIAE0MGgmc8GvU/nrVnv4fEyFXFH
         pNZUfHdEyV5JXbosF8eygUqNerrFk/PJSmsnfagAGjIwqNPnUqEKaCoHMiC6hzry53
         po2VDUTVTWOiOUAGCaKkHSNEi1HuotEBK/iHPQTo=
Date:   Thu, 23 Aug 2018 08:38:05 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jian-Hong Pan <jian-hong@endlessm.com>
Cc:     Heiner Kallweit <hkallweit1@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        David Miller <davem@davemloft.net>,
        Realtek linux nic maintainers <nic_swsd@realtek.com>,
        netdev@vger.kernel.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>,
        linux-pci@vger.kernel.org, marc.zyngier@arm.com, hch@lst.de
Subject: Re: [PATCH] r8169: don't use MSI-X on RTL8106e
Message-ID: <20180823133805.GE154536@bhelgaas-glaptop.roam.corp.google.com>
References: <ac30d4e6-6411-09e6-1205-96e3e8e29f6f@gmail.com>
 <20180820184438.GA154536@bhelgaas-glaptop.roam.corp.google.com>
 <9d7d960a-6c55-dc4b-7969-f5cf46bff0ce@gmail.com>
 <20180821.123108.89921430801253333.davem@davemloft.net>
 <da97e198-7683-e0ff-92a9-3b1b22da3757@gmail.com>
 <alpine.DEB.2.21.1808221222260.2514@nanos.tec.linutronix.de>
 <36bd086d-8d26-5162-ae24-95b259571221@gmail.com>
 <CAPpJ_edz3H81EqRSg5jeOXoULt7AKwcTpNFL6Ntt8rhQBPFBFQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPpJ_edz3H81EqRSg5jeOXoULt7AKwcTpNFL6Ntt8rhQBPFBFQ@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 23, 2018 at 06:46:28PM +0800, Jian-Hong Pan wrote:
> > On 22.08.2018 13:44, Thomas Gleixner wrote:
> >> Can you please do the following:
> 
> Tested on ASUS X441AUR equipped with RTL8106e.
> This is the laptop whose ethernet does not come back after resume, if
> it does not fallback to MSI.
> ...

> dev@endless:~$ sudo lspci -xnnvvs 02:00.0
> ...
> 00: ec 10 36 81 07 04 10 00 07 00 00 02 10 00 00 00
> 10: 01 e0 00 00 00 00 00 00 04 00 10 ef 00 00 00 00
> 20: 0c 00 00 e0 00 00 00 00 00 00 00 00 43 10 0f 20
> 30: 00 00 00 00 40 00 00 00 00 00 00 00 ff 01 00 00
> 
> After comparing, there is no difference between before suspend and
> after resume.

It'd be better to compare the hex data directly and ignore the lspci
decoding, since lspci doesn't decode everything.  You only dumped the
first 0x40 bytes of config space, and all capabilities, including the
MSI and MSI-X capabilities, are past that:

> Capabilities: [50] MSI: Enable- Count=1/1 Maskable- 64bit+
> Capabilities: [b0] MSI-X: Enable+ Count=4 Masked-
> Vector table: BAR=4 offset=00000000
> PBA: BAR=4 offset=00000800

In addition, some of the MSI-X information for this device is in BAR
4.  "lspci -xxx" will dump all config space, and you can use a tool
like http://cmp.felk.cvut.cz/~pisa/linux/rdwrmem.c or
https://github.com/billfarrow/pcimem to dump the BAR contents.
