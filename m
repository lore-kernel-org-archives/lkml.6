Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id F2DC0C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 15:00:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B22A4208B0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 15:00:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B22A4208B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754335AbeFLPAC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 11:00:02 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:60429 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932750AbeFLPAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 11:00:00 -0400
Received: from 79.184.255.56.ipv4.supernova.orange.pl (79.184.255.56) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83)
 id af3db44557138fd8; Tue, 12 Jun 2018 16:59:58 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-pm@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jon Hunter <jonathanh@nvidia.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Todor Tomov <todor.tomov@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Kevin Hilman <khilman@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH v3 0/5] PM / Domains: Add support for multi PM domains per device
Date:   Tue, 12 Jun 2018 16:58:57 +0200
Message-ID: <3721375.shleKqokg2@aspire.rjw.lan>
In-Reply-To: <20180531105959.14843-1-ulf.hansson@linaro.org>
References: <20180531105959.14843-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, May 31, 2018 12:59:54 PM CEST Ulf Hansson wrote:
> Changes in v3:
> 	- Drop patch 1->4 as they have already been applied.
> 	- Collected tags, for tests and reviews.
> 	- Minor update to function descriptions in patch 4 (earlier 8) and 5
> 	(earlier9).
> 	- Note, because of the minor changes, no history is provided per patch.
> 
> Changes in v2:
> 	- Addressed comments from Geert around DT doc.
> 	- Addressed comments from Jon around clarification of how to use this
> 	and changes to returned error codes.
> 	- Fixed build error in case CONFIG_PM was unset.
> 
> There are devices that are partitioned across multiple PM domains. Currently
> these can't be supported well by the available PM infrastructures we have in
> the kernel. This series is an attempt to address this.
> 
> One existing case where devices are partitioned across multiple PM domains, is
> the Nvida Tegra 124/210 X-USB subsystem. A while ago Jon Hunter (Nvidia) sent a
> series, trying to address these issues, however this is a new approach, while
> it re-uses the same concepts from DT point of view.
> 
> The Tegra 124/210 X-USB subsystem contains of a host controller and a device
> controller. Each controller have its own independent PM domain, but are being
> partitioned across another shared PM domain for the USB super-speed logic.
> 
> Currently to make the drivers work, either the related PM domains needs to stay
> powered on always or the PM domain topology needs to be in-correctly modelled
> through sub-domains. In both cases PM domains may be powered on while they
> don't need to be, so in the end this means - wasting power -.
> 
> As stated above, this series intends to address these problem from a PM
> infrastructure point of view. More details are available in each changelog.
> 
> Kind regards
> Ulf Hansson
> 
> Ulf Hansson (5):
>   PM / Domains: dt: Allow power-domain property to be a list of
>     specifiers
>   PM / Domains: Don't attach devices in genpd with multi PM domains
>   PM / Domains: Split genpd_dev_pm_attach()
>   PM / Domains: Add support for multi PM domains per device to genpd
>   PM / Domains: Add dev_pm_domain_attach_by_id() to manage multi PM
>     domains
> 
>  .../bindings/power/power_domain.txt           |  19 ++-
>  drivers/base/power/common.c                   |  43 +++++-
>  drivers/base/power/domain.c                   | 134 +++++++++++++++---
>  include/linux/pm_domain.h                     |  15 ++
>  4 files changed, 183 insertions(+), 28 deletions(-)
> 
> 

Applied, thanks!


