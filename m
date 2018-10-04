Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7831C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 08:36:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A6DE21470
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 08:36:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="JAoAUOAt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A6DE21470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbeJDP2u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 11:28:50 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44145 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727190AbeJDP2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 11:28:50 -0400
Received: by mail-pg1-f195.google.com with SMTP id g2-v6so2809804pgu.11
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 01:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vf5szHRTiYd5p8iO8+8KCHUjRmsNBiKPK1lNrizeXNo=;
        b=JAoAUOAt45GlXTsaSTAaUTZWJwrsNKC3rTtDJCsPajH1LQnYgS9b1R7pfkcsQjRVfh
         4932VUs14FU8Wn8c34xRJtTh9XKPiR0XxJrRmgXxKR+Yowat7YFi6t9H8bt0eb+UPgit
         pM9fGGFXEUKtR07Ep4voahZoCfKwIClLsu9aY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vf5szHRTiYd5p8iO8+8KCHUjRmsNBiKPK1lNrizeXNo=;
        b=obDJxrPy1jlLvAugoxznnwkwupHRSncaHYGBqA5LJjO824jR1ktViLEDkdSM7hLD9s
         y5HS8d/RKd0lU1tycrL3jWNn0wzCDd0NPRn/cyLMLA5L2DSEOiqi3sab2+7DbrejLp4g
         4H5HJ9s2UkRM5n4pIBZh52B9g6tlnhPbliMn0m+NJ/X5T9w8QQm+t4bscxJrVKJWWvtJ
         Bhjyl2IbumkXELYKl/81KEQkQ2Zjn0ZAo7iDgpqiGjZeG5fzwPp4oJ6es2tR0wyONGcx
         s9RzAEqLXVZ27AludlknQbpXbR6vOsB6sOa/t5uWUU+wkXZ4oYOvFXW/5FRiuQ/433aj
         SEAA==
X-Gm-Message-State: ABuFfoi+EfOfW2cpXJqnxjjVtwxmLunbOM0CxEYaizIM7tPFmEhnYGSt
        e7kdQux+EkLM+W95M6NZHfUAzQ==
X-Google-Smtp-Source: ACcGV62z5h32e+16gvUO3ReTyLcHGXtFwVTRS3WJHV2qZiaNd0zo51Z0wE/kxr0h53zTPzdH7eLguw==
X-Received: by 2002:a62:2fc1:: with SMTP id v184-v6mr5668754pfv.115.1538642200507;
        Thu, 04 Oct 2018 01:36:40 -0700 (PDT)
Received: from localhost ([122.172.76.11])
        by smtp.gmail.com with ESMTPSA id 68-v6sm9016703pfg.136.2018.10.04.01.36.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Oct 2018 01:36:39 -0700 (PDT)
Date:   Thu, 4 Oct 2018 14:06:37 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Rajendra Nayak <rnayak@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Andy Gross <andy.gross@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        David Collins <collinsd@codeaurora.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        devicetree@vger.kernel.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 2/6] dt-bindings: power: Add qcom rpm power domain
 driver bindings
Message-ID: <20181004083637.xlz26rpn4qtsvdk7@vireshk-i7>
References: <20180627045234.27403-1-rnayak@codeaurora.org>
 <20180627045234.27403-3-rnayak@codeaurora.org>
 <20180703223554.GA32313@rob-hp-laptop>
 <20180704055757.4li26b6poxllmh2k@vireshk-i7>
 <1463d24b-481d-eecd-9e44-e7a5a993e5fc@codeaurora.org>
 <CAL_JsqJe+m4hD3nxQDjOT1JzRoSMXppy1r6APV1w=NtgCr-X_A@mail.gmail.com>
 <271db7b1-f65b-f42d-b00b-9362429b3749@codeaurora.org>
 <CAL_JsqJQypZbeZRa2u2+nM96p0ZHMHgDSpMbXqZx6zn+OiZSrw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqJQypZbeZRa2u2+nM96p0ZHMHgDSpMbXqZx6zn+OiZSrw@mail.gmail.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25-09-18, 14:43, Rob Herring wrote:
> On Tue, Sep 25, 2018 at 5:25 AM Rajendra Nayak <rnayak@codeaurora.org> wrote:
> >
> > Hi Rob,
> >
> > []...
> > >>>>> +   rpmhpd_opp_table: opp-table {
> > >>>>> +           compatible = "operating-points-v2-qcom-level";
> > >>>>> +
> > >>>>> +           rpmhpd_opp_ret: opp1 {
> > >>>>> +                   qcom,level = <RPMH_REGULATOR_LEVEL_RETENTION>;
> > >>>>> +           };
> > >>>>
> > >>>> I don't see the point in using the OPP binding here when you aren't
> > >>>> using *any* of the properties from it.
> > >>>
> > >>> Yeah, that's the case for now. But there are cases (as Stephen
> > >>> mentioned earlier [1]) where the voltage values (and maybe other
> > >>> values like current, etc) would be known and filled in DT. And that's
> > >>> why we all agreed to use OPP tables for PM domains as well, as these
> > >>> are really "operating performance points" of these PM domains.
> > >>
> > >> Rob, are you fine with these bindings then?
> > >
> > > Okay, my only thought is whether we should just use 'reg' here, or do
> > > we need 'level' for anything else and should make it common?
> >
> > I am not quite sure I understood what you are suggesting here :(
> 
> You could use the  'reg' property instead of 'qcom,level'. Any reason
> not to do that?

They can use any property which uniquely identifies the OPP nodes in
the table. Though I never thought we can use 'reg' property in such a
way. I always thought it must be related to registers somehow :)

Yeah, CPU is one of the examples where 'reg' has a special meaning.

> Alternatively, would 'level' be something useful in other situations
> and should not be QCom specific?

It is too early to say that. The only platform which needs this is
Qcom right now, lets see what the requirements from other users are.

-- 
viresh
