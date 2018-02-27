Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751799AbeB0Vd5 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 16:33:57 -0500
Received: from mga05.intel.com ([192.55.52.43]:30505 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751590AbeB0Vd4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 16:33:56 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,402,1515484800";
   d="scan'208";a="20656992"
Subject: Re: [RFC PATCH V2 13/22] x86/intel_rdt: Support schemata write -
 pseudo-locking core
From: Reinette Chatre <reinette.chatre@intel.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: fenghua.yu@intel.com, tony.luck@intel.com, gavin.hindman@intel.com,
        vikas.shivappa@linux.intel.com, dave.hansen@intel.com,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1518443616.git.reinette.chatre@intel.com>
 <dbf01ddf087e4597f86a85c1c91c1fc942e70269.1518443616.git.reinette.chatre@intel.com>
 <alpine.DEB.2.21.1802200059240.1853@nanos.tec.linutronix.de>
 <73fb98d2-ce93-0443-b909-fde75908cc1e@intel.com>
 <alpine.DEB.2.21.1802271109300.1886@nanos.tec.linutronix.de>
 <69ed85f2-b9c5-30d1-8437-45f20be3e95e@intel.com>
Message-ID: <16989547-8209-8428-80a2-910cf667885f@intel.com>
Date: Tue, 27 Feb 2018 13:33:55 -0800
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <69ed85f2-b9c5-30d1-8437-45f20be3e95e@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On 2/27/2018 11:52 AM, Reinette Chatre wrote:
> On 2/27/2018 2:36 AM, Thomas Gleixner wrote:
>> Let's assume its real,
>> so you could do the following:
>>
>> mkdir group		<- acquires closid
>> echo locksetup > mode	<- Creates 'lockarea' file
>> echo L2:0 > lockarea
>> echo 'L2:0=0xf' > schemata
>> echo locked > mode	<- locks down all files, does the lock setup
>>      	      		   and drops closid
>>
>> That would solve quite some of the other issues as well. Hmm?
> 
> At this time the resource group, represented by a resctrl directory, is
> tightly associated with the closid. I'll take a closer look at what it
> will take to separate them.
> 
> Could you please elaborate on the purpose of the "lockarea" file? It
> does seem to duplicate the information in the schemata written in the
> subsequent line.
> 
> If we do go this route then it seems that there would be one
> pseudo-locked region per resource group, not multiple ones as I had in
> my examples above.

Actually, this need not be true. It could be possible for administrator
to pseudo-lock two regions at once. For example,

mkdir group
echo locksetup > mode
echo 'L2:0=0xf;1=0xf' > schemata

This could have two pseudo-locked regions associated with a single
resource group. This does complicate the usage of the "size" file even
more though since the plan was to have a single "size" file associated
with a resource group it is not intuitive how it should describe
multiple pseudo-locked regions. I added the "size" file originally to
help users of the pseudo-locking interface where a single pseudo-locked
region existed in a directory. All information to compute the size
themselves are available to users, perhaps I can add pseudo-code to
compute the size from available information to the documentation?

Reinette
