Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A71E6C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 04:17:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 740CB2147C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 04:17:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HmC6jpYx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbfBHERe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 23:17:34 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46835 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726791AbfBHERe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 23:17:34 -0500
Received: by mail-pf1-f194.google.com with SMTP id c73so1046591pfe.13;
        Thu, 07 Feb 2019 20:17:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0Jom0TD8luHFPGgknswKZsgXEV9ssoDNtGm5Ze3s9Yg=;
        b=HmC6jpYxWZXcjiWe20xKiMeVr/A6x87H+wzAUqm6tYJ02P2ofU8ralQ+/FlhtHXDKv
         sgfhcC4C/OV9URecWL3ikiR6B6MmJ8ubDUIZRMtIqgDpbPkMKBkBojoPcV1afJEywIBG
         NH5h/CyO2mFu2SAS5f9RPR+eUwpSKpzWEjTJcPUWYnJru/ajs4gxZz/4Y0Lw+EJLvJcY
         m0Lj10avjiub7XNjSbQkL2KqFZOR2x4Db5jZ/3ZwFwWAfN8yILHQ7jZ7cGl91iP/UaXX
         nM17BvOVZtDnWn7lEE+S4UspjY6mBv5auQrTIKMBRCgQYxftdgGkNueg3zNKD68aR1V5
         J46Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0Jom0TD8luHFPGgknswKZsgXEV9ssoDNtGm5Ze3s9Yg=;
        b=QResdlrdU/AMoLfkJuX+Broc2ICUO1d2A+tRToR0EdTO+VIZygwV9Z63ZL82nZwrGn
         PrV8Okshb7iuFj9Np+7T978vggGTAg1ne819K/yCc61OV9cWSEgLE2qNxM0rGm5gvpP3
         4JWQnflmFy3q6w+/t9v2emRAvZxGN/7BlgzUfeM5/Ggn4nX19bS+p1RtzZPztUnVPD+U
         exqx+Le/J1t8U7wKhF937XpTzZTRQTjR9I/Z6HPvGFUeBpFf/g6Ta8/X1TAcFiStlU+z
         u5x/Q6AQM7kkQJQwT+mqHvPG/s65esu0D6wLILphkK0DeofhmdcAcKJ4OWg9qtkJ35+A
         pQWw==
X-Gm-Message-State: AHQUAuZsKXmr1fW/R2KVvin1KJTN3eF5Dj8r0xcrUbVa7tmxPZDdYRVM
        ihZ3CtFbNNoeaoNDMC9A5pVOn+CH
X-Google-Smtp-Source: AHgI3IaZOJ0uwRgRg79GIx3+5X3o0lOhzk5GW3QSuMctvm6jHApb6YabzVI2QUv8wU1fwyL8nvF5+g==
X-Received: by 2002:aa7:800c:: with SMTP id j12mr2156372pfi.183.1549599453231;
        Thu, 07 Feb 2019 20:17:33 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d13sm868355pfd.58.2019.02.07.20.17.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Feb 2019 20:17:32 -0800 (PST)
Subject: Re: [RFC PATCH 1/4] watchdog: hpwdt: Don't disable watchdog on NMI
To:     Jerry.Hoemann@hpe.com, Ivan Mironov <mironov.ivan@gmail.com>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>
References: <20190114023617.10656-1-mironov.ivan@gmail.com>
 <20190114023617.10656-2-mironov.ivan@gmail.com>
 <20190116022731.GD18342@anatevka>
 <84950aa0d194f28389f3bb209154ddc26e96c6de.camel@gmail.com>
 <20190208012658.GF28168@anatevka>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <4f7de732-31cf-a220-f1eb-3d8182cf9c72@roeck-us.net>
Date:   Thu, 7 Feb 2019 20:17:29 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190208012658.GF28168@anatevka>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/7/19 5:26 PM, Jerry Hoemann wrote:
> On Sat, Feb 02, 2019 at 09:55:29AM +0500, Ivan Mironov wrote:
>> On Tue, 2019-01-15 at 19:27 -0700, Jerry Hoemann wrote:
>>> On Mon, Jan 14, 2019 at 07:36:14AM +0500, Ivan Mironov wrote:
>>
>> Somehow I missed the whole pretimout thing when reading about the
>> watchdog API. Thanks for clarification, now code makes much more sense
>> =).
>>
>> Still, I do not really understand the point of enabling of kdump
>> support in hpwdt driver by default while kdump is not enabled by
>> default.
> 
> Kdump is enabled by default by our Distro partners.
> 
> HPE works with distro partners to deliver a validated system which we support.
> 
> The ability to generate crash dumps is one of the means we use to
> support our customers.  Even if kdump isn't configured, panic will
> at least print stack trace to indicate system activity.
> 
> 
>>
>> Also, existing code may call hpwdt_stop() (and thus break watchdog)
>> even if pretimout is disabled.
>>
>> Also, "panic=N" option is not providing a way to *not* panic on NMI
>> unrelated with iLO. This could be circumvented by blacklisting the
>> hpwdt module entirely, but normal watchdog functionality would be lost
>> then.
> 
> panic=N provides for reset upon receipt of NMI if user wants timeout
> to reset system but not a crash dump.
> 
> The panic is for error containment.  On the legacy systems within
> the context of hpwdt_pretimeout we cannot determine if the error
> is recoverable or not.  So, we have little choice but to panic.
> 
> 
>>
>> It is possible to rebuild kernel without HPWDT_NMI_DECODING (which is
>> enabled in Fedora, for example). But it is nearly impossible to come to
>> this solution without examining the source code, because description of
>> this option does not mention that it is really about pretimout support
>> and panics and not about something else...
> 
> The name is not the best given its current use, but I'm not sure a
> name change would be allowed.
> 

I would be open to accepting an improved help text of this configuration
option. I am not going to entertain (or accept) a name change.
That would open up a can of worms, with everyone in the world requesting
name changes. That would be pretty pointless and make the kernel all but
unmanageable.

Guenter

> However, I will send a patch to update the documentation in Kconfig.
> 
> 

