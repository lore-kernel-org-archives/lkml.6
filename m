Return-Path: <benjamin.gaignard@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1519759401; cv=none;
        d=google.com; s=arc-20160816;
        b=hFjsQjg1D9DJZWseudjYq1jcxfV+eWbvAH9PL040bgksLVxCJeXBt8bWkRfnRsEVOz
         nldXLUc1R2Nh0QsS2JHmOkB0SDT5sK2lJZ5Bn3ebz1X1VPUKRITiO/wCMVTqB5ovnydt
         70Oouh6Nml+xCXC/Cl9CIBEON5MBPnEO6BFmNaOU4GE0RFEBHSINumEuBf8THuQFvmZM
         PbPbRwokS0JlvcFiJ9stf+2/xWkO3uGDDgun26/POEabn3BGsrA1R86ZDXVSIh0J+o2g
         MMR0Uw2YAGIOsHvgBSyZIzn4XtUcW6kCIsRrtC9UQbEJthUIKpCNUW1ceVN+S/+RdDPH
         i2dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=1fImqLnQHGXVUd6GW3V9U0p1/6ODderxhQHfK5sA3ss=;
        b=KfT41hvtRQ1DJ27uGA931BojiMVbOLV58esd2InsamGsgWcDnH9Zuoa3RqZOQ7/sev
         5bNHsqQ7zBP4DKoh8hpbtlj7+fmMTeXXVlz/KfU6ATQcw5JLF2QZ85m+PbRHks3XiWvr
         NZIKS87Wnbn+p0E79hlCFew2N1NWNDaDG6UKssBTYuH+0Ok/BH4Ic1tvkRFWtzKhJn6q
         DZN1ZlUF5L3hhy9zICCv8zbJ6QFWm5WHwF9z+I3vZIiJtkMA9SO7gZw5LLOHFQOz+k6c
         fz7qvOWxW1IH0ek803DOHeOaqFbVJ2O7sJ5PnbQkqX13kmrzA+pxrgObznXtWc5q+46i
         VY3g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=SjytyCLY;
       spf=pass (google.com: domain of benjamin.gaignard@linaro.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=benjamin.gaignard@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=SjytyCLY;
       spf=pass (google.com: domain of benjamin.gaignard@linaro.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=benjamin.gaignard@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AG47ELu9tUJeOv0BN7VeIErT8k01i6I9hMlCLWG7gv2kXA9yqRUpLCQkzImoi7G8oYRy2vHwmd8BFmOao0ZUXAxkIl4=
MIME-Version: 1.0
In-Reply-To: <20180227171419.3nlz23qzptvew2as@lakrids.cambridge.arm.com>
References: <20180227140926.22996-1-benjamin.gaignard@st.com>
 <20180227140926.22996-4-benjamin.gaignard@st.com> <20180227171419.3nlz23qzptvew2as@lakrids.cambridge.arm.com>
From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date: Tue, 27 Feb 2018 20:23:20 +0100
Message-ID: <CA+M3ks5xreBsZOoVFrDcP8DxgfNe6d4kduB-Fz=RgHSdT045QQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] ARM: mach-stm32: Add Extended TrustZone Protection driver
To: Mark Rutland <mark.rutland@arm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh+dt@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>,
	devicetree@vger.kernel.org, Linux ARM <linux-arm-kernel@lists.infradead.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Benjamin Gaignard <benjamin.gaignard@st.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593563504713995835?=
X-GMAIL-MSGID: =?utf-8?q?1593583234649945040?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

2018-02-27 18:14 GMT+01:00 Mark Rutland <mark.rutland@arm.com>:
> On Tue, Feb 27, 2018 at 03:09:26PM +0100, Benjamin Gaignard wrote:
>  +
>> +static const u32 stm32mp1_ip_addr[] = {
>> +     0x5c008000,     /* 00 stgenc */
>> +     0x54000000,     /* 01 bkpsram */
>> +     0x5c003000,     /* 02 iwdg1 */
>> +     0x5c000000,     /* 03 usart1 */
>> +     0x5c001000,     /* 04 spi6 */
>> +     0x5c002000,     /* 05 i2c4 */
>
> ...
>
> This duplicates information that is in the DT, which is unfortunate.

Yes I would have prefer to be able to get this information from etzpc
hardware itself
but that isn't the case so I need this table to found the status bits
of each device.

>
> Why can these not be marked disabled inthe DT instead?
>
> If it's dynamic form boot-to-boot, then the FW can probe this prior to
> entering Linux, and patch the DT appropriately.

I know that is one software way to do, but let discusted about that in
cover letter thread.

Thanks,
Benjamin

>
> Thanks,
> Mark.
