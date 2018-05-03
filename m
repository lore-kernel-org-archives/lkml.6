Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751220AbeECXXR (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 19:23:17 -0400
Received: from mail-wm0-f50.google.com ([74.125.82.50]:39425 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750965AbeECXXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 19:23:15 -0400
X-Google-Smtp-Source: AB8JxZqbGKi1jHo3QqjVhoN0Ywnucow/8oEHHoHV0VgjD3Yb3a3y+VMsmKt2JZp8a2zK7CBS5u31iQ==
Subject: Re: [PATCH] proc: use #pragma once
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>, dsterba@suse.cz,
        Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
References: <20180423213534.GA9043@avx2>
 <20180424135409.GA22709@infradead.org> <20180425205531.GA9020@avx2>
 <20180426102629.scwtdeijbo3342gp@twin.jikos.cz> <20180426192444.GA4919@avx2>
 <20180501151319.33dcb1d48a8526ed521fae9c@linux-foundation.org>
 <85dc7f54-c17f-b49f-df4d-04a339b260d7@rasmusvillemoes.dk>
 <20180503224257.GE30522@ZenIV.linux.org.uk>
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <94db646a-4fd8-9ce3-2111-b2e4852ad324@rasmusvillemoes.dk>
Date: Fri, 4 May 2018 01:23:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180503224257.GE30522@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-05-04 00:42, Al Viro wrote:
> On Fri, May 04, 2018 at 12:14:57AM +0200, Rasmus Villemoes wrote:
> 
>> FWIW, it's not just removing some identifiers from cpp's hash tables, it
>> also reduces I/O: Due to our header mess, we have some cyclic includes,
>> e.g mm.h -> memremap.h -> mm.h. While parsing mm.h, cpp sees the #define
>> _LINUX_MM_H, then goes parsing memremap.h, but since it hasn't reached
>> the end of mm.h yet (seeing that there's nothing but comments outside
>> the #ifndef/#endif pair), it hasn't had a chance to set the internal
>> flag for mm.h, so it goes slurping in mm.h again. Obviously, the
>> definedness of _LINUX_MM_H at that point means it "only" has to parse
>> those 87K for comments and matching up #ifs, #ifdefs,#endifs etc. With
>> #pragma once, the flag gets set for mm.h immediately, so the #include
>> from memremap.h is entirely ignored. This can easily be verified with
>> strace. And mm.h is not the only header getting read twice.
> 
> Which gcc version it is?

When I stumbled on this a few years ago (I was stracing gcc for some
reason), 4.something. Verifying today, 5.4.

> Does it *really* read anything twice?

Yes, just do "strace -f" and grep 'open.*= [0-9]'.

> After all, you are going to read (and tokenize) the rest of mm.h anyway, so if it
> throws away the file it has read, only to reread it again, it's bloody
> dumb.

Hm, yes, gcc should be able to hang the buffer off of the structure it
keeps around anyway for tracking the status of mm.h. But it doesn't.

> Note that sequence of preprocessor tokens does not depend upon the ifdefs;
> anything under #if 0 *is* tokenized all the same.  So it's not even that
> "parsing" (tokenizing, actually) has to be repeated.

Are you sure about that? Maybe formally it has to (if the phases are
done strictly sequentially), but can't it go into some fast-forward mode
under #if 0 (or #ifndef $some-defined-macro) where it only looks for
string and char literals, comments and "control-flow" directives?
libcpp/internal.h does have

  /* True if we are skipping a failed conditional group.  */
  unsigned char skipping;

Rasmus
