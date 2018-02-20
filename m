Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751563AbeBTWBz (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 17:01:55 -0500
Received: from mail-it0-f54.google.com ([209.85.214.54]:40626 "EHLO
        mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750773AbeBTWBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 17:01:53 -0500
X-Google-Smtp-Source: AH8x227KZhzz7bUawZeP4Ut/AMjh0JC2PIb6t9k6Oc2DnGVhAIH+D+4xBBKmfE6k6Nq3WCuUsB+IVvsqWL/ZKJiK7oU=
MIME-Version: 1.0
In-Reply-To: <20180220211849.fqjb6rdmypl6opir@agluck-desk>
References: <20180215182208.35003-1-joe.konno@linux.intel.com>
 <20180215182208.35003-2-joe.konno@linux.intel.com> <6680a760-eb30-4daf-2dad-a9628f1c15a8@kernel.org>
 <20180220211849.fqjb6rdmypl6opir@agluck-desk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 20 Feb 2018 14:01:51 -0800
X-Google-Sender-Auth: aObiZiaw4rkvwuU3jRUr-xLS8l0
Message-ID: <CA+55aFzjyB=E+=q-W9oYZ7Py7nJwm8YQHFjfbWTib6wvkP9B_A@mail.gmail.com>
Subject: Re: [PATCH 1/2] fs/efivarfs: restrict inode permissions
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Joe Konno <joe.konno@linux.intel.com>, linux-efi@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Matthew Garrett <matthew.garrett@nebula.com>,
        Jeremy Kerr <jk@ozlabs.org>, Andi Kleen <ak@linux.intel.com>,
        Matthew Garrett <mjg59@google.com>, Peter Jones <pjones@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        James Bottomley <james.bottomley@hansenpartnership.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 20, 2018 at 1:18 PM, Luck, Tony <tony.luck@intel.com> wrote:
> ...
>> > -   inode = efivarfs_get_inode(sb, d_inode(root), S_IFREG | 0644, 0,
>> > +   inode = efivarfs_get_inode(sb, d_inode(root), S_IFREG | 0600, 0,
>> >                                is_removable);
>
> Linus,
>
> Does this rate an exception to the "don't break userspace" for a security issue?

I have a hard time judging, since I don't know what the breakage is.

_Theoretical_ breakage doesn't matter.

But yes, if it's actually part of some regular use flow, then it
matters, and we should not do this change. It's not a real security
issue, afaik.

I do think that we might need to just extend on the whitelist for efi
variables we _already_ have for other reasons. I'm talking about that
whole variable_validate[] array.

Which variables are actually used by user space tools? It sounds like
it may be exactly those boot order things that we already have flags
and special behavior for.

And no, I don't believe in the "SMI can trigger a DoS" argument. Those
garbage efivars that *do* trigger SMI's should me marked and shamed,
and maybe _they_ need to be added to the list of things that you
should look out for. Root or not.

And just on general principlies, I don't want to see weasel-wordy
commit messages like

 "Reading certain EFI variables trigger SMIs"

I understand *writing* them causing SMI's due to some flash protection
scheme. What's the reading thing? And why aren't we calling that
garbage out?

So even if we do need to limit reading, I want out comments (in core
or commits) to actually explain *Why*., instead of this kind of
non-specific fear-mongering that nobody can really say yay or nay
about.

               Linus
