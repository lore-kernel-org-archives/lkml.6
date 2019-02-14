Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BAA2C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 19:46:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4D0D21916
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 19:46:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="ICQus0Vz";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="ObXdlOay"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437278AbfBNTqh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 14:46:37 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:57404 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2394511AbfBNTq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 14:46:27 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1EJh4la020778;
        Thu, 14 Feb 2019 11:46:11 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=/I0nEkIIaoVKxvqbl4yh9nI9h88/QTHUgmihMIewjWQ=;
 b=ICQus0Vz1aMxekxKZydrl7Ejkm/cMoWXz8g/nk5BIcBsYXJNdvUwiU4wYRao8iq2polW
 s8ptG8OoYAS1+2bwQr9No1nAF3hATsAPK2bvmQKkwrgrsa+iLQGZcVz6vCLiVant+RTm
 HE9cr6YIxQCgIm0KNW5aF2GRuLYBNQ7pZvVnK5gT+weO16yrEtjTAG5M4YvvihWLwS9B
 V6sDKFg2Zj4SaPvoK57ll1GsFm4WPasq+YfdtuE3LBm1MHU/PYzxWPUWSEu53nEEPlGT
 RaiZAJYwJgwHMf0W8R0SI4VVTt/4gIdJ/SFIb1VExAYHghBtu5MHqe+Gww6bPZ9Wossr hA== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pawell@cadence.com
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2052.outbound.protection.outlook.com [104.47.36.52])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2qmt3v4vpn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 14 Feb 2019 11:46:10 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/I0nEkIIaoVKxvqbl4yh9nI9h88/QTHUgmihMIewjWQ=;
 b=ObXdlOayIzXzA9o+GrO7xdhor+N2UcSHiR6JEXaGuvElEWV4ySDZi5oNIL8jL6fpD2+rvYA6myQfZCGNMEYs+EYI64k3bcPs+cZ2Wmq/W5i9RCJ/dBcLQ4X7ykGvg733EbbQIX8vSsi3BOwDaaBBZ5Pvo1FAfYfM0yrXNvkhr1I=
Received: from SN4PR0701CA0003.namprd07.prod.outlook.com
 (2603:10b6:803:28::13) by BN6PR07MB3089.namprd07.prod.outlook.com
 (2603:10b6:404:a8::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1601.21; Thu, 14 Feb
 2019 19:46:07 +0000
Received: from DM3NAM05FT057.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e51::207) by SN4PR0701CA0003.outlook.office365.com
 (2603:10b6:803:28::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1622.16 via Frontend
 Transport; Thu, 14 Feb 2019 19:46:07 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx1.cadence.com (158.140.1.28) by
 DM3NAM05FT057.mail.protection.outlook.com (10.152.98.116) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1580.2 via Frontend Transport; Thu, 14 Feb 2019 19:46:06 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id x1EJk2cS012765
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 14 Feb 2019 11:46:05 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Thu, 14 Feb 2019 20:46:01 +0100
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Thu, 14 Feb 2019 20:46:00 +0100
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id x1EJk1Ds031420;
        Thu, 14 Feb 2019 19:46:01 GMT
Received: (from pawell@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id x1EJk15f031419;
        Thu, 14 Feb 2019 19:46:01 GMT
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
Subject: [PATCH v4 2/6] usb:common Separated decoding functions from dwc3 driver.
Date:   Thu, 14 Feb 2019 19:45:10 +0000
Message-ID: <1550173514-23573-3-git-send-email-pawell@cadence.com>
X-Mailer: git-send-email 1.7.11.2
In-Reply-To: <1550173514-23573-1-git-send-email-pawell@cadence.com>
References: <1550173514-23573-1-git-send-email-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(39860400002)(396003)(346002)(136003)(2980300002)(199004)(189003)(36092001)(2616005)(476003)(14444005)(30864003)(6666004)(54906003)(356004)(316002)(426003)(486006)(51416003)(42186006)(76176011)(8936002)(87636003)(36756003)(186003)(8676002)(26005)(50226002)(126002)(16586007)(446003)(11346002)(7636002)(246002)(336012)(305945005)(6306002)(107886003)(478600001)(2906002)(966005)(48376002)(50466002)(7416002)(105596002)(2351001)(86362001)(106466001)(4720700003)(47776003)(26826003)(53386004)(6916009)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR07MB3089;H:sjmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;DM3NAM05FT057;1:IyFZfiFrvWiqvSfl6JYXuO1b6iLdYmaIIHTntLWXhAsLDj5iNOPML0neybtb43I4UqdBl13Xb4wcqXKUam/IoNpPWmc26IMWCQDUNSavTTAgSiov7CytAZdQqds6kFqRmQ6z1B3+8WZuq9G9cTm38RVePt5She/Wj60N2BfQQCc=
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8f2871c9-64bc-4688-f369-08d692b50fd3
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060);SRVR:BN6PR07MB3089;
X-MS-TrafficTypeDiagnostic: BN6PR07MB3089:
X-MS-Exchange-PUrlCount: 1
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB3089;20:iPf1eZ25hmCbY9khhFcML4owpenP7GY1zSVG19k7dMcrv/Ph3BHP21mzChX1S12w9krFGoGXCZuGZ8fv+3FNGXprCVWOCkQPYy5l9qlW0CP9n57xQ3149qQ75t9MbizJuMD/F/MPvJN8qAflQmNQik90BU+aEWZUYufETxqvAMxOdAE+JyQ98ZSzYYf/agCEX/AkUciqMnlTiR1pedfkXXdECigzCm+E/q2F4ODWMP+++JAv3SOhIyPhvuSSQI3sMXCeCzdYLGSMQdWkxFv8CHCPgXAM6TrP6fQ057N8HV71nFnzjVcTLibdF7ZMlkvFK0ZUqipmtAyeRHizuL8EiS8WM3p3Db4TI1HIPpg8qGf8YzaO0kOf6RxqFZPsQ4jVtK39ZlVsvTBuZv2yNLuBadIm/mIDtObgzqQOxj6MlqE4Zd1R8mXe0L6FJBI9kua7eeRVUX88twYjBGMyXHgN8JWafjuJhzDVwUscLxWYp9SvAEw2UX/IqSHARXTAX0sK
X-Microsoft-Antispam-PRVS: <BN6PR07MB30897F4A17AE58530E7FAC51DD670@BN6PR07MB3089.namprd07.prod.outlook.com>
X-Forefront-PRVS: 09480768F8
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR07MB3089;23:szVgXsZ+HF6YMT4Hi+NLnf2lkDh+L95ElMzIrARfS?=
 =?us-ascii?Q?pTC4Kb5yXE4tlPUNcAAeuYQhWz4L4iNCirMNjeYh1qvwuR+z9WCAWizoAa5a?=
 =?us-ascii?Q?DV/3viG5fbtnhikTbpN0MRGaFy1KQPKGdGJKU1pk8y+bILIzDwyrh9Qi+yE4?=
 =?us-ascii?Q?H2S8kXOpmWONdDssKaclSg7ZqTpEwAkSaKzrTC5YdYZVMJUiPoOU087ps1KV?=
 =?us-ascii?Q?Nb7bbTTUHYh+lnlW7Dj3YxALwY3C/QmHbYnnaXuLhcCLGLY7Qy2CFv4Nqt6t?=
 =?us-ascii?Q?QwmohSUCTOZsR49gDqRQa/YHZnKRixqvGgAbgghWAdzTk8/FGVrKsx5HRqLa?=
 =?us-ascii?Q?cxph6JsygVNJNm9bPc0lZeNhULUVbjHMSOK4UJauSR+SqU/Njr8+VjFeOJyf?=
 =?us-ascii?Q?FU3yMlUTb69RJ+nFjQUfilGdABjTmRJOCNB2CJkFxv7WPj+44ewaFw5GOAi5?=
 =?us-ascii?Q?VPKI/bvICjVJ3weSTXrTof87s0j7l6XCL+CDNYYdnjdEFxlcXk7aCYRkab6T?=
 =?us-ascii?Q?fl2fd+5AV+1z8302QbfLRX5syf6DoyX/jumJvNRWD3MD/iq+uUphR6gUS89D?=
 =?us-ascii?Q?RAWxZN9UT3GBwlnOyi3745VBJCqnC9akjDPZEO0pGuJC8W3ZOJ0hrCyopagy?=
 =?us-ascii?Q?AIYj8LVdo87m/1V53XAeKZVOk8sZB3Rpb+iBny37YX/03x/Kriy1vp+evb1h?=
 =?us-ascii?Q?3fhjIGjMF8WPG4NkOUI99rjtO0dEBlaw9CuBeSH8O+4CHBIjd9ZoswrflDKq?=
 =?us-ascii?Q?YZDeOI/FDYsPfS1yzq+sBbuBJfib7xvsZQaRU/A/fcU/QpoAyC2DAjRr4uNq?=
 =?us-ascii?Q?hUh2giXpdNibWTucsq+uDxNEuhjTKdmAjs4TpUrkdd/jJBfzmMak07hwHE6n?=
 =?us-ascii?Q?WOpJMVgqGQiPR2huu9L1l6I1vbUlFzgVrKI+Y3rv077o7VA3k98dAoOur/E3?=
 =?us-ascii?Q?D0agHm1bNQYtMAvTZ4BOCGSeMIpOQeYP9H6vGM583vnGI+6DGTtWTM6Q5kPc?=
 =?us-ascii?Q?QCTJdm/AzsoyDfHrpGcDZbsBjS6XMJaFr1ykWs7jUG0h8vZcUV8wi018E6fw?=
 =?us-ascii?Q?n3rSQ2csCY/Dgy50Cr2f90XBO2sAoSeg3S5fn8D1sOLZtcSmAis+Rw3RaEmb?=
 =?us-ascii?Q?Wle+WrVnCIWVJL8+T4PBeWjXl8gZMDuMpOCRxOG9mBorY3V4pIDee8vitm3v?=
 =?us-ascii?Q?WGRV9tZ0WApdrapzhsroLrUW6ALOrJoPVOw?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: tbv1WF294/v2OOE3m37ou0FuFQYCgs1tfflGFrCfL6N0It+1r4VBoEFci3X+8C7obkCTYNInw5V1Gk5c09hMAppO+/GAzApi8OhvTRBSFvjipBHXJRD4ikKcQ9pwqNOcW0N9nY2SJNWyZA3vPY2E6H/4DU7NmeXWq9YL1Ja7jFU6DuiFNP/itFrQ4vrvQp8MI9kwOpQ0OsNHzoAF9usFRnmveyX3qdyJU69SEmlZmZpn5jHc3Jx9TBkSiMG/fjaLbOKMFZgg4iuXQnBKhqMClFJRgD2nDMxD/zWOvrEHWryAGn7uw8tx/26OnvFiTeBScSQxXLB9a/0SHWBBiEdi1414R3vK69bnFxn4ztxrA2SCDzGagL0WA5l4jsfq9/2vZlbQeVgg2mLU/fG7t8KJgKTlJIJBpdaskjzU1fpKRk0=
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB3089;20:CqouZH9bS1c4cVq9zw5lK+BgPH4KGSLs/GzqDLrdBqcmYf3FNNxJzs5gUurjL18AJm1ObcrxoGOlxxTdRSM7YNWqmvXoCAFgVaj/XeLhX/NQavcVh53h26Zl6A0HvwvBZYDNF3bjr06SdCFFUR0iVg6GB2Vg+/0MG/uHbQka87VFnPeX/f9TTmtuTihs/nHit4jAxuADRMwhkU/dPqhwjgPZVDjwxHYa5ZOPV/k0VcRVxrkjjq1kAW0xkcM65opW
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2019 19:46:06.3081
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f2871c9-64bc-4688-f369-08d692b50fd3
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR07MB3089
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:_spf.salesforce.com include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-14_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902140131
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch moves some decoding functions from driver/usb/dwc3/debug.h driver
to driver/usb/common/debug.c file. These moved functions include:
    dwc3_decode_get_status
    dwc3_decode_set_clear_feature
    dwc3_decode_set_address
    dwc3_decode_get_set_descriptor
    dwc3_decode_get_configuration
    dwc3_decode_set_configuration
    dwc3_decode_get_intf
    dwc3_decode_set_intf
    dwc3_decode_synch_frame
    dwc3_decode_set_sel
    dwc3_decode_set_isoch_delay
    dwc3_decode_ctrl

These functions are used also in inroduced cdns3 driver.

All functions prefixes were changed from dwc3 to usb.
Also, function's parameters has been extended according to the name
of fields in standard SETUP packet.
Additionally, patch adds usb_decode_ctrl function to
include/linux/usb/ch9.h file.

Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
 drivers/usb/common/Makefile |   2 +-
 drivers/usb/common/debug.c  | 270 ++++++++++++++++++++++++++++++++++++
 drivers/usb/dwc3/debug.h    | 249 ---------------------------------
 drivers/usb/dwc3/trace.h    |   2 +-
 include/linux/usb/ch9.h     |  25 ++++
 5 files changed, 297 insertions(+), 251 deletions(-)
 create mode 100644 drivers/usb/common/debug.c

diff --git a/drivers/usb/common/Makefile b/drivers/usb/common/Makefile
index fb4d5ef4165c..3d3d2962ea4b 100644
--- a/drivers/usb/common/Makefile
+++ b/drivers/usb/common/Makefile
@@ -4,7 +4,7 @@
 #
 
 obj-$(CONFIG_USB_COMMON)	  += usb-common.o
-usb-common-y			  += common.o
+usb-common-y			  += common.o debug.o
 usb-common-$(CONFIG_USB_LED_TRIG) += led.o
 
 obj-$(CONFIG_USB_OTG_FSM) += usb-otg-fsm.o
diff --git a/drivers/usb/common/debug.c b/drivers/usb/common/debug.c
new file mode 100644
index 000000000000..3fdf116da909
--- /dev/null
+++ b/drivers/usb/common/debug.c
@@ -0,0 +1,270 @@
+// SPDX-License-Identifier: GPL-2.0
+/**
+ * Common USB debugging functions
+ *
+ * Copyright (C) 2010-2011 Texas Instruments Incorporated - http://www.ti.com
+ *
+ * Authors: Felipe Balbi <balbi@ti.com>,
+ *	    Sebastian Andrzej Siewior <bigeasy@linutronix.de>
+ */
+
+#ifndef __LINUX_USB_COMMON_DEBUG
+#define __LINUX_USB_COMMON_DEBUG
+
+#include <linux/usb/ch9.h>
+
+static void usb_decode_get_status(__u8 bRequestType, __u16 wIndex,
+				  __u16 wLength, char *str, size_t size)
+{
+	switch (bRequestType & USB_RECIP_MASK) {
+	case USB_RECIP_INTERFACE:
+		snprintf(str, size,
+			 "Get Interface Status(Intf = %d, Length = %d)",
+			 wIndex, wLength);
+		break;
+	case USB_RECIP_ENDPOINT:
+		snprintf(str, size, "Get Endpoint Status(ep%d%s)",
+			 wIndex & ~USB_DIR_IN,
+			 wIndex & USB_DIR_IN ? "in" : "out");
+		break;
+	}
+}
+
+static void usb_decode_set_clear_feature(__u8 bRequestType, __u8 bRequest,
+					 __u16 wValue, __u16 wIndex,
+					 char *str, size_t size)
+{
+	switch (bRequestType & USB_RECIP_MASK) {
+	case USB_RECIP_DEVICE:
+		snprintf(str, size, "%s Device Feature(%s%s)",
+			 bRequest == USB_REQ_CLEAR_FEATURE ? "Clear" : "Set",
+			 ({char *s;
+				switch (wValue) {
+				case USB_DEVICE_SELF_POWERED:
+					s = "Self Powered";
+					break;
+				case USB_DEVICE_REMOTE_WAKEUP:
+					s = "Remote Wakeup";
+					break;
+				case USB_DEVICE_TEST_MODE:
+					s = "Test Mode";
+					break;
+				case USB_DEVICE_U1_ENABLE:
+					s = "U1 Enable";
+					break;
+				case USB_DEVICE_U2_ENABLE:
+					s = "U2 Enable";
+					break;
+				case USB_DEVICE_LTM_ENABLE:
+					s = "LTM Enable";
+					break;
+				default:
+					s = "UNKNOWN";
+				} s; }),
+			 wValue == USB_DEVICE_TEST_MODE ?
+			 ({ char *s;
+				switch (wIndex) {
+				case TEST_J:
+					s = ": TEST_J";
+					break;
+				case TEST_K:
+					s = ": TEST_K";
+					break;
+				case TEST_SE0_NAK:
+					s = ": TEST_SE0_NAK";
+					break;
+				case TEST_PACKET:
+					s = ": TEST_PACKET";
+					break;
+				case TEST_FORCE_EN:
+					s = ": TEST_FORCE_EN";
+					break;
+				default:
+					s = ": UNKNOWN";
+				} s; }) : "");
+		break;
+	case USB_RECIP_INTERFACE:
+		snprintf(str, size, "%s Interface Feature(%s)",
+			 bRequest == USB_REQ_CLEAR_FEATURE ? "Clear" : "Set",
+			 wValue == USB_INTRF_FUNC_SUSPEND ?
+			 "Function Suspend" : "UNKNOWN");
+		break;
+	case USB_RECIP_ENDPOINT:
+		snprintf(str, size, "%s Endpoint Feature(%s ep%d%s)",
+			 bRequest == USB_REQ_CLEAR_FEATURE ? "Clear" : "Set",
+			 wValue == USB_ENDPOINT_HALT ? "Halt" : "UNKNOWN",
+			 wIndex & ~USB_DIR_IN,
+			 wIndex & USB_DIR_IN ? "in" : "out");
+		break;
+	}
+}
+
+static void usb_decode_set_address(__u16 wValue, char *str, size_t size)
+{
+	snprintf(str, size, "Set Address(Addr = %02x)", wValue);
+}
+
+static void usb_decode_get_set_descriptor(__u8 bRequestType, __u8 bRequest,
+					  __u16 wValue, __u16 wIndex,
+					  __u16 wLength, char *str, size_t size)
+{
+	snprintf(str, size, "%s %s Descriptor(Index = %d, Length = %d)",
+		 bRequest == USB_REQ_GET_DESCRIPTOR ? "Get" : "Set",
+		 ({ char *s;
+			switch (wValue >> 8) {
+			case USB_DT_DEVICE:
+				s = "Device";
+				break;
+			case USB_DT_CONFIG:
+				s = "Configuration";
+				break;
+			case USB_DT_STRING:
+				s = "String";
+				break;
+			case USB_DT_INTERFACE:
+				s = "Interface";
+				break;
+			case USB_DT_ENDPOINT:
+				s = "Endpoint";
+				break;
+			case USB_DT_DEVICE_QUALIFIER:
+				s = "Device Qualifier";
+				break;
+			case USB_DT_OTHER_SPEED_CONFIG:
+				s = "Other Speed Config";
+				break;
+			case USB_DT_INTERFACE_POWER:
+				s = "Interface Power";
+				break;
+			case USB_DT_OTG:
+				s = "OTG";
+				break;
+			case USB_DT_DEBUG:
+				s = "Debug";
+				break;
+			case USB_DT_INTERFACE_ASSOCIATION:
+				s = "Interface Association";
+				break;
+			case USB_DT_BOS:
+				s = "BOS";
+				break;
+			case USB_DT_DEVICE_CAPABILITY:
+				s = "Device Capability";
+				break;
+			case USB_DT_PIPE_USAGE:
+				s = "Pipe Usage";
+				break;
+			case USB_DT_SS_ENDPOINT_COMP:
+				s = "SS Endpoint Companion";
+				break;
+			case USB_DT_SSP_ISOC_ENDPOINT_COMP:
+				s = "SSP Isochronous Endpoint Companion";
+				break;
+			default:
+				s = "UNKNOWN";
+				break;
+			} s; }), wValue & 0xff, wLength);
+}
+
+static void usb_decode_get_configuration(__u16 wLength, char *str, size_t size)
+{
+	snprintf(str, size, "Get Configuration(Length = %d)", wLength);
+}
+
+static void usb_decode_set_configuration(__u8 wValue, char *str, size_t size)
+{
+	snprintf(str, size, "Set Configuration(Config = %d)", wValue);
+}
+
+static void usb_decode_get_intf(__u16 wIndex, __u16 wLength, char *str,
+				size_t size)
+{
+	snprintf(str, size, "Get Interface(Intf = %d, Length = %d)",
+		 wIndex, wLength);
+}
+
+static void usb_decode_set_intf(__u8 wValue, __u16 wIndex, char *str,
+				size_t size)
+{
+	snprintf(str, size, "Set Interface(Intf = %d, Alt.Setting = %d)",
+		 wIndex, wValue);
+}
+
+static void usb_decode_synch_frame(__u16 wIndex, __u16 wLength,
+				   char *str, size_t size)
+{
+	snprintf(str, size, "Synch Frame(Endpoint = %d, Length = %d)",
+		 wIndex, wLength);
+}
+
+static void usb_decode_set_sel(__u16 wLength, char *str, size_t size)
+{
+	snprintf(str, size, "Set SEL(Length = %d)", wLength);
+}
+
+static void usb_decode_set_isoch_delay(__u8 wValue, char *str, size_t size)
+{
+	snprintf(str, size, "Set Isochronous Delay(Delay = %d ns)", wValue);
+}
+
+/**
+ * usb_decode_ctrl - returns a string representation of ctrl request
+ */
+const char *usb_decode_ctrl(char *str, size_t size, __u8 bRequestType,
+			    __u8 bRequest, __u16 wValue, __u16 wIndex,
+			    __u16 wLength)
+{
+	switch (bRequest) {
+	case USB_REQ_GET_STATUS:
+		usb_decode_get_status(bRequestType, wIndex, wLength, str, size);
+		break;
+	case USB_REQ_CLEAR_FEATURE:
+	case USB_REQ_SET_FEATURE:
+		usb_decode_set_clear_feature(bRequestType, bRequest, wValue,
+					     wIndex, str, size);
+		break;
+	case USB_REQ_SET_ADDRESS:
+		usb_decode_set_address(wValue, str, size);
+		break;
+	case USB_REQ_GET_DESCRIPTOR:
+	case USB_REQ_SET_DESCRIPTOR:
+		usb_decode_get_set_descriptor(bRequestType, bRequest, wValue,
+					      wIndex, wLength, str, size);
+		break;
+	case USB_REQ_GET_CONFIGURATION:
+		usb_decode_get_configuration(wLength, str, size);
+		break;
+	case USB_REQ_SET_CONFIGURATION:
+		usb_decode_set_configuration(wValue, str, size);
+		break;
+	case USB_REQ_GET_INTERFACE:
+		usb_decode_get_intf(wIndex, wLength, str, size);
+		break;
+	case USB_REQ_SET_INTERFACE:
+		usb_decode_set_intf(wValue, wIndex, str, size);
+		break;
+	case USB_REQ_SYNCH_FRAME:
+		usb_decode_synch_frame(wIndex, wLength, str, size);
+		break;
+	case USB_REQ_SET_SEL:
+		usb_decode_set_sel(wLength, str, size);
+		break;
+	case USB_REQ_SET_ISOCH_DELAY:
+		usb_decode_set_isoch_delay(wValue, str, size);
+		break;
+	default:
+		snprintf(str, size, "%02x %02x %02x %02x %02x %02x %02x %02x",
+			 bRequestType, bRequest,
+			 (u8)(cpu_to_le16(wValue) & 0xff),
+			 (u8)(cpu_to_le16(wValue) >> 8),
+			 (u8)(cpu_to_le16(wIndex) & 0xff),
+			 (u8)(cpu_to_le16(wIndex) >> 8),
+			 (u8)(cpu_to_le16(wLength) & 0xff),
+			 (u8)(cpu_to_le16(wLength) >> 8));
+	}
+
+	return str;
+}
+EXPORT_SYMBOL_GPL(usb_decode_ctrl);
+
+#endif /* __LINUX_USB_COMMON_DEBUG */
diff --git a/drivers/usb/dwc3/debug.h b/drivers/usb/dwc3/debug.h
index 6ec4280fa40c..3cf84c0ba486 100644
--- a/drivers/usb/dwc3/debug.h
+++ b/drivers/usb/dwc3/debug.h
@@ -217,255 +217,6 @@ static inline const char *dwc3_gadget_event_string(char *str, size_t size,
 	return str;
 }
 
-static inline void dwc3_decode_get_status(__u8 t, __u16 i, __u16 l, char *str,
-		size_t size)
-{
-	switch (t & USB_RECIP_MASK) {
-	case USB_RECIP_INTERFACE:
-		snprintf(str, size, "Get Interface Status(Intf = %d, Length = %d)",
-				i, l);
-		break;
-	case USB_RECIP_ENDPOINT:
-		snprintf(str, size, "Get Endpoint Status(ep%d%s)",
-			i & ~USB_DIR_IN,
-			i & USB_DIR_IN ? "in" : "out");
-		break;
-	}
-}
-
-static inline void dwc3_decode_set_clear_feature(__u8 t, __u8 b, __u16 v,
-		__u16 i, char *str, size_t size)
-{
-	switch (t & USB_RECIP_MASK) {
-	case USB_RECIP_DEVICE:
-		snprintf(str, size, "%s Device Feature(%s%s)",
-			b == USB_REQ_CLEAR_FEATURE ? "Clear" : "Set",
-			({char *s;
-				switch (v) {
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
-			v == USB_DEVICE_TEST_MODE ?
-			({ char *s;
-				switch (i) {
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
-		break;
-	case USB_RECIP_INTERFACE:
-		snprintf(str, size, "%s Interface Feature(%s)",
-			b == USB_REQ_CLEAR_FEATURE ? "Clear" : "Set",
-			v == USB_INTRF_FUNC_SUSPEND ?
-			"Function Suspend" : "UNKNOWN");
-		break;
-	case USB_RECIP_ENDPOINT:
-		snprintf(str, size, "%s Endpoint Feature(%s ep%d%s)",
-			b == USB_REQ_CLEAR_FEATURE ? "Clear" : "Set",
-			v == USB_ENDPOINT_HALT ? "Halt" : "UNKNOWN",
-			i & ~USB_DIR_IN,
-			i & USB_DIR_IN ? "in" : "out");
-		break;
-	}
-}
-
-static inline void dwc3_decode_set_address(__u16 v, char *str, size_t size)
-{
-	snprintf(str, size, "Set Address(Addr = %02x)", v);
-}
-
-static inline void dwc3_decode_get_set_descriptor(__u8 t, __u8 b, __u16 v,
-		__u16 i, __u16 l, char *str, size_t size)
-{
-	snprintf(str, size, "%s %s Descriptor(Index = %d, Length = %d)",
-		b == USB_REQ_GET_DESCRIPTOR ? "Get" : "Set",
-		({ char *s;
-			switch (v >> 8) {
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
-			} s; }), v & 0xff, l);
-}
-
-
-static inline void dwc3_decode_get_configuration(__u16 l, char *str,
-		size_t size)
-{
-	snprintf(str, size, "Get Configuration(Length = %d)", l);
-}
-
-static inline void dwc3_decode_set_configuration(__u8 v, char *str, size_t size)
-{
-	snprintf(str, size, "Set Configuration(Config = %d)", v);
-}
-
-static inline void dwc3_decode_get_intf(__u16 i, __u16 l, char *str,
-		size_t size)
-{
-	snprintf(str, size, "Get Interface(Intf = %d, Length = %d)", i, l);
-}
-
-static inline void dwc3_decode_set_intf(__u8 v, __u16 i, char *str, size_t size)
-{
-	snprintf(str, size, "Set Interface(Intf = %d, Alt.Setting = %d)", i, v);
-}
-
-static inline void dwc3_decode_synch_frame(__u16 i, __u16 l, char *str,
-		size_t size)
-{
-	snprintf(str, size, "Synch Frame(Endpoint = %d, Length = %d)", i, l);
-}
-
-static inline void dwc3_decode_set_sel(__u16 l, char *str, size_t size)
-{
-	snprintf(str, size, "Set SEL(Length = %d)", l);
-}
-
-static inline void dwc3_decode_set_isoch_delay(__u8 v, char *str, size_t size)
-{
-	snprintf(str, size, "Set Isochronous Delay(Delay = %d ns)", v);
-}
-
-/**
- * dwc3_decode_ctrl - returns a string represetion of ctrl request
- */
-static inline const char *dwc3_decode_ctrl(char *str, size_t size,
-		__u8 bRequestType, __u8 bRequest, __u16 wValue, __u16 wIndex,
-		__u16 wLength)
-{
-	switch (bRequest) {
-	case USB_REQ_GET_STATUS:
-		dwc3_decode_get_status(bRequestType, wIndex, wLength, str,
-				size);
-		break;
-	case USB_REQ_CLEAR_FEATURE:
-	case USB_REQ_SET_FEATURE:
-		dwc3_decode_set_clear_feature(bRequestType, bRequest, wValue,
-				wIndex, str, size);
-		break;
-	case USB_REQ_SET_ADDRESS:
-		dwc3_decode_set_address(wValue, str, size);
-		break;
-	case USB_REQ_GET_DESCRIPTOR:
-	case USB_REQ_SET_DESCRIPTOR:
-		dwc3_decode_get_set_descriptor(bRequestType, bRequest, wValue,
-				wIndex, wLength, str, size);
-		break;
-	case USB_REQ_GET_CONFIGURATION:
-		dwc3_decode_get_configuration(wLength, str, size);
-		break;
-	case USB_REQ_SET_CONFIGURATION:
-		dwc3_decode_set_configuration(wValue, str, size);
-		break;
-	case USB_REQ_GET_INTERFACE:
-		dwc3_decode_get_intf(wIndex, wLength, str, size);
-		break;
-	case USB_REQ_SET_INTERFACE:
-		dwc3_decode_set_intf(wValue, wIndex, str, size);
-		break;
-	case USB_REQ_SYNCH_FRAME:
-		dwc3_decode_synch_frame(wIndex, wLength, str, size);
-		break;
-	case USB_REQ_SET_SEL:
-		dwc3_decode_set_sel(wLength, str, size);
-		break;
-	case USB_REQ_SET_ISOCH_DELAY:
-		dwc3_decode_set_isoch_delay(wValue, str, size);
-		break;
-	default:
-		snprintf(str, size, "%02x %02x %02x %02x %02x %02x %02x %02x",
-			bRequestType, bRequest,
-			cpu_to_le16(wValue) & 0xff,
-			cpu_to_le16(wValue) >> 8,
-			cpu_to_le16(wIndex) & 0xff,
-			cpu_to_le16(wIndex) >> 8,
-			cpu_to_le16(wLength) & 0xff,
-			cpu_to_le16(wLength) >> 8);
-	}
-
-	return str;
-}
-
 /**
  * dwc3_ep_event_string - returns event name
  * @event: then event code
diff --git a/drivers/usb/dwc3/trace.h b/drivers/usb/dwc3/trace.h
index 5d479c508cb5..32196b9bc45b 100644
--- a/drivers/usb/dwc3/trace.h
+++ b/drivers/usb/dwc3/trace.h
@@ -86,7 +86,7 @@ DECLARE_EVENT_CLASS(dwc3_log_ctrl,
 		__entry->wIndex = le16_to_cpu(ctrl->wIndex);
 		__entry->wLength = le16_to_cpu(ctrl->wLength);
 	),
-	TP_printk("%s", dwc3_decode_ctrl(__get_str(str), DWC3_MSG_MAX,
+	TP_printk("%s", usb_decode_ctrl(__get_str(str), DWC3_MSG_MAX,
 					__entry->bRequestType,
 					__entry->bRequest, __entry->wValue,
 					__entry->wIndex, __entry->wLength)
diff --git a/include/linux/usb/ch9.h b/include/linux/usb/ch9.h
index 523aa088f6ab..db21b11bec6e 100644
--- a/include/linux/usb/ch9.h
+++ b/include/linux/usb/ch9.h
@@ -62,4 +62,29 @@ extern enum usb_device_speed usb_get_maximum_speed(struct device *dev);
  */
 extern const char *usb_state_string(enum usb_device_state state);
 
+/**
+ * usb_decode_ctrl - Returns human readable representation of control request.
+ * @str: buffer to return a human-readable representation of control request.
+ *       This buffer should have about 200 bytes.
+ * @size: size of str buffer.
+ * @bRequestType: matches the USB bmRequestType field
+ * @bRequest: matches the USB bRequest field
+ * @wValue: matches the USB wValue field (CPU byte order)
+ * @wIndex: matches the USB wIndex field (CPU byte order)
+ * @wLength: matches the USB wLength field (CPU byte order)
+ *
+ * Function returns decoded, formatted and human-readable description of
+ * control request packet.
+ *
+ * The usage scenario for this is for tracepoints, so function as a return
+ * use the same value as in parameters. This approach allows to use this
+ * function in TP_printk
+ *
+ * Important: wValue, wIndex, wLength parameters before invoking this function
+ * should be processed by le16_to_cpu macro.
+ */
+const char *usb_decode_ctrl(char *str, size_t size, __u8 bRequestType,
+			    __u8 bRequest, __u16 wValue, __u16 wIndex,
+			    __u16 wLength);
+
 #endif /* __LINUX_USB_CH9_H */
-- 
2.17.1

