Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08FC0C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 08:12:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 888FE20C0A
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 08:12:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="Md6sfbCH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 888FE20C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=synaptics.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727592AbeIMNUe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 09:20:34 -0400
Received: from mail-by2nam03on0053.outbound.protection.outlook.com ([104.47.42.53]:54697
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726792AbeIMNUe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 09:20:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SdAeUxfbMTRCtftcUFFumC+qbcZyfpm+vAkhgH+sAB0=;
 b=Md6sfbCHYEw3gzJHldWNah1LD9vZ4rFr6ptDLTQw1JLj6u72xA/I0sA7prD/Y3IePAAy9t5BAAgunTrYsd2hab7pvfGe832UKTkPTDInGCw9xA3JKs6kHs58/kDgAWVVasXbIsG3jiHihaIInn9ChhRaOsneydhL0ZIrehpmcRc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
Received: from xhacker.debian (124.74.246.114) by
 SN1PR0301MB1584.namprd03.prod.outlook.com (2a01:111:e400:5232::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1122.16; Thu, 13 Sep
 2018 08:09:16 +0000
Date:   Thu, 13 Sep 2018 16:05:48 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Cc:     linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] i2c: designware: select gpio/default pin when
 prepare/unprepare recovery
Message-ID: <20180913160548.6ed41c43@xhacker.debian>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: OSAPR01CA0037.jpnprd01.prod.outlook.com
 (2603:1096:603:14::25) To SN1PR0301MB1584.namprd03.prod.outlook.com
 (2a01:111:e400:5232::18)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 16d4901f-307b-4a65-716a-08d61950345c
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:SN1PR0301MB1584;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR0301MB1584;3:1GanyhwjNJzog/q6WaDGTBM6sVjZGYl3tlnnOaVyeAegNJT/orLztk2KPOtw96NAUu9ckLRbVDudPRbxDBQ4b7Pvy2k8iwTnJ1q8r9MH880cV/RxLxRqeo/s5OP0kwXwNpcdaKNxtcSj2evHdIKad1poFVPmR6idpHNWN5C1VlEDyDeOiuXO/yEqkX6uRUZ5mr0hFXpuJ3SPOHO6BKOgT4fG0+kNKG9sZR4g4UiI6JU532l8n9bIqEdoH/ivCFiW;25:kWIgVytpHYudQcD4MeR5xtX7ZXuw47imsqSAM/s1aPZNSrSOzn0jlH+V6KgB9HaGSrIczfYIKGt2SOF0Ec8Nt6EEZ3QbbLoYABKGE5T8UGwhMYULdy+nZ06LsgKbGMGkyTuNaiYg4lhHCtA3X3PbqIi2ZaxYZXdvGz+01XpNrjvgJ4TvkCbk6U+6YSBZmPr1Ttjl7RuJXJCmLp9M2NcZMZA1oXvtc+CPri/5/b0scZIFnpjDcga4b1nx9Mtv5T2dt6DLFEDEvaSW9Q2/RNcb8Yu2b8o189wPnCPUQM8Un+X2N9gAqYUJQ8eDGVq0rJxviYF89SwvD2ETRozmV7kwiw==;31:Rutgem4IhCF9mnKAjZ9i2zaNrDT1OI6T+xtAlfpouHypelsKt5I3T0yU+2jzE5gTbYwFaBh8+xjVb6nu+SIXS2tK+/9tSV7sL1HyEpu5E4RBS9T+rTptMcDF06sT1y0IjUnENCFcW8iMsC+MMNxP3Ol87DySrE6vhjjT3xxk3T5uwR3LTWDO+uuPB++ZC4AdVrlW/JmExkdnHKi0lxGA+3Xg8P2ocVErMjpo9dh13Us=
X-MS-TrafficTypeDiagnostic: SN1PR0301MB1584:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR0301MB1584;20:udQTLmvWUQHQ2EP2AQPOD5YMW21Fl/TMnTDjv3PhgHoZ3mCm/SdpqtNSYIdMSf0BOOXlwfqGQQd0MSfaBSWQcUMKyaNps9NiU714ZMGSrrPwEFQ9qvG4pEKZndHFlAInKWxzkLfqYys+whyk1CYH02JsJx3xgvyXwjmLaSylB2Mc+JZwdGvArw/Zid5Fl/7b1j0qLFX51iWLXCOg5dOA145yC52Z5AJCB1efHRGTYimnQXPqnHEOYyI+X2cmoBXnxllftTKKCEa3+x6H04SH2DfdqcgK/50KJVvQhBNdkL97a9Pc9JG9cZF7GQhtGWYakoGUG/ir8ql/N1jWYFY2L6Mqw7oDhRBF5zAUewS3BkjG9sKbAUzKEMprHggk+mQ91pl08DNN1wZEj1TP7po2V+RvuUoc5DVSKMSztiFcjb4KLu0Z1Rr+D6honSqJFiUBc1wn/3Cpa6tohyrKvWlvY015/OeLAqvbIhUlMS6KNHrIxIOSQZvfivXJl+uL/n4x;4:wC6EqZgbA6MA3tDyQqPUuRnQBzRQC0LDEtbl5DQsUHRmhYr3aHlxCfN03zxb7LFKN8CpSnuI5nTZKy7Dl6HXvLIJG+OFD31k/bZk9Cqy0pWGjwJjFn9827YWqz9If+K5JbU+A2ISx6Oh63mbS4DEmPT8P6q7emgaBjNvHCH1gViFLnRJOxNfSQx1uacrOZrDuJLeEpScH8NogRRq4dQqeUTM5zbAuJGjui66ek1j0iuZqIKTdFvaZyWoofyxodcgH2lbr5j3cNkUDmVRaePOwA==
X-Microsoft-Antispam-PRVS: <SN1PR0301MB1584F92EA5055F38CCC5AD63ED1A0@SN1PR0301MB1584.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231311)(944501410)(52105095)(93006095)(93001095)(149027)(150027)(6041310)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(201708071742011)(7699050);SRVR:SN1PR0301MB1584;BCL:0;PCL:0;RULEID:;SRVR:SN1PR0301MB1584;
X-Forefront-PRVS: 07943272E1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39850400004)(136003)(376002)(396003)(366004)(346002)(189003)(199004)(316002)(7736002)(6506007)(386003)(110136005)(478600001)(105586002)(6116002)(3846002)(81156014)(81166006)(8936002)(575784001)(53936002)(14444005)(50226002)(1076002)(106356001)(72206003)(6666003)(23726003)(4326008)(86362001)(26005)(305945005)(1857600001)(16526019)(68736007)(186003)(97736004)(5660300001)(486006)(476003)(8676002)(47776003)(7696005)(50466002)(9686003)(55016002)(230700001)(33896004)(2906002)(956004)(52116002)(66066001)(25786009)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR0301MB1584;H:xhacker.debian;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR0301MB1584;23:mIwU1Kl/ulMPVQvtFv6ioFBKzE46pWY0RNNbIbH?=
 =?us-ascii?Q?hY9QgKXlJ/sbeqvutFSpMBbuF1wdCy6UFBNfEZeqv+/2Q06CNBWMmJoeIVLz?=
 =?us-ascii?Q?2M2eLPT7qOqdZDFO+MFsiOWJAVvtu485pZBbaY3+SJoro+SY9MYvTIOttdQm?=
 =?us-ascii?Q?g/6bcc67DksLTpfybHiTp3DKZo6u8Ykb1f2H76krvAzzOYH3INADaCLUf5an?=
 =?us-ascii?Q?sig2mgk4OSLgW7kgmm7FtzJoAKNuovuzBBj8N7EvPETGmyXK8MPfQvEnrX4b?=
 =?us-ascii?Q?EpJJzOAxxYWEVkWhFPqCC+fbAifPXuYKXD/hCUrgiWWzj9skCVXV1SpSLuV6?=
 =?us-ascii?Q?WFGlhul5zo3BcaJqDdKDQlDp6NP4LSM8QGECsGAcnaaE8qlbXeXizGEjkzDd?=
 =?us-ascii?Q?1i+Hk58QGYLNY83iyXtAvuDeP/0unrGFx/mO3gqnY8aAqqccmjsgRJ5SPd24?=
 =?us-ascii?Q?NAg1RyKJ2+MYqnIKNkTo+Ni4uHT2BDDc51GZ2ZalAjhf8yYlgyjXV/YJfMl4?=
 =?us-ascii?Q?XtUG45w+DOc5SLZ2HzChswePlpLYQwcneOUeHN2lvfUV06ib2Sk0HU4Iaqjc?=
 =?us-ascii?Q?aeF1BK7dAvVD4MHtF5RttWvwGcv35Z9bGBGBI16J/rxD07FwVqcvEbiBOpwd?=
 =?us-ascii?Q?77qBBredxlLYEGDJ5WnKwVZFaB75xQorlN62NkeGSefJYAZEDkWzYgu+KNU+?=
 =?us-ascii?Q?I+LOqpTSqeL5g1WckeREPnhrANG3jrvpGHQ2UdR4zrqEsJ44zbtFRm/UtrkR?=
 =?us-ascii?Q?KaYJDd9jEO58JRuSz9eIlVonyS02ID96MpgAjgGnlycrw+0ltmjEMWIRinQM?=
 =?us-ascii?Q?ArvUtCW3OiVCcaIHXhv7elr1mGTdIVi2HVbaXRmw/mpxnHNGlggzkQZLcpah?=
 =?us-ascii?Q?5JIMECTrr1fD8VJyLQP9KSycrTC0DSl/xxj9HmO0/O1Ne1Lo44MCIyfGZ3+0?=
 =?us-ascii?Q?7Y/K97Igon+SPsT/XU/OS+3rtL+UgZkRKPcRkebQ/QCfZSxT/lZXm3Z0XDrO?=
 =?us-ascii?Q?u5Dr03+hHrEBTxRbHAQaI8XyNZiFRNu8vcRXD6TiZogLw0UN0/IW1Eho1yF6?=
 =?us-ascii?Q?DxMNEG9pO2zakcNq41ayRPH2Ci3HbXHHW1adp8yZ1FTNJXHqSoZ6zmIm6GrH?=
 =?us-ascii?Q?9+m4P3DXk2ApaWORidcPZO5GTKT40uZ8KJ5HyhelBglfvbWvK4GL9TsqTR3M?=
 =?us-ascii?Q?EB3gDR5bEvdsj7+PSVK2ClaLPvCSGyPv+j5bNUL/xm+n5fEyAFkNadH94IQ?=
 =?us-ascii?Q?=3D=3D?=
X-Microsoft-Antispam-Message-Info: jXL8C7gxE1wxB2+nLmzxCKXT5yveyne/ZqE7JsSDsLouyzaI9oQqfOwPHGt6Qr0Jp+dgXNIY+NLi9KRstB8B7R/TqEVguAR3M5lSMriwGU5fRHS46c3y/JZY+fgZOTRR6U7UMhXoIIZgcb6vTQZX8fgWo3Od9Oq/5DmkYWV8RLfwS0PyCd1unDBy0qj5HY5nLvME/wl2FfMxdYS2bTqdi9eLfXNV+9RBteg5oh2mZmqBmi1Z9PxWJWUbNkTFbzP5ti+mq89At6g+CNS//1MX1oZVO7FM772lpxhIGSMx/qXdce56xUXnHvRZK+uJXnyk2A1YFBrd+oZiS4f2ZxvTiYFtgH/BFoJthgPzZi486Qc=
X-Microsoft-Exchange-Diagnostics: 1;SN1PR0301MB1584;6:yk1hF5O/QrcR4yWIPWuJK/9HAkbGGcDuAKuhEAoJYTc1W4UwDUAQk07k8WjzQnceRyODWNGrnpWuGu+xxmBcMPYbJoIZHt84u2c8fEdovtlKXg6NtfmFNx1a2RMljbjVHSEDp07/ujqGvtVMPlQymNQGNPoXucy9qDYE/P6bH62RA9GKSWorir4RywLtjGXQ+iOqn+UC9hoZDTJ63JJTdC4xMxv5Y4ZXA9jMD2ZZykhfG4dT9l3LmLjHSqZQepVEoCT1dikrdEVsWlGxe+BQutNyVhilLOoiUUgR0yVcY8hBOY1e1Cbmqyj9Hr7WIQNjFxxf37JsiqfTTiKLrwpyFJK+Wn0DUSL2bJGxQfTf0dJdtbPYqWXfPZTlI92fYROANP9c9IgajWvUbxPnNTaTz6W1x9mnBzptQkhtxAf7reU7erFUoRGHnOXECTwDQpWoqQ9U4AN+NAtbL0H+WZV0fQ==;5:mc+aG7QCEojD9oo8h0pSZbrbZ2xO8+VI2OUjcezs2s5xufIdBOFQjcuWQf2IHhIMUPblp3giDYSotTFzTJNHVgW45WakREV3PkIj/1vJIaj8DTwszDyRYY5NoBRkjKtwL/CQ51orXTxoKu3vbix7Vy3TbSyORLx2na1KrV31Jrc=;7:xtNKIpBWGkAm67y1e5NGV6Rg3x8Jboj8WVmpX606/V5YEqPNOYXLTWVPdfjGaIzkOKcM1DmmB3+NviQzJ4ypxc9Seirrsv3alxYufmQQXh284x5IPxRR7x1fAiCCbqAgIFuiGHVvIHP6zPkMNnCYWn9U4CBw0zXkJWIOAxBg045gHDlkMZpnQBy8y3zrpcdvPlwbk11X5n9x1lTme9KjtBU8Fdkb4qGO0ynvrFMmV+3U0BoAPCVVZC8qcnubcxjE
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2018 08:09:16.3085 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16d4901f-307b-4a65-716a-08d61950345c
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
index 94d94b4a9a0d..c1b5b51e3ecc 100644
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
+	if (pinctrl && !IS_ERR(pinctrl)) {
+		dev->pinctrl = pinctrl;
+		s = pinctrl_lookup_state(pinctrl, PINCTRL_STATE_DEFAULT);
+		if (s && !IS_ERR(s))
+			dev->pins_default = s;
+		s = pinctrl_lookup_state(dev->pinctrl, "gpio");
+		if (s && !IS_ERR(s))
+			dev->pins_gpio = s;
+	}
+
 	rinfo->recover_bus = i2c_generic_scl_recovery;
 	rinfo->prepare_recovery = i2c_dw_prepare_recovery;
 	rinfo->unprepare_recovery = i2c_dw_unprepare_recovery;
-- 
2.19.0.rc2

