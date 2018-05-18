Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752825AbeERKeh (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 06:34:37 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:38547 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752136AbeERKbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 06:31:48 -0400
X-Google-Smtp-Source: AB8JxZpyRdmtYbBZW7mSgVcT7te2KR1Q0mfItucUJl3i5RdYMnbWrg8VRLAPluv8spJu31UVLy3z/w==
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
Subject: [PATCH 0/9] PM / Domains: Add support for multi PM domains per device
Date: Fri, 18 May 2018 12:31:21 +0200
Message-Id: <1526639490-12167-1-git-send-email-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
  PM / Domains: dt: Allow power-domain property to be a list of phandles
  PM / Domains: Don't attach devices in genpd with multi PM domains
  PM / Domains: Split genpd_dev_pm_attach()
  PM / Domains: Add support for multi PM domains per device to genpd
  PM / Domains: Add dev_pm_domain_attach_by_id() to manage multi PM
    domains

 .../devicetree/bindings/power/power_domain.txt     |  18 ++-
 drivers/base/power/common.c                        |  33 ++++-
 drivers/base/power/domain.c                        | 154 ++++++++++++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c            |   2 +-
 include/linux/pm_domain.h                          |  79 +++++------
 5 files changed, 208 insertions(+), 78 deletions(-)

-- 
2.7.4
