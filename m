Return-Path: <hdegoede@redhat.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525788564; cv=none;
        d=google.com; s=arc-20160816;
        b=DmDKxBzbkRIdLCiKcX0H6u3vfwSXUDyMAtc/3Ud80OKatixEza+1th75Cke6FIv1q2
         vedBsgJNmFtjFcUFvfQd4j4xFt71uGrTc3kRHJwf4SiQ0BwcNHw4duVv1KbwuQ05yp4d
         oCICVPc4D2JtX3n4He9LakBz7ZfN/EZBdcTShoE7jBUR02f4+fDmet1sLgs04kGKNwUE
         OS01VUAUrgUpXe9B99In4NCpMGd179WWy8Wb/03987B1qZoBfaYZM0hhh1AfZ5zsthUL
         od2XvxDCs7SS06kwqMpsqgRWrTKjk/wWeMuFuRaru//jZREhvEMz3/yy3d8sUpYNe3/f
         G8iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=cdwZAlYokpQrfD6O/8h7EK5gexyKZnIu5EzNLjqog38=;
        b=shA7haxF4JS9aGdgvlK0AJWfm3ugPYnKfp37fCki/Ok8vN/K1a81FvnEFbfkYdyxup
         qB6S42cL49pyp5U0HDkWSz3+d6Ut6PJtawMp1DW206qlYMRsexU+OliCToJbMU4xEyPs
         KZvl8287cDAgFz2AvKTWOQ9/sTRvFKWKYF7jbMHoEdP8ePsBxImabElSUaZvTLtcbMKk
         jyRHeNfAolrOQM1po6XR6RKeKC0hofy8/MPJriYNsKRSkXKSq7MZf16kDkXFWJ3Wt7rI
         GzHnFnhP85LCJuS3B6u1Y1p6EACSAduMYH5xVnNe8QxJN930EL48ssgC2VaY4in1ApEx
         KuNA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of hdegoede@redhat.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=hdegoede@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of hdegoede@redhat.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=hdegoede@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
X-Google-Smtp-Source: AB8JxZqE3ApHaIwAGRSPYxfpjxyg9nzgSZaKcGQM8VIvVNX4MJdSrs085/BD6CWouRn9DKqcbHt5Mw==
Subject: Re: [PATCH v2] virt: vbox: Only copy_from_user the request-header
 once
To: Wenwen Wang <wang6495@umn.edu>
Cc: Kangjie Lu <kjlu@umn.edu>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 open list <linux-kernel@vger.kernel.org>
References: <1525787428-26702-1-git-send-email-wang6495@umn.edu>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <61964ea9-dfa9-33d3-80fe-2cc54e1727de@redhat.com>
Date: Tue, 8 May 2018 16:09:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1525787428-26702-1-git-send-email-wang6495@umn.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599904091917934348?=
X-GMAIL-MSGID: =?utf-8?q?1599905269961109535?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

On 08-05-18 15:50, Wenwen Wang wrote:
> In vbg_misc_device_ioctl(), the header of the ioctl argument is copied from
> the userspace pointer 'arg' and saved to the kernel object 'hdr'. Then the
> 'version', 'size_in', and 'size_out' fields of 'hdr' are verified.
> 
> Before this commit, after the checks a buffer for the entire request would
> be allocated and then all data including the verified header would be
> copied from the userspace 'arg' pointer again.
> 
> Given that the 'arg' pointer resides in userspace, a malicious userspace
> process can race to change the data pointed to by 'arg' between the two
> copies. By doing so, the user can bypass the verifications on the ioctl
> argument.
> 
> This commit fixes this by using the already checked copy of the header
> to fill the header part of the allocated buffer and only copying the
> remainder of the data from userspace.
> 
> Signed-off-by: Wenwen Wang <wang6495@umn.edu>

Thanks, looks good:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
>   drivers/virt/vboxguest/vboxguest_linux.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/virt/vboxguest/vboxguest_linux.c b/drivers/virt/vboxguest/vboxguest_linux.c
> index 398d226..6e2a961 100644
> --- a/drivers/virt/vboxguest/vboxguest_linux.c
> +++ b/drivers/virt/vboxguest/vboxguest_linux.c
> @@ -121,7 +121,9 @@ static long vbg_misc_device_ioctl(struct file *filp, unsigned int req,
>   	if (!buf)
>   		return -ENOMEM;
>   
> -	if (copy_from_user(buf, (void *)arg, hdr.size_in)) {
> +	*((struct vbg_ioctl_hdr *)buf) = hdr;
> +	if (copy_from_user(buf + sizeof(hdr), (void *)arg + sizeof(hdr),
> +			   hdr.size_in - sizeof(hdr))) {
>   		ret = -EFAULT;
>   		goto out;
>   	}
> 
