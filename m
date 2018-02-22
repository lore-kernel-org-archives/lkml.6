Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933059AbeBVPuj (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 10:50:39 -0500
Received: from mail-qt0-f194.google.com ([209.85.216.194]:44572 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932980AbeBVPuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 10:50:37 -0500
X-Google-Smtp-Source: AH8x225IOI7S6hAKz2QNokYJQWrdv3P41cr8p4jpj8k1CVkimKdID0rqSFTmjE2thBp5x6gtteRNVu/jcPMa847xfPM=
MIME-Version: 1.0
In-Reply-To: <26d1b3f2-fc7d-2644-5bdb-5238766fc4d4@redhat.com>
References: <20180222114558.1307380-1-arnd@arndb.de> <26d1b3f2-fc7d-2644-5bdb-5238766fc4d4@redhat.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 22 Feb 2018 16:50:36 +0100
X-Google-Sender-Auth: LoUf7MK6LYn1dV-Bp0P3tguIjkQ
Message-ID: <CAK8P3a0z4FV5Y7XqMPzJ_WpPAx+pqr9OVR9JKm2+6ramSiqAsw@mail.gmail.com>
Subject: Re: [PATCH] debugobjects: fix debug_objects_freed accounting
To: Waiman Long <longman@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Yang Shi <yang.shi@linux.alibaba.com>, Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 22, 2018 at 2:58 PM, Waiman Long <longman@redhat.com> wrote:
> On 02/22/2018 06:45 AM, Arnd Bergmann wrote:
>> The removal of the batched object freeing has caused the debug_objects_freed
>> to become read-only, and the reading is inside an ifdef, so gcc warns that it
>> is completely unused without CONFIG_DEBUG_FS:
>>
>> lib/debugobjects.c:71:14: error: 'debug_objects_freed' defined but not used [-Werror=unused-variable]
>>
>> Assuming we are still interested in this number, this adds back code to
>> count every instance we are about to free while we still hold the spinlock.
>>
>> Fixes: 636e1970fd7d ("debugobjects: Use global free list in free_object()")
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> ---
>>  lib/debugobjects.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/lib/debugobjects.c b/lib/debugobjects.c
>> index faab2c4ea024..748288dba512 100644
>> --- a/lib/debugobjects.c
>> +++ b/lib/debugobjects.c
>> @@ -235,6 +235,9 @@ static void free_obj_work(struct work_struct *work)
>>               hlist_move_list(&obj_to_free, &tofree);
>
> It would be simpler to just do:
>                debug_objects_freed += obj_nr_tofree;
>

Right, I missed that, sending v2 now.

Thanks for the review!

        Arnd
