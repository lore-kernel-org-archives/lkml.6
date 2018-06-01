Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752198AbeFAO30 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 10:29:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:51272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751706AbeFAO3Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 10:29:24 -0400
X-Google-Smtp-Source: ADUXVKJ/js5HIuwnc0CN5wPZp+XemHd8axsvu2r8pKqCWrKpV63CWo8ORk5UBFfVbjG0eXVGuP2ggXEZSNr/CQRh4Io=
MIME-Version: 1.0
In-Reply-To: <CABe79T7=LK=PgaftQeCRE8kmMMztFBNeJ4cdnZhv8ULDO=6+Jw@mail.gmail.com>
References: <1527486084-4636-1-git-send-email-srinath.mannam@broadcom.com>
 <1527486084-4636-2-git-send-email-srinath.mannam@broadcom.com>
 <20180531164820.GA23074@rob-hp-laptop> <CABe79T7=LK=PgaftQeCRE8kmMMztFBNeJ4cdnZhv8ULDO=6+Jw@mail.gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Fri, 1 Jun 2018 09:29:02 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJsGouQjWAu01fR4LpwanKbSj1d_CvyPXyMBe2vVBHqdw@mail.gmail.com>
Message-ID: <CAL_JsqJsGouQjWAu01fR4LpwanKbSj1d_CvyPXyMBe2vVBHqdw@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: thermal: Add binding document for SR thermal
To: Srinath Mannam <srinath.mannam@broadcom.com>
Cc: Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Pramod Kumar <pramod.kumar@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 1, 2018 at 3:51 AM, Srinath Mannam
<srinath.mannam@broadcom.com> wrote:
> Hi Rob Herring,
>
> Thank you for the review.
> Please find my answers inline..
>
> On Thu, May 31, 2018 at 10:18 PM, Rob Herring <robh@kernel.org> wrote:
>> On Mon, May 28, 2018 at 11:11:22AM +0530, Srinath Mannam wrote:
>>> From: Pramod Kumar <pramod.kumar@broadcom.com>
>>>
>>> Add binding document for supported thermal implementation
>>> in Stingray.
>>>
>>> Signed-off-by: Pramod Kumar <pramod.kumar@broadcom.com>
>>> Reviewed-by: Ray Jui <ray.jui@broadcom.com>
>>> Reviewed-by: Scott Branden <scott.branden@broadcom.com>
>>> Reviewed-by: Srinath Mannam <srinath.mannam@broadcom.com>
>>> ---
>>>  .../bindings/thermal/brcm,sr-thermal.txt           | 45 ++++++++++++++++++++++
>>>  1 file changed, 45 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/thermal/brcm,sr-thermal.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/thermal/brcm,sr-thermal.txt b/Documentation/devicetree/bindings/thermal/brcm,sr-thermal.txt
>>> new file mode 100644
>>> index 0000000..33f9e11
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/thermal/brcm,sr-thermal.txt
>>> @@ -0,0 +1,45 @@
>>> +* Broadcom Stingray Thermal
>>> +
>>> +This binding describes thermal sensors that is part of Stingray SoCs.
>>> +
>>> +Required properties:
>>> +- compatible : Must be "brcm,sr-thermal"
>>> +- reg : memory where tmon data will be available.
>>
>> What type of memory is this?
> This is shared memory(cache-able) which is shared between two micro controllers.

What else is in this shared memory? You should probably be
representing that as a whole somewhere in DT.

> One micro controller update temperature of all thermal zones in this
> shared memory.
> thermal driver running on another micro controller monitors
> temperature data of all thermal zones.
>>
>>> +
>>> +Example:
>>> +     tmons {
>>> +             compatible = "simple-bus";
>>> +             #address-cells = <1>;
>>> +             #size-cells = <1>;
>>> +             ranges;
>>> +
>>> +             tmon_ihost0: thermal@8f100000 {
>>> +                     compatible = "brcm,sr-thermal";
>>> +                     reg = <0x8f100000 0x4>;
>>> +             };
>>
>> Convince me that you need a node per register. This can all be
>> accomplished with a single node and either a single reg entry or a
>> series of reg entries.
>>
> In our system we have 6 different thermal zones. each node belongs to
> one thermal zone.
> thermal driver detects each node as separate thermal zone and monitors
> separately.
> register entry is only 4byte memory which contains the temperature
> value of respective thermal zone.
> Based on requirement we can increase or decrease the number thermal
> zones need to monitor.

Still, all this can be accomplished with a single node. Having a node
per register in DT doesn't scale.

Rob
