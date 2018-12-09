Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC3A7C07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 16:30:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7596220865
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 16:30:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jppk0nSe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7596220865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbeLIQaj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 11:30:39 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36373 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726086AbeLIQai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 11:30:38 -0500
Received: by mail-wr1-f67.google.com with SMTP id u3so8160145wrs.3
        for <linux-kernel@vger.kernel.org>; Sun, 09 Dec 2018 08:30:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FQB0a0IYNo7nzjeesQeSWed9Fp4QxJVIsK4jZhxJpcI=;
        b=Jppk0nSeK155fTwXj0059QiD5mKiqcaL05P5HAzEokSCSlpHAE4nMy0VG2w52pLicb
         LSkMDZcEm55h+pok8ZLw2ZTsIXkiQE23IH6NVcKMiuFSBpWhziQgc9uM3pM2WGbngwKV
         iMLZWv/CzLdh31Ea5rPhKc2tkW94PdqpYpAEY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FQB0a0IYNo7nzjeesQeSWed9Fp4QxJVIsK4jZhxJpcI=;
        b=b0lFQxQdHCe7nXfUBhivYlS07Mt3UroVhKLzSTtPBt3v0ofDnWPQAQPZh7lIpfwArB
         FeT4rJpLa6ylYeTs74PYBofbl8tE4KPSAY9dVpy99rgIvVC8Wk0J70Et6iI5MypSLEyz
         J0SOWEGdvxpHzFisDsVHcxpgBqVgeg4VTb2Yi2wxN2Tx+WPVyo06/F5bz8M7z6GS9XgD
         uWEPFKwGgSJBQZVtIp/rdAuPQoSXS06ASds0ozHiWzGG0k2KDGe0Dk1CcItpW+0u7K/g
         sLq1jn4MSLpgYbPI+Hlg8E5mJlfNbR0k2D6baPvRBieFRlHqNxJj1ScZggWcu7KQjlgR
         Nxrg==
X-Gm-Message-State: AA+aEWY0GYAb7/nYEFCI0R6K7FkXyuBQDASVW2XqWOc0JMUVj9RrRu9S
        l1JiFUuJfL44cyQw+9yuMNQPLY4H550=
X-Google-Smtp-Source: AFSGD/VW9CqCEd1EmZvjZwOiD9wTJXLLd3mKkP2psLm0QyuxQzJAEw6Lc+oPpNbjT7GDwco0FQ1nrg==
X-Received: by 2002:a5d:6549:: with SMTP id z9mr7038765wrv.116.1544373036375;
        Sun, 09 Dec 2018 08:30:36 -0800 (PST)
Received: from [192.168.0.40] (29.44.88.92.rev.sfr.net. [92.88.44.29])
        by smtp.googlemail.com with ESMTPSA id k128sm13132271wmd.37.2018.12.09.08.30.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Dec 2018 08:30:35 -0800 (PST)
Subject: Re: [PATCH v2 0/2] Provide sched_clock for riscv_timer
To:     Palmer Dabbelt <palmer@sifive.com>, anup@brainfault.org
Cc:     tglx@linutronix.de, aou@eecs.berkeley.edu, atish.patra@wdc.com,
        Christoph Hellwig <hch@infradead.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <mhng-3c8e382b-518c-4e32-b76e-3eebdd41034a@palmer-si-x1c4>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <dd6a7f3f-203a-f71d-314e-9706ca4757bf@linaro.org>
Date:   Sun, 9 Dec 2018 17:30:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <mhng-3c8e382b-518c-4e32-b76e-3eebdd41034a@palmer-si-x1c4>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/12/2018 18:59, Palmer Dabbelt wrote:
> On Tue, 04 Dec 2018 02:29:50 PST (-0800), anup@brainfault.org wrote:
>> This patchset extends riscv_timer to provide sched_clock using generic
>> sched_clock framework.
>>
>> The patchset is tested on QEMU virt machine. It is based on
>> Linux-4.20-rc5
>> and can be found at riscv_sched_clock_v2 branch of:
>> https://github.com/avpatel/linux.git
>>
>> Changes since v1:
>>  - Added patch to select GENERIC_SCHED_CLOCK for RISC-V
>>  - Kconfig RISCV_TIMER depends on GENERIC_SCHED_CLOCK
>>
>> Anup Patel (2):
>>   RISC-V: Select GENERIC_SCHED_CLOCK for clocksource drivers
>>   clocksource: riscv_timer: Provide sched_clock
>>
>>  arch/riscv/Kconfig                | 1 +
>>  drivers/clocksource/Kconfig       | 2 +-
>>  drivers/clocksource/riscv_timer.c | 9 +++++++++
>>  3 files changed, 11 insertions(+), 1 deletion(-)
> 
> I'm going to add these to my for-next, but let me know if these should
> go through a clock maintainer's tree instead and I'll drop them.

I'll take the second one through my tree.

  -- Daniel

-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

