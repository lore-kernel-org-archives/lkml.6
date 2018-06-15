Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 578A1C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 01:31:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2FBB208BA
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 01:31:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="jOModVBp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2FBB208BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965352AbeFOBbb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 21:31:31 -0400
Received: from mail-eopbgr730139.outbound.protection.outlook.com ([40.107.73.139]:15520
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S936073AbeFOBb3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 21:31:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3CGmQbFiOBiHr0DHAD/+Zvw5+yvXSz1l1ifyX0AI1bA=;
 b=jOModVBpMd9NsTvq524c2PEG5mrCFzGrHKH4ueP7tTiPf+5gIAY9/ZLedIyAlaI1cXzrJkgFbD+bsipzuLiCiOjxf+nMhKaEfXZajHvuhjvYQmfDgyKUr+DmNYBvCAAb8AmA30oZw+0LtiLAlAVILrb4YwhzaUxbAPAaE1B+a24=
Received: from BN6PR21MB0161.namprd21.prod.outlook.com (10.173.200.7) by
 BN6PR21MB0770.namprd21.prod.outlook.com (10.173.204.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.884.9; Fri, 15 Jun 2018 01:31:26 +0000
Received: from BN6PR21MB0161.namprd21.prod.outlook.com
 ([fe80::2869:ff90:c3c5:5528]) by BN6PR21MB0161.namprd21.prod.outlook.com
 ([fe80::2869:ff90:c3c5:5528%11]) with mapi id 15.20.0884.010; Fri, 15 Jun
 2018 01:31:26 +0000
From:   Haiyang Zhang <haiyangz@microsoft.com>
To:     David Miller <davem@davemloft.net>
CC:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next] hv_netvsc: Fix the variable sizes in ipsecv2 and
 rsc offload
Thread-Topic: [PATCH net-next] hv_netvsc: Fix the variable sizes in ipsecv2
 and rsc offload
Thread-Index: AQHUBChf605rIA+lOEWL55/YTwI5YqRgb1sAgAAY74A=
Date:   Fri, 15 Jun 2018 01:31:26 +0000
Message-ID: <BN6PR21MB01619F7846C77608A391EE5CCA7C0@BN6PR21MB0161.namprd21.prod.outlook.com>
References: <20180614213912.2889-1-haiyangz@linuxonhyperv.com>
 <20180614.170014.1767744227867675403.davem@davemloft.net>
In-Reply-To: <20180614.170014.1767744227867675403.davem@davemloft.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=haiyangz@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-06-15T01:31:24.9906945Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [69.130.166.81]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR21MB0770;7:1Nwg0a1Ms29CalU7hF+HiU/nRWXHoHlO6YXc6kOSV+7Dbq7eZXUKUIg5gcK8DrMKXLfp4k+KIDmyBf4rfw5MNQC4yKWdhXPlrSIzOHUxLjMJ2B7V7Hm6jjff0Zx3q9+uVCRsklu/97pL35d1qsbNt0og+I/rn/xqSSRHIa3hkkb4AaeRGlS0NU0nR+M53gqYbBdNwDIgyYKx41maxGhWKr/TnHctHhyDOEBCz2E+ITLP2hAzADuYCYn5k6ZeWIPL
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: d9ae7e94-9736-4c13-4c45-08d5d25fb646
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(48565401081)(2017052603328)(7193020);SRVR:BN6PR21MB0770;
x-ms-traffictypediagnostic: BN6PR21MB0770:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=haiyangz@microsoft.com; 
x-microsoft-antispam-prvs: <BN6PR21MB07701CCAE995381B808DE43FCA7C0@BN6PR21MB0770.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231254)(2018427008)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:BN6PR21MB0770;BCL:0;PCL:0;RULEID:;SRVR:BN6PR21MB0770;
x-forefront-prvs: 0704670F76
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(39380400002)(376002)(346002)(396003)(189003)(199004)(13464003)(51914003)(53936002)(86612001)(6436002)(22452003)(7696005)(3280700002)(99286004)(5660300001)(8936002)(97736004)(2900100001)(86362001)(105586002)(14454004)(74316002)(3846002)(6116002)(25786009)(316002)(76176011)(55016002)(3660700001)(6246003)(54906003)(26005)(2906002)(59450400001)(102836004)(9686003)(6916009)(66066001)(446003)(305945005)(186003)(6506007)(8676002)(229853002)(106356001)(33656002)(10090500001)(4326008)(5250100002)(81166006)(11346002)(81156014)(476003)(7736002)(486006)(8990500004)(478600001)(10290500003)(53546011)(68736007);DIR:OUT;SFP:1102;SCL:1;SRVR:BN6PR21MB0770;H:BN6PR21MB0161.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: yuoDapmqLOgdFwFDrOZKbbBz+5f2hYRlbskLrWZccgYMi00d5k16VEbwdzC1O5reLERuwcojosB2u8v1JJjxFYsv/ztMQ52Zaaj0MEO49LrxXx7IRqZtnVzxLPwowZS5YtddNPAPWWaEG1XYtLhd1e0D+9gB6V8ihWjsNwxE5rSbsAL3SxLk7tkyD0tyRogO
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9ae7e94-9736-4c13-4c45-08d5d25fb646
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2018 01:31:26.2587
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR21MB0770
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: David Miller <davem@davemloft.net>
> Sent: Thursday, June 14, 2018 8:00 PM
> To: Haiyang Zhang <haiyangz@microsoft.com>; haiyangz@linuxonhyperv.com
> Cc: netdev@vger.kernel.org; KY Srinivasan <kys@microsoft.com>; Stephen
> Hemminger <sthemmin@microsoft.com>; olaf@aepfle.de;
> vkuznets@redhat.com; devel@linuxdriverproject.org; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH net-next] hv_netvsc: Fix the variable sizes in ipsecv=
2 and
> rsc offload
>=20
>=20
> Bug fixes should be targetted at net, not net-next.  Furthermore, net-nex=
t is
> closed.

Thanks for the reminder. I just sent out the patch to "net" tree.

Thanks,
- Haiyang
