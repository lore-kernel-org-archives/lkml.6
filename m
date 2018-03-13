Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752611AbeCMVq4 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 17:46:56 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49266 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751279AbeCMVqz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 17:46:55 -0400
Subject: Re: Timing performance regression 4.15 to 4.16-rc1
From: Zdenek Kabelac <zkabelac@redhat.com>
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: LKML <linux-kernel@vger.kernel.org>, Mike Snitzer <snitzer@redhat.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Alasdair G Kergon <agk@redhat.com>
References: <31a4b0d7-2c9e-ce76-a486-48ed18b96cc6@redhat.com>
 <20180313040354.GW30522@ZenIV.linux.org.uk>
 <8d51dd0a-97a9-fca5-9d82-1cedae211d10@redhat.com>
 <ac8f0ede-22e3-199a-acb3-afeb50013127@redhat.com>
Organization: Red Hat
Message-ID: <523d279e-1c87-1f99-913a-534f459db775@redhat.com>
Date: Tue, 13 Mar 2018 22:46:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <ac8f0ede-22e3-199a-acb3-afeb50013127@redhat.com>
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne 13.3.2018 v 17:45 Zdenek Kabelac napsal(a):
> Dne 13.3.2018 v 12:17 Zdenek Kabelac napsal(a):
>> Dne 13.3.2018 v 05:03 Al Viro napsal(a):
>>> On Sun, Mar 11, 2018 at 02:02:03PM +0100, Zdenek Kabelac wrote:
>>>> Hi
>>>>
>>>> I've noticed quite some drop of performance (around 15% in some cases) where
>>>> execution of lvm2 tests took longer time - and while tests itself should not
>>>> really load CPU system  - the overall running time just got bigger.
>>>>
>>>> Running bisect game pointed clearly to this commit:
>>>>
>>>> ---
>>>>
>>>> commit 44c02a2c3dc55835e9f0d8ef73966406cd805001
>>>> Author: Al Viro <viro@zeniv.linux.org.uk>
>>>> Date:   Thu Oct 5 12:59:44 2017 -0400
>>>>
>>>>      dev_ioctl(): move copyin/copyout to callers
>>>>
>>>>
>>>> ---
>>>>
>>>> clear revert of this commit on top of 
>>>> 3266b5bd97eaa72793df0b6e5a106c69ccc166c4
>>>> (recent  ~4.16-rc4)  restored timing of tests back.
>>>>
>>>>
>>>> I'm not sure why - so at this moment this is just a patch causing 15% longer
>>>> running times on lvm2 test suite.
>>>
>>> I find it very hard to believe, TBH.  It doesn't go anywhere near drivers/md;
>>> could you profile the damn thing and see where does it spend that extra time?
>>>
>>> It really doesn't touch anything on non-sockets...
>>
>>
>> Hi
>>
>> Well I'm 100% sure it's this patch causing slowdown of the test runtime
>> (just reverting this case makes it faster).
>>
>> But even though I've already tried to create some much more simplified 
>> reproducer I'm still unclear what's behind it.
>>
>> lvm2 alone is using sockets via i.e. udev communication - so the possible 
>> reason could be that used slows down  'new node' events processing in some way.
>>
>> So for now the most visible reproducer is to run test in lvm2 build tree
>> in directory tests/:   'make check_local T=lvconvert-mirror-basic-0.sh'
>>
>> I do have 'perf record' grabs if the would help anything - but looking at 
>> them myself there are not some directly visible things.
>>
>> As said -  User+Sys timing of the running test reported by 'time' command 
>> remains the same - just 'real' time gets longer - which means it's waiting 
>> for something much longer then before  - lvm2 typically waits till udev 
>> finishes it's scanning.
>>
> 
> Hello
> 
> Here is my update - after some time of investigation - it seems the core 
> trouble is actually hidden inside  test monitoring tool which is effectively 
> grabbing test output through  a PF_UNIX socket stream - there are no other 
> sockets. (and via add printk() used commands are 21519  & 21505  for 
> dev_ioctl() call).
> 
> Also there is no influence caused by udev as since timing is same with disable 
> udev.
> 
> So ATM I'm checking, why there is such a big change in this case in the test's 
> is run via internal application which is collecting logs compare with direct 
> execution.
> 

So further evaluation revealed the key issue that
'runner' tool is using:

socketpair( PF_UNIX, SOCK_STREAM, 0, fds )

to create 2 FDs for capturing output of executed program.

If just this 'socketpair()' is replaced back to 'good old' pipe(fds)
it immediately restores performance back.

So remembering lvm history here the code has been originally actually using 
pipe() and many years back and it's been upgraded to use socketpair().

So with your current kernel patch it seems some latency slowed down this 
use-case in noticeable way (any new buffering ??).

The streamed buffer during this particular test has around 400K and 5K lines
(which is not that much for ~70 second output)

So let me know if you need some more info ?

Regards

Zdenek
