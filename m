Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967837AbeBNNVb (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 08:21:31 -0500
Received: from mail-wm0-f42.google.com ([74.125.82.42]:52739 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967798AbeBNNV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 08:21:29 -0500
X-Google-Smtp-Source: AH8x2274CdlfImh5D5rIGBz9jCHZI4QpQdU7fi7AZWxMd0XQ9azirx4hffv5wHPcBkcRJaoWsv4+6A==
Message-ID: <1518614486.4749.33.camel@profitbricks.com>
Subject: Re: Read-protected UEFI variables
From: Benjamin Drung <benjamin.drung@profitbricks.com>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Matthew Garrett <matthew.garrett@nebula.com>,
        Jeremy Kerr <jk@ozlabs.org>, Matt Fleming <matt@codeblueprint.co.uk>,
        linux-efi@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date: Wed, 14 Feb 2018 14:21:26 +0100
In-Reply-To: <CAKv+Gu_V7BCihPhZf=pKrkBZwFWeEoupamXvYSqdS+k93Gme=g@mail.gmail.com>
References: <1518612748.4749.29.camel@profitbricks.com>
         <CAKv+Gu_V7BCihPhZf=pKrkBZwFWeEoupamXvYSqdS+k93Gme=g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, den 14.02.2018, 13:09 +0000 schrieb Ard Biesheuvel:
> On 14 February 2018 at 12:52, Benjamin Drung
> <benjamin.drung@profitbricks.com> wrote:
> > Hi,
> > 
> > I am exploring the possibility to store SSH and other keys in UEFI
> > variables for systems that do not have persistent storage. These
> > systems boot via network and need individual SSH keys which ideally
> > should not be distributed via network.
> > 
> > The plan is to write a small daemon that starts at boot and gets
> > the
> > SSH keys from EFI variables to individualize the system with SSH
> > keys.
> > I plan to release the code as free software. Simple proof-of-
> > concept
> > code:
> > 
> > mount -t efivarfs none /sys/firmware/efi/efivars
> > for key in ssh_host_dsa_key ssh_host_ecdsa_key ssh_host_rsa_key; do
> >   dd ibs=1 skip=4 if=/sys/firmware/efi/efivars/${key}-89df11f4-
> > 38e6-473e-ab43-b4406b76fba9 of=/etc/ssh/$key
> > done
> > 
> > I am not the first person having the idea to use UEFI variables to
> > store keys:
> > https://www.usenix.org/conference/srecon17asia/program/presentation
> > /korgachin
> > 
> > There is one problem: The keys should be readable only by root.
> > When
> > mounting efivarfs, all variables have the permission 644 which
> > makes
> > them readable by all users. I have different ideas how to solve it:
> > 
> > 1) Hard-code a list of GUIDs that should be only readable by root
> > in
> > the kernel module. These modules would also be not set to
> > immutable.
> > 
> > 2) Instead of hard-coding GUIDs, add a kernel module parameter to
> > specify the GUIDs. Maybe have a default list in the kernel module.
> > 
> > 3) Add a mount option to specify the protected GUIDs.
> > 
> > Feedback is welcome.
> > 
> 
> I'd consider a patch that makes the permissions a mount option for
> efivarfs, applying to all variables. The reason is that these
> variables shouldn't have been world readable in the first place, and
> I
> am reluctant to make this overly complex.

Having some variables (like the BootXXXX and BootOrder variables) world
readable is useful. This allows normal users to run 'efibootmgr' to
display the boot options.

> On the other hand, you should realize that UEFI was never designed to
> keep secrets, and so whether it is a good idea to put secrets in UEFI
> variables to begin with is dubious IMHO.

If the UEFI is as secure as storing an unencrypted file on a hard
drive, I am satisfied. Or do you have a better idea where to store the
SSH keys for a diskless system that boots via network?

-- 
Benjamin Drung
System Developer
Debian & Ubuntu Developer

ProfitBricks GmbH
Greifswalder Str. 207
D - 10405 Berlin

Email: benjamin.drung@profitbricks.com
URL: https://www.profitbricks.de

Sitz der Gesellschaft: Berlin
Registergericht: Amtsgericht Charlottenburg, HRB 125506 B
Geschäftsführer: Achim Weiss, Matthias Steinberg
