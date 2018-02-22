Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933633AbeBVRy2 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 12:54:28 -0500
Received: from mga02.intel.com ([134.134.136.20]:60587 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933572AbeBVRyS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 12:54:18 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,378,1515484800";
   d="scan'208";a="19565643"
Date: Thu, 22 Feb 2018 09:54:12 -0800
From: "Luck, Tony" <tony.luck@intel.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andi Kleen <ak@linux.intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Joe Konno <joe.konno@linux.intel.com>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jeremy Kerr <jk@ozlabs.org>, Matthew Garrett <mjg59@google.com>,
        Peter Jones <pjones@redhat.com>, Andy Lutomirski <luto@kernel.org>,
        James Bottomley <james.bottomley@hansenpartnership.com>
Subject: Re: [PATCH v2] efivarfs: Limit the rate for non-root to read files
Message-ID: <20180222175411.xzx2d2r2fahn7llo@agluck-desk>
References: <3908561D78D1C84285E8C5FCA982C28F7B37F130@ORSMSX110.amr.corp.intel.com>
 <CA+55aFx3WKAL7e3TAs-2okggW6Z+DHANdmcsr+WTDh3N-Mx+Xw@mail.gmail.com>
 <20180222014505.2l76ccrrs36y3b26@agluck-desk>
 <CA+55aFzJXsPcsJ5MtsxTp2n+43xC0yGzANLNcDm1mFbZKR75FQ@mail.gmail.com>
 <3908561D78D1C84285E8C5FCA982C28F7B37FE28@ORSMSX110.amr.corp.intel.com>
 <CA+55aFy0hRexJkLbN7t31LjfGr4Ae0W5g6sBMqHHJi8aYuGKeA@mail.gmail.com>
 <612E894E-62C8-4155-AED8-D53702EDC8DC@intel.com>
 <CA+55aFxeBaTbwvbWqx1MKYjKKzLUs=1O43Bx2=JaO8qrnY-8HA@mail.gmail.com>
 <20180222171506.wwsichkiyc5f74pr@agluck-desk>
 <CA+55aFyOLYAbvTX0F8WLHgBnhwAPWr7EOPbO_sEepmB5GsCBKQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFyOLYAbvTX0F8WLHgBnhwAPWr7EOPbO_sEepmB5GsCBKQ@mail.gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 22, 2018 at 09:39:10AM -0800, Linus Torvalds wrote:
> I'm certainly ok with this. I'm assuming this has been tested

I read some files using "dd bs=1" as root and non-root.  Root still
goes fast, non-root is limited. Both see the same data. I can ^C the
non-root version and the dd quits as expected:

$ dd if=DefSetup-e8a99903-302c-4851-a6be-ab2731873b2f of=/dev/null bs=1
^C301+0 records in
300+0 records out
300 bytes copied, 3.10487 s, 0.1 kB/s


> and gives nice warnings too?

They seemed very spammy before so I turned them off with this:

+               ratelimit_set_flags(&new->ratelimit, RATELIMIT_MSG_ON_RELEASE);

They looked like this:

[  176.607182] efivarfs_file_read: 42 callbacks suppressed
[  177.611064] efivarfs_file_read: 42 callbacks suppressed
[  178.614931] efivarfs_file_read: 41 callbacks suppressed
[  179.622986] efivarfs_file_read: 42 callbacks suppressed
[  180.630920] efivarfs_file_read: 42 callbacks suppressed
[  181.634839] efivarfs_file_read: 42 callbacks suppressed
[  182.646729] efivarfs_file_read: 42 callbacks suppressed
[  183.658679] efivarfs_file_read: 42 callbacks suppressed
[  184.678664] efivarfs_file_read: 43 callbacks suppressed
[  185.698571] efivarfs_file_read: 43 callbacks suppressed
[  186.703129] efivarfs_file_read: 42 callbacks suppressed
[  187.718510] efivarfs_file_read: 43 callbacks suppressed

With the new "while/nap" change there would still be one message
per second, but the number of callbacks suppressed should be 1
(unless the user has many threads doing reads).

Maybe it is good to know that an application is doing something
stupid and we should drop that line from the patch and let the
warnings flow?

-Tony
