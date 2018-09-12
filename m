Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43902C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 06:33:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1E0420880
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 06:33:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1E0420880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727384AbeILLgC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 07:36:02 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:42864 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725910AbeILLgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 07:36:02 -0400
Received: from p4fea45ac.dip0.t-ipconnect.de ([79.234.69.172] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fzyhu-0003NV-GA; Wed, 12 Sep 2018 08:32:58 +0200
Date:   Wed, 12 Sep 2018 08:32:58 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
cc:     jian-hong@endlessm.com, Linux Netdev List <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Regression caused by commit 7bb05b85bc2d ("r8169: don't use
 MSI-X on RTL8106e")
In-Reply-To: <5D685053-1A33-4553-8678-A50C542466FD@canonical.com>
Message-ID: <alpine.DEB.2.21.1809120826310.1427@nanos.tec.linutronix.de>
References: <5D685053-1A33-4553-8678-A50C542466FD@canonical.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Sep 2018, Kai-Heng Feng wrote:

> There's a Dell machine with RTL8106e stops to work after S3 since the
> commit introduced. So I am wondering if it's possible to revert the
> commit and use DMI/subsystem id based quirk table?

Probably.

> It's because of commit bc976233a872 ("genirq/msi, x86/vector: Prevent
> reservation mode for non maskable MSI") cleared the reservation mode, and I
> can see this after S3:
> 
> [   94.872838] do_IRQ: 3.33 No irq handler for vector

It's not because of that commit, really. There is a interrupt sent after
resume to the wrong vector for whatever reason. The MSI vector cannot be
masked it seems in the device, but the driver should quiescen the device to
a point where it does not send interrupts.

> If the device uses MSI-X instead of MSI, the issue doesn't happen because of
> reservation mode.

Reservation mode has absolutely nothing to do with that. What prevents the
issue is the fact that MSI-X can be masked by the IRQ core.

> Is it something should be handled by x86 BIOS? Because I don't see this issue
> when I use Suspend-to-Idle, which doesn't use BIOS to do suspend.

Suspend to idle works completely different and I don't see the BIOS at
fault here. it's more an issue of MSI not being maskable on that device,
which can't be fixed in BIOS or it's some half quiescened state which is
used when suspending and that's a pure driver issue.

Thanks,

	tglx
