Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751085AbeBQJhA (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Feb 2018 04:37:00 -0500
Received: from mail-io0-f195.google.com ([209.85.223.195]:35181 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751052AbeBQJg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Feb 2018 04:36:58 -0500
X-Google-Smtp-Source: AH8x22481KG77T4rs6x2nQ3jshpiKUxKZjBXHP5H0xpTbv7/zBzA1JZjz4qZctQIss56UyJ7J+FcEbTwOVIu5cPvBhs=
MIME-Version: 1.0
In-Reply-To: <20180216220536.liew4p4kqmaxwmfh@redhat.com>
References: <20180215182208.35003-1-joe.konno@linux.intel.com>
 <CAKv+Gu80pJ5tbGoJqBm8CCKrEZXdkE83c944383KbQ5jREUC0Q@mail.gmail.com>
 <1518814319.4419.10.camel@HansenPartnership.com> <3908561D78D1C84285E8C5FCA982C28F7B37942B@ORSMSX110.amr.corp.intel.com>
 <20180216220536.liew4p4kqmaxwmfh@redhat.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Sat, 17 Feb 2018 09:36:56 +0000
Message-ID: <CAKv+Gu982mt==TaBRpwLLOLrX03zVJ+RznqCgDrxGNctJUVQVA@mail.gmail.com>
Subject: Re: [PATCH 0/2] efivars: reading variables can generate SMIs
To: Peter Jones <pjones@redhat.com>
Cc: "Luck, Tony" <tony.luck@intel.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Joe Konno <joe.konno@linux.intel.com>,
        Matthew Garrett <mjg59@google.com>, Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jeremy Kerr <jk@ozlabs.org>, Andi Kleen <ak@linux.intel.com>,
        Benjamin Drung <benjamin.drung@profitbricks.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16 February 2018 at 22:05, Peter Jones <pjones@redhat.com> wrote:
> On Fri, Feb 16, 2018 at 09:09:30PM +0000, Luck, Tony wrote:
>> > That said, I'm not sure how many non-root users run the toolkit to
>> > extract their EFI certificates or check on the secure boot status of
>> > the system, but I suspect it might be non-zero: I can see the tinfoil
>> > hat people wanting at least to check the secure boot status when they
>> > log in.
>>
>> Another fix option might be to rate limit EFI calls for non-root users (on X86
>> since only we have the SMI problem). That would:
>>
>> 1) Avoid using memory to cache all the variables
>> 2) Catch any other places where non-root users can call EFI
>
> I could get behind that as well.  Currently the things I maintain do
> approximately this many normal accesses with invocations you can do as a
> user:
>
> "efibootmgr -v" - six files we always try to read, plus one per Boot####
>                   entry.
> "fwupdate --info" - one file it always tries to read, one file for each
>                     ESRT entry.
> "dbxtool -l" - one file it always reads.
> "mokutil --sb-state" - reads the same file twice.  I don't maintain
>                        this, but I'll send a patch to Gary to make it
>                        only read it once.  AFAICS all of the other
>                        invocations you can currently do as a user
>                        /legitimately/ read two files, though.
>
> Some systems seem to *love* making a pile of Boot#### entries; I think
> the most I've seen is something like 16.  So on that machine, one
> "efibootmgr -v" invocation is ~22 efivars files read.  I've never seen a
> machine that advertised more than 2 ESRT entries, but maybe we'll get
> there some day.
>

Would rate limiting (but not only for non-root) help mitigate Spectre
v1 issues in UEFI runtime services code as well? I have been looking
into unmapping the entire kernel while such calls are in progress,
because firmware is likely to remain vulnerable long after the OSes
have been fixed, and we may be able to kill two birds with one stone
here (and not break userland in the process)
