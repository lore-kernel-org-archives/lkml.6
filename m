Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id vxT7N41LGFvNFQAAmS7hNA
	; Wed, 06 Jun 2018 21:02:13 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 990146089E; Wed,  6 Jun 2018 21:02:13 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="MSdVJy4i"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id C18F2605BD;
	Wed,  6 Jun 2018 21:02:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C18F2605BD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752779AbeFFVCK (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 17:02:10 -0400
Received: from mail-sg2apc01on0097.outbound.protection.outlook.com ([104.47.125.97]:28672
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752030AbeFFVCI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 17:02:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ati5OK0PIsdhI/p8QXW5f8D4vKbHgkedqnBFSLwSMbQ=;
 b=MSdVJy4ijaMCndNROB4L+6v/C+zhhxyg3aeoQ7iUIGm3TvV7Qla6PZV+BylDL54j+29Peqz3VmYQUWbOMsavUbC0uDLk+39Xzgnd1GiVoWOGNPKo3Q35BCHDGj557SoC9x4l6M3x8WO73cEGrXQrtlaBUGIG8zImbyJFw+Y0smM=
Received: from KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM (10.170.167.17) by
 KL1P15301MB0005.APCP153.PROD.OUTLOOK.COM (10.170.167.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.2; Wed, 6 Jun 2018 21:01:52 +0000
Received: from KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM ([10.170.167.17]) by
 KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM ([10.170.167.17]) with mapi id
 15.20.0863.004; Wed, 6 Jun 2018 21:01:52 +0000
From: Dexuan Cui <decui@microsoft.com>
To: KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
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
Subject: [PATCH] hv_netvsc: Fix a network regression after ifdown/ifup
Thread-Topic: [PATCH] hv_netvsc: Fix a network regression after ifdown/ifup
Thread-Index: AdP92N4EqgEj8nWJRA2EB/lO8D4XFg==
Date: Wed, 6 Jun 2018 21:01:52 +0000
Message-ID: <KL1P15301MB00068D69392E04C10AB596AABF650@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-06-06T21:01:34.8727497Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com;
x-originating-ip: [2001:4898:80e8:0:512f:6303:d09e:a11f]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;KL1P15301MB0005;7:R5Xky5fUTyCSu9YObPRBywOx+B0faxVJu1yH6Y+NYwkapvyhy0SAzp9tKQcnMeuPObLASeITFq8nmiGAdI0OQf1JprNwCx0Lw+95+mf5IfO+0o3jQ/Li9dshNBD0ulH3jI69X5RK6WtGgAdjQMwcNozVJlVntrnsOMwicRRGkhF/ay7/LM0A0mPGZQIyV48CsimmC9D8lIVJuw/QMhkYseVQmdPSCDhR9weql9v7TYZ6DTZaTYrvNxxylvS5OXZY
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(2017052603328)(7193020);SRVR:KL1P15301MB0005;
x-ms-traffictypediagnostic: KL1P15301MB0005:
x-microsoft-antispam-prvs: <KL1P15301MB00055D74763E6AE7819DE869BF650@KL1P15301MB0005.APCP153.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(944501410)(52105095)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:KL1P15301MB0005;BCL:0;PCL:0;RULEID:;SRVR:KL1P15301MB0005;
x-forefront-prvs: 06952FC175
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(346002)(396003)(39850400004)(39380400002)(189003)(199004)(105586002)(106356001)(1857600001)(5890100001)(2501003)(99286004)(77096007)(59450400001)(6506007)(33656002)(102836004)(7696005)(8990500004)(81166006)(81156014)(4326008)(8676002)(8936002)(10090500001)(9686003)(25786009)(7736002)(305945005)(3280700002)(3660700001)(10290500003)(107886003)(478600001)(53936002)(74316002)(68736007)(6116002)(2906002)(14454004)(2900100001)(54906003)(110136005)(5660300001)(55016002)(6436002)(97736004)(316002)(486006)(476003)(46003)(86362001)(575784001)(22452003)(86612001)(1511001);DIR:OUT;SFP:1102;SCL:1;SRVR:KL1P15301MB0005;H:KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: lcJQoleexnfgGgK8m37hsgRbZ1FqUlcda0EGE5N1SRL83xEadKKHU1lJQLgRi9gpfpfh3IhFOY4LlkSoRsbT1PospIt9kY2hizGUuanLVFaX6hqC3H6y7DVn4//w+H4MQvgvimhaT9OYI+2R7lyKoJLbmPAn5TAfUF8DyQojxLqzu8FQcQ61a41J1KpKAKfr
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 47cb9da9-6a75-4042-b702-08d5cbf0ba94
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47cb9da9-6a75-4042-b702-08d5cbf0ba94
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2018 21:01:52.0416
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1P15301MB0005
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Recently people reported the NIC stops working after
"ifdown eth0; ifup eth0". It turns out in this case the TX queues are not
enabled, after the refactoring of the common detach logic. The patch fixes
the regression.

Fixes: 7b2ee50c0cd5 ("hv_netvsc: common detach logic")
Signed-off-by: Dexuan Cui <decui@microsoft.com>
Cc: stable@vger.kernel.org
Cc: Stephen Hemminger <sthemmin@microsoft.com>
Cc: K. Y. Srinivasan <kys@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/net/hyperv/netvsc_drv.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_dr=
v.c
index da07ccd..4461e16 100644
--- a/drivers/net/hyperv/netvsc_drv.c
+++ b/drivers/net/hyperv/netvsc_drv.c
@@ -126,9 +126,20 @@ static int netvsc_open(struct net_device *net)
 	}
=20
 	rdev =3D nvdev->extension;
-	if (!rdev->link_state)
+	if (!rdev->link_state) {
 		netif_carrier_on(net);
=20
+		/* When the NIC has sub-channels, usually we enable all the
+		 * TX queues after all sub-channels are set up: see
+		 * rndis_set_subchannel() -> netif_device_attach(), but in
+		 * the case of "ifdown eth0; ifup eth0" where the number of
+		 * channels doesn't change, we also must make sure the
+		 * TX queues are enabled.
+		 */
+		if (atomic_read(&nvdev->open_chn) =3D=3D nvdev->num_chn)
+			netif_tx_wake_all_queues(net);
+	}
+
 	if (vf_netdev) {
 		/* Setting synthetic device up transparently sets
 		 * slave as up. If open fails, then slave will be
--=20
2.7.4
