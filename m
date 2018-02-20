Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932483AbeBTDRE (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 22:17:04 -0500
Received: from mga09.intel.com ([134.134.136.24]:40358 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932352AbeBTDRD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 22:17:03 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,537,1511856000";
   d="scan'208";a="19346594"
Subject: Re: [RFC PATCH V2 11/22] x86/intel_rdt: Associate pseudo-locked
 regions with its domain
To: Thomas Gleixner <tglx@linutronix.de>
Cc: fenghua.yu@intel.com, tony.luck@intel.com, gavin.hindman@intel.com,
        vikas.shivappa@linux.intel.com, dave.hansen@intel.com,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1518443616.git.reinette.chatre@intel.com>
 <216ad1ef8314dc578a900ff8b06248464f5aa2ee.1518443616.git.reinette.chatre@intel.com>
 <alpine.DEB.2.21.1802192218370.1853@nanos.tec.linutronix.de>
 <7bd1f8e8-116f-bdb2-23d2-a94f9a21e028@intel.com>
 <alpine.DEB.2.21.1802200017130.1853@nanos.tec.linutronix.de>
From: Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <0efce774-57a8-40fa-7b8a-6e57e496bb37@intel.com>
Date: Mon, 19 Feb 2018 19:17:01 -0800
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1802200017130.1853@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On 2/19/2018 3:19 PM, Thomas Gleixner wrote:
> On Mon, 19 Feb 2018, Reinette Chatre wrote:
>> On 2/19/2018 1:19 PM, Thomas Gleixner wrote:
>>> On Tue, 13 Feb 2018, Reinette Chatre wrote:
>>>
>>>> After a pseudo-locked region is locked it needs to be associated with
>>>> the RDT domain representing the pseudo-locked cache so that its life
>>>> cycle can be managed correctly.
>>>>
>>>> Only a single pseudo-locked region can exist on any cache instance so we
>>>> maintain a single pointer to a pseudo-locked region from each RDT
>>>> domain.
>>>
>>> Why is only a single pseudo locked region possible? 
>>
>> The setup of a pseudo-locked region requires the usage of wbinvd. If a
>> second pseudo-locked region is thus attempted it will evict the
>> pseudo-locked data of the first.
> 
> Why does it neeed wbinvd? wbinvd is a big hammer. What's wrong with clflush?

wbinvd is required by this hardware supported feature but limited to the
creation of the pseudo-locked region. An administrator could dedicate a
portion of cache to pseudo-locking and applications using this region
can come and go. The pseudo-locked region lifetime need not be tied to
application lifetime. The pseudo-locked region could be set up once on
boot and remain for lifetime of system.

Even so, understanding that it is a big hammer I did explore the
alternatives. Trying clflush, clflushopt, as well as clwb. Finding them
all to perform poorly(*) I went further to explore if it is possible to
use these other instructions with some additional work in support to
make them perform as well as wbinvd. The additional work included,
looping over the data more times than done for wbinvd, reducing the size
of memory locked in relationship to cache size, unused spacing between
pseudo-locked region and other regions, unmapped memory at end of
pseudo-locked region.

In addition to the above research from my side I also followed up with
the CPU architects directly to question the usage of these instructions
instead of wbinvd.

In all the testing and questioning I did I was only able to confirm that
wbinvd is required. Its use consistently results in the fewest cache
misses to the created pseudo-locked region.

Reinette

(*) By poorly I mean that accessing the pseudo-locked region created
using these instructions resulted in significant cache misses.
