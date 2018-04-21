Return-Path: <linus971@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524324721; cv=none;
        d=google.com; s=arc-20160816;
        b=jPuKGK/pW4K0jOU18kBFNOVRXf+n5/J0BqDRpxlusdr/m6UE8iOyOSHxcZh+YD/hML
         /DJHWiCwi3CmPjesUv+i+MNqOcoEelul9lYmyb73LjGFjeAU/2/B3gujSGy6uMAsAc/E
         yuH9l/xm+LOwhKsHBlC1yJdqd8zB8eIqol0CiaN7dVMvIrn7ESFoOAp8mFkvlN2xjsAq
         520Eq8oeLD3K0gYqPJ37FEiesUn4j19DIZ4VvAC5j67O5E6UKHO4gvTu+cyuA1l08WYB
         IY+wbSDpR2xOQfpLqWBFGtELnr0AqbhiuVfh0FUBRMYPFKsY3LfBUmXRQrUDVX/YM5gX
         n8cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=fbhf1Qo7vfyGnc/e+1jclJWKSjfU2phpqvet10Umwpk=;
        b=AZTdBblp82IUBqghlElId1HpvGOsKko4W0rsY3L0UAh8qUL6R2lB8rVlFhCBUGBgvk
         4/FTeBSwGKtWRC/rOls9rJZ3Bwa/jMEh6I7HYGu3+k2Bq1V8dzFbsEIDLlGvd+fzkEuO
         cPUm+mYEgzLr2EPq0v7hWgm4g53mSQCBz8AhJhhddOxkTV1wApUCTU4jXEf+NjBoQEj2
         g+9dLLjypLZiXuct0ZIXcoe73vnKezhFhD0zbbB/ZOeAdiiwFBbBHJVZuTNxyJSX4Dnj
         8n0uOw/cqGUVmla2sNApPEyJj6vCrfW3Rp3wY80YYid+DhPk1i2zGgV5E22hFh3vUVvj
         BSyw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=d351EPeQ;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=LsLO4utk;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=linus971@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=d351EPeQ;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=LsLO4utk;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=linus971@gmail.com
X-Google-Smtp-Source: AB8JxZoewUegui8tl0WO0EO56JTjcVVkJsIrIREyL9BaaESmc0eLecYJ0qChkSGARwjU86RgIkPCAEM2rJ4iB8aif2k=
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <CAGXu5jKVv8R1yVcuCCPJb1YD9u8tiZyj86wdz043PKxKPZj4Lg@mail.gmail.com>
References: <20180417153307.3693-1-andresx7@gmail.com> <20180417153307.3693-6-andresx7@gmail.com>
 <20180421143206.GQ14440@wotan.suse.de> <20180421144911.GV14440@wotan.suse.de> <CAGXu5jKVv8R1yVcuCCPJb1YD9u8tiZyj86wdz043PKxKPZj4Lg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 21 Apr 2018 08:32:00 -0700
X-Google-Sender-Auth: 4u7-33D7r0xNYwqD7l5KG_McX-0
Message-ID: <CA+55aFw4WxBDD3YA9Ksj=mxcYmAg7+bnjfuDVtBnzn+0w6mtbw@mail.gmail.com>
Subject: Re: [PATCH 5/9] firmware: add functions to load firmware without
 warnings v4
To: Kees Cook <keescook@chromium.org>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>, Andres Rodriguez <andresx7@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Hans de Goede <hdegoede@redhat.com>,
	David Woodhouse <dwmw2@infradead.org>, LKML <linux-kernel@vger.kernel.org>,
	Alex Deucher <alexdeucher@gmail.com>, ckoenig.leichtzumerken@gmail.com,
	Kalle Valo <kvalo@codeaurora.org>, Arend van Spriel <arend.vanspriel@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598008015463324966?=
X-GMAIL-MSGID: =?utf-8?q?1598370319608210713?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, Apr 21, 2018 at 8:11 AM, Kees Cook <keescook@chromium.org> wrote:
>
> What was the objection to using parameters for this? i.e. something
> like the gfp flags, but have a behavior flag FW_RQ_NOWAIT,
> FW_RQ_NOWARN, etc?

The objection was that the patches that I think Luis refers to

 (a) passed in a union of random arguments

 (b) changed all the users, even the ones that didn't want to be changed.

they were nasty and illegible and pointless.

Using some single flag field for an extended function, and leaving the
existing functions alone so that you don't have to convert existing
users - that would have been fine. That's not what was tried and
rejected.

              Linus
