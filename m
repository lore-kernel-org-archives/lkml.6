Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752405AbeEKERD (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 00:17:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:41071 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751352AbeEKERC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 00:17:02 -0400
Subject: Re: [PATCH] ocfs2: ocfs2_inode_lock_tracker does not distinguish lock
 level
To: Andrew Morton <akpm@linux-foundation.org>
Cc: mfasheh@versity.com, jlbec@evilplan.org, linux-kernel@vger.kernel.org,
        ocfs2-devel@oss.oracle.com
References: <20180510053230.17217-1-lchen@suse.com>
 <20180510144944.d0842b82b99a471dbbc745ad@linux-foundation.org>
From: Larry Chen <lchen@suse.com>
Message-ID: <88053e38-350e-34a4-b3d8-431297dc1f90@suse.com>
Date: Fri, 11 May 2018 12:16:51 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180510144944.d0842b82b99a471dbbc745ad@linux-foundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andrew,


On 05/11/2018 05:49 AM, Andrew Morton wrote:
> On Thu, 10 May 2018 13:32:30 +0800 Larry Chen <lchen@suse.com> wrote:
>
>> ocfs2_inode_lock_tracker as a variant of ocfs2_inode_lock,
>> is used to prevent deadlock due to recursive lock acquisition.
>>
>> But this function does not distinguish
>> whether the requested level is EX or PR.
>>
>> If a RP lock has been attained, this function
>> will immediately return success afterwards even
>> an EX lock is requested.
>>
>> But actually the return value does not mean that
>> the process got a EX lock, because ocfs2_inode_lock
>> has not been called.
>>
>> When taking lock levels into account, we face some different situations.
>> 1. no lock is held
>>     In this case, just lock the inode and return 0
>>
>> 2. We are holding a lock
>>     For this situation, things diverges into several cases
>>
>>     wanted     holding	     what to do
>>     ex		ex	    see 2.1 below
>>     ex		pr	    see 2.2 below
>>     pr		ex	    see 2.1 below
>>     pr		pr	    see 2.1 below
>>
>>     2.1 lock level that is been held is compatible
>>     with the wanted level, so no lock action will be tacken.
>>
>>     2.2 Otherwise, an upgrade is needed, but it is forbidden.
>>
>> Reason why upgrade within a process is forbidden is that
>> lock upgrade may cause dead lock. The following illustrate
>> how it happens.
>>
>>          process 1                             process 2
>> ocfs2_inode_lock_tracker(ex=0)
>>                                 <======   ocfs2_inode_lock_tracker(ex=1)
>>
>> ocfs2_inode_lock_tracker(ex=1)
>>
> Nice changelog, but it gives no information about the severity of the
> bug: how often does it hit and what is the end-user impact.
>
> This info is needed so that I and others can decide which kernel
> version(s) need the patch, so please always include it when fixing a
> bug, thanks.

Thanks for your review and feel sorry for not providing enough information.

For the status quo of ocfs2, without this patch, neither a bug nor end-user
impact will be caused because the wrong logic is avoided.

But I'm afraid this generic interface, may be called by other
developers in future and used in this situation.

     a process
ocfs2_inode_lock_tracker(ex=0)
ocfs2_inode_lock_tracker(ex=1)

By the way, should I resend this patch with this info included?

Thanks
Larry

>
