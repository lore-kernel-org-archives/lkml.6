Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752093AbeBTTTX (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 14:19:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:58284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751854AbeBTTTV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 14:19:21 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0762621104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=luto@kernel.org
Subject: Re: [PATCH 1/2] fs/efivarfs: restrict inode permissions
To: Joe Konno <joe.konno@linux.intel.com>, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: ard.biesheuvel@linaro.org, matthew.garrett@nebula.com, jk@ozlabs.org,
        ak@linux.intel.com, tony.luck@intel.com
References: <20180215182208.35003-1-joe.konno@linux.intel.com>
 <20180215182208.35003-2-joe.konno@linux.intel.com>
From: Andy Lutomirski <luto@kernel.org>
Message-ID: <6680a760-eb30-4daf-2dad-a9628f1c15a8@kernel.org>
Date: Tue, 20 Feb 2018 11:18:57 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180215182208.35003-2-joe.konno@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/15/2018 10:22 AM, Joe Konno wrote:
> From: Joe Konno <joe.konno@intel.com>
> 
> Efivarfs nodes are created with group and world readable permissions.
> Reading certain EFI variables trigger SMIs. So, this is a potential DoS
> surface.
> 
> Make permissions more restrictive-- only the owner may read or write to
> created inodes.
> 
> Suggested-by: Andi Kleen <ak@linux.intel.com>
> Reported-by: Tony Luck <tony.luck@intel.com>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Cc: Matthew Garrett <matthew.garrett@nebula.com>
> Cc: Jeremy Kerr <jk@ozlabs.org>
> Cc: linux-efi@vger.kernel.org
> Cc: stable@vger.kernel.org
> Signed-off-by: Joe Konno <joe.konno@intel.com>

The discussion in this thread has gone on too long, so:

Acked-by: Andy Lutomirski <luto@kernel.org>

And yes, this patch will break a couple of minor usecases, but IMO those 
usecases deserve to break.

> ---
>   fs/efivarfs/super.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
> index 5b68e4294faa..ca98c4e31eb7 100644
> --- a/fs/efivarfs/super.c
> +++ b/fs/efivarfs/super.c
> @@ -145,7 +145,7 @@ static int efivarfs_callback(efi_char16_t *name16, efi_guid_t vendor,
>   
>   	name[len + EFI_VARIABLE_GUID_LEN+1] = '\0';
>   
> -	inode = efivarfs_get_inode(sb, d_inode(root), S_IFREG | 0644, 0,
> +	inode = efivarfs_get_inode(sb, d_inode(root), S_IFREG | 0600, 0,
>   				   is_removable);
>   	if (!inode)
>   		goto fail_name;
> @@ -207,7 +207,7 @@ static int efivarfs_fill_super(struct super_block *sb, void *data, int silent)
>   	sb->s_d_op		= &efivarfs_d_ops;
>   	sb->s_time_gran         = 1;
>   
> -	inode = efivarfs_get_inode(sb, NULL, S_IFDIR | 0755, 0, true);
> +	inode = efivarfs_get_inode(sb, NULL, S_IFDIR | 0700, 0, true);
>   	if (!inode)
>   		return -ENOMEM;
>   	inode->i_op = &efivarfs_dir_inode_operations;
> 
