Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750848AbeBPUwE (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 15:52:04 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:52716 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750713AbeBPUwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 15:52:02 -0500
Message-ID: <1518814319.4419.10.camel@HansenPartnership.com>
Subject: Re: [PATCH 0/2] efivars: reading variables can generate SMIs
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Joe Konno <joe.konno@linux.intel.com>,
        Matthew Garrett <mjg59@google.com>, Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>
Cc: linux-efi@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jeremy Kerr <jk@ozlabs.org>, Andi Kleen <ak@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Benjamin Drung <benjamin.drung@profitbricks.com>,
        Peter Jones <pjones@redhat.com>
Date: Fri, 16 Feb 2018 12:51:59 -0800
In-Reply-To: <CAKv+Gu80pJ5tbGoJqBm8CCKrEZXdkE83c944383KbQ5jREUC0Q@mail.gmail.com>
References: <20180215182208.35003-1-joe.konno@linux.intel.com>
         <CAKv+Gu80pJ5tbGoJqBm8CCKrEZXdkE83c944383KbQ5jREUC0Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-02-16 at 10:41 +0000, Ard Biesheuvel wrote:
> On 15 February 2018 at 18:22, Joe Konno <joe.konno@linux.intel.com>
> wrote:
> > 
> > From: Joe Konno <joe.konno@intel.com>
> > 
> > It was pointed out that normal, unprivileged users reading certain
> > EFI
> > variables (through efivarfs) can generate SMIs. Given these nodes
> > are created
> > with 0644 permissions, normal users could generate a lot of SMIs.
> > By
> > restricting permissions a bit (patch 1), we can make it harder for
> > normal users
> > to generate spurious SMIs.
> > 
> > A normal user could generate lots of SMIs by reading the efivarfs
> > in a trivial
> > loop:
> > 
> > ```
> > while true; do
> >     cat /sys/firmware/efi/evivars/* > /dev/null
> > done
> > ```
> > 
> > Patch 1 in this series limits read and write permissions on
> > efivarfs to the
> > owner/superuser. Group and world cannot access.
> > 
> > Patch 2 is for consistency and hygiene. If we restrict permissions
> > for either
> > efivarfs or efi/vars, the other interface should get the same
> > treatment.
> > 
> 
> I am inclined to apply this as a fix, but I will give the x86 guys a
> chance to respond as well.

It would break my current efi certificate tools because right at the
moment you can read the EFI secure boot variables as an unprivileged
user.

That said, I'm not sure how many non-root users run the toolkit to
extract their EFI certificates or check on the secure boot status of
the system, but I suspect it might be non-zero: I can see the tinfoil
hat people wanting at least to check the secure boot status when they
log in.

James
