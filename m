Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932959AbeCMLRZ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 07:17:25 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43724 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932593AbeCMLRY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 07:17:24 -0400
Subject: Re: Timing performance regression 4.15 to 4.16-rc1
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: LKML <linux-kernel@vger.kernel.org>, Mike Snitzer <snitzer@redhat.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Alasdair G Kergon <agk@redhat.com>
References: <31a4b0d7-2c9e-ce76-a486-48ed18b96cc6@redhat.com>
 <20180313040354.GW30522@ZenIV.linux.org.uk>
From: Zdenek Kabelac <zkabelac@redhat.com>
Organization: Red Hat
Message-ID: <8d51dd0a-97a9-fca5-9d82-1cedae211d10@redhat.com>
Date: Tue, 13 Mar 2018 12:17:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180313040354.GW30522@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne 13.3.2018 v 05:03 Al Viro napsal(a):
> On Sun, Mar 11, 2018 at 02:02:03PM +0100, Zdenek Kabelac wrote:
>> Hi
>>
>> I've noticed quite some drop of performance (around 15% in some cases) where
>> execution of lvm2 tests took longer time - and while tests itself should not
>> really load CPU system  - the overall running time just got bigger.
>>
>> Running bisect game pointed clearly to this commit:
>>
>> ---
>>
>> commit 44c02a2c3dc55835e9f0d8ef73966406cd805001
>> Author: Al Viro <viro@zeniv.linux.org.uk>
>> Date:   Thu Oct 5 12:59:44 2017 -0400
>>
>>      dev_ioctl(): move copyin/copyout to callers
>>
>>
>> ---
>>
>> clear revert of this commit on top of 3266b5bd97eaa72793df0b6e5a106c69ccc166c4
>> (recent  ~4.16-rc4)  restored timing of tests back.
>>
>>
>> I'm not sure why - so at this moment this is just a patch causing 15% longer
>> running times on lvm2 test suite.
> 
> I find it very hard to believe, TBH.  It doesn't go anywhere near drivers/md;
> could you profile the damn thing and see where does it spend that extra time?
> 
> It really doesn't touch anything on non-sockets...


Hi

Well I'm 100% sure it's this patch causing slowdown of the test runtime
(just reverting this case makes it faster).

But even though I've already tried to create some much more simplified 
reproducer I'm still unclear what's behind it.

lvm2 alone is using sockets via i.e. udev communication - so the possible 
reason could be that used slows down  'new node' events processing in some way.

So for now the most visible reproducer is to run test in lvm2 build tree
in directory tests/:   'make check_local T=lvconvert-mirror-basic-0.sh'

I do have 'perf record' grabs if the would help anything - but looking at them 
myself there are not some directly visible things.

As said -  User+Sys timing of the running test reported by 'time' command 
remains the same - just 'real' time gets longer - which means it's waiting for 
something much longer then before  - lvm2 typically waits till udev finishes 
it's scanning.

Regards


Zdenek
