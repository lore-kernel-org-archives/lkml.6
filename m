Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752200AbeEQVWx (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 17:22:53 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:41437 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751231AbeEQVWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 17:22:50 -0400
X-Google-Smtp-Source: AB8JxZrXh3150NGchErmaK0oG1wmKDPN/tgo3Bms4+/iuI7PwPABrQJNMy8Br8NQuPLfzAnesRED4wKnQbd7wZ5oJCk=
MIME-Version: 1.0
In-Reply-To: <41d5df73ddac772551d2966e0752bb0c357b1ded.1526088081.git.collinsd@codeaurora.org>
References: <cover.1526088081.git.collinsd@codeaurora.org> <41d5df73ddac772551d2966e0752bb0c357b1ded.1526088081.git.collinsd@codeaurora.org>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 17 May 2018 14:22:47 -0700
X-Google-Sender-Auth: fiELKMz6TC64gOeGPhbuWc1lqoE
Message-ID: <CAD=FV=XegPeFR8pdZM-YiBBJjrbej=C+2biBt4zJKnE90uTYZA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] regulator: dt-bindings: add QCOM RPMh regulator bindings
To: David Collins <collinsd@codeaurora.org>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, May 11, 2018 at 7:28 PM, David Collins <collinsd@codeaurora.org> wrote:
> +- qcom,regulator-initial-microvolt
> +       Usage:      optional; VRM regulators only
> +       Value type: <u32>
> +       Definition: Specifies the initial voltage in microvolts to request for a
> +                   VRM regulator.

Now that Mark has landed the patch adding support for the
-ENOTRECOVERABLE error code from get_voltage() / get_voltage_sel(), do
we still need the qcom,regulator-initial-microvolt property?  If this
is really still needed, can it be moved to the regulator core?


> +- regulator-initial-mode
> +       Usage:      optional; VRM regulators only
> +       Value type: <u32>
> +       Definition: Specifies the initial mode to request for a VRM regulator.
> +                   Supported values are RPMH_REGULATOR_MODE_* which are defined
> +                   in [1] (i.e. 0 to 3).  This property may be specified even
> +                   if the regulator-allow-set-load property is not specified.

Every time I read the above I wonder why you're documenting a standard
regulator regulator property in your bindings.  ...then I realize it's
because you're doing it because you want to explicitly document what
the valid modes are.  I wonder if it makes sense to just put a
reference somewhere else in this document to go look at the header
file where these are all nicely documented.

Speaking of documenting things like that, it might be worth finding
somewhere in this doc to mention that the "bob" regulator on PMI8998
can support "regulator-allow-bypass".  That tidbit got lost when we
moved to the standard regulator bindings for bypass.


> +- qcom,allowed-drms-modes
> +       Usage:      required if regulator-allow-set-load is specified;
> +                   VRM regulators only
> +       Value type: <prop-encoded-array>
> +       Definition: A list of integers specifying the PMIC regulator modes which
> +                   can be configured at runtime based upon consumer load needs.
> +                   Supported values are RPMH_REGULATOR_MODE_* which are defined
> +                   in [1] (i.e. 0 to 3).

Why is this still here?  You moved it to the core regulator framework,
right?  It's still in your examples too.  Shouldn't this be removed?
It looks like the driver still needs this and it needs to be an exact
duplicate of the common binding.  That doesn't seem right...


> +- qcom,drms-mode-max-microamps
> +       Usage:      required if regulator-allow-set-load is specified;
> +                   VRM regulators only
> +       Value type: <prop-encoded-array>
> +       Definition: A list of integers specifying the maximum allowed load
> +                   current in microamps for each of the modes listed in
> +                   qcom,allowed-drms-modes (matched 1-to-1 in order).  Elements
> +                   must be specified in order from lowest to highest value.

Any reason this can't go into the regulator core?  You'd basically
just take the existing concept of rpmh_regulator_vrm_set_load() and
put it in the core.


> +- qcom,headroom-microvolt
> +       Usage:      optional; VRM regulators only
> +       Value type: <u32>
> +       Definition: Specifies the headroom voltage in microvolts to request for
> +                   a VRM regulator.  RPMh hardware automatically ensures that
> +                   the parent of this regulator outputs a voltage high enough
> +                   to satisfy the requested headroom.  Supported values are
> +                   0 to 511000.

I'm curious: is this a voted-for value, or a global value?

Said another way: the whole point of RPMh is that there may be more
than one processor that needs the same rails, right?  So the AP might
request 1.1 V for a rail and the modem might request 1.3 V.  RPMh
would decide to pick the higher of those two (1.3 V), but if the modem
said it no longer needs the rail it will drop down to 1.1 V.

...and as an example of why the headroom needs to be in hardware, if
the source voltage was normally 1.4 V and the headroom was 200 mV then
the hardware would need to know to bump up the source voltage to 1.5V
during the period of of time that the modem wants the rail at 1.3V.

So my question is: do the AP and modem in the above situation
separately vote for headroom?  How is it aggregated?  ...or is it a
global value and this sets the headroom for all clients of RPMh?  It
would be interesting to document this as it might help with figuring
out how this value should be set.


> diff --git a/include/dt-bindings/regulator/qcom,rpmh-regulator.h b/include/dt-bindings/regulator/qcom,rpmh-regulator.h
> new file mode 100644
> index 0000000..4378c4b
> --- /dev/null
> +++ b/include/dt-bindings/regulator/qcom,rpmh-regulator.h
> +/*
> + * These mode constants may be used for regulator-initial-mode and
> + * qcom,allowed-drms-modes properties of an RPMh regulator device tree node.

Technically also for your new "regulator-allowed-modes".  Maybe just
say that they're used anywhere a regulator mode is needed in this
driver and give regulator-initial-mode as an example?


-Doug
