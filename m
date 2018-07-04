Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18D88C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 05:58:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C706423D8D
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 05:58:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jvKuIYRj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C706423D8D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753673AbeGDF6H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 01:58:07 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:41518 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753533AbeGDF6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 01:58:01 -0400
Received: by mail-pl0-f68.google.com with SMTP id w8-v6so2143123ply.8
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 22:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LTO85y6E1kJ+yyo7R+aYS7m//pmWOYhISXDKuw5xFZ0=;
        b=jvKuIYRj8G30a8UyChBqmWqz4Pfp/cmQP512lQL8Hts1iqCdrYjGi2rzY+fkoLr318
         J8ohuKMBZdE9+RHBVL7sG0pVjh+HL3XXhKOWzzc7yGRNxo5dTWIjswNod9G4avHJynQd
         /3KtCCO95U8//byNjFfq4qsaI+h4Gv7lE2SHg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LTO85y6E1kJ+yyo7R+aYS7m//pmWOYhISXDKuw5xFZ0=;
        b=EKYvjF7NXKNYXEN2vPq+/DqrqOpdNNICmXkUSydaYzWR+987PiEptjSPjit0zlypVG
         LSzhpEmtd5jtSIi/hu/83H0pF01Uw4ukewoIo+cq/u+RqKHXDADQOVUKHDnMGzfpfFpG
         YSwrQ9xIT9ChLEqFiRIp/xtWm42FlnMDD2uUDNV3D8RaG8tq3CK2B1aMIuTl4gc+5T+U
         aYLm9nQVR3mRe3KArR0avc05RDgsOy2K4l8Zh2iEbCcR0iwFZOGrbky+rNkM3wRe104E
         o1HI+Etfa8AIGYgn21Gje/P4vDvDGC0p287MsfWG9c3UbWN+ug7M70tw/PVomiDCaVNy
         /U9w==
X-Gm-Message-State: APt69E2ZwnQ/2aD4eB64JLXkaWK+2Cu4g4io1090SarMt7Q1Z4uWNRJO
        tzTdPv2zeVr5Gvb8ZQfCmGavBw==
X-Google-Smtp-Source: AAOMgpdtxmCzW186za/Ckqw1nY6l7kCJgPleyovg5pk/mjitokdgt+Me1lH6AT9t/q9Ba+O90ogwzA==
X-Received: by 2002:a17:902:88:: with SMTP id a8-v6mr718926pla.156.1530683881126;
        Tue, 03 Jul 2018 22:58:01 -0700 (PDT)
Received: from localhost ([122.172.117.17])
        by smtp.gmail.com with ESMTPSA id u8-v6sm4869816pfl.105.2018.07.03.22.57.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Jul 2018 22:57:59 -0700 (PDT)
Date:   Wed, 4 Jul 2018 11:27:57 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Rajendra Nayak <rnayak@codeaurora.org>, sboyd@kernel.org,
        andy.gross@linaro.org, ulf.hansson@linaro.org,
        collinsd@codeaurora.org, mka@chromium.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/6] dt-bindings: power: Add qcom rpm power domain
 driver bindings
Message-ID: <20180704055757.4li26b6poxllmh2k@vireshk-i7>
References: <20180627045234.27403-1-rnayak@codeaurora.org>
 <20180627045234.27403-3-rnayak@codeaurora.org>
 <20180703223554.GA32313@rob-hp-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180703223554.GA32313@rob-hp-laptop>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03-07-18, 16:35, Rob Herring wrote:
> > +qcom,level values specified in the OPP tables for RPMh power domains
> > +should use the RPMH_REGULATOR_LEVEL_* constants from
> > +<dt-bindings/power/qcom-rpmhpd.h>
> > +
> > +	rpmhpd: power-controller {
> > +		compatible = "qcom,sdm845-rpmhpd";
> > +		#power-domain-cells = <1>;
> > +		operating-points-v2 = <&rpmhpd_opp_table>;
> > +	};
> > +
> > +	rpmhpd_opp_table: opp-table {
> > +		compatible = "operating-points-v2-qcom-level";
> > +
> > +		rpmhpd_opp_ret: opp1 {
> > +			qcom,level = <RPMH_REGULATOR_LEVEL_RETENTION>;
> > +		};
> 
> I don't see the point in using the OPP binding here when you aren't 
> using *any* of the properties from it.

Yeah, that's the case for now. But there are cases (as Stephen
mentioned earlier [1]) where the voltage values (and maybe other
values like current, etc) would be known and filled in DT. And that's
why we all agreed to use OPP tables for PM domains as well, as these
are really "operating performance points" of these PM domains.

-- 
viresh

[1] lkml.kernel.org/r/20180110025454.GG21040@codeaurora.org
