Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6A0AC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 19:47:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E93421916
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 19:47:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="MUqS8xQO";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="nHcE7Fo9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439820AbfBNTrO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 14:47:14 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:57400 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2394507AbfBNTq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 14:46:26 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1EJgrWe020684;
        Thu, 14 Feb 2019 11:46:12 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=9sYRTpxdlVHnn5/oHJPtFelTxxi3AU7r4B61wajNYMM=;
 b=MUqS8xQOtE3RurzakL9l9FqFkWKS2tYEthytxU8IDoo0Na4yuMusBfevbhhIxDMJiWWX
 d/gppyqJlepTNZsaudS+lw/N2gX/hsmrYSDAoHPaTpAhMTIMRmpMgw9KoAeg18TBBuQN
 1SWWUPgoYEtKeCIgQcEwG9xg9Yk2AJj7+++Gw7icBm2Lf2fSge2RaJ23uW4RS2UIOp+v
 wI2fVpgVGZrGJBnrUMigNSlpsM6ZUCl0hpiXVWUH6eLmLgvkl4pM8OSwYVfkou1ZIy91
 4Tv1LrCAyFK//x75hAgM03zd5yO97w2Gf6bBkQhq8ZG6Bs3+JmyIcX6wltFVuOiibhnB aw== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pawell@cadence.com
Received: from nam05-co1-obe.outbound.protection.outlook.com (mail-co1nam05lp2050.outbound.protection.outlook.com [104.47.48.50])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2qmt3v4vpp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 14 Feb 2019 11:46:12 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9sYRTpxdlVHnn5/oHJPtFelTxxi3AU7r4B61wajNYMM=;
 b=nHcE7Fo9ptdVVSp737dH7fiSR7lS8Ox2JdPgSf/eMqrLkxauBiyerhy85F4pUQVyAI3uDcQwprA+TSYM/MRBv5yZm40LNxY/7anx7Kpp5Zoij13WKD3d38ah6Cb6bVnqAUwTFTR2oe1DPgOzdmA+BsFXprmIhpajl+T+HJiWxgo=
Received: from DM5PR07CA0027.namprd07.prod.outlook.com (2603:10b6:3:16::13) by
 DM3PR07MB2249.namprd07.prod.outlook.com (2a01:111:e400:c460::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1622.18; Thu, 14 Feb
 2019 19:46:08 +0000
Received: from DM3NAM05FT025.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e51::203) by DM5PR07CA0027.outlook.office365.com
 (2603:10b6:3:16::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1622.16 via Frontend
 Transport; Thu, 14 Feb 2019 19:46:08 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx1.cadence.com (158.140.1.28) by
 DM3NAM05FT025.mail.protection.outlook.com (10.152.98.135) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1580.2 via Frontend Transport; Thu, 14 Feb 2019 19:46:07 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id x1EJk2cU012765
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 14 Feb 2019 11:46:06 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Thu, 14 Feb 2019 20:46:01 +0100
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Thu, 14 Feb 2019 20:46:01 +0100
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id x1EJk2pi031448;
        Thu, 14 Feb 2019 19:46:02 GMT
Received: (from pawell@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id x1EJk2cl031447;
        Thu, 14 Feb 2019 19:46:02 GMT
From:   Pawel Laszczak <pawell@cadence.com>
To:     <devicetree@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <felipe.balbi@linux.intel.com>,
        <mark.rutland@arm.com>, <linux-usb@vger.kernel.org>,
        <hdegoede@redhat.com>, <heikki.krogerus@linux.intel.com>,
        <andy.shevchenko@gmail.com>, <robh+dt@kernel.org>, <rogerq@ti.com>,
        <linux-kernel@vger.kernel.org>, <jbergsagel@ti.com>,
        <nsekhar@ti.com>, <nm@ti.com>, <sureshp@cadence.com>,
        <peter.chen@nxp.com>, <kurahul@cadence.com>,
        Pawel Laszczak <pawell@cadence.com>
Subject: [PATCH v4 4/6] usb:common Simplify usb_decode_get_set_descriptor function.
Date:   Thu, 14 Feb 2019 19:45:12 +0000
Message-ID: <1550173514-23573-5-git-send-email-pawell@cadence.com>
X-Mailer: git-send-email 1.7.11.2
In-Reply-To: <1550173514-23573-1-git-send-email-pawell@cadence.com>
References: <1550173514-23573-1-git-send-email-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(376002)(136003)(396003)(39860400002)(2980300002)(36092001)(199004)(189003)(106466001)(51416003)(76176011)(107886003)(2351001)(6916009)(336012)(4720700003)(126002)(476003)(426003)(446003)(11346002)(2616005)(486006)(4326008)(105596002)(2906002)(36756003)(186003)(50226002)(54906003)(48376002)(26005)(26826003)(7416002)(6666004)(356004)(8676002)(478600001)(86362001)(246002)(42186006)(7636002)(8936002)(16586007)(47776003)(50466002)(316002)(305945005)(87636003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM3PR07MB2249;H:sjmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;DM3NAM05FT025;1:ETpdKaZ3hHwkSsdt76CgltpK2tKzm5kU6iTUNk2v1cktAnW+TdFozVxij5F1Tc/Ycx4omX8EaytRQjqg4RJ5X0sQanD45pCh2reT29HERU0a45ekHJJaB2joE1i9snWZlQPOCQ29waZe70Ik81374A29mlcwcszqWNOqL+OjLsE=
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: daceec87-0815-409e-f8c1-08d692b51080
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060);SRVR:DM3PR07MB2249;
X-MS-TrafficTypeDiagnostic: DM3PR07MB2249:
X-Microsoft-Exchange-Diagnostics: 1;DM3PR07MB2249;20:QRxARZtkQMAwO429LFGS0L+5SmA9tcs9rKxc6J+nOiJ8zxqrsC7+g66BXHczK76GtnoTwvfwqF0t8Xr2ie5/pmRCzvtALHKEMC+Kiy7aUPlePVK2DLApfXSUi8kG2RBm65j+26u4vkE7r1k1LsKScmsq4zGTR1GbNuqqyf9KnKnVIyUbrcAlAgit/YH3GRLwk+FdEUgOHzXIkK7FmM6zzDjzzkKj/C3evWNEChuQvJFx3+9ho4ScSMfczcdQDaPfXSpB3HNbEgCIUegR3gpDafMxpmUMD+vle2g/RXj3CDns9fINggB0Nl+cBDL6HhW0rpMuUqeb8G5sugAej5rw8J53Qa7IgfmRvbDd8fghX22sIKNq43dOvMdbxO/5F/u++6JpoWi/V8qeDCUBsASLLTDuc+WKdZ71s+ihJzyhTKIYBBfcbzaDHPBoOMIQbq28DcwhsHPAkB0+LrizrxS/n1ADxbd3ID0V//wuDhg+8O/I/wTd8lSC0Yw7boxrOoPi
X-Microsoft-Antispam-PRVS: <DM3PR07MB2249277FF9E0F64C6C077B02DD670@DM3PR07MB2249.namprd07.prod.outlook.com>
X-Forefront-PRVS: 09480768F8
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM3PR07MB2249;23:lEApvaH1fRb8DZ5cJ5gruvR7BbfpwbMBHGyOvODKx?=
 =?us-ascii?Q?taQJ7lFWcwROaah2NSY+p7SoEXjmsXMdjAqrt5tcyqHrL6zgEgzcz0jAExbh?=
 =?us-ascii?Q?WbJh64DWP0FF2KmM7KYgjBqMDQGkQtIZ/1GxjvmlgcODduJa/pUETCr0QyuP?=
 =?us-ascii?Q?eccuU2bwBLN7NkF9nJtUHZfxMWxceZQwOcpdeMGzIO2DAlRi3/SNcrsX5lG+?=
 =?us-ascii?Q?ZzaXSBBN7/aNXLDrbviy/dkBFJM/kbFWe+DeMcf6lW+hy3/H+k2mv2vFKFG9?=
 =?us-ascii?Q?ugVXcuFD1wVPo/2XQ+p89rJm70OHTfH07wgs/vvGivnKLJqJSQ2J9HZuKwGt?=
 =?us-ascii?Q?jnrs0j73v3gJLkq73i837OJoPdq0/nem4nfVBYhJf2xBnv9sRi86d4Ldx9mD?=
 =?us-ascii?Q?YNSvm6HX7nOUdT6O6POUlRbXl8Cux/AIT2pbCovQIjhaRq44YBL+DIAnLiB4?=
 =?us-ascii?Q?Y6PtYxixmq1lALe/FlAT0MicTAdroeNfL/YMAUqgFV7acIqX+YRPl57fS13k?=
 =?us-ascii?Q?ZNe9Ln1HQ+RmWTpoqb1oW6oujo8UQOvDkRZrs4l/Jle6x2yd5zYZWMdXoKu9?=
 =?us-ascii?Q?jlSJYcb4ORQPrM/ZbyHDGdnYEXm1FdxPXQZW/w8H8yJzs9GSy3P8xS1JkQeL?=
 =?us-ascii?Q?tLrFeR39ulBfkhFW4hwDghks0yhPZjexZ7fPFR+Djx9sDCnKf3ru1Cv+TuYy?=
 =?us-ascii?Q?Xwy8WTZA8j3iu0r9DA4WNUBf+TPKbcUOeUNJ1SYKSU1Lj42wE8CFkNYfrZGH?=
 =?us-ascii?Q?Dsntr8X1/zjR6aS2gdRaNf0vDU4ZSN4qo/bvATsmmQcnj7I6E4swrdXBh68X?=
 =?us-ascii?Q?uIsqJb4QGMFut2R2uF4QR6wpM+EfCahT/hdi2hJP8bVpq0C95zpqGRkjxpwz?=
 =?us-ascii?Q?OJYhVoxDSAF69PwlYduol/BgCVXBehu1QSlw2DQE48/Hp4S+nMul8nOwJn8M?=
 =?us-ascii?Q?6gC+45YJipG5N0PTPoPlnqa21reoRpAEjJ1KwWrZ/iQO45d23QcZVkfigWcM?=
 =?us-ascii?Q?T6SP/opjrihgqycsNlajLvRGJwxjwPBUA+J29MF6oKTfx4Jsb7VMH6eG7d9u?=
 =?us-ascii?Q?5MjKYZzcA2IkOe7kyf4xQN5IPZBTNe33nkR9boTr7UMUJ6ZDw5kb5VYmS4pc?=
 =?us-ascii?Q?WjsYnsdkv8=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: EI55k6F32B/x6O8Bf3Cvq7xyGd0WQUbbbd4sJ8AC6htDrrv/wUDiBxXuguSFSMM3VTzn5cWpwuujHRR0vHS9C2VtXPWamoW/AbV9IQ3ZrChaDNFZgba05bEpZ+rsPXdHcmcV5ZRuzFkkDy+rhmoQmKtvvkehRVvgHJ4kB4KZZSJQTgWmQ2P20tp5hqSsspwOXJ6B7wFJoEaZFyQCSpOvrS9+DfQhiRZNBJbqZ5lsYo5uCadTn5fwyfcSRSbsxnojCkit5sKTdvxhy7ZJAOIdxXQvv3KLdC/GoAtfQuV83dTM2kTtI2uuZrWYEksoRY5k13LgU5tUyS4+W7GN+qvFumXcVnGIjVq7Q7LvW8xdEaIl89tvDbmFfTJEKtQtR/yfjz8/a/xsV36OC2m7rI5VSBU4O+hlUhochd0kxch3U38=
X-Microsoft-Exchange-Diagnostics: 1;DM3PR07MB2249;20:I/5qEplrd93A3jvDuK02Zs/bUkEdqlblppqrYtXkzTQNN7AlXdvREoxAd+kVjXPAcIZv2DeDUmVLz4NvWpQJbbq1xhLUsEBHA7TcV6qbRuMW/MuluWjgXOKYkZfx/OIQ02BDlPpn3t8YPrkntMVBkl9UZo7eSg6NF5hpXjmUTfxAXkwQQRMxt77ugsqwQqLzWS/j4639CENj0kl4yx6tC0+TyLrQYMeI2tfL15RmClRS1qySZWRv1EpI9lDXEqwQ
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2019 19:46:07.4930
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: daceec87-0815-409e-f8c1-08d692b51080
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR07MB2249
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:_spf.salesforce.com include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-14_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 suspectscore=1
 malwarescore=0 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0
 lowpriorityscore=0 mlxlogscore=850 adultscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.0.1-1810050000 definitions=main-1902140131
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch moves switch responsible for decoding descriptor type
outside snprintf. It improves code readability a little.

Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
 drivers/usb/common/debug.c | 113 +++++++++++++++++++------------------
 1 file changed, 58 insertions(+), 55 deletions(-)

diff --git a/drivers/usb/common/debug.c b/drivers/usb/common/debug.c
index ad6c96aa45b0..8e2c81a40cf8 100644
--- a/drivers/usb/common/debug.c
+++ b/drivers/usb/common/debug.c
@@ -105,62 +105,65 @@ static void usb_decode_get_set_descriptor(__u8 bRequestType, __u8 bRequest,
 					  __u16 wValue, __u16 wIndex,
 					  __u16 wLength, char *str, size_t size)
 {
+	char *s;
+
+	switch (wValue >> 8) {
+	case USB_DT_DEVICE:
+		s = "Device";
+		break;
+	case USB_DT_CONFIG:
+		s = "Configuration";
+		break;
+	case USB_DT_STRING:
+		s = "String";
+		break;
+	case USB_DT_INTERFACE:
+		s = "Interface";
+		break;
+	case USB_DT_ENDPOINT:
+		s = "Endpoint";
+		break;
+	case USB_DT_DEVICE_QUALIFIER:
+		s = "Device Qualifier";
+		break;
+	case USB_DT_OTHER_SPEED_CONFIG:
+		s = "Other Speed Config";
+		break;
+	case USB_DT_INTERFACE_POWER:
+		s = "Interface Power";
+		break;
+	case USB_DT_OTG:
+		s = "OTG";
+		break;
+	case USB_DT_DEBUG:
+		s = "Debug";
+		break;
+	case USB_DT_INTERFACE_ASSOCIATION:
+		s = "Interface Association";
+		break;
+	case USB_DT_BOS:
+		s = "BOS";
+		break;
+	case USB_DT_DEVICE_CAPABILITY:
+		s = "Device Capability";
+		break;
+	case USB_DT_PIPE_USAGE:
+		s = "Pipe Usage";
+		break;
+	case USB_DT_SS_ENDPOINT_COMP:
+		s = "SS Endpoint Companion";
+		break;
+	case USB_DT_SSP_ISOC_ENDPOINT_COMP:
+		s = "SSP Isochronous Endpoint Companion";
+		break;
+	default:
+		s = "UNKNOWN";
+		break;
+	}
+
 	snprintf(str, size, "%s %s Descriptor(Index = %d, Length = %d)",
-		 bRequest == USB_REQ_GET_DESCRIPTOR ? "Get" : "Set",
-		 ({ char *s;
-			switch (wValue >> 8) {
-			case USB_DT_DEVICE:
-				s = "Device";
-				break;
-			case USB_DT_CONFIG:
-				s = "Configuration";
-				break;
-			case USB_DT_STRING:
-				s = "String";
-				break;
-			case USB_DT_INTERFACE:
-				s = "Interface";
-				break;
-			case USB_DT_ENDPOINT:
-				s = "Endpoint";
-				break;
-			case USB_DT_DEVICE_QUALIFIER:
-				s = "Device Qualifier";
-				break;
-			case USB_DT_OTHER_SPEED_CONFIG:
-				s = "Other Speed Config";
-				break;
-			case USB_DT_INTERFACE_POWER:
-				s = "Interface Power";
-				break;
-			case USB_DT_OTG:
-				s = "OTG";
-				break;
-			case USB_DT_DEBUG:
-				s = "Debug";
-				break;
-			case USB_DT_INTERFACE_ASSOCIATION:
-				s = "Interface Association";
-				break;
-			case USB_DT_BOS:
-				s = "BOS";
-				break;
-			case USB_DT_DEVICE_CAPABILITY:
-				s = "Device Capability";
-				break;
-			case USB_DT_PIPE_USAGE:
-				s = "Pipe Usage";
-				break;
-			case USB_DT_SS_ENDPOINT_COMP:
-				s = "SS Endpoint Companion";
-				break;
-			case USB_DT_SSP_ISOC_ENDPOINT_COMP:
-				s = "SSP Isochronous Endpoint Companion";
-				break;
-			default:
-				s = "UNKNOWN";
-				break;
-			} s; }), wValue & 0xff, wLength);
+		bRequest == USB_REQ_GET_DESCRIPTOR ? "Get" : "Set",
+		s, wValue & 0xff, wLength);
 }
 
 static void usb_decode_get_configuration(__u16 wLength, char *str, size_t size)
-- 
2.17.1

