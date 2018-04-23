Return-Path: <amit.pundir@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1524504135; cv=none;
        d=google.com; s=arc-20160816;
        b=Lwkw+M3Zr0dcNfyt0PkTXQQDKCIO4iBQk/IRV9jHJFSeM1H8/lExCoZIKu3VkiwKQi
         yUOqniNvnb8H+jKymA2NH6+pHl01IGLh1ANEne3ZiMhzGajH1BEWGH1BR2I4SzQZ/3WT
         /h74L5/bKWZ4tjI2DrdUfZweYjWJ8OPNXF+kkKIpN/0+Sxnz2dLPvcEjLnFlMUpsF847
         KA+ovhcBs+YFQHB7V1rWhqMmRi7ESJTN7Zxoc1pEDVYa95S2+ncENzYvLFKmFuGMprQ+
         9KMONvSCUllHTmd1h2he210Wf2mCMjB4n6EmZTs/G1ii2qOsakvK/EgzNHba4wMpjJq+
         kfWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=1imOBoA2UU94O/dyyetIXILQInT2G6JtOGvFyiQPAFw=;
        b=aoM0/jQmMWnVTD2HjHbTp7l1LADCHHRRewRhwHlCzQBlQi2HhJ1k0Yupg3KpiudASP
         jDBaMPHQWKm92a11l7GjiL4WOc5x3eSGq0uefwWvhnIjOGQrfZv9RuFg+DM4/EGtctVA
         CI1MsZ3l6mYxJgsLf8cd6YxqtTmTfNZB5D0ws4AaetwQceVHufnLgF17QwkfxKJ1zsjt
         bEvudeoZH6vDb7IJV8q+tvSQlB19GORBdj8gvXGnvV7rAEmWZm39Nk/50e8H/X8OMcqI
         F+1ln0hF5XRqXqTzi1vH9WQcuV4vlG8gTzaDX0usFe+tnKuN4F4P16ByDPq8ICqPzHZH
         4fXg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=POxhUfgZ;
       spf=pass (google.com: domain of amit.pundir@linaro.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=amit.pundir@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=POxhUfgZ;
       spf=pass (google.com: domain of amit.pundir@linaro.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=amit.pundir@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AB8JxZoti5cXZr1s4vmNc1PCLMwgGXrjvNqJDfTZ5Cr0CnISJPWUwwNy+OVXD0CYdsEYHViK7NjsOD35j5mQXSaFRJk=
MIME-Version: 1.0
In-Reply-To: <20180420164507.GA22666@animalcreek.com>
References: <1524045904-7005-1-git-send-email-amit.pundir@linaro.org>
 <1524045904-7005-3-git-send-email-amit.pundir@linaro.org> <1524227986.21176.467.camel@linux.intel.com>
 <20180420164507.GA22666@animalcreek.com>
From: Amit Pundir <amit.pundir@linaro.org>
Date: Mon, 23 Apr 2018 22:51:35 +0530
Message-ID: <CAMi1Hd36LbWSTsnxiLY0CAgW_CaAbTJNRrUQ07Qb4OiSmuC5sw@mail.gmail.com>
Subject: Re: [RESEND][PATCH 2/4] NFC: st21nfca: Fix memory OOB and leak issues
 in connectivity events handler
To: Mark Greer <mgreer@animalcreek.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, lkml <linux-kernel@vger.kernel.org>,
	linux-wireless@vger.kernel.org, Samuel Ortiz <sameo@linux.intel.com>,
	Christophe Ricard <christophe.ricard@gmail.com>, Greg KH <gregkh@linuxfoundation.org>,
	John Stultz <john.stultz@linaro.org>, Dmitry Shmidt <dimitrysh@google.com>,
	Todd Kjos <tkjos@google.com>, Android Kernel Team <kernel-team@android.com>,
	Suren Baghdasaryan <surenb@google.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598077974606996222?=
X-GMAIL-MSGID: =?utf-8?q?1598558448767002317?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 20 April 2018 at 22:15, Mark Greer <mgreer@animalcreek.com> wrote:
> On Fri, Apr 20, 2018 at 03:39:46PM +0300, Andy Shevchenko wrote:
>> On Wed, 2018-04-18 at 15:35 +0530, Amit Pundir wrote:
>>
>> >             if (skb->data[transaction->aid_len + 2] !=
>> > -               NFC_EVT_TRANSACTION_PARAMS_TAG)
>> > +               NFC_EVT_TRANSACTION_PARAMS_TAG ||
>> > +               skb->len < transaction->aid_len + transaction-
>> > >params_len + 4) {
>>
>> > +                   devm_kfree(dev, transaction);
>>
>> Oh, no.
>>
>> This is not memory leak per se, this is bad choice of devm_ API where it
>> should use plain kmalloc() / kfree().
>
> Also, there is no check to see if the allocation worked at all.

Ack. I'll add that in v2.
Thanks.

Regards,
Amit Pundir

>
> Mark
> --
