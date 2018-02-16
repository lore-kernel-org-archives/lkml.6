Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750880AbeBPVpm (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 16:45:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:36238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750763AbeBPVpk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 16:45:40 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 493F7217D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=luto@kernel.org
X-Google-Smtp-Source: AH8x2271FfNU1aGVuHdWRQt4urbHkp2t7YFAhyjH2khUOBInmUD+vQKYFmUXDR8wIbwIEcDHCG6GmRwkvrbI8UKFhm8=
MIME-Version: 1.0
In-Reply-To: <3908561D78D1C84285E8C5FCA982C28F7B37942B@ORSMSX110.amr.corp.intel.com>
References: <20180215182208.35003-1-joe.konno@linux.intel.com>
 <CAKv+Gu80pJ5tbGoJqBm8CCKrEZXdkE83c944383KbQ5jREUC0Q@mail.gmail.com>
 <1518814319.4419.10.camel@HansenPartnership.com> <3908561D78D1C84285E8C5FCA982C28F7B37942B@ORSMSX110.amr.corp.intel.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Fri, 16 Feb 2018 21:45:19 +0000
X-Gmail-Original-Message-ID: <CALCETrXD4qCwgnDcwnybUXzVk7zyJtzHC2xzLfcZvzrXvAB8PQ@mail.gmail.com>
Message-ID: <CALCETrXD4qCwgnDcwnybUXzVk7zyJtzHC2xzLfcZvzrXvAB8PQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] efivars: reading variables can generate SMIs
To: "Luck, Tony" <tony.luck@intel.com>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Joe Konno <joe.konno@linux.intel.com>,
        Matthew Garrett <mjg59@google.com>, Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jeremy Kerr <jk@ozlabs.org>, Andi Kleen <ak@linux.intel.com>,
        Benjamin Drung <benjamin.drung@profitbricks.com>,
        Peter Jones <pjones@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 16, 2018 at 9:09 PM, Luck, Tony <tony.luck@intel.com> wrote:
>> That said, I'm not sure how many non-root users run the toolkit to
>> extract their EFI certificates or check on the secure boot status of
>> the system, but I suspect it might be non-zero: I can see the tinfoil
>> hat people wanting at least to check the secure boot status when they
>> log in.
>
> Another fix option might be to rate limit EFI calls for non-root users (on X86
> since only we have the SMI problem). That would:
>
> 1) Avoid using memory to cache all the variables
> 2) Catch any other places where non-root users can call EFI

I'm going to go out on a limb and suggest that the fact that
unprivileged users can read efi variables at all is a mistake
regardless of SMI issues.

Also, chmod() just shouldn't work on efi variables, and the mode
passed to creat() should be ignored.  After all, there's no backing
store for the mode.
