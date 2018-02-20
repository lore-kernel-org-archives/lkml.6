Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752004AbeBTXaO (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 18:30:14 -0500
Received: from mga12.intel.com ([192.55.52.136]:9028 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751860AbeBTXaN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 18:30:13 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,541,1511856000";
   d="scan'208";a="19059857"
Date: Tue, 20 Feb 2018 15:30:09 -0800
From: "Luck, Tony" <tony.luck@intel.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Joe Konno <joe.konno@linux.intel.com>, linux-efi@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Matthew Garrett <matthew.garrett@nebula.com>,
        Jeremy Kerr <jk@ozlabs.org>, Andi Kleen <ak@linux.intel.com>,
        Matthew Garrett <mjg59@google.com>, Peter Jones <pjones@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        James Bottomley <james.bottomley@hansenpartnership.com>
Subject: Re: [PATCH 1/2] fs/efivarfs: restrict inode permissions
Message-ID: <20180220233008.55rfm7zw62hrao5p@agluck-desk>
References: <20180215182208.35003-1-joe.konno@linux.intel.com>
 <20180215182208.35003-2-joe.konno@linux.intel.com>
 <6680a760-eb30-4daf-2dad-a9628f1c15a8@kernel.org>
 <20180220211849.fqjb6rdmypl6opir@agluck-desk>
 <CA+55aFzjyB=E+=q-W9oYZ7Py7nJwm8YQHFjfbWTib6wvkP9B_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFzjyB=E+=q-W9oYZ7Py7nJwm8YQHFjfbWTib6wvkP9B_A@mail.gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 20, 2018 at 02:01:51PM -0800, Linus Torvalds wrote:
> And just on general principlies, I don't want to see weasel-wordy
> commit messages like
> 
>  "Reading certain EFI variables trigger SMIs"
> 
> I understand *writing* them causing SMI's due to some flash protection
> scheme. What's the reading thing? And why aren't we calling that
> garbage out?

Too much weasel there.  Should say:

EFI[1] stinks. Reading any file in /sys/firmware/efi/efivars/ generates
4 (yes FOUR!) SMIs.

# rdmsr 0x34
14e2
# cat /sys/firmware/efi/efivars/ConIn-8be4df61-93ca-11d2-aa0d-00e098032b8c > /dev/null
# rdmsr 0x34
14e6

-Tony

[1] I didn't dig through the Linux code to check whether we manage to
get those four SMIs from a single EFI call, or whether we make multiple
EFI calls to open/read/close one file. It is possible that we stink a
bit too if we are doing more EFI calls than required.
