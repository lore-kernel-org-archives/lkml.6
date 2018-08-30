Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D23AC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 08:21:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40D762082C
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 08:21:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dDdt9ja5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40D762082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727778AbeH3MWN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 08:22:13 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:39416 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727622AbeH3MWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 08:22:13 -0400
Received: by mail-lf1-f65.google.com with SMTP id j201-v6so6498417lfg.6
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 01:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=buceAgGoc3cZgE90hU7eJXpWFuY5dhAFc0lDVyy7SLI=;
        b=dDdt9ja536lhBlCtEpR2sCSeiqx3ehpeRAjwN27yNExCksWWCnuA08ENd7XGe9MTv/
         HFB9MvRKoiM/i3frpOFTDRAhaFjAyLH6v3k0EMJmaR/PCFD0qxHSBQDxcUZmhRrcB7mU
         qk39pASotZBvgC5l6qZdBtvxHMMti02kEf8Hk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=buceAgGoc3cZgE90hU7eJXpWFuY5dhAFc0lDVyy7SLI=;
        b=NCgiODNCOlSTcNElgicRoaXjhO01UcWiwwZRzb1OvlSTn53qFTBoKnyOSRVYh91WOI
         W+FK8hAldpgUC+FFRzSAFtFB9SXE8TDiRPNsfFnPmCWIHB+wZSqmc4Gj1A6PIHbweBxC
         HfW3EtjGVn+kCbC6FQ1vPU6HS+gqIoaKulSdvLxglxoAMPLOjB4505EVBjL5aQgX5z+q
         FxS9A9JL5jfPr4cT/Zu3RIERY88517ZJ/zJ85mERsnKyQKwTiw75ABK8bFkzDMwbk9ZM
         iB9J9P0JwT8GFIUwtrabwR6W6iRIsNonO8QIf9xED8wX3LRtDtbKSK7czuCA5CL9FSmb
         sEeg==
X-Gm-Message-State: APzg51DGT7OKAfUjPJZ5CJ4/bCFhaXTfs5HQfJaVNyP/LPM5C3rE1W4Q
        lBXiFG09BgdTfhKwXPAf45hJJg==
X-Google-Smtp-Source: ANB0VdaxoIvq1VTyN1cUHhgDzhTCHttfyshjA+k0lFEPiQ/98nSyRmQldfSxJ3z3T+Pq5h/UXhpyTA==
X-Received: by 2002:a19:1819:: with SMTP id o25-v6mr6588039lfi.50.1535617273457;
        Thu, 30 Aug 2018 01:21:13 -0700 (PDT)
Received: from centauri.lan (h-229-118.A785.priv.bahnhof.se. [5.150.229.118])
        by smtp.gmail.com with ESMTPSA id x14-v6sm1172398lff.7.2018.08.30.01.21.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 Aug 2018 01:21:12 -0700 (PDT)
Date:   Thu, 30 Aug 2018 10:21:10 +0200
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     viresh.kumar@linaro.org, sboyd@kernel.org, andy.gross@linaro.org,
        ulf.hansson@linaro.org, collinsd@codeaurora.org, mka@chromium.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/6] Add power domain driver for corners on
 msm8996/sdm845
Message-ID: <20180830082110.GA13528@centauri.lan>
References: <20180627045234.27403-1-rnayak@codeaurora.org>
 <91ece266-025b-0b70-6563-5041b70f84b8@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91ece266-025b-0b70-6563-5041b70f84b8@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2018 at 12:05:14PM +0530, Rajendra Nayak wrote:
> 
> 
> On 6/27/2018 10:22 AM, Rajendra Nayak wrote:
> > Changes in v4:
> > * Included the patch to add qcom-opp bindings (dropped accidentally in v3)
> > * merged the patches to add bindings for rpm and rpmh, added consumer binding example
> > * Made the drivers built in, removed .remove
> > * Added better description in changelog for PATCH 6/6
> > * Updated rpmhpd_aggregate_corner() based on Davids feedback
> > * rpmhpd_set_performance_state() returns max corner, in cases where its called
> > with an INT_MAX
> > * Dropped the patch to max vote on all corners at init, the patch did not
> > work anyway, and it shouldn't be needed now
> 
> These patches have been out on the list for a while (8 weeks).
> I haven't seen any further comments from anyone, except on PATCH 2/6
> by Rob. I requested Rob to provide his Ack if he is fine with the bindings.
> 
> Can we plan to pull these in for 4.20?

Hello Rajendra,

FYI: these patches do no longer cleanly apply to v4.19-rc1, it's a trivial
conflict, but most maintainers prefer for the patch author to rebase, not
sure what Andy prefers.

If it builds correctly with COMPILE_TEST, please consider adding that to
your new Kconfig:
depends on MFD_QCOM_RPM && QCOM_SMD_RPM || COMPILE_TEST

Kind regards,
Niklas

> 
> > 
> > Changes in v3:
> > * Bindings split into seperate patches
> > * Bindings updated to remove duplicate OPP table phandles
> > * DT headers defining macros for Power domain indexes and OPP levels
> > * Optimisations to use rpmh_write_async() whereever applicable
> > * Fixed up handling of ACTIVE_ONLY/WAKE_ONLY/SLEEP voting for RPMh
> > * Fixed the vlvl to hlvl conversions in set_performance
> > * Other minor fixes based on review of v2
> > * TODO: This series does not handle the case where all VDD_MX votes
> > should be higher than VDD_CX from APPs, as pointed out
> > by David Collins in v2. This needs support at genpd to propogate performance
> > state up the parents, if we model these as Parent/Child to handle the
> > interdependency.
> > 
> > Changes in v2:
> > * added a power domain driver for sdm845 which supports communicating to RPMh
> > * dropped the changes to sdhc driver to move over to using OPP
> > as there is active discussion on using OPP as the interface vs
> > handling all of it in clock drivers
> > * Other minor binding updates based on review of v1
> > 
> > With performance state support for genpd/OPP merged, this is an effort
> > to model a power domain driver to communicate corner/level
> > values for qualcomm platforms to RPM (Remote Power Manager) and RPMh.
> > 
> > Rajendra Nayak (6):
> >    dt-bindings: opp: Introduce qcom-opp bindings
> >    dt-bindings: power: Add qcom rpm power domain driver bindings
> >    soc: qcom: rpmpd: Add a Power domain driver to model corners
> >    soc: qcom: rpmpd: Add support for get/set performance state
> >    arm64: dts: msm8996: Add rpmpd device node
> >    soc: qcom: rpmhpd: Add RPMh Power domain driver
> > 
> >   .../devicetree/bindings/opp/qcom-opp.txt      |  25 ++
> >   .../devicetree/bindings/power/qcom,rpmpd.txt  | 146 +++++++
> >   arch/arm64/boot/dts/qcom/msm8996.dtsi         |  34 ++
> >   drivers/soc/qcom/Kconfig                      |  18 +
> >   drivers/soc/qcom/Makefile                     |   2 +
> >   drivers/soc/qcom/rpmhpd.c                     | 406 ++++++++++++++++++
> >   drivers/soc/qcom/rpmpd.c                      | 340 +++++++++++++++
> >   include/dt-bindings/power/qcom-rpmpd.h        |  39 ++
> >   8 files changed, 1010 insertions(+)
> >   create mode 100644 Documentation/devicetree/bindings/opp/qcom-opp.txt
> >   create mode 100644 Documentation/devicetree/bindings/power/qcom,rpmpd.txt
> >   create mode 100644 drivers/soc/qcom/rpmhpd.c
> >   create mode 100644 drivers/soc/qcom/rpmpd.c
> >   create mode 100644 include/dt-bindings/power/qcom-rpmpd.h
> > 
