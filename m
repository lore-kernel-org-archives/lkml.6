Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11E87C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 13:48:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1A6B2054F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 13:48:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1A6B2054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbeLKNsj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 08:48:39 -0500
Received: from foss.arm.com ([217.140.101.70]:47592 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726530AbeLKNsj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 08:48:39 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3C3FA1596;
        Tue, 11 Dec 2018 05:48:35 -0800 (PST)
Received: from queper01-lin (queper01-lin.cambridge.arm.com [10.1.195.48])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B4FAF3F59C;
        Tue, 11 Dec 2018 05:48:33 -0800 (PST)
Date:   Tue, 11 Dec 2018 13:48:32 +0000
From:   Quentin Perret <quentin.perret@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] OPP: Fix missing debugfs supply directory for OPPs
Message-ID: <20181211134829.nct4uqvofn332yxp@queper01-lin>
References: <90e3577b5feb42bac1269e16bb3d2bdd8f6df40f.1544527580.git.viresh.kumar@linaro.org>
 <46f48aca2e5aef3f430e95d1a5fb68227ec8ec85.1544527580.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46f48aca2e5aef3f430e95d1a5fb68227ec8ec85.1544527580.git.viresh.kumar@linaro.org>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 11 Dec 2018 at 16:56:29 (+0530), Viresh Kumar wrote:
> There is one case where we may end up with no "supply" directory for the
> OPPs in debugfs. That happens when the OPP core isn't managing the
> regulators for the device and the device's OPP do have microvolt
> property. It happens because the opp_table->regulator_count remains set
> to 0 and the debugfs routines don't add any supply directory in such a
> case.
> 
> This commit fixes that by setting opp_table->regulator_count to 1 in
> that particular case. But to make everything work nicely and not break
> other parts of the core, regulator_count is defined as "int" now instead
> of "unsigned int" and it can have different special values now. It is
> set to -1 initially to mark it "uninitialized" and later only we set it
> to 0 or positive values after checking how many supplies are there.
> 
> This also helps in finding the bugs where only few of the OPPs have the
> "opp-microvolt" property set and not all.

Tested on Juno r0 and Hikey960 successfully. The 'supply' directory is
now correctly exposed.

Feel free to add Tested-by: Quentin Perret <quentin.perret@arm.com>

Thanks,
Quentin
