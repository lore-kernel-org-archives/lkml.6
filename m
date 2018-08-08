Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61AE4C46471
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 16:09:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A33F21771
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 16:09:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="stvjihHH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A33F21771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728450AbeHHSaD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 14:30:03 -0400
Received: from mail-eopbgr40068.outbound.protection.outlook.com ([40.107.4.68]:40736
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728030AbeHHSaC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 14:30:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6my6uAMqziLxxqG1qIv87gR90N+afLl9bRdXzQVqn+I=;
 b=stvjihHHFoLdCruW/mO5xvqEM401we9eq7Gy1Mi9FMQRqgr4UbbZKBodIHzHM4dbkSi+CFMo6FpQHPXfHLcenxO50Dta7MPpn2lMQpu47wRtNad5sIDkdDgqJbhNJebH0jPHHPiK8sk3QjEJsJ3aa2B/R8+K7oNk6s+TXorzZeg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
Received: from localhost.localdomain (95.76.156.53) by
 VI1PR04MB4301.eurprd04.prod.outlook.com (2603:10a6:803:3f::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.15; Wed, 8 Aug 2018 16:09:33 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Stefan Agner <stefan@agner.ch>, Marek Vasut <marex@denx.de>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Robert Chiras <robert.chiras@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        dri-devel@lists.freedesktop.org,
        Dong Aisheng <aisheng.dong@nxp.com>, linux-imx@nxp.com,
        kernel@pengutronix.de, linux-kernel@vger.kernel.org
Subject: [PATCH v4 4/5] drm/mxsfb: Add PM_SLEEP support
Date:   Wed,  8 Aug 2018 19:09:01 +0300
Message-Id: <3559b9b99a8a48042ee468034e5f1d538ffbd081.1533743954.git.leonard.crestez@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1533743954.git.leonard.crestez@nxp.com>
References: <cover.1533743954.git.leonard.crestez@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [95.76.156.53]
X-ClientProxiedBy: DB6PR02CA0004.eurprd02.prod.outlook.com
 (2603:10a6:6:15::17) To VI1PR04MB4301.eurprd04.prod.outlook.com
 (2603:10a6:803:3f::28)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b84b282f-d218-4bf0-f1ad-08d5fd495533
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4301;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4301;3:jX6pmXQTFslrxamkqUQx3DaCijsu2h1PMDq4l+d4+9hw1/gnKzEEu1JhTwTEx1GPXF0urNBMJlY4dZmBsoWxCm5orLVxWJtTy3JTnrgD6R/vaxFmaFQ/tEjwDh54j2STq9oNVIslLOfjt4+3pvgGN0SkX8QODldWBss0mkgElc3QsnGMQbQaayqQJWnvZKP/NSZNqJH2fNP/vI41D9CyybjNnbVGQdkTmvWIgDgoFTkyk9ZdyDJydIKfKA29oRbX;25:Sw1jVzwYqpbUfKG/RsHArpoalnb8VvgsYiJktyvSfYkSrVehkgsckghe9x3V6fpuKqayl56UiF+5Hjg8HWyC3nLmPzBsqqrq+ROgq6hwD4VMZNr4/X+tn98kaFCRZUBtwzYrHr+JJ7WulAdodgBVkyE05OWmg8Kj/9tclgkZmNfekNr+kgFXakF4FhHHrmfUFwhw6EuxFb0tXKHhVYvS0XFalTElTzd1010qFu2UPlIC+u7JhBPXGdUmsVLr1nmccJV59Em6hoFcrNEpFlBPu3W/CIK1Fb5oq6Mbf1u3MYiMHhc8DSmvKj4GBwcb04eD7TYzXQt88+svZ/9rH1pitQ==;31:w7po/HtE3vHw2PWAUIAh6SFTE6a4yq59Mk1tQk2oiohnTMJdcUeVLCdTsLOwDdkFig66GFxdlRRNfUvD4IbpyIMsDsBmSoSNd9q/dIaIRc9Xf/fCzW32GnDEvUOb8+I5KCF6OTwiBG2CRr24yzovEzY9JmWynCapSHk67zUa28Rr3cYh7LGDjHW0qKyQgK/cbM6VDyENtoYh8ATWu1ByQHD9DSazqvhHM397gc8Arhs=
X-MS-TrafficTypeDiagnostic: VI1PR04MB4301:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4301;20:aqPbusWPSkBpojeg+sFokkTclMJXeJ1t6iQ5xodWxB9cLy5KVBKKPxJlCGJp/oTQyJcR60LPFgqmjHcFbJhG2AYIA7HPE9zCLnds36c3NwPaHi6ZouZDkR73RVAzbdMHIA/H0oX3WXn41UZ33YAaB3cpmVV8cvUJIssIcGHnJq4m2CDF2vegUpvQ/H+iFdXmaRiQt4nYfoazuCg1QlkCyfN2HxaU6SVpup2JpAZ9kxqrY4+mV4kOrfVd2zVce0LZZct5SfbqiIfT+GOUKrdyqQSbgRC4tDoms04clhER6j2dyXylyBglfRAoY7ILZUEMmUc0I8Wid8iSqdiaHT8nZmk2EcsbjaSvFh5jLWp0d5m9UYTVOfDYMLBYH6u/eg/A0mC7N0Lxk6McjCGUXv20heeoiMJUSpPmFRf7YpMXjqVFVMo0fFOiSmiQ1lRADcGAQvtESWUv+4DtZ3cpc2aEFLO/PiRm7R3fv2Ot3GdwZcQShWqaAtbQnrRTQ+gTZiwq;4:mjVFuRImG3k2vkYd8UkJQAgHYMXIaaFFjqsAbRWfwoSFjLXf5trglUKG9rsp7knNTOkyO/oRWETY4qeD83HiHPISelJmIHfdxW9gzpoxdQZYP7/HVhUB1jOknFcYiT9uvnPY0BmOp1D1jAiKD/RfRJgMiiof+B+ZB4qfKCxY/XyKgy9dj36TeuwdCEMCZuPo6eDgZw+jUbj/6F8oPl46XHa42gYJQgM/GUOQdK45EodulBKnNmPRvGHpHIyzMftz/xnLfsW14KW64M1q0cU6t4hd6MFpMcYyFYbbDoScjTv9gF/DCq+tRgE/uHpXmaTr
X-Microsoft-Antispam-PRVS: <VI1PR04MB4301096F19A3CC52584C6C1AEE260@VI1PR04MB4301.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(10201501046)(93006095)(93001095)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:VI1PR04MB4301;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB4301;
X-Forefront-PRVS: 07584EDBCD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(979002)(6069001)(39850400004)(376002)(396003)(346002)(366004)(136003)(199004)(189003)(66066001)(7736002)(76176011)(47776003)(6512007)(81166006)(68736007)(81156014)(25786009)(8676002)(6666003)(110136005)(54906003)(36756003)(14444005)(305945005)(106356001)(105586002)(53936002)(50466002)(6486002)(97736004)(48376002)(86362001)(4326008)(575784001)(3846002)(5660300001)(26005)(486006)(16526019)(186003)(316002)(2906002)(16586007)(6116002)(6506007)(44832011)(478600001)(8936002)(956004)(11346002)(2616005)(50226002)(386003)(446003)(476003)(51416003)(52116002)(118296001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4301;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR04MB4301;23:gXc/v81EvW1lWIVbVkKoy7/ohBVA+eVilb4GLycYT?=
 =?us-ascii?Q?nmtRTKwN2PADGxiMG0WrSclDq4V0x0XNyl8qEANlFIpR0aNvPZX4Ke6hRvW8?=
 =?us-ascii?Q?RFEpwMgzuTa/uP7RgoMC58vy0nYNDGhtaaiiMS9LusAK23vyz0SuMzKg0YmK?=
 =?us-ascii?Q?WIIPQkyJmfWYEZdH8gsQ3mHg0te6EjQXcBYKODhQaUVxLTG2oXxn05lNqdcZ?=
 =?us-ascii?Q?vXNn8OQ7F5j9praP5zWn3VVJw02DFRhRzRENRH2lJ6gcadlWQJxyGIg8Huj0?=
 =?us-ascii?Q?vXSNFimcZz5OQF12N/vPv5Cg7LOUfJDio2h1+C6FJGtMpn5VueTeWmjZUfBl?=
 =?us-ascii?Q?Jm/tcho7CIA5vlExl5YZBc9Jel/PUXflazjUFMJchU1lViNkVi70LSHhyVj1?=
 =?us-ascii?Q?13282IkNghPt6FPmA6ep2gxpKL5WRMZA4RxEcs8/yh6xr/J7jC4qlTeCHZ1X?=
 =?us-ascii?Q?5tvjsC3Mzs0P0qFY9g30xHIcOLaly9oGRvC6aAGqpKsYgIbHDHn2BsgIducc?=
 =?us-ascii?Q?po5+bkeia1d0uCGOHGwzKIyMzWwxzH7qrrhLTsG5R+35jdxx7mDtWDs55x6b?=
 =?us-ascii?Q?c3abIwdPlcYoCcQhusb8U4DZFHQZub8WSQUxSeWWtKFu11ATFhaLlzzpNCJo?=
 =?us-ascii?Q?iSCKazwsEJoBMrO4cVKmt/wVU6VKyKtFDYN8Mr3sRB4DE743NvOBEtY/V/kw?=
 =?us-ascii?Q?FOvVcCqg0qHQrOcmO4JEHVSKjcKOqGq8u34CSpY0kBJjzaWF7Qyzxw2RwnF/?=
 =?us-ascii?Q?S5NWgv9eUUXBolePLQuYnxbssAk0Mhk7NUwFD//cs4QonmJCo9dmBMJlStOE?=
 =?us-ascii?Q?mvHXx6Y9jx0m7fktyy6aa8dDSa+OXrSeisQgE1MiaFCROMfPbar8a7bCQiy8?=
 =?us-ascii?Q?PSoRvYROFBU/m8j6QEWKU9+njp+zsGG19s7k53tvi02xbSUMyZYNQYK8k3f2?=
 =?us-ascii?Q?fyjhY6CXBJRuemcrnWSjD9kx9hK9EcP/0ow3B/zIHArsleDMpJFfbgl5eKXX?=
 =?us-ascii?Q?k71fUzn+cJOZrdIxbk82v43ABQ2Aj3RbGDDH5I8x+GjIZLj3rhHJpvF+wnZR?=
 =?us-ascii?Q?/EZJqPv8M797BiMupSaS+c6FwLldhmUunV2a9ZmmtpCE+aNf4KzpEX3bvOlS?=
 =?us-ascii?Q?aR94WkgJg4MxbG3CT/xz7mGfWAwpLhNGAKwpOCQGVTY4P3RpbdneckA4NoRV?=
 =?us-ascii?Q?PsVMdpIuj7Fq5wwjQvsEDycUlBCxtc/IqPsxWbm0pXtqqwnHdBxnYMOMB1mW?=
 =?us-ascii?Q?g0gSmJMGEPgEHtv22GXQbDaTx06YD24YU9oDGRYvo+Sp2Rde5sQ1m41DLGni?=
 =?us-ascii?Q?1gc4qRbKaPINcKjw+XZQgj5B1E/fMtP09zNrYzdCH08BCC9HdgTUITCJ3dyx?=
 =?us-ascii?Q?bk2hzHaXIWD9Cyz6BuMpUtYqVWz+VMxQmMmp47YBrSbdrpq?=
X-Microsoft-Antispam-Message-Info: 03gRm8Oky+VmGSO1z+oKq5N6p2E40AM4G6MNKpJrDqQxB9mS7mnUmkOrej4LhtnYPJhf9bJxt/tJHl9nlLbB/wKIr8gs82enES+GQV7WyqGEnKcE9y8VeFo6Vk0vplPJBWxOSmnsdlagGcjBk1mc+dkMw09C2dV6iOZv9bWgjcj0JCbWvqfx37q3+/7/DEOdS4vGztewaF+ZH+Rr7nvg/+jt/LTIVGLef+tOzzI8FPrAnFQPcHGt1TGr0NKBYwi0pDhcJJlQWwWU9dEAaPj3UhhLXm5lJWoqILfrQnm0WGg5Qhhy5X1yAalhsUoIhr3j5b9rxxWKyScLi1V/W1irQhYKilYP7NdXXw4IwPvJRxg=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4301;6:9mRgg+sJ0zM73jFlmub4IHvfZqJe9Rh//tTawfhcunCucqoMgQcYrAcUADAXOU2LMe3j2E4dRdswpVZIHBbOOspy4pXpJFKKQ2cUuROULGlHkWNCinyRmJs92u5HS5G354161SUmifP79/PFOCho2yMnuM/A7+cuFripwbgYkTWQIAKoDU5xidKcVd5YUAtM1l09lK7ouMBy5wHfWio/aYRNi9qmTULs2qmH3vG8bxaRwlQ7VTv/x5phekm6g5ugrLZSUCp/ihcjBXO1OCBM4pFkqkhB6D+TJIDqa06cgEbgn5VlrEtpp/mnhW0ezDpeuYVStlTYpkRkDSN5oxdAhIiS73irej/UYHePT8oqIke9KgIuVxMd464uvM9b/CH8I0wJC28UvMbygNDTk+Dnl4+y/+YXLQliut51YedIt3KcD6HXqpCp399cdkbzf2KQow4yBqQxgZeStMVBZYqVTA==;5:AxLlDEpyEmihhayK/kxK26TUGGlf4bsIu4YZbUEyqnH9EwQVu+9CRfvQTD6l+p5VO5BASH+h2KIVreGauJdEByHbrTk55zlTMV7rnfdxUmAxfrYn/B3huECBf4cY/EjLToAtiaucd9w3FkRdrTxNzqCAVUILanluTMXJgzoz034=;7:gPM+XmeYtGtat6WYqmgqf426tiNTY1tOLHGlZuKEhtVuirVTghb2aQJ8qM1tXJv2q0tmuGa56TxLK0dTAEr6rmfcv1joj9ovmcMaxnFeuMMAG+OOpLl9oTEsF4b/zCzyfhNmsi+3CCPieM25ROi10rs/d3NmgAcTcAOJ8kZ6YP8161D9hY5oODTtvuECISx/WUcBFwzUU8kLau/9UrGmfbXbtWqM/jk7VFSY64q3N1q/BZc8Zb8HeBX5q+w98jZ+
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2018 16:09:33.3731
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b84b282f-d218-4bf0-f1ad-08d5fd495533
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4301
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since power to the lcdif block can be lost on suspend implement
PM_SLEEP_OPS using drm_mode_config_helper_suspend/resume to save/restore
the current mode.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
Reviewed-by: Stefan Agner <stefan@agner.ch>
---
 drivers/gpu/drm/mxsfb/mxsfb_drv.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/gpu/drm/mxsfb/mxsfb_drv.c b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
index 68d79f5dc0d3..d797dfd40d98 100644
--- a/drivers/gpu/drm/mxsfb/mxsfb_drv.c
+++ b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
@@ -416,17 +416,38 @@ static int mxsfb_remove(struct platform_device *pdev)
 	drm_dev_unref(drm);
 
 	return 0;
 }
 
+#ifdef CONFIG_PM_SLEEP
+static int mxsfb_suspend(struct device *dev)
+{
+       struct drm_device *drm = dev_get_drvdata(dev);
+
+       return drm_mode_config_helper_suspend(drm);
+}
+
+static int mxsfb_resume(struct device *dev)
+{
+       struct drm_device *drm = dev_get_drvdata(dev);
+
+       return drm_mode_config_helper_resume(drm);
+}
+#endif
+
+static const struct dev_pm_ops mxsfb_pm_ops = {
+       SET_SYSTEM_SLEEP_PM_OPS(mxsfb_suspend, mxsfb_resume)
+};
+
 static struct platform_driver mxsfb_platform_driver = {
 	.probe		= mxsfb_probe,
 	.remove		= mxsfb_remove,
 	.id_table	= mxsfb_devtype,
 	.driver	= {
 		.name		= "mxsfb",
 		.of_match_table	= mxsfb_dt_ids,
+		.pm		= &mxsfb_pm_ops,
 	},
 };
 
 module_platform_driver(mxsfb_platform_driver);
 
-- 
2.17.1

