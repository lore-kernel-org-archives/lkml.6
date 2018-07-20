Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58DC2ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 14:39:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2EE0206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 14:39:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="b0pmwnA7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2EE0206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731747AbeGTP17 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 11:27:59 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38833 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731546AbeGTP17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 11:27:59 -0400
Received: by mail-wr1-f67.google.com with SMTP id v14-v6so11554290wro.5
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jul 2018 07:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:subject:to:cc:references:openpgp:autocrypt:message-id:date
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oyISpPnA++Y5PK0tj8A0vfH2r+hsrfA8ONlHyDip7ys=;
        b=b0pmwnA7fyPq+RLOIYK+J4UCkv9KjwESOPNv16diSSGy2g1ZEleqt54gXwjgEVMSYo
         1uFO076+HB7M9alMTcZjqSqxc5rZNh3hEEH6xXxcj8GHxcjYUnVtRiO8O2XdFUfssBDV
         O9wshm06W5MFFKwOEHPb8qjp/1manR3OQcKJo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:openpgp:autocrypt
         :message-id:date:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oyISpPnA++Y5PK0tj8A0vfH2r+hsrfA8ONlHyDip7ys=;
        b=QD8MqLPKx991l4cKSzURpluDnUtB4y7o4rTeBk4p/IdfsU/xzLf0dOh7rMM0pE2uBI
         r4tHeUvXLlY1b2uLEX3/pYVaDlIOvvoHniXaLTcQHBFSurLZ98dJXcfR9vmVhkuN/kUI
         CsNTqfIoZEwKCbAVQblp5MJyapzuw8QQ06Y5j6AEmLM5VP/SI4jaXelKa+9J32lFcN6L
         rgqlYIt4VT4/UEmBth+9GLvd9DRgCO/lxfwqkm7Nuiohq9pe5ETyZ/vnRpNPIJ9uUmIg
         YXI1NqSygDVkGJBMSTd034B/tN9N1l72qgJLuoflGODcfR5FZNSY4BuvvgK70qMGn7Mh
         bviw==
X-Gm-Message-State: AOUpUlGJ9xl74AbTudx7d0bpPHjfvAow4Jz3f/2IdUI0ZfN4Njvnnlxv
        MVyVqMbrPoEVlH0h1kwHJTJs0Q==
X-Google-Smtp-Source: AAOMgpeWVzt66nC5TtagwZk7qacVMbi/baSaTB33+QxnqEgyJxCZyQilLAOWxeGc1lZiV+v5oKaI+Q==
X-Received: by 2002:a5d:4785:: with SMTP id w5-v6mr1623108wrq.188.1532097562394;
        Fri, 20 Jul 2018 07:39:22 -0700 (PDT)
Received: from [10.44.66.8] ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id l10-v6sm1854705wrv.23.2018.07.20.07.39.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Jul 2018 07:39:21 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
Subject: Re: [PATCH v6 4/8] interconnect: qcom: Add RPM communication
To:     Evan Green <evgreen@chromium.org>
Cc:     linux-pm@vger.kernel.org, gregkh@linuxfoundation.org,
        rjw@rjwysocki.net, robh+dt@kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        khilman@baylibre.com, Alexandre Bailon <abailon@baylibre.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Saravana Kannan <skannan@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        amit.kucheria@linaro.org, seansw@qti.qualcomm.com,
        daidavid1@codeaurora.org, mka@chromium.org, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, tfiga@chromium.org
References: <20180709155104.25528-1-georgi.djakov@linaro.org>
 <20180709155104.25528-5-georgi.djakov@linaro.org>
 <CAE=gft6pPcxfYqEcb-yQpf7S6CDTZNavhqYaKi37962U78qO3Q@mail.gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=georgi.djakov@linaro.org; prefer-encrypt=mutual; keydata=
 xsFNBFjTuRcBEACyAOVzghvyN19Sa/Nit4LPBWkICi5W20p6bwiZvdjhtuh50H5q4ktyxJtp
 1+s8dMSa/j58hAWhrc2SNL3fttOCo+MM1bQWwe8uMBQJP4swgXf5ZUYkSssQlXxGKqBSbWLB
 uFHOOBTzaQBaNgsdXo+mQ1h8UCgM0zQOmbs2ort8aHnH2i65oLs5/Xgv/Qivde/FcFtvEFaL
 0TZ7odM67u+M32VetH5nBVPESmnEDjRBPw/DOPhFBPXtal53ZFiiRr6Bm1qKVu3dOEYXHHDt
 nF13gB+vBZ6x5pjl02NUEucSHQiuCc2Aaavo6xnuBc3lnd4z/xk6GLBqFP3P/eJ56eJv4d0B
 0LLgQ7c1T3fU4/5NDRRCnyk6HJ5+HSxD4KVuluj0jnXW4CKzFkKaTxOp7jE6ZD/9Sh74DM8v
 etN8uwDjtYsM07I3Szlh/I+iThxe/4zVtUQsvgXjwuoOOBWWc4m4KKg+W4zm8bSCqrd1DUgL
 f67WiEZgvN7tPXEzi84zT1PiUOM98dOnmREIamSpKOKFereIrKX2IcnZn8jyycE12zMkk+Sc
 ASMfXhfywB0tXRNmzsywdxQFcJ6jblPNxscnGMh2VlY2rezmqJdcK4G4Lprkc0jOHotV/6oJ
 mj9h95Ouvbq5TDHx+ERn8uytPygDBR67kNHs18LkvrEex/Z1cQARAQABzShHZW9yZ2kgRGph
 a292IDxnZW9yZ2kuZGpha292QGxpbmFyby5vcmc+wsF+BBMBAgAoBQJY07kXAhsDBQkHhM4A
 BgsJCAcDAgYVCAIJCgsEFgIDAQIeAQIXgAAKCRCyi/eZcnWWUuvsD/4miikUeAO6fU2Xy3fT
 l7RUCeb2Uuh1/nxYoE1vtXcow6SyAvIVTD32kHXucJJfYy2zFzptWpvD6Sa0Sc58qe4iLY4j
 M54ugOYK7XeRKkQHFqqR2T3g/toVG1BOLS2atooXEU+8OFbpLkBXbIdItqJ1M1SEw8YgKmmr
 JlLAaKMq3hMb5bDQx9erq7PqEKOB/Va0nNu17IL58q+Q5Om7S1x54Oj6LiG/9kNOxQTklOQZ
 t61oW1Ewjbl325fW0/Lk0QzmfLCrmGXXiedFEMRLCJbVImXVKdIt/Ubk6SAAUrA5dFVNBzm2
 L8r+HxJcfDeEpdOZJzuwRyFnH96u1Xz+7X2V26zMU6Wl2+lhvr2Tj7spxjppR+nuFiybQq7k
 MIwyEF0mb75RLhW33sdGStCZ/nBsXIGAUS7OBj+a5fm47vQKv6ekg60oRTHWysFSJm1mlRyq
 exhI6GwUo5GM/vE36rIPSJFRRgkt6nynoba/1c4VXxfhok2rkP0x3CApJ5RimbvITTnINY0o
 CU6f1ng1I0A1UTi2YcLjFq/gmCdOHExT4huywfu1DDf0p1xDyPA1FJaii/gJ32bBP3zK53hM
 dj5S7miqN7F6ZpvGSGXgahQzkGyYpBR5pda0m0k8drV2IQn+0W8Qwh4XZ6/YdfI81+xyFlXc
 CJjljqsMCJW6PdgEH87BTQRY07kXARAAvupGd4Jdd8zRRiF+jMpv6ZGz8L55Di1fl1YRth6m
 lIxYTLwGf0/p0oDLIRldKswena3fbWh5bbTMkJmRiOQ/hffhPSNSyyh+WQeLY2kzl6geiHxD
 zbw37e2hd3rWAEfVFEXOLnmenaUeJFyhA3Wd8OLdRMuoV+RaLhNfeHctiEn1YGy2gLCq4VNb
 4Wj5hEzABGO7+LZ14hdw3hJIEGKtQC65Jh/vTayGD+qdwedhINnIqslk9tCQ33a+jPrCjXLW
 X29rcgqigzsLHH7iVHWA9R5Aq7pCy5hSFsl4NBn1uV6UHlyOBUuiHBDVwTIAUnZ4S8EQiwgv
 WQxEkXEWLM850V+G6R593yZndTr3yydPgYv0xEDACd6GcNLR/x8mawmHKzNmnRJoOh6Rkfw2
 fSiVGesGo83+iYq0NZASrXHAjWgtZXO1YwjW9gCQ2jYu9RGuQM8zIPY1VDpQ6wJtjO/KaOLm
 NehSR2R6tgBJK7XD9it79LdbPKDKoFSqxaAvXwWgXBj0Oz+Y0BqfClnAbxx3kYlSwfPHDFYc
 R/ppSgnbR5j0Rjz/N6Lua3S42MDhQGoTlVkgAi1btbdV3qpFE6jglJsJUDlqnEnwf03EgjdJ
 6KEh0z57lyVcy5F/EUKfTAMZweBnkPo+BF2LBYn3Qd+CS6haZAWaG7vzVJu4W/mPQzsAEQEA
 AcLBZQQYAQIADwUCWNO5FwIbDAUJB4TOAAAKCRCyi/eZcnWWUhlHD/0VE/2x6lKh2FGP+QHH
 UTKmiiwtMurYKJsSJlQx0T+j/1f+zYkY3MDX+gXa0d0xb4eFv8WNlEjkcpSPFr+pQ7CiAI33
 99kAVMQEip/MwoTYvM9NXSMTpyRJ/asnLeqa0WU6l6Z9mQ41lLzPFBAJ21/ddT4xeBDv0dxM
 GqaH2C6bSnJkhSfSja9OxBe+F6LIAZgCFzlogbmSWmUdLBg+sh3K6aiBDAdZPUMvGHzHK3fj
 gHK4GqGCFK76bFrHQYgiBOrcR4GDklj4Gk9osIfdXIAkBvRGw8zg1zzUYwMYk+A6v40gBn00
 OOB13qJe9zyKpReWMAhg7BYPBKIm/qSr82aIQc4+FlDX2Ot6T/4tGUDr9MAHaBKFtVyIqXBO
 xOf0vQEokkUGRKWBE0uA3zFVRfLiT6NUjDQ0vdphTnsdA7h01MliZLQ2lLL2Mt5lsqU+6sup
 Tfql1omgEpjnFsPsyFebzcKGbdEr6vySGa3Cof+miX06hQXKe99a5+eHNhtZJcMAIO89wZmj
 7ayYJIXFqjl/X0KBcCbiAl4vbdBw1bqFnO4zd1lMXKVoa29UHqby4MPbQhjWNVv9kqp8A39+
 E9xw890l1xdERkjVKX6IEJu2hf7X3MMl9tOjBK6MvdOUxvh1bNNmXh7OlBL1MpJYY/ydIm3B
 KEmKjLDvB0pePJkdTw==
Message-ID: <cbcee243-0039-ae88-a306-f88fe27dd82c@linaro.org>
Date:   Fri, 20 Jul 2018 17:39:20 +0300
MIME-Version: 1.0
In-Reply-To: <CAE=gft6pPcxfYqEcb-yQpf7S6CDTZNavhqYaKi37962U78qO3Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Evan,

On 07/11/2018 01:34 AM, Evan Green wrote:
> On Mon, Jul 9, 2018 at 8:51 AM Georgi Djakov <georgi.djakov@linaro.org> wrote:
>>
>> On some Qualcomm SoCs, there is a remote processor, which controls some of
>> the Network-On-Chip interconnect resources. Other CPUs express their needs
>> by communicating with this processor. Add a driver to handle communication
>> with this remote processor.
>>
>> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
>> ---
>>  .../bindings/interconnect/qcom-smd.txt        | 32 +++++++
>>  drivers/interconnect/qcom/Kconfig             | 11 +++
>>  drivers/interconnect/qcom/Makefile            |  2 +
>>  drivers/interconnect/qcom/smd-rpm.c           | 91 +++++++++++++++++++
>>  drivers/interconnect/qcom/smd-rpm.h           | 15 +++
>>  5 files changed, 151 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/interconnect/qcom-smd.txt
>>  create mode 100644 drivers/interconnect/qcom/Kconfig
>>  create mode 100644 drivers/interconnect/qcom/Makefile
>>  create mode 100644 drivers/interconnect/qcom/smd-rpm.c
>>  create mode 100644 drivers/interconnect/qcom/smd-rpm.h
>>
>> diff --git a/Documentation/devicetree/bindings/interconnect/qcom-smd.txt b/Documentation/devicetree/bindings/interconnect/qcom-smd.txt
>> new file mode 100644
>> index 000000000000..88a5aeb50935
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/interconnect/qcom-smd.txt
>> @@ -0,0 +1,32 @@
>> +Qualcomm SMD-RPM interconnect driver binding
>> +------------------------------------------------
>> +The RPM (Resource Power Manager) is a dedicated hardware engine
>> +for managing the shared SoC resources in order to keep the lowest
>> +power profile. It communicates with other hardware subsystems via
>> +the shared memory driver (SMD) back-end and accepts requests for
>> +various resources.
>> +
>> +Required properties :
>> +- compatible : shall contain only one of the following:
>> +                       "qcom,interconnect-smd-rpm"
>> +
>> +Example:
>> +       smd {
>> +               compatible = "qcom,smd";
>> +
>> +               rpm {
>> +                       interrupts = <0 168 1>;
>> +                       qcom,ipc = <&apcs 8 0>;
>> +                       qcom,smd-edge = <15>;
>> +
>> +                       rpm_requests {
>> +                               compatible = "qcom,rpm-msm8916";
>> +                               qcom,smd-channels = "rpm_requests";
>> +
>> +                               interconnect-smd-rpm {
>> +                                       compatible = "qcom,interconnect-smd-rpm";
>> +                               };
>> +
>> +                       };
>> +               };
>> +       };
>> diff --git a/drivers/interconnect/qcom/Kconfig b/drivers/interconnect/qcom/Kconfig
>> new file mode 100644
>> index 000000000000..b0c2ff928d88
>> --- /dev/null
>> +++ b/drivers/interconnect/qcom/Kconfig
>> @@ -0,0 +1,11 @@
>> +config INTERCONNECT_QCOM
>> +       bool "Qualcomm Network-on-Chip interconnect drivers"
>> +       depends on INTERCONNECT
>> +       depends on ARCH_QCOM || COMPILE_TEST
>> +
>> +config INTERCONNECT_QCOM_SMD_RPM
>> +       tristate "Qualcomm SMD RPM interconnect driver"
>> +       depends on INTERCONNECT_QCOM
> 
> Should this also depend on CONFIG_QCOM_SMD_RPM, since it uses
> qcom_rpm_smd_write?

Yes, you are right.

>> +       help
>> +         This is a driver for communicating interconnect related configuration
>> +         details with a remote processor (RPM) on Qualcomm platforms.
> ...
>> diff --git a/drivers/interconnect/qcom/smd-rpm.h b/drivers/interconnect/qcom/smd-rpm.h
>> new file mode 100644
>> index 000000000000..c33b91a3dd51
>> --- /dev/null
>> +++ b/drivers/interconnect/qcom/smd-rpm.h
>> @@ -0,0 +1,15 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * Copyright (c) 2018, Linaro Ltd.
>> + * Author: Georgi Djakov <georgi.djakov@linaro.org>
>> + */
>> +
>> +#ifndef __DRIVERS_INTERCONNECT_QCOM_RPM_H
>> +#define __DRIVERS_INTERCONNECT_QCOM_RPM_H
> 
> Nit: this still doesn't quite match, it would need an _SMD like:
> __DRIVERS_INTERCONNECT_QCOM_SMD_RPM_H
> 

Ok, thanks!

Georgi
