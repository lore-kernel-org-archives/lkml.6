Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F9E8C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 14:21:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43C5121771
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 14:21:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43C5121771
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lxorguk.ukuu.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732356AbeHCQSC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 12:18:02 -0400
Received: from www.llwyncelyn.cymru ([82.70.14.225]:53020 "EHLO fuzix.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732074AbeHCQSC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 12:18:02 -0400
Received: from alans-desktop (82-70-14-226.dsl.in-addr.zen.co.uk [82.70.14.226])
        by fuzix.org (8.15.2/8.15.2) with ESMTP id w73EKh5P020485;
        Fri, 3 Aug 2018 15:20:43 +0100
Date:   Fri, 3 Aug 2018 15:20:43 +0100
From:   Alan Cox <gnomes@lxorguk.ukuu.org.uk>
To:     Jerome Glisse <jglisse@redhat.com>
Cc:     "Tian, Kevin" <kevin.tian@intel.com>,
        Kenneth Lee <nek.in.cn@gmail.com>,
        Hao Fang <fanghao11@huawei.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxarm@huawei.com" <linuxarm@huawei.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Zaibo Xu <xuzaibo@huawei.com>,
        Kenneth Lee <liguozhu@hisilicon.com>,
        "David S . Miller" <davem@davemloft.net>,
        Ross Zwisler <ross.zwisler@linux.intel.com>
Subject: Re: [RFC PATCH 0/7] A General Accelerator Framework, WarpDrive
Message-ID: <20180803152043.40f88947@alans-desktop>
In-Reply-To: <20180802144627.GB3481@redhat.com>
References: <20180801102221.5308-1-nek.in.cn@gmail.com>
        <20180801165644.GA3820@redhat.com>
        <AADFC41AFE54684AB9EE6CBC0274A5D191290E1A@SHSMSX101.ccr.corp.intel.com>
        <20180802111000.4649d9ed@alans-desktop>
        <20180802144627.GB3481@redhat.com>
Organization: Intel Corporation
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> If we are going to have any kind of general purpose accelerator API then
> > it has to be able to implement things like  
> 
> Why is the existing driver model not good enough ? So you want
> a device with function X you look into /dev/X (for instance
> for GPU you look in /dev/dri)

Except when my GPU is in an FPGA in which case it might be somewhere else
or it's a general purpose accelerator that happens to be usable as a GPU.
Unusual today in big computer space but you'll find it in
microcontrollers.

> Each of those device need a userspace driver and thus this
> user space driver can easily knows where to look. I do not
> expect that every application will reimplement those drivers
> but instead use some kind of library that provide a high
> level API for each of those devices.

Think about it from the user level. You have a pipeline of things you
wish to execute, you need to get the right accelerator combinations and
they need to fit together to meet system constraints like number of
IOMMU ids the accelerator supports, where they are connected.

> Now you have a hierarchy of memory for the CPU (HBM, local
> node main memory aka you DDR dimm, persistent memory) each

It's not a heirarchy, it's a graph. There's no fundamental reason two
accelerators can't be close to two different CPU cores but have shared
HBM that is far from each processor. There are physical reasons it tends
to look more like a heirarchy today.

> Anyway i think finding devices and finding relation between
> devices and memory is 2 separate problems and as such should
> be handled separatly.

At a certain level they are deeply intertwined because you need a common
API. It's not good if I want a particular accelerator and need to then
see which API its under on this machine and which interface I have to
use, and maybe have a mix of FPGA, WarpDrive and Google ASIC interfaces
all different.

The job of the kernel is to impose some kind of sanity and unity on this
lot.

All of it in the end comes down to

'Somehow glue some chunk of memory into my address space and find any
supporting driver I need'

plus virtualization of the above.

That bit's easy - but making it usable is a different story.

Alan
