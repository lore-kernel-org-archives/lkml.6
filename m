Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DATE_IN_FUTURE_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 218E5C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 09:00:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C678E2075E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 09:00:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="R89bN1Jn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C678E2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937550AbeFSJA5 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 05:00:57 -0400
Received: from mail-he1eur01on0087.outbound.protection.outlook.com ([104.47.0.87]:3242
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S937410AbeFSI6E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 04:58:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N1lbTXjQFvlybmaLu0QO7GawFMybVJDj5XrMowiJ21I=;
 b=R89bN1JnUtD+XX1dwqXt7OP5NE5sePNlsQdxLvEq06m9z6YDDOTKpzmfUqRSkvEGXDB92k6WBlaQJC/WTVPPHqmpTa+h/0b9mcSGV5w9JEswIHDOpndsWuHLjh07vkFmyvq2ZU/4d3cB7Z7RhQFBfUNNDNkmoxzdo/+B1igWx1U=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.66) by
 VI1PR04MB3231.eurprd04.prod.outlook.com (2603:10a6:802:6::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.19; Tue, 19 Jun 2018 08:57:52 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     vkoul@kernel.org, s.hauer@pengutronix.de, l.stach@pengutronix.de,
        dan.j.williams@intel.com, gregkh@linuxfoundation.org,
        jslaby@suse.com
Cc:     linux-serial@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-imx@nxp.com
Subject: [PATCH v5 1/7] tty: serial: imx: correct dma cookie status
Date:   Wed, 20 Jun 2018 00:56:58 +0800
Message-Id: <1529427424-12321-2-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1529427424-12321-1-git-send-email-yibin.gong@nxp.com>
References: <1529427424-12321-1-git-send-email-yibin.gong@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0PR03CA0073.apcprd03.prod.outlook.com
 (2603:1096:203:72::13) To VI1PR04MB3231.eurprd04.prod.outlook.com
 (2603:10a6:802:6::28)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ceedd419-0d52-40ed-2290-08d5d5c2bfdc
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB3231;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB3231;3:F8Rg4LOVN5QvVAvC3FeLsze/fqI0xp5EMtC+uslrCSHxEi33SHw/rBGPVM1BUL7ESajEzG+d1lDzev93dWEfk6qQnmjeOQEuqqqbwpwnbNnx4rYdb6fQcSOqzOoyRbIgfePl1z2lsg2ffkT33t2bSoZojjA4qU4AsX3iPES4AABWL33IRoUHobAc9RNRfUigifPTv9VOVPjNgNl1d3GqM2GpNmZJGHpgE2XQhohGOTMdGFVdFqm1d2JzACIRcCEc;25:cX+1xnZHI0jO57WSq6MpNngMCYg7ft+AB1F8/ye52e7TgYGBa3HC8peRGK5djMxxLc6rMc/PVQlKh0H0pgN/izseXTRQgICW6ee5JB0A6o4pGcUhxJOn5ASzL9ocGHE5w3OzIPBIpH6o/pXGCz2MGY9NgGL/8N4a8zjqS/O7WXwOQYSedvxOlf6spB4lm339zOXOVekgHmQ0iGK+/jXesbZeTAmIqvIdGtSJOrlU5fKALXVWdEgJKEvSHDyWlnzk7TqIGcpsbkHdqClFiGin5Dq5xqOK9N4H+57PIyKtoEkfBHyHIBiIc/+FtDsjWnYeiOZAh6lAguOR/vgtJbXJvA==;31:49cZw+Krgj/tsWOl6iyYhc1+kgKkuyefG/LseoQiCpKg+acKARrMD/qRTWwCGdmsrPJglacVwNTmvDwAOWRcKco3WoKx2sMuJgl8yCCuP+rtlhJ+l3hgPFFxWtRwH4Pn2zCjrw4DqhoxaB5IP662sZgrpuOU0DBvsi2E/COvDUoAQnu8IfkQBpRv+DDDJwaygl52Oaf5qlzC1TkQHQR1u8pjLFm8FVrYm+LdLDM5ihA=
X-MS-TrafficTypeDiagnostic: VI1PR04MB3231:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB3231;20:GnagBEmC46Ecq6fzCKg6M38D0GCfoKplPOwUBtHjnBTpY1pt1eKRHj/s4fqb/5A1eJe6/0pCYqSiUeWpdqciJkcFHe80I/nhaq+sORf9JBdXqg5M0gSnbzWPK3ftYzk5LioZl/M6SBBUpBbXAm0b718rS0vvssvCEcxZdkSO4rerLPfyUwXlQ51PU58NT4vV4fj42w3SACILZGshBEEUOn4gmeCjLG3Kip7LpRZc2OuW70PgIJ1GUu3+QpadQPfXmbVU97iYFZigEpdXS/s7OY37s91fSyZ4n7NirziApF2NsweVae3dz7aJ311YuA1fdZPckU2fMkjLYe7/yY7X8pwE4nPzcFG4hpf5LUvTej3CxEVA2naMycGlohEFjxNFuXEanIx/TQWXAJSl8+cUMm4g5qPxHMmmSKcSJ7vhfc/4+BJTTZ2jS77krmIPiKHh85WYShv7p6YnSM/GenVklGamnXi1mNzaqEdxxJJKlCH6XylZ1Eqrp1XyGENDVrVN;4:I2zWt2EC6zNKKvo7fPt6GQ3NWP2pAhB9dtYpg+uAeSp/p6OXGx7EMXE91JxQt+wMLCTH1JlOA07AvxRPXoLg/jvQjOU1gNBQHT1rGvZrjBKgE3Pzg2CydFeQIB7561LpD6fIMRy+4bsUVL+KYOxoKVs05a1t4BLsA+3BERbxNpDoyDNFNbRZRkVAI+uhevVpaIZpigO+spvX6fs5bf7rD++x4fU0cjf4+uv+fvlSwS2gna7NgzIzQhU6V7bXbXYs9NzCnw3dikvsnK7kwq50NGyTsOXOqUfxk8o+LwECNs+m1svZQ22/8UpgHDDqsevP
X-Microsoft-Antispam-PRVS: <VI1PR04MB3231459C99768C85E909592289700@VI1PR04MB3231.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231254)(944501410)(52105095)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:VI1PR04MB3231;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB3231;
X-Forefront-PRVS: 07083FF734
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(39380400002)(346002)(376002)(396003)(366004)(199004)(189003)(53936002)(6512007)(5660300001)(478600001)(386003)(6506007)(59450400001)(26005)(52116002)(4326008)(25786009)(97736004)(51416003)(76176011)(68736007)(47776003)(86362001)(66066001)(7416002)(105586002)(36756003)(50466002)(6486002)(48376002)(106356001)(316002)(11346002)(446003)(476003)(186003)(16526019)(2616005)(956004)(486006)(81156014)(8936002)(2906002)(3846002)(305945005)(6116002)(50226002)(7736002)(8676002)(16586007)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB3231;H:robin-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR04MB3231;23:Nd81qS/OScZ6MYz8KNeQ2mlZzVQ1+G3lJ9bQW6iok?=
 =?us-ascii?Q?wMGeXwctDKgk5rR84NeiRQX2fOQAgKVgu13YgP9VxhNfjQTdebL/gCMNB9zi?=
 =?us-ascii?Q?bCemm36T1NAB1djxhG4rZyNjfQ6M7OLHaQUtj2anirP1qSgZUiBoTdFPgW5E?=
 =?us-ascii?Q?VAiN78wYECxrIwZqWjq3b5D5WD+EHR6Sx4UWZLZsbEmoEeKmC5kCGkOr6v5m?=
 =?us-ascii?Q?PkXDoidUZCYB9PQrI4r9XAyB+s7wvVeGRq5rtLzImx3LsF6uwnGM1FcjilI6?=
 =?us-ascii?Q?SQg6SoMvfC8sORIPagQ9S+ihU/x8OjPbYVDNRt7ANJl41gpMnZivue5mAneW?=
 =?us-ascii?Q?ywD8jvfkfyftVmPidLrQU9aHN61rL4ZK++CSVaadJWfQijWSqPeZJDcO608x?=
 =?us-ascii?Q?Udj8uRls9GI/rAi3lHF5is0CAHWSyFJDscUezxw8i8DomdYE0q5HYiTnAfnd?=
 =?us-ascii?Q?qdwDGYT/fduUFoDIPMrqgVgCp+U4NaDNSVSfnNTKrlXo13Sf/TPdV7Cjmwfo?=
 =?us-ascii?Q?kmoONeAl9ikMpc9aXLuR21gTzJq3Rucv25DOsJVFBwOyBvcuvPPEKKVZaAL2?=
 =?us-ascii?Q?V0V57rK7lpAeIw/TtXbq221A/xcFj6/aPilSf048D1HyhJIAc//WTG4az3PD?=
 =?us-ascii?Q?+aUPKhMSf4dKk8ehB6DCdDxAX5VxQu6yP7O4nJ1TIVMZmeXCrGbp8dkVieL7?=
 =?us-ascii?Q?0LQM0IeNaFHqxQfb1fSKcnWZjFYLPJk4svyxC/4KFwUOeZuxEjXDH6VMYNEU?=
 =?us-ascii?Q?AjetE84V2Fh/WKyutl9AjDKMUWPCeqnkdwab0pUIGPW24hkGkPxO3FHNots2?=
 =?us-ascii?Q?B1zpdwIMst8+pi6s02FdKHsHgWLu5DGyzEQSVAI3/mOSMthvLbtu+MSEfp7L?=
 =?us-ascii?Q?VQC8Gu0UAy/HORVvoT5kd/mE+rXDE2MBzPjkcX7VfvFSUyWeBka1hXy/VicM?=
 =?us-ascii?Q?snhonox0BW9Rgjq2cvF/90aFvi1b2bqENLSPIF61ZDzhx5fCOJP/WC1UIkRF?=
 =?us-ascii?Q?Ie3nqDmnAUOhjtSIKBejjthc10WwkZg+5XrUapnQDBEIPyhMaT64XwRz3GSI?=
 =?us-ascii?Q?XGRa2YvyJm935Z6CFBnA/j5M32t/OE1DfnVWdj7pUI4aX1udQNoX5trvAV1e?=
 =?us-ascii?Q?QTMqpnPmSyx6/XWneF0NeBip5NMie8AHLFq2CHCdb0qxQRvcBK2e+PzyGSRD?=
 =?us-ascii?Q?QJ6HOu9NpiWrEE=3D?=
X-Microsoft-Antispam-Message-Info: WxRu5yTOgS1tnii37JOMuqzGUs9wNvT5Icl1opOviivpCO5+4JcDsiePDcDAxjxzu8pxc4XjUJRKVPNjwVsuee9oreg2POjif59peyWUsPheRow4A0sjlzH6jP9uvyekP7GUscCcShghHhAvybFDq0V/2qQnU7xQ5wxBKy5SnYd7Uu5WHSJURQjNdXpBuKfru0k+ZTmPzp2o45BJoZ44z3V2mibV0HG9yP3vlLcITx01PSoMFmz3kGjUVntiNwp14BPeBnYVawrEUIHRNWo6J62jVHwUmyUDPTFysGpuR9IMvZkki+OCUoL+g0VE98kz
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB3231;6:/I91WX6BlKmZLBROTXm6gsXfhs/cr1F/OOaYv6Fuu+y8nBqw81GCcwHXlHu3kMkC4deM+F0or2OfeZuZ+zIJ15j8sEnejpM65qvzZrZphVYpPrpC+QVfZ36IGB5YthDFPGh6on4/y3/AkmxGKGXsS1CW6j9dp4u10MVvLb8cCq5YIClz/9zvlQ1cXSz7BrWpigoNoLjsU088ZVGKLpQ/Y4CLo7tEOA5Q+aApsho3mfBDtCKZUG044p4Qp7oFKppq2tJQUHBYTlNvG5cM70KFUAj+NK7D5QpUhrh7zvEst2oKxJq7CG89LbWvuAZaTgInyHeZyjmpj+Uvp4VA5Zus3xDU6q5Sor98Zsr8B56nClkI4sV+j0odo0dT+DQi8gqdWnN7kTEUN7CIJ2NSlVVho1iMK0BRTScrqzHgRbQ/JxbJA5hGjcnY0xUQ/wQGEA8CRsSgFekK53IAvxj0dHCVIA==;5:QZQTfFalDcyPlv43DMHfuUZpAmCi8Y8HEIxypthVupsIo4E92Kkd2pkFhQUa4kzVQNGewlsWijmzGZBDqFUw71sk+pP3vPqbpGrIrVvB1mMlf5PtB1BOzho/c7Vw62icqlGDK1RgVTQzjyuSAPmVfMawXZJc5/Vho03lAxVPmrA=;24:8K+DWktC1HGa/n8DIcCCtvi7LbcFpa9n0Sde8/FPzUgJEdhHgQeG03t+0WE7cvOMRhEGaTdWqXSDk8e6CR9sXbHFw+tcswDLFI6mNHCIjLs=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB3231;7:3YJtbdnaLcwwIlwI1Zz2GIbjmXKmHk4DWGNsGrh6ZQF6c2zlv0qKrfuW8B47BK89HpeMJXdtkqFdki4OKA/jAnWJxUqXL5JepJtvRxGd/PvfXllTRgMfTl2U5OAJbvv8Zz9OuStCfQNQ+yZR7N81pX21A+/zjWyuiVBb9OIpgvVZz9dUIhLDtZRkQKYUUdooS1lx0uicxQhshVSgv13zwMlsFVnzlBddkivmtyzk7WNVOleOvU0i2THTIWz69OfH
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2018 08:57:52.5524
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ceedd419-0d52-40ed-2290-08d5d5c2bfdc
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3231
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct to check the right rx dma cookie status in spit of it
works because only one cookie is running in the current sdma.
But it will not once sdma driver support multi cookies
running based on virt-dma.

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
---
 drivers/tty/serial/imx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 4e85357..2879407 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1051,7 +1051,7 @@ static void imx_uart_dma_rx_callback(void *data)
 	unsigned int r_bytes;
 	unsigned int bd_size;
 
-	status = dmaengine_tx_status(chan, (dma_cookie_t)0, &state);
+	status = dmaengine_tx_status(chan, sport->rx_cookie, &state);
 
 	if (status == DMA_ERROR) {
 		imx_uart_clear_rx_errors(sport);
-- 
2.7.4

