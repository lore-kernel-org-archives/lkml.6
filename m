Return-Path: <kvalo@codeaurora.org>
X-Google-Smtp-Source: AG47ELupINIB8ksPXxYaKOUCh/ol+EnarC0b16Cso0QStlc68lQ8tB1jZBTzny0Y+3vnTQmbfmfs
ARC-Seal: i=1; a=rsa-sha256; t=1520959628; cv=none;
        d=google.com; s=arc-20160816;
        b=ArcN2TNM8gU6g/OgkJWJ0tr4zCI6qf5yVuuDXsD+DN5SpqdQIoBirbETicXHEPVKXx
         L4SIunjWH/ZY/VLCY8HjFyRE4YGaHHbJqKI50Bu/PYDae0uIdZwlwUZ2OgpXN2iazge/
         W0UsS55Zj/elJJKvTv2jqkj6vZxiSJTYdKxm+6eU/WnfV6DYJhcVHxpf88KhPzInoSWJ
         NHA+pAfk1tlrt36gbQHuShesIK6G1BKNnlU5zw0cNEnc8Cy69OpUrvZ2CTQmX0+ppG0k
         6wobGjQfGX4PBcPBU/3arDpQd7NwdM8/c2E+rBcEvKmZFd3Yg/Pk9lkGw4k1ryZPoURa
         w0PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=XcjMsfzMCcBooLyv37XjIlsfjWDDwMvUaHf2TLGwqSQ=;
        b=bS7E1hEHUGTxaq3qVrZ2bnrF+zQeK6YWd9teRmD0RZIIx6iraE7eeXYB5Z7ejP9BN1
         lTEfhyHcMvoTUqNiMfxba2QbVnPKnigFKQLjuX+V1YfmiR2b9txC1W6wOenQKYXQGDEq
         ibEuJn5Ka18nEdq5NdLoN6RCnJEZmbnIMNu9L4mqa+whb6DfJuT0dlM5cnLAXLZRRWU0
         0H1G320Y0MQFFIJ6wbzmkeAV8YiaZZOVobNzJ7fOeRSJwNGg/34sMqOzUUKpD9aPCI95
         uGCffN7K4rLAWxbNJLnwc2kmVfF88KGGfOEi2tXWy7R8xWt1ZTcdmeSz7I/H8rpGOaEh
         xziw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=In1O6baA;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=BgKWBEti;
       spf=pass (google.com: domain of kvalo@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=kvalo@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=In1O6baA;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=BgKWBEti;
       spf=pass (google.com: domain of kvalo@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=kvalo@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B52FB60B1E
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From: Kalle Valo <kvalo@codeaurora.org>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: Andres Rodriguez <andresx7@gmail.com>,  "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,  Greg Kroah-Hartman <gregkh@linuxfoundation.org>,  linux-wireless <linux-wireless@vger.kernel.org>,  Arend Van Spriel <arend.vanspriel@broadcom.com>
Subject: Re: [PATCH] firmware: add a function to load optional firmware v2
References: <20180309221243.15489-2-andresx7@gmail.com>
	<20180309230925.3573-1-andresx7@gmail.com>
	<CAB=NE6VY62KqmhzD=zT8od=PhgPi3rGKKKxKz_zad-ZrYW-97A@mail.gmail.com>
	<87a7vcazf1.fsf@kamboji.qca.qualcomm.com>
	<20180313164026.GG4449@wotan.suse.de>
Date: Tue, 13 Mar 2018 18:46:58 +0200
In-Reply-To: <20180313164026.GG4449@wotan.suse.de> (Luis R. Rodriguez's
	message of "Tue, 13 Mar 2018 16:40:26 +0000")
Message-ID: <87fu53apod.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594503439621024078?=
X-GMAIL-MSGID: =?utf-8?q?1594841763722133054?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

"Luis R. Rodriguez" <mcgrof@kernel.org> writes:

> On Tue, Mar 13, 2018 at 03:16:34PM +0200, Kalle Valo wrote:
>> "Luis R. Rodriguez" <mcgrof@kernel.org> writes:
>> 
>> >> +/**
>> >> + * request_firmware_optional: - request for an optional fw module
>> >> + * @firmware_p: pointer to firmware image
>> >> + * @name: name of firmware file
>> >> + * @device: device for which firmware is being loaded
>> >> + *
>> >> + * This function is similar in behaviour to request_firmware(), except
>> >> + * it doesn't produce warning messages when the file is not found.
>> >> + **/
>> >> +int
>> >> +request_firmware_optional(const struct firmware **firmware_p, const char *name,
>> >> +                         struct device *device)
>> >> +{
>> >> +       int ret;
>> >> +
>> >> +       /* Need to pin this module until return */
>> >> +       __module_get(THIS_MODULE);
>> >> +               ret = _request_firmware(firmware_p, name, device, NULL, 0,
>> >> +                               FW_OPT_UEVENT | FW_OPT_NO_WARN );
>> >> +       module_put(THIS_MODULE);
>> >> +       return ret;
>> >> +}
>> >> +EXPORT_SYMBOL(request_firmware_optional);
>> >
>> > New exported symbols for the firmware API should be EXPORT_SYMBOL_GPL().
>> 
>> To me the word optional feels weird to me. For example, in ath10k I
>> suspect we would be only calling request_firmware_optional() with all
>> firmware and not request_firmware() at all.
>> 
>> How about request_firmware_nowarn()? That would even match the
>> documentation above.
>
> _nowarn() works with me. Do you at least want the return value to give
> an error value if no file was found? This way the driver can decide
> when to issue an error if it wants to.

Yes, it would be very good to return the error value to ath10k. That way
we can give a proper error message to the user if we can't find a
suitable firmware image.

-- 
Kalle Valo
