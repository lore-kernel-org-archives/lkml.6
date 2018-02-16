Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934602AbeBPKz5 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 05:55:57 -0500
Received: from mail.skyhub.de ([5.9.137.197]:48622 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933125AbeBPKzz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 05:55:55 -0500
Date: Fri, 16 Feb 2018 11:55:48 +0100
From: Borislav Petkov <bp@alien8.de>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Joe Konno <joe.konno@linux.intel.com>,
        Matthew Garrett <mjg59@google.com>, Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>, linux-efi@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jeremy Kerr <jk@ozlabs.org>, Andi Kleen <ak@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Benjamin Drung <benjamin.drung@profitbricks.com>,
        Peter Jones <pjones@redhat.com>
Subject: Re: [PATCH 0/2] efivars: reading variables can generate SMIs
Message-ID: <20180216105548.GA29042@pd.tnic>
References: <20180215182208.35003-1-joe.konno@linux.intel.com>
 <CAKv+Gu80pJ5tbGoJqBm8CCKrEZXdkE83c944383KbQ5jREUC0Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKv+Gu80pJ5tbGoJqBm8CCKrEZXdkE83c944383KbQ5jREUC0Q@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 16, 2018 at 10:41:45AM +0000, Ard Biesheuvel wrote:
> On 15 February 2018 at 18:22, Joe Konno <joe.konno@linux.intel.com> wrote:
> > From: Joe Konno <joe.konno@intel.com>
> >
> > It was pointed out that normal, unprivileged users reading certain EFI
> > variables (through efivarfs) can generate SMIs. Given these nodes are created
> > with 0644 permissions, normal users could generate a lot of SMIs. By
> > restricting permissions a bit (patch 1), we can make it harder for normal users
> > to generate spurious SMIs.
> >
> > A normal user could generate lots of SMIs by reading the efivarfs in a trivial
> > loop:
> >
> > ```
> > while true; do
> >     cat /sys/firmware/efi/evivars/* > /dev/null
> > done
> > ```
> >
> > Patch 1 in this series limits read and write permissions on efivarfs to the
> > owner/superuser. Group and world cannot access.
> >
> > Patch 2 is for consistency and hygiene. If we restrict permissions for either
> > efivarfs or efi/vars, the other interface should get the same treatment.
> >
> 
> I am inclined to apply this as a fix, but I will give the x86 guys a
> chance to respond as well.

That stinking pile EFI never ceases to amaze me...

Just one question: by narrowing permissions this way, aren't you
breaking some userspace which reads those?

And if you do, then that's a no-no.

Which then would mean that you'd have to come up with some caching
scheme to protect the firmware from itself.

Or we could simply admit that EFI is a piece of crap, kill it and
start anew, this time much more conservatively and not add a whole OS
underneath the actual OS.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
