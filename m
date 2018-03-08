Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756015AbeCHTC7 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 14:02:59 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56476 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754558AbeCHTC6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 14:02:58 -0500
Subject: Re: [PATCH v3 0/6] ipc: Clamp *mni to the real IPCMNI limit
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>
References: <1519926220-7453-1-git-send-email-longman@redhat.com>
 <20180308182335.GH4449@wotan.suse.de>
From: Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <90323260-02ee-b7b8-5de3-79378fc972a6@redhat.com>
Date: Thu, 8 Mar 2018 14:02:54 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180308182335.GH4449@wotan.suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/08/2018 01:23 PM, Luis R. Rodriguez wrote:
> On Thu, Mar 01, 2018 at 12:43:34PM -0500, Waiman Long wrote:
>> v2->v3:
>>  - Fix kdoc comment errors.
>>  - Incorporate comments and suggestions from Luis R. Rodriguez.
>>  - Add a patch to fix a typo error in fs/proc/proc_sysctl.c.
>>
>> v1->v2:
>>  - Add kdoc comments to the do_proc_do{u}intvec_minmax_conv_param
>>    structures.
>>  - Add a new flags field to the ctl_table structure for specifying
>>    whether range clamping should be activated instead of adding new
>>    sysctl parameter handlers.
>>  - Clamp the semmni value embedded in the multi-values sem parameter.
>>
>> v1 patch: https://lkml.org/lkml/2018/2/19/453
>> v2 patch: https://lkml.org/lkml/2018/2/27/627
>>
>> The sysctl parameters msgmni, shmmni and semmni have an inherent limit
>> of IPC_MNI (32k). However, users may not be aware of that because they
>> can write a value much higher than that without getting any error or
>> notification. Reading the parameters back will show the newly written
>> values which are not real.
>>
>> Enforcing the limit by failing sysctl parameter write, however, can
>> break existing user applications. To address this delemma, a new flags
>> field is introduced into the ctl_table. The value CTL_FLAGS_CLAMP_RANGE
>> can be added to any ctl_table entries to enable a looser range clamping
>> without returning any error. For example,
>>
>>   .flags = CTL_FLAGS_CLAMP_RANGE,
>>
>> This flags value are now used for the range checking of shmmni,
>> msgmni and semmni without breaking existing applications. If any out
>> of range value is written to those sysctl parameters, the following
>> warning will be printed instead.
>>
>>   Kernel parameter "shmmni" was set out of range [0, 32768], clamped to 32768.
>>
>> Reading the values back will show 32768 instead of some fake values.
> I don't see any addition of respective tests cases, I thought I asked
> for this. Please add respective tests cases for all the API you are
> adding on lib/test_sysctl.c and respective tests on
> tools/testing/selftests/sysctl/sysctl.sh
>
>   Luis

I probably missed that. I will add a test case in the next version.

-Longman
