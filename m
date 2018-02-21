Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751372AbeBUTrj (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 14:47:39 -0500
Received: from mga04.intel.com ([192.55.52.120]:23493 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751053AbeBUTrg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 14:47:36 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,375,1515484800";
   d="scan'208";a="32537889"
Date: Wed, 21 Feb 2018 11:47:32 -0800
From: "Luck, Tony" <tony.luck@intel.com>
To: Andi Kleen <ak@linux.intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Joe Konno <joe.konno@linux.intel.com>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matthew Garrett <matthew.garrett@nebula.com>,
        Jeremy Kerr <jk@ozlabs.org>, Matthew Garrett <mjg59@google.com>,
        Peter Jones <pjones@redhat.com>, Andy Lutomirski <luto@kernel.org>,
        James Bottomley <james.bottomley@hansenpartnership.com>
Subject: Re: [PATCH 1/2] fs/efivarfs: restrict inode permissions
Message-ID: <20180221194731.t7jowrmicvaggu3x@agluck-desk>
References: <6680a760-eb30-4daf-2dad-a9628f1c15a8@kernel.org>
 <20180220211849.fqjb6rdmypl6opir@agluck-desk>
 <CA+55aFzjyB=E+=q-W9oYZ7Py7nJwm8YQHFjfbWTib6wvkP9B_A@mail.gmail.com>
 <20180220233008.55rfm7zw62hrao5p@agluck-desk>
 <CA+55aFy8JMLjpDk+sU6pirSZdVqqHtw5oocDAEC7wcHuo5Vssw@mail.gmail.com>
 <3908561D78D1C84285E8C5FCA982C28F7B37DE1B@ORSMSX110.amr.corp.intel.com>
 <CA+55aFwKsa6bq5SUD6wKv8znGcxqjLCPh33a3DkbnUkSfd68Yw@mail.gmail.com>
 <CAKv+Gu--iHii9SxE7RMZKdVdLvQPPGo0wdCzG30xW0+7dakbmw@mail.gmail.com>
 <CA+55aFx4Q7AzCM5mDwga6_LteNUBWQsT6nKJMjn8JcriS3ExuQ@mail.gmail.com>
 <20180221182104.GI3231@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180221182104.GI3231@tassilo.jf.intel.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 21, 2018 at 10:21:04AM -0800, Andi Kleen wrote:
> > But it should be fairly easy to just add a 'struct ratelimit_state' to
> > 'struct user_struct', and then you can easily just use
> > 
> >    '&file->f_cred->user->ratelimit'
> > 
> > and you're done. Make sure the initial root user has it unlimited, and
> > limit it to something reasonable for all other user allocations.
> 
> How about uid name spaces? Someone untrusted in a container could 
> create a lot of uids and switch between them.
> 
> A global rate limit seems better. While in theory it allows DoS
> it's probably not worse than a lot of others we have with
> other resources, and it's relatively harmless.

The EFI calls are all about checking system configuration. A thing
that only a handful of users do on a very occasional basis. I don't
see much harm if my "efibootmgr -v" call is slowed down a bit (or even
a lot) because you are using a bunch of the available ratelimit reading
the efivars.

Per-user seems over engineered to solve this problem.

-Tony
