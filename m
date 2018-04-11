Return-Path: <baijiaju1990@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523434278; cv=none;
        d=google.com; s=arc-20160816;
        b=lfb2+FSSLmDJVI770G4VU82HLiJ8CmdPzfXgL+cv8y34LEFLnuq+OIWa1W1HOLSGbS
         9nSEwd8sLATdpqfNuiYngqd7YUpl3mH/7wVLe31+1kMs4xItoWt7xxrI+dS7cuK+VrO7
         z0cquKLIoIMOB6S2k+wlmD4bFS/4P1URDeRU6RzGAvzXRIEaaRJ7VvZ+ceFNDp0/ADMF
         Ns4O2zJlUKAW65BSFr2wT/pmUVM2m+LXCu88mAGW+2IAymgMjx6pWmiWW7n+1Rf6Do5J
         S5fnNREhB2Qv0oMftw9pbeRzdNyce8W55Tq7tmAOa7a697yOOGP8H6XXavLRyrvUzwUi
         RvvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=qrh9Io6+i4bQTc9Jq9mH6vXLL+t0n/l5Qo7TmIlbfnM=;
        b=RiGWONln0jSsQ+Yq28rNPOOwLMtAUk4VpOADtje0VmCPv+vMPxI9/uAZaqQco6um/b
         pvL7eVqgU37bOqLNx1u0Xs2VTjbCKMtV9F41xKkqkaepxPIz/cRrwJL1NivQ8CTDIRxn
         sAE/+iGuph5QHf44hcOA7FUjMwdIbRm551Vq5E2Av3TRxU/5Biq6+DrFH/N4XIE/+Q+4
         snMrbPvt0N3LF4ccvW1b/J9PudMe9lwLa3xtjHpF6pllRK/VdBNgDP5f4Zv4jU8RuLUS
         ORFJ8yS3Fhem5CQoKuwW1e7jcRyIT26WAOMGBhxH1/ipyS3s/qIW6DGJUZRfjwulAKvT
         RXMg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=kx30GhCu;
       spf=pass (google.com: domain of baijiaju1990@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=baijiaju1990@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=kx30GhCu;
       spf=pass (google.com: domain of baijiaju1990@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=baijiaju1990@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx48UYK8WUqTFYA4meyONL9/PPVYpYt1639nPsQs/aVSUJEdrHKpAhDtdzHIsjBJ8KmhLsiMGfA==
Subject: Re: [PATCH 1/2] staging: irda: Replace mdelay with usleep_range in
 stir421x_fw_upload
To: Greg KH <gregkh@linuxfoundation.org>
Cc: devel@driverdev.osuosl.org, samuel@sortiz.org, netdev@vger.kernel.org,
 johan@kernel.org, linux-kernel@vger.kernel.org, arvind.yadav.cs@gmail.com,
 davem@davemloft.net
References: <1523410174-1553-1-git-send-email-baijiaju1990@gmail.com>
 <20180411064135.GA28354@kroah.com>
 <d65d1116-7ffd-e289-5379-cc052782700d@gmail.com>
 <20180411080311.GB2137@kroah.com>
From: Jia-Ju Bai <baijiaju1990@gmail.com>
Message-ID: <ecf21a6e-0e99-55dc-54be-3bd633bedbc5@gmail.com>
Date: Wed, 11 Apr 2018 16:11:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180411080311.GB2137@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597411356016070238?=
X-GMAIL-MSGID: =?utf-8?q?1597436622572287087?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 2018/4/11 16:03, Greg KH wrote:
> On Wed, Apr 11, 2018 at 03:17:10PM +0800, Jia-Ju Bai wrote:
>>
>> On 2018/4/11 14:41, Greg KH wrote:
>>> On Wed, Apr 11, 2018 at 09:29:34AM +0800, Jia-Ju Bai wrote:
>>>> stir421x_fw_upload() is never called in atomic context.
>>>>
>>>> The call chain ending up at stir421x_fw_upload() is:
>>>> [1] stir421x_fw_upload() <- stir421x_patch_device() <- irda_usb_probe()
>>>>
>>>> irda_usb_probe() is set as ".probe" in struct usb_driver.
>>>> This function is not called in atomic context.
>>>>
>>>> Despite never getting called from atomic context, stir421x_fw_upload()
>>>> calls mdelay() to busily wait.
>>>> This is not necessary and can be replaced with usleep_range() to
>>>> avoid busy waiting.
>>>>
>>>> This is found by a static analysis tool named DCNS written by myself.
>>>> And I also manually check it.
>>>>
>>>> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
>>>> ---
>>>>    drivers/staging/irda/drivers/irda-usb.c | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>> Please, at the very least, work off of Linus's tree.  There is no
>>> drivers/staging/irda/ anymore :)
>>>
>> Okay, sorry.
>> Could you please recommend me a right tree or its git address?
> Have you looked in the MAINTAINERS file?  Worst case, always use
> linux-next.
>
> greg k-h

Oh, sorry, I did notice the git tree in the MAINTAINERS file.
I always used linux-stable.
Thanks for telling me this :)


Best wishes,
Jia-Ju Bai
