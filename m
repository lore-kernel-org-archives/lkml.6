Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755920AbeDWQwS (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 12:52:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:39320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755817AbeDWQwP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 12:52:15 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6078D217D2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=robh@kernel.org
X-Google-Smtp-Source: AB8JxZpWH04vROn9D3xS+DqsiD6E/T640NRRJ13hrEG9iyoBs8U+73+hjX0N8TQYmun6Q03UFymz27OfXUeX8Dk6h+s=
MIME-Version: 1.0
In-Reply-To: <20180420214722.GA18510@minitux>
References: <20180418222905.10414-1-robh@kernel.org> <20180420214722.GA18510@minitux>
From: Rob Herring <robh@kernel.org>
Date: Mon, 23 Apr 2018 11:51:52 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJRGBmjEoaaiPTuqqN=H3oF+VJXz=pbmkQSTZJisPB40w@mail.gmail.com>
Message-ID: <CAL_JsqJRGBmjEoaaiPTuqqN=H3oF+VJXz=pbmkQSTZJisPB40w@mail.gmail.com>
Subject: Re: [RFC PATCH] dt-bindings: add a jsonschema binding example
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: devicetree@vger.kernel.org, devicetree-spec@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Grant Likely <grant.likely@arm.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Mark Brown <broonie@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Stephen Boyd <sboyd@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 20, 2018 at 4:47 PM, Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
> On Wed 18 Apr 15:29 PDT 2018, Rob Herring wrote:
>
>> The current DT binding documentation format of freeform text is painful
>> to write, review, validate and maintain.
>>
>> This is just an example of what a binding in the schema format looks
>> like. It's using jsonschema vocabulary in a YAML encoded document. Using
>> jsonschema gives us access to existing tooling. A YAML encoding gives us
>> something easy to edit.
>>
>> This example is just the tip of the iceberg, but it the part most
>> developers writing bindings will interact with. Backing all this up
>> are meta-schema (to validate the binding schemas), some DT core schema,
>> YAML encoded DT output with dtc, and a small number of python scripts to
>> run validation. The gory details including how to run end-to-end
>> validation can be found here:
>>
>> https://www.spinics.net/lists/devicetree-spec/msg00649.html
>>
>> Signed-off-by: Rob Herring <robh@kernel.org>
>> ---
>> Cc list,
>> You all review and/or write lots of binding documents. I'd like some feedback
>> on the format.
>>
>
> I really like the idea of formalizing the binding document format and
> the ability of validating a dtb is really nice.
>
>> Thanks,
>> Rob
>>
>>  .../devicetree/bindings/example-schema.yaml        | 149 +++++++++++++++++++++
>>  1 file changed, 149 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/example-schema.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/example-schema.yaml b/Documentation/devicetree/bindings/example-schema.yaml
> [..]
>> +  reg:
>> +    # The description of each element defines the order and implicitly defines
>> +    # the number of reg entries
>> +    items:
>> +      - description: core registers
>> +      - description: aux registers
>> +    # minItems/maxItems equal to 2 is implied
>
> I assume that a reg with variable number of entries would have
> "description" for all of them and then a minItems that matches the
> required ones and maxItems matching all of them?

You could do that, but it doesn't really enforce which compatible(s)
each size of reg is valid for. It would work okay when just the last N
entries are variable, but it will break down if you have cases where
essentially any subset is valid. For bindings with lots of conditional
sizes for reg, clocks, resets, etc. based on compatible strings, I
think we will need to split the binding into a schema per compatible.

IMO, things like this are probably not going to be addressed at the
start and may remain in the description (as we have today). I think we
need to start with a base schema and can improve them over time.

>> +
>> +  reg-names:
>> +    # The core schema enforces this is a string array
>> +    items:
>> +      - const: core
>> +      - const: aux
>
> I presume validation based on this should check that there's equal
> number of entries in reg-names as there where in reg. Should this
> relationship be described in the schema?

Yes, if we can figure out how. But I don't think it belongs in per
device schema as it is a core requirement.

>
> [..]
>> +  interrupts:
>> +    # Either 1 or 2 interrupts can be present
>> +    minItems: 1
>> +    maxItems: 2
>> +    items:
>> +      - description: tx or combined interrupt
>> +      - description: rx interrupt
>> +
>> +    description: |
>> +      A variable number of interrupts warrants a description of what conditions
>> +      affect the number of interrupts. Otherwise, descriptions on standard
>> +      properties are not necessary.
>
> For validation purposes this could be interrupts with interrupt-parents
> or a interrupts-extend, a fact that we probably don't want to duplicate
> in every definition?
>
> Perhaps we should just do like you did here and define the "interrupts"
> and then in the validation tool - where we need to encode the logic
> behind this anyways - we support the different variants.

Yes, essentially as we do now where the binding just describes
'interrupts' and 'interrupts-extended' is implicitly supported.

>> +
>> +  interrupt-names:
>> +    # minItems must be specified here because the default would be 2
>> +    minItems: 1
>
> As with reg-names, it would be good to have the validator warn if this
> is not the same number of items as entries in "interrupts".
>
>> +    items:
>> +      - const: "tx irq"
>> +      - const: "rx irq"
>> +
>> +  # Property names starting with '#' must be quoted
>> +  '#interrupt-cells':
>> +    # A simple case where the value must always be '2'.
>> +    # The core schema handles that this must be a single integer.
>> +    const: 2
>
> If this is specified then interrupt-controller should also be given, or
> vise versa. How would we describe that?

The core meta-schema can check that with 'dependencies'. Here's gpio
meta-schema for example:

dependencies:
  gpio-controller: ['#gpio-cells']
  '#gpio-cells': [gpio-controller]
  gpio-ranges: [gpio-controller]
  ngpios: [gpio-controller]


Rob
