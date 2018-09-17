Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4CC7ECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:33:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55259208AE
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:33:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="B150wx6u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55259208AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=synaptics.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729361AbeIQI6v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:58:51 -0400
Received: from mail-cys01nam02on0076.outbound.protection.outlook.com ([104.47.37.76]:22553
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728552AbeIQI6v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:58:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OKDdj+KFBLxmrketiQ6QkPL/0vu/dadwKx4KhD1ObFs=;
 b=B150wx6ugr40E4dVt9iEVwSyeMIc3SaprF36RliQLKIuajZkFYkrupqnkr9HarlhRNc8BESZOt0WMSPM8F4F4+4l49rGMg4E38DRpDadZ6eKxVynsxiHzgmwIAViU+eYi7nMIeBB7cWrSx3j5xnfxQ+HLOKkvl703scckN29NLQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
Received: from xhacker.debian (124.74.246.114) by
 BY2PR0301MB1574.namprd03.prod.outlook.com (2a01:111:e400:526e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1143.18; Mon, 17 Sep
 2018 03:33:17 +0000
Date:   Mon, 17 Sep 2018 11:29:49 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Wolfram Sang <wsa@the-dreams.de>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        <linux-i2c@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 3/3] i2c: designware: select gpio/default pin when
 prepare/unprepare recovery
Message-ID: <20180917112949.414dd56f@xhacker.debian>
In-Reply-To: <20180917112633.252c591c@xhacker.debian>
References: <20180917112633.252c591c@xhacker.debian>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: OSBPR01CA0060.jpnprd01.prod.outlook.com
 (2603:1096:604:10::24) To BY2PR0301MB1574.namprd03.prod.outlook.com
 (2a01:111:e400:526e::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ecd16ecd-e2c6-4ff2-5be1-08d61c4e4fe7
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BY2PR0301MB1574;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR0301MB1574;3:ri4gaxqNwUtICxwdxUv7WcVxety+lWyr5OQV+YxebpTBF2iyCUT1EdfVtmBNOlY6xhTLvvywYY0OH+yNbEtAOlrUcP5pAF2Hoy8LARZcXY4pYpPb6AQGDwemthorlT6YQQupHwu43GMo6lGZfXr6PTkON0nMSpCB6i90DBxoBsw1m2q3gy/jrGmCGIREtQ90NXve0ehpx51NgdI8dcoW9RRnIEtuJhLKEmiL/ev7pqsC8amY99opuZDQeh8m/ab3;25:6gnAsFVMi+FmeY2kSbA9h9S5B8BZ2lANd+xbc4eAm9B24ghUpXX2UjxEMo8Se3fk4dj2bi44vb8mWepKVh3i+qJSApDkY30FuNT9YIguXL93sxo+cx30t5Cnfg4DIuJiFwe1WDEhufkoyshovYH/q2NMogJqCobllonAIyvQ4YKvKnsBZrM0mzeSnjAA/W11xmsFCm4g95TujylsHMeZ81oc6udtKj6hrDRiRBpljCdoZXscaQ5lv15dGUUGYz4rhYPptnriG0OW4rtn542VuYIcqwmo95AWkAJFhAX6VaOuio2efqX8MMcWRT2K1m8mHkA8QnRAjFjPX4YgiefgwA==;31:gQi5Bva1++agtx5gmEYHp2U5oIAI9GfRMXWoTaj6/il3DxQ2EgIm9qp0jsswjqYsb+/kWm5YzNm9bUYyaoTTkjMceYKBchJFRfQHUvNN8XdCOVdpo8Lh0awX9m9rfS7Tw1pxPDZS2wJp/0KEyYXrX5z6q3ki0d6dyfEBhi0gbs6cLcNs8e7seD+6V2KMX1pxzgUqZXQxq19wFtcnQ5SKP0JE44g57yC8zQKmyyrp7sU=
X-MS-TrafficTypeDiagnostic: BY2PR0301MB1574:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR0301MB1574;20:z68kdTsepfxpjBna3rHDQjTIODSFH46vEQye52le1ItNYtNUm3zKkYdiEkkizakcB7ciCWj4bRD19sQo9WseQLytvuVM8PUSKTlzXwYco7L/pzb+1Mwbq+SnLWKeamsCFzgUdV2AdwIE8Vv0Qkg6dCSvy7rFAtprMvY7UtD66eklOB2JpyF03N5Wm1SbFjgTeBO01OezAbwQnj7IEIeSPs7JEY/t5j/sARX2bhfUTfMnTmePYh4wL6gitfS8BWun9Gj3d1ZSB8z9i9WtSnR5Y/VzOmkShPnMqjkc9dtHEDj4sHr+SeSZgSceNjV5fPwPa109XVNGdc6/PKGk7DZfNpcH3pjoJdLSfbYKYY6yLIgB4exzBmCaIKezRFpOU0W2FUzLbboXnFLFG+xWB5qfxg1vyoeQuC3PO56Ta29/qNPjIp4glRZn2XFIFOK/DCaqzBdtH7kAMyT2j0x1usOVxa3O9puDJevFcDmtQ3oalnTMmcDhIHLyOZMag+Co7UKx;4:RmLiAS0HDVteaph+1D+OFdRbWm8h1MSEAAHmgabM/yvi3GgEe0gPS5MEIPXrQkkCy3CHzxP7JJ+UzAN8SH9ZrZY28Sn2ieqlFklF1Pi57AvNuU98GmQp/3ABRXGF/6FADNvPgt7UxhD3oUopFc/lReolrRjai8Iv7SkL2HcE1o83/SB5TAt0U9qHOf6af5zY21vsBfrDHhgUtPsdnRoQRoJ+tz/g6Dy3IbduadvGo88q0r3ZfzrnvE5GaiDc0lxXeZ/KpuUaTo9ZxoeUcGehQQ==
X-Microsoft-Antispam-PRVS: <BY2PR0301MB157401140BCDA5305EC52054ED1E0@BY2PR0301MB1574.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231355)(944501410)(52105095)(149027)(150027)(6041310)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(201708071742011)(7699050);SRVR:BY2PR0301MB1574;BCL:0;PCL:0;RULEID:;SRVR:BY2PR0301MB1574;
X-Forefront-PRVS: 0798146F16
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(136003)(39850400004)(396003)(366004)(376002)(346002)(199004)(189003)(81156014)(14444005)(81166006)(86362001)(575784001)(53936002)(8676002)(5660300001)(72206003)(68736007)(486006)(7736002)(305945005)(55016002)(478600001)(8936002)(9686003)(105586002)(66066001)(3846002)(230700001)(7696005)(52116002)(386003)(6506007)(6116002)(186003)(16526019)(50466002)(50226002)(4326008)(110136005)(25786009)(1076002)(54906003)(2906002)(33896004)(316002)(956004)(11346002)(446003)(106356001)(97736004)(23726003)(6666003)(47776003)(76176011)(476003)(26005)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR0301MB1574;H:xhacker.debian;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR0301MB1574;23:eeNLk9yx5x2p2yI83/cjhWdfoH59NXgTgLLQ3DJ?=
 =?us-ascii?Q?r2GE6gYTpf7YyMz3zUoiu8xnQ+6fAibP1Hyxj1bKi+5Wmpi38R8g/So6AHnJ?=
 =?us-ascii?Q?jwXm4JzVjsZkUebNKA+IXNUaTzL9ZuiXziA0HLKeqzpLTiVDIZ6Zq3g6RHPX?=
 =?us-ascii?Q?aEuyuYB1T7m7NTOvxQX5nbxGR7OKnT/DAjxTkGIIOaF/JWztUeieajIYEK6r?=
 =?us-ascii?Q?xS/Rt/bZJbvpuplq7FRvmJwmrzcdTko5A0x5l4GvYAwqEPeHF7GM+NR7xnBM?=
 =?us-ascii?Q?l8y2tBK0okgotFQ72NHcccheTqOq6iCvyCtwrNvzAfQRWyL204w9EFAuyMHl?=
 =?us-ascii?Q?tbOT/2LVYa1A9Er4rodI9BwB3LqcGUScLpDBJWByzHA92J7PtzBoFOiFGTwt?=
 =?us-ascii?Q?pfhbUoKRta0Qpk4dv1COxv9J6nW4gcBsPw2y1GTxXOwMiUc6D7RIooHTJUTh?=
 =?us-ascii?Q?5FjG5rUMFT/oGRBS9rWpJ5Ev4H+2SwEJuf+/YorMCBfQfWNx+IgIDUCEPrq9?=
 =?us-ascii?Q?vyV2E2iXAZ0vsyCdp91XLCXDAcdIrnNFhVpJDpVMn4n46b81u7B3caQXo4hU?=
 =?us-ascii?Q?5Hcb98Hl+B4ruh/Q3I0ThIJ8AEjbN2VYBGI94PFGdVRAEOkycrIN/7qHinE6?=
 =?us-ascii?Q?h1Ni41rIeG7884A6bIJCrHR3N6LanoyGvwN2W7MuYtQ2ZaNkvAoPe1ULh3hA?=
 =?us-ascii?Q?K4RSKETA69bZ2NlrRX5Z+QAPzQM/q7grka4pzbIeC+r1GVEQOlC/0MgEVOmz?=
 =?us-ascii?Q?m2egvhgJSDcljrlSYUshzKWERxQWYCAW4CDbuHNPda2hEE6hZxrba/NWdEAa?=
 =?us-ascii?Q?oO/eMlQONLF9zOdUo38etoQsHOxyWWXkUdkpTq5KaB7OptALkKLO0pVKXgwX?=
 =?us-ascii?Q?LGTLHPoRceBleIpQoOKOIs0i+Ohn/KC1kljnrMRVV+AtrJ8dmBX9nS4sFksl?=
 =?us-ascii?Q?bUuytvUlFbtMtlGPtCGuwiHKOgpU4u/IMNLBgX5GKp+yzWlY73Sz9wDok0aj?=
 =?us-ascii?Q?GNqb4wp290SPCK+pQqQJzhEyHBl+ahtPDbvmXIvaiHhuvWvGpbRMDEkaMuUC?=
 =?us-ascii?Q?w5hXvugT6AKZ7Md4+mx684uRE3crGcLsQFHAriSNcfmPkqq+voAcNPckaDs0?=
 =?us-ascii?Q?Hru7QzF9r9CW5I/DdjHFz2l4QPhbSFFwgYNSQIoAaguW0W1RQZf1l9MxkNBQ?=
 =?us-ascii?Q?Uo/m4YUxrpQnQ0BF+9wt560DFPrlAR0q5gyJ58c9w4SCyF59Lo63xylYGPNS?=
 =?us-ascii?Q?dXXEkcGCxU3p8kMsVDvq2jXy4AqZdV3GcuqhiwQ05vsq8eXkWIch8rHFBufG?=
 =?us-ascii?Q?mVw=3D=3D?=
X-Microsoft-Antispam-Message-Info: /3lM6NLbPcc5PLb70I/CzGmrzWqj59OzLkyXxDl2CKCcDq/PH8/9a3NYOjjrhIF8JUTxQAmi/vZjjLuhlYrW7Z40xjuwv9PrcX2RSwrCC80yuv9QAMfCVfczodBApfaS2lCAmQD7PNJQ8wwxrAP+Iqq/Nhp5sVxFSWN71OGvn7FVvVyn7rg+M8+VGozO31Up0Au1M7H+bbtClQxexq/dvy2kfGY0f2aRnRbrSTtRhiPptAvP0/ksfenpkiOuuNX8Shl4BoYQzgxxHoZlzidBlA+ykouy6TRi2P4MaVkLXthdS1iWnomyCOvLhuBtO1wCdRPoLdzUOiYQuzma1rApjOMSTAVltpnci0kHCGsK/Mg=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR0301MB1574;6:AnUt3Iu2FX0iMgprgFsjV4W+XS1DOy6S5yfibI6wTzX97BLl5sAea0Av4Gyg8+W6Q6W9QCtQ1MQoCxEV4jj6ZKwefFJuDOQuuzn5DxcPNvH3BUjm+fbQA/kukJ6BeHSYSMxi4bO6chYEaXC5Xi0cvJPTH3RzPThHtHwq3153VyTnB5FTQdxkX89WDhMFOinLRYtn4Ut1wRsXLAinb750mcJxgSEC93AH/2g+4y1tibaJoHssn0v5ZEYJuZyOProIxH2MsjA4genmT4VX96o0FYCnCYCKUYYBJSY27GFwwwiu+RzRrGRMGVe1DdU4UsTqOTQlkzu+RHPIUtQeZ1WTCtZoaUC7QWI4q7sA22xPrbARh3SG6UpiflFxDUGfLNcZZNLCiGHcblWijhV56DUfi2/HiOsbJqeM92aIhbXuCMJwfMJIkISOKUit3AZdShp7ek7mcKVW8T5w6efJjiZIeg==;5:XZ5zpqpwSj73vziXHfJTlzLSztxpFsYg79yXInpbhOeisfv+AnxYfv3S++be5E1H2wKEC3G1rFLWr9JJqMwIh42y70iVt4t7CSbm2qtRGSuGQSSWERCCXhvQAW4jicZQD8fjCc304TBf1DOmV430tAVx6Qxj1TJZ0A11iuw+hQM=;7:f18scNkdpM2kztgvNs8wzNmB4VI6hSL54qUrAFAszoyi0uJUYo0F8qyiH/YUuWL0yDo/IwS1AMKzu+sOS2dVmlG+1DsIovXXnHHC7qJbu4XnjgYsqtdwlNAGGboyx86mNiq7Ae5qaHHlBb8lyzmwfmldhjdlTSwWsWnecMI8l+PIHgb75TKgwFlpOSHuBjpizELXV4zY4ajt3PuIDqIYnMSK6c5Zu4rIpnhRCNd3ibrnvE+2JCMCANeGNiLi8c5j
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2018 03:33:17.2035 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ecd16ecd-e2c6-4ff2-5be1-08d61c4e4fe7
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR0301MB1574
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On some platforms, the sda/scl pins are muxed with gpio functions, so
they could be used for recovery. Select the gpio/default pin function
when prepare/unprepare recovery.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
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

