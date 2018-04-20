Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751182AbeDTSr1 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 14:47:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:44584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750745AbeDTSrZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 14:47:25 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BE7F217D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=robh@kernel.org
X-Google-Smtp-Source: AB8JxZoo+IQ3IB+GElL1DamW7/ZbuAgR8oB9lr5goDvo35deOBQp3Ykbj0SALITCgZ66TGb8aVUbx62Jb7kjsqwwkrM=
MIME-Version: 1.0
In-Reply-To: <20180420165921.GD22369@sirena.org.uk>
References: <20180418222905.10414-1-robh@kernel.org> <20180420165921.GD22369@sirena.org.uk>
From: Rob Herring <robh@kernel.org>
Date: Fri, 20 Apr 2018 13:47:03 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+ZB-afhtDqq333qG9fs060WX8jkEqWmgOJyJVtztL2XA@mail.gmail.com>
Message-ID: <CAL_Jsq+ZB-afhtDqq333qG9fs060WX8jkEqWmgOJyJVtztL2XA@mail.gmail.com>
Subject: Re: [RFC PATCH] dt-bindings: add a jsonschema binding example
To: Mark Brown <broonie@kernel.org>
Cc: devicetree@vger.kernel.org, devicetree-spec@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Grant Likely <grant.likely@arm.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Stephen Boyd <sboyd@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 20, 2018 at 11:59 AM, Mark Brown <broonie@kernel.org> wrote:
> On Wed, Apr 18, 2018 at 05:29:05PM -0500, Rob Herring wrote:
>> The current DT binding documentation format of freeform text is painful
>> to write, review, validate and maintain.
>>
>> This is just an example of what a binding in the schema format looks
>> like. It's using jsonschema vocabulary in a YAML encoded document. Using
>> jsonschema gives us access to existing tooling. A YAML encoding gives us
>> something easy to edit.
>
> It'd be useful to see some examples of how things like including by
> reference other schema work.  It feels like something we should be able
> to use more in a schema based thing but perhaps that's not viable with
> realistic tooling.  In general this looks OK, especially with all the
> meta comments about the language stripped out.

There are several examples in the meta-schema and some of the core
schema as references are used there quite a bit. It gets quite fun to
follow with recursion. :)

I think the need for references in device bindings should be pretty
minimal. We'd probably mainly need references for some vendor specific
properties which will need to reference some of our compound types. So
we'd have something like this:

vendor,a-string-array-prop:
  $ref: "dt-core.yaml#/definitions/proptypes/stringarray"

For common bindings, we don't have to reference them in device
bindings (which should save lots of boilerplate). We can select and
apply them based on presence of properties and that happens
independent of the device binding. The device binding only needs
define what the common binding cannot which is typically how many
elements and what are they.

>
>> +    description: |
>> +      A variable number of interrupts warrants a description of what conditions
>
> Like Stephen said the | looks odd.

That's just how literal blocks in yaml are done.

>> +  interrupt-names:
>> +    # minItems must be specified here because the default would be 2
>> +    minItems: 1
>> +    items:
>> +      - const: "tx irq"
>> +      - const: "rx irq"
>
> Any way to relate this to the interrupts property in the schema
> language (eg, must have the less or equal number of elements)?

I've wanted something like that, but there isn't any way that I've
come up with. Generally, the "jsonschema way" is each schema is
supposed to be independent of each other. There's some discussion
about adding data dependent schema which might help in this case.

>
>> +  # Property names starting with '#' must be quoted
>
> That's awkward :/  Perhaps just by convention quote all property names
> for simplicity?

Yes, perhaps we should. I have a formatting tool, I'll look into
whether i can make it do that.

Thanks for taking a look.

Rob
