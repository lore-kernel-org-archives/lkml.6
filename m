Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B560CC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 13:37:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7010C20846
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 13:37:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7010C20846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932368AbeFTNhv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 09:37:51 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:40391 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754162AbeFTNht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 09:37:49 -0400
Received: by mail-wm0-f68.google.com with SMTP id n5-v6so6961917wmc.5
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 06:37:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zdB29D++jwbYIlk4F6LVN+rbff9R/J2ATQ36MYRS4UU=;
        b=RFWrC39MdoTSli4TWC2UheGuX5CTDGahaepGBJTV/WIZjP6TIVqil7slh4O3kKGEvT
         apwXrBAbVySllQPlBTPwJHl0SLqNWGEss6o+hdk4ue16RuyaR1obAVYjHCzHysG7Qp28
         Oh5XXDG1mE/RjQODeq0XERzgCfNLoMn9COKz9rRlGSjoi2Op14v9m+Ec8uP5C11C8YCv
         R9tMyxPWKjGeNPyui9HScfxnXTfLKnQzCTM2Ia+a+LaLuAD0MTsISlvcEL+i4dqhFkvJ
         wzAxcwzlmj9xlcx5k1kiiap3caJoCzUpN0DRnsxvUcuubdd0KQ99SjKhDMOut9mEP3N2
         s/dw==
X-Gm-Message-State: APt69E1mjzHbJanlaCIOVbAQ4ScKrtCFpzr0biKrDZdwEO0k9waHSJyJ
        Gq4PpdiHvb6msHGrrcMZA2x8qrjnto4=
X-Google-Smtp-Source: ADUXVKJ5JufU3X3RY02NPujVcCSvHh9pHAXvqqhA+XFXjeCcXJQaKqvJpWz7bs+xY3gYLZTZRphsDA==
X-Received: by 2002:a50:870f:: with SMTP id i15-v6mr18474902edb.218.1529501868292;
        Wed, 20 Jun 2018 06:37:48 -0700 (PDT)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id c20-v6sm2096324ede.3.2018.06.20.06.37.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jun 2018 06:37:47 -0700 (PDT)
Subject: Re: [PATCH] printk: Make CONSOLE_LOGLEVEL_QUIET configurable
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
References: <20180619115726.3098-1-hdegoede@redhat.com>
 <20180620110335.sjzmtra2z3chvon2@pathway.suse.cz>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <f60d844d-9d3b-3154-4eec-982432c8e502@redhat.com>
Date:   Wed, 20 Jun 2018 15:37:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180620110335.sjzmtra2z3chvon2@pathway.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 20-06-18 13:03, Petr Mladek wrote:
> On Tue 2018-06-19 13:57:26, Hans de Goede wrote:
>> The goal of passing the "quiet" option to the kernel is for the kernel
>> to be quiet unless something really is wrong.
>>
>> Sofar passing quiet has been (mostly) equivalent to passing
>> loglevel=4 on the kernel commandline. Which means to show any messages
>> with a level of KERN_ERR or higher severity on the console.
>>
>> In practice this often does not result in a quiet boot though, since
>> there are many false-positive or otherwise harmless error messages printed,
>> defeating the purpose of the quiet option. Esp. the ACPICA code is really
>> bad wrt this, but there are plenty of others too.
> 
> I see your pain. But this sounds like a workaround for a broken code.
> This change might just encourage people to create even more mess.

I've been submitting patches upstream to fix false-positive KERN_ERR
messages for more then a year now and getting a KERN_ERR free kernel
(on more then 1 specific model hw) is just undoable. Every release some
new nonsense error comes up, like e.g.:

https://bugzilla.redhat.com/show_bug.cgi?id=1568276

Besides this random KERN_ERR cases (of which there are plenty
by themselves) I've also had long discussions with the ACPICA upstream
maintainers, but they refuse to change this instead insisting that:

a) Vendors should fix there DSDTs to be perfect; and
b) end-users should then update their BIOS to fix this

Neither of which is a realistic expectation in anyway.

IOW I've tried to fix this the right way and I will keep posting patches
to keep "dmesg --level=err" output to a minimum, but it simply is not
feasible to get the desired quiet boot with its current configuration
of quiet mapping to loglevel=4.

>> This commit makes CONSOLE_LOGLEVEL_QUIET configurable.
>>
>> This for example will allow distros which want quiet to really mean quiet
>> to set CONSOLE_LOGLEVEL_QUIET so that only messages with a higher severity
>> then KERN_ERR (CRIT, ALERT, EMERG) get printed, avoiding an endless game
>> of whack-a-mole silencing harmless error messages.
> 
> I find it a bit confusing that "quiet" would mean something different
> on different systems.

The kernel is so configurable already that I don't think this really is much
of an issue, quiet will still mean quiet on all systems, some might just
be a tad more quiet (or actually be quiet) compared to others.

The same argument could be made for the default loglevel being configurable,
yet it is configurable already.

> Why did not you use loglevel=<whatever_you_need> instead of "quiet"?

We would still need to pass quiet, to also silence e.g. the messages
from the EDD code, see arch/x86/boot/edd.c around line 147 and further,
so then we would need to pass:

quiet loglevel=3

And we would need to pass it in that order! which is ugly also this
complicates giving people instructions to turn it off to debug
system not-booting problems.

> Alternative solution would be to add "silent" or so to calm down
> everything. But I am afraid that any change in this area would
> just create a mess similar to grep -s and -q options.

A better alternative would be to make quiet actually does what the
name suggests and simply unconditionally change
CONSOLE_LOGLEVEL_QUIET from 4 to 3. I went with making this configurable
because I expect that to be a controversial change.

A third, sucky, alternative would be for Fedora to permanently
carry a downstream patch changing the CONSOLE_LOGLEVEL_QUIET from 4
to 3 in printk.h. That would still lead to the confusion about quiet
not meaning the same everywhere (although I would expect e.g. Ubuntu
to follow suit) combined with extra downstream patches which are never
good.

Regards,

Hans

