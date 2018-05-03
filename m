Return-Path: <lurodriguez@suse.de>
X-Google-Smtp-Source: AB8JxZos2RZRMgZnB0fH60ua+DmLVG77Al79cTBZ4U61a/ADbr9tyLQRh0VSES9tK2oebHg9S5Gj
ARC-Seal: i=1; a=rsa-sha256; t=1525390958; cv=none;
        d=google.com; s=arc-20160816;
        b=ObYBv4jFJJjp5jO7i8c9V/lupGZ6jWMp5OHj9DW6G9Gnzqyrq02o2dvx7909ipHm4W
         ID7y7kJzrHkso45Gvjaqvs/Q3kAICq5mWsGIp8gk/hmQOQijAsggVv5e4eX8zGSYP8bd
         hfi4xSzlbYpdF4FJdwTnNueIsJRHAAIMjFTvEdhkOuZ+CSzZePA1ATQNr9Vh+pXkp42c
         OXtxZXXUzHk4i8yFnRrPtmhdM4bPl5w2xaoOqsGkoNUGOtARKearVF5+9FcOj/aQ+nfQ
         Zyp74OJy7wf6kK9Ledga9O6obz80N1nHZ0+Xj41nk/T62WXR/YuhbDbJcZWpQjmiCWky
         RREg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=/o6LFbcG1q7jiH+VHd0/PBT5kQkRRJ+KCC4bk8Owj0w=;
        b=GJIBD2cNCZiGahX9JmLBscWhRENN4qOI1WDQvpxOovRqjVg4LSHgZ8IBCCnEQ1iA6D
         sD5JqG+XgtiZspnRK7RkDubCuv7j8EHNlxbCLFxvBQyOg1ljMUr05yu40y45OW0s8e1l
         BkNtBMpcHH4FCq2LQ/nfY/JhqfQtGnuJHaytEbRPxCo6c+M9qid19gmQyibsKLlVliBn
         PwXsWJWg73cDhdfXcYb8kmcLRTp08i7DLNdPlPf7Flrf6WYjk45wmXzu5/SwNEzESD7p
         edZ/Stq3GIt8/gj0qsqgn6LraYO76/+k1Hj5Qk9aRJWeQUZ0b3CLEkCkAEWXUEi8Q5hg
         VzOA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of lurodriguez@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=lurodriguez@suse.de;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of lurodriguez@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=lurodriguez@suse.de;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Date: Thu, 3 May 2018 23:42:35 +0000
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: Andres Rodriguez <andresx7@gmail.com>
Cc: linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
	mcgrof@kernel.org, alexdeucher@gmail.com, christian.koenig@amd.com,
	kvalo@codeaurora.org, arend.vanspriel@broadcom.com,
	linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
	hdegoede@redhat.com, Kees Cook <keescook@chromium.org>,
	Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: Re: [PATCH 6/9] firmware: print firmware name on fallback path
Message-ID: <20180503234235.GX27853@wotan.suse.de>
References: <20180423201205.20533-1-andresx7@gmail.com>
 <20180423201205.20533-7-andresx7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180423201205.20533-7-andresx7@gmail.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598569151610038779?=
X-GMAIL-MSGID: =?utf-8?q?1599488349609814935?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 23, 2018 at 04:12:02PM -0400, Andres Rodriguez wrote:
> Previously, one could assume the firmware name from the preceding
> message: "Direct firmware load for {name} failed with error %d".
> 
> However, with the new firmware_request_nowarn() entrypoint, the message
> outlined above will not always be printed.

I though the whole point was to not print an error message. What if
we want later to disable this error message? This would prove a bit
pointless.

Let's discuss the exact semantics desired here. Why would only the
fallback be desirable here?

Andres, Kalle?

After we address this I'll address resubmitting this lat patch
along with the last one. For now I'll skip it.

  Luis

> Therefore, we add the firmware name to the fallback path spew in order
> to associate it with the appropriate request.
> 
> Signed-off-by: Andres Rodriguez <andresx7@gmail.com>
> ---
>  drivers/base/firmware_loader/fallback.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/base/firmware_loader/fallback.c b/drivers/base/firmware_loader/fallback.c
> index e75928458489..1a47ddc70c31 100644
> --- a/drivers/base/firmware_loader/fallback.c
> +++ b/drivers/base/firmware_loader/fallback.c
> @@ -669,6 +669,6 @@ int fw_sysfs_fallback(struct firmware *fw, const char *name,
>  	if (!fw_run_sysfs_fallback(opt_flags))
>  		return ret;
>  
> -	dev_warn(device, "Falling back to user helper\n");
> +	dev_warn(device, "Falling back to user helper for %s\n", name);
>  	return fw_load_from_user_helper(fw, name, device, opt_flags);
>  }
> -- 
> 2.14.1
> 
> 

-- 
Do not panic
