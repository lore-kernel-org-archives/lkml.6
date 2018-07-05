Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA7EDC6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 16:13:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 811ED23EF0
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 16:13:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hT1EBOPM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 811ED23EF0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753780AbeGEQNZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 12:13:25 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39421 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753325AbeGEQNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 12:13:24 -0400
Received: by mail-wr1-f68.google.com with SMTP id h10-v6so1486156wre.6
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 09:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xZJ5oIEIjDm5AOIg1/P9Le2JNxm0goFPnAw2x+MnssE=;
        b=hT1EBOPMg2cpuTTvqtSeptbBM/l/SydXNIQshZdWB4uubUL6kjBPeF8Kn7UFgojWwV
         vThH1/IfpD35moCM6q1eqwi3EgRBs20g1pEOb5Wems/T+V7p9YBzo/cgHh3wPi5HyGGA
         fsSMyEvEoUJ0MxKtBEVdgBdCojeFk5k7UahaE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xZJ5oIEIjDm5AOIg1/P9Le2JNxm0goFPnAw2x+MnssE=;
        b=WtfjU47CnMIoOsTvGXY5tV+ancBWitU90myBHQKcCrL5A61PfOc5fBqSICdlf6rXbe
         iZY+MjZjq5Htk/XIUht7lSvfLONQ0JfF8u0rpGPy8h+F/eG6DEl1gCXi6qvDLcsb/vrM
         Mtq3vCy9nSho1OMMw3W4711JW+PlrUFajjatgW08RBibr40mvyXGifwBpwVb2dWTLysw
         1W+PJIePERkvn8duusxqNuuc/UFhN8L2sQb+ZKFzcLrrOb/ZxLLzyEeR6qMlAiZc+xLL
         +F69UZ6yGJJshikQUxDBjnoAwSz3RoD20KTmcNzqtY1maEtdhgIYIwg8bcNCrHzJaKRz
         TfJQ==
X-Gm-Message-State: APt69E0Pyaj1iiRuFDgfzBe990yMkpD2xrmEyogaWeFa13RUv0SeX9ok
        qP/JFU4JfJTif2O/GKqfk54SDQ==
X-Google-Smtp-Source: AAOMgpecAAcgkJK8/OJmedu2N0TspmRgzOPRTf1LPnc1boVqI5FKH8owS/5FsPXthRIW6GRwL4wRvA==
X-Received: by 2002:adf:a6e2:: with SMTP id t89-v6mr5472514wrc.231.1530807203124;
        Thu, 05 Jul 2018 09:13:23 -0700 (PDT)
Received: from [192.168.0.18] (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.googlemail.com with ESMTPSA id b1-v6sm9031678wma.23.2018.07.05.09.13.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Jul 2018 09:13:22 -0700 (PDT)
Subject: Re: [PATCH] regmap: slimbus: add support to raw read/writes
To:     Mark Brown <broonie@kernel.org>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
References: <20180705113700.32465-1-srinivas.kandagatla@linaro.org>
 <20180705150857.GA6227@sirena.org.uk>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <3c958e52-d720-c008-913b-4ff29ea35c00@linaro.org>
Date:   Thu, 5 Jul 2018 17:13:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180705150857.GA6227@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 05/07/18 16:08, Mark Brown wrote:
> On Thu, Jul 05, 2018 at 12:37:00PM +0100, Srinivas Kandagatla wrote:
> 
>> SLIMbus supports upto 16 bytes in value management messages,
>> so add support to raw read/writes upto 16 bytes.
> That's not what raw access is.  It's unmediated access to existing
> registers, not some other thing with completely different register sizes
> which you can't see through the register map.  The intended use is for
> things like fast firmware downloads.  If it's not part of the register
> map we shouldn't be going through regmap to get to it.

Thanks for explaining this in detail.

I think I got it wrong by looking at _regmap_bus_read() implementation 
which calls _regmap_raw_read(), this made me think that read/writes 
callbacks imply raw read/writes. Looks like that is not the case.

These bus read/write callbacks are just simple multiple register 
read/writes.

All am trying to do is support paged registers, which seems to be only 
possible via read/write support at bus level.

Does reg_read/reg_write become redundant if we implement read/write 
callbacks at bus regmap level?

> 
>> Also useful for paged register access on SLIMbus interfaced codecs.
> That needs a bunch more explanation...  in what way does raw access
> relate to paged register maps?
Yes, this is nothing to do with raw access! I got it wrong!
WCD9335 codec has paged registers which is what I need!

I will fix the patch and commit message removing the raw related parts 
and resend.

Does that sound okay?

thanks,
srini
