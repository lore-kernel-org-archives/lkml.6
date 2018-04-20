Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752892AbeDTXls convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 19:41:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:46270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752703AbeDTXlq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 19:41:46 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B01B2168D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sboyd@kernel.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To: Rob Herring <robh@kernel.org>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <CAL_Jsq+1G61+E0wtVEkzann3Z=2Cr=2PkbDJ_OuaA5GysWZsXQ@mail.gmail.com>
Cc: devicetree-spec@vger.kernel.org, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Grant Likely <grant.likely@arm.com>,
        Frank Rowand <frowand.list@gmail.com>,
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
Message-ID: <152426770474.46528.1592920281091105196@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [RFC PATCH] dt-bindings: add a jsonschema binding example
Date: Fri, 20 Apr 2018 16:41:44 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rob Herring (2018-04-20 11:15:04)
> On Fri, Apr 20, 2018 at 11:47 AM, Stephen Boyd <sboyd@kernel.org> wrote:
> > Quoting Rob Herring (2018-04-18 15:29:05)
> >> diff --git a/Documentation/devicetree/bindings/example-schema.yaml b/Documentation/devicetree/bindings/example-schema.yaml
> >> new file mode 100644
> >> index 000000000000..fe0a3bd1668e
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/example-schema.yaml
> >> @@ -0,0 +1,149 @@
> >> +
> >> +  The end of the description is marked by indentation less than the first line
> >> +  in the description.
> >> +
> >> +select: false
> >> +  # 'select' is a schema applied to a DT node to determine if this binding
> >> +  # schema should be applied to the node. It is optional and by default the
> >> +  # possible compatible strings are extracted and used to match.
> >
> > Can we get a concrete example here?
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

Thanks! I was looking to see how the select syntax would work and this
shows one example nicely. I suppose another way would be to show how a
compatible string would be matched through select, even though it's
redundant.

Is there a way we can enforce node names through the schema too? For
example to enforce that a clock controller is called 'clock-controller'
or a spi master is called 'spi'.

> 
> >> +
> >> +properties:
> > [...]
> >> +
> >> +  interrupts:
> >> +    # Either 1 or 2 interrupts can be present
> >> +    minItems: 1
> >> +    maxItems: 2
> >> +    items:
> >> +      - description: tx or combined interrupt
> >> +      - description: rx interrupt
> >> +
> >> +    description: |
> >
> > The '|' is needed to make yaml happy?
> 
> Yes, this is simply how you do literal text blocks in yaml.
> 
> We don't really need for this one really, but for the top-level
> 'description' we do. The long term intent is 'description' would be
> written in sphinx/rst and can be extracted into the DT spec (for
> common bindings). Grant has experimented with that some.

Ok. That sounds cool. Then we could embed links to datasheets and SVGs
too.

> 
> >> +      A variable number of interrupts warrants a description of what conditions
> >> +      affect the number of interrupts. Otherwise, descriptions on standard
> >> +      properties are not necessary.
> >> +
> >> +  interrupt-names:
> >> +    # minItems must be specified here because the default would be 2
> >> +    minItems: 1
> >> +    items:
> >> +      - const: "tx irq"
> >> +      - const: "rx irq"
> >> +
> >> +  # Property names starting with '#' must be quoted
> >> +  '#interrupt-cells':
> >> +    # A simple case where the value must always be '2'.
> >> +    # The core schema handles that this must be a single integer.
> >> +    const: 2
> >> +
> >> +  interrupt-controller: {}
> >
> > Does '{}' mean nothing to see here?
> 
> Yes. It's just an empty schema that's always valid.

Could we include another schema to indicate that this is an interrupt
controller? I'm sort of asking for multi-schema inheritance.

> 
> >> +  foo-gpios:
> >> +    maxItems: 1
> >> +    description: A connection of the 'foo' gpio line.
> >> +
> >> +  vendor,int-property:
> >> +    description: Vendor specific properties must have a description
> >> +    type: integer # A type is also required
> >> +    enum: [2, 4, 6, 8, 10]
> >> +
> >> +  vendor,bool-property:
> >> +    description: Vendor specific properties must have a description
> >> +    type: boolean
> >> +
> >> +required:
> >> +  - compatible
> >> +  - reg
> >> +  - interrupts
> >> +  - interrupt-controller
> >
> > Can the required or optional parts go under each property instead of
> > having a different section?
> 
> No, because then it is not json-schema language.
> 
> > Or does that make the schema parser
> > difficult to implement?
> 
> Yes, because then we have to implement a schema parser.

:/
