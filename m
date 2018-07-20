Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F195ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:48:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32D8520652
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:48:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="TcbTtQZ1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32D8520652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390456AbeGTNge (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 09:36:34 -0400
Received: from mail-eopbgr50085.outbound.protection.outlook.com ([40.107.5.85]:15725
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389265AbeGTNgb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 09:36:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eYcZM0EG+KIni3X1hJuLTSCBuOjGNQD4bYP1JG45BmM=;
 b=TcbTtQZ11D7ODI1ivvX4LZ7S8AoIBkq7lWAQvGd1DH7L+MmRSa+M9mOe2oOtNsPZrxz1xX9NruC2H1FJ/dRBGWK842R2l8JB87mjKneVoWxm73zujLX9m4Ypshoq0cw0WWQw5Ff4NNUDDA5hHk5gGecbGypRxpgcXorL2PEYoCk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
Received: from localhost.localdomain (95.76.156.53) by
 AM6PR04MB4293.eurprd04.prod.outlook.com (2603:10a6:209:4f::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.20; Fri, 20 Jul 2018 12:48:00 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Lucas Stach <l.stach@pengutronix.de>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>, kernel@pengutronix.de,
        linux-imx@nxp.com
Subject: [PATCH v2 2/3] reset: imx7: Fix always writing bits as 0
Date:   Fri, 20 Jul 2018 15:47:43 +0300
Message-Id: <54f436a1d2a11a379af642a3327312367ef95343.1532090446.git.leonard.crestez@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1532090446.git.leonard.crestez@nxp.com>
References: <cover.1532090446.git.leonard.crestez@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [95.76.156.53]
X-ClientProxiedBy: AM5PR06CA0015.eurprd06.prod.outlook.com
 (2603:10a6:206:2::28) To AM6PR04MB4293.eurprd04.prod.outlook.com
 (2603:10a6:209:4f::31)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0fcfbf11-5e4d-474c-45f4-08d5ee3f0705
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(48565401081)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB4293;
X-Microsoft-Exchange-Diagnostics: 1;AM6PR04MB4293;3:6DKySgyLyk/VC3IV3VX1Tr9yk0TAlAdls5LyViAs/qpxrtT1pUgdY+y+UnZlB0A/t1oT92WDp9OsEHRIRi+THnRXKTbJXWHFtK8xOGA7Lca27PSyGFM6H/AFU5pYLlZBEAsu6y3rwZn0Sqz63eW8+nTww9UnVdt/dlniihK59M5BKau/DOAIjjDntTRimALLx60HQ2N7ZaxXtxM3q6BhiFvzEBZ42+EV3d0tgSuirte7SWcD9sDKX9N8xVvIdX7n;25:2GZb4E8c7ImP+4BgaEKqGPr0cInn6LGmbFhHYYLO2OGe2A8QDjeG5GtvyuBBP99C5kNgYp3FJaWL80LK7hx1g97pklDiSiKQGDNHEtESnczuzfXckTSEYnxTtOZcAjwQ/XHE/k+AlFsApoMRvJREKT6JRowa9K/k/IAU4JpTdERXcyprh064XybOHdzyzvm5DOLrmCANJpgaV7Zzpw/krYemDN3SN0K9bBW6+VpEr7J85qx8MzPwMXo7gSzragqlAUXRd43x6FMn9OpiBzaAmeqhmVREWJHG5Denkj3WY9BV7vQRvHIRm/diN8IhEr4CKezC/xodJ1IV9DBgY4mBXg==;31:AdfosXsSkSqzTWb8mBjnu0x/OpVwtH/FekTRnZn46xZutFggKlqReNhUOTT39sJn9Cq/+zpShDhnsWQ8Tn8Ah7ygXi7AXhCBaoMVBxz48CNDdN3vRtbhLw1DllvXxybz8Aup8qZ3zcGG98PHUrebgt0xExvH79YFxTauWNOx3ngbJFB4AuJk9zBfEspkwLQGrORncYT3VxlquGuoQGYIEe+ptm7YIEnRJ4NQRgZ+eDA=
X-MS-TrafficTypeDiagnostic: AM6PR04MB4293:
X-Microsoft-Exchange-Diagnostics: 1;AM6PR04MB4293;20:ABHjPkTeloS1x4S8/NTEP5bdLyPIishgvMbcZD0vOlQagUFqPtORQcBsQHV/Y7Q8/GueS5Boy14ZHkXJhsk1b672eoBfiymHPLbMJ/8xxDdHW/UjAoAylD0XR00IXlTMbh8RN3RdMsvoV0CSWNo311FvrpWC14SiYgUkcMnM7+5rypk73R84C8vYnmrFkz5nMuMmFOv5Sxf0qQtI27bdXX2dOp7smyIiMiKm1ECPaEXJGjy4urXuXbs9ez+31cx2ZKkN9EUEGzdBOa1MmAsPA9teK0BcUrAhoCT6OW8aaT/qrkPTRdNr5gw11b2kpxlfE1jR+KUz6d6WW41shb6QEGeAwbRMtzW6LlzzOjMvzZ1FyCRMki7kU593II30zRi1ktbxqnCCHwn39iyi+bQdFkIfTo/SJzyyQIYMbIAGiblMCoT27p6kCSMhIpDXXvL9oETyBw0x1iVU7htajgUwD7sJRUW/gDAegJOtVQNiiBZTcR9JlKU7PayjL9qct6Ng;4:JrImp8l6GCLiq3p6YyIMrRHSYs6/zKJoCmornGTlCUz0bNrb5y60EnI3wMP392IsTnFFKJCRiW5FFHsXE3Cz+++qu+yah8jitibLJnrul+m3CdXJdkSyFNDgXuP71MMXg7LF61oy5sKT4RGVo0giCfGKOUjfoRdhUWip53+CrR/KePkWHN/ux2bWQ+Kcy/GVr1eHibsOUQaWluTUdRC3BmYBvFiL5d9roAvL9dDgOeI25xkwb6qDlfJ0kiatQp8mJ7odlB0hWXjGjTOJNMqrNr3jfrqAbxnEiEnh4yjjq3QwIzjukD9Cea7w4Z4bD9Yf
X-Microsoft-Antispam-PRVS: <AM6PR04MB4293660060CF906E6E35CD83EE510@AM6PR04MB4293.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:AM6PR04MB4293;BCL:0;PCL:0;RULEID:;SRVR:AM6PR04MB4293;
X-Forefront-PRVS: 073966E86B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(366004)(376002)(136003)(346002)(396003)(39860400002)(199004)(189003)(2616005)(39060400002)(110136005)(54906003)(50466002)(86362001)(4326008)(305945005)(8676002)(48376002)(7416002)(8936002)(105586002)(81156014)(2906002)(81166006)(106356001)(51416003)(11346002)(14444005)(486006)(53936002)(97736004)(52116002)(956004)(25786009)(6666003)(16586007)(478600001)(476003)(76176011)(316002)(5660300001)(3846002)(6512007)(44832011)(36756003)(6116002)(6486002)(26005)(6506007)(50226002)(186003)(16526019)(386003)(66066001)(118296001)(446003)(7736002)(47776003)(68736007);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB4293;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM6PR04MB4293;23:A5fUdLAT0QWfDwvPf98Gdb+jIjPW4OnJxKpUddX0b?=
 =?us-ascii?Q?ebq6blt0bX0YfnNFhhIdrX2pOuCaLjZs+E5ZNA2Rs4a/p3QMQXQ5qKFlg+qJ?=
 =?us-ascii?Q?TSAiF1IrIWlDx6864msYPgX/nRLMwozhx3MKlq1WK7z2GVLXYR4VT2y51Ovj?=
 =?us-ascii?Q?VpG33R/LIuXvob52SIT1RlChr8ah8w8Z+Q9LqMn6CNO8FfQUeBa+9a9rBrTv?=
 =?us-ascii?Q?BP198fP80EvsCs8mb6/S2L/yCGixiNP/Ez5AxgzdzTUhkvYC+inRuCQuxj+r?=
 =?us-ascii?Q?YHa1sBjcPtFWByvyShCTOaaNrRc36x+8E6mI+CH97pvNPKYS0Hi3JnO4zecX?=
 =?us-ascii?Q?z4WoP8PBjNXAiEcM8zPBataWK74AR9p5xVRRSq5Hup/Fg6fBmX9/tans6aIE?=
 =?us-ascii?Q?i/tfkzcUk7Xbrc7j+glGt64F0T3cBpuFqNVT8blkL+dGEMyGx5bMeMFtVvY2?=
 =?us-ascii?Q?AK74uL+zUE3AD2TJNkxl2lyk9Bpx2vxde6iOBsAoET258LUFI0gJiq9KonHT?=
 =?us-ascii?Q?L6b0v0qmyrcjpD6FTcKeOf5CtpX1EmYzyKkNFXrA/f71G7EHaHkBmtyqfj6J?=
 =?us-ascii?Q?7i+QMn5t1H/qqSN+aP5IFmdKmC6DObaDSdmqwg4AvAyjAUqxoCpHCs/uy2ky?=
 =?us-ascii?Q?0pPwWMttVGLxuiH6xT0sPmT5s09Ddhnjg6cI/qgBvRQNHUW4p6y9QVuepA/M?=
 =?us-ascii?Q?TBUWxACYW48uTlGb+lw4u8gXKZSRGHDHvvAejCrex+cw3dwX00+qthASBnHa?=
 =?us-ascii?Q?qBrhB1OA4wS+wf2yn3UttZCyMivGR0Gp4tC0FY6aZyYQYDO9PLsOyeeiFrdp?=
 =?us-ascii?Q?qzI4/tt9uR1EZ3HLBTjvMok9/zm/n2OXgfa1CnKlfx5HP8q1pG6I9Kuwp275?=
 =?us-ascii?Q?v3AHT6T+v0CmQs4fT1uFXGVvmND+21dTD3CPsjlYnWsrD7AVN3THOMi3e/We?=
 =?us-ascii?Q?QaYjbEb+ekvcafEilPKy2G9q3yKEzrq4tIzOa17t+LKh1fzXFAcZeaIIeYw0?=
 =?us-ascii?Q?g3acnpTGXs/mhCzP/FVxghzgVPFhfq9f4djKvW1WGEt+Z0jZs0lix5wfBmpI?=
 =?us-ascii?Q?AQ8jjbA2WBMQusloSy8euY1tv1bnBm29+cIwMGj5uWf+Y4PiZLS1Uk1/+uy1?=
 =?us-ascii?Q?zkX7Uk6dSUTDvDbDnQde3YzSrdOrDvUQPn9FZeqIbTojc/2ZhK6ROfhN26Wt?=
 =?us-ascii?Q?321/+r+4cvbY5vWuY88RfRGjO3bkdnOQJczG793gPBFd7c/NZg+K4XPx/PEp?=
 =?us-ascii?Q?djezFVlNN7KdWEG0Ye0ZmX3B2U8BWSSlXD+2KV/RHJuHOks615x9OXxf9+Fl?=
 =?us-ascii?Q?grRaAzOVUrkf8WZtPF9Db8=3D?=
X-Microsoft-Antispam-Message-Info: qPNQLclL6JvtgWFvD7n9QjM3aOS8YeW7H71TY+LHf1J5oZeqf1RePXmz+tH3+IiNZuwKDacgqVyu+X11LPhJQP8QLBbBhBpT94l+TlPjIf8PsOs3eeDAk5Q67CraoYMhuS7L+dRRb9qQhOaIGqIuw+35aH2lBLbaP5M6Pm9HSSiZPQStAMk9++8+HAtNsNDWxpvpBjnmBGq6z7rAHBbJ8SuaPXAEzF2AGr2WoCXVrRjEbDPeVPih6JKkgEgGcp++NL9qiOZMicwqfNMhU2lEDRojwY1H0wCXknYdJ3s8L8RVFq0ctQCt416SyZsnD2JRnDSDqzZhJQmdj9Fu6+ulsN0yC3jL82Dniw4b5ec8q88=
X-Microsoft-Exchange-Diagnostics: 1;AM6PR04MB4293;6:yuTQIm1RavJuTCHRJw7t85p3Uiy1wxeGwGuTOm5YlzTBa5lH87TNE7wv63zUHs1tPRfFmVm3pQkeifo4vxxC89utN4tjj72gZiIsTIS+0LL0hl0xQjoVvTEytBdBUC3X77uk8paX819D2MHi8jRLppR7lAbxZnokQ+r5PLtOyw+gLvabjO4Y7apFsyCDLu8yveFipn3wf1rRpw3QojQwxHqjpaRse7PgojHXjNL4KxG34fw4DzmCMNAP9a1Ah/Zrv6zRiRk7JSBeKEt2+PuzUy8DP/PYHHwWtqlHV/IIvVG2DVC5rMuCKYFlSGVemqLSMkVq3+78cskSevGYaqqvJPrnvApoAJwW29iYxbxuwH6YcGwWQEqvriZPRQ6I+rrlzvkiMLVoSFg5TyBQa9lCol5997EXXwzwB3sUUNwjAr0OXMPX+H/Ji84zpB8SQKg713fEebpp+Gp6pkjSbX/bnQ==;5:E+7/AQz5IC1cI8+EpKlQpoCPf01xKehO4ChQKoorKD5gyu+KRxi8+CNw0W1hicOzrXPK3DYffStD8fXJgwpUkkqJqC8c3Qj25B+u9zRQLuEnTZ99ik4jpDDJMg2QK5mSXJIBiyD8H0upqLnMZ3BInKgJDMSTp6HJZO5+KBIQdHU=;24:OrOrejUffVrcSe93acmJa90muren4RjYVmSxCi1KLiHTcFS99OuQJEjKji4HjA9yzOpXduFxwM3S0QMQhA1/R9SOHB/YB4FG3lPqknQ0pvo=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM6PR04MB4293;7:sK6HUT0EDVZ8kBiSG+eCFg3ytG56HMPoDvHEfk3wu8GrJqHaxNfNk8oVQk9BVWcD2fns9kbhta0IP5zzJCtQbGcv+tcVzPk3FQAj00ZH3Fed1F28t7IoQxYWO7kdPzfiUU+OJmWj2KDaOlUwiwWJEhZVUtnLpz+4E+G/MZdtR7Z6OnNaaM0RzsPlkhywOCoPMLes58OhjbpQlUU7aL1fhbGsPVC7fVhYttYONTVPDEi6idiBOmSGu7FvHNWPG1dq
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2018 12:48:00.3585
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fcfbf11-5e4d-474c-45f4-08d5ee3f0705
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4293
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Right now the only user of reset-imx7 is pci-imx6 and the
reset_control_assert and deassert calls on pciephy_reset don't toggle
the PCIEPHY_BTN and PCIEPHY_G_RST bits as expected. Fix this by writing
1 or 0 respectively.

The reference manual is not very clear regarding SRC_PCIEPHY_RCR but for
other registers like MIPIPHY and HSICPHY the bits are explicitly
documented as "1 means assert, 0 means deassert".

The values are still reversed for IMX7_RESET_PCIE_CTRL_APPS_EN.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
---
 drivers/reset/reset-imx7.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/reset/reset-imx7.c b/drivers/reset/reset-imx7.c
index 4db177bc89bc..fdeac1946429 100644
--- a/drivers/reset/reset-imx7.c
+++ b/drivers/reset/reset-imx7.c
@@ -78,11 +78,11 @@ static struct imx7_src *to_imx7_src(struct reset_controller_dev *rcdev)
 static int imx7_reset_set(struct reset_controller_dev *rcdev,
 			  unsigned long id, bool assert)
 {
 	struct imx7_src *imx7src = to_imx7_src(rcdev);
 	const struct imx7_src_signal *signal = &imx7_src_signals[id];
-	unsigned int value = 0;
+	unsigned int value = assert ? signal->bit : 0;
 
 	switch (id) {
 	case IMX7_RESET_PCIEPHY:
 		/*
 		 * wait for more than 10us to release phy g_rst and
-- 
2.17.1

