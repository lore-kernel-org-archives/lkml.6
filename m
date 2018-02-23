Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933827AbeBWTrj (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 14:47:39 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42532 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754857AbeBWTrg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 14:47:36 -0500
Date: Fri, 23 Feb 2018 14:47:33 -0500
From: Peter Jones <pjones@redhat.com>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Joe Konno <joe.konno@linux.intel.com>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jeremy Kerr <jk@ozlabs.org>, Matthew Garrett <mjg59@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        James Bottomley <james.bottomley@hansenpartnership.com>
Subject: Re: [PATCH] efivarfs: Limit the rate for non-root to read files
Message-ID: <20180223194732.v6trfxp3pmlhthcc@redhat.com>
References: <20180221182104.GI3231@tassilo.jf.intel.com>
 <20180221194731.t7jowrmicvaggu3x@agluck-desk>
 <CA+55aFzy89V13rSxGQy77Bb08qpUpH+J=trcjooKQhsAFbgrVw@mail.gmail.com>
 <3908561D78D1C84285E8C5FCA982C28F7B37F130@ORSMSX110.amr.corp.intel.com>
 <CA+55aFx3WKAL7e3TAs-2okggW6Z+DHANdmcsr+WTDh3N-Mx+Xw@mail.gmail.com>
 <20180222014505.2l76ccrrs36y3b26@agluck-desk>
 <CA+55aFzJXsPcsJ5MtsxTp2n+43xC0yGzANLNcDm1mFbZKR75FQ@mail.gmail.com>
 <3908561D78D1C84285E8C5FCA982C28F7B37FE28@ORSMSX110.amr.corp.intel.com>
 <CA+55aFy0hRexJkLbN7t31LjfGr4Ae0W5g6sBMqHHJi8aYuGKeA@mail.gmail.com>
 <612E894E-62C8-4155-AED8-D53702EDC8DC@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <612E894E-62C8-4155-AED8-D53702EDC8DC@intel.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 22, 2018 at 06:11:14AM +0000, Luck, Tony wrote:
>> On Feb 21, 2018, at 21:52, Linus Torvalds wrote:
>> 
>> Does the error return actually break real users? Not "I can do did
>> things and it acts differently" things, but actual users...
> 
> Probably not. Peter Jones said that efibootmgr might access up to 20
> files. Assuming it is sanely reading in big chunks, it won’t hit the
> rate limit that I set at 100.

Typically each read looks like:

openat(AT_FDCWD, "/sys/firmware/efi/efivars/Boot0001-8be4df61-93ca-11d2-aa0d-00e098032b8c", O_RDONLY) = 3
read(3, "\7\0\0\0", 4)                  = 4
read(3, "\1\0\0\0b\0t\0e\0s\0t\0\0\0\4\1*\0\1\0\0\0\0\10\0\0\0\0\0\0"..., 4096) = 114
read(3, "", 3982)                       = 0
close(3)                                = 0

For each multiple of 4k, you'll see one more read() call.  (It's two
reads because libefivar's efi_get_variable() returns the attributes
separately from the data, which goes in an allocation the caller is
responsible for freeing, so doing it as one read means it would
introduce an extra copy.)  Looking at that code path, if it *does* get
tripped up by EAGAIN, it should handle it fine, though maybe I should
add a short randomized delay (or just sched_yield()) in that case.

I don't think the 3rd read there to detect EOF hits the efivarfs code,
so that's 2 reads per variable until you go over 4k, which most never
do.

That pattern is true of everything that uses libefivar to do its EFI
variable manipulation.  On my moderately typical laptop with 2 boot
variables set, it looks something like:

trillian:~$ strace -o efibootmgr.strace efibootmgr -v 
BootCurrent: 0001
Timeout: 0 seconds
BootOrder: 0001,0000
Boot0000* Fedora	HD(1,GPT,2cf5261b-7b98-48c0-ae54-463dbd23e65b,0x800,0x64000)/File(\EFI\fedora\shimx64.efi)
Boot0001* test	HD(1,GPT,2cf5261b-7b98-48c0-ae54-463dbd23e65b,0x800,0x64000)/File(\EFI\fedora\shimx64.efi)
trillian:~$ grep '^\(open\|read\)' efibootmgr.strace | grep -A100 sys/firmware  | grep -c ^read
15

Which, if I'm write about VFS eating that last read, means 10 calls.
Many machines have some default boot variables; my desktop at home has 5
completely useless variables the firmware sets.  So there it winds up
being 27 calls to read(2), and thus 18 calls to count towards our limit.

Your limit at 100 looks sufficiently large to me.

-- 
  Peter
