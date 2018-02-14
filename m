Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031084AbeBNVEO (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 16:04:14 -0500
Received: from mail-io0-f196.google.com ([209.85.223.196]:37640 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030618AbeBNVEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 16:04:13 -0500
X-Google-Smtp-Source: AH8x226zBQmQQ7kIpRAIUkEYt+7LLjK+7eQdJCp7eZmWCp4mk9zXY34ShbMCoW+YTP4qBloKNKsNd/7Vte948MV72GE=
MIME-Version: 1.0
In-Reply-To: <151864141010.23667.12512377970963681490.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <151864141010.23667.12512377970963681490.stgit@dwillia2-desk3.amr.corp.intel.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 14 Feb 2018 13:04:11 -0800
X-Google-Sender-Auth: qJqKA0OAlMnaimxZ5Xf6L2k0Vv4
Message-ID: <CA+55aFxe2Q0vJ5nz-nRvf8n61ZWG2ak2jt=JK_3VFsFbiFS_XQ@mail.gmail.com>
Subject: Re: [PATCH] x86, nospec: Fix uninitialized mask in array_index_mask_nospec()
To: Dan Williams <dan.j.williams@intel.com>
Cc: Ingo Molnar <mingo@kernel.org>, Andi Kleen <ak@linux.intel.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 14, 2018 at 12:50 PM, Dan Williams <dan.j.williams@intel.com> wrote:
> Break the false dependency on the uninitialized value of 'mask' in
> array_index_mask_nospec(). This potentially allows the CPU to rename the
> register, avoids reports from tools that can detect uninitialized inline
> asm arguments, and makes it explicit that this sequence wants the result
> of (0 - 0 - CARRY).

NAK.

This is stupid.

Any asm tools that think this is "uninitialized inline asm arguments"
are complete garbage. It's an output-only register. Fix the tool, or
ignore it as shit.

And that false dependency argument is pure garbage too. Making this an
input that has been initialized to zero doesn't just generate a
pointless zeroing operation, it also adds to register pressure.

So NAK NAK NAK. The arguments for this patch are pure and utter shite.

If somebody can actually show a performance reason (with NUMBERS!) for
it or some _real_ reason to do something this stupid, that's one
thing. But these arguments are just bad, and the patch is bad.

              Linus
