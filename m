Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BD07C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 14:13:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E69562133F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 14:13:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="MRwIiVwF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733276AbeLQONo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 09:13:44 -0500
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:52511 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbeLQONn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 09:13:43 -0500
X-IronPort-AV: E=Sophos;i="5.56,365,1539673200"; 
   d="scan'208";a="22366013"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 17 Dec 2018 07:13:43 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.106) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Mon, 17 Dec 2018 07:13:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tuJv263tGe8h3AzwfWZaMNbSWZNEBAAuTghyVLMHBGs=;
 b=MRwIiVwFtDteUs1qZyGNXRkpoK4H6Db+ftXgLmHaKsfKoZYpJO0b93Tp432PalAbhWyPHGA+Aqhn74ITPzwSBCWx+v6ppamwmpxMGCWqQyS4nASORqQVee0T9ssQfcWWhLcL0mdddklWMf3cIJoNlOPKWZlcAQb92f+ISxKx+BE=
Received: from BY2PR11MB0744.namprd11.prod.outlook.com (10.163.112.142) by
 BY2PR11MB0584.namprd11.prod.outlook.com (10.163.159.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.19; Mon, 17 Dec 2018 14:13:37 +0000
Received: from BY2PR11MB0744.namprd11.prod.outlook.com
 ([fe80::cd88:53bd:589a:ab7f]) by BY2PR11MB0744.namprd11.prod.outlook.com
 ([fe80::cd88:53bd:589a:ab7f%2]) with mapi id 15.20.1425.021; Mon, 17 Dec 2018
 14:13:37 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <thierry.reding@gmail.com>, <robh@kernel.org>, <corbet@lwn.net>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>
CC:     <linux-pwm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <Claudiu.Beznea@microchip.com>
Subject: [PATCH v7 0/6] extend PWM framework to support PWM modes
Thread-Topic: [PATCH v7 0/6] extend PWM framework to support PWM modes
Thread-Index: AQHUlhKzksFWWUwQG0uTo0qGzE/WsQ==
Date:   Mon, 17 Dec 2018 14:13:36 +0000
Message-ID: <1545055999-23950-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1P195CA0015.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:800:d0::25) To BY2PR11MB0744.namprd11.prod.outlook.com
 (2a01:111:e400:52de::14)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BY2PR11MB0584;6:Lqnepj9WhEoN3GFo0R3/YhePRZQXSh9SQaIkWEYM4PVfNJXYlyzyDVSxNvjV9ZxHyoRybOyjtzFVKG9QPPKlKzEiLrASCGK3+dQJ9gQnTuIHGsqR2iyjhh26Qf0uI23rpYpVIPI+UyaYFKvf3T+Kl2ZsX3/c5CWIxx2JBSFC8krZfeeGw5yici8aLZ8y5OLRhtA+LgIy0hFGyy9wDdpCuZaEryo8i6ivWlj1QzVuXwc48MO0A+7hwzLAilV3ZzC4BvMBOSemU5mPXDJhMGV4NoHJ/uFtmls0zfHs5fijt3/cEAXqQacbl3Xv8zCvT5xpwUx9P6gaVnbamEQQ+LU8UpuG4DG3tTlP5GmFsjxec/rn3hR1xsV5Mkmw+MSqlUQsXZc21DZBzDSSnNRFuid4ItfODSb+zmriAnbXuq3IR7tNJCn9pCA/o5giwXrY8bnKLDMa39jY9D9VVvdUpxiWJg==;5:Ff3wXHr5MNEEdJNQmyv4txehLShOuzSTrFpiDA61v2uuIrTcSY9JekJpFZ6ekoBET95N1+ecWyY89hRbdD4R9Xie68xXNqOOBrEiNBJKPZPCZgrq2BF1GwQTVGRZ30GU7htXLTnaz+zoRJfFO3OV/6gLrc8OTKSeyX9j9xrxWig=;7:qX1j/t+WMsHObF5YUBZR6GI1b+a+yCXp1tPAoV01CJu0guXdp7jGLw5MTycpvWhskYcIlRI32RTAzkt0ypBUPdOjif9nP1Hw3dp3qMXOubbBMeUswGod1mejvogUcekbeH0wn6B/1uy63A+HWUCUxg==
x-ms-office365-filtering-correlation-id: 4dc95255-baf5-48fb-f7ae-08d66429d5f3
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BY2PR11MB0584;
x-ms-traffictypediagnostic: BY2PR11MB0584:
x-microsoft-antispam-prvs: <BY2PR11MB05843412CAEEE44416F1846787BC0@BY2PR11MB0584.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230021)(999002)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231475)(944501520)(4982022)(52105112)(93006095)(93001095)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:BY2PR11MB0584;BCL:0;PCL:0;RULEID:;SRVR:BY2PR11MB0584;
x-forefront-prvs: 08897B549D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(39860400002)(376002)(346002)(366004)(199004)(189003)(8676002)(25786009)(68736007)(6506007)(386003)(6116002)(102836004)(5660300001)(6436002)(966005)(66066001)(3846002)(39060400002)(478600001)(107886003)(71190400001)(2501003)(72206003)(256004)(305945005)(71200400001)(6486002)(7736002)(186003)(97736004)(26005)(52116002)(316002)(54906003)(476003)(6306002)(4326008)(2201001)(99286004)(14454004)(2616005)(2906002)(6512007)(36756003)(53936002)(110136005)(86362001)(6636002)(8936002)(81156014)(486006)(81166006)(105586002)(106356001);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR11MB0584;H:BY2PR11MB0744.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: nzOhB5H+SjrJtQV7XO0pOBydMZSA9SspMb3heMdvtC7DT2C2qeI4yYSHvhBbisCkjGwAsbpFsv+HtY7dWGaW8kdPlfPqa3Rh0M9pYlT3cGIf/TWy5TiycMcLb9wCTiQh6uEL84P9KqFwFPFhQ3Brr+LITiB5SN3oRx+XUH37adpSLf+VLc7OyXbCDJy96v1KFUBHYkBlvSqKgvj6R95D6lmoF4RoMzCdwQOae6pKSUtx1H8bPoqihpZ8/9ESr4GUtwUuVO6qAv6gQNXm0h1l/abqJZbeGu9HnXYsdCCc/5Q4Y9BYQqOXYEve+3wjNO7Q
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dc95255-baf5-48fb-f7ae-08d66429d5f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2018 14:13:36.8859
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR11MB0584
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

