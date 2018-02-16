Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933679AbeBPKls (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 05:41:48 -0500
Received: from mail-io0-f180.google.com ([209.85.223.180]:37100 "EHLO
        mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933633AbeBPKlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 05:41:47 -0500
X-Google-Smtp-Source: AH8x227BPFC/9EX34zdi6nLSOxSdcTVvg2cxACZbkQTT3zllIfV6t7uhISSyWP4CkyIh2X8nX22afD19yj/P/jxUD5Y=
MIME-Version: 1.0
In-Reply-To: <20180215182208.35003-1-joe.konno@linux.intel.com>
References: <20180215182208.35003-1-joe.konno@linux.intel.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Fri, 16 Feb 2018 10:41:45 +0000
Message-ID: <CAKv+Gu80pJ5tbGoJqBm8CCKrEZXdkE83c944383KbQ5jREUC0Q@mail.gmail.com>
Subject: Re: [PATCH 0/2] efivars: reading variables can generate SMIs
To: Joe Konno <joe.konno@linux.intel.com>,
        Matthew Garrett <mjg59@google.com>, Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>
Cc: linux-efi@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jeremy Kerr <jk@ozlabs.org>, Andi Kleen <ak@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Benjamin Drung <benjamin.drung@profitbricks.com>,
        Peter Jones <pjones@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15 February 2018 at 18:22, Joe Konno <joe.konno@linux.intel.com> wrote:
> From: Joe Konno <joe.konno@intel.com>
>
> It was pointed out that normal, unprivileged users reading certain EFI
> variables (through efivarfs) can generate SMIs. Given these nodes are created
> with 0644 permissions, normal users could generate a lot of SMIs. By
> restricting permissions a bit (patch 1), we can make it harder for normal users
> to generate spurious SMIs.
>
> A normal user could generate lots of SMIs by reading the efivarfs in a trivial
> loop:
>
> ```
> while true; do
>     cat /sys/firmware/efi/evivars/* > /dev/null
> done
> ```
>
> Patch 1 in this series limits read and write permissions on efivarfs to the
> owner/superuser. Group and world cannot access.
>
> Patch 2 is for consistency and hygiene. If we restrict permissions for either
> efivarfs or efi/vars, the other interface should get the same treatment.
>

I am inclined to apply this as a fix, but I will give the x86 guys a
chance to respond as well.


> Joe Konno (2):
>   fs/efivarfs: restrict inode permissions
>   efi: restrict top-level attribute permissions
>
>  drivers/firmware/efi/efi.c | 10 ++++++----
>  fs/efivarfs/super.c        |  4 ++--
>  2 files changed, 8 insertions(+), 6 deletions(-)
>
> --
> 2.14.1
>
