Return-Path: <arvind.yadav.cs@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1519903523; cv=none;
        d=google.com; s=arc-20160816;
        b=dHM9dOlZU4uZDkw1xdP7KXaTFGbWL8TkrP/6Mkd/2IOCR9yhZS8czo4QV5bm9Nltl/
         kQzGj+Kie3NPJ1l4zK5CwR1m3QNgJAqCUkepcvauoTqxsM+V7e8vL+6UA/U+s4V4mA8Y
         zk8kZJyEmfsEqpwbIHBSfsQNDBHWHmPLMa0709SVqQGVDWj9m+i9E2JurqEx1NZ1vUa0
         818F/DEvtcP+GquBt+k/pG0Cg5Jbhfa8PFfuVNTMauWUwDqCRgB08Vbve7+69gSNGjxM
         F5Dq9PXhmmyHN6oYl20rmSljozZSx4A0X2HymGGgKzrvMbIkTmsTYbwHAwQNiWUVuP9X
         shKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:cc:references:to:subject:dkim-signature
         :arc-authentication-results;
        bh=Qco3pFI9HjiB49zW8U7IqZ/HbhvTHud8Swz2RFUYYmw=;
        b=C3RSdlfn5150Hx9VDC9lRbQJu50iNWhYHd8U0c7qQZVMo5T17E0Zw9e+b4MO8jBZl/
         aFgAefXdWDhEaYPmZZmJoNhfePZWk4sAoSAkCk9zBzOq1O6tTGI04iix4jjWKbsmQzRk
         ub1ms7S7czZqOesysJ5NLl4TmwpbTMLQZYBJYyllnCasMgBtKcpsCUIjuEFTIUQgjISq
         y57j+MCVpobJmq63oW95dmYgWnlMSUr8nFmukUWIWpyjcn1Ji1VeXshgwd2493jvkFMv
         id0/KtrNeFRYl6CO3k/vwEs+lTdsn4AdC4bluCiv5uadruQdHr3p7nevWVY39wSmTrzK
         pYsA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=CcKSpMCk;
       spf=pass (google.com: domain of arvind.yadav.cs@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arvind.yadav.cs@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=CcKSpMCk;
       spf=pass (google.com: domain of arvind.yadav.cs@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arvind.yadav.cs@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELuRJZ++m8cDLJGvzL77ILFaiTy1fmhs2H+g+Op9dFjFlRXrAdxijB+sCsFCYbsbcfYKaU9L/Q==
Subject: Re: [PATCH] driver core: Free memory obtained by kzalloc
To: Andy Shevchenko <andy.shevchenko@gmail.com>
References: <55b8ad8c5e7ad38403c34a5d30d49f8aaba37156.1519883835.git.arvind.yadav.cs@gmail.com>
 <CAHp75VeiUccZp7fLeRv9d2qt61Ha=CPEo2rwKypY42WGO4Aejw@mail.gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Message-ID: <4f693209-db25-2dfb-1018-3dcbe806104f@gmail.com>
Date: Thu, 1 Mar 2018 16:54:48 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <CAHp75VeiUccZp7fLeRv9d2qt61Ha=CPEo2rwKypY42WGO4Aejw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593713894002392634?=
X-GMAIL-MSGID: =?utf-8?q?1593734356430364993?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Andy,

sorry for noise.

On Thursday 01 March 2018 04:24 PM, Andy Shevchenko wrote:
> On Thu, Mar 1, 2018 at 7:59 AM, Arvind Yadav <arvind.yadav.cs@gmail.com> wrote:
>> Here kfree() is taking NULL. So moving 'dev = NULL' after kfree().
> Ouch! Does system_root_device_release() code ring a bell? How did you test this?
Yes, This is fine. put_device() will decrement a ref count.
So No need to call kfree() after put_device().
>
> When you start eventually looking to the code?
>
> NAK.
>
>> diff --git a/drivers/base/bus.c b/drivers/base/bus.c
>> index ef61833..ccb64a0 100644
>> --- a/drivers/base/bus.c
>> +++ b/drivers/base/bus.c
>> @@ -1170,9 +1170,9 @@ static int subsys_register(struct bus_type *subsys,
>>
>>   err_dev_reg:
>>          put_device(dev);
>> -       dev = NULL;
>>   err_name:
>>          kfree(dev);
>> +       dev = NULL;
>>   err_dev:
>>          bus_unregister(subsys);
>>          return err;
Thanks for your review.
>
>
