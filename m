Return-Path: <keescook@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524323466; cv=none;
        d=google.com; s=arc-20160816;
        b=iGkWC1tBRY4ORmUhQab99dyfb1/h6N6XTLmyQWmd8+vF8ZSso+TrRA/J1fcikZps8+
         5dkRiV3HeQl/1B4YZvlhjk0vI4Oj4vMjhSYI6guGHQZLvLOITdFpF08BhX1D+Kn+XDnI
         yjVxFKBUQY1MAiIiqzUy7aD4K5ohYrTiMQtmeSM9IHd/aa8IJz0+yUeNrOIJL+tlyXdP
         vNf926auIPfpTRw4PM/SyAoHQixfjXHGTUiwe79Yf0Z21m7lvl58bOCWba90TJAH9r5i
         Fve/TKtez7j2Y+DVFHQ0FI1ORO0Dap8HOeIdju9/V9ZqrFQYsm6FOSzbgg5NiSr2YAYN
         llEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=YkNNVtlK4emrr49enc8cwC4sWfevxbi+yYuUasSKuFg=;
        b=VNia1FY3q2HAL1l9OkPJp8OdsFYCIAjlndWYKq0hM0PpAsQqBA7u4QbJparWUwVxGQ
         dQAfIoX3Y5v6oO3hQgzh7Iv3bdNZTHKB71+F9xApekixFZEHFbxRHDi9DubwX3wmOAe7
         tf9/HyQePjvm9F1S4EKBstPIZ/3/5JxtM81v6fNdyNNkd/Ox/5bv/iC9r9FAgWNuT9Qc
         2HF8fjO4vMy4dsEJeytP0v4r2iGBVXHNzmU+aVGGEQMLcvypUsc1djrg3ckvAJPpXJxv
         2sUTWo+Rz86NSlxZkG90vT9IHaHXQcSLzl06ka60jMXt26B9HFO1eHNgEUW2b0Vyprm+
         TcEQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=r1ym21/X;
       dkim=pass header.i=@chromium.org header.s=google header.b=CfaDqP7q;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=r1ym21/X;
       dkim=pass header.i=@chromium.org header.s=google header.b=CfaDqP7q;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AIpwx48rDu0X3h+mPtTVK4Lt/H+58f2UOREKdQEFb3zCil2di7iw2DOOeuYST8mvUEHu2PoV+LEu2BqtJnvEaz8NIUc=
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <20180421144911.GV14440@wotan.suse.de>
References: <20180417153307.3693-1-andresx7@gmail.com> <20180417153307.3693-6-andresx7@gmail.com>
 <20180421143206.GQ14440@wotan.suse.de> <20180421144911.GV14440@wotan.suse.de>
From: Kees Cook <keescook@chromium.org>
Date: Sat, 21 Apr 2018 08:11:04 -0700
X-Google-Sender-Auth: zgP2zG_uOHrfUyOb-sJYM3lJ1Q8
Message-ID: <CAGXu5jKVv8R1yVcuCCPJb1YD9u8tiZyj86wdz043PKxKPZj4Lg@mail.gmail.com>
Subject: Re: [PATCH 5/9] firmware: add functions to load firmware without
 warnings v4
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: Andres Rodriguez <andresx7@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hans de Goede <hdegoede@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>,
	David Woodhouse <dwmw2@infradead.org>, LKML <linux-kernel@vger.kernel.org>,
	Alex Deucher <alexdeucher@gmail.com>, ckoenig.leichtzumerken@gmail.com,
	Kalle Valo <kvalo@codeaurora.org>, Arend van Spriel <arend.vanspriel@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598008015463324966?=
X-GMAIL-MSGID: =?utf-8?q?1598369002755941842?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, Apr 21, 2018 at 7:49 AM, Luis R. Rodriguez <mcgrof@kernel.org> wrote:
> On Sat, Apr 21, 2018 at 04:32:06PM +0200, Luis R. Rodriguez wrote:
>> On Tue, Apr 17, 2018 at 11:33:03AM -0400, Andres Rodriguez wrote:
>> > @@ -755,10 +779,11 @@ static void firmware_request_work_func(struct work_struct *work)
>> >  }
>> >
>> >  /**
>> > - * firmware_request_nowait() - asynchronous version of firmware_request
>> > + * firmware_request_nowait2() - asynchronous version of firmware_request
>> >   * @module: module requesting the firmware
>> >   * @uevent: sends uevent to copy the firmware image if this flag
>> >   * is non-zero else the firmware copy must be done manually.
>> > + * @warn: enable warnings
>> >   * @name: name of firmware file
>> >   * @device: device for which firmware is being loaded
>> >   * @gfp: allocation flags
>> > @@ -778,8 +803,8 @@ static void firmware_request_work_func(struct work_struct *work)
>> >   *         - can't sleep at all if @gfp is GFP_ATOMIC.
>> >   **/
>> >  int
>> > -firmware_request_nowait(
>> > -   struct module *module, bool uevent,
>> > +firmware_request_nowait2(
>> > +   struct module *module, bool uevent, bool warn,
>> >     const char *name, struct device *device, gfp_t gfp, void *context,
>> >     void (*cont)(const struct firmware *fw, void *context))
>> >  {
>> > @@ -799,7 +824,8 @@ firmware_request_nowait(
>> >     fw_work->context = context;
>> >     fw_work->cont = cont;
>> >     fw_work->opt_flags = FW_OPT_NOWAIT |
>> > -           (uevent ? FW_OPT_UEVENT : FW_OPT_USERHELPER);
>> > +           (uevent ? FW_OPT_UEVENT : FW_OPT_USERHELPER) |
>> > +           (warn ? 0 : FW_OPT_NO_WARN);
>> >
>> >     if (!uevent && fw_cache_is_setup(device, name)) {
>> >             kfree_const(fw_work->name);
>> > @@ -818,6 +844,24 @@ firmware_request_nowait(
>> >     schedule_work(&fw_work->work);
>> >     return 0;
>> >  }
>> > +EXPORT_SYMBOL_GPL(firmware_request_nowait2);
>> > +
>> > +/**
>> > + * firmware_request_nowait() - compatibility version of firmware_request_nowait2
>> > + *
>> > + * This is equivalent to calling firmware_request_nowait2 with warnings enabled.
>> > + *
>> > + * Refer to firmware_request_nowait2 for further details.
>> > + **/
>> > +int
>> > +firmware_request_nowait(
>> > +   struct module *module, bool uevent,
>> > +   const char *name, struct device *device, gfp_t gfp, void *context,
>> > +   void (*cont)(const struct firmware *fw, void *context))
>> > +{
>> > +   return firmware_request_nowait2(module, uevent, true, name, device,
>> > +                                   gfp, context, cont);
>> > +}
>> >  EXPORT_SYMBOL(firmware_request_nowait);
>> >
>> >  #ifdef CONFIG_PM_SLEEP
>>
>> Ugh this is precisely the type of naming issue I predicted *years ago*
>> about the unflexibility of the naming scheme we used. Greg, since you had
>> sent us this rabbit hole, any name preference here? Please review what is
>> proposed and also suggest a scheme which you do prefer. I'm done with
>> the bikeshedding and just want to move on, but in a way that scales.
>
> I'll side for now with Kalle's suggestion of having:
>
> firmware_request_nowait_nowarn()
>
> as nasty as it may seem. And this is just because we embarked on
> the path to not have parameters passed to modify the calls site.

What was the objection to using parameters for this? i.e. something
like the gfp flags, but have a behavior flag FW_RQ_NOWAIT,
FW_RQ_NOWARN, etc?

-Kees

-- 
Kees Cook
Pixel Security
