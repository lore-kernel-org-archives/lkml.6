Return-Path: <andresx7@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525489049; cv=none;
        d=google.com; s=arc-20160816;
        b=0fF2E5dnwjW+O57jAY7MbazQ+KjFuDN42C3xOepmxo/6sk8hCmBY6oXURb8fjyRn92
         6zQAZkLnL+GZ/hWg6n3B+TYwHws/jXuv/VVoF+n/5TzO1PO/sLa97WXUOJD+X3WWttlV
         ro4T8HxuhV5smu1KAtIEp5a2X3xvdrOdW8DjqU6wmfZldmaVlqGc8k6lYjADDdZc+f5g
         dag3PY8MWTeiuL5XPYqMl73xkT7cIp+wzfiPZY9RF5L/Fn2Evj54on4U2ohBP1ZS/gY/
         lkiTsS9mWS3PXq+ywTjLqzb6KkaZuCo36RK6sCkvEG+LHN0Y88STfOBThCp94lzUo1mX
         FBbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:to:subject:cc
         :dkim-signature:arc-authentication-results;
        bh=3GdMiZSnmFqnpeki2CNckAmlmXDljYdCJQ6CMJkJVEY=;
        b=rtgdzJiI51tpJ0UPgsRLMrcyRa/IR6+CY3mX3cm1P63HJGvCaQ3q6HY9lmFw9oZodg
         FKpZMK4xA69oPG5Hh27WQzg2KYaQhG2CrNR70iQx6+Ym+KNlEhD3L6pjIROr6LsjGTNQ
         B8tzrMUyAkUWvgfJaxq44bzuEKpGGXUM0BXtxrwh+W/y3T6OdxjPFdEqb2Ir1ZlsMFUD
         NVsaCWeAi9DwRHkNsafy2vf4AGKj6IXOYHPXRDEnWVWjUKdULOpClYM8+RYQW4f1f9/t
         FsioICJAHvMSwCilBFdAW7BjUui4mq3v8Q4dfTIEubeM685hAuPzr1VOhtsj4Ij2s6Ur
         nOcg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=R9Qaa2V3;
       spf=pass (google.com: domain of andresx7@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andresx7@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=R9Qaa2V3;
       spf=pass (google.com: domain of andresx7@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andresx7@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AB8JxZoGwewwp5kbp9PgjIMtLsVhMWkcrB61LWyFPtZ/+AEIO4WGnidoAcEBwMXcFbe1OrNdIB6gHQ==
Cc: andresx7@gmail.com, linux-kernel@vger.kernel.org,
 gregkh@linuxfoundation.org, alexdeucher@gmail.com, christian.koenig@amd.com,
 kvalo@codeaurora.org, arend.vanspriel@broadcom.com,
 linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
 hdegoede@redhat.com, Kees Cook <keescook@chromium.org>,
 Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: Re: [PATCH 6/9] firmware: print firmware name on fallback path
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
References: <20180423201205.20533-1-andresx7@gmail.com>
 <20180423201205.20533-7-andresx7@gmail.com>
 <20180503234235.GX27853@wotan.suse.de>
From: Andres Rodriguez <andresx7@gmail.com>
Message-ID: <e79fe68b-7dc5-b65a-e483-287c91d67bc2@gmail.com>
Date: Fri, 4 May 2018 22:57:26 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180503234235.GX27853@wotan.suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598569151610038779?=
X-GMAIL-MSGID: =?utf-8?q?1599591205724659338?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 2018-05-03 07:42 PM, Luis R. Rodriguez wrote:
> On Mon, Apr 23, 2018 at 04:12:02PM -0400, Andres Rodriguez wrote:
>> Previously, one could assume the firmware name from the preceding
>> message: "Direct firmware load for {name} failed with error %d".
>>
>> However, with the new firmware_request_nowarn() entrypoint, the message
>> outlined above will not always be printed.
> 
> I though the whole point was to not print an error message. What if
> we want later to disable this error message? This would prove a bit
> pointless.
> 
> Let's discuss the exact semantics desired here. Why would only the
> fallback be desirable here?
> 
> Andres, Kalle?
> 
> After we address this I'll address resubmitting this lat patch
> along with the last one. For now I'll skip it.

You are correct. I initially thought it would be useful to know that the 
usermode fallback was being triggered. And for that message to be useful 
we would need a fw name.

But now that you point it out, this behaviour is inconsistent with the 
_nowarn() definition. We shouldn't have a message in the first place.

So it might be better to instead have:

if (!(opt_flags & FW_OPT_NO_WARN) )
     dev_warn(device, "Falling back to user helper\n");

No need to add the firmware name, cause we either:
     a) FW_OPT_NO_WARN is set and no messages are printed, or
     b) FW_OPT_NO_WARN is not set and we get both messages.

Yay, nay?

Regards,
Andres

> 
>    Luis
> 
>> Therefore, we add the firmware name to the fallback path spew in order
>> to associate it with the appropriate request.
>>
>> Signed-off-by: Andres Rodriguez <andresx7@gmail.com>
>> ---
>>   drivers/base/firmware_loader/fallback.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/base/firmware_loader/fallback.c b/drivers/base/firmware_loader/fallback.c
>> index e75928458489..1a47ddc70c31 100644
>> --- a/drivers/base/firmware_loader/fallback.c
>> +++ b/drivers/base/firmware_loader/fallback.c
>> @@ -669,6 +669,6 @@ int fw_sysfs_fallback(struct firmware *fw, const char *name,
>>   	if (!fw_run_sysfs_fallback(opt_flags))
>>   		return ret;
>>   
>> -	dev_warn(device, "Falling back to user helper\n");
>> +	dev_warn(device, "Falling back to user helper for %s\n", name);
>>   	return fw_load_from_user_helper(fw, name, device, opt_flags);
>>   }
>> -- 
>> 2.14.1
>>
>>
> 
