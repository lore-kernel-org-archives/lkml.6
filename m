Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752103AbeERWYu (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 18:24:50 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:36611 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751606AbeERWYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 18:24:47 -0400
X-Google-Smtp-Source: AB8JxZpR4opRZmUqTNesUi9hmo3OkBC5T4XNT2oKJ8j6dwE1eTNjWvy04Ks7E6KS1JgWP5w8TnyHRw==
Date: Fri, 18 May 2018 17:24:45 -0500
From: Rob Herring <robh@kernel.org>
To: David Collins <collinsd@codeaurora.org>
Cc: Doug Anderson <dianders@chromium.org>, Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>, linux-arm-msm@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v3 1/2] regulator: dt-bindings: add QCOM RPMh regulator
 bindings
Message-ID: <20180518222445.GA16342@rob-hp-laptop>
References: <cover.1526088081.git.collinsd@codeaurora.org>
 <41d5df73ddac772551d2966e0752bb0c357b1ded.1526088081.git.collinsd@codeaurora.org>
 <CAD=FV=XegPeFR8pdZM-YiBBJjrbej=C+2biBt4zJKnE90uTYZA@mail.gmail.com>
 <869aad59-1cc5-28ef-1fb5-4ef846696c40@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <869aad59-1cc5-28ef-1fb5-4ef846696c40@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 17, 2018 at 05:16:13PM -0700, David Collins wrote:
> On 05/17/2018 02:22 PM, Doug Anderson wrote:
> > On Fri, May 11, 2018 at 7:28 PM, David Collins <collinsd@codeaurora.org> wrote:
> >> +- qcom,regulator-initial-microvolt
> >> +       Usage:      optional; VRM regulators only
> >> +       Value type: <u32>
> >> +       Definition: Specifies the initial voltage in microvolts to request for a
> >> +                   VRM regulator.
> > 
> > Now that Mark has landed the patch adding support for the
> > -ENOTRECOVERABLE error code from get_voltage() / get_voltage_sel(), do
> > we still need the qcom,regulator-initial-microvolt property?
> 
> Yes, this is still needed.  The -ENOTRECOVERABLE patch ensures that
> qcom-rpmh-regulator devices can be registered even if
> qcom,regulator-initial-microvolt is not specified.  However, that will
> result in the regulators being configured for the minimum voltage
> supported in the DT specified min/max range.  The
> qcom,regulator-initial-microvolt property allows us to set a specific
> voltage that is larger than the min constraint.
> 
> > If this is really still needed, can it be moved to the regulator core?
> 
> I'm not opposed to the idea, but I think that Mark is [1]:
> 
> >> Do you have a preference for qcom,regulator-initial-microvolt vs a generic
> >> framework supported regulator-initial-microvolt property for configuring a
> >> specific voltage at registration time?  We'll need to have support for one
> >> or the other in order for the qcom_rpmh-regulator driver to be functional.
> > 
> > This is basically specific to Qualcomm, I can't off hand think of any
> > other devices with similar issues.
> 
> 
> >> +- regulator-initial-mode
> >> +       Usage:      optional; VRM regulators only
> >> +       Value type: <u32>
> >> +       Definition: Specifies the initial mode to request for a VRM regulator.
> >> +                   Supported values are RPMH_REGULATOR_MODE_* which are defined
> >> +                   in [1] (i.e. 0 to 3).  This property may be specified even
> >> +                   if the regulator-allow-set-load property is not specified.
> > 
> > Every time I read the above I wonder why you're documenting a standard
> > regulator regulator property in your bindings.  ...then I realize it's
> > because you're doing it because you want to explicitly document what
> > the valid modes are.  I wonder if it makes sense to just put a
> > reference somewhere else in this document to go look at the header
> > file where these are all nicely documented.
> 
> Isn't that what the [1] in the above snippet is currently doing.  Further
> down in qcom,rpmh-regulator.txt is this line:
> 
> +[1] include/dt-bindings/regulator/qcom,rpmh-regulator.h
> 
> 
> > Speaking of documenting things like that, it might be worth finding
> > somewhere in this doc to mention that the "bob" regulator on PMI8998
> > can support "regulator-allow-bypass".  That tidbit got lost when we
> > moved to the standard regulator bindings for bypass.
> 
> I suppose that I could add something like this:
> 
> +- regulator-allow-bypass
> +	Usage:      optional; BOB type VRM regulators only
> +	Value type: <empty>
> +	Definition: See [2] for details.
> ...
> +[2]: Documentation/devicetree/bindings/regulator.txt
> 
> However, I don't want the patch to get NACKed because it is defining a
> property that is already defined in the common regulator.txt file.

If all constraints are defined in the common doc, just "see 
regulator.txt" is fine. You just need to say what properties this 
binding uses.

Rob
