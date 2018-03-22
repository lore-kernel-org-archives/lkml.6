Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752131AbeCVT74 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 15:59:56 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:44517 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751771AbeCVT7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 15:59:53 -0400
X-Google-Smtp-Source: AG47ELuSCoFA4wXFblS37t+YOu7Ohdc8s3wYCp+9WdHI5lZV8DL97NDr3VcidvOWWHL90w26Zirg+Q==
Subject: Re: [PATCH] floppy: Do not copy a kernel pointer to user memory in
 FDGETPRM ioctl
To: Jiri Kosina <jikos@kernel.org>, linux-kernel@vger.kernel.org
References: <1520467365-7194-1-git-send-email-bbellevi@uci.edu>
From: Brian Belleville <bbellevi@uci.edu>
Message-ID: <ca7b2e22-483c-f16f-2a41-04fb936bba9b@uci.edu>
Date: Thu, 22 Mar 2018 12:59:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1520467365-7194-1-git-send-email-bbellevi@uci.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, are there any comments on this patch or the issue I described? I 
have tested the FDGETPRM ioctl and confirmed that the struct it returns 
does contain a pointer to kernel data. I also have tested my patch, and 
with it applied the returned struct no longer contains a kernel pointer, 
but all other fields are still present.

Thank you,
Brian Belleville


On 03/07/2018 04:02 PM, Brian Belleville wrote:
> The final field of a floppy_struct is the field "name", which is a
> pointer to a string in kernel memory. The kernel pointer should not be
> copied to user memory. The FDGETPRM ioctl copies a floppy_struct to
> user memory, including the "name" field. This pointer cannot be used
> by the user, and it will leak a kernel address to user-space, which
> will reveal the location of kernel code and data and undermine KASLR
> protection. Instead, copy the floppy_struct except for the "name"
> field.
> 
> Signed-off-by: Brian Belleville <bbellevi@uci.edu>
> ---
>   drivers/block/floppy.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
> index eae484a..4d4a422 100644
> --- a/drivers/block/floppy.c
> +++ b/drivers/block/floppy.c
> @@ -3470,6 +3470,7 @@ static int fd_locked_ioctl(struct block_device *bdev, fmode_t mode, unsigned int
>   					  (struct floppy_struct **)&outparam);
>   		if (ret)
>   			return ret;
> +		size = offsetof(struct floppy_struct, name);
>   		break;
>   	case FDMSGON:
>   		UDP->flags |= FTD_MSG;
> 
