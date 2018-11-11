Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B135FC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 11:57:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A6DE20871
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 11:57:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A6DE20871
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727767AbeKKVpi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 16:45:38 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:40737 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727492AbeKKVph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 16:45:37 -0500
Received: by mail-ed1-f65.google.com with SMTP id d3so4556116edx.7
        for <linux-kernel@vger.kernel.org>; Sun, 11 Nov 2018 03:57:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6tF8O2vAgtqwLVdss95ldjlv+6Xr8yAgnMoHEZdpBW4=;
        b=ni2cyW/JCkx+8KKLUBUPhHkaSHRMrUqsi5ztm2T45gB5lXx9Z7zbDBluig4kmI9gWe
         aV3VyYoXMtokOJ+5bRef+C0x+XpYt6H5hvBrYtYia4xkPOEDP4208x3baPzELH6lFPlG
         sv94GaFo2WlZV4Mw9vXLUuTwSWLWu/Py48hmiS+AvPvvia95211FlOoAMGjNTXLBmIDX
         Pzg+AQwTBcT6MVhtAwdRd7gnbASLISBJjdpgikt6z5RIj9RmZBXFl+tbRDgetfNOZquU
         Ca2ZgBNy8NunsdU7ilcnxpsIicoBPoe4CLXV1TJFf5jqoKs9S/0+JQop3jtB7mf6b5Pe
         cz8A==
X-Gm-Message-State: AGRZ1gK/3LQr3SVYZxQcf1wWWut9IatTiH0aRihDR/RIX1OFOwK315vD
        NzdvSsHXAqsqNa6bPKOn3+LirFZyCKE=
X-Google-Smtp-Source: AJdET5cFbmE+8guyBNEcU8h0KP+EW2pC1eA4JDcH6WAliep8Uc9GWiNgJkf3VfShd3rEj0B8vAQgOg==
X-Received: by 2002:aa7:cfc3:: with SMTP id r3-v6mr9119467edy.208.1541937434135;
        Sun, 11 Nov 2018 03:57:14 -0800 (PST)
Received: from dhcp-45-79.space.revspace.nl ([2a01:4f8:1c0c:6c86:74cc:2527:1001:2c5e])
        by smtp.gmail.com with ESMTPSA id w6-v6sm3387207eds.54.2018.11.11.03.57.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Nov 2018 03:57:13 -0800 (PST)
Subject: Re: [PATCH] ACPI / battery: Fix reporting "Not charging" when
 capacity is 100%
To:     Daniel Drake <drake@endlessm.com>, pavel@ucw.cz
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        sebastian.reichel@collabora.co.uk,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        linux@endlessm.com,
        =?UTF-8?Q?Jo=c3=a3o_Paulo_Rechi_Vita?= <jprvita@endlessm.com>,
        =?UTF-8?Q?Jo=c3=a3o_Paulo_Rechi_Vita?= <jprvita@gmail.com>
References: <20181103065732.12134-1-jprvita@endlessm.com>
 <20181105091917.GD4439@amd>
 <CA+A7VXXUB2CZUyPtaMya7in7ntO_unbqVnaZyfCBT_BXtAxeQQ@mail.gmail.com>
 <CAD8Lp46Go79C_xOkzM-hq4umET1M62Ofqw48swn1JNocifET3Q@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <c883a2be-e772-2e18-f074-d2ad5f27f42b@redhat.com>
Date:   Sun, 11 Nov 2018 12:57:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <CAD8Lp46Go79C_xOkzM-hq4umET1M62Ofqw48swn1JNocifET3Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/7/18 5:53 AM, Daniel Drake wrote:
> On Mon, Nov 5, 2018 at 1:19 AM Pavel Machek <pavel@ucw.cz> wrote:
>> Plus, I don't think "100% charge" is right test for "battery full". At
>> least on thinkpads, there's configuration option, and it is common
>> _not_ to charge batterry above 95% or so (to increase its lifetime).
> 
> Hans also touched on this area in his response:
> 
>> As for this kernel-side fix I do not believe that fixing thus in
>> the kernel is the right thing to do. We try to stay away from
>> heuristics using full_charge_capacity in the kernel since that
>> is not really reliable / deterministic.
> 
> I'm not fully convinced by this argument though.
> 
> The ACPI spec is not very clear on what conditions you should apply to
> decide when the battery is full. Instead, ACPI seems to provide a
> pretty decent amount of data, and the decision about whether to
> interpret that as "battery full" is left for consumers.

Right, but in this case the "discharging" status bit is explicitly
set, to me it feels wrong to report "full", when the firmware
is reporting "discharging" IMHO, at best we are "not charging"
(on AC, below the threshold where a new charge cycle starts) and
that is what we are currently reporting.

Anu heurstics to decide that "not charging" is close enough to full
to report it as full to the user belongs in userspace IMHO.

Anyways this ultimately is Rafael's call. If Rafael is ok with this
patch then I would like to see Pavel's comment addressed and otherwise
it is fine with me.

Note that we will still often get the case where a laptop is charged,
reports full, is unplugged for 5 minutes and then replugged and then
reports a capacity of 97% combined with "not charging", so we will
still need to fix userspace to handle this.

Rafael, what is your take on this?

Regards,

Hans
