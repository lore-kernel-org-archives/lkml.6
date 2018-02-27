Return-Path: <colin.king@canonical.com>
X-Google-Smtp-Source: AG47ELuI7O5udHR2Px2M8IBaeITKwTS6PQsCThgzFYDpFexcyqJQsjPk18d35FR8Cd4SHC2UAXaE
ARC-Seal: i=1; a=rsa-sha256; t=1519752682; cv=none;
        d=google.com; s=arc-20160816;
        b=RKSF8kepwbr8KBX6IbQoJTGtvnYobKUl3sQ6fDdod1PpefSsjuiDjfnaYfSJY71Yp9
         +vyL8+m9YoBsUpJl0/z2Td5sG89du0zMTrgWLuCpk3zl1qhbHY/Lkjv8i4L9kiBqolcX
         TUfyiYg2nP+U9IFcFfqgqMVA7qcmfYQFyA574UCBK57cvOzsiru91UxvGqlceSsGnGS/
         K3DC3pu/Xc55beh3O3XDs5hd1KLjjYszAEyEYFEyRVdKnJl85+N/2/On5aeCduS8A+HN
         S9skdsqopm2F1LLfvwJuTPa3YsdKMx59XO/zSxYiaLmzJNchzqU2uwtslBcg4e3xhvG8
         foyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=yFKXEO4qXsz0L3LgyRaowhnb6wqvbWSMyo2cxzHWBcI=;
        b=z/UqOSdCj6IPwrLJIvyWkpBD+LbO9kUJklyN5EUkwZCWmLA2BALmhghY1dL5EtMpcd
         fUCTevd7BmuAtqBDDR0mV7LqBCqbZ3ElBIBXnAMh9hFyfO820O7sHL53cZM2J+bBr3yR
         puIh6ZZNGS2Rhe60BOHshLeOkOFMBLsGVASLK3/RzGuXG6Uoi4i9j+33f7lVASLvsQyt
         dHI2Q1FNkrUrw5/KgK3zdeEFBYNR637krUMBh94tnSrFvKzf6O74V/+FIE3kV1myXMGf
         usRtkf0Np6tKiqC0AxtNkrB4eY4f8PE6MsMotSRm2mi4vHIv6eg3G9V3KL096LQR+EYS
         3Uog==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of colin.king@canonical.com designates 91.189.89.112 as permitted sender) smtp.mailfrom=colin.king@canonical.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=canonical.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of colin.king@canonical.com designates 91.189.89.112 as permitted sender) smtp.mailfrom=colin.king@canonical.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=canonical.com
Subject: Re: [PATCH] mei: remove dev_err message on an unsupported ioctl
To: "Winkler, Tomas" <tomas.winkler@intel.com>, Arnd Bergmann
 <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20180227162105.14113-1-colin.king@canonical.com>
 <5B8DA87D05A7694D9FA63FD143655C1B9422A4CC@hasmsx108.ger.corp.intel.com>
From: Colin Ian King <colin.king@canonical.com>
Message-ID: <42c81e25-52be-a80e-f304-765c9a71b328@canonical.com>
Date: Tue, 27 Feb 2018 17:31:19 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <5B8DA87D05A7694D9FA63FD143655C1B9422A4CC@hasmsx108.ger.corp.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593571772960941030?=
X-GMAIL-MSGID: =?utf-8?q?1593576188568331915?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 27/02/18 17:26, Winkler, Tomas wrote:
>>
>> From: Colin Ian King <colin.king@canonical.com>
>>
>> Currently the driver spams the kernel log on unsupported ioctls which is
>> unnecessary as the ioctl returns -ENOIOCTLCMD to indicate this anyway.
>> I suspect this was originally for debugging purposes but it really is not
>> required so remove it.
>>
> 
> This is rather strange as most of the legimit applications are using one IOCTL from kernel 3.0
> Do you have any reference where this call is originated from, frankly this is the first time I got such complain.

I hit this while stressing the kernel with my stress-ng kernel stressing
tool; this was not using the legitimate ioctls (to see if things
explode) and I got a rather full kernel log. So it was being abused
somewhat ;-)

> 
> In any case it would be maybe better to change it a warn once call.

Probably so, I can fix that up if that is preferred.

Colin

>  
> Thanks
> Tomas
> 
>> Signed-off-by: Colin Ian King <colin.king@canonical.com>
>> ---
>>  drivers/misc/mei/main.c | 1 -
>>  1 file changed, 1 deletion(-)
>>
>> diff --git a/drivers/misc/mei/main.c b/drivers/misc/mei/main.c index
>> 758dc73602d5..7bb013644aeb 100644
>> --- a/drivers/misc/mei/main.c
>> +++ b/drivers/misc/mei/main.c
>> @@ -507,7 +507,6 @@ static long mei_ioctl(struct file *file, unsigned int
>> cmd, unsigned long data)
>>  		break;
>>
>>  	default:
>> -		dev_err(dev->dev, ": unsupported ioctl %d.\n", cmd);
>>  		rets = -ENOIOCTLCMD;
>>  	}
>>
>> --
>> 2.15.1
> 
