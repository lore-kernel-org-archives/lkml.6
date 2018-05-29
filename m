Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754584AbeE2EfA (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 00:35:00 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:45761 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754501AbeE2Eez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 00:34:55 -0400
X-Google-Smtp-Source: AB8JxZrj9t3LcXSpd1UU5ixNdRWSbSnWN2SLGIxT2CI9yZoMtjXgHjtR+PY8NOKGZ1qeYt2gDd8JqQ==
Date: Mon, 28 May 2018 21:36:34 -0700
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Rohit Kumar <rohitkr@codeaurora.org>
Cc: ohad@wizery.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, bgoswami@codeaurora.org,
        sbpata@codeaurora.org, asishb@codeaurora.org, rkarra@codeaurora.org,
        RajendraBabu Medisetti <rajendrabm@codeaurora.org>,
        Krishnamurthy Renu <krishnamurthy.renu@codeaurora.org>,
        asishb@qti.qualcomm.com, Ramlal Karra <rkarra@qti.qualcomm.com>,
        Rohit Kumar <rohkumar@qti.qualcomm.com>
Subject: Re: [PATCH] remoteproc: Add APSS based Qualcomm ADSP PIL driver for
 SDM845
Message-ID: <20180529043634.GF2259@tuxbook-pro>
References: <1526194908-19027-1-git-send-email-rohitkr@codeaurora.org>
 <20180523062645.GY14924@minitux>
 <767dc01f-abed-8192-0274-ff5fc092f60b@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <767dc01f-abed-8192-0274-ff5fc092f60b@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 23 May 22:18 PDT 2018, Rohit Kumar wrote:

> Thanks Bjorn for reviewing.
> 
> 
> On 5/23/2018 11:56 AM, Bjorn Andersson wrote:
> > On Sun 13 May 00:01 PDT 2018, Rohit kumar wrote:
> > 
> > > --- a/Documentation/devicetree/bindings/remoteproc/qcom,adsp.txt
> > > +++ b/Documentation/devicetree/bindings/remoteproc/qcom,adsp.txt
> > > @@ -10,6 +10,7 @@ on the Qualcomm ADSP Hexagon core.
> > >   		    "qcom,msm8974-adsp-pil"
> > >   		    "qcom,msm8996-adsp-pil"
> > >   		    "qcom,msm8996-slpi-pil"
> > > +		    "qcom,sdm845-apss-adsp-pil"
> > Afaict there's nothing in this binding that ties this to the apss, so I
> > don't think we should base the compatible on this. The differentiation
> > is PAS vs non-PAS; so let's start naming the PAS variants
> > "qcom,platform-subsystem-pas" and the non-PAS
> > "qcom,platform-subsystem-pil" instead.
> > 
> > I.e. please make this "qcom,sdm845-adsp-pil".
> > 
> > More importantly, any resources such as clocks or reset lines should
> > come from DT and as such you need to extend the binding quite a bit -
> > which I suggest you do by introducing a new binding document.
> Sure. Will create new dt-binding document with clocks and reset driver info
> added for sdm845 PIL.
> 
> > >   - interrupts-extended:
> > >   	Usage: required
> > > diff --git a/drivers/remoteproc/Makefile b/drivers/remoteproc/Makefile
> > > index 02627ed..759831b 100644
> > > --- a/drivers/remoteproc/Makefile
> > > +++ b/drivers/remoteproc/Makefile
> > > @@ -14,7 +14,8 @@ obj-$(CONFIG_OMAP_REMOTEPROC)		+= omap_remoteproc.o
> > >   obj-$(CONFIG_WKUP_M3_RPROC)		+= wkup_m3_rproc.o
> > >   obj-$(CONFIG_DA8XX_REMOTEPROC)		+= da8xx_remoteproc.o
> > >   obj-$(CONFIG_KEYSTONE_REMOTEPROC)	+= keystone_remoteproc.o
> > > -obj-$(CONFIG_QCOM_ADSP_PIL)		+= qcom_adsp_pil.o
> > > +obj-$(CONFIG_QCOM_ADSP_PIL)		+= qcom_adsp.o
> > > +qcom_adsp-objs				+= qcom_adsp_pil.o qcom_adsp_pil_sdm845.o
> > >   obj-$(CONFIG_QCOM_RPROC_COMMON)		+= qcom_common.o
> > >   obj-$(CONFIG_QCOM_Q6V5_PIL)		+= qcom_q6v5_pil.o
> > >   obj-$(CONFIG_QCOM_SYSMON)		+= qcom_sysmon.o
> > > diff --git a/drivers/remoteproc/qcom_adsp_pil.c b/drivers/remoteproc/qcom_adsp_pil.c
> > I get the feeling that the main reason for modifying this file is its
> > name, not that it reduces the complexity of the final solution. I
> > definitely think it's cleaner to have some structural duplication and
> > keep this driver handling the various PAS based remoteprocs.
> The main intention was to re-use exisiting APIs in PAS based PIL
> driver as the major change was w.r.t. start and stop of ADSP firmware.
> Load(), interrupt handling and few other APIs will be same as done in
> exisiting PAS based PIL driver.

A very good intention, I just think it's good to keep the PAS driver
only dealing with PAS targets and work on reducing the duplication in
other ways; keeping the logic as simple as possible.

> > Please see the RFC series I posted reducing the duplication between the
> > various "Q6V5 drivers".
> I went through the RFC. Our code will fit into the design. However, we
> will still have some amount of code duplication between PAS and
> Non-PAS ADSP PIL driver. Will this be fine?

I'm sorry for not finding the time to provide you this feedback earlier.

> Please suggest.
> Will wait for your response whether to write complete new driver or reuse
> exisitng one.
> 

For the Hexagon based non-PAS WCSS remoteproc in IPQ8074 we're creating
a new driver [1], in doing so I extracted some common helper functions
that reduces the duplication between the drivers and there are a few
more things on the way (e.g. reduce the code needed to deal with
memory-regions).

Please have a look at either extending this (non-PAS, non-MSA) driver to
cover the ADSP as well. It's hard for me to see how the exact details
will look after extracting the clocks and resets to their appropriate
drivers, if it doesn't fit the details we should work further on making
sure frameworks and helper functions reduces the logical duplication
between drivers.

[1] https://patchwork.kernel.org/patch/10420185/
 
> > [..]
> > > diff --git a/drivers/remoteproc/qcom_adsp_pil.h b/drivers/remoteproc/qcom_adsp_pil.h
> > [..]
> > > +static inline void update_bits(void *reg, u32 mask_val, u32 set_val, u32 shift)
> > > +{
> > > +	u32 reg_val = 0;
> > > +
> > > +	reg_val = ((readl(reg)) & ~mask_val) | ((set_val << shift) & mask_val);
> > > +	writel(reg_val, reg);
> > > +}
> > > +
> > > +static inline unsigned int read_bit(void *reg, u32 mask, int shift)
> > > +{
> > > +	return ((readl(reg) & mask) >> shift);
> > > +}
> > I don't like these helper functions, their prototype is nonstandard and
> > makes it really hard to read all the calling code.
> > 
> > I would prefer if you just inline the operations directly, to make it
> > clearer what's going on in each case - if not then at least follow the
> > prototype of e.g. regmap_udpate_bits(), which people might be used to.
> Sure. Will update these APIs to follow standard format used in regmap and
> other drivers.

I like Rob's argument here (just use readl/writel) and it does suit our
current style.

[..]
> Thanks,
> Rohit
> 

Thank you Rohit,
Bjorn
