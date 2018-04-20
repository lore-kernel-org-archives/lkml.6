Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752609AbeDTVAd (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 17:00:33 -0400
Received: from mail-pl0-f50.google.com ([209.85.160.50]:36483 "EHLO
        mail-pl0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751227AbeDTVAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 17:00:31 -0400
X-Google-Smtp-Source: AIpwx49ILLIVgID/Ms6Ggn6CON7l3E3O7i0a+ajlJ/WlHj79fR0FKWVAGiEiyCdbQSjaxp0XOfP8Qw==
Subject: Re: [RFC PATCH] dt-bindings: add a jsonschema binding example
To: Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        devicetree-spec@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: grant.likely@arm.com, mark.rutland@arm.com,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Mark Brown <broonie@kernel.org>, shawnguo@kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Stephen Boyd <sboyd@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>
References: <20180418222905.10414-1-robh@kernel.org>
From: Frank Rowand <frowand.list@gmail.com>
Message-ID: <e7a2f4ca-40c2-05ef-097c-2cecd31fb731@gmail.com>
Date: Fri, 20 Apr 2018 14:00:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180418222905.10414-1-robh@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Thanks for the example.  It was a good starting tutorial of sorts for me
to understand the format a bit.


On 04/18/18 15:29, Rob Herring wrote:
> The current DT binding documentation format of freeform text is painful
> to write, review, validate and maintain.
> 
> This is just an example of what a binding in the schema format looks
> like. It's using jsonschema vocabulary in a YAML encoded document. Using
> jsonschema gives us access to existing tooling. A YAML encoding gives us
> something easy to edit.
> 
> This example is just the tip of the iceberg, but it the part most
> developers writing bindings will interact with. Backing all this up
> are meta-schema (to validate the binding schemas), some DT core schema,
> YAML encoded DT output with dtc, and a small number of python scripts to
> run validation. The gory details including how to run end-to-end
> validation can be found here:
> 
> https://www.spinics.net/lists/devicetree-spec/msg00649.html
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> Cc list,
> You all review and/or write lots of binding documents. I'd like some feedback
> on the format.
> 
> Thanks,
> Rob
> 
>  .../devicetree/bindings/example-schema.yaml        | 149 +++++++++++++++++++++
>  1 file changed, 149 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/example-schema.yaml
> 
> diff --git a/Documentation/devicetree/bindings/example-schema.yaml b/Documentation/devicetree/bindings/example-schema.yaml
> new file mode 100644
> index 000000000000..fe0a3bd1668e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/example-schema.yaml

I'm guessing by the path name that this is in the Linux kernel source tree.


> @@ -0,0 +1,149 @@
> +# SPDX-License-Identifier: BSD-2-Clause

If in the Linux kernel source tree, then allow gpl-v2 as a possible license.


> +# Copyright 2018 Linaro Ltd.
> +%YAML 1.2
> +---
> +# All the top-level keys are standard json-schema keywords except for
> +# 'maintainers' and 'select'
> +
> +# $id is a unique idenifier based on the filename

                     ^^^^^^^^^  identifier

> +$id: "http://devicetree.org/schemas/example-schema.yaml#"

Does this imply that all schemas will be at devicetree.org instead
of in the Linux kernel source tree?  This would be counter to my
earlier guess about where this patch is applied.


> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"

How is $schema used?  Is it accessed across the network?

> +
> +# Only 1 version supported for now
> +version: 1
> +
> +title: An example schema annotated with jsonschema details
> +
> +maintainers:
> +  - Rob Herring <robh@kernel.org>
> +
> +description: |
> +  A more detailed multi-line description of the binding.
> +
> +  Details about the hardware device and any links to datasheets can go here.
> +
> +  The end of the description is marked by indentation less than the first line
> +  in the description.
> +
> +select: false
> +  # 'select' is a schema applied to a DT node to determine if this binding
> +  # schema should be applied to the node. It is optional and by default the
> +  # possible compatible strings are extracted and used to match.

My first reaction was that 'node' should somehow be included in the name
of 'select'.  But my second thought was that maybe 'node' is implied,
because every schema file describes a single node???  This is where my
lack of knowledge kicks in - I'll go read stuff in your yaml-bindings
repo to get a better background...


> +
> +properties:
> +  # A dictionary of DT properties for this binding schema
> +  compatible:
> +    # More complicated schema can use oneOf (XOR), anyOf (OR), or allOf (AND)
> +    # to handle different conditions.
> +    # In this case, it's needed to handle a variable number of values as there
> +    # isn't another way to express a constraint of the last string value.
> +    # The boolean schema must be a list of schemas.
> +    oneOf:
> +      - items:
> +          # items is a list of possible values for the property. The number of
> +          # values is determined by the number of elements in the list.
> +          # Order in lists is significant, order in dicts is not
> +          # Must be one of the 1st enums followed by the 2nd enum
> +          #
> +          # Each element in items should be 'enum' or 'const'
> +          - enum:
> +              - vendor,soc4-ip
> +              - vendor,soc3-ip
> +              - vendor,soc2-ip
> +          - enum:
> +              - vendor,soc1-ip
> +        # additionalItems being false is implied
> +        # minItems/maxItems equal to 2 is implied
> +      - items:
> +          # 'const' is just a special case of an enum with a single possible value
> +          - const: vendor,soc1-ip

I'm using this as an example of a concept, not to pick on this one specific
instance.

One of my concerns with YAML has been the rich, flexible syntax available.  To
a YAML expert, this is a very useful feature.  To someone who does not use YAML
and will not use it for anything other than binding schemas, this adds more
complexity.

What I have heard some people say in the validation discussions is that the
allowed YAML syntax for binding schemas would be limited to one (or a very
small number) of the possible YAML alternative syntaxes for use in the
bindings.  Will there be a document describing such a limitation on
alternate syntaxes?

(This example file provides a good example of a single syntax style, but does
not preclude other equivalent syntax.)

Getting back to the specific example of 'const', it is a less verbose way of
specifying a single value enum, and I think it looks cleaner and more
readable.  But it is also a case of adding more complexity for someone who
does not otherwise use YAML.  I would using the more verbose syntax of
enum even for a single possible value.


> +
> +  reg:
> +    # The description of each element defines the order and implicitly defines
> +    # the number of reg entries
> +    items:
> +      - description: core registers
> +      - description: aux registers
> +    # minItems/maxItems equal to 2 is implied
> +
> +  reg-names:
> +    # The core schema enforces this is a string array
> +    items:
> +      - const: core
> +      - const: aux
> +
> +  clocks:
> +    # Only a single entry, so just need to set the max number of items.

       # More restrictions are provided in meta-schemas/clocks.yaml


> +    maxItems: 1
> +
> +  clock-names:
> +    items:
> +      - const: bus
> +
> +  interrupts:
> +    # Either 1 or 2 interrupts can be present
> +    minItems: 1
> +    maxItems: 2
> +    items:
> +      - description: tx or combined interrupt
> +      - description: rx interrupt
> +
> +    description: |
> +      A variable number of interrupts warrants a description of what conditions
> +      affect the number of interrupts. Otherwise, descriptions on standard
> +      properties are not necessary.
> +
> +  interrupt-names:
> +    # minItems must be specified here because the default would be 2
> +    minItems: 1

Why the difference between the interrupts property and the interrupt-names
property (specifying maxItems for interrupt, but not interrupt-names)?

Others have already commented on a desire to have a way to specify that
number of interrupts should match number of interrupt-names.


> +    items:
> +      - const: "tx irq"
> +      - const: "rx irq"
> +
> +  # Property names starting with '#' must be quoted
> +  '#interrupt-cells':
> +    # A simple case where the value must always be '2'.
> +    # The core schema handles that this must be a single integer.
> +    const: 2
> +
> +  interrupt-controller: {}
> +    # The core checks this is a boolean, so just have to list it here to be
> +    # valid for this binding.
> +
> +  clock-frequency:
> +    # The type is set in the core schema. Per device schema only need to set
> +    # constraints on the possible values.
> +    minimum: 100
> +    maximum: 400000
> +    # The value that should be used if the property is not present
> +    default: 200

This is confusing to me.  (Beyond the discussion of this in Stephen Boyd's
reply...)  My naive reading of this is that the default is the value that
the driver should implement if the property is missing, which is unrelated
to the concept of validating a dts file.


> +
> +  foo-gpios:
> +    maxItems: 1
> +    description: A connection of the 'foo' gpio line.
> +
> +  vendor,int-property:
> +    description: Vendor specific properties must have a description
> +    type: integer # A type is also required
> +    enum: [2, 4, 6, 8, 10]
> +
> +  vendor,bool-property:
> +    description: Vendor specific properties must have a description
> +    type: boolean
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - interrupt-controller
> +
> +examples:
> +  - |
> +    /{
> +          compatible = "vendor,soc4-ip", "vendor,soc1-ip";
> +          reg = <0x1000 0x80>,
> +                <0x3000 0x80>;
> +          reg-names = "core", "aux";
> +          interrupts = <10>;
> +          interrupt-controller;
> +    };
> --
> 2.14.1
> 
