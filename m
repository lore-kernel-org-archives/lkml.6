Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934319AbeB1R6I (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 12:58:08 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:49207 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932938AbeB1R6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 12:58:04 -0500
Date: Wed, 28 Feb 2018 18:57:52 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Reinette Chatre <reinette.chatre@intel.com>
cc: fenghua.yu@intel.com, tony.luck@intel.com, gavin.hindman@intel.com,
        vikas.shivappa@linux.intel.com, dave.hansen@intel.com,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH V2 13/22] x86/intel_rdt: Support schemata write -
 pseudo-locking core
In-Reply-To: <85c96e41-5a54-d3dd-bda4-d8ef9c28b1d8@intel.com>
Message-ID: <alpine.DEB.2.21.1802281819390.1392@nanos.tec.linutronix.de>
References: <cover.1518443616.git.reinette.chatre@intel.com> <dbf01ddf087e4597f86a85c1c91c1fc942e70269.1518443616.git.reinette.chatre@intel.com> <alpine.DEB.2.21.1802200059240.1853@nanos.tec.linutronix.de> <85c96e41-5a54-d3dd-bda4-d8ef9c28b1d8@intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Feb 2018, Reinette Chatre wrote:
> On 2/20/2018 9:15 AM, Thomas Gleixner wrote:
> > Let's look at the existing crtl/mon groups which are each represented by a
> > directory already.
> > 
> >  - Adding a 'size' file to the ctrl groups would be a natural extension
> >    which makes sense for regular cache allocations as well.
> > 
> 
> I would like to clarify how you envision the value of "size" computed. A
> resource group may have several resources associated with it. Some of
> these resources may indeed overlap, for example, if there is L2 and L3
> CAT capable resources on the system. Similarly when CDP is enabled,
> there would be overlap in bitmasks referring to the same cache locations
> but treated as different resources. Indeed, there may in the future be
> some resources that are capable of allocation but not cache specifically
> that could also be handled within a single resource group.
> 
> Summarizing all of these cases with a single "size" associated with the
> resource group does not seem straightforward to me.

We have the schemata file which covers everthing. So the size file inside a
resource group should show the sizes for each domain/resource as well.

L2:0=128K;1=256K;
L3:0=1M;1=2M;

L3DATA:0=128K
L3CODE:0=128K

or such. That would be consistent with the schemata file. If there are
resources which cannot be expressed in size, like MBA then you simply do
not print them.

At the top level you want to show the inuse areas. I'd go for straight
bitmap display there:

L2:0=00011100;1=11111111;
L3:0=11001100;1=11111111;

If L3 CDP is enabled then you can show:

L3:0=1DCCDC00;1=DDDD00CC;

where:

0 = unused
1 = overlapping C/D
C = code
D = data

Hmm?

Thanks,

	tglx
