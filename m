Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751368AbeBUCQW (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 21:16:22 -0500
Received: from mail-it0-f41.google.com ([209.85.214.41]:52516 "EHLO
        mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751017AbeBUCQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 21:16:21 -0500
X-Google-Smtp-Source: AH8x226aVLgAO9IsE3zNOGO9J1I4UW8EybtzYU+M2EKYBGVEEzpFoqtpVJSBaVN5nLnvM/ch5q/puRi2S1jnIAAjyME=
MIME-Version: 1.0
In-Reply-To: <3908561D78D1C84285E8C5FCA982C28F7B37DE1B@ORSMSX110.amr.corp.intel.com>
References: <20180215182208.35003-1-joe.konno@linux.intel.com>
 <20180215182208.35003-2-joe.konno@linux.intel.com> <6680a760-eb30-4daf-2dad-a9628f1c15a8@kernel.org>
 <20180220211849.fqjb6rdmypl6opir@agluck-desk> <CA+55aFzjyB=E+=q-W9oYZ7Py7nJwm8YQHFjfbWTib6wvkP9B_A@mail.gmail.com>
 <20180220233008.55rfm7zw62hrao5p@agluck-desk> <CA+55aFy8JMLjpDk+sU6pirSZdVqqHtw5oocDAEC7wcHuo5Vssw@mail.gmail.com>
 <3908561D78D1C84285E8C5FCA982C28F7B37DE1B@ORSMSX110.amr.corp.intel.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 20 Feb 2018 18:16:19 -0800
X-Google-Sender-Auth: hKcliz5w_28v3nvOv13_ZEw48VQ
Message-ID: <CA+55aFwKsa6bq5SUD6wKv8znGcxqjLCPh33a3DkbnUkSfd68Yw@mail.gmail.com>
Subject: Re: [PATCH 1/2] fs/efivarfs: restrict inode permissions
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Joe Konno <joe.konno@linux.intel.com>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
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

On Tue, Feb 20, 2018 at 5:05 PM, Luck, Tony <tony.luck@intel.com> wrote:
>>> EFI[1] stinks. Reading any file in /sys/firmware/efi/efivars/ generates
>>> 4 (yes FOUR!) SMIs.
>
>> Is that actualkly the normal implementation?
>
> I don't know if there are other implementations. This is what I see on my
> lab system.

Ok. I'm not a huge fan of EFI. Over-designed to the hilt. Happily at
least the loadable drivers are a thing of the past.

Do we have a list of things normal users care about? Because one thing
that would solve it is caching of the values. We don't want to do that
in general, but maybe we could just do it for the subset that we think
are "user accessible".

Although maybe just that "rate limit" thing would be simplest.

I don't want to break existing users, although it's not entirely clear
to me if there are any real use cases that matter to users. If tpmtotp
is the main case, maybe that can be changed to work around it and just
cache a value or something?

So I could imagine just applying Joe's / Andy's patch to see if
anybody even notices. But if somebody does, we'd have to go to the
alternatives anyway.

                Linus
