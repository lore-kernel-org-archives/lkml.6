Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id lkYDJshPGFuTNwAAmS7hNA
	; Wed, 06 Jun 2018 21:19:04 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 8121560290; Wed,  6 Jun 2018 21:19:04 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="dnYOclrt"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 142FA607E4;
	Wed,  6 Jun 2018 21:19:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 142FA607E4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752257AbeFFVTA (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 17:19:00 -0400
Received: from mail-hk2apc01on0090.outbound.protection.outlook.com ([104.47.124.90]:26850
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752055AbeFFVS7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 17:18:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pJbtE+HYc604WNjVY16xs3yZIo7p0AaL+wR5UWqf7/w=;
 b=dnYOclrtUuVs6Hcx1hASNBVizAT6ZkMA9rIxurV11QosvYnaUMP+Oio7qsBvas8mnRTX+K62Cw6Z9PK4v4JpX4b+6j7e4IH+4fZ+noHfgzIE4z7C1e1/Z6KKpSQzvIYXzyFOyThWF1O41w9cxK95G9clymIKxQHSwkOF7RY8vJ8=
Received: from KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM (10.170.167.17) by
 KL1P15301MB0071.APCP153.PROD.OUTLOOK.COM (10.170.168.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.2; Wed, 6 Jun 2018 21:18:30 +0000
Received: from KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM ([10.170.167.17]) by
 KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM ([10.170.167.17]) with mapi id
 15.20.0863.004; Wed, 6 Jun 2018 21:18:30 +0000
From: Dexuan Cui <decui@microsoft.com>
To: Stephen Hemminger <sthemmin@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "David S. Miller" <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "'olaf@aepfle.de'" <olaf@aepfle.de>,
        "'apw@canonical.com'" <apw@canonical.com>,
        "'jasowang@redhat.com'" <jasowang@redhat.com>,
        "'vkuznets@redhat.com'" <vkuznets@redhat.com>,
        "'marcelo.cerri@canonical.com'" <marcelo.cerri@canonical.com>,
        Josh Poulson <jopoulso@microsoft.com>,
        Stephen Zarkos <Stephen.Zarkos@microsoft.com>
Subject: RE: [PATCH] hv_netvsc: Fix a network regression after ifdown/ifup
Thread-Topic: [PATCH] hv_netvsc: Fix a network regression after ifdown/ifup
Thread-Index: AdP92N4EqgEj8nWJRA2EB/lO8D4XFgAAWMTeAABYEyA=
Date: Wed, 6 Jun 2018 21:18:29 +0000
Message-ID: <KL1P15301MB0006B0675E39FFCC78124A2BBF650@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
References: <KL1P15301MB00068D69392E04C10AB596AABF650@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
 <MW2PR2101MB1129F05634300DD074529FFDCC650@MW2PR2101MB1129.namprd21.prod.outlook.com>
In-Reply-To: <MW2PR2101MB1129F05634300DD074529FFDCC650@MW2PR2101MB1129.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-06-06T21:18:26.6347799Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com;
x-originating-ip: [2001:4898:80e8:0:512f:6303:d09e:a11f]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;KL1P15301MB0071;7:gBCB02Dr0zidCjr+lp3dnaODFTiGvI0ffR0AJgkJfE+2Tp3SLVnmhlOClr6iVLhVoPCWUzL5gIGStx58mNctfs+tICpOYi+Spqa57sAMh7FZcp5VErowHvIW4XGVToLm/B92wJJ4gHTuoxBDxw7eX2TaRSebL0BRGhs1ux8vbUi0ZATs9iPIfz6NQlRg6QUqag4A+cFKy2vgylV50WWZI39qSHlaNI/tnG2OLa5WuDx3Rrrt+YbDKrMcwMuBJgqr
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(2017052603328)(7193020);SRVR:KL1P15301MB0071;
x-ms-traffictypediagnostic: KL1P15301MB0071:
x-microsoft-antispam-prvs: <KL1P15301MB0071B407B32929C818D3D033BF650@KL1P15301MB0071.APCP153.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(944501410)(52105095)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:KL1P15301MB0071;BCL:0;PCL:0;RULEID:;SRVR:KL1P15301MB0071;
x-forefront-prvs: 06952FC175
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(39850400004)(39380400002)(396003)(366004)(199004)(189003)(8936002)(110136005)(54906003)(558084003)(316002)(10090500001)(22452003)(6116002)(86362001)(1511001)(3660700001)(478600001)(46003)(86612001)(10290500003)(11346002)(5660300001)(446003)(486006)(476003)(3280700002)(2906002)(14454004)(6506007)(105586002)(33656002)(99286004)(76176011)(107886003)(7696005)(2501003)(53936002)(9686003)(68736007)(55016002)(6246003)(229853002)(77096007)(102836004)(97736004)(2900100001)(81156014)(25786009)(8990500004)(106356001)(8676002)(74316002)(4326008)(305945005)(81166006)(6436002)(7736002);DIR:OUT;SFP:1102;SCL:1;SRVR:KL1P15301MB0071;H:KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: ZtJEyezSl+wqarW99Ap9ruNqd6JcA7CcQNG5vDOSZSAKcQ6JUDMRwfs4W7SfSiNJjS3oBVakVWSA7IKfvwccjJybMHkbmPe63kVNWPNPCHxPAkh3jo6DJ8OzKoZQRbAgF/0xO9p8uuYjfPKwVyiUhvSOlW1BcNBfCAIUTEn0gprJ144YKhtXiz16tDKh4aNI
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: a62ab277-ee0a-4e6a-cc50-08d5cbf30d23
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a62ab277-ee0a-4e6a-cc50-08d5cbf30d23
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2018 21:18:29.4889
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1P15301MB0071
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Stephen Hemminger=20
> Sent: Wednesday, June 6, 2018 14:07
> ...
> Ok, just skip the check and big comment.
> wake all queues is harmless if they are already awake.

Ok, I'll post a v2 without the check and the comment shortly.

-- Dexuan
