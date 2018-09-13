Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C068DC04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 08:25:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 384BD20866
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 08:25:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="uXJjbA7F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 384BD20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=synaptics.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727278AbeIMNdb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 09:33:31 -0400
Received: from mail-bl2nam02on0054.outbound.protection.outlook.com ([104.47.38.54]:15328
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726495AbeIMNda (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 09:33:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QcIQQDLzraG/B9zB0qjjWdBfNpQ8//NO4oDLUE1uEhM=;
 b=uXJjbA7FW16fGt2fXBmyvAJtTCgvFjykFKs/BeEkFgZwRh4+Ejs/rL0Kd56sRrsRf0aBi0b1cf3rL1jliCgl+MsK9XdRqn2V5qBvQqd4rE6SP5OVcq+bcT4DEA9XfXLRKOMsZB3ySAWlUW3vy8wfAT2mhFBvU7rEM1QUEOkS9Cc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
Received: from xhacker.debian (124.74.246.114) by
 SN1PR0301MB1584.namprd03.prod.outlook.com (2a01:111:e400:5232::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1122.16; Thu, 13 Sep
 2018 08:24:58 +0000
Date:   Thu, 13 Sep 2018 16:21:32 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Wolfram Sang <wsa@the-dreams.de>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] i2c: designware: select gpio/default pin when
 prepare/unprepare recovery
Message-ID: <20180913162132.17c9c2b3@xhacker.debian>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: OSAPR01CA0143.jpnprd01.prod.outlook.com
 (2603:1096:604:f::35) To SN1PR0301MB1584.namprd03.prod.outlook.com
 (2a01:111:e400:5232::18)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cc94a946-60eb-4c84-5d15-08d6195265fe
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:SN1PR0301MB1584;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR0301MB1584;3:CVCZ98M5KgMhH2MckiLrYEGJQMV6P9ALUpOZurgabMh2A8jAvKYwfYjnfQRlzEKGkSp8T8iP+ugZSOCe+8Y0If189umwyH9dxSCG60sH30xWW9q4wOBbRuPu7+UTT+tDIR87FZIl3dewoC2KBt5PJ2gMMP7curwLPKhgO94LzyP0G5Rd+1oNlm/yD9tu47fLcdJUw3uNFhvgb0Jpy4Xs9XNhfAS3GvEauDfd7r8LvMfo8NfzOYOknekm+2uBmkJS;25:Q2rrDaIZdMbGVKgLLNW7C9bUSo0IuuI7qwvkdiNr4+Ml8/R4nC4zaSxQ3JO0MJIu2qatYiVkf0xX55Rz7x0dsKOx12Cz08y2zU52qi6/CHzHtrE+NL4AbLJVdPLl0zL61o7Su5IoGCqqlXa4sZnZFoIYX+ghE/zDHk5jOnyjD+wxBmw3WEPm/OzPembN/BQdktPLu1QtRTm20gQMD5IO5652JPLtAqW7ADxZ0NEr15NH8PdobaHaHEMvb/UTIRArjYit5+jErh/QpCXcs3jEHp6NjFPiw2XMK7rpDKZDwHetOZzdS/vVVxT5xDmilLGuRiQXon4wb6znzQauSRQH6Q==;31:+/aknbqbzEUSbQkYGudH6WuOuP4M34qNxThdNn+tRqt2fdWnTn2CfSnSfqJO/khZv9k2USuPKfR6Sdr3aFx9Fh1MN72aFyp947oJt5KmwEjrNXwl9no/Bptjj2/pfQf4Pok3C61ZDyXHgfpjLX2Iq0FHKo5yQye6NKE/sCT6LcT4e0u4gOc0A/aK9KVsPm/8W6KgwmXZaMfJxBtZfiyDbJlmznswfBAWDMcyB3BNXm4=
X-MS-TrafficTypeDiagnostic: SN1PR0301MB1584:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR0301MB1584;20:ByGeMdXfAAF8jRVJEqTKMfgN3vXdOvG1E+T+iA6slwVjcGvr8z9oIroDemRwvzrmIZjQld0zAz5dIOarwMNE2/6/6sS+yicHJNlSEpws5qEL7Rtb5/JyeptUHVLPqxQ8bo/DZdTTbDfyBOhFPYAen4M4ZGTpT8FLNyV1yUoFo+8LUt7Sg0cTVYZCUaiVPY0ipfmMpfyTsCSqXjEXO8wK+7ej/K2yB4bsP/HeNsSfdqIwXc0I2qpS7Herni3pHj40Pkc+IdNqjJmgzRRoaL+oO2f2AfLg7XHdPB7TCLqP+rPdUyBfw3w82yUbFCh1EKh4J1/1vOAq8OodVhTzxutE89BAMpAI99R1s81OHaDmiv+afgjn+8HaQ3zIEkQY/G8RmyD3afBHZtFDnYJDs2eCdyJejr0EfV1o+Vutho7i4KFK8Ad8cf9O8tjkxsDpXJE7k1trUmBKjTTdcAWDbENV22Q7L7J9N559dMn/RYYzzr7tGFYh6Lqs75NwJDg3yO92;4:WXgY43IQFWONAlQ1z1Fz3Lwm34ImVH8Ic/eNlDSSyzivAk6jDBP/0qT+ZR3WwBpfrEUOFIT1vUcPWfZFXwUB6Nw7H101mQyF8UNnIf4pVYMeLRx3KBSF0QzIv90CfsH3x/zHyJ9E7a2NtUluxXnGdCJJlbjmDOQ4tGioADdvhbl68rBEazPODLAX8y3p7IabgsPinDyX7zhP2011UwKNSd/oX4/5hFCr8bb8iV1lz4m4B02FM3ZUk1pt1eY49MCjHfllUTbwf2Xt0ALqu+plKw==
X-Microsoft-Antispam-PRVS: <SN1PR0301MB1584E556526E6FA94D2C0266ED1A0@SN1PR0301MB1584.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231311)(944501410)(52105095)(93006095)(93001095)(149027)(150027)(6041310)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(20161123564045)(20161123560045)(201708071742011)(7699050);SRVR:SN1PR0301MB1584;BCL:0;PCL:0;RULEID:;SRVR:SN1PR0301MB1584;
X-Forefront-PRVS: 07943272E1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(396003)(376002)(346002)(39830400003)(199004)(189003)(97736004)(5660300001)(186003)(16526019)(68736007)(305945005)(26005)(52116002)(2906002)(956004)(33896004)(25786009)(66066001)(230700001)(8676002)(476003)(486006)(50466002)(55016002)(9686003)(47776003)(7696005)(7736002)(6506007)(386003)(110136005)(316002)(508600001)(3846002)(6116002)(105586002)(72206003)(6666003)(1076002)(106356001)(86362001)(23726003)(4326008)(81156014)(50226002)(14444005)(8936002)(575784001)(81166006)(53936002)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR0301MB1584;H:xhacker.debian;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR0301MB1584;23:2b54KkTEYUwf0pktTuitfICx+JEnbeX/SC1q0kn?=
 =?us-ascii?Q?JrVIHS+CWG34EHg+Y2zNaPABFvI4nVbp+YPVmKA0HfhOym9SFJ5AexqmAWfV?=
 =?us-ascii?Q?gvuRufnt5XyX5kalIlW4soH3QjTVNoltinAwWjqb1WZucGvFMks3xM8uNWjf?=
 =?us-ascii?Q?FeeIyR5eaXxdoMM2AZUOv/xhYKI5z3n+vrVe5K4MkPq0Ca7WY9aoEuvd0zDZ?=
 =?us-ascii?Q?V+/AkAKx5njiD00zvq3k9D+4VG3pXt4wuXiJF2lN7eymzYxPQrJik9cM5w8C?=
 =?us-ascii?Q?D0dnr2vJ9aZwEeK3LVdWZ3Z4kkZe5+5JbT/m7Zqm3Lx8dEPRCYl53IWc0AsA?=
 =?us-ascii?Q?SRnBA/XWGyOaNSdgOb0PsPgScDZev2hGv8b717vtoiZL1eWFIZuCDdABUFcx?=
 =?us-ascii?Q?mhTL/vyxlkEEKID3p4CdR/xWQo1PoLSm56yUzjULpvVdn5lcFYQTKJK1ZZKE?=
 =?us-ascii?Q?qC/FTo4TiVh6WXeN6R5CDnsL8DpS/c55tQpQQBhSbnv/jIqVS85K8cgKDBM8?=
 =?us-ascii?Q?BIp1c+xJUKD7pkOf7mc1/zyQdW6RfWpUZyjkMnMNpbqNGScJUqMnFFrbhER4?=
 =?us-ascii?Q?9Cp0srgs6xv0z1+ONV+ExtwiKRClhggtVW9H+ragULtutizOginSPxRcnWYo?=
 =?us-ascii?Q?r3JNthADrfCzzvi7l4bZQKwZa66SuOgqnLbtTOPHSy546WAX2OUV3arkPWSH?=
 =?us-ascii?Q?GoQGsiI50U91HrBNInosLNMxLEtqFrhyQRgFzIJMaTDlC11eBJS6slcZ67t4?=
 =?us-ascii?Q?OiIebxJRd5xIexobdSk1yBjHouYWguMOw7DvFkfmp1iA2Wa+CwWDknR0nDRo?=
 =?us-ascii?Q?WWyGLiD8p75LXr8BhjAnx9ASWnHMzujfAOrt/j2gVFwqUJVR2HuM+zqpDTa/?=
 =?us-ascii?Q?z1NuXSrzm/P1tsEIaxEmC9j54q9TwScLj8nzS/Vry43iy+xZK3uYgD+FDUrW?=
 =?us-ascii?Q?V3074j2XZrdqAl+2agoUH1/f98Fb0ffj55DzeLTEdO6ikXalgUNClWS29ClE?=
 =?us-ascii?Q?LHQsOq3nLgkbtyo+NtsSFlFOi8kq8Rq1M28C+IckI7Mo5pLYAQhd4/lXGpp6?=
 =?us-ascii?Q?tm38mLJ4e7lmX+lEmIyMR3k3fFLs2OKUsSUkvISPwv7ojcBtqkYxK1kTK5bF?=
 =?us-ascii?Q?Wb6x2wKWhws2Be7cX9yEeV7AqzJlIqoemxI+f0/GXDtr4y0QFQg+HVHl2uJV?=
 =?us-ascii?Q?HYA/U81hFBCeTTbE=3D?=
X-Microsoft-Antispam-Message-Info: n6vZ868wNaRqviDEQ95TXgFsf03bR2kT6V4ijQo+n340XLrEy4HWQGtRD9n/e7QXflLtzp4WdzgfO8a4dPi/Nhgk+RQ4SN/qIRByU9awaV0PiopCLMLK2Bpa/Qb2FFDhx6EFNZ68vVqeJ+9+XuZY3O8nLbeBRrm1RArGyKy+S2MvIOApQ7Mgv1udYqsvJ6KV4cMNbf1Y+Q34brIfKbsrIOd4WCWio6MNIM1keDYkBHUht/hQw2H4bgO6idECLKmNyewvkE4UirKm8NcEoXj3SXF7vyIDAG86iLnm47sPpBxVE1YDw8RLZCt68ARiLwTLcFbD1xdxMnzyMpH6TldBwLSXs70E9imnIWYEqLXERnQ=
X-Microsoft-Exchange-Diagnostics: 1;SN1PR0301MB1584;6:mym8FXx8Trxs4pXii/L2B7oFr4lYhd24I4VjF1FQFkWE+vBMvv80KotpXKrhmjzulHehyFN/jrfMaChykq5a1dGoQSNn618ZFZ1W2ScghcH+9Ul2hiSE4PPT5Uvxuw/9iLqrtbtWt5+hhNbENdLKd56Si3pVm80DK9PGVB/IyfQjV1K0t4GOc9MMQJq9i3OqCAvBHnvoD0G75O955oCV6jGd4taVwMplnZaTm/aWGLN/9WUE/+zU5WplZeY1C7S24MOtRuW2sBdLTfIY6f4MSGLUymK3ElnCn9r/ZMxdIyysv8IHXXf/lciRYrZgnMT52jlGw03xdBE5mnrmem5Y7HbYUp+lob0HcxPuwTel/wCU0Fe5XWLLPaqeJILGEj3Owf/Eo8RcSeZTRmCb302z2pSbaUZOcnb9v16TfgjqxHV13fYbEcpV8pQwJIhweNJOSi17Yb1HBcJN5AgVkC0+3A==;5:kDv/hplEyjf/3In5pNR+1icuQdlml8+VMgFvPmuOylXEXKH/b81N5A5jno4JSeiiOGvAnPvEdpaIMd7WNkKh3fgBUK3riR3VuN0ktRi5NaCOv7LaIQYE7OsEduDnauK8eyZadJCrcRpw3HOp3Pm+WbdNV6DJLU0UjiytA/dsoIQ=;7:UBm7bsnBBZ3mJV0MKIOX/1l5F7K+9YZL0QAYw5kusAoYfTbQyF5xKGV0I+IoyTSmME9Usr187OflKXrlHN1cKUT05FWij1ugDhHS4xTNkRLnPLa9EFC/6CBTN18jKrVRaIaJVMK1aKAyZSL8wA4i5PFVFt2wEbonyis2bSP9aCiHGw/qSkdwTWLX/fSSIL+985dYGzUGQIj3Zle+x7a6aVo4qSnchfWoKNY3kdwEo9AREc4/tp2+YWjSVnEN7PUF
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2018 08:24:58.9153 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc94a946-60eb-4c84-5d15-08d6195265fe
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR0301MB1584
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On some platforms, the sda/scl pins are muxed with gpio functions, so
they could be used for recovery. Select the gpio/default pin function
when prepare/unprepare recovery.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---

since v1:
 - use IS_ERR_OR_NULL

 drivers/i2c/busses/i2c-designware-core.h   |  3 +++
 drivers/i2c/busses/i2c-designware-master.c | 22 ++++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/drivers/i2c/busses/i2c-designware-core.h b/drivers/i2c/busses/i2c-designware-core.h
index e367b1af4ab2..01d5f01691a4 100644
--- a/drivers/i2c/busses/i2c-designware-core.h
+++ b/drivers/i2c/busses/i2c-designware-core.h
@@ -271,6 +271,9 @@ struct dw_i2c_dev {
 	int			(*init)(struct dw_i2c_dev *dev);
 	int			mode;
 	struct i2c_bus_recovery_info rinfo;
+	struct pinctrl		*pinctrl;
+	struct pinctrl_state	*pins_default;
+	struct pinctrl_state	*pins_gpio;
 };
 
 #define ACCESS_SWAP		0x00000001
diff --git a/drivers/i2c/busses/i2c-designware-master.c b/drivers/i2c/busses/i2c-designware-master.c
index 94d94b4a9a0d..384d6630366a 100644
--- a/drivers/i2c/busses/i2c-designware-master.c
+++ b/drivers/i2c/busses/i2c-designware-master.c
@@ -17,6 +17,7 @@
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/module.h>
+#include <linux/pinctrl/consumer.h>
 #include <linux/pm_runtime.h>
 #include <linux/reset.h>
 
@@ -629,6 +630,9 @@ static void i2c_dw_prepare_recovery(struct i2c_adapter *adap)
 {
 	struct dw_i2c_dev *dev = i2c_get_adapdata(adap);
 
+	if (dev->pinctrl && dev->pins_gpio)
+		pinctrl_select_state(dev->pinctrl, dev->pins_gpio);
+
 	i2c_dw_disable(dev);
 	reset_control_assert(dev->rst);
 	i2c_dw_prepare_clk(dev, false);
@@ -641,6 +645,9 @@ static void i2c_dw_unprepare_recovery(struct i2c_adapter *adap)
 	i2c_dw_prepare_clk(dev, true);
 	reset_control_deassert(dev->rst);
 	i2c_dw_init_master(dev);
+
+	if (dev->pinctrl && dev->pins_default)
+		pinctrl_select_state(dev->pinctrl, dev->pins_default);
 }
 
 static int i2c_dw_init_recovery_info(struct dw_i2c_dev *dev)
@@ -648,6 +655,8 @@ static int i2c_dw_init_recovery_info(struct dw_i2c_dev *dev)
 	struct i2c_bus_recovery_info *rinfo = &dev->rinfo;
 	struct i2c_adapter *adap = &dev->adapter;
 	struct gpio_desc *gpio;
+	struct pinctrl *pinctrl;
+	struct pinctrl_state *s;
 	int r;
 
 	gpio = devm_gpiod_get(dev->dev, "scl", GPIOD_OUT_HIGH);
@@ -664,6 +673,19 @@ static int i2c_dw_init_recovery_info(struct dw_i2c_dev *dev)
 		return PTR_ERR(gpio);
 	rinfo->sda_gpiod = gpio;
 
+	pinctrl = devm_pinctrl_get(dev->dev);
+	if (PTR_ERR(pinctrl) == -EPROBE_DEFER)
+		return -EPROBE_DEFER;
+	if (!IS_ERR_OR_NULL(pinctrl)) {
+		dev->pinctrl = pinctrl;
+		s = pinctrl_lookup_state(pinctrl, PINCTRL_STATE_DEFAULT);
+		if (!IS_ERR_OR_NULL(s))
+			dev->pins_default = s;
+		s = pinctrl_lookup_state(pinctrl, "gpio");
+		if (!IS_ERR_OR_NULL(s))
+			dev->pins_gpio = s;
+	}
+
 	rinfo->recover_bus = i2c_generic_scl_recovery;
 	rinfo->prepare_recovery = i2c_dw_prepare_recovery;
 	rinfo->unprepare_recovery = i2c_dw_unprepare_recovery;
-- 
2.19.0

