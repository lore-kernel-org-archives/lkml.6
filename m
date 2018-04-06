Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752147AbeDFQz7 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 12:55:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:43848 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751749AbeDFQz5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 12:55:57 -0400
Subject: Re: [PATCH?] reiserfs: prevent panic: don't allow %-char in journal
 dev. name
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>, reiserfs-devel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Artem Bityutskiy <dedekind1@gmail.com>,
        syzkaller-bugs@googlegroups.com,
        syzbot+6bd77b88c1977c03f584@syzkaller.appspotmail.com
References: <d9b518a5-287a-72b3-05f1-ea89e25563ba@infradead.org>
 <20180404184517.9f2b91b856a56f71464f5f7f@linux-foundation.org>
 <6b575956-6498-43c8-dc2c-9e2a0d5564a9@rasmusvillemoes.dk>
From: Jeff Mahoney <jeffm@suse.com>
Openpgp: preference=signencrypt
Message-ID: <d520db9a-fd40-a3ef-7747-a5a7a51668cd@suse.com>
Date: Fri, 6 Apr 2018 12:55:53 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <6b575956-6498-43c8-dc2c-9e2a0d5564a9@rasmusvillemoes.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/5/18 5:04 AM, Rasmus Villemoes wrote:
> On 2018-04-05 03:45, Andrew Morton wrote:
>> On Wed, 4 Apr 2018 18:25:16 -0700 Randy Dunlap <rdunlap@infradead.org> wrote:
>>
>>> From: Randy Dunlap <rdunlap@infradead.org>
>>>
>>> If the reiserfs mount option's journal name contains a '%' character,
>>> it can lead to a WARN_ONCE() in lib/vsprintf.c::format_decode(),
>>> saying: "Please remove unsupported %/ in format string."
>>> That's OK until panic_on_warn is set, at which point it's dead, Jim.
>>>
>>> To placate this situation, check the journal name string for a '%'
>>> character and return an error if one is found. Also print a warning
>>> (one that won't panic the kernel) about the invalid journal name (e.g.):
>>>
>>>   reiserfs: journal device name is invalid: %/file0
>>>
>>> (In this example, the caller app specified the journal device name as
>>> "%/file0".)
>>>
>>
>> Well, that is a valid filename and we should support it...
>>
>> Isn't the bug in journal_init_dev()?
> 
> Urgh. At first I was about to reply that the real bug was in reiserfs.h
> for failing to annotate __reiserfs_warning with __printf(). But digging
> into it, it turns out that it implements its own printf extensions, so
> that's obviously a non-starter. Now, one thing is that some of those
> extension clash with existing standard modifiers (%z and %h, so if
> someone adds a correct %zu thing to print a size_t in reiserfs things
> will break). But, and I hope I'm wrong about this and just hasn't had
> enough coffee, this seems completely broken:

Yep.  There are a bunch of ways that this is broken, but it's been "good
enough" for so long that no fix has landed.  Once upon a time, I wanted
to fix this by adding something similar to %pV that allowed the caller
to pass a set of handlers for additional types.  That didn't make it off
the ground.

There's another issue where we assume that % will only be followed by a
single character.  That won't cause runtime issues, but it will end up
putting those additional characters in the output.

Lastly, again not a runtime issue, is that the spinlock only covers
formatting the buffer.  It doesn't cover printing it.  You can end up
with part of the error buffer containing the format of another warning.

I'm working up something to fix most of the above.  I'll post it later
today or Monday.

-Jeff

>         while ((k = is_there_reiserfs_struct(fmt1, &what)) != NULL) {
>                 *k = 0;
> 
>                 p += vsprintf(p, fmt1, args);
> 
>                 switch (what) {
>                 case 'k':
>                         sprintf_le_key(p, va_arg(args, struct
> reiserfs_key *));
>                         break;
> 
> On architectures where va_list is a typedef for a one-element array of
> some struct (x86-64), that works ok, because the vsprintf call can and
> does update the args metadata. But when args is just a pointer into the
> stack (i386), we don't know how much vsprintf consumed, and end up
> consuming the same arguments again - only this time we may interpret
> some random integer as a struct pointer...
> 
> A minimal program showing the difference:
> 
> #include <stdio.h>
> #include <stdarg.h>
> 
> void f(const char *dummy, ...)
> {
> 	va_list ap;
> 	int i;
> 
> 	va_start(ap, dummy);
> 	for (i = 0; i < 5; ++i) {
> 		vprintf("%d\n", ap);
> 		printf("%d\n", va_arg(ap, int));
> 	}
> 	va_end(ap);
> }
> 
> int main(int argc, char *argv[])
> {
> 	f("bla", 1, 2, 3, 4, 5, 6, 7, 8, 9, 10);
> 	return 0;
> }
> 
> Compiling for native (x86-64), this produces $(seq 10). But with -m32,
> one gets 1,1,2,2,3,3,4,4,5,5.
> 
> Assuming reiserfs (at least its debugging infrastructure) isn't broken
> on a bunch of architectures, I'm obviously missing something
> fundamental. Please enlighten me.
> 
> Rasmus
> 


-- 
Jeff Mahoney
SUSE Labs
