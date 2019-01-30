Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDD3BC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 15:14:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C24720989
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 15:14:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730653AbfA3POv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 10:14:51 -0500
Received: from proxy01.fsdata.se ([89.221.252.211]:30586 "EHLO
        mail-gw01.fsdata.se" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726455AbfA3POu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 10:14:50 -0500
Received: from localhost (94.234.42.28) by DAG01.HMC.local (192.168.46.11)
 with Microsoft SMTP Server (TLS) id 15.0.1263.5; Wed, 30 Jan 2019 16:14:45
 +0100
From:   Mattias Jacobsson <2pi@mok.nu>
To:     <andy@infradead.org>, <dvhart@infradead.org>,
        <mario.limonciello@dell.com>, <michal.lkml@markovi.net>,
        <mjg59@srcf.ucam.org>, <pali.rohar@gmail.com>,
        <yamada.masahiro@socionext.com>
CC:     <2pi@mok.nu>, <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 0/3] platform/x86: wmi: add WMI support to MODULE_DEVICE_TABLE()
Date:   Wed, 30 Jan 2019 16:14:37 +0100
Message-ID: <cover.1548860212.git.2pi@mok.nu>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [94.234.42.28]
X-ClientProxiedBy: PROXY04.HMC.local (192.168.46.54) To DAG01.HMC.local
 (192.168.46.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel provides the macro MODULE_DEVICE_TABLE() which can help
driver authors to generate the appropriate MODULE_ALIAS() output. The
WMI device type is currently not supported by MODULE_DEVICE_TABLE().

While using MODULE_DEVICE_TABLE() does increase the complexity as well
as spreading out the implementation across the kernel, it does come with
some benefits too;
* It makes different drivers look more similar; if you can specify the
  array of device_ids any device type specific input to MODULE_ALIAS()
  will automatically be generated for you.
* It helps each driver avoid keeping multiple versions of the same
  information in sync. That is, both the array of device_ids and the
  potential multitude of MODULE_ALIAS()'s.
* Other things eg. [2]

This patchset adds WMI support to MODULE_DEVICE_TABLE().

[PATCH 1/3]: prepare struct wmi_device_id
[PATCH 2/3]: add support
[PATCH 3/3]: update existing drivers to use MODULE_DEVICE_TABLE()

Changes in v3:
* use UUID_STRING_LEN instead of self-defined
* change loop condition in wmi_dev_match() according to comments
* change the usage of snprintf return code in do_wmi_entry()

Changes in v2:
* add one Suggested-by and one Reviewed-by tag
* depend upon patch [1]
* reword commit message for [PATCH 2/3] and [PATCH 3/3] to document the
  reasoning behind the changes

[1]: https://lkml.kernel.org/r/20190122200302.19861-1-2pi@mok.nu
[2]: https://lkml.kernel.org/r/20190126210634.GB13882@wrath

Mattias Jacobsson (3):
  platform/x86: wmi: move struct wmi_device_id to mod_devicetable.h
  platform/x86: wmi: add WMI support to MODULE_DEVICE_TABLE()
  platform/x86: wmi: use MODULE_DEVICE_TABLE() instead of MODULE_ALIAS()

 drivers/platform/x86/dell-smbios-wmi.c       |  2 +-
 drivers/platform/x86/dell-wmi-descriptor.c   |  2 +-
 drivers/platform/x86/dell-wmi.c              |  4 ++--
 drivers/platform/x86/huawei-wmi.c            |  3 +--
 drivers/platform/x86/intel-wmi-thunderbolt.c |  2 +-
 drivers/platform/x86/wmi-bmof.c              |  2 +-
 drivers/platform/x86/wmi.c                   |  2 +-
 include/linux/mod_devicetable.h              | 12 +++++++++++
 include/linux/wmi.h                          |  5 +----
 scripts/mod/devicetable-offsets.c            |  3 +++
 scripts/mod/file2alias.c                     | 22 ++++++++++++++++++++
 11 files changed, 46 insertions(+), 13 deletions(-)

-- 
2.20.1

