Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751950AbeB0XBP (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 18:01:15 -0500
Received: from hs01.dk-develop.de ([213.136.71.231]:54570 "EHLO
        hs01.dk-develop.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751778AbeB0XBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 18:01:14 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Wed, 28 Feb 2018 00:01:17 +0100
From: Danilo Krummrich <danilokrummrich@dk-develop.de>
To: Kees Cook <keescook@chromium.org>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
        keescook@google.com
Subject: Re: [PATCH 2/2] fs/sysctl: remove redundant link check in
 proc_sys_link_fill_cache()
In-Reply-To: <CAGXu5jKpmw2qEqL7dnELS5h45pq9AZf=0nEXox52qEbP6pz4CA@mail.gmail.com>
References: <20180227224358.12672-1-danilokrummrich@dk-develop.de>
 <20180227224358.12672-2-danilokrummrich@dk-develop.de>
 <CAGXu5jKpmw2qEqL7dnELS5h45pq9AZf=0nEXox52qEbP6pz4CA@mail.gmail.com>
Message-ID: <ceee9f3092664f11a1c8bf06e14c6a2a@dk-develop.de>
User-Agent: Roundcube Webmail/1.3.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-02-27 23:59, Kees Cook wrote:
> On Tue, Feb 27, 2018 at 2:43 PM, Danilo Krummrich
> <danilokrummrich@dk-develop.de> wrote:
>> proc_sys_link_fill_cache() does not need to check whether we're
>> called for a link - it's already done by scan().
>> 
>> Signed-off-by: Danilo Krummrich <danilokrummrich@dk-develop.de>
>> ---
>>  fs/proc/proc_sysctl.c | 11 +++++------
>>  1 file changed, 5 insertions(+), 6 deletions(-)
>> 
>> diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
>> index a0b6c647835e..7e7d9facb842 100644
>> --- a/fs/proc/proc_sysctl.c
>> +++ b/fs/proc/proc_sysctl.c
>> @@ -707,17 +707,16 @@ static bool proc_sys_link_fill_cache(struct file 
>> *file,
>>                                     struct ctl_table *table)
>>  {
>>         bool ret = true;
>> +       int err = 0;
>>         head = sysctl_head_grab(head);
>> 
>>         if (IS_ERR(head))
>>                 return false;
>> 
>> -       if (S_ISLNK(table->mode)) {
>> -               /* It is not an error if we can not follow the link 
>> ignore it */
>> -               int err = sysctl_follow_link(&head, &table);
>> -               if (err)
>> -                       goto out;
>> -       }
>> +       /* It is not an error if we can not follow the link ignore it 
>> */
>> +       sysctl_follow_link(&head, &table);
> 
> Shouldn't this be err = sysctl_follow_link... ? Otherwise I don't see
> where err is used.
> 
> -Kees
> 
Of course, thanks.
>> +       if (err)
>> +               goto out;
>> 
>>         ret = proc_sys_fill_cache(file, ctx, head, table);
>>  out:
>> --
>> 2.14.1
>> 
