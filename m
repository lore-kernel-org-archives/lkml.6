Return-Path: <labbott@redhat.com>
ARC-Seal: i=1; a=rsa-sha256; t=1517957992; cv=none;
        d=google.com; s=arc-20160816;
        b=pCFk7yIQReWKJ5Bmkc+D5MVoIeaeJM00pzgug/raSygg4CTHXj3ae5+hEUqxFYNDDS
         hHLGmbsHuxhwjvdnwFFQMMHDAAaNYZW7zKYg26G0RvYqv6OH7+z5/NiMe/pDTespwLW2
         licV2eJQoQX6xSG3/YNpX51v8QX8xiv7KRo67XzahD/MDPaMzPRSpGRfUVSDruYW96SL
         sL5uRZ0wqJc7JeUuJ3kBWDo9V9kjKjINmGzhrC4DowatgjUN1PFTkKSB2bs9ceOosgQJ
         fzVpxCOIP45OhRZVFjWLFajh/20F1kutKQbQ31YKGylDxOj54x5KsP+jGXbA6dgUnICh
         OWhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=ORDG4cFFJsyDHJFP2ocA+48A0US0+rYuZmnJ1s6JiXE=;
        b=kEeKzdjjZD72L6awtdR+mouc8NvJJEH5UtNA8Ok2+3o590OmjVJ/kvK730xP13PMuO
         XtIGteVoKos2kogY1FsGmEAKYh7NbGX0Lo8RnSjczW4BwaiBZTC4X+KIgeFnUAY1wPNk
         4KHXvvldbyKyBhuqRJWxlGXuDiFeGEFjnax9474joEBioBmewEvQQ3N/L56QZPhHfTry
         Y1y7qWv56ReLKcrsZGKQW3jKS/C7D7UgWfoNQaLZ9HIkcVAZmlmmTxPv/LhqE/Z0ZjrZ
         ZLMj9nfePpkhY64Mrr7N0Z39mN1AgS5Nh1vamDsQMNJFDAmzqZFtlyQp8aqZ2oLuqYs9
         A78g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of labbott@redhat.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=labbott@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of labbott@redhat.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=labbott@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
X-Google-Smtp-Source: AH8x227mHY7lmdWwnZ0vpQ5d0ml45sRmwaYZrUlD6fsT9Z4Dc7/HFzdhvnATpwXoQyhVg4q/8mypbg==
Subject: Re: [PATCH 1/2] staging: android: ion: Avoid NULL point in error path
To: Yisheng Xie <xieyisheng1@huawei.com>, gregkh@linuxfoundation.org
Cc: sumit.semwal@linaro.org, devel@driverdev.osuosl.org,
 linux-kernel@vger.kernel.org
References: <1517488447-41252-1-git-send-email-xieyisheng1@huawei.com>
From: Laura Abbott <labbott@redhat.com>
Message-ID: <b5b6c497-94c8-16e8-a223-6c0e985a9acc@redhat.com>
Date: Tue, 6 Feb 2018 14:59:49 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <1517488447-41252-1-git-send-email-xieyisheng1@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591202561358042464?=
X-GMAIL-MSGID: =?utf-8?q?1591694319915589789?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/01/2018 04:34 AM, Yisheng Xie wrote:
> If we failed to create debugfs for ion at ion_device_create, the
> debug_root of ion_device will be NULL, and then when try to create debug
> file for shrinker of heap it will be create on the top of debugfs. If we
> also failed to create this the debug file, it call dentry_path to found
> the path of debug_root, then a NULL point will occur.
> 
> Fix this by avoiding call dentry_path, but show the debug name only when
> failed to create debug file for shrinker.
> 

Acked-by: Laura Abbott <labbott@redhat.com>

> Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
> ---
>   drivers/staging/android/ion/ion.c | 10 +++-------
>   1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/staging/android/ion/ion.c b/drivers/staging/android/ion/ion.c
> index f480885..3e41644 100644
> --- a/drivers/staging/android/ion/ion.c
> +++ b/drivers/staging/android/ion/ion.c
> @@ -570,13 +570,9 @@ void ion_device_add_heap(struct ion_heap *heap)
>   		debug_file = debugfs_create_file(
>   			debug_name, 0644, dev->debug_root, heap,
>   			&debug_shrink_fops);
> -		if (!debug_file) {
> -			char buf[256], *path;
> -
> -			path = dentry_path(dev->debug_root, buf, 256);
> -			pr_err("Failed to create heap shrinker debugfs at %s/%s\n",
> -			       path, debug_name);
> -		}
> +		if (!debug_file)
> +			pr_err("Failed to create ion heap shrinker debugfs at %s\n",
> +			       debug_name);
>   	}
>   
>   	dev->heap_cnt++;
> 
