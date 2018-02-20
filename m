Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932512AbeBTDVr (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 22:21:47 -0500
Received: from mga11.intel.com ([192.55.52.93]:46079 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932370AbeBTDVq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 22:21:46 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,537,1511856000";
   d="scan'208";a="19347110"
Subject: Re: [RFC PATCH V2 06/22] x86/intel_rdt: Create pseudo-locked regions
To: Thomas Gleixner <tglx@linutronix.de>
Cc: fenghua.yu@intel.com, tony.luck@intel.com, gavin.hindman@intel.com,
        vikas.shivappa@linux.intel.com, dave.hansen@intel.com,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1518443616.git.reinette.chatre@intel.com>
 <17cceeb077f3ac5f50b110285b36905091a345b0.1518443616.git.reinette.chatre@intel.com>
 <alpine.DEB.2.21.1802192138140.1853@nanos.tec.linutronix.de>
 <97148038-6af3-aa49-d5ac-35741867dd29@intel.com>
 <alpine.DEB.2.21.1802200012030.1853@nanos.tec.linutronix.de>
From: Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <d6345cf7-159b-ab90-2df4-1a998358a710@intel.com>
Date: Mon, 19 Feb 2018 19:21:44 -0800
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1802200012030.1853@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On 2/19/2018 3:16 PM, Thomas Gleixner wrote:
> On Mon, 19 Feb 2018, Reinette Chatre wrote:
>> On 2/19/2018 12:57 PM, Thomas Gleixner wrote:
>>> On Tue, 13 Feb 2018, Reinette Chatre wrote:
>>>
>>>> System administrator creates/removes pseudo-locked regions by
>>>> creating/removing directories in the pseudo-lock subdirectory of the
>>>> resctrl filesystem. Here we add directory creation and removal support.
>>>>
>>>> A "pseudo-lock region" is introduced, which represents an
>>>> instance of a pseudo-locked cache region. During mkdir a new region is
>>>> created but since we do not know which cache it belongs to at that time
>>>> we maintain a global pointer to it from where it will be moved to the cache
>>>> (rdt_domain) it belongs to after initialization. This implies that
>>>> we only support one uninitialized pseudo-locked region at a time.
>>>
>>> Whats the reason for this restriction? If there are uninitialized
>>> directories, so what?
>>
>> I was thinking about a problematic scenario where an application
>> attempts to create infinite directories. All of these uninitialized
>> directories need to be kept track of before they are initialized as
>> pseudo-locked regions. It seemed simpler to require that one
>> pseudo-locked region is set up at a time.
> 
> If the application is allowed to create directories then it can also create
> a dozen unused resource control groups. This is not a Joe User operation so
> there is no problem.

Thank you for the guidance. I will remove this restriction.

>>>> +/*
>>>> + * rdt_pseudo_lock_rmdir - Remove pseudo-lock region
>>>> + *
>>>> + * LOCKING:
>>>> + * Since the pseudo-locked region can be associated with a RDT domain at
>>>> + * removal we take both rdtgroup_mutex and rdt_pseudo_lock_mutex to protect
>>>> + * the rdt_domain access as well as the pseudo_lock_region access.
>>>
>>> Is there a real reason / benefit for having this second mutex?
>>
>> Some interactions with the pseudo-locked region are currently done
>> without the need for the rdtgroup_mutex. For example, interaction with
>> the character device associated with the pseudo-locked region (the
>> mmap() call) as well as the debugfs operations.
> 
> Well, yes. But none of those operations are hot path so having the double
> locking in lots of the other function is just extra complexity for no real
> value.

I will revise.

Thank you very much.

Reinette
