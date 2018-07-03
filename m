Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83B4BC6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 04:13:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3012D24D04
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 04:13:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="CN4x43ao"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3012D24D04
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753749AbeGCEN2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 00:13:28 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:32905 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751646AbeGCENZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 00:13:25 -0400
Received: by mail-pg0-f66.google.com with SMTP id e11-v6so332856pgq.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 21:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eVch0RokISw89X66LKkf84A5CHp6LmWnAKmUWOgwqPA=;
        b=CN4x43ao+7FVbx4LtZEvP1Xl2YVh97huuDVIxfsUJjNTzcoczq9tJ5v+hJAW6oOU2a
         dpcK3Vhy7RMjhXHl6TiNJ+8bcpWW5eBs8tilBKno8q+paSJ6gs9dsfJu+Vc1vsLUXrhR
         YhmOyIn3eNAHgs02K5Fh7cfowSwO8YH+fQ9+I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eVch0RokISw89X66LKkf84A5CHp6LmWnAKmUWOgwqPA=;
        b=FFBIqt2aGF3VDebWjItv1IMMY50MYQX53Ebdw0qP1J9v/S0jyX8//pTN6GRurWfSfs
         7DLF5koBATzSkZchD8eLWeUhq8CuJR1W/SBFtzj7yUQUMls5SX2cIZpL0uuq0Ezk89I0
         X9ukMa7svFof2YfN1GJbHykm8wb5/4Go1/P3YB8OTf0XrfH4ZlSFpZMbhKcsTdjyQuhd
         z6BC+nM6WoII0IVryjMqC2wQUUnJdF5L5zArAyJA540joll+RgbU+GjYsgqoyVcUcmnL
         iHXXRlW2gLsrwLeVBJVI7hnp8jbZfIcDoK/Be1NxuG6CMBEtWoQcie2h3xXlHlpJV5Ic
         N12A==
X-Gm-Message-State: APt69E0z6z7VvBpZ6tz42TmtX/C5pMZi4VVpK7alpcmamSXwps95cZzs
        aG81j5jGV0WV0eLtwKFI0u2dzQ==
X-Google-Smtp-Source: AAOMgpeV3uceOQ2jrHNtTuymoE+nkXl4Rl9rbKbet7NamW9zbB8YvPbLC7pessxQrdYIW0SXC2DQ/w==
X-Received: by 2002:a62:2b4c:: with SMTP id r73-v6mr23835273pfr.134.1530591205327;
        Mon, 02 Jul 2018 21:13:25 -0700 (PDT)
Received: from localhost ([122.172.117.17])
        by smtp.gmail.com with ESMTPSA id f64-v6sm298849pff.57.2018.07.02.21.13.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Jul 2018 21:13:24 -0700 (PDT)
Date:   Tue, 3 Jul 2018 09:43:21 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Olof Johansson <olof@lixom.net>
Cc:     Rob Herring <robh@kernel.org>,
        ARM-SoC Maintainers <arm@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        ionela.voinescu@arm.com,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        chris.redpath@arm.com,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 12/15] arm: dts: highbank: Add missing OPP properties for
 CPUs
Message-ID: <20180703041321.k2ewqta76cnqhsmm@vireshk-i7>
References: <cover.1527244200.git.viresh.kumar@linaro.org>
 <f8a4e5c3062397736475ec599de730206846cb9b.1527244201.git.viresh.kumar@linaro.org>
 <CAL_JsqJRKMREfJ8LoDfuda8BU3g5Eq1AX5cPZGzO3uN3vUhrAQ@mail.gmail.com>
 <20180702232735.eocdrdfwyj37577h@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180702232735.eocdrdfwyj37577h@localhost>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02-07-18, 16:27, Olof Johansson wrote:
> On Mon, Jul 02, 2018 at 02:25:40PM -0600, Rob Herring wrote:
> > On Fri, May 25, 2018 at 4:32 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > >
> > > The OPP properties, like "operating-points", should either be present
> > > for all the CPUs of a cluster or none. If these are present only for a
> > > subset of CPUs of a cluster then things will start falling apart as soon
> > > as the CPUs are brought online in a different order. For example, this
> > > will happen because the operating system looks for such properties in
> > > the CPU node it is trying to bring up, so that it can create an OPP
> > > table.
> > >
> > > Add such missing properties.
> > >
> > > Fix other missing property (clock latency) as well to make it all
> > > work.
> > >
> > > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > > ---
> > >  arch/arm/boot/dts/highbank.dts | 30 ++++++++++++++++++++++++++++++
> > >  1 file changed, 30 insertions(+)
> > 
> > Acked-by: Rob Herring <robh@kernel.org>
> > 
> > ARM-SOC maintainers, Please apply this.
> 
> Applied to next/dt.

Thanks Olof.

Can you also apply other patches in this series, that haven't been
applied yet by SoC maintainers ? And same for the arm64 series..

-- 
viresh
