Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43FCCC282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 13:15:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FA1C218D0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 13:15:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728330AbfAYNPX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 08:15:23 -0500
Received: from mga06.intel.com ([134.134.136.31]:65210 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726100AbfAYNPX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 08:15:23 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jan 2019 05:15:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,521,1539673200"; 
   d="scan'208";a="141283943"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 25 Jan 2019 05:15:20 -0800
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Chen Yu <chenyu56@huawei.com>, Jun Li <jun.li@nxp.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/8] device connection: Add support for device graphs
Date:   Fri, 25 Jan 2019 16:15:11 +0300
Message-Id: <20190125131519.88416-1-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series adds support for OF and ACPI device graph parsing to the
device connection API.

Handling the graph is straightforward, but because I'm adding that
fwnode member to struct device_connection, I had to make sure all the
existing users consider it.

The plan is to only support matching with fwnode in the future, so no
more device name matching. The software fwnodes that we now have in
kernel should make that possible, once we add support for references
to them.

The original RFC:
https://lkml.org/lkml/2018/10/24/619

thanks,

Heikki Krogerus (8):
  platform/x86: intel_cht_int33fe: Remove connection for the alt mode
    mux
  usb: typec: Rationalize the API for the muxes
  device connection: Add fwnode member to struct device_connection
  usb: typec: mux: Find the muxes by also matching against the device
    node
  usb: roles: Find the muxes by also matching against the device node
  usb: typec: Find the ports by also matching against the device node
  device connection: Prepare support for firmware described connections
  device connection: Find device connections also from device graphs

 drivers/base/devcon.c                    | 63 ++++++++++++++++-
 drivers/platform/x86/intel_cht_int33fe.c | 11 ++-
 drivers/usb/roles/class.c                | 21 +++++-
 drivers/usb/typec/class.c                | 31 ++++++---
 drivers/usb/typec/mux.c                  | 86 +++++++++++++++++++-----
 include/linux/device.h                   |  6 ++
 include/linux/usb/role.h                 |  1 +
 include/linux/usb/typec_mux.h            |  3 +-
 8 files changed, 185 insertions(+), 37 deletions(-)

-- 
2.20.1

