Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751405AbeBUB7F (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 20:59:05 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:49028 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750781AbeBUB7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 20:59:04 -0500
Subject: Re: [RFC PATCH V2 13/22] x86/intel_rdt: Support schemata write -
 pseudo-locking core
To: Thomas Gleixner <tglx@linutronix.de>,
        Reinette Chatre <reinette.chatre@intel.com>
Cc: fenghua.yu@intel.com, tony.luck@intel.com, gavin.hindman@intel.com,
        vikas.shivappa@linux.intel.com, dave.hansen@intel.com,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1518443616.git.reinette.chatre@intel.com>
 <dbf01ddf087e4597f86a85c1c91c1fc942e70269.1518443616.git.reinette.chatre@intel.com>
 <alpine.DEB.2.21.1802200059240.1853@nanos.tec.linutronix.de>
 <6c960fc0-820e-757c-2770-d770647e63d6@intel.com>
 <alpine.DEB.2.21.1802202355240.24268@nanos.tec.linutronix.de>
From: Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <2db87a79-e13f-ad6b-c399-1ad58585f38e@oracle.com>
Date: Tue, 20 Feb 2018 17:58:46 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1802202355240.24268@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8810 signatures=668675
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802210022
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/20/2018 03:21 PM, Thomas Gleixner wrote:
> On Tue, 20 Feb 2018, Reinette Chatre wrote:
>> On 2/20/2018 9:15 AM, Thomas Gleixner wrote:
>>> On Tue, 13 Feb 2018, Reinette Chatre wrote:
>>>
>>> Now the remaining thing is the memory allocation and the mmap itself. I
>>> really dislike the preallocation of memory right at setup time. Ideally
>>> that should be an allocation of the application itself, but the horrid
>>> wbinvd stuff kinda prevents that. With that restriction we are more or less
>>> bound to immediate allocation and population.
>>
>> Acknowledged. I am not sure if the current permissions would support
>> such a dynamic setup though. At this time the system administrator is
>> the one that sets up the pseudo-locked region and can through
>> permissions of the character device provide access to these regions to
>> user space applications.
> 
> You still would need some interface, e.g. character device which allows you
> to hand in the pointer to the user allocated memory and do the cache
> priming. So you could use the same permission setup for that character
> device.
> 
> The other problem is that we'd need to have MAP_CONTIG first so you
> actually can allocate physically contigous memory from user space. Mike is
> working on that, but it's not available today. The only way to do so today
> (with lots of waste) would be MAP_HUGETLB, which might be an acceptable
> constraint up to the point where MAP_CONTIG is available.

Just to clarify, there is not any activity on exposing a general purpose
MAP_CONTIG interface to user space.  When initially proposed, MAP_CONTIG
was shot down and the suggestion was to create a new in kernel interface
to make allocation of contiguous pages easier.  The initial use case was
a driver which could use the new internal interface as part of it's
mmap() routine to give contiguous regions to user space.

Reinette is using this new interface, but that must be for the ?immediate
allocation? case you are trying to move away from.  Sorry, I have not been
following development of this feature.

If you would have to create a device to accept a user buffer, could you
perhaps use the same device to create/hand out a contiguous mapping?
-- 
Mike Kravetz
