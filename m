Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24C5FC6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 16:15:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C924420890
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 16:15:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="mkOFfSBl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C924420890
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388469AbeGXRWa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 13:22:30 -0400
Received: from mail-eopbgr80070.outbound.protection.outlook.com ([40.107.8.70]:43936
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388321AbeGXRWa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 13:22:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FoUt8f+TUHDkVu2GWHL4FQQcFTQ1EecaFwjtPoKrIXo=;
 b=mkOFfSBl9cFhdiDEBbfySVlFB23ukREV/Wl0HRnCr2rAqxleKpN30vPMQ/eyperIOHd1pbE3Mto19LVR9GlnAwP7MryaOIWyvvZdE4I5yVRRVzthUuARPalYkifqh7AddCuespUuHQ/4NkU06XQxqKrmVnmnwACYAM0G6oJdLT0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
Received: from localhost.localdomain (95.76.156.53) by
 AM0PR04MB4290.eurprd04.prod.outlook.com (2603:10a6:208:67::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.21; Tue, 24 Jul 2018 16:15:11 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Lucas Stach <l.stach@pengutronix.de>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     Anson Huang <Anson.Huang@nxp.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>, linux-imx@nxp.com,
        kernel@pengutronix.de, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] PCI: imx: Initial imx7d pm support
Date:   Tue, 24 Jul 2018 19:14:18 +0300
Message-Id: <cover.1532448745.git.leonard.crestez@nxp.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [95.76.156.53]
X-ClientProxiedBy: AM3PR05CA0137.eurprd05.prod.outlook.com
 (2603:10a6:207:3::15) To AM0PR04MB4290.eurprd04.prod.outlook.com
 (2603:10a6:208:67::17)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 16bd528d-1a98-451a-a909-08d5f180a237
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600073)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4290;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4290;3:3aecPGwCZ1A/cGN2a82JcUoc60/BP4+jEafRAejxWNYyt8+jA/pZCzVVpyZ4CheUPDMdsQt10j4gcCcz53Q9KpHEDL2g+MTk48NWLtxAyPIV8Xwpw0XF5ZNgMaYJ9bOc2VFXxaCZ+gnOrmztOANcTo/9RdU4TqIZjA1MdKO+uBmc6yUkCHrHGKCiwvvbz0XO/cnDpDxzbsnpaGFbcKhtgVee4gRFBGH01qDdzzlARq4ORtb0A7lE6C6EZN7TkGn/;25:W6JDEt1AeWAZEyJFi53l+FPN9xHarPoKggvlAJIpkcOA3yGOyI8F144L6DNzmlAYn1LTYkqeiF75k/SBD1ZemrZAC+QlgN/Q4/RQwwtzWOhxbCaJl6HmSpWapYrhlagi1CIsMwx4khtSNyIla4X5Vy1XybKQgq32Bv+nRSSgkAuELqb90TIYZRksSgVi1a1MkD1GEJNwXz8YJUxK2TQunzq6gUcA6lWNR/aOGO3RlqQGoPUcLHbog5diPJpU55VlzDzl+bnHdKUiUbEQW9uCbFnNzCkUnTvUbZfrYZYjxn8BaTy4iYxtMWwDgZZzUqznBBkg70RvvOQDa9UWygQUnA==;31:Hfcd/9DOxnr+NYyIpcLlnAFL7VBtpgfzRzMJpHDHHpSM8lQyQkzHHQdzVGHoEQ/KBXeI560Z2LLOzIyCD0KymEG8rmRtSMDsSs0GGdMhK8Xni8jQbKPS2QWVruxqZkaZEzz8ORemWv2AuLEkkrSe3dqPnG0NeOraC3eAo5Jf7n0hGE+cXj6HQY6b3lVNL20dMcGkiRT1Yk4GrAIoSgmQyvLEuLJ3OtNOypAIkPAjAr8=
X-MS-TrafficTypeDiagnostic: AM0PR04MB4290:
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4290;20:5vR/+kMmbj6rcpmmXrbvF+YrCtHtLawvx0ar3NtMKdfwCWPjIN2QaLciU0IBKfq9CHd++UL9h/O/CIhaXKLastAq2OU71DFExfy4n/bAkynE/0a9ckzjZcavcnsEp+y+a8+lBf47Drlse1zHIxmmlrG5KetgboYVMM4kl9pnt7TUxnqLS81b6mmTIhhTucJKgclniW5HO2EJwAtPy31qcklE8ySatsaar85BydbRSQ6ohE+HJJqeh6ZTWXrx5qJLgxnG1mSvKx3SLGULyQnP8S4O40v9OkIiKOfgrbqUvqVoiFNcbfJD211qpg5O9ejN7WAZ5g0x+CDXMAxkW7BMCqwr6jgp/QoJpaBPl2yMp01xQrZjOyNqRHvNba8CMuCCvjP5mCeydxZwpnF+2D7RWxCKfXeOAcbbgwyLQ0uyD7qUOOwAB5+hBI6k7vAbgQ2Yjs+rHndtcJJwX0kIBJkNCz5Xjl2vup7p1q+PvG2M5YlOE9OON2s9pLDFYPecDA6/;4:jfW6moHvRqTahyoWuRPFPZVKKE3zxaYINmjo9yl2wQMF8zv3CF4/RCOzoubeFRrYXe3XyZWJJd7rMR4seKF8UAWA7zjXqvvgZj+SAtVRwfBmGtM0HEJxUAVDSasE8LjNGHcqT7RVre4l1dR+C61zXA20yfys2i8O/tXh62BpwRr8jCoCtyXeZvDHd6IqCg0F/nb3zLK0xA4tqaJGEcFeyFV6PDFKcp/QprEiLZcoWA1YMkad3TVaf3WZty2SPsfkoEEMZfYRzzongxWDekRnfQ==
X-Microsoft-Antispam-PRVS: <AM0PR04MB4290A74E390BE045D5D6591DEE550@AM0PR04MB4290.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:AM0PR04MB4290;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4290;
X-Forefront-PRVS: 0743E8D0A6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(396003)(376002)(366004)(39860400002)(346002)(136003)(189003)(199004)(966005)(44832011)(86362001)(54906003)(81156014)(50226002)(47776003)(97736004)(81166006)(2906002)(110136005)(8676002)(14444005)(316002)(16586007)(4326008)(16526019)(8936002)(25786009)(305945005)(486006)(66066001)(39060400002)(2616005)(186003)(6506007)(386003)(6116002)(3846002)(7416002)(68736007)(53936002)(476003)(7736002)(26005)(52116002)(6512007)(51416003)(6306002)(106356001)(36756003)(5660300001)(105586002)(50466002)(956004)(6486002)(478600001)(48376002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4290;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM0PR04MB4290;23:JaFRbmpWinm9vFWDy04HcMeBuKME9VMYgeROSCn5o?=
 =?us-ascii?Q?QiMJwHaBgAjfgkEhrhinrb/8Lh1/EnoP3T6q8b1xbxL0kyoEC10zmU/tFab9?=
 =?us-ascii?Q?cyUedBVUGWOkVXmzRLTDlt4GpX1sY0nQXYf+amJbiRdulmY/PH0YpFXyCtwb?=
 =?us-ascii?Q?fpc0rsUcm/BGKTms4/HpQ5ftS1e8Jl7iAzMEGZkvWD1bzDSKpX26X5UnmCus?=
 =?us-ascii?Q?yCUAAOnyPmVzyJillBUDqbH8JqsuGi6o/sHf4vihz9gtsYFZHseg4ctn6DPI?=
 =?us-ascii?Q?I61T7qA5H1p8/DMKW+CRMj5bJRBRGzSzzsaqkdma4CRznJKlutkpuaLM87Yi?=
 =?us-ascii?Q?7D8e9XnomIfSJI0KRr4sHM85SVt2er6GTKCSGSpLIzDZ9MACXTpZ+jFNNg6j?=
 =?us-ascii?Q?So74La96pdFET8UOlK5GOfSmu0JNAM1WFsYOfog+OLRK8ke/OdRcf1HriqAz?=
 =?us-ascii?Q?hPBvaSR6MofQ0jP/PCd+PZWx7t8FA6NEVICo/blV/NxoWZnixXoBYzZdXdNm?=
 =?us-ascii?Q?YXmGtBylTHlk7L8f4pRDOXQJX7SwWEZnQW/PmC4Y1vDuMMKFqjS6xwveHHAk?=
 =?us-ascii?Q?XoCsfCKy5vbEUdAo3uGosRcXFS2RtKqawVgM+P5VIRa7zM/FZXsTnZN5Fm0J?=
 =?us-ascii?Q?3F7S8IO/4k+EsMHF9L334ULeb9YLgcgZhTEGWlujHpkBt+EWYhI22qu/o5wz?=
 =?us-ascii?Q?R1ieD0BSpgKrxD0LvBTprSpwLZ4yzKzCiCvcG5s2+RNHaOpaelijhTkIaoqm?=
 =?us-ascii?Q?OIaKJnW4UgqgXDbLqDxiSOlbnf5HoQ6KXGFdCt0Rlfufg90IS83ffIm1voWo?=
 =?us-ascii?Q?146ZBjFQlzd0M/GTDQfbR6nDr4jr7nWY+M3LjwxlWCD2cyRlo70s2GEkEWWP?=
 =?us-ascii?Q?QGHvi/spwt7xJYtSdiqe3ipcmmceYzYSjXFp4at9Zh0tjRAl0kp4hmdMKW+Q?=
 =?us-ascii?Q?QjkIClSrcE237fuRwAZOVWSvGTYqkLGa1fUAA2RMIP7CLWbB79sUL537MGzE?=
 =?us-ascii?Q?66GZn7VT9z1B5MzUAGrddZ1Rg5D3eFNx0sL6R9DhCDyMiPnykPiZP1gGpkd9?=
 =?us-ascii?Q?4j+imMex3PIiq7JncumsML1M2wl26louXeCcZeCuCdSa5/CqwS1zBELenUYE?=
 =?us-ascii?Q?XHPF3F7B4irRHl0yRXMJxfxvAldGcQfdnhliTBurnFDbKJfLpXgjdQQf5oGH?=
 =?us-ascii?Q?GWKuEBvukazzJeyyjMSPb7qongQJfGNbO8gll1iPAf9QQXHGK6uyM3egGUu2?=
 =?us-ascii?Q?HEHwlvYZWClfPQAFu0=3D?=
X-Microsoft-Antispam-Message-Info: dQXUM/iXQAYwZzE7KzJc9pCe5ltkHnhlHQU2/wah1gOS2IcMk6nsOhhS9VaJuA8PKQMtFkg5fShEZooe4baOrTXSrjiUs6MoclNB4iUJceABsaLTYofoOSb6bbyxq/xTIPGY6yRwctB9pjxKvCLDX5h0zgn+GpyWiFfY6jxLf4Hp7WdPGrxZXLA4YRiKN6Rpw+03JIIEZSX8h6gS11CMrx/h0rZvNEWqBEM3D1MpqfVHd5nqYO0aWSY5JRV/vMBDvDNHpWnUFxQkwrBYLLitS62QREwk5Bv5EH5K8aju/OCZN618vRGvF96gHWTLIDiSbAVFFULt0iTnLLng0AnR8bsMyiqG61Nw3rm49ymBOrE=
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4290;6:lF2Q41pSyplz9CVdzTSbfpNrWY8S7f1Z56G9ENfDyLrcq2sxcCAu460bOijfY1Xt5nwz0Zx2ARXrCjC01RfiyWnIke66MLzw/cmrghqUz0WuLpPaKqDzi+am3a3ltRLnFkw5iOeT4XGaPefJAuHZvHrZmunPN061YNg56Y3W0Jpn1C9kcGASk5mDkIOymH2ApO2CSOJftjmkwjEPVODCv3ORUioebW9JqZr17ElhzMoATymVSfYp/poHvuNOpuPNaApwA4t4iEIOVRDiq/yO1L3Is1IvqNTZmDrZnei/0DcIpAeJcnbJ2D7fKkEGWxw74kc9Hz5K0/De81i3TADizDJQx800KmZBbXBC5hfF2dgRgC6MsOIdQ3Qu2s7j86GtqPMjc8gbwtq0W5TA5OYjxRmTdQxvVCTKUR8S1ovi4eU3HwReEjC1rPNH4IYshXzXpNqC4IZQoV7bWfEF05jTzQ==;5:XuH2wt6FGB6pvyTJ9kZr216IpAgko1N04XFgVU/Jy4Jn/Rjhm+e7HDazNzOSL8AVNUCIihXDWn7CwqzqtO2M0/lLPmhRnuYb1TeSDRvBg4hAiHLFr8XyOT9H07cYPzr/LI+WPwBvK9lOK+Q/Chkpn4xwNEd/gbEVFlH/4dQBNgU=;7:sn3gCDeybeHzfHMg9isFyHkh/dkpHiZygc7RwjCbTQbDNjcYWoRRHLTPq2qU3tAEC/kIfJjgJeTOCIHvKs2qloKis/XR9RPsnsluSNNpjOnaFJMrhafofMTOtih6ATq9lCCcU8SS56l6s6RRLCLiZbAyncp+xtRIRSVeKfediiFHrKBVVGNnWU3NdiQ2Pg3oz3b0zmWU9gb7GnMWd2pCebVs/DOFX7bY0lsMXVFsvachjqETC+YpNHo0qMqEiOLz
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2018 16:15:11.4489
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16bd528d-1a98-451a-a909-08d5f180a237
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4290
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v2:
 * Print with dev_info if link fails on resume (Lucas)
 * Add a comment on imx7d pci irq mappings (Andrey)
 * Make imx6_pcie_ltssm_disable print an error on IMX6Q (Lucas)

The ltssm_disable does not return an error because it can't be usefully
handled, reversing partial suspend is a nightmare and unlikely to work.

 * Drop "reset: imx7: Fix always writing bits as 0 (accepted by Philipp)

Series is against linux-next tag next-20180724 where the reset patch was
already accepted. The imx7d.dtsi patch is also useful standalone.

Link to v2: https://lkml.org/lkml/2018/7/20/472

Leonard Crestez (2):
  Revert "ARM: dts: imx7d: Invert legacy PCI irq mapping"
  PCI: imx: Initial imx7d pm support

 arch/arm/boot/dts/imx7d.dtsi          | 12 ++--
 drivers/pci/controller/dwc/pci-imx6.c | 97 +++++++++++++++++++++++++--
 2 files changed, 100 insertions(+), 9 deletions(-)

-- 
2.17.1

