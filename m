Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754564AbeEaLAK (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 07:00:10 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:44267 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754455AbeEaLAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 07:00:07 -0400
X-Google-Smtp-Source: ADUXVKIbPyvw9G/ka8XKaOE6zfLohA30/UJyL3dx1uHpFlOlmj6MY7p4n8hX8Xkh20ipXr+yhyEoog==
From: Ulf Hansson <ulf.hansson@linaro.org>
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jon Hunter <jonathanh@nvidia.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Todor Tomov <todor.tomov@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Kevin Hilman <khilman@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org
Subject: [PATCH v3 0/5] PM / Domains: Add support for multi PM domains per device
Date: Thu, 31 May 2018 12:59:54 +0200
Message-Id: <20180531105959.14843-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v3:
	- Drop patch 1->4 as they have already been applied.
	- Collected tags, for tests and reviews.
	- Minor update to function descriptions in patch 4 (earlier 8) and 5
	(earlier9).
	- Note, because of the minor changes, no history is provided per patch.

Changes in v2:
	- Addressed comments from Geert around DT doc.
	- Addressed comments from Jon around clarification of how to use this
	and changes to returned error codes.
	- Fixed build error in case CONFIG_PM was unset.

There are devices that are partitioned across multiple PM domains. Currently
these can't be supported well by the available PM infrastructures we have in
the kernel. This series is an attempt to address this.

One existing case where devices are partitioned across multiple PM domains, is
the Nvida Tegra 124/210 X-USB subsystem. A while ago Jon Hunter (Nvidia) sent a
series, trying to address these issues, however this is a new approach, while
it re-uses the same concepts from DT point of view.

The Tegra 124/210 X-USB subsystem contains of a host controller and a device
controller. Each controller have its own independent PM domain, but are being
partitioned across another shared PM domain for the USB super-speed logic.

Currently to make the drivers work, either the related PM domains needs to stay
powered on always or the PM domain topology needs to be in-correctly modelled
through sub-domains. In both cases PM domains may be powered on while they
don't need to be, so in the end this means - wasting power -.

As stated above, this series intends to address these problem from a PM
infrastructure point of view. More details are available in each changelog.

Kind regards
Ulf Hansson

Ulf Hansson (5):
  PM / Domains: dt: Allow power-domain property to be a list of
    specifiers
  PM / Domains: Don't attach devices in genpd with multi PM domains
  PM / Domains: Split genpd_dev_pm_attach()
  PM / Domains: Add support for multi PM domains per device to genpd
  PM / Domains: Add dev_pm_domain_attach_by_id() to manage multi PM
    domains

 .../bindings/power/power_domain.txt           |  19 ++-
 drivers/base/power/common.c                   |  43 +++++-
 drivers/base/power/domain.c                   | 134 +++++++++++++++---
 include/linux/pm_domain.h                     |  15 ++
 4 files changed, 183 insertions(+), 28 deletions(-)

-- 
2.17.0
