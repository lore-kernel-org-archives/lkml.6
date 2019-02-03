Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 542A1C169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 09:43:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EBEF2083B
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 09:43:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727761AbfBCJns (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 04:43:48 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33409 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727724AbfBCJns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 04:43:48 -0500
Received: by mail-wr1-f67.google.com with SMTP id a16so5798980wrv.0
        for <linux-kernel@vger.kernel.org>; Sun, 03 Feb 2019 01:43:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WSvwqx9bikCLcmhpAMqSYA8JbWpH3TZEkQisb0dHc1s=;
        b=cWzSVgSsTVDrugjZGnpTrjvrbc5UHb4uISflP9bgtNiNNF1kZXJotMV1e7Dd9cX4je
         EDvrG0z6SZ8pdp206HQtfPQ+kflfp6U6icOt0kzy+l7CPJ2ZZtd7s0pvv7OQ9K/CnkDN
         QOzwLMWJqgQHY2C0ElNBdPk0xLvwPfnfevfgyB3dllJBOirCSsxd8OPsrl1B/LxxhXtJ
         QgP2CDeh8udV63UsfNiFCVeOrmZhGlKEMsa4Js6vWM42QjPXJhkR4g5wSi147aBUuvf5
         7DkBWDGrKkXfzd9JizqJXsb8WJ/iqkCzuLENlg+JLn4m9sIBp2EF2uOyiQ4zfjbHpzdF
         s4yA==
X-Gm-Message-State: AJcUukdqMBbOd/XtOMfwIyvR809aWik/QGbheD0oSzIhED4QCSWMCWND
        JsLxoboU6y3Ii7p1bQZMI3jMEkDE0IQ=
X-Google-Smtp-Source: ALg8bN631ib24l12CC2rVXVGlhrzn6+HicqW87NhpL653+QeL9cHoIEwSXNfmEmNJ2bY7Abtt3LUWg==
X-Received: by 2002:adf:f211:: with SMTP id p17mr44513942wro.293.1549187026126;
        Sun, 03 Feb 2019 01:43:46 -0800 (PST)
Received: from localhost.localdomain ([212.76.254.34])
        by smtp.gmail.com with ESMTPSA id v4sm6548168wme.6.2019.02.03.01.43.44
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Feb 2019 01:43:45 -0800 (PST)
Subject: Re: [PATCH] platform/x86: intel_int0002_vgpio: Implement irq_set_wake
To:     Maxim Mikityanskiy <maxtram95@gmail.com>
Cc:     Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180924143719.22191-1-hdegoede@redhat.com>
 <CAKErNvoeMs9cDDAvMfxaGLsKY3-q_JmrjCUB8VK4ZUXUVytwsQ@mail.gmail.com>
 <35cfd1f2-43eb-fc49-4777-a21413bb2d41@redhat.com>
 <CAKErNvptohPtM_Zf8oLk_tgQMNq3ypdrGen6Juv-4veba-pbaQ@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <c41941b0-c655-8263-f0a8-b65364515655@redhat.com>
Date:   Sun, 3 Feb 2019 10:43:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAKErNvptohPtM_Zf8oLk_tgQMNq3ypdrGen6Juv-4veba-pbaQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2/2/19 8:04 PM, Maxim Mikityanskiy wrote:
> On Sat, Feb 2, 2019 at 12:52 AM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Hi,
>>
>> On 1/31/19 8:47 PM, Maxim Mikityanskiy wrote:
>>> Hi,
>>>
>>> On Mon, Sep 24, 2018 at 5:37 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>>>
>>>> We were relying on the interrupt being shared with the ACPI SCI and the
>>>> ACPI core calling irq_set_wake. But that does not always happen on
>>>> Bay Trail devices, so we should do it ourselves.
>>>>
>>>> This fixes wake from USB not working on various Bay Trail devices.
>>>
>>> This patch breaks suspend on ASUS E202SA (bisecting pointed me to this
>>> patch, and if I revert it and build 4.20.5 without this patch,
>>> everything works flawlessly).
>>
>> Thank you for the bug report, can you please test 4.20.5 with the attached
>> patch on top? That should fix it. Once I've confirmation that this fixes
>> things I will submit the patch upstream.
> 
> I've tested your patch against both 4.20.5 and 4.20.6, and it works
> fine. Thank you for such a quick fix.

Thank you for the bug-report and for testing the fix. I've submitted
the patch upstream now, so hopefully it will show up in a 4.20.x
release soon.

Regards,

Hans
