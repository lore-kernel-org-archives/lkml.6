Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 350DAECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:19:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8B9B214AB
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:19:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="PFz4Uu2f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8B9B214AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730752AbeIQIo1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:44:27 -0400
Received: from mail-eopbgr690116.outbound.protection.outlook.com ([40.107.69.116]:54124
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730532AbeIQIa3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:30:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ag2WT9BvrZ6GLk6rHp71rZENL4duretgg6sNp2Dvgbc=;
 b=PFz4Uu2fb8ra0ZwOOYg6olYs1yXJ9Dgx2+WVxAFyxQquPYv7+W8OUMiRN1WxQsvjGhPvi8Ds0C0Jbi4YfvSWAeuR02cv9b9RgcRGdcoyd1/vx6f4ysoZwr2UJ3UWa3dGCp9LfqliLMf8zeCBzFj6UNzcBFenmxOlJPbY4BAznOg=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0133.namprd21.prod.outlook.com (10.173.189.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.11; Mon, 17 Sep 2018 03:05:03 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:05:03 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Johan Hovold <johan@kernel.org>,
        Denis Kirjanov <kirjanov@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-edac <linux-edac@vger.kernel.org>,
        Borislav Petkov <bp@suse.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 82/87] EDAC: Fix memleak in module init error
 path
Thread-Topic: [PATCH AUTOSEL 4.14 82/87] EDAC: Fix memleak in module init
 error path
Thread-Index: AQHUTjL7wwxkVpMga0erdXbPfcgszQ==
Date:   Mon, 17 Sep 2018 03:03:17 +0000
Message-ID: <20180917030220.245686-82-alexander.levin@microsoft.com>
References: <20180917030220.245686-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030220.245686-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0133;6:hbpXq2C2s2tiXfdhcAkNL5Atqw/UVSh7WaH4dvXfmq4vgak8QMucIfC+kZLpZnU8kYjQbMtdsGakiB3V5HMHri62+6GT5taKn7ohP3iW6cFowAxOX96Xqhmo4TXdj9z+3IG6BVdbx3/XGPOlVO9ZCXFcTdOF1Mc3tUxP04+s0HcsjUbW38VEZDZpkAUjBD04VPtQ2TPjGqIBsFx3U05j3JnhLttYNa8dRz/WN3zb13uQS2V4eRG4yEL0xlYgI43bu2KILvkhXSenMD6oU4UdOi/FGqTlBF3zHa/904ZvE2tX4XgyiSXKVoByq5o2BhaN6vMb5kjsaAuR1EGTvCwi6Ms0IrhZSQVPC1uBoCWRGkVfoTkJSaf67h0mxD8Qvu5YJN7vpmae1spn76mCqYW+IjjFmamg8LiDY+TXZOUMoPJTPTlCj0zNZh7jDxaQioewKo+ALPP3tTuBewAqp9JCug==;5:978yaLWIHOx7SzoIMdUXTOWCPmnpwWP874m6yRphn9goOfMCu6wbZUrSGrQN177UHpzdqLvEWwIbDKbsYA4AVOjfjB3liDlz8vkjl5BrJDwJLPtbpZrI1QyNFSGdP/GOQgk9djlwjH1zZqH3nq6vZ4MRQFF7t0oYg1cuB0JIaDs=;7:oQrNzf27bEHOF974Ebk9yOJvrV06KVJwKm3nhKDdY2oGheGOWlKlNOYOI7U5Cu+BkNXoMiUcsDOdDZmDjyCML2eHQUc70XWTlkoYtVZHFLHIXIt5Y9vwKMVg1CpzVoHhcg3CNVYZVfLcDp74wU7HTU7UX6yntxVxBaYtYtoTRUjS6hhDRdrWssaJotq6+ey5nkDeEveG3VPRhoqDWicBgy7i95Rr1LFU0Ly+F2MobDCQ1pWfYpnu0Jilp68pFq0O
x-ms-office365-filtering-correlation-id: d775f38d-4f8b-43a8-d844-08d61c4a5cfc
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0133;
x-ms-traffictypediagnostic: CY4PR21MB0133:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB01335CC2871FBCCF3D641FA6FB1E0@CY4PR21MB0133.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(42068640409301)(85827821059158)(9452136761055)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231355)(944501410)(52105095)(2018427008)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0133;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0133;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(396003)(39860400002)(376002)(346002)(189003)(199004)(102836004)(53936002)(8676002)(486006)(476003)(3846002)(6116002)(76176011)(10290500003)(97736004)(217873002)(256004)(5660300001)(107886003)(6506007)(478600001)(39060400002)(110136005)(2501003)(10090500001)(14444005)(305945005)(7736002)(446003)(11346002)(36756003)(2906002)(1076002)(22452003)(5250100002)(2616005)(26005)(316002)(106356001)(25786009)(68736007)(86362001)(575784001)(14454004)(966005)(72206003)(105586002)(99286004)(6486002)(6306002)(6436002)(6512007)(86612001)(6666003)(81166006)(81156014)(186003)(2900100001)(54906003)(8936002)(4326008)(66066001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0133;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 01ui38fS7Qa80EWOWmCMOR2O3vGiMuk5PjWU11JvADazMO7zXTxLVrRyXBRbO0blfYx0uLCiATNy6fSnDmOySl7GdvERfZABS1w2i+bKy/QJuRXXNJPcew3Hbmz4Re9rscKQX4RV+U807QIOKJyYnd++CDgVGeQ2QzzySgcqphb5PHcJ9fdzkRmmYj9akAYd3ExjaV4AlN/9vMQH89BnMo6EJzD0TiAtzD6qVthZxGiSohn/t4YM5o/IO7IQpODGc/tKNN0RnDP9EJ3BQSja5crICZIl+e2LUDhWm5J4JGPZv5FbSSLVwSMRjczD2LJ1MYSpoVii7ptU9NoKbsBIGiPTpvj6Th1k8OJWcRiwLh8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d775f38d-4f8b-43a8-d844-08d61c4a5cfc
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:03:17.0089
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0133
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johan Hovold <johan@kernel.org>

[ Upstream commit 4708aa85d50cc6e962dfa8acf5ad4e0d290a21db ]

Make sure to use put_device() to free the initialised struct device so
that resources managed by driver core also gets released in the event of
a registration failure.

Signed-off-by: Johan Hovold <johan@kernel.org>
Cc: Denis Kirjanov <kirjanov@gmail.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-edac <linux-edac@vger.kernel.org>
Fixes: 2d56b109e3a5 ("EDAC: Handle error path in edac_mc_sysfs_init() prope=
rly")
Link: http://lkml.kernel.org/r/20180612124335.6420-1-johan@kernel.org
Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/edac/edac_mc_sysfs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/edac/edac_mc_sysfs.c b/drivers/edac/edac_mc_sysfs.c
index e4fcfa84fbd3..79c13301bf41 100644
--- a/drivers/edac/edac_mc_sysfs.c
+++ b/drivers/edac/edac_mc_sysfs.c
@@ -1097,14 +1097,14 @@ int __init edac_mc_sysfs_init(void)
=20
 	err =3D device_add(mci_pdev);
 	if (err < 0)
-		goto out_dev_free;
+		goto out_put_device;
=20
 	edac_dbg(0, "device %s created\n", dev_name(mci_pdev));
=20
 	return 0;
=20
- out_dev_free:
-	kfree(mci_pdev);
+ out_put_device:
+	put_device(mci_pdev);
  out:
 	return err;
 }
--=20
2.17.1
