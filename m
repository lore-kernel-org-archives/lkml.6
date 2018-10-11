Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9171C28CF8
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 22:31:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5490B2077C
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 22:31:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="TlhY8+UA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5490B2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbeJLGAW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 02:00:22 -0400
Received: from mail-eopbgr720114.outbound.protection.outlook.com ([40.107.72.114]:39008
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725911AbeJLGAV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 02:00:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6PTHnGLDYuf4HL56VpLCCywuIBfSzNtmo/H/+C5RrwE=;
 b=TlhY8+UAajA0hRaLrs4KSJqh459q8fUUNzThUkKlSec4rniI/zCaFSOLWlUGzXuslL+rfRIfFZr//1LAUJlJNhVK9HDiltDOJTn5i5b/yvCPR4KkKlh6xa1qMANCxveeRatHQCeg5m6BLoQHITgmD9KWPjejbgRIn9uZ1DaU8sY=
Received: from MWHPR21MB0176.namprd21.prod.outlook.com (10.173.52.22) by
 MWHPR21MB0702.namprd21.prod.outlook.com (10.175.142.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.4; Thu, 11 Oct 2018 22:30:59 +0000
Received: from MWHPR21MB0176.namprd21.prod.outlook.com
 ([fe80::8817:5ea6:f97f:aa10]) by MWHPR21MB0176.namprd21.prod.outlook.com
 ([fe80::8817:5ea6:f97f:aa10%2]) with mapi id 15.20.1250.004; Thu, 11 Oct 2018
 22:30:59 +0000
From:   Haiyang Zhang <haiyangz@microsoft.com>
To:     Haiyang Zhang <haiyangz@microsoft.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC:     KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "olaf@aepfle.de" <olaf@aepfle.de>, vkuznets <vkuznets@redhat.com>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next] hv_netvsc: fix vf serial matching with pci slot
 info
Thread-Topic: [PATCH net-next] hv_netvsc: fix vf serial matching with pci slot
 info
Thread-Index: AQHUYZ8xRe87/5A0vEmtKRlG+pA7h6UaoB1w
Date:   Thu, 11 Oct 2018 22:30:59 +0000
Message-ID: <MWHPR21MB0176EB148DC772F9DC5845D2CAE10@MWHPR21MB0176.namprd21.prod.outlook.com>
References: <20181011201434.30737-1-haiyangz@linuxonhyperv.com>
In-Reply-To: <20181011201434.30737-1-haiyangz@linuxonhyperv.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=haiyangz@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-10-11T22:30:55.1931300Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [96.61.92.94]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR21MB0702;6:K9Qn+NenUz3XbH0bSn2eUc+PWsN7G9PzfE2WBsEgrzhIqOsHAcmJVRZXkoaPBEWQdkkJDmIZ8N5/eolAVP9U6xZtpm5f+IE2Y28/VSmA/u4y33wUYSssvmosBIDdIVA86Bi/f7Er6FGsvEIWEHhJrPAJNVAn6vf9WlwyUWdB6e92K7maDTxRlAOoxA15y7Lg6ygAYMNeRzJlwimLnrp0kLZQ8rfxt3rrsION/ddQ6+ienfDRMfHQ+R26GQEgdockaOfnqHp0UtRxwbpSG2U8SLN8J6fz0Q5bLPz8yJELJDwd4qQeZDqWsLr9TFXk9gHDpENSg8Y1JbLFvfmkrYxTbrktdNpmODSjblDTalL5kXkeEmNN59sZqxwWG8bDoalSC2LzNmhDVxgPc7ElSaDMH8d7Loba8xIaZepdW7k9VYTDVn+ch9qAlVXteb+5tLCZt0bhe5pB+bFEe8Lr+D1ZDQ==;5:TSQoj5HhU768Fek7OSbsknLsHa7W/q2UGK+bmprSoK9vT1/Y72nmhuu/mPBgTO47IyRG0Bw232nUHIHFM1I++3fMQPBMJu8f3t/LYYPJZZyFUDx/pccR3oU4jyt0nGgmFrX8ADDAdQuGI36iSWVfWKwoFQB7GrW2C1EBJnKE4hQ=;7:wR4YmhSyJO77LmAZteiAUoMbWdJECCrwqk39jda0/9OQpX90sR208oquzrC+2j1HfFzPZW2BGO90BLZ5ZKq+nv9TpqBduRQPWk2grB1u7irl0NXhCFJSzNLxh0WgC3LtFW3Cr+yAIOucSW2DNnYXO+i9qGZRt2ZuXEzjzn8Vd5RE/BCiFZYXOepQYWDgGfH2ffATj3PTClA5dGyn3LAhpKb8X7BAtvsmnRRsshmfdnAOEzGEmNsyBIo0ZQk3Fo+I
x-ms-office365-filtering-correlation-id: 452fd8fa-85cc-4f33-00ec-08d62fc93828
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:MWHPR21MB0702;
x-ms-traffictypediagnostic: MWHPR21MB0702:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MWHPR21MB070230A62B7EBCAB7B1B42D9CAE10@MWHPR21MB0702.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(6055026)(149066)(150057)(6041310)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699051)(76991066);SRVR:MWHPR21MB0702;BCL:0;PCL:0;RULEID:;SRVR:MWHPR21MB0702;
x-forefront-prvs: 08220FA8D6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(376002)(346002)(39860400002)(396003)(366004)(199004)(40224003)(189003)(13464003)(4326008)(14454004)(11346002)(86362001)(2201001)(6506007)(86612001)(6116002)(68736007)(8936002)(53546011)(22452003)(76176011)(102836004)(6346003)(446003)(74316002)(256004)(305945005)(26005)(14444005)(476003)(97736004)(7696005)(9686003)(81156014)(55016002)(486006)(316002)(186003)(8990500004)(66066001)(8676002)(7736002)(53936002)(3846002)(81166006)(6436002)(1511001)(5250100002)(54906003)(99286004)(6246003)(5660300001)(229853002)(2900100001)(478600001)(10290500003)(33656002)(71190400001)(2501003)(106356001)(25786009)(2906002)(71200400001)(105586002)(110136005)(10090500001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR21MB0702;H:MWHPR21MB0176.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=haiyangz@microsoft.com; 
x-microsoft-antispam-message-info: vvkhkokSLcVmCtwWyU9S/YaXpmSxckOqHude1ULfawraAy30tqJZLPpbjjCkDzOENTKDiAAJuBmFHoFkXiAoFgX++73W8qQZPs9LxkDmZhq0tXRvBnqKR7FAQYifL+7/jX3Bb6XhOIcZhCb4tBKFu9mkEgodICl75GmJb7VJYzjEK4hkwv4MFYBYh/MrO+5sMsQnmJ2aczzl2apzOS5gtNSAQJxapB8qa8uvqXIB9iiws1f0DcpgTtxmAbRVMfaPJ/wGjwANMe7CQPgxx6hX49bSY/CPD+AGYgyDqrVIMDFe+mkou8tagb01kiJitqNobT+izB+dmHvep/4xKDeqyylyQmdJtI6J5IpqnKz8Zjw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 452fd8fa-85cc-4f33-00ec-08d62fc93828
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2018 22:30:59.5331
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR21MB0702
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Haiyang Zhang <haiyangz@linuxonhyperv.com>
> Sent: Thursday, October 11, 2018 4:15 PM
> To: davem@davemloft.net; netdev@vger.kernel.org
> Cc: Haiyang Zhang <haiyangz@microsoft.com>; KY Srinivasan
> <kys@microsoft.com>; Stephen Hemminger <sthemmin@microsoft.com>;
> olaf@aepfle.de; vkuznets <vkuznets@redhat.com>;
> devel@linuxdriverproject.org; linux-kernel@vger.kernel.org
> Subject: [PATCH net-next] hv_netvsc: fix vf serial matching with pci slot=
 info
>=20
> From: Haiyang Zhang <haiyangz@microsoft.com>
>=20
> The VF device's serial number is saved as a string in PCI slot's kobj nam=
e, not
> the slot->number. This patch corrects the netvsc driver, so the VF device=
 can be
> successfully paired with synthetic NIC.
>=20
> Fixes: 00d7ddba1143 ("hv_netvsc: pair VF based on serial number")
> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>

Thanks Stephen for the reminder -- I added the "reported-by" here:

Reported-by: Vitaly Kuznetsov <vkuznets@redhat.com>
