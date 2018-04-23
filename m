Return-Path: <amit.pundir@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1524504060; cv=none;
        d=google.com; s=arc-20160816;
        b=YfR7ocjHGJmKdjDNScA3rqg0z5FexmDgr9bxwRUKV1Z25RqyBIRUwtXf5uNHt3tTFJ
         W39k1ZOO8LyyHsxMByZYOsMWrWjOZkntc7iQnOYV50t+qgd56TU2c78piBO/qCB+Fbix
         CXhBgXae+9hD/o2Wm+uIAIupmWuLhdCa3XU24HE+aeyrsbKfKdxso/rdY0pIbsEnY/yH
         XZcB0wVWSzvUjoyCOIc2G9FwI5MD2X2pekJ15gb5fKmorGFo/Rk+geGcUHsjpY9tNDrA
         mBxYg4UXkWnrpd3YdgGQPuT80WhRtiHv8Q3WEMwzPEj5HIIJwqA7SsSjmq5MnkGosL90
         cb8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=HzHrQRlVuj3bW05OGwUabgjNt8M7YSi7TF65unWm5vw=;
        b=eIL4L9BTXadktnQ2RcL9xEsJKnUAD4+K9Ay3v9k0vy/QAD8xK/JBe1S454zxqOnVWS
         YkcPvD31UmpCoKwkkEq9gp4zGnL0Gwu8pZsChzgaZx/EAIGSQKCicAu8INpGDAtog8cU
         yP9UQ3BDJYg3oRFtnuNQPoxo7FdcNUOO8OO2TI1Ucl/x4BJ2dCZ8u6OtHYFTV1+7wEkj
         +rDb3xap9h8v9L4Xg1qeXqYbI3vAcEGlrrIDKEVECrP2987oFQZ4xKr8DwZQ5a1kyPLS
         7V6X1z97T4dGlyMPTlriiegfCvgon4udvz6SkfWPIN8L+3/g7wrNJfkQmQTLnJlgMKD6
         wPHg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=OYroK1H8;
       spf=pass (google.com: domain of amit.pundir@linaro.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=amit.pundir@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=OYroK1H8;
       spf=pass (google.com: domain of amit.pundir@linaro.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=amit.pundir@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AB8JxZoQ55GD0fP9kJsFXDn5vTkzNjFSvnoLjMZNe0Uq+gXpcZ6FyLYQr1Bj6B8HuMwxvqmO5hvYqQOijoG7w/arXt4=
MIME-Version: 1.0
In-Reply-To: <1524227986.21176.467.camel@linux.intel.com>
References: <1524045904-7005-1-git-send-email-amit.pundir@linaro.org>
 <1524045904-7005-3-git-send-email-amit.pundir@linaro.org> <1524227986.21176.467.camel@linux.intel.com>
From: Amit Pundir <amit.pundir@linaro.org>
Date: Mon, 23 Apr 2018 22:50:19 +0530
Message-ID: <CAMi1Hd1Hxgo=_1CMDJ8_mnzfcEm97=aiYoxgf42rK_oXp17arQ@mail.gmail.com>
Subject: Re: [RESEND][PATCH 2/4] NFC: st21nfca: Fix memory OOB and leak issues
 in connectivity events handler
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: lkml <linux-kernel@vger.kernel.org>, linux-wireless@vger.kernel.org,
	Samuel Ortiz <sameo@linux.intel.com>, Christophe Ricard <christophe.ricard@gmail.com>,
	Greg KH <gregkh@linuxfoundation.org>, John Stultz <john.stultz@linaro.org>,
	Dmitry Shmidt <dimitrysh@google.com>, Todd Kjos <tkjos@google.com>,
	Android Kernel Team <kernel-team@android.com>, Suren Baghdasaryan <surenb@google.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598077974606996222?=
X-GMAIL-MSGID: =?utf-8?q?1598558369590629541?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 20 April 2018 at 18:09, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Wed, 2018-04-18 at 15:35 +0530, Amit Pundir wrote:
>
>>               if (skb->data[transaction->aid_len + 2] !=
>> -                 NFC_EVT_TRANSACTION_PARAMS_TAG)
>> +                 NFC_EVT_TRANSACTION_PARAMS_TAG ||
>> +                 skb->len < transaction->aid_len + transaction-
>> >params_len + 4) {
>
>> +                     devm_kfree(dev, transaction);
>
> Oh, no.
>
> This is not memory leak per se, this is bad choice of devm_ API where it
> should use plain kmalloc() / kfree().
>

Hi, If I switch to kmalloc()/kfree() with allocation and may be
pre-usage checks along the way up to nfc_genl_se_transaction() would
that suffice? I believe, I still be needing the additional aid_len and
params_len checks regardless, right?

Regards,
Amit Pundir

>>                       return -EPROTO;
>> +             }
>
> --
> Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Intel Finland Oy
