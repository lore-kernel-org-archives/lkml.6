Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA9E7C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 11:59:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F941245C2
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 11:59:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="U9OaUXDa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F941245C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934135AbeGBL7a (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 07:59:30 -0400
Received: from mail-eopbgr70048.outbound.protection.outlook.com ([40.107.7.48]:14600
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933061AbeGBL70 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 07:59:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2DviNZVd0eri2mFT2/UyLEieycn2DYCOZbwtPTsbHc0=;
 b=U9OaUXDavG5jkoZL2BAYn81XOKiUpah1FGi04rfzkRe4iTXKBypKjUCUH7Oqp+bhQcOojiU9/ASMBXJhc5YxwbzOKzskERt2Eh/r1tB1u0jAqyGPmu1qngDj6Qthkf7R9r94/m3xy79A964o/ll4FBNvxbSkYkpJyMAu+qMhJlU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
Received: from fsr-ub1664-175.ea.freescale.net (95.76.156.53) by
 DB5PR04MB1607.eurprd04.prod.outlook.com (2a01:111:e400:5994::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.906.20; Mon, 2 Jul
 2018 11:59:19 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Lucas Stach <l.stach@pengutronix.de>,
        Rob Herring <robh@kernel.org>,
        Dong Aisheng <aisheng.dong@nxp.com>
Cc:     linux-gpio@vger.kernel.org, linux-imx@nxp.com,
        Shawn Guo <shawnguo@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abel Vesa <abelvesa@linux.com>, Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH v6 0/2] pinctrl: imx: Add driver for i.MX8MQ
Date:   Mon,  2 Jul 2018 14:59:04 +0300
Message-Id: <1530532746-619-1-git-send-email-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [95.76.156.53]
X-ClientProxiedBy: HE1PR0802CA0012.eurprd08.prod.outlook.com
 (2603:10a6:3:bd::22) To DB5PR04MB1607.eurprd04.prod.outlook.com
 (2a01:111:e400:5994::21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: db0d311e-07f7-4d1c-e8f8-08d5e0133ef0
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:DB5PR04MB1607;
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1607;3:ojgpaHsNjQQKRltnOk6tRJK2UmL1+29R0lA/gbyvNwqeuGCQALD5SyD+Xwlnc2cSk6qfEEJCSdDBH20hQvrUHnoRtwS5fN3V93c9+GYV5chqhsUTmcHHGBZVf8O6H/9i4P2DRJgPyV3Rzjj4ULsuRFILIU32DlS6qcAjCN5Lf80t/gStgd+B+pFR9rU45XVR80HEY9MZen9H3+a5sACctEY1GHFtTBi8pjZDsbg3kzoziuW600GBqlspYNdQzwEI;25:kGwHQJX3DVDx3wtOkyPytjYuy26y3lkd5ESXxVKIppogBwTIo1HHCQu3c4DMzd3ymIz/8VAct2jHsNRUf9Oxr98Z1prP94Pn2oYw7HT6+jY1AB1IQj0rVij4qsJS3eglxjPdWg5NjI/Wi2eotCPXjJjoyw+4tbsvU2Q0w7s0G5NSG7nDJTz/Vsiks46z6FJaxaLuzUV0t+eMhzwfBrc6o5TT/nRp0QISN7KjXKm90JLPOeu7TVXmy82Ekgf2TT9eXy/mZoHdfTsFu4w1EAguNzaM5tmybeXv77l6TEvf6WRIwGNW/alOL+MQy3JCAbYUxFN1ZQrQCl+wV0ulrnt21w==;31:CozihdD7BFK2tjBIRr79BnJfg48WD+kKlm55K8xVRivaGSLUsAQQRvjLknanuLezgNblIb3dxtba2uan0rPgagm7P2E03APAhOlGe0C+PyxamQTzi38DsoDvdq6TLWUDvBJ17uETrpPoghzKTIEP4pEQ2Juse5Hi41VT8KXhtXlrCUobuK24e9L6X86K14KH8qq8xlQdZyJl9IlVTQYXhiaxskdlPkE12vt0QEK+Zrg=
X-MS-TrafficTypeDiagnostic: DB5PR04MB1607:
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1607;20:Mb986lrv/mPGLrXvZxm59l/yfShIcbjK6vLtosGX1uIs1o1LuYBwxPOVv+NyRx1Fo1m9PPhzwJhODmqKDq8nvryyn7uHOQQOPZx9sQqkw9qXKV8c65FmPN1Aqr7hfg2UYTGF1iH9SUpmsBidHQoZ/uk/4O/ve/WATva/4iur/haAWH2JYlPZjdz7ZLmpW4GHLA3Qfs8sHFKc85EUIJs0TXEUWudfsAbnCRfkirxuOXoa0E3IFhx9OUkoZnt+xL3tkVwGPLXpRbMsI/zuN7Bvflj2SzV0nIKC3tJsv1tgxPmGGAfuEBleZnf0N73B1VeTrsG8jcxNIKR+5/HkWmC27Z4sQEoel52gtjpf5SlUT+Lk5pOZdrNGuWNMLB12zImwzI0vEg1gC9cOqvBfn4N+2qfFz8zCbxO6AGCgfXhEqyQ6g6OqH4Y8BD5kaLsSnutbf0A2w1dsi5HFdKB5vsIL/DcdRiDwEFMEaBOCbhDG1IJdTGjT5pYrhM6oScJF/rM2;4:RbW5woLMgPcctCeQ8aVjhryqtumm0LPo9wREbCh45y/nJlgXfsPOGu+x55tPfanoPaJXA+4XBpOoPtGH08KKIP7TEc8NLhRw7Jk4oC6RXycn5msMpvp5wXpAqBlARn4/nL6zs9V9kta0Sicx1DnUlIDn1Bap1T9sq42d0Jl+Gr/JdnqUiVAV0HEitlQOcNfJ6BrUXddEFFUMBsI9hzLTioO3sOirpg2ky0OCpL/uRHIarY3L19BmgZx8pSC94NlUDcQSOlq63jzGLUlrIPYOrJ6YFm/Jh1Bp6gKSS5zJ9VYZCmTbbvxmN/pLYlR3jBO+
X-Microsoft-Antispam-PRVS: <DB5PR04MB16078CA97D6ACCBAA2E895A7F6430@DB5PR04MB1607.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(17755550239193);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:DB5PR04MB1607;BCL:0;PCL:0;RULEID:;SRVR:DB5PR04MB1607;
X-Forefront-PRVS: 07215D0470
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(136003)(376002)(346002)(366004)(396003)(39860400002)(199004)(189003)(16526019)(97736004)(186003)(26005)(25786009)(8676002)(476003)(44832011)(956004)(2616005)(6506007)(386003)(47776003)(6486002)(8936002)(81156014)(81166006)(53936002)(4326008)(6512007)(486006)(6306002)(66066001)(68736007)(50466002)(3846002)(48376002)(51416003)(52116002)(36756003)(106356001)(105586002)(305945005)(966005)(5660300001)(6636002)(6666003)(7736002)(54906003)(478600001)(86362001)(110136005)(2906002)(16586007)(316002)(7416002)(50226002)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB5PR04MB1607;H:fsr-ub1664-175.ea.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB5PR04MB1607;23:SUmFrZ/m0skBE1QGmePl9is3TOT0sPlJQDU9wJukk?=
 =?us-ascii?Q?H+DcYVm5mJxTfhKuez5jnsaLSrRI0XoDZy0tIDsSJeCK2sKBgXYudXipr4x1?=
 =?us-ascii?Q?1H1AZ+tP5s+rXbPa5nBkFbkFix95Db+1HSFFPH5qjy3S1Hz9//v6G9YVhf5U?=
 =?us-ascii?Q?wfdEg8NX3XzTDiddLunaZfvIfpHqXkmfrSsfOBykINxaKz1X11ioZFsHChxH?=
 =?us-ascii?Q?iYr9hoG8D2v8zq9R63dyFPT0RkIbf0AK2j/JcyeqkNAdFUEAOPRyo+W9vvsm?=
 =?us-ascii?Q?IQBcRifxT3Jm3PDG2vpzYDFvCr/EeX4h/zGDpsiErY7s/3abWRbHybGQg/QF?=
 =?us-ascii?Q?5As5GMe73A/vLUNRcxMsI/yEZO39WEtQslu/Ub3YLdIS4KGT+JWFSzZ3sTde?=
 =?us-ascii?Q?pVTKMmvHGwj2L/7I37d5ZIaaNmEduefT7LUCU35ust1vUGRdKAzNCe/BIdTs?=
 =?us-ascii?Q?zNVK2nfT11F1LWIk6i6xew/J+6SM2X3ttwoIjmRi5aaokLjNSxyf1u4rL4s8?=
 =?us-ascii?Q?ixzoC0TiErrBRnJSgDNJXpV7SW1FiOWq7qvbp2ulfbhqemtxdvG2/dey5Dax?=
 =?us-ascii?Q?NojNK9FWwTgr3c1LaN1gFhxs3h8jbDkTr8yQrAUBlumBUJQldKs9iUXDz0Bm?=
 =?us-ascii?Q?vF4U98Sd+0I8jKozCWNqzZJePs9FAo7q6nboj4bBlIPNoj74eLo8xdcjPRSl?=
 =?us-ascii?Q?o5zOOWaMwaAT5CrhAbfX15DAofVw/KyCTLsxLHs38pRw1a5vhzJ1unpRno1A?=
 =?us-ascii?Q?bKyaXGNOT9ZqXNf0NFmyzq42tayvWRj85hqlULMbrovgDlGWEVIYZ1BfmiDr?=
 =?us-ascii?Q?MftpBX0aSlc+47vGbNEdY9+vxPaG4tLCIGudArpfktM0JUuEyvQSquFn8Y3f?=
 =?us-ascii?Q?cX4i8DxqKfkAnsyfu7Uzxyu4PlUqrLn9yFx7dcXIc7ulP8wGhI6TlHgu1MtI?=
 =?us-ascii?Q?U7/ghO54c2ZF5d1i8ZVe7ztVR39N5bIEwImHV8Ey7KfwfSpw5EavMHNkYsGr?=
 =?us-ascii?Q?24+gjwYPWkOlh65z8/UgCTdVLq/fvJ/O0GXVDQq+7+lQ9YzWQOpWt6e55KA+?=
 =?us-ascii?Q?u/MfeaP96o1bH/PcdpQSMKX/kJaXGEzpBvpA441y/tGdrN15fVkmDPDcH2/T?=
 =?us-ascii?Q?CnqTl92o3UHxGRvgXK2txvo1zZ9kWvsoiThS32XpQhn2U1jGkW6Nwq7j1/eC?=
 =?us-ascii?Q?v0AbhB2kzVyNT3NSV0njhktp3BOymiefZ/CuIfaFFOVeEPaEHdvX/BURQ=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: JB1Yfy7o2XDD8cOlcUU2u+prBVGhoUibnbISil1lRzeJ5JQYxbXgj9wYJHL/ppXVlLr5vmeR7s3LBvdEhDzCevSk7qai/+Jo7auKza/CQD9WiQRMABguiPAJXp079z+W+PiasdvRHQY8j5X1vKzgfs4Whh2KhJI9lzmiYOnFPwLjfvTSIKPcWvCd40gqP4LikVAY4yI4h8bIae4lmEbRnA/9GgUOFFZJmUlBt84Yt+uUczp7g6Sum9h0uZp/jSSlZ+K8ZI0ahFGJ30XO/LEeNZxttbTZNJnZu1+3eIX0NlLaIOKFJ8LqjwwmeJwox/kF7z894xedZgyIEPsY4amzOMzOzX7mJqRm3NLWPBb0QS4=
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1607;6:cjK9N2Iy5OhCMXSeaIKMHMPLkcp6h4o9byoZ5yNJJbWHPEyhbLdoyyNgICrcI+yIUtIp69NzhTGCYXI2vOzXigA8Z9SVtgOsYXo+soGv9ytX1g0qmn8UxaEulgBJc3NMT4PE3yFdguV1srZ8yzhnTeJwBmJrqqzVMgVz7s1CfV+nP4Wp/A2Tu9JSeWXFFTz52KZmOIC1LqAupAHikchwYfncoTP6b9bGkaQMnj/rjxACiJyqiKxZolkndCB/cKD6/pLsB26Zuw11eIw18skQiwVEZxftqxau7wkeKAGHhi1jIMNUryVnHz0zIJ7fEGjgWSvu3kppzOSrpHbnt4Y0NxUnKYJyAj5vOGg66RbUhpTruMyShelC48H9kPc0x2gSxTuWhoDqcXw1qzP8VYJwX5IQ+2Nt8roCtIDrwNMsjgbJEGB3trmJDXbqvImEU9f3KeaErJK+IF3hOCBr7TCXrg==;5:jGSn3F7dyxzLJ3NgvmY8iwXX83wguCwhRsRRJTlniTf8wY2Tc2FUfsEPlyfZWwQ18Bz2q9pR4NKSKGJSDRbiwNqdiruAUauiTFwVikPn94foGlQXKWH1RMUhnM4xFbFkU5dX9bIcAUPE01WYIfbb7ewFygf+b06pEzzV1Qa1oUU=;24:V4HvkPdbzXudiCevv2bHXabeaOXXWqOjZVR65MS6THMUu0KgGmCd4HOVUWZQCOgX1qU1yNDRbDhEE2Ss6nwj5VTRM0Kf7696+Ix23J6uwNk=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1607;7:grRRRcA9pfGI6Mjt2yENXXIctWKF09AkPGG6ofNaIAHntY0X4Zg8uYRBd8pEPfmbOYe5ycxnB1eEt8sBSvXj4OY9i6t/+/eoOsxonS93wksFXiifIUMq6eo0EUSSETPvaJerplE1Ymqn38jrKrII1y8+yAuN4NVVe4nMPFcXHAMT7bCVMzM2NTsXn0hv4QlSPV/Ev1Y1sajcePx4C3IIA1ReKLpxGigXqEwoOC2O7F02sqIB78zPANnC/nQAMVf7
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2018 11:59:19.1831
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db0d311e-07f7-4d1c-e8f8-08d5e0133ef0
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR04MB1607
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the sixth version for the patch series sent by Lucas.

https://www.spinics.net/lists/devicetree/msg212752.html

Fifth version can be found here:

https://lkml.org/lkml/2018/6/22/501

Changes since v5:
 * implemented Rob's review comments related to bindings

Changes since v4:
 * implemented all Aisheng's review comments

Changes since v3:
 * dropped the SION generic pinconf changes
 * added examples to the bindings doc

Changes since v2:
 * switch back to the 'fsl,pins' and hardcoded the config values
inside the dts.
 * updated documentation accordingly

Abel Vesa (1):
  dt-bindings: add binding for i.MX8MQ IOMUXC

Lucas Stach (1):
  pinctrl: imx: add driver for i.MX8MQ

 .../bindings/pinctrl/fsl,imx8mq-pinctrl.txt        |  36 +++
 drivers/pinctrl/freescale/Kconfig                  |   7 +
 drivers/pinctrl/freescale/Makefile                 |   1 +
 drivers/pinctrl/freescale/pinctrl-imx8mq.c         | 351 +++++++++++++++++++++
 4 files changed, 395 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/fsl,imx8mq-pinctrl.txt
 create mode 100644 drivers/pinctrl/freescale/pinctrl-imx8mq.c

-- 
2.7.4

