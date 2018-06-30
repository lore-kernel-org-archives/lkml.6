Return-Path: <SRS0=GJTC=JQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54FC9C3279B
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 14:08:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C16D1243A4
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 14:08:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C16D1243A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lxorguk.ukuu.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751114AbeF3OIQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Jun 2018 10:08:16 -0400
Received: from www.llwyncelyn.cymru ([82.70.14.225]:43020 "EHLO fuzix.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750802AbeF3OIP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jun 2018 10:08:15 -0400
Received: from alans-desktop (82-70-14-226.dsl.in-addr.zen.co.uk [82.70.14.226])
        by fuzix.org (8.15.2/8.15.2) with ESMTP id w5UE7kRD013933;
        Sat, 30 Jun 2018 15:07:47 +0100
Date:   Sat, 30 Jun 2018 15:07:46 +0100
From:   Alan Cox <gnomes@lxorguk.ukuu.org.uk>
To:     Simon Que <sque@chromium.org>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ben Chan <benchan@chromium.org>,
        Chun-Ta Lin <itspeter@chromium.org>,
        Zhongze Hu <frankhu@chromium.org>,
        Joe Perches <joe@perches.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>, linux-fpga@kernel.org
Subject: Re: [PATCH v7] drivers/staging: Gasket driver framework + Apex
 driver
Message-ID: <20180630150746.38d69e92@alans-desktop>
In-Reply-To: <20180630024938.107529-1-sque@chromium.org>
References: <20180630024938.107529-1-sque@chromium.org>
Organization: Intel Corporation
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The Gasket (Google ASIC Software, Kernel Extensions, and Tools) kernel
> framework is a generic, flexible system that supports thin kernel
> drivers. Gasket kernel drivers are expected to handle opening and
> closing devices, mmap'ing BAR space as requested, a small selection of
> ioctls, and handling page table translation (covered below). Any other
> functions should be handled by userspace code.

So it seems to me that we shouldn't have one random layer for Google
ASIC, another chunk of code for FPGA and so on. This all really ought to
be unified including where possible making things meaningfully self
describe.

You also don't seem to consider partitioning of an ASIC, eg if it
implements a serial port abstraction for debug that ought to routed to
the kernel, nor how to handle an ASIC that provides services to multiple
consumers ?

> One of the core assumptions of the Gasket framework is that precisely
> one process is allowed to have an open write handle to the device node
> at any given time. (That process may, once it has one write handle, open

Why ? That's a very un-Linuxlike and un-Unixlike model. It's more like
Windows and with all the problems we know that model causes.

> any number of additional write handles.) This is accomplished by
> tracking open and close data for each driver instance.

What if I want to have multiple threads not sharing an mm, or pass an
ASIC by handle to another instance - eg if I have a master process
assigning resources wanting to pass a handle into a container ?

And what about fd passing ?

It seems completely weird to try and do this given I can (given
permissions) equally just ptrace the person with it open and use ptrace
as a multiplexor ???


Also how about pointers to a real world use case example and user space ?

Alan
