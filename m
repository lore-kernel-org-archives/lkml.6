Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DEF9C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 13:29:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C19AE2073D
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 13:29:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="Jji48ZZ0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731735AbfACN3u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 08:29:50 -0500
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:20956 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730107AbfACN3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 08:29:49 -0500
X-IronPort-AV: E=Sophos;i="5.56,435,1539673200"; 
   d="scan'208";a="25939503"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 03 Jan 2019 06:29:47 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.107) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Thu, 3 Jan 2019 06:30:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JJ3DYfRqlQ8cG3lvyhPI6N0rrc7G1RJU/AG/Iq/Pq14=;
 b=Jji48ZZ0rbtVUJ6UwOKllIVGmTE37X9kuRPUKzVTmCbNbiRcaRcTPYQ1fU3D2JZW2CZZE3esKOwPKkzfrPZlxzRINrmF6KmqPPa2U0vaDGAZLNPV9jNiWn5C2Q+tdPG1qpmTdSI+JTtGXP6ECPOtmfEKokCwPO53OnMt0YpPMGU=
Received: from MWHPR11MB1920.namprd11.prod.outlook.com (10.175.54.19) by
 MWHPR11MB1984.namprd11.prod.outlook.com (10.175.54.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.6; Thu, 3 Jan 2019 13:29:41 +0000
Received: from MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::e553:ff9d:8c0b:9627]) by MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::e553:ff9d:8c0b:9627%6]) with mapi id 15.20.1495.005; Thu, 3 Jan 2019
 13:29:41 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <thierry.reding@gmail.com>, <corbet@lwn.net>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>
CC:     <linux-pwm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <Claudiu.Beznea@microchip.com>
Subject: [PATCH v8 0/6] extend PWM framework to support PWM modes
Thread-Topic: [PATCH v8 0/6] extend PWM framework to support PWM modes
Thread-Index: AQHUo2hi9GpKj2IHbUqVaUAAIe8U4g==
Date:   Thu, 3 Jan 2019 13:29:41 +0000
Message-ID: <1546522081-23659-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR07CA0209.eurprd07.prod.outlook.com
 (2603:10a6:802:3f::33) To MWHPR11MB1920.namprd11.prod.outlook.com
 (2603:10b6:300:110::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR11MB1984;6:RibiKHV9WS2sDvuZ1Hk8l+pNIz+cb7yedaH9qi/J4GIWiSzGXZtaRB9oW+6n5jKWeie9OBUl7N1NKpoERHMfgae4T/82oF5jp4E4uShhEl6WOF0KCDSa7TRZPiHBoGk4TDJCaGi941l3j3gAp1c84/pIZIoPJwISlolfPiXVhjo3ppeyMTXMbvdR9hJXV7wWNv/GhGjyzoriQk+UAJnxOjQVHCxEWlj33/ztxN5hTzoLB0rmXsF6U0qfDXU0Jh7Zfod50sUFyi1hHgP7Df9YpjXTRie8HE78LJj57pVtJb2iXaofYd2PDvD73Uzd5xRkxf3jul5VtssCGZJMBqiOL6QS8XauvDEKlIQTv7ub2A5x0Q9Nc8kCed3W5jpbA4uBQqPG9nK4AlL48b3iqWe79FlzzVGk0i12kUwpHGYEFmzAJoXpmD1KT7RsGbFbGPfrMYxPEo2TY2emduvt3PhZ7g==;5:47CPkl0/jylqIF2u0Azx7mwDv0flvnII/p5XUPKAKj2WzAlSQtlVhy9cxT2tkHgPGuoZ9SUVfEef33ShuA6jte6Oa3Ax9vt1cmpXWYKy0v49hwiOPt+KZcTmcJfZN9tDWYYoD3kOUaH3UeAanzW6G897L+JCCibezVSwLDRBppy9oe6n6fNxijW8HfO0jhxwE3fPuX4PDhICdZeq6Q00Tg==;7:NcmA4V0ITu7r+Rx31DkMs1QuD+DuKHqyNgqj5BXxHJJ2VlRI0Tv7g7zT9NHkBogWbBOk8gFNnLHuv1aS0UfZyozA2Jb8flB4cV/gYubvCQyfmSNg0PpBjuml7GRqXHaUrFVa2p97fn1uVQXHr03XQw==
x-ms-office365-filtering-correlation-id: 16d48eea-d5e5-4395-40cf-08d6717f8451
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600109)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:MWHPR11MB1984;
x-ms-traffictypediagnostic: MWHPR11MB1984:
x-microsoft-antispam-prvs: <MWHPR11MB1984FD18CD1951F1F8521191878D0@MWHPR11MB1984.namprd11.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(93006095)(93001095)(3231475)(944501520)(4982022)(52105112)(3002001)(10201501046)(6041310)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:MWHPR11MB1984;BCL:0;PCL:0;RULEID:;SRVR:MWHPR11MB1984;
x-forefront-prvs: 0906E83A25
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(376002)(346002)(396003)(366004)(199004)(189003)(71190400001)(6486002)(966005)(2501003)(72206003)(14454004)(2616005)(476003)(97736004)(5660300001)(478600001)(316002)(6636002)(86362001)(99286004)(54906003)(52116002)(110136005)(71200400001)(6436002)(6512007)(6306002)(186003)(53936002)(305945005)(7736002)(3846002)(39060400002)(6506007)(386003)(6116002)(105586002)(106356001)(107886003)(68736007)(36756003)(4326008)(26005)(81156014)(81166006)(102836004)(8936002)(66066001)(2906002)(486006)(8676002)(256004)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1984;H:MWHPR11MB1920.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 7x+YQGpCVG7Ux1VTjdkafBsMVA6fTlvgk6RoAMI/yLihHsOMzQeGMKB1REVZ6xfQb0oOCt+v4WKcFuMlAf5jDkG9zVVFaIW3/BA35mhFoP+Vzwb2Um9sEMeB8QJJywR98UWW/hfey18NYdhJFYvZSzt8ymzSI6NIwixV6wPtA1zGGv+pOapietcTilj/rzzsjx0aiZ2lCzBxy485KHfVM4OJ8rqGesbG/4PFfM8OnddCxT+OzNRPD8RxfT+R/KZWt+AZMEXHSGJGMHAqdcMbGsZhtVp7/AkQZraTs1zAmY9/hl7puGioYJ3iGQS82DEm
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 16d48eea-d5e5-4395-40cf-08d6717f8451
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2019 13:29:41.6968
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1984
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea@microchip.com>

Hi,

This series extends PWM framework with PWM modes.

The current patch series add the following PWM modes:
- PWM mode normal
- PWM mode complementary
- PWM mode push-pull

In the following description PWMx_y refers to output y of PWM with ID x.

Normal mode - for PWM channels with one output; output waveforms looks like
this:
              __      __      __      __                                   =
     =20
    PWMx   __|  |____|  |____|  |____|  |__                                =
     =20
             ^       ^       ^       ^                                     =
     =20

    Where '^' specifies the beginning of a period.

Since PWMs with more than one output per channel could be used as one
output PWM the normal mode is the default mode for all PWMs (if not specifi=
ed
otherwise).

Complementary mode - for PWM channels with two outputs; output waveforms
for a PWM channel in complementary mode looks line this:
              __      __      __      __                                   =
     =20
    PWMx_0 __|  |____|  |____|  |____|  |__                                =
     =20
           __    ____    ____    ____    __                                =
     =20
    PWMx_1   |__|    |__|    |__|    |__|                                  =
     =20
             ^       ^       ^       ^                                     =
     =20

    Where '^' specifies the beginning of a period.

Push-pull mode - for PWM channels with two outputs; output waveforms for a
PWM channel in push-pull mode with normal polarity looks like this:
              __              __                                           =
      =20
    PWMx_0 __|  |____________|  |__________                                =
      =20
                      __              __                                   =
      =20
    PWMx_1 __________|  |____________|  |__                                =
      =20
             ^       ^       ^       ^                                     =
      =20

    If polarity is inversed:
           __    ____________    __________                                =
      =20
    PWMx_0   |__|            |__|                                          =
      =20
           __________    ____________    __                                =
      =20
    PWMx_1           |__|            |__|                                  =
      =20
             ^       ^       ^       ^                                     =
      =20

    Where '^' specifies the beginning of a period.
=20
The PWM working modes are per PWM channel registered as PWM's capabilities.
The driver registers itself to PWM core a get_caps() function, in
struct pwm_ops, that will be used by PWM core to retrieve PWM capabilities.
If this function is not registered in driver's probe, a default function
will be used to retrieve PWM capabilities. Currently, the default
capabilities includes only PWM normal mode.

PWM state has been updated to keep PWM mode. PWM mode could be configured
via sysfs. pwm_apply_state() will do the preliminary validation for PWM mod=
e
to be applied.

In sysfs, user could get PWM modes by reading mode file of PWM device:
root@sama5d2-xplained:/sys/class/pwm/pwmchip0/pwm2# ls -l
total 0
-r--r--r-- 1 root root 4096 Oct 11 18:08 capture
-rw-r--r-- 1 root root 4096 Oct 11 18:14 duty_cycle
-rw-r--r-- 1 root root 4096 Oct 11 18:11 enable
-rw-r--r-- 1 root root 4096 Oct 11 18:14 mode
-rw-r--r-- 1 root root 4096 Oct 11 18:09 period
-rw-r--r-- 1 root root 4096 Oct 11 18:14 polarity
drwxr-xr-x 2 root root    0 Oct 11 18:08 power
-rw-r--r-- 1 root root 4096 Oct 11 18:08 uevent
root@sama5d2-xplained:/sys/class/pwm/pwmchip0/pwm2# cat mode
normal complementary [push-pull]

The mode enclosed in bracket is the currently active mode.

The mode could be set, via sysfs, by writing to mode file one of the modes
displayed at read:
root@sama5d2-xplained:/sys/class/pwm/pwmchip0/pwm2# echo normal > mode
root@sama5d2-xplained:/sys/class/pwm/pwmchip0/pwm2# cat mode
[normal] complementary push-pull=20

The PWM push-pull mode could be usefull in applications like half bridge
converters (see [1], page 2126).

This series also add PWM modes support for Atmel/Microchip SoCs.

Thank you,
Claudiu Beznea

[1] http://ww1.microchip.com/downloads/en/DeviceDoc/DS60001476B.pdf

Changes in v8:
- fix kbuild error

Changes in v7:
- use proper number of patches in cover letter title

Changes in v6:
- get rid of DT changes;
- get rid of get_default_caps member of struct pwm_chip;
- remove struct pwm_chip argument of pwm_get_caps(); caps are retrieved
  in the context of a PWM device and at this moment the chip should be vali=
d;
  also, get rid of chip->ops check in pwm_get_caps();
- rename pwm_mode_get_valid() function to pwm_get_default_modebit();
- rename mode member of struct pwm_caps to modes_msk;
- rename pwm_mode_valid() function to pwm_supports_mode() and rename
  its mode argument to modebit to emphasize what should be passed to it;
- rename pwm_mode_desc() to pwm_get_mode_name() and avoid returning "invali=
d"
  string; pwm_get_mode_name() is called only with a valid modebit;
- rename mode member of struct pwm_state to modebit to emphasize that it st=
ores
  a bitmask;
- use const arguments for pwm_get_default_modebit(), pwm_get_caps(),
  pwm_supports_mode() and get_caps() member of struct pwm_ops;
- change return type of pwm_ops::get_caps() to int;
- rename PWMC_MODE() macro to PWM_MODE_BIT();
- rename PWMC_MODE_<mode-name>_BIT enum members to PWM_MODE_<mode-name>;
- remove patches 2/9, 3/9, 4/9 from previous version since they were relate=
d
  to DT changes;
- use PWMx_y naming in documentation to emphasize it is talked about output
  y of PWM x;
- use 1/3 duty factor in waveforms from documentation patches;
- use '^' to emphasize the beginning of a new period in documentation patch=
es.

Changes in v5:
- solved kbuild errors by removing dummy functions for case where
  CONFIG_PWM is not defined; adopted this approach since the removed
  function are used only when CONFIG_PWM is defined (in PWM core
  and few drivers from drivers/pwm/ directory)

Changes in v4:
- removed changes related to pwm_config() as per maintainer proposals
- added pwm_mode_get_valid() to retrieve a valid PWM mode fror PWM device
  instead of using BIT(ffs(caps.mode) - 1) and changed drivers to use
  pwm_mode_get_valid() instead of pwm_get_caps() + BIT(ffs(caps.mode) - 1)
  (patches 2, 3, 4 from this series)
- renamed PWM_MODE() macro in PWMC_MODE() to avoid conflicts with
  pwm-sun4i.c driver ('C' stands for capability)
- removed pwm_caps_valid() function
- renamed PWM_DTMODE_COMPLEMENTARY and PWM_DTMODE_PUSH_PULL macros in
  PWM_MODE_COMPLEMENTARY and PWM_MODE_PUSH_PULL

Changes in v3:
- removed changes related to only one of_xlate function for all PWM drivers
- switch to PWM capabilities per PWM channel nor per PWM chip
- squash documentation and bindings patches as requeted by reviewer
- introduced PWM_MODE(name) macro and used a bit enum for pwm modes
- related to DT bindings, used flags cell also for PWM modes
- updated of_xlate specific functions with "state->mode =3D mode;"
  instructions to avoid pwm_apply_state() failures
- use available modes for PWM channel in pwm_config() by first calling
  pwm_get_caps() to get caps.modes
- use loops through available modes in mode_store()/mode_show() and also in
  of_pwm_xlate_with_flags() instead of "if else" instructions; in this way,
  the addition of a new mode is independent of this code sections
- use DTLI=3D1, DTHI=3D0 register settings to obtain push-pull mode wavefor=
ms
  for Atmel/Microchip PWM controller.

Changes in v2:
- remove of_xlate and of_pwm_n_cells and use generic functions to pharse DT
  inputs; this is done in patches 1, 2, 3, 4, 5, 6, 7 of this series; this =
will
  make easy the addition of PWM mode support from DT
- add PWM mode normal
- register PWM modes as capabilities of PWM chips at driver probe and, in c=
ase
  driver doesn't provide these capabilities use default ones
- change the way PWM mode is pharsed via DT by using a new input for pwms
  binding property


Claudiu Beznea (9):
  pwm: extend PWM framework with PWM modes
  pwm: clps711x: populate PWM mode in of_xlate function
  pwm: cros-ec: populate PWM mode in of_xlate function
  pwm: pxa: populate PWM mode in of_xlate function
  pwm: add PWM modes
  pwm: atmel: add pwm capabilities
  pwm: add push-pull mode support
  pwm: add documentation for pwm push-pull mode
  pwm: atmel: add push-pull mode support

 Documentation/devicetree/bindings/pwm/pwm.txt |  11 ++-
 Documentation/pwm.txt                         |  42 ++++++++-
 drivers/pwm/core.c                            | 125 ++++++++++++++++++++++=
+++-
 drivers/pwm/pwm-atmel.c                       | 118 +++++++++++++++++-----=
--
 drivers/pwm/pwm-clps711x.c                    |  10 ++-
 drivers/pwm/pwm-cros-ec.c                     |   1 +
 drivers/pwm/pwm-pxa.c                         |   1 +
 drivers/pwm/sysfs.c                           |  61 +++++++++++++
 include/dt-bindings/pwm/pwm.h                 |   2 +
 include/linux/pwm.h                           |  64 +++++++++++++
 10 files changed, 395 insertions(+), 40 deletions(-)

--=20
2.7.4

