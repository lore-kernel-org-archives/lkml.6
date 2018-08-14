Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19F75C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 21:59:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9C3A21580
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 21:59:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="G4YnBr4T";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="bs9O4xPs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9C3A21580
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729795AbeHOAsQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 20:48:16 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:48112 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727776AbeHOAsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 20:48:15 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 3CA5C61D7A; Tue, 14 Aug 2018 21:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534283943;
        bh=gjs0nW1WoTXMtVpk2UKwBszvAyZ/0otVd2rSxCc+4W8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=G4YnBr4TtfL2VltsUqf4h7E9dvkHAzbNoV9mmojtG5j/MrggrpEoADp9pkYSDDAwM
         OAPel4LcLHRpzQUPNGMu2MndUWin6sD93rgqz5twXCiqD+n+Hs9feuMBzdGx4LPIKh
         12iYu51uWOfNFaEW/5RxHmm/LGpnjfmUkd/jNEcE=
Received: from [10.46.160.165] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: collinsd@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E406B61D66;
        Tue, 14 Aug 2018 21:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534283942;
        bh=gjs0nW1WoTXMtVpk2UKwBszvAyZ/0otVd2rSxCc+4W8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=bs9O4xPs6pU/O5thMoSZzTDqAnL+R6IRXda+2nglXeGS62cS7Ci3LP5W3LGivH/vR
         r4HD81I9/PS9QAVPFf0nbhhI4UURYU3DZ4GtDeGRx3oHKJmc8IcIdzwiAmlqAD9RhM
         lH61l1NmTgP0sZV3fxzKkJzSK727QtAodiakVIII=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E406B61D66
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
From:   David Collins <collinsd@codeaurora.org>
Message-ID: <aa2bd1f6-74b4-a63b-d115-88d6e16ed95d@codeaurora.org>
Date:   Tue, 14 Aug 2018 14:59:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <CAD=FV=VNCOyyq5+xvSudTmtBgPm4-s7gj7GRCvuL5vSmA6yDVA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 08/14/2018 01:03 PM, Doug Anderson wrote:
> On Tue, Aug 14, 2018 at 11:30 AM, David Collins <collinsd@codeaurora.org> wrote:>>> --- a/drivers/regulator/core.c
>>> +++ b/drivers/regulator/core.c
>>> @@ -732,6 +732,7 @@ static int drms_uA_update(struct regulator_dev *rdev)
>>>       struct regulator *sibling;
>>>       int current_uA = 0, output_uV, input_uV, err;
>>>       unsigned int mode;
>>> +     bool any_unset = false;
>>>
>>>       lockdep_assert_held_once(&rdev->mutex);
>>>
>>> @@ -751,11 +752,17 @@ static int drms_uA_update(struct regulator_dev *rdev)
>>>               return -EINVAL;
>>>
>>>       /* calc total requested load */
>>> -     list_for_each_entry(sibling, &rdev->consumer_list, list)
>>> +     list_for_each_entry(sibling, &rdev->consumer_list, list) {
>>>               current_uA += sibling->uA_load;
>>> +             if (!sibling->uA_load_set)
>>> +                     any_unset = true;
>>> +     }
>>>
>>>       current_uA += rdev->constraints->system_load;
>>>
>>> +     if (any_unset)
>>> +             current_uA = INT_MAX;
>>> +
>>
>> This check will incorrectly result in a constant load request of INT_MAX
>> for all regulators that have at least one child regulator.  This is the
>> case because such child regulators are present in rdev->consumer_list and
>> because regulator_set_load() requests are not propagated up to parent
>> regulators.  Thus, the regulator structs for child regulators will always
>> have uA_load==0 and uA_load_set==false.
> 
> Ah, interesting.
> 
> ...but doesn't this same bug exist anyway, just in the opposite
> direction?  Without my patch we'll try to request a 0 mA load in this
> case which seems just as wrong (or perhaps worse?).  I guess on RPMh
> regulator you're "saved" because the RPMh hardware itself knows the
> parent/child relationship and knows to ignore this 0 mA load, but it's
> still a bug in the overall Linux framework...

I'm not sure what existing bug you are referring to here.  Where is a 0 mA
load being requested?  Could you list the consumer function calls and the
behavior on the framework side that you're envisioning?

The RPMh hardware never sees requests with units of mA (though its
predecessor RPM SMD did).  Instead, mode requests sent to RPMh are raw
PMIC MODE_CTL register values.  RPMh then applies max aggregation of these
register values across masters (APPS, modem, etc).  Also note that the
RPMh knowledge of parent/child relationships is only utilized in enable
control and voltage headroom management.  It does not apply to mode control.


> I have no idea how we ought to propagate regulator_set_load() to
> parents though.  That seems like a tough thing to try to handle
> automagically.

I attempted it seven years ago with two revisions of a patch series [1]
and [2].  The feature wasn't completed though.  Perhaps something along
the same lines could be reintroduced now that child regulators are handled
the same way as ordinary consumers within the regulator framework.

Thanks,
David

[1]: https://lkml.org/lkml/2011/3/28/246
[2]: https://lkml.org/lkml/2011/3/28/530

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
