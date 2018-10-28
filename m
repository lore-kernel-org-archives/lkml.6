Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF875ECDE44
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 10:48:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B73D20843
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 10:48:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B73D20843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbeJ1TdC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Oct 2018 15:33:02 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:37272 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbeJ1TdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Oct 2018 15:33:02 -0400
Received: by mail-ed1-f68.google.com with SMTP id u12-v6so1964533eds.4
        for <linux-kernel@vger.kernel.org>; Sun, 28 Oct 2018 03:48:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6alRfDBiFL26fmhy4Ia7xj1Yf4rCbZ6HYk49z/5pmY8=;
        b=anudnTjCYg4eWmsJLZWdpdsRZK/RqmZ7YEDseyyp/uLS1xLTXyi/ZDiYH3TQ09rab3
         VnxsNYEwCGrauF1CgrHHsAK3NY3jicHUjaDK+N3wdA4I5+bapNep2jSZD+jms/HsbJp+
         GmkDgc51EZ/BRJzmlNhRch6pcoan21J9iuudbGdM+GKhkKIfNT/e/mVKJf7GlasAAHtf
         DzN43AwyhSBGbGI8MYL6wopLdWv1Jg3tfDd+dEfaUdQzGWVg9lue7QUU1JQIO7f5KAsp
         lqCMBTQ+qsl08aqfJdWo18vuh7etMKvboyUensaRg6XWWuagLShMR4x/cjJxUrBohiH2
         ymJg==
X-Gm-Message-State: AGRZ1gL1h1HXFALVARjZE2bjn4LuNutN62lfl5FQrRNpc9CiOSTe4cPt
        EuR8SFEickv3cVwRq0SFIry4/g==
X-Google-Smtp-Source: AJdET5fhZzMsUTEIi8eZ0KEmXuXXiEuiCLR0tMPPBTS4gexwiaEE6w5m00DoFHlt8b6vbhgEUvm01g==
X-Received: by 2002:a50:a5d8:: with SMTP id b24-v6mr3745821edc.137.1540723724207;
        Sun, 28 Oct 2018 03:48:44 -0700 (PDT)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id j22-v6sm5448357edh.47.2018.10.28.03.48.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Oct 2018 03:48:43 -0700 (PDT)
Subject: Re: [PATCH v3] libata: Apply NOLPM quirk for SAMSUNG
 MZ7TD256HAFV-000L9
To:     Diego Viola <diego.viola@gmail.com>, axboe@kernel.dk
Cc:     tj@kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20181026134516.1234-1-diego.viola@gmail.com>
 <3d9dd60b-7bfe-bc1c-b971-0935a84dcf45@kernel.dk>
 <CA+ToGPHR7s4kTKdSh3rpjvxPQN+Y+Qfv=vT2icJ1Gh55X3-mTg@mail.gmail.com>
 <CA+ToGPFMgT2co9c+QWN=7etS9w0OaRfUz69hduOn5rRvMwdsbg@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <539a21b1-7d09-4f30-0421-d083d1c48ee4@redhat.com>
Date:   Sun, 28 Oct 2018 11:48:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CA+ToGPFMgT2co9c+QWN=7etS9w0OaRfUz69hduOn5rRvMwdsbg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 28-10-18 05:13, Diego Viola wrote:
> On Fri, Oct 26, 2018 at 5:36 PM Diego Viola <diego.viola@gmail.com> wrote:
>>
>> On Fri, Oct 26, 2018 at 11:21 AM Jens Axboe <axboe@kernel.dk> wrote:
>>>
>>> On 10/26/18 7:45 AM, Diego Viola wrote:
>>>> med_power_with_dipm causes my T450 to freeze with a SAMSUNG
>>>> MZ7TD256HAFV-000L9 SSD (firmware DXT02L5Q).
>>>>
>>>> Switching the LPM to max_performance fixes this issue.
>>>
>>> Applied, thanks.
>>>
>>> --
>>> Jens Axboe
>>>
>>
>> Jens, Hans,
>>
>> Thank you.
>>
>> Diego
> 
> Hi Hans and Jens,
> 
> I just wanted to give you guys an update about this problem.
> 
> I've managed to update my SSD firmware to the latest version[1].
> 
> For running the update, I've had to install Windows 10, ran the
> firmware update, remove Windows and reinstall Arch Linux.
> 
> The latest version of the firmware is DXT04L5Q, and it looks like
> there hasn't been a new update since 2015.
> 
> I'll be running with med_power_with_dipm and hope this firmware update
> fixes the problem, if it doesn't and I get another freeze, I'll send
> another patch blacklisting the drive completely. Is that OK?

Yes, if it still happens with the latest firmware then blacklisting
it completely is the right thing to do.

Unfortunately for reasons which I do not understand OEM SSDs often use
different (customized?) firmware compared to the model on which they
are based and often see less updates and seem to have more bugs :|

Regards,

Hans
