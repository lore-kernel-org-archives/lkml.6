Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CB08ECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 22:06:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BCC021470
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 22:06:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="kmI1fLP8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BCC021470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726624AbeJTGOA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 02:14:00 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38105 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726313AbeJTGOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 02:14:00 -0400
Received: by mail-pg1-f194.google.com with SMTP id f8-v6so16315789pgq.5
        for <linux-kernel@vger.kernel.org>; Fri, 19 Oct 2018 15:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=ELIUPqDxF5m+HeMdeUJd/lmuPOV0caa6vT+E7+g/w10=;
        b=kmI1fLP83l/BejTMnVmaW3I0cFRZeoncjpxCDKudJBHq64a2EuiQuyZ5lltA0aJMMz
         7a80Zc7v1LPFlxzzbitlMJf9hZ8XGUdjakhKY8yB7OtN7YqEAbYi6hLrtmJAhVyVs0bn
         +jAWkCn2SceiHONygywKZV6secVE1o/r8VuOxNQKT/7Y20NEJzC+1WUs+DTdetBdoZ6/
         +8WQK9+7+9lAmeEKk7vOB5yy30tP5DwrWbwMfn+zV+rTtvH9QfMUD/lDaH9tf85QBQHF
         ulxlwVaKU4rf8WXkPeb5OjlWVFbSghK7HAVhbI/I7m47mj82zsQ2lpKugivNvBCne/Jv
         BEVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=ELIUPqDxF5m+HeMdeUJd/lmuPOV0caa6vT+E7+g/w10=;
        b=aSGrwoS5VcXkSJ+JAvOEn8ykgwtM0C2AhdQwEtg+oIAL99aKCo6qqpPLRN9oRE6L5d
         FGfnyyqKIWNZSWGtyEBWx0pZ0pvky3zuktZGzAiB82cF5XS9X9wDzmuuvahA0LhZpGmt
         Oy3e69Lt7IVQG/NRd2ggQ6MwKPv/+xlZzha1S887AyQqDmXcvM/o7F/TC9tf686s81ZT
         /Mxuu523Fx0gUbsiaw1kRlwINDya7+JA4L5M9NBOJROFMxwzydSiNWRh45Qlyztbn9Nv
         Aq/Uau6FNIkcri7Vt/MwzmLR3t8OvRLiUqZXpWD7i4x97Lvs2itvrX4bCjCUSyL8XQWc
         ec0Q==
X-Gm-Message-State: ABuFfojTN8tYu1VXyf6SZJUuGXM/3osgjr4s7torXuF8OIJe8l0fSYhV
        ozpIXBac/a8kBxqpDi+0WJH1fA==
X-Google-Smtp-Source: ACcGV6142jmGT3mgmJqV5OGyiDAFE4LFuV0FvNkWABWoVmVHgGOu4KaNYCZhjes2nWM1SLS/AewgZQ==
X-Received: by 2002:a63:c112:: with SMTP id w18-v6mr34632882pgf.429.1539986764501;
        Fri, 19 Oct 2018 15:06:04 -0700 (PDT)
Received: from [172.19.248.111] ([104.153.224.167])
        by smtp.gmail.com with ESMTPSA id y8-v6sm41227977pfd.168.2018.10.19.15.05.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Oct 2018 15:06:03 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] dt-bindings: serial: add documentation for the
 SiFive UART driver
To:     Rob Herring <robh+dt@kernel.org>
Cc:     "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul@pwsan.com>
References: <20181019184827.12351-1-paul.walmsley@sifive.com>
 <20181019184827.12351-2-paul.walmsley@sifive.com>
 <CAL_JsqJBSqaxnETdJg1Mdp+H2ay+WKT0JaxLe6D4Fwo_99qUkw@mail.gmail.com>
From:   Paul Walmsley <paul.walmsley@sifive.com>
Message-ID: <4317548d-f831-29ba-3be9-35f080587db9@sifive.com>
Date:   Fri, 19 Oct 2018 15:05:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqJBSqaxnETdJg1Mdp+H2ay+WKT0JaxLe6D4Fwo_99qUkw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/19/18 1:45 PM, Rob Herring wrote:
> On Fri, Oct 19, 2018 at 1:48 PM Paul Walmsley <paul.walmsley@sifive.com> wrote:
>> Add DT binding documentation for the Linux driver for the SiFive
>> asynchronous serial IP block.  Nothing too exotic.
>>
>> Cc: linux-serial@vger.kernel.org
>> Cc: devicetree@vger.kernel.org
>> Cc: linux-riscv@lists.infradead.org
>> Cc: linux-kernel@vger.kernel.org
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Cc: Rob Herring <robh+dt@kernel.org>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Palmer Dabbelt <palmer@sifive.com>
>> Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
>> Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
>> Signed-off-by: Paul Walmsley <paul@pwsan.com>
>> ---
>>   .../bindings/serial/sifive-serial.txt         | 21 +++++++++++++++++++
>>   1 file changed, 21 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/serial/sifive-serial.txt
>>
>> diff --git a/Documentation/devicetree/bindings/serial/sifive-serial.txt b/Documentation/devicetree/bindings/serial/sifive-serial.txt
>> new file mode 100644
>> index 000000000000..8982338512f5
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/serial/sifive-serial.txt
>> @@ -0,0 +1,21 @@
>> +SiFive asynchronous serial interface (UART)
>> +
>> +Required properties:
>> +
>> +- compatible: should be "sifive,fu540-c000-uart0" or "sifive,uart0"
> I assume once again, the last '0' is a version?


Yes.


> Palmer mentioned the
> compatible string is part of the IP block repository?


It is, but there's no guarantee that the compatible string from the RTL 
will make it into a ROM for any given chip.  For example, a customer may 
want the UART, but not want to take the DT ROM to keep area down.


This is one of the reasons why we'll likely switch to the usual 
software-maintained DTS files for Linux, just like the rest of arch/arm, 
arch/powerpc, etc.


> As I mentioned for the
> intc and now the pwm block bindings, if you are going to do version
> numbers please document the versioning scheme.


Will add that to the binding document.


>   Where does the
> number come from?


It comes from the RTL, which is public:

https://github.com/sifive/sifive-blocks/blob/master/src/main/scala/devices/uart/UART.scala#L43



> What's the next version?


1 (or something larger)


> Major vs. minor versions?


Not currently for this IP block.


> ECO fixes?


ECOs for a specific chip?  If so, whether an integrator changes the 
version number in a ROM (if present) is up to whomever does the ECO.  
That may not be SiFive.


Suppose that someone ECOs a SiFive UART in a way that incompatibly 
changes the programming model.  They can choose to submit corresponding 
RTL changes back upstream to the sifive-blocks repository, or not.


If they don't, and they want upstream Linux support, it's up to the 
integrator to define a "foobar,foochip-uart" in their chip DT file, and 
post it upstream to the kernel lists, along with the corresponding 
driver patches.


If however, they do get their changes accepted into the sifive-blocks 
public RTL repository, then the maintainer of sifive-blocks is 
responsible for ensuring that the compatible string in the RTL is 
changed in an appropriate way.


>   Is the version s/w readable?


Not in the UART IP block itself.   In the specific case of the FU540 
chip, there's a string in a ROM.


> How do you ensure it gets
> updated?


The string in the ROM?  For an IP block like the UART, it's up to the 
engineer patching the UART RTL to update the compatible string when the 
programming model changes, and the sifive-blocks maintainer to enforce it.

For a given chip, it's up to the integrator/end user whether they want 
to include the DT ROM or not, and if it's present, it's up to them what 
it contains.


> All that should be addressed.
>
> Otherwise, don't do version numbers because we have no visibility to
> what they mean.


It's all in the public RTL:

https://github.com/sifive/sifive-blocks/blob/master/src/main/scala/devices/uart/UART.scala#L43


>> +- reg: address and length of the register space
>> +- interrupt-parent: should contain a phandle pointing to the SoC interrupt
>> +    controller device node that the UART interrupts are connected to
> Don't need to document interrupt-parent here.


OK, will drop it.


- Paul

