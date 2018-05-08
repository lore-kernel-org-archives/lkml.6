Return-Path: <hdegoede@redhat.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525779965; cv=none;
        d=google.com; s=arc-20160816;
        b=qVK+54PFVLaID0O3Ap5zME39OHEX5L/l2vFrV1ohRsNg8NVXlt9D/ZqPOupN5BzgYv
         Jybg2SbMOMWhwPR4zqBgO//mU+BdpPygxOx3UOKuE27jey9ImLRIiqNbtffE5E8uL5w6
         5La/OiuTJRe8b1RrMMtZfVR37HbETtj8qJNX+4eESvpPZIr0VIj7aFOefObLdFYdCqQF
         FX/na0bmxJz/lXuPezRNMmOOYxUPQ6QIyJo5tkluGQR2KmjDY/4I93ggsCcLr54QXMe3
         W9ToZDdOCsfhOTTWqHsSmAmatOnZeV6X3Vm7vL3seoCfcpFi9jNbrHSaK6RPeLKbEQgr
         N0ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=R7/dNltBoYetjWA5Hs9c3/dRuB2tu2NJz5Wnt0Qp+j4=;
        b=avnlO/qriCGu0Ub9QbAA95TJ1MR+kAKVEVFAugUNKimx4LAZyUVvYPfR+pi413S3QL
         TgArvGhpstnVSVdqdgCMXbJzzWIZlflD9J/wPzeSbLinNoneOGFnRcg8GBreLxN6Px/A
         Zh6VJ1HnOYg1syMX6uuRm/QI956KtQY5qihz0G+rmNdumtvekcJCGZDbSpkbv4uJ+wCG
         qNcRNrQObEn+0Ply8LBWY+FTrGv2cMA0hXLO7k6vJmoPzzTbRoAtUbsyPCh1E4McGCt2
         QKhV2rVZJ3Fl5ZV3Pcl2P3gvU63m+jE3JmvXL4fovdNzB9A0v67DrriaXuG3maU9eD/J
         lDtA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of hdegoede@redhat.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=hdegoede@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of hdegoede@redhat.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=hdegoede@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
X-Google-Smtp-Source: AB8JxZppKrU/BmM90Md/5+ad+IdUdfAq6K95vKY+N6ZaGHgrfvreHDYZoW53Ekl21k8tsBYzd/ZixQ==
Subject: Re: [PATCH] virt: vbox: fix a missing-check bug
To: Wenwen Wang <wang6495@umn.edu>
Cc: Kangjie Lu <kjlu@umn.edu>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 open list <linux-kernel@vger.kernel.org>
References: <1525577448-16071-1-git-send-email-wang6495@umn.edu>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <8db08d8e-c618-d806-b824-0b8990ef0785@redhat.com>
Date: Tue, 8 May 2018 13:46:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1525577448-16071-1-git-send-email-wang6495@umn.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599683912395513650?=
X-GMAIL-MSGID: =?utf-8?q?1599896253056214918?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Wenwen,

On 06-05-18 05:30, Wenwen Wang wrote:
> In vbg_misc_device_ioctl(), the header of the ioctl argument is copied from
> the userspace pointer 'arg' and saved to the kernel object 'hdr'. Then the
> 'version', 'size_in', and 'size_out' fields of 'hdr' are verified. For
> example, if 'hdr.version' is not VBG_IOCTL_HDR_VERSION, an error code
> -EINVAL will be returned. If 'hdr' can pass all verifications, the whole
> structure of the ioctl argument is copied once again from 'arg' and saved
> to 'buf'. Then the function vbg_core_ioctl() is invoked to execute the
> ioctl command. Given that the 'arg' pointer resides in userspace, a
> malicious userspace process can race to change the data pointed to by 'arg'
> between the two copies. By doing so, the user can bypass the verifications
> on the ioctl argument, which can cause vbg_core_ioctl() to work on unsecure
> data because it assumes the 'version', 'size_in', and 'size_out' have been
> verified by vbg_misc_device_ioctl(), as mentioned in the comment in
> vbg_core_ioctl():
> 
>          /*
>           * hdr->version and hdr->size_in / hdr->size_out minimum size are
>           * already checked by vbg_misc_device_ioctl().
>           */
> 
> This patch adds checks after the second copy to ensure the consistency
> between the data obtained in the two copies. In case an inconsistency is
> detected, an error code -EINVAL will be returned.
> 
> Signed-off-by: Wenwen Wang <wang6495@umn.edu>

Thank you for finding this. I don't think that doing a second check is
a good solution, by copy and pasting the checks we run the risk that
any future additional checks are omitted from one copy of the checks.

Instead I think we should simply avoid the 2nd copy of the header, like this:

 From 0c50b0dce3cf25a0ee9794c5816d9a0232d29e0a Mon Sep 17 00:00:00 2001
From: Hans de Goede <hdegoede@redhat.com>
Date: Tue, 8 May 2018 13:23:01 +0200
Subject: [PATCH 3/3] virt: vbox: Only copy_from_user the request-header once

In vbg_misc_device_ioctl(), the header of the ioctl argument is copied from
the userspace pointer 'arg' and saved to the kernel object 'hdr'. Then the
'version', 'size_in', and 'size_out' fields of 'hdr' are verified.

Before this commit, after the checks a buffer for the entire request would
be allocated and then all data including the verified header would be
copied from the userspace 'arg' pointer again.

Given that the 'arg' pointer resides in userspace, a malicious userspace
process can race to change the data pointed to by 'arg' between the two
copies. By doing so, the user can bypass the verifications on the ioctl
argument.

This commit fixes this by using the already checked copy of the header
to fill the header part of the allocated buffer and only copying the
remainder of the data from userspace.

Reported-by: Wenwen Wang <wang6495@umn.edu>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
  drivers/virt/vboxguest/vboxguest_linux.c | 4 +++-
  1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/virt/vboxguest/vboxguest_linux.c b/drivers/virt/vboxguest/vboxguest_linux.c
index 398d22693234..6e2a9619192d 100644
--- a/drivers/virt/vboxguest/vboxguest_linux.c
+++ b/drivers/virt/vboxguest/vboxguest_linux.c
@@ -121,7 +121,9 @@ static long vbg_misc_device_ioctl(struct file *filp, unsigned int req,
  	if (!buf)
  		return -ENOMEM;

-	if (copy_from_user(buf, (void *)arg, hdr.size_in)) {
+	*((struct vbg_ioctl_hdr *)buf) = hdr;
+	if (copy_from_user(buf + sizeof(hdr), (void *)arg + sizeof(hdr),
+			   hdr.size_in - sizeof(hdr))) {
  		ret = -EFAULT;
  		goto out;
  	}

Do you agree that this would also fix the race window you found?

Regards,

Hans




> ---
>   drivers/virt/vboxguest/vboxguest_linux.c | 11 ++++++-----
>   1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/virt/vboxguest/vboxguest_linux.c b/drivers/virt/vboxguest/vboxguest_linux.c
> index 398d226..6b525259 100644
> --- a/drivers/virt/vboxguest/vboxguest_linux.c
> +++ b/drivers/virt/vboxguest/vboxguest_linux.c
> @@ -125,6 +125,12 @@ static long vbg_misc_device_ioctl(struct file *filp, unsigned int req,
>   		ret = -EFAULT;
>   		goto out;
>   	}
> +	if (((struct vbg_ioctl_hdr *)buf)->version != hdr.version ||
> +	    ((struct vbg_ioctl_hdr *)buf)->size_in != hdr.size_in ||
> +	    ((struct vbg_ioctl_hdr *)buf)->size_out != hdr.size_out) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
>   	if (hdr.size_in < size)
>   		memset(buf + hdr.size_in, 0, size -  hdr.size_in);
>   
> @@ -133,11 +139,6 @@ static long vbg_misc_device_ioctl(struct file *filp, unsigned int req,
>   		goto out;
>   
>   	returned_size = ((struct vbg_ioctl_hdr *)buf)->size_out;
> -	if (returned_size > size) {
> -		vbg_debug("%s: too much output data %zu > %zu\n",
> -			  __func__, returned_size, size);
> -		returned_size = size;
> -	}
>   	if (copy_to_user((void *)arg, buf, returned_size) != 0)
>   		ret = -EFAULT;
>   
> 
