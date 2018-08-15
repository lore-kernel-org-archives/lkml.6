Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53523C46460
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 01:32:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA1F0216FB
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 01:32:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="W0RkkgE4";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="jrhEv650"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA1F0216FB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726089AbeHOEWJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 00:22:09 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:46008 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbeHOEWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 00:22:09 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id BEE1A62444; Wed, 15 Aug 2018 01:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534296736;
        bh=fG3sqwso1mJugv0Pw8zP30fnqT1SKN407UJmBEzqHSU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=W0RkkgE41DDkYB25ir/Bix6A7DeqxIPTpQhbQq2dOQgcZiLNtysGbz3rNSfKxX4Sy
         PAckpx+c9jZP1IK1K5Ofr3MQcpXauvt3eRSK5FMk+U8hRmZ/srrqhatolQwzyW/NJ6
         Fj7FfzAFfcseOapL9I3SpxoY12RSAjVWIYMy7Ubk=
Received: from [10.46.160.165] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: collinsd@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3DBF562447;
        Wed, 15 Aug 2018 01:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534296735;
        bh=fG3sqwso1mJugv0Pw8zP30fnqT1SKN407UJmBEzqHSU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=jrhEv650XgDP6txEE69jua3v7XFHDKrcGoau6zZNgZOsOYxPhU5yOvtN3QKjxVHpM
         AloJHadYmCvcabXy7NxNr+BM/Fq53YjU3p6tAD1FP7KHDLcsK+k0LwyIbr8pX4y2NM
         IvPVb2CGBDC7paVtLZsqNTfpk3M1v2VSYZU5Xyrk=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3DBF562447
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=collinsd@codeaurora.org
Subject: Re: [PATCH 1/4] regulator: core: If consumers don't call
 regulator_set_load() assume max
To:     Doug Anderson <dianders@chromium.org>
Cc:     Mark Brown <broonie@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <20180814170617.100087-1-dianders@chromium.org>
 <20180814170617.100087-2-dianders@chromium.org>
 <bf70f01d-41ac-dcdc-b503-5e0eb1e70329@codeaurora.org>
 <CAD=FV=VNCOyyq5+xvSudTmtBgPm4-s7gj7GRCvuL5vSmA6yDVA@mail.gmail.com>
 <aa2bd1f6-74b4-a63b-d115-88d6e16ed95d@codeaurora.org>
 <CAD=FV=WBw2SKgPq8Atb+SkziUku8p7N4GWemHYZZvoMSE0bK9g@mail.gmail.com>
From:   David Collins <collinsd@codeaurora.org>
Message-ID: <7455e529-7898-232e-16b9-5ace2ad6be33@codeaurora.org>
Date:   Tue, 14 Aug 2018 18:32:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <CAD=FV=WBw2SKgPq8Atb+SkziUku8p7N4GWemHYZZvoMSE0bK9g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/14/2018 04:56 PM, Doug Anderson wrote:
> On Tue, Aug 14, 2018 at 2:59 PM, David Collins <collinsd@codeaurora.org> wrote:
>> On 08/14/2018 01:03 PM, Doug Anderson wrote:
>>> On Tue, Aug 14, 2018 at 11:30 AM, David Collins <collinsd@codeaurora.org> wrote:>>> --- a/drivers/regulator/core.c
>>>>> +++ b/drivers/regulator/core.c
>>>>> @@ -732,6 +732,7 @@ static int drms_uA_update(struct regulator_dev *rdev)
>>>>>       struct regulator *sibling;
>>>>>       int current_uA = 0, output_uV, input_uV, err;
>>>>>       unsigned int mode;
>>>>> +     bool any_unset = false;
>>>>>
>>>>>       lockdep_assert_held_once(&rdev->mutex);
>>>>>
>>>>> @@ -751,11 +752,17 @@ static int drms_uA_update(struct regulator_dev *rdev)
>>>>>               return -EINVAL;
>>>>>
>>>>>       /* calc total requested load */
>>>>> -     list_for_each_entry(sibling, &rdev->consumer_list, list)
>>>>> +     list_for_each_entry(sibling, &rdev->consumer_list, list) {
>>>>>               current_uA += sibling->uA_load;
>>>>> +             if (!sibling->uA_load_set)
>>>>> +                     any_unset = true;
>>>>> +     }
>>>>>
>>>>>       current_uA += rdev->constraints->system_load;
>>>>>
>>>>> +     if (any_unset)
>>>>> +             current_uA = INT_MAX;
>>>>> +
>>>>
>>>> This check will incorrectly result in a constant load request of INT_MAX
>>>> for all regulators that have at least one child regulator.  This is the
>>>> case because such child regulators are present in rdev->consumer_list and
>>>> because regulator_set_load() requests are not propagated up to parent
>>>> regulators.  Thus, the regulator structs for child regulators will always
>>>> have uA_load==0 and uA_load_set==false.
>>>
>>> Ah, interesting.
>>>
>>> ...but doesn't this same bug exist anyway, just in the opposite
>>> direction?  Without my patch we'll try to request a 0 mA load in this
>>> case which seems just as wrong (or perhaps worse?).  I guess on RPMh
>>> regulator you're "saved" because the RPMh hardware itself knows the
>>> parent/child relationship and knows to ignore this 0 mA load, but it's
>>> still a bug in the overall Linux framework...
>>
>> I'm not sure what existing bug you are referring to here.  Where is a 0 mA
>> load being requested?  Could you list the consumer function calls and the
>> behavior on the framework side that you're envisioning?
> 
> Imagine you've got a tree like this:
> 
> - regulatorParent (1.8 V)
>   - regulatorChildA (1.7 V)
>   - regulatorChildB (1.2 V)
>   - regulatorChildC (1.5 V)
> 
> ...and this set of calls:
> 
> regulator_set_load(regulatorChildA, 1000);
> regulator_set_load(regulatorChildB, 2000);
> regulator_set_load(regulatorChildC, 3000);
> 
> regulator_enable(regulatorChildA);
> regulator_enable(regulatorChildB);
> regulator_enable(regulatorChildC);
> 
> 
> With the existing code in Mark's tree then ChildA / ChildB / ChildC
> will presumably have a load high enough to be in high power mode.
> However, as you said, loads aren't propagated.  ...so "Parent" will
> see no load requested (which translates to a load request of 0 mA).
> 
> The "bug" is that when you did the
> "regulator_enable(regulatorChildA);" then that will propagate up and
> cause a "regulator_enable(regulatorParent)".  In _regulator_enable()
> you can see drms_uA_update().  That will cause it to set the mode of
> regulatorParent based on a load of 0 mA.  That is the bug.  You may
> respond "but REGULATOR_CHANGE_DRMS isn't set for the parent!  See
> below and for now imagine that REGULATOR_CHANGE_DRMS _is_ set for the
> parent.
> 
> With my code in the same situation the parent will end up with a load
> of "MAX_INT" mA which I think is the bug you pointed out.  ...while it
> would be good to fix this it does seem to be better to set the parent
> to a mode based on MAX_INT mA rather than 0 mA?

I agree that the existing behavior resulting from a lack of load current
propagation from child to parent regulators is wrong.  However, I do not
agree that replacing it with something else that results in different
wrong behavior is the way forward.

Adding load current propagation would resolve your 0 mA concern but does
not necessary require making MAX_INT the default for all consumers.


>>> I have no idea how we ought to propagate regulator_set_load() to
>>> parents though.  That seems like a tough thing to try to handle
>>> automagically.
>>
>> I attempted it seven years ago with two revisions of a patch series [1]
>> and [2].  The feature wasn't completed though.  Perhaps something along
>> the same lines could be reintroduced now that child regulators are handled
>> the same way as ordinary consumers within the regulator framework.
>>
>> [1]: https://lkml.org/lkml/2011/3/28/246
>> [2]: https://lkml.org/lkml/2011/3/28/530
> 
> Thanks for the links.  My first instinct is just what Mark said there:
> you can't really take the child load and map it accurately to a parent
> load without loads of per-device complexity and even then you'd
> probably get nothing more than an approximation.
> 
> IMO about the best we could hope to do would be to map "mode" from
> children to parent.  AKA: perhaps you could assume that if a child is
> in a higher power mode that perhaps a parent should be too?

Propagating regulator framework modes (Standby, Idle, Normal, Fast) from
child to parent regulators is definitely not feasible in the general case.
 The meaning of these modes varies between different types of regulators
as do load current thresholds between modes.  I.e. just because a child
regulator changed from Idle to Normal mode does not imply that the parent
regulator needs to operate in Normal mode now.

As an example, consider the QTI PM8998 FTSMPS and NLDO regulators.  The
FTSMPS regulators can supply up to 800 mA in PFM mode (Idle) and 4000 mA
in PWM mode (Fast).  The child NLDO type regulators supplied by the
FTSMPSes can source up to 30 mA in LPM (Idle) and 300 - 1200 mA in HPM
(Normal) (depending upon subtype).  Clearly, an NLDO switching from Idle
to Normal mode because 50 mA was requested does not mean that its parent
needs to switch to Fast mode.

Also note that in this case, the FTSMPS regulators have AUTO mode in
hardware what maps to Linux mode Normal.  In practice, the FTSMPSes will
be configured to be in AUTO mode all the time unless there is a special
case that requires PWM mode (e.g. hardware that is particularly
susceptible to PFM voltage ripple).  They will completely ignore load
current aggregation.

I agree that calculating the load current required from a parent based
upon the current output by a child regulator is challenging.  However,
microamps are physically meaningful and consistent across different types
of regulators.  Therefore, it is technically possible to propagate load
currents from child regulators up to parents.  The same is not true of
regulator framework modes.

Take care,
David

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
