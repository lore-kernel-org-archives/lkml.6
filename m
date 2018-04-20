Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752273AbeDTQrI convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 12:47:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:35218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750841AbeDTQrG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 12:47:06 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D40AF2178F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sboyd@kernel.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To: Rob Herring <robh@kernel.org>, devicetree-spec@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20180418222905.10414-1-robh@kernel.org>
Cc: grant.likely@arm.com, frowand.list@gmail.com, mark.rutland@arm.com,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Mark Brown <broonie@kernel.org>, shawnguo@kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Jonathan Cameron <jic23@kernel.org>
References: <20180418222905.10414-1-robh@kernel.org>
Message-ID: <152424282214.46528.2511757264045171935@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [RFC PATCH] dt-bindings: add a jsonschema binding example
Date: Fri, 20 Apr 2018 09:47:02 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rob Herring (2018-04-18 15:29:05)
> diff --git a/Documentation/devicetree/bindings/example-schema.yaml b/Documentation/devicetree/bindings/example-schema.yaml
> new file mode 100644
> index 000000000000..fe0a3bd1668e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/example-schema.yaml
> @@ -0,0 +1,149 @@
> +# SPDX-License-Identifier: BSD-2-Clause
> +# Copyright 2018 Linaro Ltd.
> +%YAML 1.2
> +---
> +# All the top-level keys are standard json-schema keywords except for
> +# 'maintainers' and 'select'
> +
> +# $id is a unique idenifier based on the filename
> +$id: "http://devicetree.org/schemas/example-schema.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
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

Can we get a concrete example here?

> +
> +properties:
[...]
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

The '|' is needed to make yaml happy?

> +      A variable number of interrupts warrants a description of what conditions
> +      affect the number of interrupts. Otherwise, descriptions on standard
> +      properties are not necessary.
> +
> +  interrupt-names:
> +    # minItems must be specified here because the default would be 2
> +    minItems: 1
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

Does '{}' mean nothing to see here?

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
> +

The 'default' field is neat. I look forward to the compiler using the
schema to insert defaults into the dtb if the properties aren't present
in the input file.

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

Can the required or optional parts go under each property instead of
having a different section? Or does that make the schema parser
difficult to implement? It may also make sense to negate this and
specify only the optional properties, or to require both optional and
required lists to make things more explicit at the cost of some
verbosity.

> +
> +examples:
> +  - |
> +    /{

Is the first slash required here?

> +          compatible = "vendor,soc4-ip", "vendor,soc1-ip";
> +          reg = <0x1000 0x80>,
> +                <0x3000 0x80>;
> +          reg-names = "core", "aux";
> +          interrupts = <10>;
> +          interrupt-controller;
> +    };
