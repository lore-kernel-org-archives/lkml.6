Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 340F8C43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 06:47:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 905F220846
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 06:47:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 905F220846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.ee
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932723AbeFUGrx convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 02:47:53 -0400
Received: from smtp1.it.da.ut.ee ([193.40.5.66]:49493 "EHLO smtp1.it.da.ut.ee"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932481AbeFUGrv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 02:47:51 -0400
Received: from math.ut.ee (unknown [IPv6:2001:bb8:2002:2400:5054:ff:fe3b:8db9])
        by smtp1.it.da.ut.ee (Postfix) with ESMTP id A97B79004A;
        Thu, 21 Jun 2018 09:47:49 +0300 (EEST)
Received: by math.ut.ee (Postfix, from userid 1014)
        id 91D42220109; Thu, 21 Jun 2018 09:47:47 +0300 (EEST)
Received: from localhost (localhost [127.0.0.1])
        by math.ut.ee (Postfix) with ESMTP id A2DBE220105;
        Thu, 21 Jun 2018 09:47:47 +0300 (EEST)
Date:   Thu, 21 Jun 2018 09:47:47 +0300 (EEST)
From:   Meelis Roos <mroos@linux.ee>
To:     Corey Minyard <minyard@acm.org>
cc:     Linux Kernel list <linux-kernel@vger.kernel.org>,
        openipmi-developer@lists.sourceforge.net,
        Corey Minyard <cminyard@mvista.com>
Subject: Re: [PATCH] ipmi: Cleanup oops on initialization failure
In-Reply-To: <7c9a293d-02e7-96c3-4760-f2d066e9dfd6@acm.org>
Message-ID: <alpine.LRH.2.21.1806210946020.20455@math.ut.ee>
References: <alpine.LRH.2.21.1806191553040.28622@math.ut.ee> <1529497606-3857-1-git-send-email-minyard@acm.org> <alpine.LRH.2.21.1806201725520.28187@math.ut.ee> <7c9a293d-02e7-96c3-4760-f2d066e9dfd6@acm.org>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > The corresponding dmesg:
> > 
> > [    7.372830] IPMI System Interface driver.
> > [    7.373034] ipmi_si dmi-ipmi-si.0: ipmi_platform: probing via SMBIOS
> > [    7.373109] ipmi_si: SMBIOS: mem 0x0 regsize 1 spacing 1 irq 0
> > [    7.373182] ipmi_si: Adding SMBIOS-specified kcs state machine
> > [    7.373352] ipmi_si: Trying SMBIOS-specified kcs state machine at mem
> > address 0x0, slave address 0x20, irq 0
> > [    7.373479] ipmi_si dmi-ipmi-si.0: Could not set up I/O space
> > 
> > > BTW, can you send me at least the IPMI portion of the output of
> > > dmidecode for your machine?  I have seen a lot of these where the
> > > address in the SMBIOS tables is incorrect, and I'm wondering if
> > > it's something in the driver, or if it's really the tables that
> > > are bad.
> > Handle 0x001B, DMI type 38, 18 bytes
> > IPMI Device Information
> >          Interface Type: KCS (Keyboard Control Style)
> >          Specification Version: 2.0
> >          I2C Slave Address: 0x10
> >          NV Storage Device: Not Present
> >          Base Address: 0x0000000000000000 (Memory-mapped)
> >          Register Spacing: Successive Byte Boundaries
> 
> Thanks a bunch.  It looks like the SMBIOS tables are wrong.  I
> wonder if this is what some vendor do if there is no IPMI device
> installed.  I guess I need to add a check for this.

Another machine (Sun X2100) with similar crash is also cured by the 
patch, but this is slightly different (not NULL):

[    8.891217] IPMI System Interface driver.
[    8.898404] ipmi_si dmi-ipmi-si.0: ipmi_platform: probing via SMBIOS
[    8.905635] ipmi_si: SMBIOS: io 0xca2 regsize 1 spacing 1 irq 0
[    8.912895] ipmi_si: Adding SMBIOS-specified kcs state machine
[    8.920246] ipmi_si: Trying SMBIOS-specified kcs state machine at i/o address 0xca2, slave address 0x20, irq 0
[    8.934379] ipmi_si dmi-ipmi-si.0: Interface detection failed

IPMI Device Information
        Interface Type: KCS (Keyboard Control Style)
        Specification Version: 1.5
        I2C Slave Address: 0x10
        NV Storage Device: Not Present
        Base Address: 0x0000000000000CA2 (I/O)
        Register Spacing: Successive Byte Boundaries



-- 
Meelis Roos (mroos@linux.ee)
