Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9A82C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 18:39:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9037420671
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 18:39:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HLorcNli"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9037420671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731405AbeGZT52 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 15:57:28 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33935 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729801AbeGZT52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 15:57:28 -0400
Received: by mail-pf1-f196.google.com with SMTP id k19-v6so865511pfi.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 11:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UsTGO2NsWuyXp3CsQxGOFv/T8izmmjPCChvJ+CWq33o=;
        b=HLorcNliLf7QBCCOmVF0wqNMTTZqCBQVe45wJ/F2LXfpN74DQYAaAInw6Ys2fn81aJ
         W4RCMtFtXGJoL9CqJA2GSl8nFzuT2emHyVNAstQk4U/SVulQwVUad9jh6xre2isknhRg
         6KTqC57Rwse7B4NhRyWAuEO01tTvdekR398Lw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UsTGO2NsWuyXp3CsQxGOFv/T8izmmjPCChvJ+CWq33o=;
        b=Zae//ZAbhoNg2Fmw/Bo9/Btb2BjEdYQCOx/lpnoC6iWSPGw9GcdsrI2mxAPlluNaxr
         GdoxMAn3EoxPszEf4ApVD6mwyOiPnZPxcgCiSvEHOdpVCCIA2lgxHFwa69FlyxyADCOY
         Z5GwwXMXg5kwAMUfQpEGo0R3T1VACYtofFB94XkpCg8N8/W/PEY4YMTO686FLwe0fMXy
         i/nGAmc+3P/X9EG5jc1VdD9QI6Q7stf6YLyH7bwj5HFShssJzaM3/KkVcSc0tSfp3ScF
         GHquUF0J2HjcedXYrXNQl7DfILUXQDmFJNja9WiUWTGJQbc3Fb81dvecBW0AmEW6KzIc
         rFZQ==
X-Gm-Message-State: AOUpUlHJ8fpjC4Sh4NnDY9Gt487kMVoovjnGGt8TUy7pyMLRzYDKc4yV
        JYSUxCcuQ+MMSc2tzKSElcYZnoZrkK8=
X-Google-Smtp-Source: AAOMgpcthAseHgFJUA61+rdnpzBhvTUj+Nhtecmxq1E/otjw5kEt/6/SI7YXnd7H+pOfVzjNg8KfOQ==
X-Received: by 2002:a62:4909:: with SMTP id w9-v6mr3311825pfa.154.1532630364262;
        Thu, 26 Jul 2018 11:39:24 -0700 (PDT)
Received: from localhost ([199.115.243.172])
        by smtp.gmail.com with ESMTPSA id y63-v6sm3282500pgd.94.2018.07.26.11.39.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Jul 2018 11:39:23 -0700 (PDT)
Date:   Thu, 26 Jul 2018 11:39:22 -0700
From:   Andy Gross <andy.gross@linaro.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Doug Anderson <dianders@chromium.org>,
        David Collins <collinsd@codeaurora.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH v9 1/2] regulator: dt-bindings: add QCOM RPMh regulator
 bindings
Message-ID: <20180726183922.GA4402@hector.mosconeconnections.com>
References: <cover.1531531808.git.collinsd@codeaurora.org>
 <56b9d5c38cfe46da1228c54f001a49773c3e31dc.1531531808.git.collinsd@codeaurora.org>
 <CAD=FV=VmfqWRGRMEn+0dzZ8x4R5vVaHbkthXAN91Lm-XmP9Gqg@mail.gmail.com>
 <20180724145755.GF13268@sirena.org.uk>
 <CAD=FV=Uo8sT72a0gRitOVoK0SfC-_QixsovW94_LnL6H7QdKvA@mail.gmail.com>
 <20180724152514.GJ13268@sirena.org.uk>
 <CAD=FV=WHJcAoR7Y_uhi7_GbVzy6K8FnovVFVRz8js0REONox=w@mail.gmail.com>
 <20180724165942.GP13268@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180724165942.GP13268@sirena.org.uk>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ olof

On Tue, Jul 24, 2018 at 05:59:42PM +0100, Mark Brown wrote:
> On Tue, Jul 24, 2018 at 08:43:46AM -0700, Doug Anderson wrote:
> > On Tue, Jul 24, 2018 at 8:25 AM, Mark Brown <broonie@kernel.org> wrote:
> 
> > > There was also some other thing called command DB as well which was a
> > > separate series.  Ideally there'd be a branch I could pull as there's a
> > > build dependency on rpmh so I can't apply until the code has landed in
> > > my tree, don't know what command DB is exactly.
> 
> > Yup.  That one landed in May and is already in mainline Linux.  Refer
> > to commit 312416d9171a ("drivers: qcom: add command DB driver").
> 
> That's good at least - the cover letter said it was still under review,
> guess it just hadn't been updated.
> 
> > Adding Andy to this thread (I guess he wasn't on it?).  Hopefully he
> > can provide you with the branch.
> 
Mark,

The arm-soc guys merged the Qualcomm pull requests.  So you can just use my
qcom-drivers-for-4.19 tag.  That won't change at this point.

git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git
qcom-drivers-for-4.19

Regards,
Andy
