Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752095AbeB0XUZ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 18:20:25 -0500
Received: from hs01.dk-develop.de ([213.136.71.231]:53116 "EHLO
        hs01.dk-develop.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751979AbeB0XUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 18:20:23 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Wed, 28 Feb 2018 00:20:26 +0100
From: Danilo Krummrich <danilokrummrich@dk-develop.de>
To: Kees Cook <keescook@chromium.org>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
        keescook@google.com
Subject: Re: [PATCH 1/2] fs/sysctl: fix potential page fault while
 unregistering sysctl table
In-Reply-To: <CAGXu5j+geUKNMu8W-+CYUD0_d_LBv+78TE5QbKx2EBeCx_oP9A@mail.gmail.com>
References: <20180227224358.12672-1-danilokrummrich@dk-develop.de>
 <CAGXu5j+geUKNMu8W-+CYUD0_d_LBv+78TE5QbKx2EBeCx_oP9A@mail.gmail.com>
Message-ID: <55ea6fc33aa0385c90ea5a640fa5ad9d@dk-develop.de>
User-Agent: Roundcube Webmail/1.3.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-02-28 00:02, Kees Cook wrote:
> On Tue, Feb 27, 2018 at 2:43 PM, Danilo Krummrich
> <danilokrummrich@dk-develop.de> wrote:
>> proc_sys_link_fill_cache() does not take currently unregistering
>> sysctl tables into account, which might result into a page fault in
>> sysctl_follow_link() - add a check to fix it.
>> 
>> Signed-off-by: Danilo Krummrich <danilokrummrich@dk-develop.de>
>> ---
>>  fs/proc/proc_sysctl.c | 3 +++
>>  1 file changed, 3 insertions(+)
>> 
>> diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
>> index c5cbbdff3c3d..a0b6c647835e 100644
>> --- a/fs/proc/proc_sysctl.c
>> +++ b/fs/proc/proc_sysctl.c
>> @@ -709,6 +709,9 @@ static bool proc_sys_link_fill_cache(struct file 
>> *file,
>>         bool ret = true;
> 
> Nothing appears to actually change "ret" in this function. It should
> likely be dropped too.
> 
proc_sys_fill_cache() potentially changes "ret".
>>         head = sysctl_head_grab(head);
>> 
>> +       if (IS_ERR(head))
>> +               return false;
>> +
> 
> This looks sensible. I'd drop the blank line between sysctl_head_grab
> and the IS_ERR, though.
> 
I'll do that.
> How are you testing this change?
> 
Honestly, not at all. Actually, I never run in such a page fault.
I spotted it by accident while reading the code.
> Thanks!
> 
> -Kees
> 
>>         if (S_ISLNK(table->mode)) {
>>                 /* It is not an error if we can not follow the link 
>> ignore it */
>>                 int err = sysctl_follow_link(&head, &table);
>> --
>> 2.14.1
>> 
