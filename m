Return-Path: <baijiaju1990@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523408458; cv=none;
        d=google.com; s=arc-20160816;
        b=LrUOcJ5OF0yKH9EHy/nqfxNHmlbu2fBCXh750/Uo0TPFhVWq6SAHIB24skTStIN1j0
         QCr7p8lmzl1zPGJ3Fgfl1+hr4mwJjbRuZbmQWNRpXXT2oaF6WjfMzCiez9LAaIPPzzJc
         qNkZrnLizif9eTdT4mOSo4pBOecAX7CfBHQD/xf6MRo7MbGSVDAI1ttvvtxD+zNkBYb8
         u7cyjwCIiK8eHIQRIPHw+kbZkvjlY5qpPBNxlzd6LPXI3XWO8zz7w1svwcC9HCbGNeP0
         kWthDLTJdYQXXRb9fypZs5fUIW6wzLU5P4EF3rSdmH5uKNOnyVYZsioghUIr3b6MeOOk
         GBig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=wgo6oROl6R5+k6yVmQTX0kXOCldSEzv+lbBgARzDRFo=;
        b=eqyP67ka8L532bjmRFLKwlP2N+2X2EmlMVia0+7i2c6VXOTSJwOc+K91nIzSslGP+A
         eie/QexH6s1T/ipLEizdPzxCf1zt+UGn6MzaYYdy41iC5Csk3AB7/cyLW+kXIV+YmzHD
         OMaLiIQT8PqtM0+auC68xLDZAXmkCdnVu3X5KJUFUSxvUcCXy15F6XUPubZ5aE1oEWDB
         9fyUqVj/O0Rz2YXmMoMUUOqVfomkFN8f1EfuFKdFVK7LxQsE53siDl8u/z9iYQt/vHuh
         U3OJnK3njRIk9L22SH5ZuY8fpONLr8VwSAxlhzDjuIygBxw811/1GVGsEe5vmzYWsxHt
         9RmA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=VxQGUjGa;
       spf=pass (google.com: domain of baijiaju1990@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=baijiaju1990@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=VxQGUjGa;
       spf=pass (google.com: domain of baijiaju1990@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=baijiaju1990@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx4/GQ3epnJ+A18s2sVTEKnZ1rwrq/fgH12ebjhtqDLqlvUkiLAtFHdHD07KK7cU3GZiV+n3yAw==
Subject: Re: [PATCH 1/4] xen: xen-pciback: Replace GFP_ATOMIC with GFP_KERNEL
 in pcistub_probe
To: Boris Ostrovsky <boris.ostrovsky@oracle.com>, jgross@suse.com,
 gregkh@linuxfoundation.org
Cc: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
References: <1523286216-26345-1-git-send-email-baijiaju1990@gmail.com>
 <b07f0a27-f09d-1617-ab9e-ebbc761cb3a4@oracle.com>
 <74fe5dd3-fb85-bed8-82b6-a9fb7a3a376d@gmail.com>
 <9703e77f-35e8-aa11-9ddb-fdc322efd6d2@oracle.com>
From: Jia-Ju Bai <baijiaju1990@gmail.com>
Message-ID: <311acb17-1cab-bb1a-b612-23e7523f6709@gmail.com>
Date: Wed, 11 Apr 2018 09:00:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <9703e77f-35e8-aa11-9ddb-fdc322efd6d2@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597281379484745930?=
X-GMAIL-MSGID: =?utf-8?q?1597409548206626031?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 2018/4/10 23:01, Boris Ostrovsky wrote:
> On 04/10/2018 10:31 AM, Jia-Ju Bai wrote:
>>
>>
>> On 2018/4/10 22:27, Boris Ostrovsky wrote:
>>> On 04/09/2018 11:03 AM, Jia-Ju Bai wrote:
>>>> pcistub_probe() is never called in atomic context.
>>>> This function is only set as ".probe" in struct pci_driver.
>>>>
>>>> Despite never getting called from atomic context,
>>>> pcistub_probe() calls kmalloc() with GFP_ATOMIC,
>>>> which does not sleep for allocation.
>>>> GFP_ATOMIC is not necessary and can be replaced with GFP_KERNEL,
>>>> which can sleep and improve the possibility of sucessful allocation.
>>>>
>>>> This is found by a static analysis tool named DCNS written by myself.
>>>> And I also manually check it.
>>>>
>>>> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
>>> What about use of GFP_ATOMIC in pcistub_reg_add()?
>> Thanks for your reply :)
>> I find pcistub_reg_add() is called by pcistub_quirk_add().
>> And pcistub_quirk_add() is called in the macro DRIVER_ATTR().
>> I am not sure whether DRIVER_ATTR() can make the function called in
>> atomic context,
>> so I do not analyze it in my tool.
> I don't see why it needs to be ATOMIC, it's sysfs access. Can you send a
> patch to fix it as well?

Okay, I will send a patch for it soon.
You can have a look :)


Best wishes,
Jia-Ju Bai
