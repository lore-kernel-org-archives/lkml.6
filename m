Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E18BCC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 01:01:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85A142075B
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 01:01:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Due1ds6P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85A142075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728693AbeIGFOT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:14:19 -0400
Received: from mail-eopbgr710107.outbound.protection.outlook.com ([40.107.71.107]:21288
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728163AbeIGFOQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:14:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=urtDv5J2Q+FqJO2ldPc+6k0HTiDIMEvjESjMV+uVHVA=;
 b=Due1ds6PdkbZP0ajH+dWXMM0Wq8SrqbhPzDBci362UzOlxW1zjW7LebEYz8fEd6IHKCVfvk0/ADC+4dBqlCi00gMIZSsfod0F964DItM1jpOnhBhXrF4QE/8jNcxvaG+oD/B95SbKNxr6LVDxDSDPoacVVhPU1l1gB3jbB1vio0=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0824.namprd21.prod.outlook.com (10.173.192.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.8; Fri, 7 Sep 2018 00:36:08 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:36:08 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 23/88] kbuild: do not update config when running
 install targets
Thread-Topic: [PATCH AUTOSEL 4.18 23/88] kbuild: do not update config when
 running install targets
Thread-Index: AQHURkLE+ghjyIPBsU+BKHUd/JgDLg==
Date:   Fri, 7 Sep 2018 00:36:08 +0000
Message-ID: <20180907003547.57567-23-alexander.levin@microsoft.com>
References: <20180907003547.57567-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003547.57567-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0824;6:8U9JZ7SFxow7ODrxQ4vHyNO8yA4wh+prP7Mt/J60EpglwLPGWPxHQaIOydpCacRePE1inHkHdDGqxaZVqVksb8SesgScAAGIu3BQYDX3J7045gwGpEM5OlIJQD0rmD9u1jRQSVpcPKuKk3DY5dFaLYu7rtfqDN1mJA9/d5HbZ1k7GLLOcAKGsmvy4cMysUUe3+hgbDinCxqFkzy5O8l8x0pG5jlREIyTBuI2u+eEmvWDXDwiOvFH48xedmYjf+07U0OBKp3mZZDUqvasB6yhyERLC1Bg8dGAAPIOZLeUvgdbhMWxKp3iLBDTr/CtWkff9t+Lrem7Je/oyiHWP1funUhqLJ0yRPRZSr/XeO2KknHnzafvN+f+M3CVwWS5ZUfokqfECrhXL7J6wQOXFrk5H5EOexebd9XHKvp8Nopnn1ZddijLxJp1Z9e0INgsTSu1uT+TYj8CLlm0jNc/hZgFHg==;5:Jm2XkewGBbMo1bxt4xoIwa7OrCuHIumGlxkk8WyQYIxxkGhoNn8OfAHAQDD5SdYIaTGT8d1pSc1cyLLtqBUJFi+YNe+EpP1B9GF0F2S8U+rv4jX6euC4ubDE4JVpS9TjJzKhd6XpF4aznh9iqS4XADKsarmAqCWRbzMRbwkBk7o=;7:FTfEMuOPc31l4QAjC3aBcDAdPHg6hXKweoelgVmxkcuNtnrbsRRSmqsm0gXuCrgARpvCnL63JKPERFkDX4tq13EexCYtpq2m9h6Yt3iyXLoTq/srlwyBtYtbpbboewyyzydFLekxYvn048SmEzcSSvIC9bO+6p5MVv4oSHPjkikRlmYXqkElfLJKjgFTP4xwfYONrudwdpFHlzdvxLfS/RS7agBIMUc7PJx4xFX3N/YrdcWwSXgTPt+Nptc3i/sn
x-ms-office365-filtering-correlation-id: c11c64c4-1c70-4188-9948-08d61459e777
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0824;
x-ms-traffictypediagnostic: CY4PR21MB0824:
x-microsoft-antispam-prvs: <CY4PR21MB0824F131E8CE9B3B2388102BFB000@CY4PR21MB0824.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231344)(944501410)(52105095)(2018427008)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0824;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0824;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39860400002)(376002)(346002)(136003)(199004)(189003)(22452003)(14444005)(256004)(102836004)(6506007)(217873002)(10290500003)(186003)(26005)(5660300001)(4326008)(6346003)(81156014)(81166006)(110136005)(54906003)(72206003)(316002)(575784001)(1076002)(6116002)(3846002)(8936002)(107886003)(14454004)(86612001)(2900100001)(105586002)(106356001)(5250100002)(86362001)(76176011)(2501003)(53936002)(10090500001)(68736007)(66066001)(36756003)(6436002)(99286004)(6512007)(486006)(25786009)(2906002)(6486002)(15650500001)(478600001)(7736002)(305945005)(2616005)(476003)(11346002)(97736004)(8676002)(446003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0824;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: CfxGZNTjVhinrMtAOS54Zy2seO0Qyl3tyxLaQAKC23XubxVRzH/ATraR7RwCaai9ARRR4Pp1eCA7jmsXhex+N8RceSyx0uUXt56enPmqRnM2Z6wLL3GLHEQoPXs4s97NmAwy8fh8783Cz4swt18ic+hO+EJWkYiFgCO4vGtYHbVO//j/eHeLV4aDGrX+bxx9qTq+gMGHtnfgqSLu1tiXENZskXac66JcEwsqoWZdUwwADqyi3lyx5QVvvevAwedBjENOm5S3cZtxpPHTWkqxGNumCDCKA5i30T3EJmv3TrnnWDJzKkzCaw0PADmDiOIeFz8aQWTrUkGeRwHvBoAefoueISp5g6u1n/M/Mh2Yjw4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c11c64c4-1c70-4188-9948-08d61459e777
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:36:08.5672
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0824
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masahiro Yamada <yamada.masahiro@socionext.com>

[ Upstream commit d79424137a7312d381d131d707a462440c0e8df9 ]

"make syncconfig" is automatically invoked when any of the following
happens:

 - .config is updated
 - any of Kconfig files is updated
 - any of environment variables referenced in Kconfig is changed

Then, it updates configuration files such as include/config/auto.conf
include/generated/autoconf.h, etc.

Even install targets (install, modules_install, etc.) are no exception.
However, they should never ever modify the source tree.  Install
targets are often run with root privileges.  Once those configuration
files are owned by root, "make mrproper" would end up with permission
error.

Install targets should just copy things blindly.  They should not care
whether the configuration is up-to-date or not.  This makes more sense
because we are interested in the configuration that was used in the
previous kernel building.

This issue has existed since before, but rarely happened.  I expect
more chance where people are hit by this; with the new Kconfig syntax
extension, the .config now contains the compiler information.  If you
cross-compile the kernel with CROSS_COMPILE, but forget to pass it
for "make install", you meet "any of environment variables referenced
in Kconfig is changed" because $(CC) is referenced in Kconfig.
Another scenario is the compiler upgrade before the installation.

Install targets need the configuration.  "make modules_install" refer
to CONFIG_MODULES etc.  "make dtbs_install" also needs CONFIG_ARCH_*
to decide which dtb files to install.  However, the auto-update of
the configuration files should be avoided.  We already do this for
external modules.

Now, Make targets are categorized into 3 groups:

[1] Do not need the kernel configuration at all

    help, coccicheck, headers_install etc.

[2] Need the latest kernel configuration

    If new config options are added, Kconfig will show prompt to
    ask user's selection.

    Build targets such as vmlinux, in-kernel modules are the cases.

[3] Need the kernel configuration, but do not want to update it

    Install targets except headers_install, and external modules
    are the cases.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 Makefile | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/Makefile b/Makefile
index a41692c5827a..d21929d160a4 100644
--- a/Makefile
+++ b/Makefile
@@ -225,10 +225,12 @@ no-dot-config-targets :=3D $(clean-targets) \
 			 cscope gtags TAGS tags help% %docs check% coccicheck \
 			 $(version_h) headers_% archheaders archscripts \
 			 kernelversion %src-pkg
+no-sync-config-targets :=3D $(no-dot-config-targets) install %install
=20
-config-targets :=3D 0
-mixed-targets  :=3D 0
-dot-config     :=3D 1
+config-targets  :=3D 0
+mixed-targets   :=3D 0
+dot-config      :=3D 1
+may-sync-config :=3D 1
=20
 ifneq ($(filter $(no-dot-config-targets), $(MAKECMDGOALS)),)
 	ifeq ($(filter-out $(no-dot-config-targets), $(MAKECMDGOALS)),)
@@ -236,6 +238,16 @@ ifneq ($(filter $(no-dot-config-targets), $(MAKECMDGOA=
LS)),)
 	endif
 endif
=20
+ifneq ($(filter $(no-sync-config-targets), $(MAKECMDGOALS)),)
+	ifeq ($(filter-out $(no-sync-config-targets), $(MAKECMDGOALS)),)
+		may-sync-config :=3D 0
+	endif
+endif
+
+ifneq ($(KBUILD_EXTMOD),)
+	may-sync-config :=3D 0
+endif
+
 ifeq ($(KBUILD_EXTMOD),)
         ifneq ($(filter config %config,$(MAKECMDGOALS)),)
                 config-targets :=3D 1
@@ -606,7 +618,7 @@ ARCH_CFLAGS :=3D
 include arch/$(SRCARCH)/Makefile
=20
 ifeq ($(dot-config),1)
-ifeq ($(KBUILD_EXTMOD),)
+ifeq ($(may-sync-config),1)
 # Read in dependencies to all Kconfig* files, make sure to run syncconfig =
if
 # changes are detected. This should be included after arch/$(SRCARCH)/Make=
file
 # because some architectures define CROSS_COMPILE there.
@@ -621,8 +633,9 @@ $(KCONFIG_CONFIG) include/config/auto.conf.cmd: ;
 include/config/%.conf: $(KCONFIG_CONFIG) include/config/auto.conf.cmd
 	$(Q)$(MAKE) -f $(srctree)/Makefile syncconfig
 else
-# external modules needs include/generated/autoconf.h and include/config/a=
uto.conf
-# but do not care if they are up-to-date. Use auto.conf to trigger the tes=
t
+# External modules and some install targets need include/generated/autocon=
f.h
+# and include/config/auto.conf but do not care if they are up-to-date.
+# Use auto.conf to trigger the test
 PHONY +=3D include/config/auto.conf
=20
 include/config/auto.conf:
@@ -634,7 +647,7 @@ include/config/auto.conf:
 	echo >&2 ;							\
 	/bin/false)
=20
-endif # KBUILD_EXTMOD
+endif # may-sync-config
=20
 else
 # Dummy target needed, because used as prerequisite
--=20
2.17.1
