Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751571AbeCNR1o (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 13:27:44 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56386 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751279AbeCNR1m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 13:27:42 -0400
Reply-To: jtoppins@redhat.com
Subject: Re: [PATCH net] tg3: prevent scheduling while atomic splat
To: Michael Chan <michael.chan@broadcom.com>
Cc: Netdev <netdev@vger.kernel.org>, Andy Gospodarek <andy@greyhouse.net>,
        Siva Reddy Kallam <siva.kallam@broadcom.com>,
        Prashant Sreedharan <prashant@broadcom.com>,
        Michael Chan <mchan@broadcom.com>,
        open list <linux-kernel@vger.kernel.org>
References: <f439051c3964c6bb5342e25fb5327e0cdeba001e.1521045132.git.jtoppins@redhat.com>
 <CACKFLi=R2q71JH2Jbqbpy8HrzNpg1UmnoNWKhEs7ooWLWoQOqQ@mail.gmail.com>
From: Jonathan Toppins <jtoppins@redhat.com>
Organization: Red Hat
Message-ID: <266eae62-bef2-6c51-415f-cbacc1669e30@redhat.com>
Date: Wed, 14 Mar 2018 13:27:41 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <CACKFLi=R2q71JH2Jbqbpy8HrzNpg1UmnoNWKhEs7ooWLWoQOqQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/14/2018 01:22 PM, Michael Chan wrote:
> On Wed, Mar 14, 2018 at 9:36 AM, Jonathan Toppins <jtoppins@redhat.com> wrote:
>> The problem was introduced in commit
>> 506b0a395f26 ("[netdrv] tg3: APE heartbeat changes"). The bug occurs
>> because tp->lock spinlock is held which is obtained in tg3_start
>> by way of tg3_full_lock(), line 11571. The documentation for usleep_range()
>> specifically states it cannot be used inside a spinlock.
>>
>> Fixes: 506b0a395f26 ("[netdrv] tg3: APE heartbeat changes")
>> Signed-off-by: Jonathan Toppins <jtoppins@redhat.com>
>> ---
>>
>> Notes:
>>     The thing I need reviewed from Broadcom is if the udelay should be 20
>>     instead of 10, due to any timing changes introduced by the offending
>>     patch.
> 
> Thanks.  10 us is correct.
> 
> As a future improvement, we might want to see if we can release the
> spinlock and go back to usleep_range().  The wait time is potentially
> up to 20 msec which is quite long.

Agreed, glad it is not just me wondering why a lock needs to be held for
reads. :-)
