Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752192AbeDTTxQ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 15:53:16 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:45135 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751092AbeDTTxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 15:53:13 -0400
X-Google-Smtp-Source: AIpwx4/BSt1sCWxEePsdkXiXA+gE3cVHtMCkQmLz/NcBNmi880heQFKJdaaSSWBeXi72Sa/3zhxX6w==
Subject: Re: [RFC PATCH] dt-bindings: add a jsonschema binding example
To: Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>
Cc: devicetree-spec@vger.kernel.org, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Grant Likely <grant.likely@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Mark Brown <broonie@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Jonathan Cameron <jic23@kernel.org>
References: <20180418222905.10414-1-robh@kernel.org>
 <152424282214.46528.2511757264045171935@swboyd.mtv.corp.google.com>
 <CAL_Jsq+1G61+E0wtVEkzann3Z=2Cr=2PkbDJ_OuaA5GysWZsXQ@mail.gmail.com>
From: Frank Rowand <frowand.list@gmail.com>
Message-ID: <de8cf071-2280-45fb-c41a-feb1f039d68b@gmail.com>
Date: Fri, 20 Apr 2018 12:53:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAL_Jsq+1G61+E0wtVEkzann3Z=2Cr=2PkbDJ_OuaA5GysWZsXQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/20/18 11:15, Rob Herring wrote:
> On Fri, Apr 20, 2018 at 11:47 AM, Stephen Boyd <sboyd@kernel.org> wrote:
>> Quoting Rob Herring (2018-04-18 15:29:05)
>>> diff --git a/Documentation/devicetree/bindings/example-schema.yaml b/Documentation/devicetree/bindings/example-schema.yaml
>>> new file mode 100644
>>> index 000000000000..fe0a3bd1668e
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/example-schema.yaml
>>> @@ -0,0 +1,149 @@
>>> +# SPDX-License-Identifier: BSD-2-Clause
>>> +# Copyright 2018 Linaro Ltd.
>>> +%YAML 1.2
>>> +---
>>> +# All the top-level keys are standard json-schema keywords except for
>>> +# 'maintainers' and 'select'
>>> +
>>> +# $id is a unique idenifier based on the filename
>>> +$id: "http://devicetree.org/schemas/example-schema.yaml#"
>>> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
>>> +
>>> +# Only 1 version supported for now
>>> +version: 1
>>> +
>>> +title: An example schema annotated with jsonschema details
>>> +
>>> +maintainers:
>>> +  - Rob Herring <robh@kernel.org>
>>> +
>>> +description: |
>>> +  A more detailed multi-line description of the binding.
>>> +
>>> +  Details about the hardware device and any links to datasheets can go here.
>>> +
>>> +  The end of the description is marked by indentation less than the first line
>>> +  in the description.
>>> +
>>> +select: false
>>> +  # 'select' is a schema applied to a DT node to determine if this binding
>>> +  # schema should be applied to the node. It is optional and by default the
>>> +  # possible compatible strings are extracted and used to match.
>>
>> Can we get a concrete example here?
> 
> select: true
> 
> :) Which is apply to every node.
> 
> A better one is from the memory node schema ('$nodename' gets added :
> 
> select:
>   required: ["$nodename"]
>   properties:
>     $nodename:
>       oneOf:
>         - pattern: "^memory@[0-9a-f]*"
>         - const: "memory" # 'memory' only allowed for selecting
> 
> 
> I expect the vast majority of device bindings will not use select at
> all and rely on compatible string matching.
> 
>>> +
>>> +properties:
>> [...]
>>> +
>>> +  interrupts:
>>> +    # Either 1 or 2 interrupts can be present
>>> +    minItems: 1
>>> +    maxItems: 2
>>> +    items:
>>> +      - description: tx or combined interrupt
>>> +      - description: rx interrupt
>>> +
>>> +    description: |
>>
>> The '|' is needed to make yaml happy?
> 
> Yes, this is simply how you do literal text blocks in yaml.
> 
> We don't really need for this one really, but for the top-level
> 'description' we do. The long term intent is 'description' would be
> written in sphinx/rst and can be extracted into the DT spec (for
> common bindings). Grant has experimented with that some.
> 
>>> +      A variable number of interrupts warrants a description of what conditions
>>> +      affect the number of interrupts. Otherwise, descriptions on standard
>>> +      properties are not necessary.
>>> +
>>> +  interrupt-names:
>>> +    # minItems must be specified here because the default would be 2
>>> +    minItems: 1
>>> +    items:
>>> +      - const: "tx irq"
>>> +      - const: "rx irq"
>>> +
>>> +  # Property names starting with '#' must be quoted
>>> +  '#interrupt-cells':
>>> +    # A simple case where the value must always be '2'.
>>> +    # The core schema handles that this must be a single integer.
>>> +    const: 2
>>> +
>>> +  interrupt-controller: {}
>>
>> Does '{}' mean nothing to see here?
> 
> Yes. It's just an empty schema that's always valid.
> 
>>> +    # The core checks this is a boolean, so just have to list it here to be
>>> +    # valid for this binding.
>>> +
>>> +  clock-frequency:
>>> +    # The type is set in the core schema. Per device schema only need to set
>>> +    # constraints on the possible values.
>>> +    minimum: 100
>>> +    maximum: 400000
>>> +    # The value that should be used if the property is not present
>>> +    default: 200
>>> +
>>
>> The 'default' field is neat. I look forward to the compiler using the
>> schema to insert defaults into the dtb if the properties aren't present
>> in the input file.
> 
> That wasn't really my intention, but it's what the OS should use if
> property is not present. But at least for required properties, we
> could certainly do as you suggest.

I understand the thought of 'neat', but it would also add yet one more
layer to the "how did this property get into my dtb?" stew.

But more importantly, if this becomes a required part of the kernel
build process, is it adding a new required tool (python)?  (Or is
python already required?)  There is resistance to adding new tools.

-Frank


>>> +  foo-gpios:
>>> +    maxItems: 1
>>> +    description: A connection of the 'foo' gpio line.
>>> +
>>> +  vendor,int-property:
>>> +    description: Vendor specific properties must have a description
>>> +    type: integer # A type is also required
>>> +    enum: [2, 4, 6, 8, 10]
>>> +
>>> +  vendor,bool-property:
>>> +    description: Vendor specific properties must have a description
>>> +    type: boolean
>>> +
>>> +required:
>>> +  - compatible
>>> +  - reg
>>> +  - interrupts
>>> +  - interrupt-controller
>>
>> Can the required or optional parts go under each property instead of
>> having a different section?
> 
> No, because then it is not json-schema language.
> 
>> Or does that make the schema parser
>> difficult to implement?
> 
> Yes, because then we have to implement a schema parser.
> 
>> It may also make sense to negate this and
>> specify only the optional properties, or to require both optional and
>> required lists to make things more explicit at the cost of some
>> verbosity.
>>
>>> +
>>> +examples:
>>> +  - |
>>> +    /{
>>
>> Is the first slash required here?
> 
> No, just leftover from being the root node in the example.
> 
> 
> Thanks for taking a look.
> 
>>> +          compatible = "vendor,soc4-ip", "vendor,soc1-ip";
>>> +          reg = <0x1000 0x80>,
>>> +                <0x3000 0x80>;
>>> +          reg-names = "core", "aux";
>>> +          interrupts = <10>;
>>> +          interrupt-controller;
>>> +    };
> 
