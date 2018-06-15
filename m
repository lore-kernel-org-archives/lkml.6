Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 9FB91C5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 10:15:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37F94208B2
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 10:15:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="dLsWYIRc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37F94208B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965601AbeFOKPm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 06:15:42 -0400
Received: from mail-db5eur01on0122.outbound.protection.outlook.com ([104.47.2.122]:4422
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934900AbeFOKPh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 06:15:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H0xTD1knj2k/QSQeJHX4Rlttzq2gU2othN05sYEafKc=;
 b=dLsWYIRcOKp80Hny2q6hcwSvcW2/V24JpuCPh6IJeQzChUC+L77eUZZyXGRrQVHocXbYHjChQ5DxmImHZFPoUYYkPfz6UwEwq0eX9sGS/Bsp/zJKX0FFUcJNJ+rDPQMvmjMh1gEhUYJF62TsnK0nVU6nLZTIjp6Sx9cNcBICWhk=
Received: from orc.pedanet (85.226.244.23) by
 HE1PR0201MB2460.eurprd02.prod.outlook.com (2603:10a6:3:82::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.16; Fri, 15 Jun 2018 10:15:32 +0000
From:   Peter Rosin <peda@axentia.se>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Rosin <peda@axentia.se>, Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Haavard Skinnemoen <hskinnemoen@gmail.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Guenter Roeck <linux@roeck-us.net>, Crt Mori <cmo@melexis.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Antti Palosaari <crope@iki.fi>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Michael Krufky <mkrufky@linuxtv.org>,
        Lee Jones <lee.jones@linaro.org>,
        linux-integrity@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-input@vger.kernel.org,
        linux-media@vger.kernel.org
Subject: [PATCH 00/11] Split i2c_lock_adapter into i2c_lock_root and i2c_lock_segment
Date:   Fri, 15 Jun 2018 12:14:55 +0200
Message-Id: <20180615101506.8012-1-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR05CA0248.eurprd05.prod.outlook.com
 (2603:10a6:3:fb::24) To HE1PR0201MB2460.eurprd02.prod.outlook.com
 (2603:10a6:3:82::8)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2161ef95-9e82-4ea4-900d-08d5d2a8edf0
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:HE1PR0201MB2460;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0201MB2460;3:QKDAbOgbon+kE7ihPiGAGz+M933IIdOuM4scgn0nqyUqOGdKcp/iafrZyveZQ8fTSgmiomrdYn3SGgoCUr9OOzvtmFLWfexo9mcMDuI3CALF3InkgtYFpTZYkmokNlxARr1OUq0RJ2Wy3WZHljFtU5r/uROo1y+RJ7kfi5SNoF7uXzG3t++1ETPYkbpTkTbyg3zYVwau2+vPlIFCKw5BhY46xi/rX/kcAPzPnyfcBTzC/FlssuPSAFvObHd9J1ny;25:WR+T8pO2iDZBD/loH0xuA045Z8V1WubCN4p9xIBjhjO2JPIauHiUFLe5p90Ey0cd29R9A7NQadqW3M22LnS6/6cp031zWlobATDCSHhhZRndVHeth+XhALn1SXPzXHhP5dl2QCXlKao9fJ7WxdSEQdrqJfltaFBPsSr1s21fNIScKJOe6X4X7ZLimt55zUjKmdmU3BBYDjNCZTfecfJeDBqiJWq4R7E2eJOn5bNBOlw04QRoFS2pdbvomUL4halxWqAmeYx4TckVBjimKBEWwWg/+GxjISawUU7R/4l1ar7HCn4cPro/YnmpNNGfbZybOYQ8UFVElG4yoe3OU9GgLw==;31:lnTlvs48ZW7OxwUolNyaWHCM9Iwkr4CqGBdSn9OJkT0QpgTs7XppGjVTlD2EdTeH1oNX+eYxRGKROFUheu74BLC6zset65v7NW+csOxFsP6fTJXDIoWrZCB9YY3pTY0bmmFRYpQCvvCU7cAXgIOEhccePb4pb0SKGlrdTRZjS9rwzGgo2wx4Oki9GhHUzOUXtYXn9OBUUSAbAoe70Q6OBtdsscAmrz1zYWh1J1svruw=
X-MS-TrafficTypeDiagnostic: HE1PR0201MB2460:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
X-Microsoft-Antispam-PRVS: <HE1PR0201MB2460DE3063BD507782B05250BC7C0@HE1PR0201MB2460.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(2016111802025)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(6072148)(6043046)(201708071742011)(7699016);SRVR:HE1PR0201MB2460;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0201MB2460;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0201MB2460;4:mitOHkOIz+1LbZOfgH5KVak9cCMSmbhz6R46Xk5StghVctLHUz2cf+B3c7bzW4mcFLgVHoX2jw0umaEjSqDPFdXdWufexWwhHXLV6/I7awg+4JTUk7dhp5akZ1m+/GryRy8vSBzGQrPZEWc+QQ3Oi/QCM16fWpoG3c6GAkfBAmeKAd+hy2RNRvkGeVBMXR7DkmoMJsvVNoi/+jtdsSDQglKR0meeJdb89uDY5bx6v4U6gCmrhUiwfPXcyPSpvkXvejv5qp6czMa6pddB9nFbqg==
X-Forefront-PRVS: 0704670F76
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(346002)(376002)(396003)(39830400003)(39380400002)(52314003)(199004)(189003)(186003)(16526019)(97736004)(50466002)(386003)(50226002)(68736007)(81166006)(8676002)(74482002)(26005)(52116002)(6666003)(478600001)(51416003)(2351001)(81156014)(59450400001)(8936002)(6506007)(2906002)(15760500003)(6116002)(3846002)(1076002)(6916009)(48376002)(86362001)(7416002)(7406005)(106356001)(66066001)(2361001)(8666007)(305945005)(4326008)(39060400002)(53936002)(36756003)(316002)(5660300001)(476003)(7736002)(105586002)(6486002)(6512007)(54906003)(956004)(47776003)(25786009)(2616005)(486006)(16586007)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0201MB2460;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR0201MB2460;23:7NwhRc87CJ81UUqtJwWpVZwXHvTu/wyUCP2np1z?=
 =?us-ascii?Q?Cy6gxt8BjHlo5zx0UEwLZv+7mmysHzP1lj2ZAVpnLI0gSKcHADJaBjG+VLLu?=
 =?us-ascii?Q?9XMEv8ECfASonEdzh3r7tKT9LtlakZOabYDMrEl3rWbdWyyjLL0xM17QfpZd?=
 =?us-ascii?Q?y8+c/Ve2Mbc0ET40Y8hu5io9m9+KYkQQtOBwELAqZogv1UfsNQb3pzqG4eO3?=
 =?us-ascii?Q?9N0hTGIHSjgFT62pX6aCOyRbCg+VVXwPZlUpLXsQ5H3RTbiqsQU1+9XYzx5y?=
 =?us-ascii?Q?SdETdDU50BPBoF7NrQ/3P3RS5LnSRATKXVRe3tZt4S7qQRS1HLbSK7vSKP+v?=
 =?us-ascii?Q?f3QnigYlEkynamEzGWaV/yrvPC6FEpJKY/Rss7xGQrDXvZXL9IIQcW98uchi?=
 =?us-ascii?Q?TtzmhZHU4NMtzLpWkNMr00hm5Zqv1DY6S6zzyrjmVpi2fu/44rjsx5ilPbuM?=
 =?us-ascii?Q?XsfTipTMz+okuX9ZblYGNKjeMykWpZ+VEsNXoC5Coi6ZCYx/zPsvZ/5BL6da?=
 =?us-ascii?Q?KW2xDEtrKbITzhLTYsm6XLGYk2QC4ONlLEQ0KWv8BvE9szuEXklRy5Bk7+Vz?=
 =?us-ascii?Q?MBhkGB7FDf2qyaOK3JjJ5bgHMuygKf1UjHz8TW7UX2ffPWAOCChme69BwGIs?=
 =?us-ascii?Q?z7MdsSk1pfakW6dbiJ/2ZPSF9oxDObEY7DWwR0nbJHs3+j/wl8BTMAr4B9Wu?=
 =?us-ascii?Q?XR2QJZvtgPBoDpzaVCP78CTSzfAwI+2G0Kdp1Py2LCDwOdHG1AQ3z7uKgB8o?=
 =?us-ascii?Q?5zqXc8sXHAjNO+FFeGnoUEmF0kB7VBnuO9NdksfvkGPoxs4J4rfJMJn08DF7?=
 =?us-ascii?Q?SE315mPZluu+6jfYMTRLtHMo714YYn2Odd9vTzeStKH1vuMQhr0vUfmgosXJ?=
 =?us-ascii?Q?0hN2BO2tcspWmP9JX0piPbRdz3u0CrM46/IFEDSORI8Ds3mrwHxmp/rnUpEL?=
 =?us-ascii?Q?3qJRFiPc5cu2FKsrUM0P8kyJ41Zg2J6pcxGq2myuBe62RGI7gtw8Rdsy8857?=
 =?us-ascii?Q?twLLNbVz/3hrYcwkbyjasyg1vTQJjV+2G+tNUO7absSIEV/9DQHaStOyZTIp?=
 =?us-ascii?Q?XmOwzIZwXSig5o17Ov8Ub0m5TxvcKua0I78RAGxPwQxhDCEemQq1cjOYSzTr?=
 =?us-ascii?Q?9Im77/03DkcUU2fElWWITyZgljRINwYEA86RChcbaislbWHpjOSrlnUtJcZq?=
 =?us-ascii?Q?35opFUmYzmC0CODLw52mSPWCYVmxAvgXN7G+LUfZdq7AsoYnIDkPav2NCAZN?=
 =?us-ascii?Q?rKHLEU2AN9GsTdZKYmE4l/k7gNRM1Mck0yEIynB9DzaTPYhsVMZM1nfjkXcG?=
 =?us-ascii?Q?e62FruUK95Z0XwPYu/c80SA/6G5gkoWGjnAjiL4v76DboxQmfPsifrtpG1Mh?=
 =?us-ascii?Q?JKqehi6l5nJzGMYBGieS8Aq2INtPFUAf/339WhYiGnDDxNPP7?=
X-Microsoft-Antispam-Message-Info: Uz/M/cwis4lH51Sjt1fAIrSd7HYHFlc9bWC6yJo/miOr8TjN7Lo1eCdaUOi4HaScKsTxdj0lJhsRIhXsKk4oneZAu//9sLH9fAxME/6YBQr96LhlCMoK2xQ6X+mL4METdq7fQu57/W89nBJhn8GoQuKTniqS/ZNyKd0m4plkv4as0slZTzTEwWZEfVpm1o7b
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0201MB2460;6:ovn3WM83Z1ldBSGrJ63Ffna026+EtAFhowvlmkUkmFrloDahlfRvhp67j2ZeeAZspIEyjqaG1NwzxjawWK4pJMKQr1oKG0E1mnTogYpmX7TlVmAfqqBrlFwujc022G1UM2Jo5tQgkV7yapYn9LsIUCqSYPvuTa2wBT07+AVnc03WdM7rLXIks2C/0YfnhX8YbdrwUVeRkCSkt7/558h775tCdTeMxR2rOBYO7vjp1aIkQG7BdBj+/dLHckfqqR9gu88kgpNHcRY3UTg820e+dgDWwjm4Vp99IJTbb24dO95ppzDfuCPQLhddgRB1cnZw97A1/SY4U1nGsNWpezsGjVsDB8fWukgLpEcgU3nMxCeQr3e8jxMmvlaRLYZr1B4Gm2ETndt2xaJdk2sv19O1UtPP/dZ0XR7neN8aqFh6xZuPAmEUpylSz0HA0INo2xPFqu7ZTS85PYV2SZ/Xf1V44A==;5:qN+DHcAYqqgjx9hTQXLoVp7X7CELA60Ke47gQqoDk5jzrDxwVanBWgHmqTTxAnTqWzWpRTmrz5vnrvbflXYQcOQfwY7Lss2AOUZYobt7SZXhhE76GuwK4MiPOAeQCfaJG3lGk3B2CgBPxDEVqlG+VIMu8aeQJaISCH3pXGwN1ro=;24:Y+Y2DBsQ1KTnp2XnPj0/pU1cwVZvO0rA/voW0S87vLU00FphLaefmU7o5oDZkoTwjc/VWJqq7yuIVyDgxe+nhpVlWgp/8OXP4pSrlz3M3Jo=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0201MB2460;7:sF5m9nR6h7lebMLGBJykJ6w6UaTanvyjiU0cjGvZ9RVgOF6stBxqfUsHlUbzLzzmBJ540yxKvbJulK0R7tJja8/RPgtCWBaxLj3sZ9tSMxj3SaqSLaDVI62UfMN8RanfrJlO98o6sZEAsI9/HlKFNv3X50h0vUCDV7Qupx9KYvPbtBGoU2EnnOajQ38q0dYW/phwGTbVPF4jUn1PC03s8zL2SsczdS6B1kpz5rswyhqayTjR3xU0K0nxWGnACA3R
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2018 10:15:32.1253 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2161ef95-9e82-4ea4-900d-08d5d2a8edf0
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0201MB2460
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

With the introduction of mux-locked I2C muxes, the concept of
locking only a segment of the I2C adapter tree was added. At the
time, I did not want to cause a lot of extra churn, so left most
users of i2c_lock_adapter alone and aparently didn't think enough
about it; they simply continued to lock the whole adapter tree.
However, i2c_lock_adapter is in fact wrong for almost every caller
(there are naturally exceptions) that is itself not a driver for
a root adapter. What normal drivers generally want is to only
lock the segment of the adapter tree that their device sits on.

In fact, if a device sits behind a mux-locked I2C mux, and its
driver calls i2c_lock_adapter followed by an unlocked I2C transfer,
things will deadlock (since even a mux-locked I2C adapter will lock
its parent at some point). If the device is not sitting behind a
mux-locked I2C mux (i.e. either directly on the root adapter or
behind a (chain of) parent-locked I2C muxes) the root/segment
distinction is of no consequence; the root adapter is locked either
way.

Mux-locked I2C muxes are probably not that common, and putting any
of the affected devices behind one is probably even rarer, which
is why we have not seen any deadlocks. At least not that I know
of...

Since silently changing the semantics of i2c_lock_adapter might
be quite a surprise, especially for out-of-tree users, this
series instead introduces new helpers to make it easier to only
lock the I2C segment, then converts drivers over and finally
renames the remaining i2c_lock_adapter instances to i2c_lock_root.

I suggest that Wolfram takes this series through the I2C tree
and creates an immutable branch for the other subsystems. The
series is based on v4.17, but I did not find any new instances in
neither linus-master nor linux-next and the series still applies
cleanly to linus-master for me. linux-next has removed suspend
support from the i2c-tegra driver. A bit strange, I thought the
I2C changes was merged for this window? Anyway, the resolution
for that conflict is trivial, just remove the i2c-tegra hunk from
patch 11.

I do not have *any* of the affected devices, and have thus only
done build tests.

Cheers,
Peter

Peter Rosin (11):
  i2c: add helpers for locking the I2C segment
  tpm/tpm_i2c_infineon: switch to i2c_lock_segment
  i2c: mux: pca9541: switch to i2c_lock_segment
  input: rohm_bu21023: switch to i2c_lock_segment
  media: af9013: switch to i2c_lock_segment
  media: drxk_hard: switch to i2c_lock_segment
  media: rtl2830: switch to i2c_lock_segment
  media: tda1004x: switch to i2c_lock_segment
  media: tda18271: switch to i2c_lock_segment
  mfd: 88pm860x-i2c: switch to i2c_lock_segment
  i2c: rename i2c_lock_adapter to i2c_lock_root

 drivers/char/tpm/tpm_i2c_infineon.c      |  8 ++++----
 drivers/i2c/busses/i2c-brcmstb.c         |  8 ++++----
 drivers/i2c/busses/i2c-davinci.c         |  4 ++--
 drivers/i2c/busses/i2c-gpio.c            | 12 ++++++------
 drivers/i2c/busses/i2c-s3c2410.c         |  4 ++--
 drivers/i2c/busses/i2c-sprd.c            |  8 ++++----
 drivers/i2c/busses/i2c-tegra.c           |  8 ++++----
 drivers/i2c/i2c-core-base.c              |  6 +++---
 drivers/i2c/i2c-core-slave.c             |  8 ++++----
 drivers/i2c/i2c-core-smbus.c             |  4 ++--
 drivers/i2c/muxes/i2c-mux-pca9541.c      |  6 +++---
 drivers/iio/temperature/mlx90614.c       |  4 ++--
 drivers/input/touchscreen/rohm_bu21023.c |  4 ++--
 drivers/media/dvb-frontends/af9013.c     |  8 ++++----
 drivers/media/dvb-frontends/drxk_hard.c  |  4 ++--
 drivers/media/dvb-frontends/rtl2830.c    | 12 ++++++------
 drivers/media/dvb-frontends/tda1004x.c   |  6 +++---
 drivers/media/tuners/tda18271-common.c   |  8 ++++----
 drivers/mfd/88pm860x-i2c.c               |  8 ++++----
 include/linux/i2c.h                      | 22 ++++++++++++++++++++--
 20 files changed, 85 insertions(+), 67 deletions(-)

-- 
2.11.0

