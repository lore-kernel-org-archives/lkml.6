Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3ECBC6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 08:57:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A8942238E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 08:57:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A8942238E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754676AbeGCI5T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 04:57:19 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:41409 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754382AbeGCI5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 04:57:16 -0400
Received: by mail-ed1-f67.google.com with SMTP id b12-v6so1042885edt.8
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 01:57:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hGo7H0Ok7tsDVr2yfI5djic9yJPnO4fApCONUdCFWlg=;
        b=UcFRUal1k38MWqDdjlGVFDgUItNfZo7DhN25q8nDQhjqX2RmAi+rULNyiPO6PYyui6
         bcyvAXtVc32Pa6mRtG44ix4XBprCoBnlcUya5Q0exKohh56fJejDCti0BhZg/BwFyVTO
         bpWD8Y0JBmHhx3dL06hme6dUSZBuXxcW0y84zwA20gKcxG7Tg0Yd8i9MwMxVDAm5Kdhe
         IWiNNhClSPOc1M6S9Cj59k/BN2cnZb8pOLZbyHlWga1oEoLUgYLbGfe4EomfgVZDjess
         8Iy3fTLR2vX22INQCY5Ee0LCUaCWf6yrU+3lGDzA/EFBnADPdnlNlqHNUUd3CquwKd2V
         HxQA==
X-Gm-Message-State: APt69E0aWHhMwPxypB5x/rQiMMMY1WJnxyg2KzgpRUN0d5wvzokrqbXy
        drOIHt2HrSEsPJmObukAafJ96w==
X-Google-Smtp-Source: AAOMgpc7hY+ELyxn+EiXcrjm4dBhpyOCFMgh/uycyODCGvbBixBZp0P8Bh3AoDyngYLhVYGpC6GV/g==
X-Received: by 2002:a50:a2c7:: with SMTP id 65-v6mr27608576edm.136.1530608235669;
        Tue, 03 Jul 2018 01:57:15 -0700 (PDT)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id e20-v6sm434550eds.20.2018.07.03.01.57.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Jul 2018 01:57:15 -0700 (PDT)
Subject: Re: [RFC PATCH] ata: ahci: Enable DEVSLP by default on x86 modern
 standby platform
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Tejun Heo <tj@kernel.org>
Cc:     rjw@rjwysocki.net, alan.cox@intel.com, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Mario.Limonciello@dell.com
References: <20180702190845.7456-1-srinivas.pandruvada@linux.intel.com>
 <20180702202151.GK533219@devbig577.frc2.facebook.com>
 <5493bfdb-14a9-a55d-f96e-b9c8a29f1d63@redhat.com>
 <ca753f719e123d8e3c2306b8d55f3d4a656cbd2f.camel@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <fefe0ef4-e21f-72cc-18d6-a5a6693c21c6@redhat.com>
Date:   Tue, 3 Jul 2018 10:57:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <ca753f719e123d8e3c2306b8d55f3d4a656cbd2f.camel@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 03-07-18 00:08, Srinivas Pandruvada wrote:
> Hi Hans,
> 
> On Mon, 2018-07-02 at 23:27 +0200, Hans de Goede wrote:

<snip>

>>>> SATA IP block doesn't get turned off till SATA is in DEVSLP mode.
>>>> Here
>>>> user has to either use scsi-host sysfs or tools like powertop to
>>>> set
>>>> the sata-host link_power_management_policy to min_power.
>>>>
>>>> This change sets by default link power management policy to
>>>> min_power
>>>> for some platforms.  To avoid regressions, the following
>>>> conditions
>>>> are used:
>>>> - The kernel config is already set to use med_power_with_dipm or
>>>> deeper
>>>> - System is a modern standby system using ACPI low power idle
>>>> flag
>>>> - The platform is not blacklisted for Suspend to Idle and suspend
>>>> to idle is used instead of S3
>>>> This combination will make sure that systems are fairly recent
>>>> and
>>>> since getting shipped with modern standby standby, the DEVSLP
>>>> function
>>>> is already validated.
>>>>
>>>> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.int
>>>> el.com>
>>>
>>> Seems sane to me.  Hans, what do you think?
>>
>> I think this is going in the right direction, but min_power enables
>> both DEVSLP and HIPM, AFAIK Windows at least in the past did not
>> enable HIPM be default.
> 
> Windows and Linux will need to meet the same criteria to reach SLP_S0
> state. OS is not deciding whether we meet criteria or not, it is
> firmware deciding, and it will look for SATA IP to be in certain
> predefined state, before generating this SLP_S0 signal.
> 
> 
>> Srinivas can you figure out what Windows does wrt HIPM?
> 
> We can see that under Windows the SATA rail voltage is dropped. I don't
> know if there is any other method other than DEVSLP configuration. But
> I will surely check around.

I understand that we need DEVSLP, but AFAIK DEVSLP is entered automatically
after being in slumber for a defined time. The question is how we get into
slumber. Currently with the new med_power_with_dipm policy we always use
DIPM to enter slumber. Your suggested switch to min_power means also
enabling HIPM. What I'm suggesting is that it might better to have
DIPM + DEVSLP rather then DIPM + HIPM + DEVSLP.

So basically the question is does windows use:

a) DIPM + DEVSLP; or
b) DIPM + HIPM + DEVSLP

If b. is the case, then I'm fine with your patch as is, but if Windows
does a. then we should mimic that, which requires a new power-level as
our min_power level is b.

>> We may need a new med_power_with_dipm_and_devslp level if windows
>> does
>> not enable HIPM by default on these systems. In hind sight we really
>> should have separate bools for each, rather then coding this in
>> a single level, ah well.
> Agree. We can certainly do this for even safer implementation.

Ack.

Regards,

Hans

