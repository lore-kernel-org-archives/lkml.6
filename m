Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61E03C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 23:56:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 045602170E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 23:56:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ct3+BZww"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 045602170E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727881AbeHOCqV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 22:46:21 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:36400 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726837AbeHOCqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 22:46:21 -0400
Received: by mail-ua1-f66.google.com with SMTP id c12-v6so15140293uan.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Aug 2018 16:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=UwJfCvGdbdWxYL3wU4DcmdEjvgZoWaRoeF6+kLsy9iY=;
        b=ct3+BZwwAQr2glyteG4aBUAdpv5VfgPsugOf2g/8zU4D3OHH8xayFD7j6CScHomDM/
         4xtJBfiWmQ0r1S63uadp3LOjKK21s9XR3Kr9CQwFYzYQY2S2r0OQg60F3v9W0ir0tOA9
         kgCe+/D+Jhen8pHn8lsy0/GulS953CdngVYOM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=UwJfCvGdbdWxYL3wU4DcmdEjvgZoWaRoeF6+kLsy9iY=;
        b=JniOmOKROdHX1aMYDXCiYXF9/+43A6yEbjE/Gpw+6VZjsg3g4QysGsg35UxwP4hEp9
         TqzndPMUQSOMrRi5y7c6oHDetaHh/UOp4Y5rWzBvE37VbTJE6CQ2mXdeLsR+ASwFC+jQ
         qheSthyrOPqR7Gdo3E4Rd1L+WvN+ss1rit4fnVYtmlzpe9bajWcpJG/4brC6MwzrZ8ni
         9zpG9lCfgdvFZ/LyZP+8Z+R4pntjpYcWGCe2IwiU73dvy6kkF9nXnuk2Ubo8h2gr8CEu
         7PaSkt35SMqDyIdl2E73dq5KqVF1ZFs7EMO6ZojtUML0qwrz+WR1cqlIA8S/KVgQbqvF
         PYNw==
X-Gm-Message-State: AOUpUlG9R1wJhrnUGXhvtuNg/9UIMIgW6R/MJRjTSwWCC7go3mrIhE0U
        2kpJka2r58dV8U9BLilg9nMlWKxdXYM=
X-Google-Smtp-Source: AA+uWPzRRagfo7hb82o+CeJWM2+QPkWipI8U2954XB4Pk79cfrQwIGFdRRQdKdB0jpmxQN43aDouMg==
X-Received: by 2002:ab0:5b57:: with SMTP id v23-v6mr15657567uae.72.1534291005043;
        Tue, 14 Aug 2018 16:56:45 -0700 (PDT)
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com. [209.85.222.52])
        by smtp.gmail.com with ESMTPSA id b132-v6sm4428368vke.10.2018.08.14.16.56.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Aug 2018 16:56:43 -0700 (PDT)
Received: by mail-ua1-f52.google.com with SMTP id f4-v6so15167453uao.10
        for <linux-kernel@vger.kernel.org>; Tue, 14 Aug 2018 16:56:43 -0700 (PDT)
X-Received: by 2002:ab0:11dd:: with SMTP id q29-v6mr15638743uac.191.1534291003197;
 Tue, 14 Aug 2018 16:56:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1f:cd5:0:0:0:0:0 with HTTP; Tue, 14 Aug 2018 16:56:42 -0700 (PDT)
In-Reply-To: <aa2bd1f6-74b4-a63b-d115-88d6e16ed95d@codeaurora.org>
References: <20180814170617.100087-1-dianders@chromium.org>
 <20180814170617.100087-2-dianders@chromium.org> <bf70f01d-41ac-dcdc-b503-5e0eb1e70329@codeaurora.org>
 <CAD=FV=VNCOyyq5+xvSudTmtBgPm4-s7gj7GRCvuL5vSmA6yDVA@mail.gmail.com> <aa2bd1f6-74b4-a63b-d115-88d6e16ed95d@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 14 Aug 2018 16:56:42 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WBw2SKgPq8Atb+SkziUku8p7N4GWemHYZZvoMSE0bK9g@mail.gmail.com>
Message-ID: <CAD=FV=WBw2SKgPq8Atb+SkziUku8p7N4GWemHYZZvoMSE0bK9g@mail.gmail.com>
Subject: Re: [PATCH 1/4] regulator: core: If consumers don't call
 regulator_set_load() assume max
To:     David Collins <collinsd@codeaurora.org>
Cc:     Mark Brown <broonie@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Aug 14, 2018 at 2:59 PM, David Collins <collinsd@codeaurora.org> wrote:
> Hi,
>
> On 08/14/2018 01:03 PM, Doug Anderson wrote:
>> On Tue, Aug 14, 2018 at 11:30 AM, David Collins <collinsd@codeaurora.org> wrote:>>> --- a/drivers/regulator/core.c
>>>> +++ b/drivers/regulator/core.c
>>>> @@ -732,6 +732,7 @@ static int drms_uA_update(struct regulator_dev *rdev)
>>>>       struct regulator *sibling;
>>>>       int current_uA = 0, output_uV, input_uV, err;
>>>>       unsigned int mode;
>>>> +     bool any_unset = false;
>>>>
>>>>       lockdep_assert_held_once(&rdev->mutex);
>>>>
>>>> @@ -751,11 +752,17 @@ static int drms_uA_update(struct regulator_dev *rdev)
>>>>               return -EINVAL;
>>>>
>>>>       /* calc total requested load */
>>>> -     list_for_each_entry(sibling, &rdev->consumer_list, list)
>>>> +     list_for_each_entry(sibling, &rdev->consumer_list, list) {
>>>>               current_uA += sibling->uA_load;
>>>> +             if (!sibling->uA_load_set)
>>>> +                     any_unset = true;
>>>> +     }
>>>>
>>>>       current_uA += rdev->constraints->system_load;
>>>>
>>>> +     if (any_unset)
>>>> +             current_uA = INT_MAX;
>>>> +
>>>
>>> This check will incorrectly result in a constant load request of INT_MAX
>>> for all regulators that have at least one child regulator.  This is the
>>> case because such child regulators are present in rdev->consumer_list and
>>> because regulator_set_load() requests are not propagated up to parent
>>> regulators.  Thus, the regulator structs for child regulators will always
>>> have uA_load==0 and uA_load_set==false.
>>
>> Ah, interesting.
>>
>> ...but doesn't this same bug exist anyway, just in the opposite
>> direction?  Without my patch we'll try to request a 0 mA load in this
>> case which seems just as wrong (or perhaps worse?).  I guess on RPMh
>> regulator you're "saved" because the RPMh hardware itself knows the
>> parent/child relationship and knows to ignore this 0 mA load, but it's
>> still a bug in the overall Linux framework...
>
> I'm not sure what existing bug you are referring to here.  Where is a 0 mA
> load being requested?  Could you list the consumer function calls and the
> behavior on the framework side that you're envisioning?

Imagine you've got a tree like this:

- regulatorParent (1.8 V)
  - regulatorChildA (1.7 V)
  - regulatorChildB (1.2 V)
  - regulatorChildC (1.5 V)

...and this set of calls:

regulator_set_load(regulatorChildA, 1000);
regulator_set_load(regulatorChildB, 2000);
regulator_set_load(regulatorChildC, 3000);

regulator_enable(regulatorChildA);
regulator_enable(regulatorChildB);
regulator_enable(regulatorChildC);


With the existing code in Mark's tree then ChildA / ChildB / ChildC
will presumably have a load high enough to be in high power mode.
However, as you said, loads aren't propagated.  ...so "Parent" will
see no load requested (which translates to a load request of 0 mA).

The "bug" is that when you did the
"regulator_enable(regulatorChildA);" then that will propagate up and
cause a "regulator_enable(regulatorParent)".  In _regulator_enable()
you can see drms_uA_update().  That will cause it to set the mode of
regulatorParent based on a load of 0 mA.  That is the bug.  You may
respond "but REGULATOR_CHANGE_DRMS isn't set for the parent!  See
below and for now imagine that REGULATOR_CHANGE_DRMS _is_ set for the
parent.

With my code in the same situation the parent will end up with a load
of "MAX_INT" mA which I think is the bug you pointed out.  ...while it
would be good to fix this it does seem to be better to set the parent
to a mode based on MAX_INT mA rather than 0 mA?


> The RPMh hardware never sees requests with units of mA (though its
> predecessor RPM SMD did).  Instead, mode requests sent to RPMh are raw
> PMIC MODE_CTL register values.  RPMh then applies max aggregation of these
> register values across masters (APPS, modem, etc).  Also note that the
> RPMh knowledge of parent/child relationships is only utilized in enable
> control and voltage headroom management.  It does not apply to mode control.

Yeah, I know RPMh only sees modes.  I was sorta assuming that perhaps
RPMh would use its parent/child relationship knowledge to say that if
a child is in HPM then the parent should automatically go to HPM.

...but as I dug further I figured out why we're not running into this
bug (at least with the regulator setup I have in my tree).  All of the
"parent" regulators are always configured such that
"REGULATOR_CHANGE_DRMS" is not valid.  Thus we never end up calling
into drms_uA_update() and never update the mode.


So tl;dr: your original comment was that my patch had problems
whenever one regulator is the supply for another regulator if parent
has REGULATOR_CHANGE_DRMS set.  I believe I have shown that even
without my patch we have problems in this exact same case.


>> I have no idea how we ought to propagate regulator_set_load() to
>> parents though.  That seems like a tough thing to try to handle
>> automagically.
>
> I attempted it seven years ago with two revisions of a patch series [1]
> and [2].  The feature wasn't completed though.  Perhaps something along
> the same lines could be reintroduced now that child regulators are handled
> the same way as ordinary consumers within the regulator framework.
>
> Thanks,
> David
>
> [1]: https://lkml.org/lkml/2011/3/28/246
> [2]: https://lkml.org/lkml/2011/3/28/530

Thanks for the links.  My first instinct is just what Mark said there:
you can't really take the child load and map it accurately to a parent
load without loads of per-device complexity and even then you'd
probably get nothing more than an approximation.

IMO about the best we could hope to do would be to map "mode" from
children to parent.  AKA: perhaps you could assume that if a child is
in a higher power mode that perhaps a parent should be too?


-Doug
