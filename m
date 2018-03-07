Return-Path: <paullawrence@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520460368; cv=none;
        d=google.com; s=arc-20160816;
        b=gGUOfdCwwhEFvviQVupSvoQBNhMfou8mmNVfE3+hw0D4XZQhP0/OYrxay2/xBh52q8
         dJZM91EvagBPdWsLF1jFd/CUl6gvQKLewWwgghDDeCG1yzcWgK2GmFiYDkFE8eMSQhjx
         xOzoAvYluhVCrfWhjaVwuFGmMrTg/ob4TL72TXGB+bCEADanEKpH0p1Fvkeg1/8TGukf
         1uQiwaFMF+IPoZsA2lrpgvuH46URlS7Yq45QTt/Y6F7OuqrOfl6bk3akS2fuJ6xmcXbm
         zxnwKVnHaDeKExaQRkwX8nXUNxA0rBGoKaaSIUs4nVjy2R+l0Q/9DNdg/MYeNI46sLGU
         OXBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-language:in-reply-to:mime-version:user-agent:date
         :message-id:from:references:cc:to:subject:dkim-signature
         :arc-authentication-results;
        bh=kkKsGqkUtTOlyNycT9m1TJE0+rsphRdCbVy2OV4RkPs=;
        b=qjsupmcHvcxXMzicJAKJjqlJ+yZjIJYh8wqtloFfkb0bkUBlXB37/42c72uZj9iPxv
         r7GE6ntUVdrskqH49z+o8CGEoMvGuBHkx3d+hIjA5KDoyNI84G75JN4jIwUt5IoOQy0/
         zf/w87AHZJsgAdks9m2yyrucyzHg/SY0FAfoB2zcDj4fX9tN9Z/uqn7fnarO3yAp2aMS
         pVT8rjMFX3fsV+IHbp5kgnBaI1TR4xhsGHWaIqfi85qfbeAaUfAGbOQywWGSoCWjpBNa
         KCjPmfKhsDYxCHIGSaf7Es1U+U8g16MlypRkANZjySI/o3wa/dTx4C6qqS7trOpsu1rh
         7MxQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=FCRrCt7t;
       spf=pass (google.com: domain of paullawrence@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=paullawrence@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=FCRrCt7t;
       spf=pass (google.com: domain of paullawrence@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=paullawrence@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
X-Google-Smtp-Source: AG47ELsr7ib/I0AFohT9tp5WItnBrx/N2IQ47vcePfk9W7QW3+1ef0Vz575bWaKTf190aSclpsIx6g==
Subject: Re: [PATCH] staging: android: ashmem: Remove deadlock
To: Nathan Chancellor <natechancellor@gmail.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Ben Hutchings <ben@decadent.org.uk>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 =?UTF-8?Q?Arve_Hj=c3=b8nnev=c3=a5g?= <arve@android.com>,
 Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
 devel@driverdev.osuosl.org
References: <20180307214042.135109-1-paullawrence@google.com>
 <20180307214829.GA15587@flashbox>
From: Paul Lawrence <paullawrence@google.com>
Message-ID: <41c677ab-1d63-e1df-4fed-db54024dff74@google.com>
Date: Wed, 7 Mar 2018 14:06:06 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180307214829.GA15587@flashbox>
Content-Type: multipart/alternative;
 boundary="------------03A32B0C2398C9E47D13669F"
Content-Language: en-US
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594316660298021299?=
X-GMAIL-MSGID: =?utf-8?q?1594318251492554606?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is a multi-part message in MIME format.
--------------03A32B0C2398C9E47D13669F
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Great! We need to make sure this gets backported to 4.4 and 4.9, and to 
3.18 with the original dependency, please.

Thanks,

Paul

On 03/07/2018 01:48 PM, Nathan Chancellor wrote:
> On Wed, Mar 07, 2018 at 01:40:30PM -0800, Paul Lawrence wrote:
>> Regression introduced in commit ce8a3a9e76d0193e2e8d74a06d275b3c324ca652
>> ("staging: android: ashmem: Fix a race condition in pin ioctls")
>> causing deadlock.
>>
>> No need to hold ashmem_mutex while copying from user
>>
>> Stacks are:
>>
>> ashmem_mmap+0x53/0x400 drivers/staging/android/ashmem.c:379
>> mmap_region+0x7dd/0xfd0 mm/mmap.c:1694
>> do_mmap+0x57b/0xbe0 mm/mmap.c:1473
>>
>> and
>>
>> lock_acquire+0x12e/0x410 kernel/locking/lockdep.c:3756
>> __might_fault+0x14a/0x1d0 mm/memory.c:4014
>> copy_from_user arch/x86/include/asm/uaccess.h:705 [inline]
>> ashmem_pin_unpin drivers/staging/android/ashmem.c:719 [inline]
>>
>> Signed-off-by: Paul Lawrence <paullawrence@google.com>
>> Cc: <stable@vger.kernel.org> # 4.9.x
>> Cc: <stable@vger.kernel.org> # 4.4.x
>> Cc: <stable@vger.kernel.org> # 3.18.x: ce8a3a9e76d01
>> Cc: <stable@vger.kernel.org> # 3.18.x
>> Cc: Ben Hutchings <ben@decadent.org.uk>
>> ---
>>   drivers/staging/android/ashmem.c | 8 +++-----
>>   1 file changed, 3 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/staging/android/ashmem.c b/drivers/staging/android/ashmem.c
>> index 6dbba5aff191..8c55706c2cfa 100644
>> --- a/drivers/staging/android/ashmem.c
>> +++ b/drivers/staging/android/ashmem.c
>> @@ -702,16 +702,14 @@ static int ashmem_pin_unpin(struct ashmem_area *asma, unsigned long cmd,
>>   	size_t pgstart, pgend;
>>   	int ret = -EINVAL;
>>   
>> +	if (unlikely(copy_from_user(&pin, p, sizeof(pin))))
>> +		return -EFAULT;
>> +
>>   	mutex_lock(&ashmem_mutex);
>>   
>>   	if (unlikely(!asma->file))
>>   		goto out_unlock;
>>   
>> -	if (unlikely(copy_from_user(&pin, p, sizeof(pin)))) {
>> -		ret = -EFAULT;
>> -		goto out_unlock;
>> -	}
>> -
>>   	/* per custom, you can pass zero for len to mean "everything onward" */
>>   	if (!pin.len)
>>   		pin.len = PAGE_ALIGN(asma->size) - pin.offset;
>> -- 
>> 2.16.2.395.g2e18187dfd-goog
>>
> Hey Paul,
>
> Looks like this same patch is already in Greg's tree:
> https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git/commit/?id=740a5759bf222332fbb5eda42f89aa25ba38f9b2
>
> Cheers!
> Nathan Chancellor


--------------03A32B0C2398C9E47D13669F
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="gmail_default" style="color: rgb(34, 34, 34);
      font-style: normal; font-variant-ligatures: normal;
      font-variant-caps: normal; font-weight: 400; letter-spacing:
      normal; orphans: 2; text-align: start; text-indent: 0px;
      text-transform: none; white-space: normal; widows: 2;
      word-spacing: 0px; -webkit-text-stroke-width: 0px;
      background-color: rgb(255, 255, 255); text-decoration-style:
      initial; text-decoration-color: initial; font-family: tahoma,
      sans-serif; font-size: small;">Great! We need to make sure this
      gets backported to 4.4 and 4.9, and to 3.18 with the original
      dependency, please.</div>
    <div class="gmail_default" style="color: rgb(34, 34, 34);
      font-style: normal; font-variant-ligatures: normal;
      font-variant-caps: normal; font-weight: 400; letter-spacing:
      normal; orphans: 2; text-align: start; text-indent: 0px;
      text-transform: none; white-space: normal; widows: 2;
      word-spacing: 0px; -webkit-text-stroke-width: 0px;
      background-color: rgb(255, 255, 255); text-decoration-style:
      initial; text-decoration-color: initial; font-family: tahoma,
      sans-serif; font-size: small;"><br>
    </div>
    <div class="gmail_default" style="color: rgb(34, 34, 34);
      font-style: normal; font-variant-ligatures: normal;
      font-variant-caps: normal; font-weight: 400; letter-spacing:
      normal; orphans: 2; text-align: start; text-indent: 0px;
      text-transform: none; white-space: normal; widows: 2;
      word-spacing: 0px; -webkit-text-stroke-width: 0px;
      background-color: rgb(255, 255, 255); text-decoration-style:
      initial; text-decoration-color: initial; font-family: tahoma,
      sans-serif; font-size: small;">Thanks,</div>
    <div class="gmail_default" style="color: rgb(34, 34, 34);
      font-style: normal; font-variant-ligatures: normal;
      font-variant-caps: normal; font-weight: 400; letter-spacing:
      normal; orphans: 2; text-align: start; text-indent: 0px;
      text-transform: none; white-space: normal; widows: 2;
      word-spacing: 0px; -webkit-text-stroke-width: 0px;
      background-color: rgb(255, 255, 255); text-decoration-style:
      initial; text-decoration-color: initial; font-family: tahoma,
      sans-serif; font-size: small;"><br>
    </div>
    <div class="gmail_default" style="color: rgb(34, 34, 34);
      font-style: normal; font-variant-ligatures: normal;
      font-variant-caps: normal; font-weight: 400; letter-spacing:
      normal; orphans: 2; text-align: start; text-indent: 0px;
      text-transform: none; white-space: normal; widows: 2;
      word-spacing: 0px; -webkit-text-stroke-width: 0px;
      background-color: rgb(255, 255, 255); text-decoration-style:
      initial; text-decoration-color: initial; font-family: tahoma,
      sans-serif; font-size: small;">Paul</div>
    <br>
    <div class="moz-cite-prefix">On 03/07/2018 01:48 PM, Nathan
      Chancellor wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20180307214829.GA15587@flashbox">
      <pre wrap="">On Wed, Mar 07, 2018 at 01:40:30PM -0800, Paul Lawrence wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="">Regression introduced in commit ce8a3a9e76d0193e2e8d74a06d275b3c324ca652
("staging: android: ashmem: Fix a race condition in pin ioctls")
causing deadlock.

No need to hold ashmem_mutex while copying from user

Stacks are:

ashmem_mmap+0x53/0x400 drivers/staging/android/ashmem.c:379
mmap_region+0x7dd/0xfd0 mm/mmap.c:1694
do_mmap+0x57b/0xbe0 mm/mmap.c:1473

and

lock_acquire+0x12e/0x410 kernel/locking/lockdep.c:3756
__might_fault+0x14a/0x1d0 mm/memory.c:4014
copy_from_user arch/x86/include/asm/uaccess.h:705 [inline]
ashmem_pin_unpin drivers/staging/android/ashmem.c:719 [inline]

Signed-off-by: Paul Lawrence <a class="moz-txt-link-rfc2396E" href="mailto:paullawrence@google.com">&lt;paullawrence@google.com&gt;</a>
Cc: <a class="moz-txt-link-rfc2396E" href="mailto:stable@vger.kernel.org">&lt;stable@vger.kernel.org&gt;</a> # 4.9.x
Cc: <a class="moz-txt-link-rfc2396E" href="mailto:stable@vger.kernel.org">&lt;stable@vger.kernel.org&gt;</a> # 4.4.x
Cc: <a class="moz-txt-link-rfc2396E" href="mailto:stable@vger.kernel.org">&lt;stable@vger.kernel.org&gt;</a> # 3.18.x: ce8a3a9e76d01
Cc: <a class="moz-txt-link-rfc2396E" href="mailto:stable@vger.kernel.org">&lt;stable@vger.kernel.org&gt;</a> # 3.18.x
Cc: Ben Hutchings <a class="moz-txt-link-rfc2396E" href="mailto:ben@decadent.org.uk">&lt;ben@decadent.org.uk&gt;</a>
---
 drivers/staging/android/ashmem.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/android/ashmem.c b/drivers/staging/android/ashmem.c
index 6dbba5aff191..8c55706c2cfa 100644
--- a/drivers/staging/android/ashmem.c
+++ b/drivers/staging/android/ashmem.c
@@ -702,16 +702,14 @@ static int ashmem_pin_unpin(struct ashmem_area *asma, unsigned long cmd,
 	size_t pgstart, pgend;
 	int ret = -EINVAL;
 
+	if (unlikely(copy_from_user(&amp;pin, p, sizeof(pin))))
+		return -EFAULT;
+
 	mutex_lock(&amp;ashmem_mutex);
 
 	if (unlikely(!asma-&gt;file))
 		goto out_unlock;
 
-	if (unlikely(copy_from_user(&amp;pin, p, sizeof(pin)))) {
-		ret = -EFAULT;
-		goto out_unlock;
-	}
-
 	/* per custom, you can pass zero for len to mean "everything onward" */
 	if (!pin.len)
 		pin.len = PAGE_ALIGN(asma-&gt;size) - pin.offset;
-- 
2.16.2.395.g2e18187dfd-goog

</pre>
      </blockquote>
      <pre wrap="">
Hey Paul,

Looks like this same patch is already in Greg's tree:
<a class="moz-txt-link-freetext" href="https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git/commit/?id=740a5759bf222332fbb5eda42f89aa25ba38f9b2">https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git/commit/?id=740a5759bf222332fbb5eda42f89aa25ba38f9b2</a>

Cheers!
Nathan Chancellor
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------03A32B0C2398C9E47D13669F--
