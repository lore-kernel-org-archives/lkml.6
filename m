Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932161AbeB0PjB (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 10:39:01 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:46486 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932115AbeB0PjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 10:39:00 -0500
Date: Tue, 27 Feb 2018 16:38:59 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Reinette Chatre <reinette.chatre@intel.com>
cc: fenghua.yu@intel.com, tony.luck@intel.com, gavin.hindman@intel.com,
        vikas.shivappa@linux.intel.com, dave.hansen@intel.com,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH V2 13/22] x86/intel_rdt: Support schemata write -
 pseudo-locking core
In-Reply-To: <alpine.DEB.2.21.1802271109300.1886@nanos.tec.linutronix.de>
Message-ID: <alpine.DEB.2.21.1802271553560.1886@nanos.tec.linutronix.de>
References: <cover.1518443616.git.reinette.chatre@intel.com> <dbf01ddf087e4597f86a85c1c91c1fc942e70269.1518443616.git.reinette.chatre@intel.com> <alpine.DEB.2.21.1802200059240.1853@nanos.tec.linutronix.de> <73fb98d2-ce93-0443-b909-fde75908cc1e@intel.com>
 <alpine.DEB.2.21.1802271109300.1886@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Feb 2018, Thomas Gleixner wrote:
> On Mon, 26 Feb 2018, Reinette Chatre wrote:
> > Moving to "exclusive" mode it appears that, when enabled for a resource
> > group, all domains of all resources are forced to have an "exclusive"
> > region associated with this resource group (closid). This is because the
> > schemata reflects the hardware settings of all resources and their
> > domains and the hardware does not accept a "zero" bitmask. A user thus
> > cannot just specify a single region of a particular cache instance as
> > "exclusive". Does this match your intention wrt "exclusive"?
> 
> Interesting question. I really did not think about that yet. 

Actually we could solve that problem similar to the locked one and share
most of the functionality:

mkdir group
echo exclusive > mode
echo L3:0 > restrict

and for locked:

mkdir group
echo locksetup > mode
echo L2:0 > restrict
echo 'L2:0=0xf' > schemata
echo locked > mode

The 'restrict' file (feel free to come up with a better name) is only
available/writeable in exclusive and locksetup mode. In case of exclusive
mode it can contain several domains/resources, but in locked mode its only
allowed to contain a single domain/resource.

A write to schemata for exclusive or locksetup mode will apply the
exclusiveness restrictions only to the resources/domains selected in the
'restrict' file. 

Thanks,

	tglx
