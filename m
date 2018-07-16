Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69BD5ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 14:03:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A7352083D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 14:03:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="EwbxMzu4";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Qa1Z6Z2i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A7352083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729357AbeGPOag (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 10:30:36 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:63914 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727652AbeGPOag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 10:30:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1531749780; x=1563285780;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=KK7TSUCiXLwQ2qud/MWDfhpydSceo3PF0lJsTK3EbmI=;
  b=EwbxMzu4kq6u6ZyzAOG3ythlO/jP4hR19LOaNKN8RWgeJz9XRSJvqzKA
   BIdgUUST3r9vgwt1cFXtSxNiglYLtIGJOm3Y5nwVkxR/GHmu575UyD6N1
   vhJMSxmWxCtYCKvyjfPJV2IkU8mL/5B1K35gfzeOwHLET/tmHAdbkf16B
   Xm7IsTfvezn1n5iVTUayEkB2lJrZ7fXOT+sfmZzSbXclzPuuh939ByC1c
   2MNJ+Ti8KuJ5XPehakPgtqS98QfKqPxWr5GBT2hZnAwBflKxgQ6lf4STe
   mr6tN/nW98wupwmcqqCUFvK5EA3E411yp2HHTZI1f0r5eowWK3wxerF3n
   w==;
X-IronPort-AV: E=Sophos;i="5.51,361,1526313600"; 
   d="scan'208";a="187643465"
Received: from mail-bl2nam02lp0087.outbound.protection.outlook.com (HELO NAM02-BL2-obe.outbound.protection.outlook.com) ([207.46.163.87])
  by ob1.hgst.iphmx.com with ESMTP; 16 Jul 2018 22:02:58 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FaQ1ueIPH7OApSHdowpfkyKkOQvj49si91Bd0GCvmb8=;
 b=Qa1Z6Z2iUut2ettPnPxTCrXN/5cyWUtwortqcZRbY6CaGlP7vvZfAd+r5KSDhuNQUuJPAYg6wm5SEen2deK6ay6wERPT6fFqKQZNCMdbX8VFkWqHI8W+Exrv7f2IJEBB1/Ukb5bQpoIy4rngo8nNl/wxiOwLU4+dey4L2FluOIc=
Received: from MWHPR04MB1198.namprd04.prod.outlook.com (10.173.48.151) by
 MWHPR04MB0367.namprd04.prod.outlook.com (10.173.48.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.18; Mon, 16 Jul 2018 14:02:52 +0000
Received: from MWHPR04MB1198.namprd04.prod.outlook.com
 ([fe80::a134:ec95:a6c0:7c44]) by MWHPR04MB1198.namprd04.prod.outlook.com
 ([fe80::a134:ec95:a6c0:7c44%4]) with mapi id 15.20.0930.022; Mon, 16 Jul 2018
 14:02:52 +0000
From:   Bart Van Assche <Bart.VanAssche@wdc.com>
To:     "vinholikatti@gmail.com" <vinholikatti@gmail.com>,
        "asutoshd@codeaurora.org" <asutoshd@codeaurora.org>,
        "sayalil@codeaurora.org" <sayalil@codeaurora.org>,
        "riteshh@codeaurora.org" <riteshh@codeaurora.org>,
        "evgreen@chromium.org" <evgreen@chromium.org>,
        "cang@codeaurora.org" <cang@codeaurora.org>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "subhashj@codeaurora.org" <subhashj@codeaurora.org>,
        "vivek.gautam@codeaurora.org" <vivek.gautam@codeaurora.org>,
        "rnayak@codeaurora.org" <rnayak@codeaurora.org>,
        "jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>
CC:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V6] scsi: ufs: Add configfs support for UFS provisioning
Thread-Topic: [PATCH V6] scsi: ufs: Add configfs support for UFS provisioning
Thread-Index: AQHUHOm+ZdO4sYPgkE+zNt5kIS4su6SR4YqA
Date:   Mon, 16 Jul 2018 14:02:52 +0000
Message-ID: <2c6a82d0fe7819c5fef3946a50a132ed1a11e71d.camel@wdc.com>
References: <1531734237-27421-1-git-send-email-sayalil@codeaurora.org>
         <1531734237-27421-2-git-send-email-sayalil@codeaurora.org>
In-Reply-To: <1531734237-27421-2-git-send-email-sayalil@codeaurora.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com; 
x-originating-ip: [174.62.111.89]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB0367;7:qodhzwBvjHwxibivQZxL7aheXRYTnDjQ/o3sxih59Ij7BorfmLOGL4+RDAUxJXTPzvNn/2ZKTNHkRk+Yk98z+gtendR1F0mNfQm1phFheci2TEAxRPzCg7v4ZLOx9/Ixcahjycd3cbJ2Biz9NroGC9RYkr/ik10JNYUqDsSu0YTP6V3Y+UMRh9gY7HyWEq3S7U8wT7rflEpOr/5qFup8z37nqc2GX8f9LsVRfd8Ft+g0/M20bOw1ep6DIjwPwx6E;20:gOIs/p+t6VWZJaEApw9HpyXsyYVZShnCY7v7mE9/J700HPKkVGFlJ334BBx11BUn/klnzKX4TZBBt6o/4RL5u6nc/VprskK/8PqePRayxr5pILvyCjaqGBKLvrxD3zeP6mgtIcF0Iafg/Z8AZRUDsf1FlLujkQ0XKyujSRsyfYI=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: d6ace361-2c0d-402d-30de-08d5eb24d296
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(48565401081)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB0367;
x-ms-traffictypediagnostic: MWHPR04MB0367:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB0367D5AAFDDB4BAA8EF6A292985D0@MWHPR04MB0367.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:MWHPR04MB0367;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB0367;
x-forefront-prvs: 073515755F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(136003)(346002)(376002)(366004)(199004)(189003)(4326008)(25786009)(39060400002)(106356001)(66066001)(99286004)(86362001)(53936002)(105586002)(6246003)(72206003)(6436002)(486006)(11346002)(476003)(6486002)(118296001)(2616005)(6512007)(7416002)(36756003)(5250100002)(14454004)(5660300001)(478600001)(2201001)(2501003)(229853002)(256004)(97736004)(6116002)(3846002)(8936002)(7736002)(102836004)(305945005)(81156014)(8676002)(81166006)(54906003)(110136005)(2906002)(68736007)(2900100001)(316002)(26005)(446003)(6506007)(186003)(76176011)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB0367;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: fM2zjfXgpozbUZKAQ8+hoBVHNai1sbSMOL4YKgXYfhV0yKBQiHByKsMX8iFsBVUt7CgMWMf+t5k9v0Ir5luX8WhhO3deYDy4d1Pfd0pN1QHO0l4Uji7iDJ0jbBUvk7s+omRjaN852Khvn8OncLDvrNP+ayRnUw0UHdYZYtH7arb7KhQIcyAllH8zuH3hvqAC+nBSNTzqjftS3vJ+XnAIkO63pf3ivKakTUDQ1qedTKqfKnT9PYR8b+jLRlEh+liMt1A6JK8Q77V4MgPVmjj2cAdpfpILQcO+tpvSjwf8wMxngVx0G2yeKtR1r0FAWT+cPyxTxaHr8JUk1fhaXfnMVee0jRwRpsmZypI7enxpSkw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-7"
Content-ID: <CD4FE2C05E3F91408CC0E10EC8BAB3DF@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6ace361-2c0d-402d-30de-08d5eb24d296
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2018 14:02:52.6490
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0367
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-07-16 at 15:13 +-0530, Sayali Lokhande wrote:
+AD4- +-		This file shows the current ufs configuration descriptor set in d=
evice.
+AD4- +-		This can be used to provision ufs device if bConfigDescrLock is 0=
.
+AD4- +-		For more details, refer 14.1.6.3 Configuration Descriptor and
+AD4- +-		Table 14-12 - Unit Descriptor configurable parameters from specs =
for
+AD4- +-		description of each configuration descriptor parameter.
+AD4- +-		Configuration descriptor buffer needs to be passed in space separ=
ated
+AD4- +-		format specificied as below:
+AD4- +-		echo +ADw-bLength+AD4- +ADw-bDescriptorIDN+AD4- +ADw-bConfDescCon=
tinue+AD4- +ADw-bBootEnable+AD4-
+AD4- +-		+ADw-bDescrAccessEn+AD4- +ADw-bInitPowerMode+AD4- +ADw-bHighPrior=
ityLUN+AD4-
+AD4- +-		+ADw-bSecureRemovalType+AD4- +ADw-bInitActiveICCLevel+AD4- +ADw-w=
PeriodicRTCUpdate+AD4-
+AD4- +-		+ADw-0Bh:0Fh+AF8-ReservedAs+AF8-0+AD4- +ADw-bLUEnable+AD4- +ADw-b=
BootLunID+AD4- +ADw-bLUWriteProtect+AD4-
+AD4- +-		+ADw-bMemoryType+AD4- +ADw-dNumAllocUnits+AD4- +ADw-bDataReliabil=
ity+AD4- +ADw-bLogicalBlockSize+AD4-
+AD4- +-		+ADw-bProvisioningType+AD4- +ADw-wContextCapabilities+AD4- +ADw-0=
Dh:0Fh+AF8-ReservedAs+AF8-0+AD4-
+AD4- +-		+AD4- /config/XXXX.ufshc/ufs+AF8-provision

I think the person who suggested to use configfs expected you to create one=
 configfs
attribute per value instead of writing a long list of values into a single =
configfs
attribute.

Bart.







