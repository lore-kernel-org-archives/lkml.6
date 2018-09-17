Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 681C1ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:04:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0720F2147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:04:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="VFBIb9oJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0720F2147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730174AbeIQI3d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:29:33 -0400
Received: from mail-eopbgr710114.outbound.protection.outlook.com ([40.107.71.114]:1680
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728972AbeIQI3c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:29:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZboYD3cD18s19Lte7kiKJduchRPD3NdSMgp+XWgYE2w=;
 b=VFBIb9oJdVLE5CSgCligyZ+pxk02YOGrHKn8q7NgWNA/UUH+GZSABqVUeYMRlQjs4omvkHEhsxsfllrwLpTj4+G5n71mQxdKFz4B7Mns7ZMIRIcAEDpqwLoHO1ERRsPzuiRfMXb9kT8eoCdZF+jaBkeVQUmeQnfD43nqSQtDnvE=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.5; Mon, 17 Sep 2018 03:04:12 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:04:12 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Bart Van Assche <bart.vanassche@wdc.com>,
        Mike Christie <mchristi@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Hannes Reinecke <hare@suse.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 34/87] scsi: target/iscsi: Make
 iscsit_ta_authentication() respect the output buffer size
Thread-Topic: [PATCH AUTOSEL 4.14 34/87] scsi: target/iscsi: Make
 iscsit_ta_authentication() respect the output buffer size
Thread-Index: AQHUTjLov9NwO6s04UeLmm1YRPO4ng==
Date:   Mon, 17 Sep 2018 03:02:45 +0000
Message-ID: <20180917030220.245686-34-alexander.levin@microsoft.com>
References: <20180917030220.245686-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030220.245686-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0776;6:7jXb3O3Ij2ZjSnBAtY1g2Bmc63xbyOXppirBbgQOUyIk8KP0QdTVUKwysykr1mmEjOyeuqIj79VbVnwosXzvk1XT1Aryfj69OVFhCa22g78o9lHy7cXfDSYsw474YbN/t5DBC18jlCe1U4DeZw9DDjqWMfcjI2hnyIcdvcgnx4dkf2Y1Te/Y7y8ByL0LutW31Zs3uadzOADsIgNYSSZY9CFa3kXcDoBm5QWViJgqz4gYF7zeXaVvBA7gL4F050cBXP1+6pSG9m4aw+V6ZjAwMoh2tsyguPBjjunVlDL0NBMJjlICXVf54EOBLj8iDEA089RlehG7MwfiQqPt0G8BtzgqTEU/G/Xz8Us7OXmib8GnlcVcaXne8bsMHaovFvmJco1ZrcsSRPu/WIKpAW8WMgdZ+PDO1lApesRqYFzmMVy3wA+YOP+H7lhwgzmYWRi6jLcT+nb+Omk06y4VX5Hwxw==;5:Xac6MPt3mb0xnca510brLUlSIx5QRzxnVNHw6tfDx6ByFmK+UqPzeG1mEo0iE/e9bNraN3p+sVQTX224qex038SeI7YqkQUUIATOkHbpuiHYjxWIa2QIw13GW4hxoLjcM2Wpoo/PJ8btCyLZAhEK/LgtuSAaTl1xJMA+2e7JS4w=;7:SE8GsOB7FJ2PreIfLMGoJrj4kGitdR/+PpdCwtL07dN9Hm+I/9pRZEvIpVG42Wb9a5BYPtgsThEBjR67hbnMIU1IschDvvETGHSULxt+snNM5ztI5/MkhgTXQFPAsOEp6jiuWb11nEuPFOxryl+tIzqdVLVVD5AI2RgJ1EvAs0V5ZFwbMbsniPZIlXYmRt/XmmXZFo6AvsG6yye02iZgY+wmGkCrx+m3RJwCbQgW8cEWlw5QgcJWIdhsMbtOFvui
x-ms-office365-filtering-correlation-id: daaedad2-79ca-4c55-87cc-08d61c4a3eb3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0776;
x-ms-traffictypediagnostic: CY4PR21MB0776:
x-microsoft-antispam-prvs: <CY4PR21MB077659550EEFB8107034EE33FB1E0@CY4PR21MB0776.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(146099531331640)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0776;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0776;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(136003)(346002)(376002)(396003)(199004)(189003)(5250100002)(53936002)(72206003)(14454004)(102836004)(478600001)(4326008)(6346003)(2501003)(25786009)(6666003)(10290500003)(110136005)(54906003)(6436002)(66066001)(8936002)(316002)(107886003)(76176011)(2906002)(217873002)(6116002)(3846002)(22452003)(14444005)(6506007)(486006)(5660300001)(7736002)(2616005)(11346002)(446003)(97736004)(476003)(6486002)(105586002)(81166006)(99286004)(186003)(81156014)(575784001)(2900100001)(8676002)(86612001)(68736007)(86362001)(26005)(36756003)(305945005)(256004)(106356001)(6512007)(1076002)(10090500001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0776;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: IqBxJGrUkzrRjrb46CJwaZPIXtUjr9Gt5EApBOy362dL5UbZ0tPp8/lDRuR2o1kEGOAA2gQr5Csl+DQzR4Zw5S0AZUrirh0LUlbTYCJMp57eKkaV1OUo+YyeOqCjnqCgpAOmJU7GG2m7pIsNWIINq4xgxNW43M6iqOWrCXxfa67V2JG/kTFFNoiQjOFKw7As0xC33KGUs8zJ9M6dzR7UQWYmzm/6CB2oTmTrzwuZAEbUbgRmC+OIr3tUNdF4SLZnqmav3KOsJ5C9hsRpEitqgxOSOBr8Zeoe7fE0o2MKwHp9nSiq68es7PAomm34/4bgB17Lf03BixYAuEx8f1O9GNyBxR3SbhffyBKtA7UL7JY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: daaedad2-79ca-4c55-87cc-08d61c4a3eb3
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:02:45.5406
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0776
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bart Van Assche <bart.vanassche@wdc.com>

[ Upstream commit 35bea5c84fd13c643cce63f0b5cd4b148f8c901d ]

Fixes: e48354ce078c ("iscsi-target: Add iSCSI fabric support for target v4.=
1")
Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Reviewed-by: Mike Christie <mchristi@redhat.com>
Cc: Mike Christie <mchristi@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/target/iscsi/iscsi_target_tpg.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/target/iscsi/iscsi_target_tpg.c b/drivers/target/iscsi=
/iscsi_target_tpg.c
index 594d07a1e995..16e7516052a4 100644
--- a/drivers/target/iscsi/iscsi_target_tpg.c
+++ b/drivers/target/iscsi/iscsi_target_tpg.c
@@ -633,8 +633,7 @@ int iscsit_ta_authentication(struct iscsi_portal_group =
*tpg, u32 authentication)
 		none =3D strstr(buf1, NONE);
 		if (none)
 			goto out;
-		strncat(buf1, ",", strlen(","));
-		strncat(buf1, NONE, strlen(NONE));
+		strlcat(buf1, "," NONE, sizeof(buf1));
 		if (iscsi_update_param_value(param, buf1) < 0)
 			return -EINVAL;
 	}
--=20
2.17.1
