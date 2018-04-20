Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752337AbeDTVr2 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 17:47:28 -0400
Received: from mail-oi0-f46.google.com ([209.85.218.46]:41031 "EHLO
        mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752192AbeDTVr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 17:47:26 -0400
X-Google-Smtp-Source: AIpwx4//XKMAAMjXNiKn3SCDeXj/Jv2OsrgDpJSIYpfia3ezyQ5fpMW/cFRYh0P2QgeBIGWQ/FvfTg==
Date: Fri, 20 Apr 2018 14:47:22 -0700
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org, devicetree-spec@vger.kernel.org,
        linux-kernel@vger.kernel.org, grant.likely@arm.com,
        frowand.list@gmail.com, mark.rutland@arm.com,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Mark Brown <broonie@kernel.org>, shawnguo@kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Stephen Boyd <sboyd@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>
Subject: Re: [RFC PATCH] dt-bindings: add a jsonschema binding example
Message-ID: <20180420214722.GA18510@minitux>
References: <20180418222905.10414-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180418222905.10414-1-robh@kernel.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 18 Apr 15:29 PDT 2018, Rob Herring wrote:

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

I really like the idea of formalizing the binding document format and
the ability of validating a dtb is really nice.

> Thanks,
> Rob
> 
>  .../devicetree/bindings/example-schema.yaml        | 149 +++++++++++++++++++++
>  1 file changed, 149 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/example-schema.yaml
> 
> diff --git a/Documentation/devicetree/bindings/example-schema.yaml b/Documentation/devicetree/bindings/example-schema.yaml
[..]
> +  reg:
> +    # The description of each element defines the order and implicitly defines
> +    # the number of reg entries
> +    items:
> +      - description: core registers
> +      - description: aux registers
> +    # minItems/maxItems equal to 2 is implied

I assume that a reg with variable number of entries would have
"description" for all of them and then a minItems that matches the
required ones and maxItems matching all of them?

> +
> +  reg-names:
> +    # The core schema enforces this is a string array
> +    items:
> +      - const: core
> +      - const: aux

I presume validation based on this should check that there's equal
number of entries in reg-names as there where in reg. Should this
relationship be described in the schema?

[..]
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

For validation purposes this could be interrupts with interrupt-parents
or a interrupts-extend, a fact that we probably don't want to duplicate
in every definition?

Perhaps we should just do like you did here and define the "interrupts"
and then in the validation tool - where we need to encode the logic
behind this anyways - we support the different variants.

> +
> +  interrupt-names:
> +    # minItems must be specified here because the default would be 2
> +    minItems: 1

As with reg-names, it would be good to have the validator warn if this
is not the same number of items as entries in "interrupts".

> +    items:
> +      - const: "tx irq"
> +      - const: "rx irq"
> +
> +  # Property names starting with '#' must be quoted
> +  '#interrupt-cells':
> +    # A simple case where the value must always be '2'.
> +    # The core schema handles that this must be a single integer.
> +    const: 2

If this is specified then interrupt-controller should also be given, or
vise versa. How would we describe that?

> +
> +  interrupt-controller: {}
> +    # The core checks this is a boolean, so just have to list it here to be
> +    # valid for this binding.
> +

Regards,
Bjorn
