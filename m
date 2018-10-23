Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8720C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 17:05:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A28AE20665
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 17:05:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="hoRCkKAR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A28AE20665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728646AbeJXB37 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 21:29:59 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:33538 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728488AbeJXB36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 21:29:58 -0400
Received: by mail-ed1-f67.google.com with SMTP id r25-v6so2360630edy.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 10:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=z9Hr70PhvvvU4PrsJYQR5cJ/AOmcSadB+PAQIQWG7Eo=;
        b=hoRCkKARqhl2rgpvFGA67polxnHSQ7lx9hF7w9hGwOrQfmLtCjHaepnz9Uh0wm3EpF
         1ML4u2xEPsQVKH1Dylfhbc7z2hiLVMBgb7G+sPePfvm2VQn4hDEJHtHKqheR63D3ICwI
         mucgnHr5kcvt2wPuz3no9DxOBU6yFQGW3gq4yTTB7gj6mp9dj1EvT1HXjsdE5scxoECa
         /LtakaEjSOdab9HtLfCRRh6VALuTPj2bxwRY08tGE3gbmqpBSv1biLoB0zq0CDVSt+VI
         TL5iD1WmNkweO/Q4dQ3E0exFGAU/WVJWcheSaV5ZdhDll5Icg9hA8E4WAMRAsEGXF/vW
         84+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=z9Hr70PhvvvU4PrsJYQR5cJ/AOmcSadB+PAQIQWG7Eo=;
        b=VMHlmo2//NP5ir0NYhlu9zTgGaPmbySu1liPwIylUAWHiKiFhdmIfmw6ADGjC5b6nm
         Maadr4orzIWdt9rd0q2IOdr+TEzPe66fXe3A0rgVcdCGWdp7lKbdFyNJLjoCv1wB19cH
         COd0YwjxQxA+5tEy9Yjv5wNM5yPeF3nW7KO0mMYIcbZwtscBxdvT2Mxigt5kmAVgwhqK
         s/VVS2LCmh4JVT3IyB4r13N96Qp1RswktmfwJCbYks4G49w7XyjEIMDWv3GJ+muzl+rl
         Pa2jPV4UgZdPcz3pg+ymzGw9ZPdC4st0ajrmDwCbIOU2G7lOIwnu0hEFUEkQK2nhGH9y
         HTxg==
X-Gm-Message-State: ABuFfoh4Ul7OSd0WeYkZw731cPLIuuJIGQBIQP7jVuiBgmZ1KVOfd5WS
        O7Y9mQ7lg4o9qiTazAorMERStQaISNc=
X-Google-Smtp-Source: ACcGV60BTRSSS2MlVkKfrIgtqn7G1FptPmOo1Y5qjevk7WPaiowE17sFp+67GdQWJmU//Z9fXZJNEQ==
X-Received: by 2002:a17:906:e082:: with SMTP id gh2-v6mr2708879ejb.92.1540314342849;
        Tue, 23 Oct 2018 10:05:42 -0700 (PDT)
Received: from [10.1.6.225] ([185.15.205.146])
        by smtp.gmail.com with ESMTPSA id dv2-v6sm480363ejb.10.2018.10.23.10.05.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Oct 2018 10:05:42 -0700 (PDT)
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
 <4317548d-f831-29ba-3be9-35f080587db9@sifive.com>
 <CAL_JsqLagTgjDhZ02X=wPFDB4WF2bR7=LyzSW9D=ooo_XB_zOg@mail.gmail.com>
From:   Paul Walmsley <paul.walmsley@sifive.com>
Message-ID: <6571bb0e-b36a-1196-4d90-8aa62d8a2a90@sifive.com>
Date:   Tue, 23 Oct 2018 10:05:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqLagTgjDhZ02X=wPFDB4WF2bR7=LyzSW9D=ooo_XB_zOg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/20/18 7:21 AM, Rob Herring wrote:
> On Fri, Oct 19, 2018 at 5:06 PM Paul Walmsley <paul.walmsley@sifive.com> wrote:
>> On 10/19/18 1:45 PM, Rob Herring wrote:
>>> On Fri, Oct 19, 2018 at 1:48 PM Paul Walmsley <paul.walmsley@sifive.com> wrote:
>>>> Add DT binding documentation for the Linux driver for the SiFive
>>>> asynchronous serial IP block.  Nothing too exotic.
>>>>
>>>> Cc: linux-serial@vger.kernel.org
>>>> Cc: devicetree@vger.kernel.org
>>>> Cc: linux-riscv@lists.infradead.org
>>>> Cc: linux-kernel@vger.kernel.org
>>>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>>> Cc: Rob Herring <robh+dt@kernel.org>
>>>> Cc: Mark Rutland <mark.rutland@arm.com>
>>>> Cc: Palmer Dabbelt <palmer@sifive.com>
>>>> Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
>>>> Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
>>>> Signed-off-by: Paul Walmsley <paul@pwsan.com>
>>>> ---
>>>>    .../bindings/serial/sifive-serial.txt         | 21 +++++++++++++++++++
>>>>    1 file changed, 21 insertions(+)
>>>>    create mode 100644 Documentation/devicetree/bindings/serial/sifive-serial.txt
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/serial/sifive-serial.txt b/Documentation/devicetree/bindings/serial/sifive-serial.txt
>>>> new file mode 100644
>>>> index 000000000000..8982338512f5
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/serial/sifive-serial.txt
>>>> @@ -0,0 +1,21 @@
>>>> +SiFive asynchronous serial interface (UART)
>>>> +
>>>> +Required properties:
>>>> +
>>>> +- compatible: should be "sifive,fu540-c000-uart0" or "sifive,uart0"
>>>>
>>> As I mentioned for the
>>> intc and now the pwm block bindings, if you are going to do version
>>> numbers please document the versioning scheme.
>>>
>>>
>>> Will add that to the binding document.
> I don't seem to be making my point clear. I don't want any of this
> added to a binding doc for particular IP blocks. Write a common doc
> that explains the scheme and addresses the questions I asked. Then
> just reference that doc here.
>
> Maybe this is documented somewhere already? Otherwise, if one is
> creating a new IP block, how do they know what the versioning scheme
> is or what goes in the DT ROM?


Seems like there might be some confusion between IP blocks as integrated 
on an SoC vs. IP blocks in isolation.  It's not necessarily the SoC 
integrator that sets an IP block version number; this can come from the 
IP block vendor itself.  So each IP block may have its own version 
numbering practices for the IP block alone.


For SiFive IP blocks, we at SiFive could probably align on a common 
version numbering structure for what's in the sifive-blocks repository.

But other IP blocks from other vendors may not align to that, or may not 
have version numbers exposed at all.  In those cases there's no way for 
software folks to find out what they are,  as you pointed out earlier.  
This is the case with most DT compatible strings in the kernel tree.

For example, we've integrated the NVDLA IP block, from NVIDIA, on some 
designs.  Any NVIDIA version numbers in that IP block will probably not 
follow the SiFive version numbering scheme.  I'd propose the right thing 
to do for an IP block compatible string is to follow the vendor's 
practice, and then use the SoC integrator's version numbering practice 
for the SoC-integrated compatible string.


In effect, an SoC integration DT compatible string like 
"sifive,fu540-c000-uart" implicitly states an IP block version number: 
"whatever came out of the fab on the chip"[**].   I'd propose that even 
in these cases, there's an advantage to keeping the "0" on the end, 
since it uniquely identifies an SoC-independent IP block, rather than 
just the type of the IP block.   But if the "0" on the end of the SoC 
integration DT compatible string is problematic for you, we can 
certainly drop that last 0 from the SoC integration DT compatible 
string, and only suffer a slight lack of clarity as to what version was 
integrated on that chip.


But for IP block-specific version strings like "sifive,uart0", I think 
we can address your concern, at least for these public IP blocks. Since 
the SiFive UART and some other peripheral IP blocks are open-source, the 
public can have a pretty good idea of what DT version number corresponds 
to the source RTL, since the RTL is public.   The version number 
identifies a specific programming model, without tying that programming 
model to any SoC-specific workarounds, etc.  So for these cases, I think 
there's a pretty good case for having IP block-specific version numbers 
in DT compatible strings, and I hope you'll agree.


The advantage for all of us is that there's then no need to embed 
chip-specific DT match strings in these drivers, for the most part.  We 
just match on "sifive,uart0" and that's it, assuming no chip-specific 
workarounds are needed.


>>>    Where does the
>>> number come from?
>>
>> It comes from the RTL, which is public:
>>
>> https://github.com/sifive/sifive-blocks/blob/master/src/main/scala/devices/uart/UART.scala#L43
> I'm not going to go read your RTL, sorry.


There's no need, but you did ask where it came from.  Sorry you didn't 
like the answer.


Please let us know what you want us to do.


Thanks for your review


- Paul


** The caveat is that even with SoC identifiers in the Linux DT 
compatible strings, there's not enough information in many of the 
existing kernel DT compatibility strings to uniquely identify chip 
versions.  Taking OMAP and Tegra as examples, there are several 
different chip versions for a given SoC generation that came out of the 
fab.    OMAP chip version strings usually began with "ES"; Tegra version 
numbers, as I recall, were a letter and two numbers.  For the most part, 
those versions were never specifically identified in the upstream kernel 
DT strings or in DT file names. (There are some exceptions with OMAP 
where we did identify specific chip version numbers, because sizable 
numbers of folks had boards with early silicon, and we were committed to 
supporting them at the time.)    Sadly even adding these additional chip 
version identifiers to the DT strings wouldn't be perfect: I've seen at 
least one large vendor implementing metal-only ECOs without incrementing 
public chip version numbers. The point here is that we're already not 
uniquely identifying IP blocks with our current Linux DT compatibility 
string scheme.

