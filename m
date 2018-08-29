Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E6EBC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 21:22:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84D2420647
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 21:21:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SYsQSbv4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84D2420647
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lwfinger.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728828AbeH3BUl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 21:20:41 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:39704 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727507AbeH3BUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 21:20:41 -0400
Received: by mail-oi0-f65.google.com with SMTP id c190-v6so11766499oig.6
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 14:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wX0nuwUZtm0jJXab0RxJZIp0hiccVva3PnVH1mmKBOY=;
        b=SYsQSbv46nemQKz3myLf0I1CtlElbpRZKMggRhgeGLf7EUSkzXlX+O6XayfiEjLA8R
         Ylxvpbvse7BgmmjJSITi/u7PAxcIHh5IBl54g1RLb1Ze5hacOjVFd60Vg0BdKQDaqbGm
         +B7KcrucOlyctDXqQpGpb1kBQt3A/4jEwpAeQkQhox3/jXg35iH9ZuSacou4Gl5FIB4r
         j3976GU6MCoCltiizT1DygxipULJ+o3bvASLTpvJqwcLfLuaEp9Xu8pIdODNBasnP/34
         xSv73Ep7LrJ5OocTTf4SmJMCIsJ7/87R8XBk1uvyM+hyRLsUjj0Qm02y/Asq6aik6Lvi
         xidQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wX0nuwUZtm0jJXab0RxJZIp0hiccVva3PnVH1mmKBOY=;
        b=ctnd1N90D5fpm5lKmmPMO1DJ5DidCqk1ZTXaB82arjcnQGA9lF7R+B53bKELFc8OTE
         J8Ow42OlAykpR9q1Zrm4R1UHqZ3ZSN92b/7nw8M+D97ouXO5q++Pqjf7NwrXQh/OqIS1
         RmNX38tijm+4ABnIw2PPTPMymzHOEHrKQZ3sW13nPgMFia95xG+DpeHwdlpG9NAmdoi4
         4HpsjaSHJxkN8DEOH8YEvzhMBoYWrYM3oVhFDoMtqWRZAauupnWlACejtirrvw462rlF
         L97A3FRP0TmjveDA8XC4Y5mMge1HVHAwXVUwWfnd13Hc8/dDoDgJ7CPOpFz3NjdhC5Mg
         VaOA==
X-Gm-Message-State: APzg51CZMAb6J5BfYe4R1KJ27eo9An8+bcsVTi90vgA36DKEKmUt6INh
        WDIxjh//x6lapI68Xy/rZDg=
X-Google-Smtp-Source: ANB0VdbCp+Hu3Q0hvVtflDnVF3QjcVO5MBq7OGrxxpqvZyjLtpbmfBH8fw8RXHI9BOdxCXCSQ9m6eg==
X-Received: by 2002:aca:310b:: with SMTP id x11-v6mr4567022oix.74.1535577716615;
        Wed, 29 Aug 2018 14:21:56 -0700 (PDT)
Received: from [192.168.1.107] (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id c9-v6sm4243959oia.1.2018.08.29.14.21.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Aug 2018 14:21:55 -0700 (PDT)
Subject: Re: [PATCH 01/21] staging:rtl8192u: Rename AdvCoding - Style
To:     Joe Perches <joe@perches.com>,
        John Whitmore <johnfwhitmore@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org
References: <20180829203547.15650-1-johnfwhitmore@gmail.com>
 <20180829203547.15650-2-johnfwhitmore@gmail.com>
 <b621a12258c3f0d0a9fcb61ac454af4822814e67.camel@perches.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <e302edd8-4b00-8c28-8375-2a781877f019@lwfinger.net>
Date:   Wed, 29 Aug 2018 16:21:54 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <b621a12258c3f0d0a9fcb61ac454af4822814e67.camel@perches.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/29/2018 04:14 PM, Joe Perches wrote:
> On Wed, 2018-08-29 at 21:35 +0100, John Whitmore wrote:
>> Rename the bit field element AdvCoding, as it causes a checkpatch issue
>> with CamelCase naming. As the element is not actually used in code it
>> has been renamed to 'not_used_adv_coding'.
>>
>> The single line of code which initialises the bit has been removed,
>> as the  field is unused.
>>
>> This is a purely coding style change which should have no impact
>> on runtime code execution.
> 
> Hi John.
> 
> Other than the somewhat useful code style cleanups, is there
> a point at which you will feel comfortable doing actual code
> changes to this driver?
> 
> Perhaps support for the chipset could be converted to use
> mac80211 and moved into the directory with the other realtek
> drivers in drivers/net/wireless/realtek/rtl8xxxu/...
> 
> Larry?  What do you think?

First of all, if a variable is not used, then it should be removed, not merely 
renamed to satisfy checkpatch.

All the Realtek USB devices should be added to rtl8xxxu, not merely moved into 
that directory. Jes Sorensen created a well-designed driver the is structured to 
permit addition of different initialization routines, etc. That said, the 
conversion will not be easy. In addition, it will require having your hands on a 
real device - a requirement that I cannot meet for the RTL8192U.

Larry

