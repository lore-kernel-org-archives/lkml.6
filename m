Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8A21C67879
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 17:09:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DDB92077C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 17:09:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DDB92077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lxorguk.ukuu.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727469AbeJMAmh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 20:42:37 -0400
Received: from www.llwyncelyn.cymru ([82.70.14.225]:50736 "EHLO fuzix.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725854AbeJMAmg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 20:42:36 -0400
Received: from alans-desktop (82-70-14-226.dsl.in-addr.zen.co.uk [82.70.14.226])
        by fuzix.org (8.15.2/8.15.2) with ESMTP id w9CH8LrL031467;
        Fri, 12 Oct 2018 18:08:22 +0100
Date:   Fri, 12 Oct 2018 18:08:21 +0100
From:   Alan Cox <gnomes@lxorguk.ukuu.org.uk>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, linux-i2c@vger.kernel.org,
        linux-acpi@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] x86: baytrail/cherrytrail: Rework and move
 P-Unit PMIC bus semaphore code
Message-ID: <20181012180821.602abd04@alans-desktop>
In-Reply-To: <34244947-6b73-55c2-a0e8-b6a66050a612@redhat.com>
References: <20181011142911.13750-1-hdegoede@redhat.com>
        <20181011142911.13750-2-hdegoede@redhat.com>
        <20181011213508.40b8ce0e@alans-desktop>
        <34244947-6b73-55c2-a0e8-b6a66050a612@redhat.com>
Organization: Intel Corporation
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > It should be.  
> 
> You mean that the problem should be purely academic, IOW that registers touched
> by the P-Unit are never touched through ACPI Opregions / power-resources?

As far as I am aware. Holding the lock over both is definitely better
regardless

> >> 2) To safely access the shared I2C bus, we need to do 3 things:
> >> a) Notify the GPU driver that we are starting a window in which it may not
> >> access the P-Unit, since the P-Unit seems to ignore the semaphore for
> >> explicit power-level requests made by the GPU driver  
> > 
> > That's not what happens. It's more a problem of
> > 
> > We take the SEM
> > The GPU driver pokes the GPU
> > The GPU decides it wants to change the power situation
> > The GPU asks
> > It blocks on the SEM
> > 
> > and the system deadlocks.  
> 
> That may be, but why does it deadlock?

As I understand it because the CPU is stuck waiting for the GPU which is
waiting for the SEM which the CPU is holding. This isn't purely software
remember.

> I can understand that you are reluctant to change this code, but this
> commit is not changing the logic, it mostly just moves the code around
> and I do believe that overall doing this is worthwhile.

Fair enough

Alan
