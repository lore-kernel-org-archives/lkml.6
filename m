Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id BSCsHA5TGFsWaAAAmS7hNA
	; Wed, 06 Jun 2018 21:33:11 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 5E495607F7; Wed,  6 Jun 2018 21:33:11 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="aHBozxgK"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id C41AB605BD;
	Wed,  6 Jun 2018 21:33:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C41AB605BD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752788AbeFFVdJ (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 17:33:09 -0400
Received: from mail-hk2apc01on0120.outbound.protection.outlook.com ([104.47.124.120]:64976
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752042AbeFFVdH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 17:33:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dpjp1Ian9mWmFcPvXkvhh1INl5kwPV8DiEJGZ+3ehN0=;
 b=aHBozxgKRBwM/qQSJaiACoNuk8iLGieS4sDPJKLFsHVNIAiWwq0Vl3eZ/dVv2nSkrXwQF+IAYWyWxRu+kwLmwn9IDGFo30P/6c34F+Bvo38Tt/q/qIk9adymdyeDoRZ4Q0kXe96an3ePu6LBNoYuqda6q2dLNDdB7tyi8OzAZZY=
Received: from KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM (10.170.167.17) by
 KL1P15301MB0069.APCP153.PROD.OUTLOOK.COM (10.170.168.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.2; Wed, 6 Jun 2018 21:32:52 +0000
Received: from KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM ([10.170.167.17]) by
 KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM ([10.170.167.17]) with mapi id
 15.20.0863.004; Wed, 6 Jun 2018 21:32:52 +0000
From: Dexuan Cui <decui@microsoft.com>
To: KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "'David S. Miller'" <davem@davemloft.net>,
        "'netdev@vger.kernel.org'" <netdev@vger.kernel.org>
CC: "'devel@linuxdriverproject.org'" <devel@linuxdriverproject.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'olaf@aepfle.de'" <olaf@aepfle.de>,
        "'apw@canonical.com'" <apw@canonical.com>,
        "'jasowang@redhat.com'" <jasowang@redhat.com>,
        "'vkuznets@redhat.com'" <vkuznets@redhat.com>,
        "'marcelo.cerri@canonical.com'" <marcelo.cerri@canonical.com>,
        Josh Poulson <jopoulso@microsoft.com>,
        Stephen Zarkos <Stephen.Zarkos@microsoft.com>
Subject: [PATCH v2] hv_netvsc: Fix a network regression after ifdown/ifup
Thread-Topic: [PATCH v2] hv_netvsc: Fix a network regression after ifdown/ifup
Thread-Index: AdP93aHn9TGSCyTZTpeoa5AplobU8g==
Date: Wed, 6 Jun 2018 21:32:51 +0000
Message-ID: <KL1P15301MB00062D55F01921B958359A55BF650@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-06-06T21:32:50.0440845Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com;
x-originating-ip: [2001:4898:80e8:0:512f:6303:d09e:a11f]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;KL1P15301MB0069;7:9rvn5o0z1+Yl5i5E10KSs6K9/pnDIU5vVeldQvCurFYdbNUHF49BXUvcrX9gn4U9rzNM7SVIhcNztD4BZtTXzk6jIur3Z6ZgvzWXnNAGrPv03T6RtrvMPKrTSp5Gam0unVuwwu0m5qy08GJ7fj5oqlo1udCOGIQsS/gpvjWC9Js7cYJSnBbTp80lXNQCbZWLOjiuKYp7i3c2Pw6nlul6odGvatlStqIfS9VJm70RznW+kckhx6HlsEU6bH2NmqNI
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(2017052603328)(7193020);SRVR:KL1P15301MB0069;
x-ms-traffictypediagnostic: KL1P15301MB0069:
x-microsoft-antispam-prvs: <KL1P15301MB0069F78A34DF253A66FA2B69BF650@KL1P15301MB0069.APCP153.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(944501410)(52105095)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:KL1P15301MB0069;BCL:0;PCL:0;RULEID:;SRVR:KL1P15301MB0069;
x-forefront-prvs: 06952FC175
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39840400004)(376002)(39380400002)(366004)(396003)(189003)(199004)(77096007)(81166006)(81156014)(8990500004)(54906003)(8936002)(8676002)(1511001)(2900100001)(7696005)(9686003)(110136005)(10290500003)(478600001)(74316002)(14454004)(5890100001)(6116002)(575784001)(305945005)(86362001)(105586002)(86612001)(6436002)(99286004)(68736007)(106356001)(476003)(486006)(97736004)(2906002)(53936002)(4326008)(25786009)(3280700002)(10090500001)(316002)(7736002)(102836004)(6506007)(55016002)(33656002)(46003)(22452003)(5660300001)(107886003)(59450400001)(3660700001)(491001);DIR:OUT;SFP:1102;SCL:1;SRVR:KL1P15301MB0069;H:KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: GRI5iNS4Zkl22fQaWKNNSDjfhGjVols9JbkVMMpYKMmRUdwcxJ1R0i+OgXPhr65cksTvGC0LOW0JoJX8oc52crLsqHMdOiN7HKVfLbj7IYrX1RnKZA/8gg4rrrh8WLHY/aH1Hb6HdQXZWjb4UNj8UqEa+Bd3SWaMxBW3NjPH/NZ64+Q6oBzXNzWUOx8iu4oc
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 4492acdf-cfc2-4af3-9674-08d5cbf50f35
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4492acdf-cfc2-4af3-9674-08d5cbf50f35
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2018 21:32:51.9854
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1P15301MB0069
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Recently people reported the NIC stops working after
"ifdown eth0; ifup eth0". It turns out in this case the TX queues are not
enabled, after the refactoring of the common detach logic: when the NIC
has sub-channels, usually we enable all the TX queues after all
sub-channels are set up: see rndis_set_subchannel() ->
netif_device_attach(), but in the case of "ifdown eth0; ifup eth0" where
the number of channels doesn't change, we also must make sure the TX queues
are enabled. The patch fixes the regression.

Fixes: 7b2ee50c0cd5 ("hv_netvsc: common detach logic")
Signed-off-by: Dexuan Cui <decui@microsoft.com>
Cc: stable@vger.kernel.org
Cc: Stephen Hemminger <sthemmin@microsoft.com>
Cc: K. Y. Srinivasan <kys@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
---

Changes since v1:
Removed the check and the comment from the code [Stephen Hemminger]

 drivers/net/hyperv/netvsc_drv.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_dr=
v.c
index da07ccd..eb8dccd 100644
--- a/drivers/net/hyperv/netvsc_drv.c
+++ b/drivers/net/hyperv/netvsc_drv.c
@@ -126,8 +126,10 @@ static int netvsc_open(struct net_device *net)
 	}
=20
 	rdev =3D nvdev->extension;
-	if (!rdev->link_state)
+	if (!rdev->link_state) {
 		netif_carrier_on(net);
+		netif_tx_wake_all_queues(net);
+	}
=20
 	if (vf_netdev) {
 		/* Setting synthetic device up transparently sets
--=20
2.7.4
