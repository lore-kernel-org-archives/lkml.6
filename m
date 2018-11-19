Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B40CFC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 09:58:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FE3020871
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 09:58:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="L1IHAbeX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FE3020871
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727670AbeKSUVv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 15:21:51 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46344 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727084AbeKSUVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 15:21:50 -0500
Received: by mail-wr1-f66.google.com with SMTP id l9so18412217wrt.13
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 01:58:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+CcwNZHlu+n9v8HXDa3SYL/8n8ZY1HFXMZUsKLSChtc=;
        b=L1IHAbeXMcOq3bfJv5daTHWcujuJ/If8bDSc/reW+JNGYJFK1CwztVu6yXGdDIuZAS
         P8RFWniKTIif8ve6CEaYfYYv0UFsGVmUeS7WwhXPeol6x/0z/PkShipx0AzAIv1VhKLH
         MjU+Hv+78AWmMH3pOYh8uiud1ycIzZJPBlXu8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+CcwNZHlu+n9v8HXDa3SYL/8n8ZY1HFXMZUsKLSChtc=;
        b=TaEd/k28gdTx3Jx0j2jhV58io0Oau6Tpm5kj4Er2jncI/4ZdEtMJzj+vnUSeDR+tZl
         CquU06FFkcaFO1ofxyYVlXbtFR+qrTXHRKcfeFtM3RxpwFAVpPlKXvsWXoP4XwTW1ztp
         WYLCaVn+pqYLt7WgBfljs9FrLrbG6cxNCzkLXc5l6sH1r1p744v+pPoNfCVHvToGfM27
         ZdOYNLULhrt1mGBqZAA4Uvy+eXcrkYKXMHJt0MNXjxfqdj0bOWiXyGSM9E7+iXPmE8Zw
         FGxt5aYLpXfVguwXfoKqcMqXh4mPIsQEE/kO+iqyY1uAM2l+HhdxsJTxhOUi2iXWNWPv
         N4ig==
X-Gm-Message-State: AGRZ1gI87Y6UGomJSSqaib3CMs0o2oKs0D8ej1mfoMEVbxtDHUBS06Zq
        wcNXr2hR3x5UB6mUnZiVvLREEw==
X-Google-Smtp-Source: AJdET5fEryQnsr4HYHcVQBITvl+Sd3SYUoPrpxauXZ7V7TCo44lEpsWFn5+tSPfhzATGOXCpc+29lA==
X-Received: by 2002:adf:e28c:: with SMTP id v12-v6mr17058679wri.26.1542621521519;
        Mon, 19 Nov 2018 01:58:41 -0800 (PST)
Received: from [192.168.0.40] (51.223.136.77.rev.sfr.net. [77.136.223.51])
        by smtp.googlemail.com with ESMTPSA id e66-v6sm65085934wmf.40.2018.11.19.01.58.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Nov 2018 01:58:40 -0800 (PST)
Subject: Re: [PATCH v2] clocksource/drivers/arc_timer: Utilize generic
 sched_clock
To:     Alexey Brodkin <alexey.brodkin@synopsys.com>
Cc:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "vineet.gupta1@synopsys.com" <vineet.gupta1@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
References: <20181017113020.7551-1-abrodkin@synopsys.com>
 <C2D7FE5348E1B147BCA15975FBA23075012B0B1A07@US01WEMBX2.internal.synopsys.com>
 <78ccbb4c-56d0-594b-4032-3eb19202847b@linaro.org>
 <2c46ab6e-f0a9-4857-9772-f3c714284e98@linaro.org>
 <dab866a50e66e73f6010de1487b06019887930c8.camel@synopsys.com>
 <40ada5b3-5824-51fd-501f-ef363f162047@linaro.org>
 <e31a11c42c21353963bd75c88493e8158316d469.camel@synopsys.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <6bb98a9c-899e-ee9c-d630-da07382c1c16@linaro.org>
Date:   Mon, 19 Nov 2018 10:58:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <e31a11c42c21353963bd75c88493e8158316d469.camel@synopsys.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Alexey,

On 19/11/2018 10:55, Alexey Brodkin wrote:
> Hi Daniel,

[ ... ]

>>> In that case do I understand correctly that we may enable GENERIC_SCHED_CLOCK
>>> for ARC even before proposed change for arc_timer.c gets merged - i.e. with no
>>> special GENERIC_SCHED_CLOCK driver we'll safely fall-back to jiffie-based
>>> sched clock which we anyways use now when GENERIC_SCHED_CLOCK is disabled, right?
>>
>> The ARC's Kconfig part does not apply on tip/timers/core.
> 
> May I have a reference to that tree so I may check what gets in the way there
> and then I'll just move "select GENERIC_SCHED_CLOCK" a bit below so there're no
> clashes any longer.

sure, here it is:

https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/log/?h=timers/core


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

