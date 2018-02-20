Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751879AbeBTXTZ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 18:19:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:40620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751779AbeBTXTX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 18:19:23 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09F33217A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=luto@kernel.org
X-Google-Smtp-Source: AH8x2256TdnL3+1GFJaIbQYre24Hx6yXIUV6oPdXY/rEd9Ub/AkM/n6UojaacAjhLTTvgeL3M1xaZqelF26DqZJtXlU=
MIME-Version: 1.0
In-Reply-To: <6680a760-eb30-4daf-2dad-a9628f1c15a8@kernel.org>
References: <20180215182208.35003-1-joe.konno@linux.intel.com>
 <20180215182208.35003-2-joe.konno@linux.intel.com> <6680a760-eb30-4daf-2dad-a9628f1c15a8@kernel.org>
From: Andy Lutomirski <luto@kernel.org>
Date: Tue, 20 Feb 2018 23:19:01 +0000
X-Gmail-Original-Message-ID: <CALCETrW4e_Q4fO2Qd50nhXgtngGFZo7UnEM_ATt6RPckj=Rv=A@mail.gmail.com>
Message-ID: <CALCETrW4e_Q4fO2Qd50nhXgtngGFZo7UnEM_ATt6RPckj=Rv=A@mail.gmail.com>
Subject: Re: [PATCH 1/2] fs/efivarfs: restrict inode permissions
To: Andy Lutomirski <luto@kernel.org>
Cc: Joe Konno <joe.konno@linux.intel.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>, matthew.garrett@nebula.com,
        Jeremy Kerr <jk@ozlabs.org>, Andi Kleen <ak@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 20, 2018 at 7:18 PM, Andy Lutomirski <luto@kernel.org> wrote:
> On 02/15/2018 10:22 AM, Joe Konno wrote:
>>
>> From: Joe Konno <joe.konno@intel.com>
>>
>> Efivarfs nodes are created with group and world readable permissions.
>> Reading certain EFI variables trigger SMIs. So, this is a potential DoS
>> surface.
>>
>> Make permissions more restrictive-- only the owner may read or write to
>> created inodes.
>>
>> Suggested-by: Andi Kleen <ak@linux.intel.com>
>> Reported-by: Tony Luck <tony.luck@intel.com>
>> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> Cc: Matthew Garrett <matthew.garrett@nebula.com>
>> Cc: Jeremy Kerr <jk@ozlabs.org>
>> Cc: linux-efi@vger.kernel.org
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Joe Konno <joe.konno@intel.com>
>
>
> The discussion in this thread has gone on too long, so:
>
> Acked-by: Andy Lutomirski <luto@kernel.org>
>
> And yes, this patch will break a couple of minor usecases, but IMO those
> usecases deserve to break.

Alternatively, a patch like this (untested but straightforward) might
be a little more effective and easier to undo in userspace for anyone
who may be adversely affected:

diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
index 5b68e4294faa..88c7163c0ac1 100644
--- a/fs/efivarfs/super.c
+++ b/fs/efivarfs/super.c
@@ -207,7 +207,7 @@ static int efivarfs_fill_super(struct super_block
*sb, void *data, int silent)
        sb->s_d_op              = &efivarfs_d_ops;
        sb->s_time_gran         = 1;

-       inode = efivarfs_get_inode(sb, NULL, S_IFDIR | 0755, 0, true);
+       inode = efivarfs_get_inode(sb, NULL, S_IFDIR | 0700, 0, true);
        if (!inode)
                return -ENOMEM;
        inode->i_op = &efivarfs_dir_inode_operations;

If you prefer that, I'd be happy to re-send it for real.

--Andy
