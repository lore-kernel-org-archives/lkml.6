Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87BB7C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 16:30:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4510A222B2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 16:30:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nokia.onmicrosoft.com header.i=@nokia.onmicrosoft.com header.b="lBj67NuV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404380AbfBMQ3w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 11:29:52 -0500
Received: from mail-eopbgr10091.outbound.protection.outlook.com ([40.107.1.91]:36831
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2404319AbfBMQ3s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 11:29:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kna2VtpzOEl0QRLSR/t16AVeJ3yhyryVtJ2cbOnc6Ps=;
 b=lBj67NuV5XcWT35RxvNupsjBYPPc56ktKJj8+haDn+jkji/ttYLN5JHPf8B4ckZG2SHz8UZP5w7D5mg/hVvqkdulgHthDh7hzujzjBzqd9yC/R3VQfZmyIGeMcFMnItlv+rc29V+nUbv81PNb0xw3gxkTdPfV5A/XP9+/ctLBZE=
Received: from HE1PR0702MB3675.eurprd07.prod.outlook.com (52.133.6.141) by
 HE1PR0702MB3721.eurprd07.prod.outlook.com (52.133.6.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.13; Wed, 13 Feb 2019 16:29:36 +0000
Received: from HE1PR0702MB3675.eurprd07.prod.outlook.com
 ([fe80::b49f:d20e:88d4:128]) by HE1PR0702MB3675.eurprd07.prod.outlook.com
 ([fe80::b49f:d20e:88d4:128%6]) with mapi id 15.20.1622.016; Wed, 13 Feb 2019
 16:29:36 +0000
From:   "Rantala, Tommi T. (Nokia - FI/Espoo)" <tommi.t.rantala@nokia.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hailong Liu <liu.hailong6@zte.com.cn>,
        Xiubo Li <xiubli@redhat.com>,
        Jiang Biao <jiang.biao2@zte.com.cn>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rantala, Tommi T. (Nokia - FI/Espoo)" <tommi.t.rantala@nokia.com>
Subject: [PATCH 4.14 6/8] uio: fix wrong return value from uio_mmap()
Thread-Topic: [PATCH 4.14 6/8] uio: fix wrong return value from uio_mmap()
Thread-Index: AQHUw7lOsesSnm8vj0OOLrNDcZjOGA==
Date:   Wed, 13 Feb 2019 16:29:36 +0000
Message-ID: <20190213162845.11688-7-tommi.t.rantala@nokia.com>
References: <20190213162845.11688-1-tommi.t.rantala@nokia.com>
In-Reply-To: <20190213162845.11688-1-tommi.t.rantala@nokia.com>
Accept-Language: fi-FI, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.20.1
x-clientproxiedby: HE1P191CA0019.EURP191.PROD.OUTLOOK.COM (2603:10a6:3:cf::29)
 To HE1PR0702MB3675.eurprd07.prod.outlook.com (2603:10a6:7:8d::13)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tommi.t.rantala@nokia.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [131.228.2.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 135000e5-3232-4d68-f4ad-08d691d0712a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7193020);SRVR:HE1PR0702MB3721;
x-ms-traffictypediagnostic: HE1PR0702MB3721:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;HE1PR0702MB3721;23:hes2eNv7q9kCTRWNhW74sSLdm7LunTKqMTnyB?=
 =?iso-8859-1?Q?kfLnRM+CkqCFCKKTTEXdipYZbiIT3I3pfTVprWdtG2RER9LdzUlXL5jYMf?=
 =?iso-8859-1?Q?JIM56RvuE58mEXtGE+EoilcDMooM8LQc+QeUCvWrgOLGaIVi/99w2PkhPd?=
 =?iso-8859-1?Q?I/FrX56MCjRtI7hOCfigwdf7hbxwuEoO5YiVEf2Olu1Geihth7b6vpY6ph?=
 =?iso-8859-1?Q?Hz1J4bXRMuVkPIKztBDSiBUOQN2PFBIrfnd6fvtO7fO8FtlmAN7yiOznIQ?=
 =?iso-8859-1?Q?sb9mLYeKYjYu2wi4mL8zj0dzbPiL89Bs7dQEJfbchZG5WxXFPdk4CS47s+?=
 =?iso-8859-1?Q?LkxXiNGiPiSOf5P0+O0alqeDffli4D8r/vvE4PbbSIe+BtLl8yGGFZPyHl?=
 =?iso-8859-1?Q?nn9reNRrEoWiWsdvA5qYvI0MJQw7WOzX68fI0MCbB3wmN165gT+/q0VmSG?=
 =?iso-8859-1?Q?8FvRQ9dc65BrbN5l0US8gcBaG7jFcG9VXMERFr+wdSKUhMQ+ERKCUoPSZX?=
 =?iso-8859-1?Q?H9uxekBHl1PDGTGDI9ZlngA5NwPqCmGtiLJcFstF9asL3l+hPQgHBq6CHl?=
 =?iso-8859-1?Q?gg1dg8den7nGWt2oQxqPkUiA7QkFR4xfOXBmTTa8WXo/3tGBDKeO85NoUt?=
 =?iso-8859-1?Q?548B4JhkQsUiu4n7KEavKetB3T0BWkTg2LicP0O5oLiSGIxP3PAePfGEhh?=
 =?iso-8859-1?Q?TBxJKlJAxtUwJ1XNtqRqagPA5QzcIOZcB1KbENMrC869qMSzhVjgja+O6o?=
 =?iso-8859-1?Q?cdIl3SZeoNgiZ0AsYKAZWt2MfXHtZKw1PVH6Rsmp5GmTLW43WtDf9K9eye?=
 =?iso-8859-1?Q?xfdJ+lL0iPlgUK+D2lWT1oSVoZF31K2Dee3iH5Mmd4Eowc1aVFNRXI4fqG?=
 =?iso-8859-1?Q?KS61lTipjR7/pV68iDK+6Nbb1ayDf6brsgKpDLy+smWJROcl1CjaRO34s9?=
 =?iso-8859-1?Q?ERijpP8+HWB1oDlvsBj+WU3JJeL9dDbLxscrT0PU7d48TVU/8IUSv2G+mS?=
 =?iso-8859-1?Q?jfrEc+Sm0ECD0iqFbGRON1SudUHkNJ+E/heZNIxGSvXTLGqneRdFkaH17k?=
 =?iso-8859-1?Q?3A6pgqKSjvQNf/L7V3XFRkeYDS/5rvyUK6e4iFecItE1/vmD74eokdb0PV?=
 =?iso-8859-1?Q?7yr5Sqmq53qXzN4DWs06bD0VKE05+4cwGywgx4iiFS8wBnmHc0hppzkpZ1?=
 =?iso-8859-1?Q?jqt9HHNmN0oDwKQCIhW5rPtTeqew2KqWOsGP6e0HrD+Iex6CeRFFuPrEga?=
 =?iso-8859-1?Q?H1yb3qWJXy3Nustq8otriHdKtbcJJof6DwWRJB0j/kM5ugzy2bB0UvKzOl?=
 =?iso-8859-1?Q?8git24OJTJs0c7T6+1TcHE5o/eGcbWGFxvLV3xLHYXfIuSIHtr1er0c2/0?=
 =?iso-8859-1?Q?p2/2tzuvWkO2D7St4EWWF77zLqnS+tK06h8HdAh7+bdh8KFPBrqjw=3D?=
 =?iso-8859-1?Q?=3D?=
x-microsoft-antispam-prvs: <HE1PR0702MB3721A031CF04426EB1FDDFAFB4660@HE1PR0702MB3721.eurprd07.prod.outlook.com>
x-forefront-prvs: 094700CA91
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39860400002)(346002)(376002)(396003)(366004)(199004)(189003)(2906002)(1076003)(68736007)(71190400001)(71200400001)(446003)(486006)(4326008)(4744005)(8676002)(478600001)(5640700003)(81156014)(1730700003)(97736004)(6512007)(81166006)(11346002)(105586002)(6486002)(2616005)(476003)(6916009)(106356001)(6436002)(2501003)(14444005)(256004)(36756003)(99286004)(186003)(386003)(2351001)(66066001)(50226002)(14454004)(8936002)(54906003)(3846002)(305945005)(25786009)(53936002)(102836004)(316002)(6116002)(26005)(76176011)(107886003)(52116002)(7736002)(86362001)(6506007)(103116003);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0702MB3721;H:HE1PR0702MB3675.eurprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nokia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: s+jcQ6KrnMvKSV43JWSWNpvotVRF1CcFI3iGZn521vxx7wU74uRauik9J+6xV5cVwyLF8vKSekI1lv3jovdEZaFq4CfE2KGpumrvbpVj7Tu10giGqzHPmIwYxkZmBs8GABcvCJcBpKzBmg8L9a0u0RuhxA586oRrm7WuWnHheaJVebE0bVSFKd82nwZv8BhTbGV8tRfl6Tzh15M9JZc0JPm64J0M/74IdKqkPqtIAzKJcAg2gmvCtxNnx3JYMMRVJ8YUlSkrpu3nKVBAzNyvUmIlTk2sTlABwaMI8+7qvjpiyOEv4hW79rlQT0BQ+0PTj6bsQT6bsMG3zuVhv86yZzoRNpeWCkLwI8J9RuW3XxyfCyEa1x1tniozsObdf3elel12YgIg6haTqA/iUGRvd7zX2oQ3j6b5y86Pq4KofkY=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 135000e5-3232-4d68-f4ad-08d691d0712a
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2019 16:29:35.5678
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0702MB3721
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hailong Liu <liu.hailong6@zte.com.cn>

commit e7de2590f18a272e63732b9d519250d1b522b2c4 upstream.

uio_mmap has multiple fail paths to set return value to nonzero then
goto out. However, it always returns *0* from the *out* at end, and
this will mislead callers who check the return value of this function.

Fixes: 57c5f4df0a5a0ee ("uio: fix crash after the device is unregistered")
CC: Xiubo Li <xiubli@redhat.com>
Signed-off-by: Hailong Liu <liu.hailong6@zte.com.cn>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Jiang Biao <jiang.biao2@zte.com.cn>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Tommi Rantala <tommi.t.rantala@nokia.com>
---
 drivers/uio/uio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/uio/uio.c b/drivers/uio/uio.c
index 262610192755..fed2d8fa4d4d 100644
--- a/drivers/uio/uio.c
+++ b/drivers/uio/uio.c
@@ -816,7 +816,7 @@ static int uio_mmap(struct file *filep, struct vm_area_=
struct *vma)
=20
 out:
 	mutex_unlock(&idev->info_lock);
-	return 0;
+	return ret;
 }
=20
 static const struct file_operations uio_fops =3D {
--=20
2.20.1

