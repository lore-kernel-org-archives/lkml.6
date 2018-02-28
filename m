Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933016AbeB1Se4 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 13:34:56 -0500
Received: from mga14.intel.com ([192.55.52.115]:27616 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932651AbeB1Sey (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 13:34:54 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,406,1515484800";
   d="scan'208";a="207738152"
Subject: Re: [RFC PATCH V2 13/22] x86/intel_rdt: Support schemata write -
 pseudo-locking core
To: Thomas Gleixner <tglx@linutronix.de>
Cc: fenghua.yu@intel.com, tony.luck@intel.com, gavin.hindman@intel.com,
        vikas.shivappa@linux.intel.com, dave.hansen@intel.com,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1518443616.git.reinette.chatre@intel.com>
 <dbf01ddf087e4597f86a85c1c91c1fc942e70269.1518443616.git.reinette.chatre@intel.com>
 <alpine.DEB.2.21.1802200059240.1853@nanos.tec.linutronix.de>
 <85c96e41-5a54-d3dd-bda4-d8ef9c28b1d8@intel.com>
 <alpine.DEB.2.21.1802281819390.1392@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1802281858420.1392@nanos.tec.linutronix.de>
From: Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <057523c7-5192-9a29-ca04-a8b299ef9685@intel.com>
Date: Wed, 28 Feb 2018 10:34:53 -0800
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1802281858420.1392@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On 2/28/2018 9:59 AM, Thomas Gleixner wrote:
> On Wed, 28 Feb 2018, Thomas Gleixner wrote:
>> On Tue, 27 Feb 2018, Reinette Chatre wrote:
>>> On 2/20/2018 9:15 AM, Thomas Gleixner wrote:
>>>> Let's look at the existing crtl/mon groups which are each represented by a
>>>> directory already.
>>>>
>>>>  - Adding a 'size' file to the ctrl groups would be a natural extension
>>>>    which makes sense for regular cache allocations as well.
>>>>
>>>
>>> I would like to clarify how you envision the value of "size" computed. A
>>> resource group may have several resources associated with it. Some of
>>> these resources may indeed overlap, for example, if there is L2 and L3
>>> CAT capable resources on the system. Similarly when CDP is enabled,
>>> there would be overlap in bitmasks referring to the same cache locations
>>> but treated as different resources. Indeed, there may in the future be
>>> some resources that are capable of allocation but not cache specifically
>>> that could also be handled within a single resource group.
>>>
>>> Summarizing all of these cases with a single "size" associated with the
>>> resource group does not seem straightforward to me.
>>
>> We have the schemata file which covers everthing. So the size file inside a
>> resource group should show the sizes for each domain/resource as well.
>>
>> L2:0=128K;1=256K;
>> L3:0=1M;1=2M;
>>
>> L3DATA:0=128K
>> L3CODE:0=128K
>>
>> or such. That would be consistent with the schemata file. If there are
>> resources which cannot be expressed in size, like MBA then you simply do
>> not print them.
>>
>> At the top level you want to show the inuse areas. I'd go for straight
>> bitmap display there:
>>
>> L2:0=00011100;1=11111111;
>> L3:0=11001100;1=11111111;
>>
>> If L3 CDP is enabled then you can show:
>>
>> L3:0=1DCCDC00;1=DDDD00CC;
>>
>> where:
>>
>> 0 = unused
>> 1 = overlapping C/D
>> C = code
>> D = data
> 
> Hit send too early....
> 
> For the locked case this would add:
> 
>  L = locked

I hesitated doing something like this because during the review of this
series there was resistance to using sysfs files for multiple values. I
will proceed with your suggestion noting that it is tied with schemata file.

I do not think we need these special labels for CDP though. From what I
understand when CDP is enabled there will be two new resources in the
info directory. For example,

info/L3DATA/
info/L3CODE/

Each would have its own file(s) noting which bits are in use.

At this time I am also not enabling pseudo-locking when CDP is enabled
so the locked label is not needed.

There is already the file "shareable_bits" in the info directory
associated with each resource. At the moment it only reflects the bits
that could be used by other entities on the system. Considering its name
and us now introducing the idea of "shareable" I was thinking of adding
all "shareable" bits (hardware and software) of this resource to this
file. This still leaves the new "inuse_bits" (or perhaps "unused_bits")
info file that will communicate the "exclusive" and "locked" bits in
addition so what is in "shareable_bits". Between these two files users
should have information needed to choose regions for their tasks. These
would all use bitmap displays.

Thank you very much

Reinette
