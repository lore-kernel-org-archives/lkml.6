Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967803AbeBNNKB (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 08:10:01 -0500
Received: from mail-it0-f48.google.com ([209.85.214.48]:36498 "EHLO
        mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967706AbeBNNKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 08:10:00 -0500
X-Google-Smtp-Source: AH8x225OcoP0HPx/vrTtimScjnYEWU3d/inXXmjysu8TCY3P/BR7Am/q1WV0YEaOswyXq0uN5GXG8Hs01/67TQa0pho=
MIME-Version: 1.0
In-Reply-To: <1518612748.4749.29.camel@profitbricks.com>
References: <1518612748.4749.29.camel@profitbricks.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Wed, 14 Feb 2018 13:09:59 +0000
Message-ID: <CAKv+Gu_V7BCihPhZf=pKrkBZwFWeEoupamXvYSqdS+k93Gme=g@mail.gmail.com>
Subject: Re: Read-protected UEFI variables
To: Benjamin Drung <benjamin.drung@profitbricks.com>
Cc: Matthew Garrett <matthew.garrett@nebula.com>,
        Jeremy Kerr <jk@ozlabs.org>, Matt Fleming <matt@codeblueprint.co.uk>,
        linux-efi@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14 February 2018 at 12:52, Benjamin Drung
<benjamin.drung@profitbricks.com> wrote:
> Hi,
>
> I am exploring the possibility to store SSH and other keys in UEFI
> variables for systems that do not have persistent storage. These
> systems boot via network and need individual SSH keys which ideally
> should not be distributed via network.
>
> The plan is to write a small daemon that starts at boot and gets the
> SSH keys from EFI variables to individualize the system with SSH keys.
> I plan to release the code as free software. Simple proof-of-concept
> code:
>
> mount -t efivarfs none /sys/firmware/efi/efivars
> for key in ssh_host_dsa_key ssh_host_ecdsa_key ssh_host_rsa_key; do
>   dd ibs=1 skip=4 if=/sys/firmware/efi/efivars/${key}-89df11f4-38e6-473e-ab43-b4406b76fba9 of=/etc/ssh/$key
> done
>
> I am not the first person having the idea to use UEFI variables to
> store keys:
> https://www.usenix.org/conference/srecon17asia/program/presentation/korgachin
>
> There is one problem: The keys should be readable only by root. When
> mounting efivarfs, all variables have the permission 644 which makes
> them readable by all users. I have different ideas how to solve it:
>
> 1) Hard-code a list of GUIDs that should be only readable by root in
> the kernel module. These modules would also be not set to immutable.
>
> 2) Instead of hard-coding GUIDs, add a kernel module parameter to
> specify the GUIDs. Maybe have a default list in the kernel module.
>
> 3) Add a mount option to specify the protected GUIDs.
>
> Feedback is welcome.
>

I'd consider a patch that makes the permissions a mount option for
efivarfs, applying to all variables. The reason is that these
variables shouldn't have been world readable in the first place, and I
am reluctant to make this overly complex.

On the other hand, you should realize that UEFI was never designed to
keep secrets, and so whether it is a good idea to put secrets in UEFI
variables to begin with is dubious IMHO.
