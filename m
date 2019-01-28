Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDFBDC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 13:55:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7DC721738
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 13:55:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbfA1NzH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 08:55:07 -0500
Received: from route-level1.fsdata.se ([89.221.252.216]:12205 "EHLO
        route-level1.fsdata.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbfA1NzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 08:55:06 -0500
Received: from DAG01.HMC.local (192.168.46.11) by EDGE01LEVEL1.hmc.local
 (192.168.46.33) with Microsoft SMTP Server (TLS) id 15.0.847.32; Mon, 28 Jan
 2019 14:54:41 +0100
Received: from localhost (94.234.46.36) by DAG01.HMC.local (192.168.46.11)
 with Microsoft SMTP Server (TLS) id 15.0.1263.5; Mon, 28 Jan 2019 14:54:43
 +0100
Date:   Mon, 28 Jan 2019 14:54:37 +0100
From:   Mattias Jacobsson <2pi@mok.nu>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        <2pi@mok.nu>
Subject: Re: [PATCH v2 1/3] platform/x86: wmi: move struct wmi_device_id to
 mod_devicetable.h
Message-ID: <20190128135437.qetbebros3xkayyn@mok.nu>
References: <cover.1548610407.git.2pi@mok.nu>
 <b40da7d75a8cf02f78db7896e07859e315477120.1548610407.git.2pi@mok.nu>
 <CAHp75Vdsr8aY1ODpZUqR--jAfgRowJz8tbSGwS1SFTH-W4u0XA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAHp75Vdsr8aY1ODpZUqR--jAfgRowJz8tbSGwS1SFTH-W4u0XA@mail.gmail.com>
X-Originating-IP: [94.234.46.36]
X-ClientProxiedBy: PROXY04.HMC.local (192.168.46.54) To DAG01.HMC.local
 (192.168.46.11)
Received-SPF: Neutral (EDGE01LEVEL1.hmc.local: 192.168.46.11 is neither
 permitted nor denied by domain of 2pi@mok.nu)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

Thanks for reviewing!

On 2019-01-27, Andy Shevchenko wrote:
> On Sun, Jan 27, 2019 at 9:04 PM Mattias Jacobsson <2pi@mok.nu> wrote:
> >
> > In preparation for adding WMI support to MODULE_DEVICE_TABLE() move the
> > definition of struct wmi_device_id to mod_devicetable.h and inline
> > guid_string in the struct.
> >
> > Changing guid_string to an inline char array changes the loop conditions
> > when looping over an array of struct wmi_device_id. Therefore update
> > wmi_dev_match()'s loop to check for an empty guid_string instead of a
> > NULL pointer.
> 
> Below some minor comments.
> 
> > -       while (id->guid_string) {
> > +       while (id->guid_string[0] != '\0') {
> 
> Hmm.. I would rather put it as
> 
> while (*id->guid_string) {

Sure.

> 
> > +#define WMI_MODULE_PREFIX      "wmi:"
> 
> > +#define WMI_GUID_STRING_LEN    36
> 
> Isn't this already defined in UUID namespace?
> (include/linux/uuid.h IIRC)  

Kind of, UUID_STRING_LEN is defined in uuid.h. It is included behind a
#ifdef __KERNEL__, but others seam to use things included through it so
I guess it is alright...

Let me know how you want it.

> 
> >  #include <linux/device.h>
> >  #include <linux/acpi.h>
> 
> > +#include <linux/mod_devicetable.h>
> 
> Not sure it's needed since acpi.h includes that.

It is included in acpi.h(behind CONFIG_ACPI), I thought it was cleaner
with it included explicitly. Plus that we aren't relying on others to
include it.

Let me know how you want it.

> 
> -- 
> With Best Regards,
> Andy Shevchenko

Thanks,
Mattias
