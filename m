Return-Path: <mpe@ellerman.id.au>
X-Google-Smtp-Source: AH8x224+WSL8reff6nQ1YcygpWmQLs7PXC+BoLHVXnfANlrplp1s1VeXMQmrM4YXSeDeGhzWeIbA
ARC-Seal: i=1; a=rsa-sha256; t=1519338692; cv=none;
        d=google.com; s=arc-20160816;
        b=JRsjGg30Bwo+LY0HKSvN48dsKpKZIvm2bYs/hkolKVSYFfTfgYQwy3IFyGODOYEPe7
         Zv7+klMzCQ5QLcQhkIB3xRoY/yhgMz9AwpoK7Rgo3HcKlXIIeyQqm3VfAfKApkQzJjEN
         BrNiltxrWtP8MdHjAJ1BRN335T7sHjTr0j7U6YW2afjHGPjzhFsFD5ayZwz3OGZhcHD9
         63245sxOh/LvZTuwowi9G2R8yIB1WBiTCwROs3HVMyoxOYxmW4FErZRIEKqeHjnzOtko
         ksi/iNSoK/8kvLjLi6I4UuxsGEFT5xSZbZO0YR5XqvtYvZ6uO/FlXwpX6pRH4YPnfVOW
         QPjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:arc-authentication-results;
        bh=bh/KAVxfUqhcudVt3ZH4uCN0t2iJXesYg8mGa6Pgo4s=;
        b=T/MZfWOZJuPi94FvrJPtW1JRH8vIaxMi8iS7G1td+y7VIi1KrVcq4qPOKr0yZwtkX4
         HEWDJ1PNWKPmwQIWpAghbZW0kBQMICXyIjbEqwwl5B2B/4ABQadwoCPcJ1VERIwOgjxj
         cFQvhd8UCfImgIZPw6mcz1xb2q1CjZ9QdsR1cc4+lQEyyo1vqya0BIh7OigmvE86TRz4
         yycQuMHJjXlB4I3yh4PvfsyUHDBvw9chdUBnIHZXGo9eD07PrtDMqxZdTGYI0SCJiiVG
         v7rnQ13KT3Zoxgk6T7q/ZJby30Adw2pKxcnj4VocGaV4Vv8UMOvM69rbB5SdHl6h59z0
         pozw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 2401:3900:2:1::2 is neither permitted nor denied by best guess record for domain of mpe@ellerman.id.au) smtp.mailfrom=mpe@ellerman.id.au
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 2401:3900:2:1::2 is neither permitted nor denied by best guess record for domain of mpe@ellerman.id.au) smtp.mailfrom=mpe@ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Yves-Alexis Perez <corsac@debian.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, "Nicholas Piggin" <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH 4.9 34/77] powerpc: fix build errors in stable tree
In-Reply-To: <1519306335.2388.18.camel@debian.org>
References: <20180221124432.172390020@linuxfoundation.org> <20180221124433.618725458@linuxfoundation.org> <87k1v5rg66.fsf@concordia.ellerman.id.au> <1519292030.2388.14.camel@debian.org> <874lm9qi4t.fsf@concordia.ellerman.id.au> <1519306335.2388.18.camel@debian.org>
Date: Fri, 23 Feb 2018 09:31:29 +1100
Message-ID: <87vaeopsfy.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593015251280374527?=
X-GMAIL-MSGID: =?utf-8?q?1593142088148031883?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Yves-Alexis Perez <corsac@debian.org> writes:
> On Fri, 2018-02-23 at 00:16 +1100, Michael Ellerman wrote:
>> With the patches I just sent, for pseries and powernv, the mitigation
>> should be in place. On machines with updated firmware we'll use the
>> hardware-assisted L1 flush, otherwise we fallback to doing it in
>> software.
>
> So as of 4.9.82 meltdown is *not* addressed on those arches, but it should be
> ok in 4.9.83 or 4.9.84 depending on when the patches are merged?

As of 4.9.82 *most* of the patches to do the mitigation have been
merged.

One of them was missed, due to it not applying (because it was actually
a back port to 4.4 that was sent) that is:

  222f20f14062 ("powerpc/64s: Simple RFI macro conversions")


That patch adds calls to do the L1D cache flush when returning to
user/guest, so it is important that it's missing, the mitigation is not
fully effective without that patch.

However, 4.9.82 *does* have a backport of:

  b8e90cb7bc04 ("powerpc/64: Convert the syscall exit path to use RFI_TO_USER/KERNEL")

So the syscall path is protected, which means any attack which uses
syscalls is likely to fail.

Because the data the attack is trying to read has to be in the L1D, you
can't write an attack that remains in userspace 100% of the time, you
have to enter the kernel and have the kernel load the target data into
the L1D for you. With the syscall flush in place you can't use a syscall
for that, you have to trigger some other kernel entry/exit, eg. a page
fault.

TLDR is with the syscall flush in place it's much harder to write an
attack.

Greg has already released 4.9.83, so hopefully 4.9.84 will be fully
protected.

Note also that 4.9.82/83 have a bug in the SLB miss handler that can
lead to hangs in userspace, fixed by the first patch I sent.

cheers
