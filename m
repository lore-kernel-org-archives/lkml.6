Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94DC4C10F00
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 20:00:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6607921479
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 20:00:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729458AbfBSUAQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 15:00:16 -0500
Received: from proxy01.fsdata.se ([89.221.252.211]:22220 "EHLO
        mail-gw01.fsdata.se" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725963AbfBSUAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 15:00:15 -0500
Received: from localhost (94.234.42.81) by DAG01.HMC.local (192.168.46.11)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 19 Feb 2019 21:00:05
 +0100
From:   Mattias Jacobsson <2pi@mok.nu>
To:     <andy@infradead.org>, <dvhart@infradead.org>,
        <mario.limonciello@dell.com>, <michal.lkml@markovi.net>,
        <mjg59@srcf.ucam.org>, <pali.rohar@gmail.com>,
        <yamada.masahiro@socionext.com>
CC:     <2pi@mok.nu>, <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 0/8] platform/x86: wmi: add WMI support to
Date:   Tue, 19 Feb 2019 20:59:48 +0100
Message-ID: <cover.1550603967.git.2pi@mok.nu>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [94.234.42.81]
X-ClientProxiedBy: PROXY05.HMC.local (192.168.46.55) To DAG01.HMC.local
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
[PATCH 3+/3]: update existing drivers to use MODULE_DEVICE_TABLE()

Changes in v4:
* formatting(declare/assignment, line-breaks) according to comments
* split "PATCH 3/3" into one patch per driver according to comments
* depend upon patch [3] (macro ALIAS_SIZE)

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
[3]: https://lore.kernel.org/lkml/20190207123022.7961-1-2pi@mok.nu/

Mattias Jacobsson (8):
  platform/x86: wmi: move struct wmi_device_id to mod_devicetable.h
  platform/x86: wmi: add WMI support to MODULE_DEVICE_TABLE()
  platform/x86: dell-smbios-wmi: use MODULE_DEVICE_TABLE() instead of
    MODULE_ALIAS()
  platform/x86: dell-wmi-descriptor: use MODULE_DEVICE_TABLE() instead
    of MODULE_ALIAS()
  platform/x86: dell-wmi: use MODULE_DEVICE_TABLE() instead of
    MODULE_ALIAS()
  platform/x86: huawei-wmi: use MODULE_DEVICE_TABLE() instead of
    MODULE_ALIAS()
  platform/x86: intel-wmi-thunderbolt: use MODULE_DEVICE_TABLE() instead
    of MODULE_ALIAS()
  platform/x86: wmi-bmof: use MODULE_DEVICE_TABLE() instead of
    MODULE_ALIAS()

 drivers/platform/x86/dell-smbios-wmi.c       |  2 +-
 drivers/platform/x86/dell-wmi-descriptor.c   |  2 +-
 drivers/platform/x86/dell-wmi.c              |  4 ++--
 drivers/platform/x86/huawei-wmi.c            |  3 +--
 drivers/platform/x86/intel-wmi-thunderbolt.c |  2 +-
 drivers/platform/x86/wmi-bmof.c              |  2 +-
 drivers/platform/x86/wmi.c                   |  2 +-
 include/linux/mod_devicetable.h              | 12 ++++++++++
 include/linux/wmi.h                          |  5 +----
 scripts/mod/devicetable-offsets.c            |  3 +++
 scripts/mod/file2alias.c                     | 23 ++++++++++++++++++++
 11 files changed, 47 insertions(+), 13 deletions(-)

-- 
2.20.1

