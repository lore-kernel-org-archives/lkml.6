Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967743AbeEYSfo (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 14:35:44 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:39479 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967679AbeEYSfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 14:35:41 -0400
X-Google-Smtp-Source: AB8JxZo4Lk04o4aDYazoozFUCwfJnPBhEPXMwxbx/vEF7esbmrtaGsQaftfLnECbVMNvD01muyzdBg==
Date: Fri, 25 May 2018 11:35:38 -0700
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Vivek Gautam <vivek.gautam@codeaurora.org>
Cc: Andy Gross <andy.gross@linaro.org>,
        Manu Gautam <mgautam@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: qcom: msm8996: Use UFS_GDSC for UFS
Message-ID: <20180525183538.GH14924@minitux>
References: <20180524223122.12601-1-bjorn.andersson@linaro.org>
 <CAFp+6iH5bS5rmqZ1oy09COb2Rzuz6zbN7pFwxz0WTJNOYTTbkg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFp+6iH5bS5rmqZ1oy09COb2Rzuz6zbN7pFwxz0WTJNOYTTbkg@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 25 May 05:51 PDT 2018, Vivek Gautam wrote:

> Hi Bjorn,
> 
> On Fri, May 25, 2018 at 4:01 AM, Bjorn Andersson
> <bjorn.andersson@linaro.org> wrote:
> > The UFS host controller occationally (20%) fails to enable
> > gcc_ufs_axi_clk because the UFS GDSC is not enabled. In most cases it's
> > enabled through the UFS phy driver, but to make sure it's enabled let's
> > enable it directly from the UFS host controller directly as well.
> >
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > ---
> >  arch/arm64/boot/dts/qcom/msm8996.dtsi | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> > index 380e14591686..03c7904bda14 100644
> > --- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> > @@ -674,6 +674,8 @@
> >                         vccq-max-microamp = <450000>;
> >                         vccq2-max-microamp = <450000>;
> >
> > +                       power-domains = <&gcc UFS_GDSC>;
> > +
> 
> We shouldn't need power-domain with the phy. UFS_GDSC should
> be attached to the controller, as the phy is powered up only after
> the controller is power-up, and during collapse too, we turn off
> the phy first.

Afaict you're right, it should only be needed by the resources for the
HCD.

> Can you try testing keeping UFS_GDSC only with ufs controller and
> remove it from the ufs-phy node? We are doing same on the 4.14 release
> branch too for db820.

I test booted this 10 times, with 100% success :)

> I apologize to have missed this in your patch for ufs-related dt nodes.
> Can we please fix this now?

I'll send a v2, that moves the power-domain to the HCD, rather than just
adding it there too. Thanks for the quick review!

Regards,
Bjorn
