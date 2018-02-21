Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751233AbeBUAtH (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 19:49:07 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43826 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750735AbeBUAtF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 19:49:05 -0500
Date: Tue, 20 Feb 2018 19:49:00 -0500
From: Peter Jones <pjones@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Luck, Tony" <tony.luck@intel.com>,
        Joe Konno <joe.konno@linux.intel.com>, linux-efi@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Matthew Garrett <matthew.garrett@nebula.com>,
        Jeremy Kerr <jk@ozlabs.org>, Andi Kleen <ak@linux.intel.com>,
        Matthew Garrett <mjg59@google.com>, Andy Lutomirski <luto@kernel.org>,
        James Bottomley <james.bottomley@hansenpartnership.com>
Subject: Re: [PATCH 1/2] fs/efivarfs: restrict inode permissions
Message-ID: <20180221004859.7s4ltxt4pavf4mji@redhat.com>
References: <20180215182208.35003-1-joe.konno@linux.intel.com>
 <20180215182208.35003-2-joe.konno@linux.intel.com>
 <6680a760-eb30-4daf-2dad-a9628f1c15a8@kernel.org>
 <20180220211849.fqjb6rdmypl6opir@agluck-desk>
 <CA+55aFzjyB=E+=q-W9oYZ7Py7nJwm8YQHFjfbWTib6wvkP9B_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+55aFzjyB=E+=q-W9oYZ7Py7nJwm8YQHFjfbWTib6wvkP9B_A@mail.gmail.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 20, 2018 at 02:01:51PM -0800, Linus Torvalds wrote:

> Which variables are actually used by user space tools? It sounds like
> it may be exactly those boot order things that we already have flags
> and special behavior for.

Not that many are really part of a non-root workflow.  The biggest
consumer that there's a real /user/ workflow for is Matthew's tpmtotp,
which lets you pick your own when you set it up as root and merely read
from it as a user in perpetuity.  Most workflows are of the same form as
"I run efibootmgr as a user to list things and then use sudo when I
actually need to make some changes."

> And no, I don't believe in the "SMI can trigger a DoS" argument. Those
> garbage efivars that *do* trigger SMI's should me marked and shamed,
> and maybe _they_ need to be added to the list of things that you
> should look out for. Root or not.

It's all of them except the very few that are generated during bootup.
It's worth noting, though, that EFI does not actually require this
implementation behavior in any way.  This is all about Intel's
choice to use SMI to protect the variable store.

> And just on general principlies, I don't want to see weasel-wordy
> commit messages like
> 
>  "Reading certain EFI variables trigger SMIs"
> 
> I understand *writing* them causing SMI's due to some flash protection
> scheme. What's the reading thing? And why aren't we calling that
> garbage out?

Assuming most Intel CPUs work more or less the same as Galileo in this
particular regard, what's going on is the SPI part is connected to the
North Cluster, which presents an MMIO interface to program it, and SMM
is configured so that touching those addresses triggers an SMI.  This
way they can protect the the "authenticated" variables by checking
signatures inside SMM.

So basically it's not "Reading certain variables trigger SMIs", it's
"reading any variable that's not completely fake causes SMI".  The
result is any user can not merely trigger an SMI, but really more like
they can hold it asserted.

> So even if we do need to limit reading, I want out comments (in core
> or commits) to actually explain *Why*., instead of this kind of
> non-specific fear-mongering that nobody can really say yay or nay
> about.

Yeah, makes sense.

There are other options, but they're not great either.  For example, On
most systems the total data is <100kB, so we could make a default-on
config option to just cache it all during boot by default.  Like the
options suggested so far, it has downsides, but it's not the end of the
world for most systems.

-- 
        Peter
