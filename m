Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED3A8C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 19:47:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3382222A1
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 19:47:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="QQgGBIkC";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="VtII27KH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439866AbfBNTr0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 14:47:26 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:60916 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728119AbfBNTrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 14:47:23 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1EJdRwQ018854;
        Thu, 14 Feb 2019 11:46:11 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=pQX05cqqIRIAlv/yFLTspatrIQjT2YjfWniHaF+2AbE=;
 b=QQgGBIkCTBvBFJYBoy+tsPwK/jJaQiBXsQmOybB1RDuEq0vPkVOf/mX4PSMUA62wx5Qe
 StQfCm+PGfdd48e8s85T+eRgOwZNKMNgLc6fMXAKqjNQP2VAwwqEot2UkfE9LrunUpss
 mRhPY0Jg5ZhQ6YVU5xvD4kgoXidsQqUMhXGu7eMP39HW3FXgsqZBahc7v/wE6HnUmcAJ
 q0DjXmXwgZYNFVYcx7l4g0SOJsNO4b1Hgqah/o4xSopn3FQFgFFUlFMf3b4k+WcHNu2t
 O289pW7LQ/BX7K6Xf2n5hkx0n1m2gWZXNMiSIenBKNrItJdMI78XJ1yvucc5Xek/qEWO 5g== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pawell@cadence.com
Received: from nam02-bl2-obe.outbound.protection.outlook.com (mail-bl2nam02lp2051.outbound.protection.outlook.com [104.47.38.51])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2qn8dqhrsq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Feb 2019 11:46:10 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pQX05cqqIRIAlv/yFLTspatrIQjT2YjfWniHaF+2AbE=;
 b=VtII27KHcPtcLUFbkS0VTnxLBdfOTxyRQ8KCL4ulAn4YEIyVaNPJlcz/hvwEOZRbWoAbqR6kFNR1OfdShIoAG60FOO294mcMBfPYVhw5V1MqxNjx1duxpRx7b0cPk6Mfk32jOdWQtRN3hiZ/KKLLQtm/zHH+lYeNaC33ipi3Ty8=
Received: from DM6PR07CA0044.namprd07.prod.outlook.com (2603:10b6:5:74::21) by
 SN1PR07MB3981.namprd07.prod.outlook.com (2603:10b6:802:27::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.16; Thu, 14 Feb 2019 19:46:07 +0000
Received: from DM3NAM05FT035.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e51::208) by DM6PR07CA0044.outlook.office365.com
 (2603:10b6:5:74::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1622.16 via Frontend
 Transport; Thu, 14 Feb 2019 19:46:07 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx1.cadence.com (158.140.1.28) by
 DM3NAM05FT035.mail.protection.outlook.com (10.152.98.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1580.2 via Frontend Transport; Thu, 14 Feb 2019 19:46:06 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id x1EJk2cT012765
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 14 Feb 2019 11:46:05 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Thu, 14 Feb 2019 20:46:01 +0100
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Thu, 14 Feb 2019 20:46:01 +0100
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id x1EJk2Mv031440;
        Thu, 14 Feb 2019 19:46:02 GMT
Received: (from pawell@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id x1EJk2T9031429;
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
Subject: [PATCH v4 3/6] usb:common Patch simplify usb_decode_set_clear_feature function.
Date:   Thu, 14 Feb 2019 19:45:11 +0000
Message-ID: <1550173514-23573-4-git-send-email-pawell@cadence.com>
X-Mailer: git-send-email 1.7.11.2
In-Reply-To: <1550173514-23573-1-git-send-email-pawell@cadence.com>
References: <1550173514-23573-1-git-send-email-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(39860400002)(396003)(376002)(136003)(2980300002)(199004)(189003)(36092001)(51416003)(107886003)(106466001)(316002)(47776003)(54906003)(42186006)(16586007)(105596002)(36756003)(50466002)(48376002)(4326008)(2351001)(8676002)(356004)(6666004)(50226002)(8936002)(186003)(478600001)(4720700003)(7416002)(7636002)(246002)(426003)(26826003)(76176011)(446003)(476003)(126002)(11346002)(2616005)(26005)(486006)(86362001)(336012)(2906002)(305945005)(6916009)(87636003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR07MB3981;H:sjmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;DM3NAM05FT035;1:R/fdvrvqx5dKOigspyJ2r8uwL/y5sQRAY3+501w84tkdY1mMmaFGV4oJxwHzjhQEWGL1/tzzYKw7fqdTCongQuB6vm7sDNKrMunSGlLZEygQt7AnAxk7F7pGL8Ozul4Foi7z1h0qQ/u5qoaexn5GFkpjeFSudLeRJcQxukdh9Gs=
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d3ccb9a8-e2a5-46ee-f656-08d692b50ffe
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605077)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060);SRVR:SN1PR07MB3981;
X-MS-TrafficTypeDiagnostic: SN1PR07MB3981:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB3981;20:uHUjFHVtO3kNrGT1Tbyiyw/UY6jlDGcNiuZZpojY4EF0T6nzvQwg89mL13E/ahzXtahnOkRGZtKx6pDvRiPg5ob3B5j2/SbGDZPuGgFqy/lZlqmuqrmNwSuxa3iaip6/BwsRXU16rU3+xzuzJwC3e2XJqaLTOPc+udDmSKVyJT6uOgsMTynMX1X6xKNPVKn9V4yipYz0Bqa5MpXP3aiQ660G3P9jNcjD91t3LyLo/V2kglWCLZJ3NISZyO7+I3XUdrRhQSE/Uzb+Pozqz4CxYEL50UCccR/ZhyWbPbuB1wCBUBvOM+fQDn0pJ0wJKtqnvusoNTvc8BTUKEwRVU7Pojm6QSBELIJNLYWUp5kyiUK6yPdLdCdDFDY3Px6OPLzryi97C7ZZhbQ/AhVQHbaShHyz88SyecdBEyMlXX5t2gWNsrUNPgWp5oUFqFImv7vhPSFsAnZUZcmMBkek9quw8Codn9a6MtFw1oSeo/x5VMRyoMO824BKQsIkb0of9PZo
X-Microsoft-Antispam-PRVS: <SN1PR07MB3981D4843C12BDECC05E329DDD670@SN1PR07MB3981.namprd07.prod.outlook.com>
X-Forefront-PRVS: 09480768F8
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR07MB3981;23:RELycSdbIPryP0XaVSfKHkp+jNGD0f1SzKjPsy6Q+?=
 =?us-ascii?Q?CW4NarwGEcD6wlEFLadBWrT5qCK9FRgfzgcdaaYZtGs0T5ty02g21k2GZ6IC?=
 =?us-ascii?Q?j99VbhAFDS3CplVYhLwoy4wtNZRCkR2tPLYE30GfpV3y8kC3bM4X1ozSO+X3?=
 =?us-ascii?Q?xew2hJiO3I5RH9/SLWLRhuKrA+1JGI4EvfpWSDlJawWij5CTZeu4eDChmR2s?=
 =?us-ascii?Q?KvyVXI1T+GE71vA/WRnvPMsIIIjZ+nnapJ0/s1FTjuOnZlyGktNihcZ1Ldlv?=
 =?us-ascii?Q?AsK4+YI51VSFQ0dBTgVhzXZQqvjquXMixIWHZ6OFjuntFvDpLzZEptqX2qLn?=
 =?us-ascii?Q?9Y4EeIqqdI5QxaCPJNAVhNXh5UZpDDBCc8FPgcCiSsVHYyQMBRco/SWnWD2n?=
 =?us-ascii?Q?G7Enz4vNuAMPSu8nX7VqZf++GYhvD71uwLFskD69cyGPHEZZVQVG1jnGEKoN?=
 =?us-ascii?Q?30C1+nhQI1F11fp4PzNEOaK/2KZu9vx6mdntTVy0QfpGkd7jJoe4SwgiMipf?=
 =?us-ascii?Q?w5Zo51Oo7n0uASKVZLZMZSHW/YqwbmryIVWhhIN5RCbLzXU7IgnVTLB3+wEU?=
 =?us-ascii?Q?BdXus0fE4e52AKSdP7vgKKAnFiG9NtcIDiX46EfBgZfMxMoC+XBSUeYSU1g1?=
 =?us-ascii?Q?2nyYCBlA9Rnua9a0dN6T2jLslngG3kCKuUfvVCwkx6KE6a/eWOKwv2T3H6h7?=
 =?us-ascii?Q?gE3zrDX++K3CMSiK6ymr7oKyRzhvfmQymV21J9UoP3+F0NKY5LALJY7rpduP?=
 =?us-ascii?Q?kO1/qTV1BVtptDRFFMDMPzEcgdz9xfkap/GmCtThr5YB7+jBVCrUKF/KhfNx?=
 =?us-ascii?Q?20wXnus97SWBr7zyj+NYRZ3hAwcLG6iH8h8+gnHaje1xHH3w5I9997G2im9O?=
 =?us-ascii?Q?AdZBY2/yVqjFBsxoGp4oM9wnEHY8Km8wgqvtfakNPWZKpO/KKFbQR8KoUsv9?=
 =?us-ascii?Q?il/eEFlZiGGIs2pYXzIsBKbOkHa/FbnvOHhwK4qBqgoMy2pLB0OzCk3QHTVA?=
 =?us-ascii?Q?MNPDYBpH2HuazQWRAWgaqYCPqzCUKg3dz/q9ikwiPxdsbn1D1n7mX7limmiI?=
 =?us-ascii?Q?KF8fh84MIx1EZXQP8y0nFtVkiwKPvfzv3ICBIuYcI81EPgVecxVegVE9SrS+?=
 =?us-ascii?Q?SnoC5yN3Ec=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: cj4wJlSYYPE/Z8wI+WHKV10kw6r6nmHpvE9yiTF60EMwvhPKHk/VumTp+NZnD/1FLfPUsEOb7ERR+TxuNUIycTBQlWqyYRh0bZvL3aRjtNfplMZ8ZVmP3gM2mKCh4biojE0/LUsip3OImDFTKE4pXwcsQUT29sYKjpPLzSoMHGEUSVDZtlOxfcHFu+hlTO6wj7UD1gZLIzVWCNNKzY7PPrCc0eqLds/291womKbSy17q0DkW+57Xt4qE9Esr/1AbtjVHg4FS7ynb1cg1xz52stBhB1ysy7GxblG/aJ13ifgG2dqH+mC9JhXC6gpngFRpugxFC1+R7TfKaElAuI4izz13DIO3THg/GvussjTqljPuhI+09uXRf91UUfH6AtcFUxcUkcsQwn/Add0drw9hDLZX7b0pif199WKI6M6kE2k=
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB3981;20:0Q02s0pPRoeJDyQsJGYaNzdW2KsWIwsX9d/MA421s+MYyA6X+mP0P6SHpvBGpjkYs73MCmfrUBcGEfBlRT3gMJDA9h84QZ4opo37JJXNlQ69d1wezMHy8ozyINKNCE4dn1tI9t1wu61TD4XewHV/plreRnjrOFqMRIsgmDNMrz56n6cvFdM2ZJlCCM4dbrpBN4BPkYY6RCW8byQ3QPbCwvKLgDt5BwSL/xXTIaCnVQJILc7j2IOj/wFFXrPCloLz
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2019 19:46:06.6490
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3ccb9a8-e2a5-46ee-f656-08d692b50ffe
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR07MB3981
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:_spf.salesforce.com include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-14_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=719 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902140131
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch adds usb_decode_test_mode and usb_decode_device_feature functions,
which allow to make more readable and simplify the
usb_decode_set_clear_feature function.

Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
 drivers/usb/common/debug.c | 89 ++++++++++++++++++--------------------
 1 file changed, 43 insertions(+), 46 deletions(-)

diff --git a/drivers/usb/common/debug.c b/drivers/usb/common/debug.c
index 3fdf116da909..ad6c96aa45b0 100644
--- a/drivers/usb/common/debug.c
+++ b/drivers/usb/common/debug.c
@@ -30,58 +30,55 @@ static void usb_decode_get_status(__u8 bRequestType, __u16 wIndex,
 	}
 }
 
-static void usb_decode_set_clear_feature(__u8 bRequestType, __u8 bRequest,
-					 __u16 wValue, __u16 wIndex,
-					 char *str, size_t size)
+static const char *usb_decode_device_feature(u16 wValue)
+{
+	switch (wValue) {
+	case USB_DEVICE_SELF_POWERED:
+		return "Self Powered";
+	case USB_DEVICE_REMOTE_WAKEUP:
+		return "Remote Wakeup";
+	case USB_DEVICE_TEST_MODE:
+		return "Test Mode";
+	case USB_DEVICE_U1_ENABLE:
+		return "U1 Enable";
+	case USB_DEVICE_U2_ENABLE:
+		return "U2 Enable";
+	case USB_DEVICE_LTM_ENABLE:
+		return "LTM Enable";
+	default:
+		return "UNKNOWN";
+	}
+}
+
+static const char *usb_decode_test_mode(u16 wIndex)
+{
+	switch (wIndex) {
+	case TEST_J:
+		return ": TEST_J";
+	case TEST_K:
+		return ": TEST_K";
+	case TEST_SE0_NAK:
+		return ": TEST_SE0_NAK";
+	case TEST_PACKET:
+		return ": TEST_PACKET";
+	case TEST_FORCE_EN:
+		return ": TEST_FORCE_EN";
+	default:
+		return ": UNKNOWN";
+	}
+}
+
+static void usb_decode_set_clear_feature(__u8 bRequestType,
+					 __u8 bRequest, __u16 wValue,
+					 __u16 wIndex, char *str, size_t size)
 {
 	switch (bRequestType & USB_RECIP_MASK) {
 	case USB_RECIP_DEVICE:
 		snprintf(str, size, "%s Device Feature(%s%s)",
 			 bRequest == USB_REQ_CLEAR_FEATURE ? "Clear" : "Set",
-			 ({char *s;
-				switch (wValue) {
-				case USB_DEVICE_SELF_POWERED:
-					s = "Self Powered";
-					break;
-				case USB_DEVICE_REMOTE_WAKEUP:
-					s = "Remote Wakeup";
-					break;
-				case USB_DEVICE_TEST_MODE:
-					s = "Test Mode";
-					break;
-				case USB_DEVICE_U1_ENABLE:
-					s = "U1 Enable";
-					break;
-				case USB_DEVICE_U2_ENABLE:
-					s = "U2 Enable";
-					break;
-				case USB_DEVICE_LTM_ENABLE:
-					s = "LTM Enable";
-					break;
-				default:
-					s = "UNKNOWN";
-				} s; }),
+			 usb_decode_device_feature(wValue),
 			 wValue == USB_DEVICE_TEST_MODE ?
-			 ({ char *s;
-				switch (wIndex) {
-				case TEST_J:
-					s = ": TEST_J";
-					break;
-				case TEST_K:
-					s = ": TEST_K";
-					break;
-				case TEST_SE0_NAK:
-					s = ": TEST_SE0_NAK";
-					break;
-				case TEST_PACKET:
-					s = ": TEST_PACKET";
-					break;
-				case TEST_FORCE_EN:
-					s = ": TEST_FORCE_EN";
-					break;
-				default:
-					s = ": UNKNOWN";
-				} s; }) : "");
+			 usb_decode_test_mode(wIndex) : "");
 		break;
 	case USB_RECIP_INTERFACE:
 		snprintf(str, size, "%s Interface Feature(%s)",
-- 
2.17.1

