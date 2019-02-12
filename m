Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8961C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 13:57:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DCB020821
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 13:57:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730039AbfBLN5A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 08:57:00 -0500
Received: from charybdis-ext.suse.de ([195.135.221.2]:12466 "EHLO suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727428AbfBLN47 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 08:56:59 -0500
Received: by suse.de (Postfix, from userid 1000)
        id 51A144241; Tue, 12 Feb 2019 14:56:58 +0100 (CET)
Date:   Tue, 12 Feb 2019 14:56:58 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Cc:     Jonathan Cameron <jonathan.cameron@huawei.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "mhocko@suse.com" <mhocko@suse.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "Pavel.Tatashin@microsoft.com" <Pavel.Tatashin@microsoft.com>,
        "david@redhat.com" <david@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dave.hansen@intel.com" <dave.hansen@intel.com>,
        Linuxarm <linuxarm@huawei.com>,
        Robin Murphy <robin.murphy@arm.com>
Subject: Re: [RFC PATCH v2 0/4] mm, memory_hotplug: allocate memmap from
 hotadded memory
Message-ID: <20190212135658.fd3rdil634ztpekj@d104.suse.de>
References: <20190122103708.11043-1-osalvador@suse.de>
 <20190212124707.000028ea@huawei.com>
 <5FC3163CFD30C246ABAA99954A238FA8392B5DB6@lhreml524-mbs.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5FC3163CFD30C246ABAA99954A238FA8392B5DB6@lhreml524-mbs.china.huawei.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 01:21:38PM +0000, Shameerali Kolothum Thodi wrote:
> > Hi Oscar,
> > 
> > I ran tests on one of our arm64 machines. Particular machine doesn't actually
> > have
> > the mechanics for hotplug, so was all 'faked', but software wise it's all the
> > same.
> > 
> > Upshot, seems to work as expected on arm64 as well.
> > Tested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Thanks Jonathan for having given it a spin, much appreciated!
I was short of arm64 machines.

> (qemu) object_add memory-backend-ram,id=mem1,size=1G
> (qemu) device_add pc-dimm,id=dimm1,memdev=mem1,node=1
> root@ubuntu:~# 
> root@ubuntu:~# numactl -H
...
> node 1 cpus:
> node 1 size: 1008 MB
> node 1 free: 1008 MB
> node distances:
> node   0   1 
>   0:  10  20 
>   1:  20  10 
> root@ubuntu:~#  

Ok, this is what I wanted to see.
When you hotplugged 1GB, 16MB out of 1024MB  were spent
for the memmap array, that is why you only see 1008MB there.

I am not sure what is the default section size for arm64, but assuming
is 128MB, that would make sense as 1GB would mean 8 sections,
and each section takes 2MB.

That means that at least the mechanism works.

> 
> FWIW,
> Tested-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>

thanks for having tested it ;-)!
-- 
Oscar Salvador
SUSE L3
