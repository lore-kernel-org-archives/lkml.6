Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933149AbeE2KEf (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 06:04:35 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:56148 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932828AbeE2KE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 06:04:28 -0400
X-Google-Smtp-Source: ADUXVKKKTekgJ6oP7wcHUvmuuqTyTGddJhGStQ3mQRGsqqljHPLB+jxkBjOeF1AjX2rCTeQg8IE8mw==
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
Subject: [PATCH v2 0/9] PM / Domains: Add support for multi PM domains per device
Date: Tue, 29 May 2018 12:04:12 +0200
Message-Id: <20180529100421.31022-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v2:
	- Addressed comments from Geert around DT doc.
	- Addressed comments from Jon around clarification of how to use this
	and changes to returned error codes.
	- Fixed build error in case CONFIG_PM was unset.

There are devices that are partitioned across multiple PM domains. Currently
these can't be supported well by the available PM infrastructures we have in
the kernel. This series is an attempt to address this.

The interesting parts happens from patch 5 an onwards, including a minor DT
update to the existing power-domain bindings, the 4 earlier are just trivial
clean-ups of some related code in genpd, which I happened to stumble over.

Some additional background:

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

It should be noted that this series has been tested on HW, however only by using
a home-cooked test PM domain driver for genpd and together with a test driver.
This allowed me to play with PM domain (genpd), runtime PM and device links.

Any further deployment for real use cases are greatly appreciated. I am happy to
to help, if needed!

Kind regards
Ulf Hansson


Ulf Hansson (9):
  PM / Domains: Drop extern declarations of functions in pm_domain.h
  PM / Domains: Drop __pm_genpd_add_device()
  PM / Domains: Drop genpd as in-param for pm_genpd_remove_device()
  PM / Domains: Drop unused parameter in genpd_allocate_dev_data()
  PM / Domains: dt: Allow power-domain property to be a list of
    specifiers
  PM / Domains: Don't attach devices in genpd with multi PM domains
  PM / Domains: Split genpd_dev_pm_attach()
  PM / Domains: Add support for multi PM domains per device to genpd
  PM / Domains: Add dev_pm_domain_attach_by_id() to manage multi PM
    domains

 .../bindings/power/power_domain.txt           |  19 ++-
 drivers/base/power/common.c                   |  39 ++++-
 drivers/base/power/domain.c                   | 155 ++++++++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c       |   2 +-
 include/linux/pm_domain.h                     |  79 ++++-----
 5 files changed, 216 insertions(+), 78 deletions(-)

-- 
2.17.0
