Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42AE7C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:03:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C9C2207E0
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:03:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731826AbfA3QDD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 11:03:03 -0500
Received: from mga02.intel.com ([134.134.136.20]:60152 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728943AbfA3QDD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 11:03:03 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Jan 2019 08:03:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,541,1539673200"; 
   d="scan'208";a="142760833"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 30 Jan 2019 08:03:00 -0800
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Chen Yu <chenyu56@huawei.com>, Jun Li <jun.li@nxp.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/9] device connection: Add support for device graphs
Date:   Wed, 30 Jan 2019 19:02:50 +0300
Message-Id: <20190130160259.46919-1-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is the second version of this series. On top the two code style
improvements requested by Andy, I also renamed the connection
identifiers used with the USB Type-C muxes for something that I felt
are better, especially after we start using them to name reference
device properties in fwnodes. That's why the first patch is now split
in two, 1/9 and 3/9.

Hans! Please note that there is no functional change. The alt mode
device is still getting a handle to the mux, just like before.
That was actually happening also in the first version of the series.

The commit message from v1:

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

Heikki Krogerus (9):
  platform/x86: intel_cht_int33fe: Prepare for better mux naming scheme
  usb: typec: Rationalize the API for the muxes
  platform/x86: intel_cht_int33fe: Remove old style mux connections
  device connection: Add fwnode member to struct device_connection
  usb: typec: mux: Find the muxes by also matching against the device
    node
  usb: roles: Find the muxes by also matching against the device node
  usb: typec: Find the ports by also matching against the device node
  device connection: Prepare support for firmware described connections
  device connection: Find device connections also from device graphs

 drivers/base/devcon.c                    | 62 ++++++++++++++-
 drivers/platform/x86/intel_cht_int33fe.c | 15 ++--
 drivers/usb/roles/class.c                | 21 +++++-
 drivers/usb/typec/class.c                | 31 ++++++--
 drivers/usb/typec/mux.c                  | 96 ++++++++++++++++++++----
 include/linux/device.h                   |  6 ++
 include/linux/usb/role.h                 |  1 +
 include/linux/usb/typec_mux.h            |  3 +-
 8 files changed, 195 insertions(+), 40 deletions(-)

-- 
2.20.1

