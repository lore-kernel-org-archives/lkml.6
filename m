Return-Path: <linus.walleij@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1526481505; cv=none;
        d=google.com; s=arc-20160816;
        b=gNSYklmONRlV53m0axCZYVULoktVemodP4isjBTTSr51/OfE7eXUSal+ie36L0WAes
         WuJklYE0MDTGHqZwWAS6N8CaK8FVWBNwz0loLC0Oa0eBe1Sgo8peusDS0hA0KzPhAh+M
         HWkC+UGU/Zme8dJZHWYTGl1280ZCA4kYb3bKkzmW/ylb3bmXd1blL3dKf2Ddlo87QGgY
         6ebuCGEqx2UxoPsbGdtrm9LrhD0ZNCGoEzJ9sgcxZE6QicpAQTbP2MFOOPHaFvNdnf8U
         FKhIjn458dg+fr1zAo9EpzQhTcoIS9NloJiCaCllIMSk49vT0jIGd6t/od6QlDDUgziB
         /k8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=ME/3gu1484EaW87HIiVjc5+3+k8IT5i7zeOWsIUAJOg=;
        b=ezpcdVBDtKOPNayl/FpV4yPs0VCfWoCm6XPb5zz7Tc+6hN2YlJ/PWx7p3XrioZyncB
         OQv7r0Hg2clE0dvvtRN99w4R9eAMb4ZuGPwrJdswc9n/bBAS9hcZqVYUO0YOyIEL06tT
         ayWrMWcarNBrwDNAza1SVl1KJQSCus7os0f3nKlJyOLB0aaDAKVOqKs9jwus1quDJuEW
         yeLuNIgAREz3zoHZGn2QH2THShDHkfxwWNpsSFHXUcF7FqL2wXw9kMOf41jrgyMGPfBx
         42RtC7u1FEYbo9+naibenBOm3s1m0/85OsA8NeJNXemb9Kg6K7GMO5UpfyvxJ/5XwH99
         TmWQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=M3lOGSr1;
       spf=pass (google.com: domain of linus.walleij@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=linus.walleij@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=M3lOGSr1;
       spf=pass (google.com: domain of linus.walleij@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=linus.walleij@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AB8JxZpD5foEk5vUmXtJB9Cv8yynYveGmEik4W7r2SHDvJKqJu200z+C5i1oNz5c6cUCaxLPrj4lJKFuIkN4cecYG1M=
MIME-Version: 1.0
In-Reply-To: <45eca00d-57f5-21b5-1f6e-b5f3f60ad276@xilinx.com>
References: <20180501213114.20183-1-robh@kernel.org> <20180507183106.GF2259@tuxbook-pro>
 <91dad272-e07d-2ab6-2afa-538294e9cefa@suse.de> <CACRpkdaYN-wKErERP_65T2NH6L-+8O_ugSgg7pXfkaLkn1A2KQ@mail.gmail.com>
 <c6655f84-747f-c08b-7b9c-f76ff8857567@suse.de> <45eca00d-57f5-21b5-1f6e-b5f3f60ad276@xilinx.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 16 May 2018 16:38:23 +0200
Message-ID: <CACRpkdYijOTMDr6Omh8pt2T2ugExpWngqp+bydBJG2tiyE2k7Q@mail.gmail.com>
Subject: Re: [RFC PATCH] driver core: make deferring probe forever optional
To: Michal Simek <michal.simek@xilinx.com>
Cc: Alexander Graf <agraf@suse.de>, Bjorn Andersson <bjorn.andersson@linaro.org>,
	Rob Herring <robh@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Grant Likely <grant.likely@arm.com>,
	Mark Brown <broonie@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	boot-architecture@lists.linaro.org,
	Linux ARM <linux-arm-kernel@lists.infradead.org>, Jan Kiszka <jan.kiszka@siemens.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599298891509345819?=
X-GMAIL-MSGID: =?utf-8?q?1600631870449981554?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, May 14, 2018 at 2:44 PM, Michal Simek <michal.simek@xilinx.com> wrote:
> On 14.5.2018 09:37, Alexander Graf wrote:
>> On 05/14/2018 12:01 AM, Linus Walleij wrote:
>>> On Wed, May 9, 2018 at 11:44 AM, Alexander Graf <agraf@suse.de> wrote:
>>>> On 05/07/2018 08:31 PM, Bjorn Andersson wrote:
>>>>> Can you please name platform that has enough support for Alexander to
>>>>> care about backwards and forwards compatibility but lacks a pinctrl
>>>>> driver.
>>>> ZynqMP is one example that immediately comes to my mind. I'm sure
>>>> there are
>>>> others too.
>>> Why isn't that using drivers/pinctrl/pinctrl-zynq.c?
>>>
>>> How is it so very different from (old) Zynq as it is already using
>>> the same GPIO driver?
>>
>> That one is very simple: ZynqMP is usually an AMP system where Linux
>> doesn't have full knowledge of the overall system. IIUC they have a tiny
>> microblaze (PMU) that does the actual full system configuration for
>> peripherals that may interfere with each other. This architecture also
>> allows for safety critical code to run alongside a (less safe) Linux
>> system.
>
> Linux is running in non secure world that's why Linux can't have full
> system visibility and Linux should ask firmware. It doesn't matter if
> firmware is running on specific unit or just secure SW in EL3/EL1-S, EL0-S.
> You can also configure ZynqMP to protect these address ranges not to be
> accessible from NS sw.
> If you don't care about security you can use normal read/write accesses
> at least for gpio case. Pinctrl/clk will be driven via firmware interface.

OK I get it, the situation is similar to some ACPI-based BIOSes on
PC where one needs to ask the firmware for misc services.

What would be nice is to standardize these APIs (like ACPI or device
tree does) so we don't end up with one per-SoC-specific driver per
system. But I guess it is not my pick.

Yours,
Linus Walleij
