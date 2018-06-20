Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E49EC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 05:18:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3370B20871
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 05:18:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="NkVzWPNw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3370B20871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754018AbeFTFS2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 01:18:28 -0400
Received: from mail-ve1eur01on0112.outbound.protection.outlook.com ([104.47.1.112]:15593
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753879AbeFTFSU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 01:18:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AckQOmRd7SnRSx2GGLRuK3kmEr+oTA7L/HdamQAWWNs=;
 b=NkVzWPNwRkKRDLBs2hpP25BLlfcKHkGzfThrUUI7CtzIzGQDGNVt5NW+ovhePF+ycd4+9rZl+QlJ0zPgfOK+XDBvdCFFlYvnm0afMk97f53BnA05v/SlA40QanCKxMLKGwP7rlb6OdsK8G8rCSaNuKYBfjmHM0n3oE21bYY1OYI=
Received: from orc.pedanet (85.226.244.23) by
 AM5PR0201MB2452.eurprd02.prod.outlook.com (2603:10a6:203:35::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.863.20; Wed, 20 Jun
 2018 05:18:12 +0000
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
        linux-samsung-soc@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-input@vger.kernel.org, linux-media@vger.kernel.org
Subject: [PATCH v2 00/10] Split i2c_lock_adapter into i2c_lock_root and i2c_lock_segment
Date:   Wed, 20 Jun 2018 07:17:53 +0200
Message-Id: <20180620051803.12206-1-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR05CA0127.eurprd05.prod.outlook.com
 (2603:10a6:7:28::14) To AM5PR0201MB2452.eurprd02.prod.outlook.com
 (2603:10a6:203:35::9)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d5ae7359-bf1d-4d00-7a21-08d5d66d3926
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:AM5PR0201MB2452;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2452;3:hxZKiM+IPsh8CBtKslYn70FLvEMi6PSY2Rs7QkY79shi5dCbWARaA9J/AYlHGDADGTLLc8BTEwONdEm7eUMSKWjAdND+DAkq7JnfdZ8h0zgSY6IcAT9DX++yY4GzzifkJ4UJ7V0Ik31gwbwZi7ED2Fh+8IjIahViIqq5Nw515Cgw3VEntgGlqqo5ZPtmdAwB+7AEZX5xMo1gj/oFo0h2pnwOuChbhsLv5JOTl14E/Ym+1AzeTxvCQn4+CoHznDbQ;25:Q9yq/FAvzYuy7fa1br42xLwaUo7C1aNoejHPxbmdrj73jRPg6jFl4wGlxVGNmnKZvAOf22sT4rzvtP5aOF+Cjme9uYdUJ6tptw8VqQVmvMk3kRwt7n3KXLLGi10Z2wGoqMxiTJCDFdegNHMGwciiIp/Tvl4U1j1WJ6fJ+DEW75xYbqzJDe9SZde2XROl53oO9g+wXMscuRy63Eu8bmAvdzlDgC+7pmsQHuLtGMKxrltttHYmiH1W/ab9ylrt7TNH3Q6etKzZC+ldK5l5icvxF1ZWoig49tCA8q544hgI2nhVxpm/7VGZFuH09ckPSeo0D5nYZeeSVje8S9NhklZ9GQ==;31:4ffmqhk2MpME9+uNUamR+LREhVyDqV8xRYGxhuzh1BNe9E3zNMj9U70Mu6z8NEc7V564Ibzi3tefnrupit/HJhB5SlZlmEDF+VjMnabQEiJe2f18ncly8ZZRaJerTaKX+rFtOQNiUIGvCDcI6obUF+eaUz8dqHGODY79SAcCSGvCWEPZzDGWoiH3EEookGIrB+X48j+dj/ipD5dBKs3wUrbVd9ztX4T3ebWzyGwUcU0=
X-MS-TrafficTypeDiagnostic: AM5PR0201MB2452:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
X-Microsoft-Antispam-PRVS: <AM5PR0201MB24527656E4F19B5E0AD2BE79BC770@AM5PR0201MB2452.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231254)(944501410)(52105095)(93006095)(93001095)(149027)(150027)(6041310)(2016111802025)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(6072148)(6043046)(201708071742011)(7699016);SRVR:AM5PR0201MB2452;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0201MB2452;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2452;4:VzcHaxJoAv1oWgiFOlY9yt7g2r53lbqv7vGmObPyCyKzhtkTGEP7uYs/EkI27PMuuduSK/Kkv3kmrdwHWUrrM3c7DEIMhf5Mn+NOuNpNuYhYPgjw0HUAEAobQPx2D/Zj8XCyt/EFONZfZrrWP9HEn4gs5DEuPSv9kEothAsXVvAM/KTDnGBDqu+K85g/idZdSHCqQyjv7IO2ZvEh2U/3vFWMJmvhx3Kt+BnBx54tHvKAsToXz8v8laTgCNWkld6C3xwORrP7ZHxpL8IROTN30A==
X-Forefront-PRVS: 070912876F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39830400003)(39380400002)(346002)(376002)(189003)(199004)(51416003)(50466002)(7416002)(6116002)(186003)(59450400001)(48376002)(3846002)(26005)(6916009)(53936002)(6666003)(1076002)(7406005)(6512007)(15760500003)(2906002)(316002)(386003)(36756003)(478600001)(6506007)(68736007)(86362001)(5660300001)(16586007)(50226002)(52116002)(54906003)(16526019)(2361001)(4326008)(2351001)(47776003)(25786009)(39060400002)(66066001)(8666007)(305945005)(486006)(8676002)(7736002)(97736004)(81166006)(956004)(106356001)(476003)(105586002)(81156014)(6486002)(2616005)(8936002)(74482002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM5PR0201MB2452;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM5PR0201MB2452;23:L5fFIWHjASCqs4kjgwsj6IvjP+Q4SX/KqlkRrfN?=
 =?us-ascii?Q?U1Nx43MHQPHWL7TDLZAEiGkH8FN0AwO+pAX90QRsC9uKd0pV3EkPdwZpgJkG?=
 =?us-ascii?Q?K7KDyUT58ii4cq48r3Wi5erSYJXb9rF30WhnrkgPU/Vw70xQ6+BaoGx5udFS?=
 =?us-ascii?Q?u++CyjCj4qL5USLrD4vzeHTiseSoiAOIwY0E2FUzmIYfXInBc4vzYPAwlThY?=
 =?us-ascii?Q?vlTry6QdKEW4i61BeI3A5Q8N71AuUQl/n7YI/894kpbLpHfviWb6AfX6sMPP?=
 =?us-ascii?Q?LxDeDHMlk/mxJLA9mnEaUMEy3PdTk5sgCQdWky+1Xwl3n9v86hPQ87cmpppk?=
 =?us-ascii?Q?bqin14m4AEh6VuoZtAY3IFlXDUYXyknDpMyxpoZTXyDE86kSkiF4wayigXZd?=
 =?us-ascii?Q?I0Out1yPNsr/2MeccEQ4MEVh3eN0Mz6dbCfBQClBr5I7yAEcpJt15xp+S2BM?=
 =?us-ascii?Q?6EUlxsnnXLQ7dTaabtAe2kDMx/+daE6XB4yQDFgB6Gc8KbfMIseFUeOWgKuJ?=
 =?us-ascii?Q?QUWdemhdaeC+tY1zUYtj1UU7P31igjC40DmFkqHC04w5kGB7fFz9D/qMvwH6?=
 =?us-ascii?Q?TbYcYCMPBeHS4OSjq9THW0UJiti6yg9S8m94j4Qf5psb+E+KEcTz6KVgoX2E?=
 =?us-ascii?Q?6yTjZercN5JOcVlC4stygRz8aplbC6qJeD7N0iBPUhFOOQTwsMRZLMfxNy5/?=
 =?us-ascii?Q?1Dh9ekMgaiA6kmKbySifJUup+6JukFuKNULKRR4yZiXgAwN2YiFjftiPeR6e?=
 =?us-ascii?Q?LhpMJLrA9DGtono3O/sfMI3/z/Rnni0W4AVAAhs+E6pEVQbl1Ywl7BKJft03?=
 =?us-ascii?Q?EG/yopQetfx3f7uFuKkdgVj66kYQmbbk1ZIgMZSPmmZm1uqealbA8ok5btRO?=
 =?us-ascii?Q?D/pNzjeDiNZ9We8QXDHWxiuJ2SPszKRnFFy1sdnXoDSvT1LrdvOFnuLh5lpw?=
 =?us-ascii?Q?hQQClL96N8Rn8UdVAJv44rErVFRoE/ASyR6IRlmy3RHQDlqjnJI0vOReVMjy?=
 =?us-ascii?Q?ptsoXt5DunyZNKjQY1Swv9532woF88Ht+3J/GHz01YHI+5X4X2BlnJzFYYIW?=
 =?us-ascii?Q?MWyIrWGqgfpHDScA/jjPkYC0sCZCjRgn1Z7i0j3d8FrIh7Tm4hHyH8KFspUL?=
 =?us-ascii?Q?AM4dRGzr3gpQulhgCAs8pTvXRH4tZ64Mna6hyfYMbD3Ft0hd+DLgdVS+ne2t?=
 =?us-ascii?Q?V2EJkCM2k0ld6d2yOAkeajezzbbXhyyaNHw773UCzxWF65zBx7i3G/DArhd0?=
 =?us-ascii?Q?UBICf2QjPM4C4QuXLxLGzUe51i4F3Q0JGBFfekeP5K4WN2JzOdgzUK03Ag3C?=
 =?us-ascii?Q?wwo3GFpHD0sNKmEbAP0Ozmdio0ORjeRoBF2fcFd8OMXC1fFOzaVpdmR6z8hv?=
 =?us-ascii?Q?61Ja9kEous2DyBAHN6L/z8n617Qo=3D?=
X-Microsoft-Antispam-Message-Info: SlMA3nUz3PgswXmKHEvSOBbFvsDR3uvKL9h1hOx9/EhowcAEwPNaKo517xU+Rkc4kv6HqO3FjxXrep0hUmBQknEhN7Flu1T80NEEQD2GW9LKYDSTYUWDRRkPNf+yDLChD6FNJXQAQTMMF7OjnvXbIEMY4KFc2zuSIBBmeEjCRlznPvggOdyeLwu1cj5PGpZe7uigtfGO6Uu01g+PlAAqqVbSdFWYopLUEIHasKXv5EQaWazSp+xZtIkMa7dRd99BS36UzbcngxIPfYcL9tKWQbkUC21/ApUf129CNmJCoYFqxp+C6N4wnO2iI32XSXYb
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2452;6:W0ROdZr5fwY1HY+WbUHClKlzMZu46/V5+qBoE7nBP4Vi0XLp9+lfQwpQXIi0if+++06exroCUIb2tbCJ3UinPNmGqiOKzNeC79YhOiUVJCYyJPesY2LMlt6qN24eYWs6vNwRjsQBiZ3vYlmwq9zS53iqyVfmHj1dctrJm3WBPca2T2ZrVQIWJPDgre0y8ftB/IDD/fCqwhNLuJtS2tMWzy6Ss2TL/pey65OZzebUDYxzS8+CIWMRm4q2zm3n6N0HNQfkqUsoGZ8i88kcI0Y4FCX4vCpjzPH9YU95Oh3wb9pc+5vuzmb+wNnb1+AAq1FDefGV1rLi7Dn8JwWJZXPIagtuWqtRRXIOSzwjMmKHnuPOZkx8EodVByuU59PZUavmkS0xh280EC5C66936Mk1ROEiwlYGmDQmOWm9EwK5fG6jlzqEyZBZE04HgKu9gTmru4/xxq88eo/QKEK3ONX9Kw==;5:IpRZarIt30euVDDDZmuO+GkxgQrbmRmRP1o6VDCzRoSO24/KyRiPFuEwJgENm1H5+qs6IBhIs4SLRjWRLmZF3pQyh98Z1V7TPriGqkFYYJduwSOall/6yMVHCO0dadxqJFOSma+8tkCb+3J5Npki5Oimgj/sM+Q6gXzaOBWFXVo=;24:wt/Pgg3Uhq5eZmKnll45K5HnHbEMdZixVv7OIG9sv1W8MqxK2fiNFtBz5RFdoeJTkgzSADADk+icxyzHslX6x9ce/qJRaEqgriFsSpoClYw=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2452;7:y9/0MHaQdsdKzoXdMHqMkN/FmsXdQwfZebuogjpNWRC7f1qk37Kq8PsJHgGElrzMHE/5m5CadVcNLf4RV2xwn6Zdxl3OhxpKWDxaxZ1Qd6vLt/hhUJBqaDguABz8fPJbDHqRVTeBAwG+sTvTpLmUTWEeoOZYJ/h8UzCGsLDfpzhKO9ZAEW/8SRmqkDk8uQIQ4kyETyFqwWWAYzITLmngUPDhqSg4bm4/l4ko6jk4H5qFJRoGPpto9MInqp4OWDMm
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2018 05:18:12.0458 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5ae7359-bf1d-4d00-7a21-08d5d66d3926
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0201MB2452
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

With the introduction of mux-locked I2C muxes, the concept of
locking only a segment of the I2C adapter tree was added. At the
time, I did not want to cause a lot of extra churn, so left most
users of i2c_lock_adapter alone and apparently didn't think enough
about it; they simply continued to lock the whole adapter tree.
However, i2c_lock_adapter is in fact wrong for almost every caller
(there is naturally an exception) that is itself not a driver for
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
be quite a surprise, especially for out-of-tree users, this series
instead removes the function and forces all users to explicitly
name I2C_LOCK_SEGMENT or I2C_LOCK_ROOT_ADAPTER in a call to
i2c_lock_bus, as suggested by Wolfram. Yes, users will be a teensy
bit more wordy, but open-coding I2C locking from random drivers
should be avoided, so it's perhaps a good thing if it doesn't look
too neat?

I suggest that Wolfram takes this series through the I2C tree and
creates an immutable branch for the other subsystems. The series
is based on v4.18-r1.

I do not have *any* of the affected devices, and have thus only
done build tests.

Cheers,
Peter

PS. for more background on mux-locked vs. parent-locked etc, see
Documentation/i2c/i2c-topology

Changes since v1:
- rebased to v4.18-rc1, thus removing the i2c-tegra hunk from
  the last patch
- Not adding i2c_lock_segment (et al) and remove i2c_lock_adapter
  instead of renaming it to i2c_lock_root, since having 8 closely
  related inline locking functions in include/linux/i2c.h was
  a few too many. I.e., instead going from 5 to 8, we are now
  going from 5 to 3.

Peter Rosin (10):
  tpm/tpm_i2c_infineon: switch to i2c_lock_bus(..., I2C_LOCK_SEGMENT)
  i2c: mux: pca9541: switch to i2c_lock_bus(..., I2C_LOCK_SEGMENT)
  input: rohm_bu21023: switch to i2c_lock_bus(..., I2C_LOCK_SEGMENT)
  media: af9013: switch to i2c_lock_bus(..., I2C_LOCK_SEGMENT)
  media: drxk_hard: switch to i2c_lock_bus(..., I2C_LOCK_SEGMENT)
  media: rtl2830: switch to i2c_lock_bus(..., I2C_LOCK_SEGMENT)
  media: tda1004x: switch to i2c_lock_bus(..., I2C_LOCK_SEGMENT)
  media: tda18271: switch to i2c_lock_bus(..., I2C_LOCK_SEGMENT)
  mfd: 88pm860x-i2c: switch to i2c_lock_bus(..., I2C_LOCK_SEGMENT)
  i2c: remove i2c_lock_adapter and use i2c_lock_bus directly

 drivers/char/tpm/tpm_i2c_infineon.c      |  8 +++----
 drivers/i2c/busses/i2c-brcmstb.c         |  8 +++----
 drivers/i2c/busses/i2c-davinci.c         |  4 ++--
 drivers/i2c/busses/i2c-gpio.c            | 40 ++++++++++++++++----------------
 drivers/i2c/busses/i2c-s3c2410.c         |  4 ++--
 drivers/i2c/busses/i2c-sprd.c            |  8 +++----
 drivers/i2c/i2c-core-slave.c             |  8 +++----
 drivers/i2c/muxes/i2c-mux-pca9541.c      |  6 ++---
 drivers/iio/temperature/mlx90614.c       |  4 ++--
 drivers/input/touchscreen/rohm_bu21023.c |  4 ++--
 drivers/media/dvb-frontends/af9013.c     |  8 +++----
 drivers/media/dvb-frontends/drxk_hard.c  |  4 ++--
 drivers/media/dvb-frontends/rtl2830.c    | 12 +++++-----
 drivers/media/dvb-frontends/tda1004x.c   |  6 ++---
 drivers/media/tuners/tda18271-common.c   |  8 +++----
 drivers/mfd/88pm860x-i2c.c               |  8 +++----
 include/linux/i2c.h                      | 12 ----------
 17 files changed, 70 insertions(+), 82 deletions(-)

-- 
2.11.0

