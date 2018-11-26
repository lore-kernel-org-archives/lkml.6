Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FAD3C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 19:56:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AE1620664
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 19:56:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AE1620664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbeK0GwG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 01:52:06 -0500
Received: from mga09.intel.com ([134.134.136.24]:24371 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726251AbeK0GwG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 01:52:06 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Nov 2018 11:56:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,283,1539673200"; 
   d="scan'208";a="252898133"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by orsmga004.jf.intel.com with ESMTP; 26 Nov 2018 11:56:54 -0800
Date:   Mon, 26 Nov 2018 12:53:53 -0700
From:   Keith Busch <keith.busch@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Rafael Wysocki <rafael@kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>
Subject: Re: [PATCH 4/7] node: Add memory caching attributes
Message-ID: <20181126195352.GS26707@localhost.localdomain>
References: <20181114224921.12123-2-keith.busch@intel.com>
 <20181114224921.12123-5-keith.busch@intel.com>
 <20181126190619.GA32595@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181126190619.GA32595@kroah.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 11:06:19AM -0800, Greg Kroah-Hartman wrote:
> On Wed, Nov 14, 2018 at 03:49:17PM -0700, Keith Busch wrote:
> > System memory may have side caches to help improve access speed. While
> > the system provided cache is transparent to the software accessing
> > these memory ranges, applications can optimize their own access based
> > on cache attributes.
> > 
> > In preparation for such systems, provide a new API for the kernel to
> > register these memory side caches under the memory node that provides it.
> > 
> > The kernel's sysfs representation is modeled from the cpu cacheinfo
> > attributes, as seen from /sys/devices/system/cpu/cpuX/cache/. Unlike CPU
> > cacheinfo, though, a higher node's memory cache level is nearer to the
> > CPU, while lower levels are closer to the backing memory. Also unlike
> > CPU cache, the system handles flushing any dirty cached memory to the
> > last level the memory on a power failure if the range is persistent.
> > 
> > The exported attributes are the cache size, the line size, associativity,
> > and write back policy.
> > 
> > Signed-off-by: Keith Busch <keith.busch@intel.com>
> > ---
> >  drivers/base/node.c  | 117 +++++++++++++++++++++++++++++++++++++++++++++++++++
> >  include/linux/node.h |  23 ++++++++++
> >  2 files changed, 140 insertions(+)
> > 
> > diff --git a/drivers/base/node.c b/drivers/base/node.c
> > index 232535761998..bb94f1d18115 100644
> > --- a/drivers/base/node.c
> > +++ b/drivers/base/node.c
> > @@ -60,6 +60,12 @@ static DEVICE_ATTR(cpumap,  S_IRUGO, node_read_cpumask, NULL);
> >  static DEVICE_ATTR(cpulist, S_IRUGO, node_read_cpulist, NULL);
> >  
> >  #ifdef CONFIG_HMEM
> > +struct node_cache_obj {
> > +	struct kobject kobj;
> > +	struct list_head node;
> > +	struct node_cache_attrs cache_attrs;
> > +};
> 
> I know you all are off in the weeds designing some new crazy api for
> this instead of this current proposal (sorry, I lost the thread, I'll
> wait for the patches before commenting on it), but I do want to say one
> thing here.
> 
> NEVER use a raw kobject as a child for a 'struct device' unless you
> REALLY REALLY REALLY REALLY know what you are doing and have a VERY good
> reason to do so.
> 
> Just use a 'struct device', otherwise you end up having to reinvent all
> of the core logic that struct device provides you, like attribute
> callbacks (which you had to create), and other good stuff like telling
> userspace that a device has shown up so it knows to look at it.
> 
> That last one is key, a kobject is suddenly a "black hole" in sysfs as
> far as userspace knows because it does not see them for the most part
> (unless you are mucking around in the filesystem on your own, and
> really, don't do that, use a library like the rest of the world unless
> you really like reinventing everything, which, from your patchset it
> feels like...)
> 
> Anyway, use 'struct device'.  That's all.
> 
> greg k-h

Okay, thank you for the advice. I prefer to reuse over reinvent. :)

I only used kobject because the power/ directory was automatically
created with 'struct device', but I now I see there are better ways to
suppress that.
