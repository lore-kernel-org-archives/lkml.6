Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38E3BC677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 20:35:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEE1220644
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 20:35:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEE1220644
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lxorguk.ukuu.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726136AbeJLEEP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 00:04:15 -0400
Received: from www.llwyncelyn.cymru ([82.70.14.225]:45506 "EHLO fuzix.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725781AbeJLEEP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 00:04:15 -0400
Received: from alans-desktop (82-70-14-226.dsl.in-addr.zen.co.uk [82.70.14.226])
        by fuzix.org (8.15.2/8.15.2) with ESMTP id w9BKZ9Qc004192;
        Thu, 11 Oct 2018 21:35:09 +0100
Date:   Thu, 11 Oct 2018 21:35:08 +0100
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
Message-ID: <20181011213508.40b8ce0e@alans-desktop>
In-Reply-To: <20181011142911.13750-2-hdegoede@redhat.com>
References: <20181011142911.13750-1-hdegoede@redhat.com>
        <20181011142911.13750-2-hdegoede@redhat.com>
Organization: Intel Corporation
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> 1) PMIC accesses often come in the form of a read-modify-write on one of
> the PMIC registers, we currently release the P-Unit's PMIC bus semaphore
> between the read and the write. If the P-Unit modifies the register during
> this window?, then we end up overwriting the P-Unit's changes.
> I believe that this is mostly an academic problem, but I'm not sure.

It should be.

> 2) To safely access the shared I2C bus, we need to do 3 things:
> a) Notify the GPU driver that we are starting a window in which it may not
> access the P-Unit, since the P-Unit seems to ignore the semaphore for
> explicit power-level requests made by the GPU driver

That's not what happens. It's more a problem of

We take the SEM
The GPU driver pokes the GPU
The GPU decides it wants to change the power situation
The GPU asks
It blocks on the SEM

and the system deadlocks.

> b) Make a pm_qos request to force all CPU cores out of C6/C7 since entering
> C6/C7 while we hold the semaphore hangs the SoC

Not just C6/C7 necessarily. We need to stop assorted transitions.

Given how horrible this lot was to debug originally do you have any
meaningful test data and performance numbers to justify it ? As an ahem
'feature' it's gone away in modern chips so is it worth the attention ?

Alan
