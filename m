Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F142C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 14:46:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E97A821523
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 14:46:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E97A821523
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732579AbeHBQiC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 12:38:02 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60550 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732202AbeHBQiC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 12:38:02 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EF1DC818B107;
        Thu,  2 Aug 2018 14:46:29 +0000 (UTC)
Received: from redhat.com (unknown [10.20.6.215])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DB54F2026D69;
        Thu,  2 Aug 2018 14:46:28 +0000 (UTC)
Date:   Thu, 2 Aug 2018 10:46:27 -0400
From:   Jerome Glisse <jglisse@redhat.com>
To:     Alan Cox <gnomes@lxorguk.ukuu.org.uk>
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
Message-ID: <20180802144627.GB3481@redhat.com>
References: <20180801102221.5308-1-nek.in.cn@gmail.com>
 <20180801165644.GA3820@redhat.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D191290E1A@SHSMSX101.ccr.corp.intel.com>
 <20180802111000.4649d9ed@alans-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180802111000.4649d9ed@alans-desktop>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Thu, 02 Aug 2018 14:46:30 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Thu, 02 Aug 2018 14:46:30 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jglisse@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 02, 2018 at 11:10:00AM +0100, Alan Cox wrote:
> > One motivation I guess, is that most accelerators lack of a 
> > well-abstracted high level APIs similar to GPU side (e.g. OpenCL 
> > clearly defines Shared Virtual Memory models). VFIO mdev
> > might be an alternative common interface to enable SVA usages 
> > on various accelerators...
> 
> SVA is not IMHO the hard bit from a user level API perspective. The hard
> bit is describing what you have and enumerating the contents of the device
> especially when those can be quite dynamic and in the FPGA case can
> change on the fly.
> 
> Right now we've got
> - FPGA manager
> - Google's recently posted ASIC patches
> - WarpDrive
> 
> all trying to be bits of the same thing, and really there needs to be a
> single solution that handles all of this stuff properly.
> 
> If we are going to have any kind of general purpose accelerator API then
> it has to be able to implement things like

Why is the existing driver model not good enough ? So you want
a device with function X you look into /dev/X (for instance
for GPU you look in /dev/dri)

Each of those device need a userspace driver and thus this
user space driver can easily knows where to look. I do not
expect that every application will reimplement those drivers
but instead use some kind of library that provide a high
level API for each of those devices.

> 	'find me an accelerator with function X that is nearest my memory'
> 	'find me accelerator functions X and Y that share HBM'
> 	'find me accelerator functions X and Y than can be chained'
> 
> If instead we have three API's depending upon whose accelerator you are
> using and whether it's FPGA or ASIC this is going to be a mess on a grand
> scale.

I see the enumeration as an orthogonal problem. There have
been talks within various circles about it because new system
bus (CAPI, CCIX, ...) imply that things like NUMA topology
you have in sysfs is not up to the task.

Now you have a hierarchy of memory for the CPU (HBM, local
node main memory aka you DDR dimm, persistent memory) each
with different properties (bandwidth, latency, ...). But
also for devices memory. Some device can have many types
of memory too. For instance a GPU might have HBM, GDDR,
persistant and multiple types of memory. Those device are
on a given CPU node but can also have inter-connect of their
own (AMD infinity, NVlink, ...).


You have HMAT which i was hopping would provide a new sysfs
that supersede old numa but it seems it is going back to
NUMA node for compatibilities reasons i guess (ccing Ross).


Anyway i think finding devices and finding relation between
devices and memory is 2 separate problems and as such should
be handled separatly.


Cheers,
Jérôme
