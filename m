Return-Path: <kvalo@codeaurora.org>
X-Google-Smtp-Source: AG47ELsPtT5/QPo52ienK+yt1g0vIOthnO9/2zUbIGgGL6GxvdSImCvGd5P4rCTpxOhADPWhb/rf
ARC-Seal: i=1; a=rsa-sha256; t=1520946999; cv=none;
        d=google.com; s=arc-20160816;
        b=vFsIbusB3ioAp3is75nJ50qk4nbp73fJbgBrIiWiGgHpmwC2p62A1Z1nBKb8/9kAo+
         29pUOB8rMKpmgaSDWJbQJ7dNIKoKtTlxCGCSv2f7ufqozf7YomEwi6CqzVdfqtUAkiSj
         EnmepiS+cpMKQdawLOHGNbIKj2Rdj16VFiJwAIcNREQXdkeDYelu4m12ErxBedjNztjw
         sXJqBSAYfVAIEDCMP3n2W2s6MUD75d/RN/L6WpdVMk1md8BViN3qQ7WeZmPvq7n6I4YA
         YKZfUc/xFAqrNDUxdJ64QQAKo+GTGMpnF3PZRie/9Ncs0PtQbJmRK0fgx2OEkKRu71HW
         I0aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=6/8m+nJc2m//7TowFmCZAeRE8ERp55QxrDeIgDn98zo=;
        b=tE5tdBNGccHSdBeJwmzZ7g3nMxL2tj9bEiopurimm2rziJ4zkiXeFAHxelobCBHUTi
         nJEs8Oa9ihqcHcXIG5c8QwouLBlkndA2zCn1VrUJ5mR4q9lJZZ4JtIkYeqEfRqdycrwV
         untV4/UlesCoFreJ12tQn65Cs52v4PTPPAlcDi5VH9wOlly0rkc/E1F/BI6xvUCD0wol
         UtQH5y9vix5n99B0X7oHA8IyIivYBgZTodVcfC3w+VLT80tokXeG/ok3j8TLEt/i6ppy
         /3kj9iOaCRCIufQo5EX+Wlu24cr28Tz6Q8co+9Is8Xj+6iwnK/Ki6oyODyqVmUVTIqz/
         Ltvw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=l/ApRuOJ;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=l/ApRuOJ;
       spf=pass (google.com: domain of kvalo@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=kvalo@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=l/ApRuOJ;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=l/ApRuOJ;
       spf=pass (google.com: domain of kvalo@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=kvalo@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 07FAC60591
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From: Kalle Valo <kvalo@codeaurora.org>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: Andres Rodriguez <andresx7@gmail.com>,  "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,  Greg Kroah-Hartman <gregkh@linuxfoundation.org>,  linux-wireless <linux-wireless@vger.kernel.org>,  Arend Van Spriel <arend.vanspriel@broadcom.com>
Subject: Re: [PATCH] firmware: add a function to load optional firmware v2
References: <20180309221243.15489-2-andresx7@gmail.com>
	<20180309230925.3573-1-andresx7@gmail.com>
	<CAB=NE6VY62KqmhzD=zT8od=PhgPi3rGKKKxKz_zad-ZrYW-97A@mail.gmail.com>
Date: Tue, 13 Mar 2018 15:16:34 +0200
In-Reply-To: <CAB=NE6VY62KqmhzD=zT8od=PhgPi3rGKKKxKz_zad-ZrYW-97A@mail.gmail.com>
	(Luis R. Rodriguez's message of "Sat, 10 Mar 2018 06:35:30 -0800")
Message-ID: <87a7vcazf1.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594503439621024078?=
X-GMAIL-MSGID: =?utf-8?q?1594828521207027052?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

"Luis R. Rodriguez" <mcgrof@kernel.org> writes:

>> +/**
>> + * request_firmware_optional: - request for an optional fw module
>> + * @firmware_p: pointer to firmware image
>> + * @name: name of firmware file
>> + * @device: device for which firmware is being loaded
>> + *
>> + * This function is similar in behaviour to request_firmware(), except
>> + * it doesn't produce warning messages when the file is not found.
>> + **/
>> +int
>> +request_firmware_optional(const struct firmware **firmware_p, const char *name,
>> +                         struct device *device)
>> +{
>> +       int ret;
>> +
>> +       /* Need to pin this module until return */
>> +       __module_get(THIS_MODULE);
>> +               ret = _request_firmware(firmware_p, name, device, NULL, 0,
>> +                               FW_OPT_UEVENT | FW_OPT_NO_WARN );
>> +       module_put(THIS_MODULE);
>> +       return ret;
>> +}
>> +EXPORT_SYMBOL(request_firmware_optional);
>
> New exported symbols for the firmware API should be EXPORT_SYMBOL_GPL().

To me the word optional feels weird to me. For example, in ath10k I
suspect we would be only calling request_firmware_optional() with all
firmware and not request_firmware() at all.

How about request_firmware_nowarn()? That would even match the
documentation above.

-- 
Kalle Valo
