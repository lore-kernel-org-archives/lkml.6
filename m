Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C35BEC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 20:13:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A76B20700
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 20:13:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="KCxuoRBf";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="WxhrSeUo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727266AbfBVUNs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 15:13:48 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:58008 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725900AbfBVUNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 15:13:47 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1MKBoZm012444;
        Fri, 22 Feb 2019 12:13:18 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=date : from : to :
 subject : message-id : mime-version : content-type; s=proofpoint;
 bh=e+KrvsSYuBqKPA7cIDS0Y+18LLEf+pLYpx7Qrezy8is=;
 b=KCxuoRBfrdcNBZXAzyUPkZvT+4DwiZUMcnkR9C7MyBB6gEh+cqmNTpNS0fGFF5dAze7+
 R2SuRKX3hFnxjEGHvJBiz8SHQ+Z6vzPWu6ft/OzFwvjLAbAOZtUvHShQLvI90Y39L6bW
 U+SbVckkzRhMc2M9WL9CBCojCpSPnLip0EoQ+WkNAUW1UVWBSj3NBHHypfc43AEltlbe
 Wo06hriAV3f6tmX8XZayWcwDAEXRlTQsAq624AG61+VRhdfqXHhvVe356xV8qcn/G/bH
 PLdCrxfzoymdYS5eD0fD8u3RSq2XWQi2eWaN/47WIPxLMqlMQbO+RrQ/LEQUAWstzBRb nA== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pthombar@cadence.com
Received: from nam03-co1-obe.outbound.protection.outlook.com (mail-co1nam03lp2055.outbound.protection.outlook.com [104.47.40.55])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2qsqnjqxhr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 22 Feb 2019 12:13:17 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e+KrvsSYuBqKPA7cIDS0Y+18LLEf+pLYpx7Qrezy8is=;
 b=WxhrSeUoZOWHcoj7HtGZp565SDcbCv7/XKQ1lZHklcjKdrz5ZJX/hKvlewLEOE8/QZOwSI3xdrTLkqTikN/aygfQNzcH8Nzf769DS2OJ3osB+vQKnrwn5YsPzIkiFAxUM6kvxVFaUlUu+2b3bo/fwoJCkDUSw+yqtb9kXRXQVNs=
Received: from BYAPR07CA0092.namprd07.prod.outlook.com (2603:10b6:a03:12b::33)
 by DM5PR07MB3098.namprd07.prod.outlook.com (2603:10b6:3:de::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.19; Fri, 22 Feb 2019 20:13:15 +0000
Received: from DM3NAM05FT059.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e51::200) by BYAPR07CA0092.outlook.office365.com
 (2603:10b6:a03:12b::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1622.16 via Frontend
 Transport; Fri, 22 Feb 2019 20:13:14 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 199.43.4.28 as permitted sender)
Received: from rmmaillnx1.cadence.com (199.43.4.28) by
 DM3NAM05FT059.mail.protection.outlook.com (10.152.98.176) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1665.5 via Frontend Transport; Fri, 22 Feb 2019 20:13:13 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id x1MKDACM023883
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Fri, 22 Feb 2019 15:13:12 -0500
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Fri, 22 Feb 2019 21:13:09 +0100
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Fri, 22 Feb 2019 21:13:09 +0100
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id x1MKD9hq027384;
        Fri, 22 Feb 2019 20:13:09 GMT
Received: (from pthombar@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id x1MKD9HR027368;
        Fri, 22 Feb 2019 20:13:09 GMT
Date:   Fri, 22 Feb 2019 20:13:09 +0000
From:   Parshuram Thombare <pthombar@cadence.com>
To:     <nicolas.ferre@microchip.com>, <davem@davemloft.net>,
        <netdev@vger.kernel.org>, <andrew@lunn.ch>, <f.fainelli@gmail.com>,
        <hkallweit1@gmail.com>, <linux-kernel@vger.kernel.org>,
        <rafalc@cadence.com>, <piotrs@cadence.com>, <jank@cadence.com>,
        <pthombar@cadence.com>
Subject: [PATCH 3/3] net: ethernet: add support for high speed mac and
 usxgmii pcs
Message-ID: <20190222201309.GA23470@lvlogina.cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-12-10)
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:199.43.4.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(396003)(136003)(39860400002)(346002)(2980300002)(199004)(189003)(36092001)(2201001)(486006)(426003)(23726003)(126002)(476003)(46406003)(2906002)(106466001)(478600001)(105596002)(87636003)(336012)(68736007)(33656002)(26826003)(16586007)(42186006)(26005)(110136005)(316002)(186003)(86362001)(53936002)(58126008)(69596002)(305945005)(81156014)(97756001)(97736004)(81166006)(50466002)(8676002)(8936002)(5660300002)(356004)(47776003)(14444005)(1076003)(18370500001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR07MB3098;H:rmmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:InfoDomainNonexistent;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 827e669f-7c7f-48ee-f1de-08d699022d09
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060);SRVR:DM5PR07MB3098;
X-MS-TrafficTypeDiagnostic: DM5PR07MB3098:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3098;20:iVdrvg/YpYyiRjquaQfDf1hb/1Uw9I9nsPRLpJ7YEiOUqr8a2sncWMkKu6ackG47gP057rRIViAQu9GOo/f09MJqUub1UDtpb54AHvb2rCX9uYeomynsN+eBC94I7WqYCqFFmT3k0NTa5mfV1o1wfl4RbC/aH1bEQg6uwPfHS/BH7JbR2LlrtJDKgqB0zbFUWNWLYYYoUDsm3cY2NAkJRUwxqZeyyZvYWNU6vEY2YiMxJ+wBwIfZeZjed8dcXaU+zHbL1XBtOhvK2ENkKP8OAqcCoTZVJuZ74au3q9Fl8yx5z1ALT4CeUML0Y1Hn7sMyB4FMME5obJhjQF+8sF/LOyZ5qQX+NGOIKmA716xWczIfjFMsrpZFCvQY/LXWR5ByCEBsk1V8+NPGMhyRYy7sTD0/s3ZAlZbo/ItN+4SRNRTFujeA2p1kiMY5GBIVINlm+yKfO8AadlrcEeF9v0IJ7uBz3/caVAgBG4ImNGqaB8P3mSmmerrteTglq8NrMJzV
X-Microsoft-Antispam-PRVS: <DM5PR07MB3098D60E709ADBD0DFFF0A1BC17F0@DM5PR07MB3098.namprd07.prod.outlook.com>
X-Forefront-PRVS: 09565527D6
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR07MB3098;23:fn7/VpKiim5qRb0vngTk8m1kBUta4Nk9uYiwnzQVl?=
 =?us-ascii?Q?wAyO5EIsZ+ot78+OiZVkul8ejxt3T9DY3gAreUKpQWlmzKLHF/Yuz3Dc0ZDi?=
 =?us-ascii?Q?Lw9/ya0VXB/FymCwM+cZ4LHKFk0y9xtnquwvGh5rkBiBuLjikd/RCygzIgbt?=
 =?us-ascii?Q?1+kOKvVBvY1SU5UDRQFshlI3k5mfzoM9BBnIFp9F4wj8OkvSDcPpPfbZ6nZW?=
 =?us-ascii?Q?Mu1Ocud250xigs8aQymSqmVlVR/PTnaKxKCIMPs8CIgRNUNEcg7lj5+r896d?=
 =?us-ascii?Q?V91en57evwV31viM2G2Xw2tVQciH7Al59iE6DucF1KEI9nqu16Gzmyk8S6WY?=
 =?us-ascii?Q?9AKaNdG13slOnQ+97TyM9niQV3MROSkg88VImhRupyVJs7r8Ke9Lw2W0LrZD?=
 =?us-ascii?Q?hbnBM3nXzFnMLQrojG/9wHc5c1032uthAFMFwJtXPB3ByZ+AQazHP7526Ec2?=
 =?us-ascii?Q?IfIDFuk0AnpVPw8Rs11SXNoDDhR0ZDLniB60Xka/i1KWie1u09T9T5X9JJZp?=
 =?us-ascii?Q?o+xBHAfKZ/AqvAKKFNGl9gv2dBgqcSOQ7M9hg/idXW3VqpiCBccmBfiAEHxt?=
 =?us-ascii?Q?Is3YeO/9EISYSXb+rv1Ez/NsvZCeZKAUtbHD7L6reQLn/utiRKFv84SOA2gm?=
 =?us-ascii?Q?xmo2vCWC8tbiO1/m5qe56attezTjpcItcFNLWxCQuCEQzMW0Dr4rCvR4qLYm?=
 =?us-ascii?Q?Itt0X/BAxoTmauCi+El4VW7iW4IrVmB1bpcbcq2AxjVN+LmAj2GOwpF+O3/Q?=
 =?us-ascii?Q?i6jm94xlss/4j3WFMeA+82WcbhEIhdmVC0fSe8R8DRhIZ+5BJFvmu6H4cltF?=
 =?us-ascii?Q?cUPhz75qIiWTmp8Pt8guvD1Fui2x6nsOVlFvwFQQw2MgyHgOn6MPvf02hoU5?=
 =?us-ascii?Q?l9DXbiPjf6gqgmq0kRKBTjYjP2Fj+gqzuW0naIQmUBd/rX4g6BBbPhwIQ/+y?=
 =?us-ascii?Q?DfzngfmHBNWEZWUOiCmYWNBthMQdicBxdE9dDogZl5HZEE+C+9kVrMYh5Ppo?=
 =?us-ascii?Q?MzJoQHnvXlV599s9HIJiq1OMiNsi2z4BOHJIIBlw3K8UGw70Oh7pU2fCl1zu?=
 =?us-ascii?Q?dU9Hypuqs6MEpSXxQkRSUpfyiGH2fxEEQf9fqz2i1S3+vMNyfuYssPamCw9N?=
 =?us-ascii?Q?XVk3oFeiqG3B0XuOQazgfg4f0ZhnKnO?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: XJHtTr86LONU5stceZshKYcS13vbHpXE6NTwqt3Mh1ivqZ4iC+5QrDrVjXvEyCbLclee1Rc9KxpFFhqKOrUPOmkoN9/0LQCYW5sND0Ihs20M4jKPd6qZXQLFVxeuvnURUErMnyQTioeLylEfaFDbng07WYGTAe0NgftuNex/Fp6RwW/P2amvq3/Iizw8dHpFSstZuhOamPlKsu9Sq8hxXzv+2ZK5vZEmXTJqqreGpGI7hgnxm417tb777vCp2MxJOS1Iq1A2s4fWhI8i13spBDBWQjkZSyEDPaEWPis8Da/JrKVeF2VjVlwml7ehsOgn+Q1rrvt1AV5P5HETn86xk2XgrwMT8B9M/YNMj+ir1OTCCcygSWozmbLqDu3kJ6JzESksKT4KnvcL1cSx8fx/OsQ/+cMRA9BCEZaZVQfu0kI=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3098;20:irKnJ36/0u6PjhA3a2klCJWhIcFdFXe0Gen6VYIXuKHQEncBPLTXKFYKaLsSTblmQl0z5wVkhmAd5Lr2uW/1UoIq64bVIv7syTiHVAMQ4F+IeupGGTOxgod64OFQ1odkdnEjRah35VaxobU8uVLTaIXAHMUR5LP1LQrGCtObnbq+AYSxijFCP0P3sIgYUwKH+be6f3qJZ9VzSP3GcBcxgkP/ZWY+dZKUS14ZtYbaB0Wm9TvvJlKS+o006BjRpnGu
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2019 20:13:13.9821
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 827e669f-7c7f-48ee-f1de-08d699022d09
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.28];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR07MB3098
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:_spf.salesforce.com include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-22_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902220139
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch add support for (10G) high speed mac, usxgmii pcs
and usxgmii interface in Cadence ethernet controller driver.

Signed-off-by: Parshuram Thombare <pthombar@cadence.com>
---
 drivers/net/ethernet/cadence/macb.h      |   33 +++++++++
 drivers/net/ethernet/cadence/macb_main.c |  110 ++++++++++++++++++++++++++++--
 include/linux/phy.h                      |    3 +
 3 files changed, 140 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
index 59c23e0..34df014 100644
--- a/drivers/net/ethernet/cadence/macb.h
+++ b/drivers/net/ethernet/cadence/macb.h
@@ -84,6 +84,7 @@
 #define GEM_USRIO		0x000c /* User IO */
 #define GEM_DMACFG		0x0010 /* DMA Configuration */
 #define GEM_JML			0x0048 /* Jumbo Max Length */
+#define GEM_HS_MAC_CONFIG	0x0050 /* GEM high speed config */
 #define GEM_HRB			0x0080 /* Hash Bottom */
 #define GEM_HRT			0x0084 /* Hash Top */
 #define GEM_SA1B		0x0088 /* Specific1 Bottom */
@@ -168,6 +169,9 @@
 #define GEM_DCFG7		0x0298 /* Design Config 7 */
 #define GEM_DCFG8		0x029C /* Design Config 8 */
 #define GEM_DCFG10		0x02A4 /* Design Config 10 */
+#define GEM_DCFG12		0x02AC /* Design Config 12 */
+#define GEM_USX_CONTROL		0x0A80 /* USXGMII control register */
+#define GEM_USX_STATUS		0x0A88 /* USXGMII status register */
 
 #define GEM_TXBDCTRL	0x04cc /* TX Buffer Descriptor control register */
 #define GEM_RXBDCTRL	0x04d0 /* RX Buffer Descriptor control register */
@@ -275,6 +279,8 @@
 #define MACB_IRXFCS_SIZE	1
 
 /* GEM specific NCR bitfields. */
+#define GEM_ENABLE_HS_MAC_OFFSET	31
+#define GEM_ENABLE_HS_MAC_SIZE		1
 #define GEM_TWO_PT_FIVE_GIG_OFFSET	29
 #define GEM_TWO_PT_FIVE_GIG_SIZE	1
 
@@ -463,6 +469,10 @@
 #define MACB_REV_OFFSET				0
 #define MACB_REV_SIZE				16
 
+/* Bitfield in HS_MAC_CONFIG */
+#define GEM_HS_MAC_SPEED_OFFSET			0
+#define GEM_HS_MAC_SPEED_SIZE			3
+
 /* Bitfields in DCFG1. */
 #define GEM_IRQCOR_OFFSET			23
 #define GEM_IRQCOR_SIZE				1
@@ -504,6 +514,28 @@
 #define GEM_RXBD_RDBUFF_OFFSET			8
 #define GEM_RXBD_RDBUFF_SIZE			4
 
+/* Bitfields in DCFG12. */
+#define GEM_HIGH_SPEED_OFFSET			26
+#define GEM_HIGH_SPEED_SIZE			1
+
+/* Bitfields in USX_CONTROL. */
+#define GEM_USX_CTRL_SPEED_OFFSET		14
+#define GEM_USX_CTRL_SPEED_SIZE			3
+#define GEM_SERDES_RATE_OFFSET			12
+#define GEM_SERDES_RATE_SIZE			2
+#define GEM_TX_EN_OFFSET			1
+#define GEM_TX_EN_SIZE				1
+#define GEM_SIGNAL_OK_OFFSET			0
+#define GEM_SIGNAL_OK_SIZE			1
+
+/* Bitfields in USX_STATUS. */
+#define GEM_USX_TX_FAULT_OFFSET			28
+#define GEM_USX_TX_FAULT_SIZE			1
+#define GEM_USX_RX_FAULT_OFFSET			27
+#define GEM_USX_RX_FAULT_SIZE			1
+#define GEM_USX_BLOCK_LOCK_OFFSET		0
+#define GEM_USX_BLOCK_LOCK_SIZE			1
+
 /* Bitfields in TISUBN */
 #define GEM_SUBNSINCR_OFFSET			0
 #define GEM_SUBNSINCR_SIZE			16
@@ -664,6 +696,7 @@
 #define MACB_CAPS_MACB_IS_GEM			0x80000000
 #define MACB_CAPS_PCS				0x01000000
 #define MACB_CAPS_TWO_PT_FIVE_GIG_SPEED		0x02000000
+#define MACB_CAPS_HIGH_SPEED			0x04000000
 
 #define MACB_GEM7010_IDNUM			0x009
 #define MACB_GEM7014_IDNUM			0x107
diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 2494abf..0e0acf9 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -79,6 +79,21 @@
  */
 #define MACB_HALT_TIMEOUT	1230
 
+enum {
+	HS_MAC_SPEED_100M,
+	HS_MAC_SPEED_1000M,
+	HS_MAC_SPEED_2500M,
+	HS_MAC_SPEED_5000M,
+	HS_MAC_SPEED_10000M,
+	HS_MAC_SPEED_25000M,
+};
+
+enum {
+	MACB_SERDES_RATE_5_PT_15625Gbps,
+	MACB_SERDES_RATE_10_PT_3125Gbps,
+	MACB_SERDES_RATE_25_PT_78125Gbps,
+};
+
 /* DMA buffer descriptor might be different size
  * depends on hardware configuration:
  *
@@ -443,6 +458,20 @@ static void macb_set_tx_clk(struct clk *clk, int speed,
 		default:
 		return;
 		}
+	} else if (interface == PHY_INTERFACE_MODE_USXGMII) {
+		struct macb *bp = netdev_priv(dev);
+		u32 serdes_rate = GEM_BFEXT(SERDES_RATE,
+					    gem_readl(bp, USX_CONTROL));
+		switch (serdes_rate) {
+		case MACB_SERDES_RATE_5_PT_15625Gbps:
+		rate = 78125000;
+		break;
+		case MACB_SERDES_RATE_10_PT_3125Gbps:
+		rate = 156250000;
+		break;
+		default:
+		return;
+		}
 	} else {
 		return;
 	}
@@ -475,7 +504,7 @@ static void macb_handle_link_change(struct net_device *dev)
 
 	if (phydev->link && (bp->speed != phydev->speed ||
 			     bp->duplex != phydev->duplex)) {
-		u32 reg;
+		u32 reg, speed;
 
 		reg = macb_readl(bp, NCFGR);
 		reg &= ~(MACB_BIT(SPD) | MACB_BIT(FD));
@@ -485,7 +514,53 @@ static void macb_handle_link_change(struct net_device *dev)
 			reg |= MACB_BIT(FD);
 		macb_or_gem_writel(bp, NCFGR, reg);
 
-		if (bp->phy_interface == PHY_INTERFACE_MODE_SGMII &&
+		if ((bp->phy_interface == PHY_INTERFACE_MODE_USXGMII ||
+		     bp->phy_interface == PHY_INTERFACE_MODE_XGMII) &&
+			phydev->speed >= SPEED_100) {
+			gem_writel(bp, NCR, gem_readl(bp, NCR) |
+					GEM_BIT(ENABLE_HS_MAC));
+			if (bp->phy_interface == PHY_INTERFACE_MODE_USXGMII) {
+				/* Setup USXGMII PCS */
+				reg = gem_readl(bp, USX_CONTROL);
+				reg = GEM_BFINS(SERDES_RATE,
+						MACB_SERDES_RATE_5_PT_15625Gbps,
+						reg);
+				gem_writel(bp, USX_CONTROL, reg |
+						GEM_BIT(TX_EN) |
+						GEM_BIT(SIGNAL_OK));
+				while (!GEM_BFEXT(USX_BLOCK_LOCK,
+						  gem_readl(bp, USX_STATUS)))
+					cpu_relax();
+			}
+			switch (phydev->speed) {
+			case SPEED_10000:
+			speed = HS_MAC_SPEED_10000M;
+			break;
+
+			case SPEED_5000:
+			speed = HS_MAC_SPEED_5000M;
+			break;
+
+			case SPEED_2500:
+			speed = HS_MAC_SPEED_2500M;
+			break;
+
+			case SPEED_1000:
+			speed = HS_MAC_SPEED_1000M;
+			break;
+
+			default:
+			case SPEED_100:
+			speed = HS_MAC_SPEED_100M;
+			break;
+			}
+			gem_writel(bp, HS_MAC_CONFIG,
+				   GEM_BFINS(HS_MAC_SPEED, speed,
+					     gem_readl(bp, HS_MAC_CONFIG)));
+			gem_writel(bp, USX_CONTROL,
+				   GEM_BFINS(USX_CTRL_SPEED, speed,
+					     gem_readl(bp, USX_CONTROL)));
+		} else if (bp->phy_interface == PHY_INTERFACE_MODE_SGMII &&
 		    (phydev->speed == SPEED_1000 ||
 		     phydev->speed == SPEED_2500)) {
 			if (bp->caps & MACB_CAPS_TWO_PT_FIVE_GIG_SPEED) {
@@ -627,10 +702,15 @@ static int macb_mii_probe(struct net_device *dev)
 
 	/* mask with MAC supported features */
 	if (macb_is_gem(bp)) {
-		linkmode_copy(phydev->supported, PHY_GBIT_FEATURES);
-		if (bp->caps & MACB_CAPS_TWO_PT_FIVE_GIG_SPEED)
-			linkmode_set_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT,
-					 phydev->supported);
+		if (bp->caps & MACB_CAPS_HIGH_SPEED) {
+			linkmode_copy(phydev->supported, PHY_10GBIT_FEATURES);
+		} else {
+			u32 bitmask = ETHTOOL_LINK_MODE_2500baseT_Full_BIT;
+
+			linkmode_copy(phydev->supported, PHY_GBIT_FEATURES);
+			if (bp->caps & MACB_CAPS_TWO_PT_FIVE_GIG_SPEED)
+				linkmode_set_bit(bitmask, phydev->supported);
+		}
 	} else {
 		linkmode_copy(phydev->supported, PHY_BASIC_FEATURES);
 	}
@@ -3344,6 +3424,9 @@ static void macb_configure_caps(struct macb *bp,
 			bp->caps |= MACB_CAPS_ISR_CLEAR_ON_WRITE;
 		if (GEM_BFEXT(NO_PCS, dcfg) == 0)
 			bp->caps |= MACB_CAPS_PCS;
+		dcfg = gem_readl(bp, DCFG12);
+		if (GEM_BFEXT(HIGH_SPEED, dcfg) == 1)
+			bp->caps |= MACB_CAPS_HIGH_SPEED;
 		switch (MACB_BFEXT(IDNUM, macb_readl(bp, MID))) {
 		case MACB_GEM7016_IDNUM:
 		case MACB_GEM7017_IDNUM:
@@ -4215,6 +4298,21 @@ static int macb_probe(struct platform_device *pdev)
 			bp->phy_interface = PHY_INTERFACE_MODE_MII;
 	} else {
 		switch (err) {
+		case PHY_INTERFACE_MODE_USXGMII:
+		if ((bp->caps & MACB_CAPS_HIGH_SPEED) &&
+		    (bp->caps & MACB_CAPS_PCS)) {
+			bp->phy_interface = PHY_INTERFACE_MODE_USXGMII;
+			break;
+		}
+		/* Fallthrough */
+
+		case PHY_INTERFACE_MODE_XGMII:
+		if (bp->caps & MACB_CAPS_HIGH_SPEED) {
+			bp->phy_interface = PHY_INTERFACE_MODE_XGMII;
+			break;
+		}
+		/* Fallthrough */
+
 		case PHY_INTERFACE_MODE_SGMII:
 		if (bp->caps & MACB_CAPS_PCS) {
 			bp->phy_interface = PHY_INTERFACE_MODE_SGMII;
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 8e9fc57..b627e30 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -94,6 +94,7 @@
 	PHY_INTERFACE_MODE_RTBI,
 	PHY_INTERFACE_MODE_SMII,
 	PHY_INTERFACE_MODE_XGMII,
+	PHY_INTERFACE_MODE_USXGMII,
 	PHY_INTERFACE_MODE_MOCA,
 	PHY_INTERFACE_MODE_QSGMII,
 	PHY_INTERFACE_MODE_TRGMII,
@@ -162,6 +163,8 @@ unsigned int phy_supported_speeds(struct phy_device *phy,
 		return "smii";
 	case PHY_INTERFACE_MODE_XGMII:
 		return "xgmii";
+	case PHY_INTERFACE_MODE_USXGMII:
+		return "usxgmii";
 	case PHY_INTERFACE_MODE_MOCA:
 		return "moca";
 	case PHY_INTERFACE_MODE_QSGMII:
-- 
1.7.1

