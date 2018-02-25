Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751665AbeBYK41 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Feb 2018 05:56:27 -0500
Received: from mail-it0-f67.google.com ([209.85.214.67]:51137 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751557AbeBYK4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Feb 2018 05:56:23 -0500
X-Google-Smtp-Source: AG47ELv8FiaNnDSuIvIo7n8FkKJeGn7wYfsksAhbFIEcQwANqAIc2ZbrC3aJ+8nrlD6EWj40RxZ37a6ISWnNb/S0WVQ=
MIME-Version: 1.0
In-Reply-To: <20180224200617.75cfe5f2@alans-desktop>
References: <20180215182208.35003-1-joe.konno@linux.intel.com>
 <20180215182208.35003-2-joe.konno@linux.intel.com> <6680a760-eb30-4daf-2dad-a9628f1c15a8@kernel.org>
 <20180220211849.fqjb6rdmypl6opir@agluck-desk> <CA+55aFzjyB=E+=q-W9oYZ7Py7nJwm8YQHFjfbWTib6wvkP9B_A@mail.gmail.com>
 <20180220233008.55rfm7zw62hrao5p@agluck-desk> <CA+55aFy8JMLjpDk+sU6pirSZdVqqHtw5oocDAEC7wcHuo5Vssw@mail.gmail.com>
 <3908561D78D1C84285E8C5FCA982C28F7B37DE1B@ORSMSX110.amr.corp.intel.com>
 <CA+55aFwKsa6bq5SUD6wKv8znGcxqjLCPh33a3DkbnUkSfd68Yw@mail.gmail.com>
 <CAKv+Gu--iHii9SxE7RMZKdVdLvQPPGo0wdCzG30xW0+7dakbmw@mail.gmail.com> <20180224200617.75cfe5f2@alans-desktop>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Sun, 25 Feb 2018 10:56:22 +0000
Message-ID: <CAKv+Gu86gohjooxurSr1KTfbUKPP-wf+XHdN88OrF=Pta9Ug3A@mail.gmail.com>
Subject: Re: [PATCH 1/2] fs/efivarfs: restrict inode permissions
To: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        "Luck, Tony" <tony.luck@intel.com>,
        Joe Konno <joe.konno@linux.intel.com>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matthew Garrett <matthew.garrett@nebula.com>,
        Jeremy Kerr <jk@ozlabs.org>, Andi Kleen <ak@linux.intel.com>,
        Matthew Garrett <mjg59@google.com>, Peter Jones <pjones@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        James Bottomley <james.bottomley@hansenpartnership.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24 February 2018 at 20:06, Alan Cox <gnomes@lxorguk.ukuu.org.uk> wrote:
> On Wed, 21 Feb 2018 09:03:00 +0000
>> The thing I like about rate limiting (for everyone including root) is
>> that it does not break anybody's workflow (unless EFI variable access
>> occurs on a hot path, in which case you're either a) asking for it, or
>> b) the guy trying to DoS us), and that it can make exploitation of any
>> potential Spectre v1 vulnerabilities impractical at the same time. At
>
> b) doesn't make spectre v1 much harder alas. What matters there is that
> you turn on the right CPU protections before calling into EFI and turn
> them off afterwards. EFI firmware internally isn't built with retpoline
> anyway.
>

Well, that is exactly my concern. The parsing code in the
authenticated variable routines in UEFI may well contain sequences
that are exploitable, due to UEFI's heavy reliance on protocols
involving function pointers, and the fact that a variable update is
structured data (with bounds that may need checking). Also, this code
is highly likely to remain unpatched on many systems, and it usually
appears in the same place in memory regardless of KASLR. However, only
root can call SetVariable(), so perhaps the risk is limited after all?

I had a stab (for arm64) at unmapping the kernel while UEFI calls are
in progress, which is a fairly big hammer, but effective, given that
UEFI itself does not keep any secrets in the first place, and so if
the kernel isn't mapped, there isn't anything to steal to begin with.
Note that on arm64, Spectre v2 should not be a concern, due to the
branch predictor maintenance that takes place when entering the
kernel. But Spectre v1 in UEFI runtime service code is currently
unmitigated, and I wonder what the risk level really is.
