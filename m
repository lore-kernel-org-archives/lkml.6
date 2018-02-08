Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752176AbeBHSX2 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 13:23:28 -0500
Received: from esa8.dell-outbound.iphmx.com ([68.232.149.218]:59412 "EHLO
        esa8.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751544AbeBHSX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 13:23:26 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2GEAAB1lHxahz+a6ERdGQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQcBAQEBAYQngQAyjX+OJplXghgKhTuCMVQYAQIBAQEBAQECAQIQAQEBCA0?=
 =?us-ascii?q?JCCgvgjgig0oSAYEmAQQODYotsXSIeoI8hHyCFYY3hiSFMAWTGZESCZVzlEeYD?=
 =?us-ascii?q?IE8H4IKcIMZgmSCEo0ugRcBAQE?=
X-IPAS-Result: =?us-ascii?q?A2GEAAB1lHxahz+a6ERdGQEBAQEBAQEBAQEBAQcBAQEBAYQ?=
 =?us-ascii?q?ngQAyjX+OJplXghgKhTuCMVQYAQIBAQEBAQECAQIQAQEBCA0JCCgvgjgig0oSA?=
 =?us-ascii?q?YEmAQQODYotsXSIeoI8hHyCFYY3hiSFMAWTGZESCZVzlEeYDIE8H4IKcIMZgmS?=
 =?us-ascii?q?CEo0ugRcBAQE?=
From: <Mario.Limonciello@dell.com>
X-LoopCount0: from 10.166.132.172
X-IronPort-AV: E=Sophos;i="5.46,480,1511848800";
   d="scan'208";a="211577494"
X-DLP: DLP_GlobalPCIDSS
To: <pali.rohar@gmail.com>
CC: <platform-driver-x86@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dvhart@infradead.org>, <andy.shevchenko@gmail.com>
Subject: Dell SMBIOS initializing before backends are ready
Thread-Topic: Dell SMBIOS initializing before backends are ready
Thread-Index: AdOhB+4zpnFDLdnqQwKU0CvE6GdPRQ==
Date: Thu, 8 Feb 2018 18:23:23 +0000
Message-ID: <8da25d14004a4bd6ac7415c5958bcfc8@ausx13mpc120.AMER.DELL.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.143.18.86]
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w18INXQR015862

After Paul's recent message regarding the odd wifi issue he had a 
comment I wanted to investigate:

dell_smbios: "No dell-smbios drivers are loaded"

Coming up early in boot.  This is a side effect of dell-smbios having two
backend drivers that can be compiled as modules but no tie to force
them to initialize before calls to dell_smbios_call.

So I believe what is happening is dell_micmute_led_set is called from
the HDA driver and calls dell_smbios_call early too.

I haven't tried it on a platform with mic mute, but I suspect it might cause
the mic mute LED status to be wrong initially (but corrected later when 
toggled).

Ideas that came to mind:

1) In dell_smbios_call if no backends loaded, explicitly do a symbol_request
for both backends and run initialization at that time.

If that works, that would also resolve if someone manually unloaded both
backends but a kernel module still tried to perform a request.

2) Add a notifier chain for when the driver is ready (a backend is loaded)
to all consumers of dell_smbios_call.  Don't let other modules call
dell_smbios_call until notified.
Don't let the HDA driver call dell_micmute_led_set either.

3) try_module_get during dell-smbios initialization for both the backends

What's the correct way to address this?
