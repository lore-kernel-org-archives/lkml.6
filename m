Return-Path: <arend.vanspriel@broadcom.com>
ARC-Seal: i=1; a=rsa-sha256; t=1521015851; cv=none;
        d=google.com; s=arc-20160816;
        b=Ky8F3zKTPcxyHEi8aBmR7l85VYT+u/fmrUBJiiOEZP//xdVAm9R6MFSYR22cFeCsYU
         e8NgZFmyOfOB/ybehFvT/ClbzSNcXNIlES4i/oOuh12Gt0PT49Ki3Sp+671lCJUpQGGJ
         cW1cqYIPb3hfZtGo9cDxXwdMBUAKJUKjDw0i2QpAHVJbo2JJNTtnxNuIrXFMvyZ0PtB6
         +R2EKb2ZOCIkddbHTv4BEt1jE4waDnbmKTZbnIN33fAL/m7K3g2y9c8LbKNC+HEnF2wq
         D3BkCsAPWh8thZTME6/uruld5cLD5HnJbeXO8v3r4B+NA8m0mAhTR46vbNI9+9N5zfhb
         Va/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:cc:references:to:subject:dkim-signature
         :arc-authentication-results;
        bh=hAQCYbzvyaHk8PkcFbxC/zDro3rxEg0zkwMvFFaUQXA=;
        b=cqvwrquadGTK5A/RFBfaIxr+O3+aQJe1vM64pFq0HDOH0rhN3deZEzmjY9jH3KTZi+
         Erz2bSlAWNN4TUgMDIu5hc98h8ylsy2duZQaJjII7S2xQSO3KXSBOj+S3r7pao7M3Y90
         sQhv1xColz3XvSNASzzZC+EeyyEDqgmHGljRk7B/CBMXx4ku2PFROVN/ipBuD+7lHBJK
         +DBXdKDmAk+KSlRJdnPCdM6aYumWuiAl/OmlrjjeRZTWRxQ5W3JfJF4IZt/lsbRUxjfr
         QQvLRKJaWrtQRugEp547htGpglKQmMeh0KQX6QONhPQtR88QuVQazSXcIj4EvbHqhL9G
         PpaA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@broadcom.com header.s=google header.b=WHirR4CR;
       spf=pass (google.com: domain of arend.vanspriel@broadcom.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=arend.vanspriel@broadcom.com;
       dmarc=pass (p=QUARANTINE sp=QUARANTINE dis=NONE) header.from=broadcom.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@broadcom.com header.s=google header.b=WHirR4CR;
       spf=pass (google.com: domain of arend.vanspriel@broadcom.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=arend.vanspriel@broadcom.com;
       dmarc=pass (p=QUARANTINE sp=QUARANTINE dis=NONE) header.from=broadcom.com
X-Google-Smtp-Source: AG47ELu0AIRgXhKuGJXppWpI8LMwrWdfZlBVy0evllwFk2vUwnM1xLDfAyAWIh+o0XKNafxQW8oMkQ==
Subject: Re: [PATCH] firmware: add a function to load optional firmware v2
To: Kalle Valo <kvalo@codeaurora.org>, "Luis R. Rodriguez" <mcgrof@kernel.org>
References: <20180309221243.15489-2-andresx7@gmail.com>
 <20180309230925.3573-1-andresx7@gmail.com>
 <CAB=NE6VY62KqmhzD=zT8od=PhgPi3rGKKKxKz_zad-ZrYW-97A@mail.gmail.com>
 <87a7vcazf1.fsf@kamboji.qca.qualcomm.com>
 <20180313164026.GG4449@wotan.suse.de>
 <87fu53apod.fsf@kamboji.qca.qualcomm.com>
Cc: Andres Rodriguez <andresx7@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-wireless <linux-wireless@vger.kernel.org>
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <5AA8DC29.2000806@broadcom.com>
Date: Wed, 14 Mar 2018 09:24:09 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
MIME-Version: 1.0
In-Reply-To: <87fu53apod.fsf@kamboji.qca.qualcomm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594503439621024078?=
X-GMAIL-MSGID: =?utf-8?q?1594900717612559588?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 3/13/2018 5:46 PM, Kalle Valo wrote:
> "Luis R. Rodriguez" <mcgrof@kernel.org> writes:
>
>> On Tue, Mar 13, 2018 at 03:16:34PM +0200, Kalle Valo wrote:
>>> "Luis R. Rodriguez" <mcgrof@kernel.org> writes:
>>>
>>>>> +/**
>>>>> + * request_firmware_optional: - request for an optional fw module
>>>>> + * @firmware_p: pointer to firmware image
>>>>> + * @name: name of firmware file
>>>>> + * @device: device for which firmware is being loaded
>>>>> + *
>>>>> + * This function is similar in behaviour to request_firmware(), except
>>>>> + * it doesn't produce warning messages when the file is not found.
>>>>> + **/
>>>>> +int
>>>>> +request_firmware_optional(const struct firmware **firmware_p, const char *name,
>>>>> +                         struct device *device)
>>>>> +{
>>>>> +       int ret;
>>>>> +
>>>>> +       /* Need to pin this module until return */
>>>>> +       __module_get(THIS_MODULE);
>>>>> +               ret = _request_firmware(firmware_p, name, device, NULL, 0,
>>>>> +                               FW_OPT_UEVENT | FW_OPT_NO_WARN );
>>>>> +       module_put(THIS_MODULE);
>>>>> +       return ret;
>>>>> +}
>>>>> +EXPORT_SYMBOL(request_firmware_optional);
>>>>
>>>> New exported symbols for the firmware API should be EXPORT_SYMBOL_GPL().
>>>
>>> To me the word optional feels weird to me. For example, in ath10k I
>>> suspect we would be only calling request_firmware_optional() with all
>>> firmware and not request_firmware() at all.
>>>
>>> How about request_firmware_nowarn()? That would even match the
>>> documentation above.
>>
>> _nowarn() works with me. Do you at least want the return value to give
>> an error value if no file was found? This way the driver can decide
>> when to issue an error if it wants to.
>
> Yes, it would be very good to return the error value to ath10k. That way
> we can give a proper error message to the user if we can't find a
> suitable firmware image.

I fully agree with the _nowarn() and returning an error. However, the 
firmware_p parameter (btw. do we really want the _p postfix?) is an 
output parameter which will be null in case of an error so do you really 
need a specific error code for the proper error message.

Regards,
Arend
