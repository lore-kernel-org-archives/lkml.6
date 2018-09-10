Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96D27C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 19:08:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 492232086E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 19:08:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lKELhsg9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 492232086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728673AbeIKADb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 20:03:31 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:39596 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726603AbeIKADb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 20:03:31 -0400
Received: by mail-wm0-f65.google.com with SMTP id q8-v6so22629795wmq.4;
        Mon, 10 Sep 2018 12:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gpwkHDBCZR5NQsQz6unfc1eonL+fcFjdtnucrFbFUXY=;
        b=lKELhsg9fnWqok4kHNygsQIK6CjYARREd73KHPYoCzlIwVSDFvraUBAF8qwYj7zmdG
         8tKzvr92ZjtA9qptyMuFr5L9HgC3FomGs6osvVW2PNDZlVXYDiO5PC5XSBoRHI4DcXv8
         Zu+vinSRtw2vAYDGyF3mEkiDsiNaJzyLCoVw2iPB41RsrIdV8NaZrK+lykWrm9+i10l6
         46nib4GIa5v6epeiPqiUzUQ0XUKF8FgrYbAdW+QyYH4726qP1097eNB/7T4dK+3xj6X+
         TKa5ZYnAraUihJLB9WbGnWs3W9XuYXWMobixhf2zgJAW8zIcbVyjSfy3FZBubKQkBBPd
         ZJQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gpwkHDBCZR5NQsQz6unfc1eonL+fcFjdtnucrFbFUXY=;
        b=iZe69Ge/69o/c/fVioNN2lWlu5nHbFYS47E5WDTKRZAjZvp0lNfyJmS/XJiFchn5uG
         aEvw98TJcWMr49v0X2nEHXnHygAbcO99m8USX68SPQ0PsY7us+B3gASdwzSlt6FvW8BY
         hhPOwzFaO7AquPNGBsdVe5Ux5PhbH1ogZWQL8I0EVqpneeZc1t4vlc+HFpNDXEcYCm7g
         8DoMCt7N2tQ7N93ZZi0D0dl5vXK9+IH0Od/iHeiwctZwIESroAdvHIk85PBFFbTzitgR
         OZGDoHMLmTHFprS7KYXLaCoa5+kVcRwJBoL+Syd+Hi4bv/eJwgum/m0sjcWJ86ra8mMD
         c0kg==
X-Gm-Message-State: APzg51AeyFlWwgz4B57vJmRwJTniC6R4KHeGYZC4OzSIfQuQXSz8J4Gf
        cleOyPWpleFXheR4Kb2BIMWvtp5x
X-Google-Smtp-Source: ANB0VdawNrYgW1H0IIddbCDDMDDrueU/2dUQh4nvBPJnJUfb3fYFpbc4Q6mE54hnK8Sn4eE/FXnBOA==
X-Received: by 2002:a1c:b54b:: with SMTP id e72-v6mr1593272wmf.117.1536606478531;
        Mon, 10 Sep 2018 12:07:58 -0700 (PDT)
Received: from [192.168.1.18] (dlx100.neoplus.adsl.tpnet.pl. [83.24.53.100])
        by smtp.gmail.com with ESMTPSA id x16-v6sm11672485wro.84.2018.09.10.12.07.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Sep 2018 12:07:57 -0700 (PDT)
Subject: Re: [PATCH v6 1/2] dt-bindings: leds: Add bindings for lm3697 driver
To:     Dan Murphy <dmurphy@ti.com>, Pavel Machek <pavel@ucw.cz>
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
References: <20180906135005.6718-1-dmurphy@ti.com>
 <20180906211617.GB16899@amd> <b8ac9d52-f16d-5fc4-0e9a-9246b9f984c5@ti.com>
 <20180907133228.GA16297@amd> <70f7506c-6a3d-3830-59a4-a246dc6163f7@ti.com>
 <226b8770-7041-39a4-5a06-6002a7c1225f@gmail.com>
 <20a814ce-a4c5-0649-6677-6b85a5fd2321@ti.com>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <59561e0f-e3b9-7898-a300-90b198ad14e6@gmail.com>
Date:   Mon, 10 Sep 2018 21:07:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20a814ce-a4c5-0649-6677-6b85a5fd2321@ti.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dan, Pavel,

On 09/10/2018 04:37 PM, Dan Murphy wrote:
> Jacek
> 
> On 09/08/2018 02:53 PM, Jacek Anaszewski wrote:
>> Dan,
>>
>> On 09/07/2018 03:52 PM, Dan Murphy wrote:
>> [...]
>>>>
>>>>> And I think Jacek pointed out that the bindings references in this bindings
>>>>> don't even exist.
>>>>>
>>>>> I am thinking we need to deprecate this MFD driver and consolidate these drivers
>>>>> in the LED directory as we indicated before.  I did not find any ti-lmu support
>>>>> code.
>>>>>
>>>>> ti-lmu common core code and then the LED children appending the feature differentiation.
>>>>
>>>>> Need some maintainer weigh in here.
>>>>
>>>> Hehe. I'm maintnainer. Fun.
>>>
>>> I know.  I want to see if there was any other opinion.  Especially for the LED driver.
>>>
>> [...]
>>
>> I have a question - is this lm3697 LED controller a cell of some MFD
>> device? Or is it a self-contained chip?
>>
> 
> This is a self contained chip.  And the LM3697 only function is a LED driver.
> It does not have any other special functions like the LM363X drivers for GPIO and Regulator support.

This is an argument for merging it as a standalone LED class driver
then. It is even more justifiable, taking into account uncertainties
related to the proper way of adding the support for it to the existing
MFD driver, whereas the code reuse would be the only advantage of having
thus support in MFD subsystem.

-- 
Best regards,
Jacek Anaszewski
