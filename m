Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9A1FC5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 07:53:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CDDA20864
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 07:53:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="HVlqOi4A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CDDA20864
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932860AbeFRHx0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 03:53:26 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:39232 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932524AbeFRHxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 03:53:24 -0400
Received: by mail-ot0-f195.google.com with SMTP id l15-v6so17446407oth.6
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 00:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=nhZycJGVyrXIzxkjWQ4ltxWSdLV2UeWVBP21LEJXP+8=;
        b=HVlqOi4AS5qaVTWmhlRyuxgKjQkiujCFvaGiSnDYTH+KlZnAQHNmMozkgrvQlPu/oH
         BnJd0KwWX8kB5NCV3oZtQa/K7Lsxe2uKEqfIOrwfH/CJAB8r32Dl9M9e/nqqWUlB8zts
         nV4BtulpSQhaapkBURA5rpZpyNL//FAoUqmW8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=nhZycJGVyrXIzxkjWQ4ltxWSdLV2UeWVBP21LEJXP+8=;
        b=Qro2ekywvzjBH+wIxaKCDqGVJoC6Hdr1fItTRuHq6MsazO1izg6gmHjtfETt1VnaeL
         npzmRHUPJQDsnUI5v6uFf3hcpRV26cjZwjuu3s0Wzd67WGY2r9+JNavOHRCTPGxRmcbW
         zHWvxSaMonb7+ztHqKBCaClNXgOTXe5WLkEyq0w643wjdjr1qGhyGV8yR+nyvAuvSEUQ
         5CeaABYYGdM7yyryapRx/KlkVfAq/dOPALepHHCEuGNa7IvOT/W7ED9CST9AM4QxznEG
         beKVgxm9Jgm34qtjUISQasg33tLPMlkyxSG6+GBoTPOaKlRUPmnGLeDODin4RyeT3AWS
         M+xQ==
X-Gm-Message-State: APt69E28u7fxO2Hc+9dbjPffvWZoh7rYjK0CIqS7xIpjGDtsZllzSRtW
        XLqe8CDx4amHO63jnW9Nk/fuFQeBKXTJ/Z7l6ezMfQ==
X-Google-Smtp-Source: ADUXVKL99SaJgx67GKjR/fuEoiwNyue3mZI8aziSx2H7j91XKHdRCrHTwKVYx8W8wiS36D0/ePeEDnsR3IsOOavL18Q=
X-Received: by 2002:a9d:4894:: with SMTP id d20-v6mr7558092otf.399.1529308403515;
 Mon, 18 Jun 2018 00:53:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:4044:0:0:0:0:0 with HTTP; Mon, 18 Jun 2018 00:53:22
 -0700 (PDT)
In-Reply-To: <CABe79T7gGJ1mcBV4W9nFy1ZyBL4sFpB+DFJjgpLgOtRJGjJbpw@mail.gmail.com>
References: <1527486084-4636-1-git-send-email-srinath.mannam@broadcom.com>
 <1527486084-4636-2-git-send-email-srinath.mannam@broadcom.com>
 <20180531164820.GA23074@rob-hp-laptop> <CABe79T7=LK=PgaftQeCRE8kmMMztFBNeJ4cdnZhv8ULDO=6+Jw@mail.gmail.com>
 <CAL_JsqJsGouQjWAu01fR4LpwanKbSj1d_CvyPXyMBe2vVBHqdw@mail.gmail.com> <CABe79T7gGJ1mcBV4W9nFy1ZyBL4sFpB+DFJjgpLgOtRJGjJbpw@mail.gmail.com>
From:   Srinath Mannam <srinath.mannam@broadcom.com>
Date:   Mon, 18 Jun 2018 13:23:22 +0530
Message-ID: <CABe79T5Mk+40860kXhnMaB6j5wV3ALRfVxe2ZTQRjJyBs38M5g@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: thermal: Add binding document for SR thermal
To:     Rob Herring <robh@kernel.org>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Pramod Kumar <pramod.kumar@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Please let me know if you have any comments to this patch.
If not can you please accept this patch.

Regards,
Srinath.

On Mon, Jun 4, 2018 at 11:36 AM, Srinath Mannam
<srinath.mannam@broadcom.com> wrote:
> Hi Rob Herring,
>
> Please find my comments in line..
>
> On Fri, Jun 1, 2018 at 7:59 PM, Rob Herring <robh@kernel.org> wrote:
>> On Fri, Jun 1, 2018 at 3:51 AM, Srinath Mannam
>> <srinath.mannam@broadcom.com> wrote:
>>> Hi Rob Herring,
>>>
>>> Thank you for the review.
>>> Please find my answers inline..
>>>
>>> On Thu, May 31, 2018 at 10:18 PM, Rob Herring <robh@kernel.org> wrote:
>>>> On Mon, May 28, 2018 at 11:11:22AM +0530, Srinath Mannam wrote:
>>>>> From: Pramod Kumar <pramod.kumar@broadcom.com>
>>>>>
>>>>> Add binding document for supported thermal implementation
>>>>> in Stingray.
>>>>>
>>>>> Signed-off-by: Pramod Kumar <pramod.kumar@broadcom.com>
>>>>> Reviewed-by: Ray Jui <ray.jui@broadcom.com>
>>>>> Reviewed-by: Scott Branden <scott.branden@broadcom.com>
>>>>> Reviewed-by: Srinath Mannam <srinath.mannam@broadcom.com>
>>>>> ---
>>>>>  .../bindings/thermal/brcm,sr-thermal.txt           | 45 ++++++++++++++++++++++
>>>>>  1 file changed, 45 insertions(+)
>>>>>  create mode 100644 Documentation/devicetree/bindings/thermal/brcm,sr-thermal.txt
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/thermal/brcm,sr-thermal.txt b/Documentation/devicetree/bindings/thermal/brcm,sr-thermal.txt
>>>>> new file mode 100644
>>>>> index 0000000..33f9e11
>>>>> --- /dev/null
>>>>> +++ b/Documentation/devicetree/bindings/thermal/brcm,sr-thermal.txt
>>>>> @@ -0,0 +1,45 @@
>>>>> +* Broadcom Stingray Thermal
>>>>> +
>>>>> +This binding describes thermal sensors that is part of Stingray SoCs.
>>>>> +
>>>>> +Required properties:
>>>>> +- compatible : Must be "brcm,sr-thermal"
>>>>> +- reg : memory where tmon data will be available.
>>>>
>>>> What type of memory is this?
>>> This is shared memory(cache-able) which is shared between two micro controllers.
>>
>> What else is in this shared memory? You should probably be
>> representing that as a whole somewhere in DT.
> Nothing else except 4 byte memory containing temperature value of one
> thermal zone.
> At present we configured 6 thermal zones. So six separate 4byte
> memories provided in
> shared memory.
>>
>>> One micro controller update temperature of all thermal zones in this
>>> shared memory.
>>> thermal driver running on another micro controller monitors
>>> temperature data of all thermal zones.
>>>>
>>>>> +
>>>>> +Example:
>>>>> +     tmons {
>>>>> +             compatible = "simple-bus";
>>>>> +             #address-cells = <1>;
>>>>> +             #size-cells = <1>;
>>>>> +             ranges;
>>>>> +
>>>>> +             tmon_ihost0: thermal@8f100000 {
>>>>> +                     compatible = "brcm,sr-thermal";
>>>>> +                     reg = <0x8f100000 0x4>;
>>>>> +             };
>>>>
>>>> Convince me that you need a node per register. This can all be
>>>> accomplished with a single node and either a single reg entry or a
>>>> series of reg entries.
>>>>
>>> In our system we have 6 different thermal zones. each node belongs to
>>> one thermal zone.
>>> thermal driver detects each node as separate thermal zone and monitors
>>> separately.
>>> register entry is only 4byte memory which contains the temperature
>>> value of respective thermal zone.
>>> Based on requirement we can increase or decrease the number thermal
>>> zones need to monitor.
>>
>> Still, all this can be accomplished with a single node. Having a node
>> per register in DT doesn't scale.
> Our approach is like we have individual controllers have one driver
> with multiple DT nodes.
> In coming future we will add more thermal zones based on our
> requirement. then we can just
> add new DT node, instead of having driver changes.
> With this approach we can configure each thermal zone at different trip values.
> So we must have all thermal zones are independent.
>>
>> Rob
