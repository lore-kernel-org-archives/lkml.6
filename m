Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754672AbeDZX4s (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 19:56:48 -0400
Received: from imap.thunk.org ([74.207.234.97]:36160 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751626AbeDZX4q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 19:56:46 -0400
Date: Thu, 26 Apr 2018 19:56:30 -0400
From: "Theodore Y. Ts'o" <tytso@mit.edu>
To: Sultan Alsawaf <sultanxda@gmail.com>
Cc: linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>
Subject: Re: Linux messages full of `random: get_random_u32 called from`
Message-ID: <20180426235630.GG5965@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Sultan Alsawaf <sultanxda@gmail.com>, linux-kernel@vger.kernel.org,
        Jann Horn <jannh@google.com>
References: <d92d049a-8810-a765-d57a-2a7a805fadaf@gmail.com>
 <20180426050056.GF18803@thunk.org>
 <b902d9f5-300e-2611-289d-f6d49dd43f11@gmail.com>
 <20180426073255.GH18803@thunk.org>
 <b6aa3fac-a768-e27d-3070-00d929ebc245@gmail.com>
 <20180426192524.GD5965@thunk.org>
 <2add15cb-2113-0504-a732-81255ea61bf5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2add15cb-2113-0504-a732-81255ea61bf5@gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 26, 2018 at 01:22:02PM -0700, Sultan Alsawaf wrote:
> 
> Also, regardless of what's hanging on CRNG init, CRNG should be able to init on its own in a timely
> manner without the need for user-provided entropy. Userspace was working fine before the recent CRNG
> kernel changes, so I don't think this is a userspace bug.

The CRNG changes were needed because were erroneously saying that the
entropy pool was securely initialized before it really was.  Saying
that CRNG should be able to init on its own is much like saying, "Ted
should be able to fly wherever he wants in his own personal Gulfstream
V."  It would certainly be _nice_ if I could afford my personal jet.
I certainly wish I were that rich.  But the problem is that dollars
(or Euro's) are like entropy, they don't just magically drop out of
the sky.

If there isn't user-provided entropy, and the hardware isn't providing
sufficient entropy, where did you think the kernel is supposed to get
the entropy from?  Should it dial 1-800-TRUST-NSA?

>From the dmesg log, you have a Chromebook Acer 14.  I'm guessing the
problem is that Chromebooks have hardware tries *very* hard not to
issue interrupts, since that helps with power savings.  The following
from your dmesg is very interesting:

[    0.526786] tpm tpm0: [Firmware Bug]: TPM interrupt not working, polling instead

I suspect this isn't a firmware bug; it's the hardware working as
intended / working as designed, for power savings reasons.

So there are two ways to fix this that I can see.  One is to try to
adjust userspace so that it allows the boot to proceed.  As there is
more activity, the disk completion interrupts, the user typing their
username/password into the login screen, etc., there will be timing
events which can be used to harvest entropy.

The other approach would be to compile the kernel with
CONFIG_HW_RANDOM_TPM and to modify drivers/char/tpm/tpm-chip.c tot
initalize chip->hwrng.quality = 500.  We've historically made this
something that the system administrator must set via sysfs.  This is
because we wanted system adminisrators to explicitly say that they
trust the any hardware manufacturer that (a) they haven't been paid by
your choice of the Chinese MSS or the US NSA to introduce a backdoor,i
and (b) they are competent to actually implemnt a _secure_ hardware
random number generator.  Sadly, this has not always been the case.
Please see:

	https://www.chromium.org/chromium-os/tpm_firmware_update

And note that your Edgar Chromebook is one the list of devices that
have a TPM with the buggy firmware.  Fortunately this particular TPM
bug only affects RSA prime generation, so as far as I know there is no
_known_ vulerability in your TPM's hardware random number generator.
B ut we want it to be _your_ responsibility to decide you are willing
to truste it.  I certainly don't want to be legally liable --- or even
have the moral responsibility --- of guaranteeing that every single
TPM out there is bug-free(tm).

					- Ted
