Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 414BEC5CFE7
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 16:10:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6E0020779
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 16:10:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nVs3SWud"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6E0020779
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933443AbeGIQK0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 12:10:26 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:39662 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932939AbeGIQKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 12:10:20 -0400
Received: by mail-pf0-f194.google.com with SMTP id s21-v6so14016113pfm.6
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 09:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hsjT0HDwUb9BaWQg1NiezsilEcRByhIfQZghrpisDL4=;
        b=nVs3SWudTxjhZ2BUAi8WbUjI1PP4wWpmliYAg6rWwasxnO+kpaxzF6wAJ0sHDwqPsT
         1vuT9YVQUxwSGuVgXVWIivSEdEL8Mkkp92gCI4Zz79IbeqAdARvMlX6tamSV7t/Cf0RY
         skYPnmA0qtRhLmmPSNOc6lv9d3HSK0WefuuTQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hsjT0HDwUb9BaWQg1NiezsilEcRByhIfQZghrpisDL4=;
        b=coFEx7zDd0bsFjDKvQWj72fsbAa+ZVdV2O0uG/BArZZnFToqRrNnfdD7YL30+9t3RP
         pkxcrcaH9DAGWydsnmBp28r7u0Tj/7tahJyhYnxQMc8pFFyje/g9juPYtXTWacllZumv
         zvz+23oAPZ8Y9s/KCeUq9fEn6NJwmZOAuN575IOcC/4uactWQI8Rpe2ebWDbQDX9gh9I
         DUXpKnfVotOCWvcbc6fC36l4wRNI5h3tbq57s+cTOi/dueDMoLNcRUF72tCprZwio5R8
         RoDq+zFaEcD4A/MyS8/KVUhtQS1tqmWj0jOQyg61oawNEs8cAuPBTZG834x9N9dO790q
         bG7A==
X-Gm-Message-State: APt69E3LB66+lsUmONA74o2S92hB2nini1MzjiAPLiNB22sfKW7LB2ln
        en3/bk3V772KGKL6OeIugosMkw==
X-Google-Smtp-Source: AAOMgpfiLf6tKkuRB3sGBQlSrGqKTJ0BOiO1S4pihbCFv2+NmjhlYh8oJE07yu6sto69yog0CH8VEQ==
X-Received: by 2002:a62:170c:: with SMTP id 12-v6mr21848746pfx.139.1531152620126;
        Mon, 09 Jul 2018 09:10:20 -0700 (PDT)
Received: from localhost ([2620:0:1000:1501:8e2d:4727:1211:622])
        by smtp.gmail.com with ESMTPSA id j72-v6sm32457544pge.19.2018.07.09.09.10.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Jul 2018 09:10:19 -0700 (PDT)
Date:   Mon, 9 Jul 2018 09:10:19 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        smohanad@codeaurora.org,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        lakml <linux-arm-kernel@lists.infradead.org>,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH v4 6/6] arm64: dts: sdm845: Add tsens nodes
Message-ID: <20180709161019.GN129942@google.com>
References: <cover.1530533998.git.amit.kucheria@linaro.org>
 <a52b77ad84867774a0659f51ccb79b17ba7638ab.1530533998.git.amit.kucheria@linaro.org>
 <20180703214822.GD129942@google.com>
 <CAHLCerMZw8mftQb8iRc5+RqGGjf26ebwynPfORz0hAPxp05YfA@mail.gmail.com>
 <20180709160131.GM129942@google.com>
 <CAHLCerP0z-G+YqXOe8VYSTVPfSYiR+yywskijiD7y0Lz=2AQQQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHLCerP0z-G+YqXOe8VYSTVPfSYiR+yywskijiD7y0Lz=2AQQQ@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 09, 2018 at 09:34:55PM +0530, Amit Kucheria wrote:
> On Mon, Jul 9, 2018 at 9:31 PM, Matthias Kaehlcke <mka@chromium.org> wrote:
> > On Mon, Jul 09, 2018 at 04:56:51PM +0530, Amit Kucheria wrote:
> >> On Wed, Jul 4, 2018 at 3:18 AM, Matthias Kaehlcke <mka@chromium.org> wrote:
> >> > Hi,
> >> >
> >> > On Mon, Jul 02, 2018 at 06:14:09PM +0530, Amit Kucheria wrote:
> >> >> SDM845 has two tsens blocks, one with 13 sensors and the other with 8
> >> >> sensors.
> >> >>
> >> >> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> >> >> ---
> >> >>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 16 ++++++++++++++++
> >> >>  1 file changed, 16 insertions(+)
> >> >>
> >> >> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> >> >> index cdaabeb..edf8505 100644
> >> >> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> >> >> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> >> >> @@ -221,6 +221,22 @@
> >> >>                       #interrupt-cells = <2>;
> >> >>               };
> >> >>
> >> >> +             tsens0: tsens@c222000 {
> >> >> +                     compatible = "qcom,tsens-v2.4.0", "qcom,tsens-v2";
> >> >> +                     reg = <0xc263000 0x1ff>, /* TM */
> >> >> +                           <0xc222000 0x1ff>; /* SROT */
> >> >> +                     #qcom,sensors = <13>;
> >> >> +                     #thermal-sensor-cells = <1>;
> >> >> +             };
> >> >> +
> >> >> +             tsens1: tsens@c223000 {
> >> >> +                     compatible = "qcom,tsens-v2.4.0", "qcom,tsens-v2";
> >> >> +                     reg = <0xc265000 0x1ff>, /* TM */
> >> >> +                           <0xc223000 0x1ff>; /* SROT */
> >> >> +                     #qcom,sensors = <8>;
> >> >> +                     #thermal-sensor-cells = <1>;
> >> >> +             };
> >> >> +
> >> >>               spmi_bus: spmi@c440000 {
> >> >>                       compatible = "qcom,spmi-pmic-arb";
> >> >>                       reg = <0xc440000 0x1100>,
> >> >
> >> > I tested this series on an SDM845 board. Temperatures can be read from
> >> > the tsens0 sensors, however for tsens1 sensors I get:
> >> >
> >> > cat temp
> >> > cat: temp: No data available
> >> >
> >> > TRDY_READY_BIT set when reading TRDY_OFFSET in get_temp_tsens_v2().
> >> > Unfortunately I currently have no documentation of the registers or the
> >> > thermal sensors in general and couldn't investigate further.
> >> >
> >> > Any idea what could be the problem?
> >>
> >> Strangely enough, I'm seeing this now after rebuilding my integration
> >> branch to test some other bits.
> >>
> >> I've sent another version with this patch removed while I investigate
> >> this. Could you check if you're able to read all 8 sensors with v5?
> >
> > With v6 all sensors can be read, thanks!
> 
> Great! Would it be OK to add your Tested-by tag?

Yep
