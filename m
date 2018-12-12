Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 867F4C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 04:47:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BAD220851
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 04:47:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hTZlo6l/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BAD220851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbeLLErj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 23:47:39 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34895 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726220AbeLLEri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 23:47:38 -0500
Received: by mail-pl1-f194.google.com with SMTP id p8so8009147plo.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 20:47:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dJtdsd23pE4g56G8u/5DoOJLWhUru0LSOGIwvhiYqLI=;
        b=hTZlo6l/gDIKS4ZDf3RW6VdkjkMmn4Qh/yeejALvNEBBmybWlBktFEJU9SVKikYNVu
         02sNZ4g5RgNW+yvHbzZXC0ionTDl/WDchpC5iyrSnty1KAhNJVj51Uuhcw7QkPIDcCcM
         Ffi+3Pvd0wjcuWet5x7z42MLl7BdL3cPlgUW4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dJtdsd23pE4g56G8u/5DoOJLWhUru0LSOGIwvhiYqLI=;
        b=Xb5nwr955GanWo3Si3dOUgKNLvpw8IujIG8jhj4wcRBw0vEqu2U6CTHteotV4DyxnJ
         Wu9gPEoBYE8ge+I3P5afhva/MfQqoAFrUaOs33z6cu/PBvqZuKG55/ytDvb1AQZEbbwv
         ICBrqnH9fk6eZ6GW0h4bDJa1qCQothEovAVTOXDXdgTW6Eva3E5mOiZdjJGZf6VyvvJM
         KhpSzMXXS7rggJxFh3qp50dbyUhWeZwRgO/9lEfedxq3ZaiEPgoxHwDGWJ/YoUwSZsBV
         TNfqRFJkNYVrrxB5jby1vnmpiN8SaXWWhzF/xxFatgR73Sue50zzz3F4wTFuEMalYrvz
         7IKw==
X-Gm-Message-State: AA+aEWbO3HjRQZCshrPVzuGJ59FF3koGfQaB2TqPhqh8oQaJ6HQLW5H5
        N5UupAwRncKtJdULhZrHdpKCPw==
X-Google-Smtp-Source: AFSGD/XjkMEOIayiIpsxrOvR+L9XeVnq9Wp3Ldq/L56PXQaSQ7tNCgIO8q48WaQ+Kz7yydgfGkaHaQ==
X-Received: by 2002:a17:902:f81:: with SMTP id 1mr17961344plz.174.1544590057787;
        Tue, 11 Dec 2018 20:47:37 -0800 (PST)
Received: from localhost ([122.172.23.29])
        by smtp.gmail.com with ESMTPSA id t67sm28600396pfd.90.2018.12.11.20.47.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 20:47:37 -0800 (PST)
Date:   Wed, 12 Dec 2018 10:17:32 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Quentin Perret <quentin.perret@arm.com>
Cc:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] OPP: Fix missing debugfs supply directory for OPPs
Message-ID: <20181212044732.ile3icfr5g4tvezi@vireshk-i7>
References: <90e3577b5feb42bac1269e16bb3d2bdd8f6df40f.1544527580.git.viresh.kumar@linaro.org>
 <46f48aca2e5aef3f430e95d1a5fb68227ec8ec85.1544527580.git.viresh.kumar@linaro.org>
 <20181211134829.nct4uqvofn332yxp@queper01-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181211134829.nct4uqvofn332yxp@queper01-lin>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11-12-18, 13:48, Quentin Perret wrote:
> On Tuesday 11 Dec 2018 at 16:56:29 (+0530), Viresh Kumar wrote:
> > There is one case where we may end up with no "supply" directory for the
> > OPPs in debugfs. That happens when the OPP core isn't managing the
> > regulators for the device and the device's OPP do have microvolt
> > property. It happens because the opp_table->regulator_count remains set
> > to 0 and the debugfs routines don't add any supply directory in such a
> > case.
> > 
> > This commit fixes that by setting opp_table->regulator_count to 1 in
> > that particular case. But to make everything work nicely and not break
> > other parts of the core, regulator_count is defined as "int" now instead
> > of "unsigned int" and it can have different special values now. It is
> > set to -1 initially to mark it "uninitialized" and later only we set it
> > to 0 or positive values after checking how many supplies are there.
> > 
> > This also helps in finding the bugs where only few of the OPPs have the
> > "opp-microvolt" property set and not all.
> 
> Tested on Juno r0 and Hikey960 successfully. The 'supply' directory is
> now correctly exposed.
> 
> Feel free to add Tested-by: Quentin Perret <quentin.perret@arm.com>

Thanks.

-- 
viresh
