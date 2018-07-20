Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E988BECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:48:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AF4C20652
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:48:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="TOsbNUbr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AF4C20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390159AbeGTNgL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 09:36:11 -0400
Received: from mail-eopbgr50085.outbound.protection.outlook.com ([40.107.5.85]:15725
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732146AbeGTNgK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 09:36:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+R13YOujJYB7WewOSzGUk6TP0EL09rw3biRNfJfvSaA=;
 b=TOsbNUbr93cpK7YNPN1nA090vTqtuiuQqONAOoZQLUrgVjjAfZIUqrp4M4L++kaHk4DZhqgSYlSBp8uisi5ztaVAtcxAL3SiNFW95uVoydvctf4KmEp7E7SdZxZEGoRazbHS+4mrh+6ovtp6rFrEgCKrDPqIDjN+SihCr+GHzRI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
Received: from localhost.localdomain (95.76.156.53) by
 AM6PR04MB4293.eurprd04.prod.outlook.com (2603:10a6:209:4f::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.20; Fri, 20 Jul 2018 12:47:58 +0000
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
Subject: [PATCH v2 0/3] PCI: imx: Initial imx7d pm support
Date:   Fri, 20 Jul 2018 15:47:41 +0300
Message-Id: <cover.1532090446.git.leonard.crestez@nxp.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [95.76.156.53]
X-ClientProxiedBy: AM5PR06CA0015.eurprd06.prod.outlook.com
 (2603:10a6:206:2::28) To AM6PR04MB4293.eurprd04.prod.outlook.com
 (2603:10a6:209:4f::31)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5dc06def-1631-42e7-19b7-08d5ee3f05b5
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(48565401081)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB4293;
X-Microsoft-Exchange-Diagnostics: 1;AM6PR04MB4293;3:sw/+bV9GOe0orbMQqcjEXezft/pZpz6AX3VekJOFAODb6eAYwgc/5/PH7fr9iVVHeb/vAS8uMg8HbFWarWJMBJFqnrX2T9C0oiaoSsgcmmZbQkyfNTdu0vfvI0X737NubydYCKk7ulZTO62x49elVT43vVxS/dM/WI5cLC3wn7i4naWSVYXDcvbUSMhs0yalXbmLNCpI/ihVKrcmDW7cteU+fLSpcNoL/m9nauT6GgeXj1Qj3OrdyVEVKlE6W8qb;25:6xEs5+nsQJXxdwc8Hn8iifIy+oTB4edDS2bj/IPAEYjLMONpAB1gFT5eouVje8cr+mZDbs9zygNF1BoujW4qjkEbnAt/rSZfOqN/dte+Om3N0/aWkaGKpESyQhPbc7G7hfOEajTemgbLT3SnjKQOpP8BhRq9ALEASXwZK+jv443otjkEpKx2GAXAPIgk2i2mzzBzG7sDN4BpGVMYWRvcvZYZjFXzffECIzpL5YZ8UsiWyxSZqMD/44J4ourl+KckHuXsKza/OjqNa+V0pJnqefXuTyrD/ArisaKW7e5ss7TO8G8IgpwAKj984s13l6WNIjwCLCWVa/6KIDJPlZKJ9w==;31:I/hVHpKVkyGl137qta1zcs2BPp4mMCO+nDtd1CpwZ+JVoRJMou3YNeENE9z/EEaeIZ4Pp2rIzD9dmudaYNZSuc3zMntsHG/L7WbGQDskvw1MtazYjYAY3zPUBm3IfxxfcMB8Xsg4LFt8pWtTAeDdkVXJL1UpwZ/xUIzbCSaCpz9AjZ7qVamC7HtHAKswL08lHmY4mJt5qOfZrA3m5d+g5q11o/ybldh6o486Y0LtiuU=
X-MS-TrafficTypeDiagnostic: AM6PR04MB4293:
X-Microsoft-Exchange-Diagnostics: 1;AM6PR04MB4293;20:qrkvaaampKoRpDcXHokGIIWPIh00nCtd2m7C6hurwJiXAt3GaaXQNfeaWrXiaoU9r/dJeDlEVVMbk/lfFE0Zd0zWrCY31tkdcuLP3AaxGSQopXk4APQbJfv0pas2nrxgWu+3q0FLNneVUc9KDdBMyvVxuyLFc+d9xBO2DcHqf6FkOJM9sWGugsZSaT13cOaFM3XNbpA1BM4rC2vPZJE4vSzM5ipdv1S1+IKuV9p14j8e3lVZYsKiX4tJYOhW/mIF0zdGGF+5M4km8jn7zAdyKizy7dMON6V+SwAEzKx7Yl92kuorqn5VzEIpTnw7lXbI4WcXBLa3kFPRsSkrr/1bh7xaMTYcsqWAucseANDlpqC92/7IPbNSEXcfdFSg9MYBJ6YJ2OpMqmc66bNmBw4EWdV6xOXekxsOY1Rh7sNmthvanU6RiV0Yx6yl3Ylu8YiGJBTZRx4PLYhP7WKD3D1gcsJrTuNKA4h77re6BIJnzp1pDR0FlWnv4lRhwBkWluRo;4:Pv6B5lg1H1N/BUaFwQKfiXb+G7XGyYKKwXxp9PRgxkWhlBxN9qEtqmxKZjwN20a3CEWnwkasuWWAORgNwZXBzItpjUFk1VDlYSO2lEe5D7C8bbLDiXq2CTvJ1KfU+FK2bH9BkyEK0Q0fmqDwt1aAZBWKEOF6qFp5WoXROH8lCM+lU/Cn7/Pv1yxCDjlwI/Y7GjETMeqGxloGmDLzto8huYPIYvdLBu8ue5cWsSU0xNHSXV0wCz8SD25f6iXeYmiRAMGB0U2ztEninbAEXE8HQg==
X-Microsoft-Antispam-PRVS: <AM6PR04MB4293A3C276FF5DC567859DE3EE510@AM6PR04MB4293.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:AM6PR04MB4293;BCL:0;PCL:0;RULEID:;SRVR:AM6PR04MB4293;
X-Forefront-PRVS: 073966E86B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(366004)(376002)(136003)(346002)(396003)(39860400002)(199004)(189003)(2616005)(39060400002)(110136005)(54906003)(50466002)(86362001)(4326008)(966005)(305945005)(8676002)(48376002)(7416002)(8936002)(105586002)(81156014)(2906002)(81166006)(106356001)(51416003)(14444005)(486006)(53936002)(97736004)(52116002)(956004)(25786009)(6666003)(16586007)(478600001)(476003)(316002)(5660300001)(3846002)(6512007)(44832011)(36756003)(6116002)(6306002)(6486002)(26005)(6506007)(50226002)(186003)(16526019)(386003)(66066001)(7736002)(47776003)(68736007);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB4293;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM6PR04MB4293;23:4/XUeJdrt6z31MLIW7W4uKRxNNlWB8+r/mBIfbipv?=
 =?us-ascii?Q?dzIeun+H3fCmG7ZEkrxuVYyhq/nnHEwzM07S9p//KxPsmIIccMM77Sko1+kY?=
 =?us-ascii?Q?+ah9LG2BFlo2pvyYH1Ur2foHlkFejW5n2VPABWN1zpMxWt5r90+zDDNcAOTa?=
 =?us-ascii?Q?cWUAwW49hAVxzBUrilxJyWW1asDU6pxCenuQx5+vpRTX9f37WobSFQEht2Rh?=
 =?us-ascii?Q?uD9kwQewpFLNNSgn+afMY+inNtyACfIl8+BWinDATSTPyKxYhn1HZTzMYH9x?=
 =?us-ascii?Q?z2T3fvVg2KihYJXZX9XTot4IqsN+1iy37bKqGWKqR4uvvCwvB+p7PeTHGXdZ?=
 =?us-ascii?Q?CllnXd2yIRJgUGY5vMyI8xF2sAcH8qaunqEj26HIChYzUaeIZJN1LvhafIbG?=
 =?us-ascii?Q?5k79rEeMKEF/f+MI/0a7lUariaK3spaCd5d5aC1Fs6ud6pzGk/vZnneqWsqg?=
 =?us-ascii?Q?Atl2vBPmLpXVhkWs5Mrp3GAEMPHem9TuXWhOUbQegUK0PwGY7R1oZiPpnTYi?=
 =?us-ascii?Q?TKLJbW/ymKH03KjG0UQ+fwLBa9XMhWH6qAXddftgzJ4gvYt/zicWhpzXfG1k?=
 =?us-ascii?Q?pNZsc6em9y3Mccu4zjaqdjHzM/PEf//ZlxlH+SJ+FOO9EAbhN/t2utNtPPHb?=
 =?us-ascii?Q?mBvWdSIVvS57h8Qo/0ApKHmMfRkmiYtmRPQ0+3GjxTAGw4kBJX1UUTGqD/YH?=
 =?us-ascii?Q?Q+NyB60BdAfHJriA+vcnC24zQATN1J0V38AAXhxP5BDMUxRF/dGfkJWURezc?=
 =?us-ascii?Q?56W/XBruhanIOtMu4dB191T0lAnCVyS8X3yXe0UViZhs+DyJexUdrShXVq2y?=
 =?us-ascii?Q?8A8mGYpdiIEkh5UwmZh1uQTbRcZ9x/bBpgXz6eMZx/MBxZJc5beqlaQZp0N9?=
 =?us-ascii?Q?jK6J+CdKKqHRaQczuSHnidxvKyMCPhT80xg0jdzhno+QZs7hnuYApMAXDSIi?=
 =?us-ascii?Q?z6nhB+yUZ42cBWq+jVi3gzFdUtmckjJ1xFMnA6gaAvodqoiiKNJ0+tcvaNLw?=
 =?us-ascii?Q?B0VmzUw35IVaN0KdmTVTt3knxRcola50Lm2Nyot87Y774oIk+sPs4hW7qR2j?=
 =?us-ascii?Q?Pna4F62ZdD5McVXqRJTpWrEt203ylxhTShUu3Jtygx/jav5fQlhdELtAueH0?=
 =?us-ascii?Q?KnhoWZYCskc3Ga+jS5mpaz6xkTKi647V+kpFXo0daOlQZAjtVe3iCdrUAH24?=
 =?us-ascii?Q?KCc1E+GD/UeeT/BSqo9Lr3td2Q/ex2TrMEzez4xnqyzi6R/P1r6aXld9e+4D?=
 =?us-ascii?Q?7wLspI4RZ6IX76Zq7Pvl0GazgJaqilTpxk8xn3H?=
X-Microsoft-Antispam-Message-Info: hyTZ8By1otjFPMX03zk7oRrW1p2/wbiKZZ53/O+lpZNdTXv8cJxVNnk+xtGuTMNGYEaNYRS7K4V03VsNKjUWXZ47PTmEIq8WxYlY737kBMLx3vJA8kX2qzIsW6qB5QiY31kAZ+oNr3PyCjcEkqXNAD6QweF31BN6ZrS7frXhIUbyUE/jq/NXQ3HDBxDjEvQMeLOoTYWSiMrVuaj9ekZHEjK93vVkzB/RG2aBwxr16qyMfOVhvt+H9eCN71+S/1xcr+vDnOPfr8HqQguxlBkLLP6G7Xh8n/cyFABfxpYmUc86S2s79yOR7qiIVf0VL35J5mjaVo82v2LYa7VYYkrqjcrtpFDTAv7EL2Dy5JeIOWg=
X-Microsoft-Exchange-Diagnostics: 1;AM6PR04MB4293;6:AUFlQqiXU1OheF02zRCQp3WAXmKABBktHACs5TwIW/oH2tdx99MXDqa9hqJZXvL/TSmiEVrBnnzcx6ChW9XorqbpO9qBG16BLA3uo8Qyo1Wabltuhvwe/6Z9HQHTh0Ynhz0PzOuO1LdFsRVjBvhdNmQti0Nihzi4jKdtfAtU09qh6XuG1Csdt6WOSzVnGbSHddAwvE8AACVq7w4KvrmqeCI6zLeaBmHjASK4PTnTB2JiuHbXdfGq8HwPnnGJvJ5ABfOdOd0XT/+0TEQ5lQy20mc4+JrtDzqnd03somLpUIq1VwMJxJ9hq0sKbMoOl1P7DXZM3OKlnTkLYHxEG5TRB3NZVKOuT+2KgNmVyYkeeFrKxJJ8SmMv3dNXgCdeNIGYwQ0icttmipEnLXlca9yPGNYYEWkBxXBPG+Qoah4SvTLKsPyrt0HrFsBdAmV4Qz7g5c/bNVJCy1AfH77TjZ5Eeg==;5:vbPagUyHuDOFrc+tOCiB2EaSq7LSo9d2X6Kj7OPu7YVbA/6bsHGcosUTYQ/g8bWZpnpu/LEhNA9EV/BPULZm810fwHxP6T/bpiwQF801FzgIlSYFhEedOWdN02ikHo7lOJ+GMRhiDOdFQWW4ch3S3TdeGMAJuZ9xItY64xezz2Q=;24:KaQUOkYlzERB3RGrP3qZfk0eNUbeXq6q5c8a1Rx1GgzdR38LMHdgnySZ9GySX4uzU3BxCssyd8JCtk4MSl3MM2cmhIGfbzUXKr+a/aX6nsI=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM6PR04MB4293;7:MVIsmzNFQV+I1VnxBxk5K2oS15DDl2Niy4pbMTKVNvd+ZfBzfYIR04BZ82yGkoFZ8kKzO11i59JXIGjYYRiwIJ05ATIRUoROYgKMraLpEnSWs3U7pxvxQ5XoLdxTayJNo6ppjdxsXHYUDZp3hAhlt6+4CpcZxylal/jAQE71TSHRStD0UCk/wkTbkFxltIEUMn/gK2iCGqGU3gXxilDJD4iA7G6+tEgPicC1756rHlKOVEp7RDThXG6o9j03hFIm
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2018 12:47:58.1085
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dc06def-1631-42e7-19b7-08d5ee3f05b5
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4293
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v1:
 * Indentation fixes
 * Use imx6_pcie_establish_link instead of imx6_pcie_wait_for_link
 * Move imx6_pcie_ltssm_disable to suspend
 * Make imx6_pcie_clk_disable a separate function
 * Revert PCI irq mapping (also useful separately)

Link to v1: https://lkml.org/lkml/2018/5/29/1042

Leonard Crestez (3):
  Revert "ARM: dts: imx7d: Invert legacy PCI irq mapping"
  reset: imx7: Fix always writing bits as 0
  PCI: imx: Initial imx7d pm support

 arch/arm/boot/dts/imx7d.dtsi          |  8 +--
 drivers/pci/controller/dwc/pci-imx6.c | 95 +++++++++++++++++++++++++--
 drivers/reset/reset-imx7.c            |  2 +-
 3 files changed, 95 insertions(+), 10 deletions(-)

-- 
2.17.1

