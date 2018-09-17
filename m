Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01931ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:01:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2EB0214C5
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:01:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="KDTVJi45"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2EB0214C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728976AbeIQI0b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:26:31 -0400
Received: from mail-eopbgr710095.outbound.protection.outlook.com ([40.107.71.95]:52685
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728957AbeIQI0a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:26:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ud73jCORez6KXiYGGtObrXKDfJFjuurN1VJcYG4zHZA=;
 b=KDTVJi452Z0/2LS6xzsknG5cZWBGVV/p0jcvVqDJQBnYeUOCFMaKQnh0ZXZjwmEFb1qbOKb2EbCIFN69ZejKOr0cuuEnbEDI/Prp0uRS6H5M3GvyP9u9fwAM+5EAOnXNkADpDWZrNMu+sOxqbFLRkD/9/PkEevtwoorw3OSLlKc=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0167.namprd21.prod.outlook.com (10.173.192.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.12; Mon, 17 Sep 2018 03:01:11 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:01:11 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Bart Van Assche <bart.vanassche@wdc.com>,
        Mike Christie <mchristi@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Hannes Reinecke <hare@suse.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 047/136] scsi: target/iscsi: Make
 iscsit_ta_authentication() respect the output buffer size
Thread-Topic: [PATCH AUTOSEL 4.18 047/136] scsi: target/iscsi: Make
 iscsit_ta_authentication() respect the output buffer size
Thread-Index: AQHUTjKe5wnsFKQDjUWV9h+Odr7FxQ==
Date:   Mon, 17 Sep 2018 03:00:41 +0000
Message-ID: <20180917030006.245495-47-alexander.levin@microsoft.com>
References: <20180917030006.245495-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030006.245495-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0167;6:6hxcqscg8fSF1fvICv88LwF146zycWvllO8QmTzdYC+nm4FNA4HvhCwxCTSrof9PHzhSmGl8MeTI2hPBmLX9wZKHD8rkoOZS/E+D3UtOzhVvYjV8F3KpC0IFgG5EnUxZsiCnBNde+FKZVBWMucxGhQzzVpWYWw/lkmOUxTeo7Qjga0TjhSj7eusGfQJQQn/iHs3fNpwI7a1AH48G9fl+9RxkAxIzJdVrY+ahbB/6VarvNTtv5toKXgKER32ldzd5rqp2VODqEiWXQuHzo+6HNRVwZDmp+Uiy0OV8PmI/mOk8Q+i7JUD2ZE+8w8lMEpR2/RhU+l3GIxxzEt5ZIuVSAHHe9Ouab7wdiVWFrFJnHn+tzIchubaahM+0jJNg0dER4bIbZHebYCV2j/JhX1U5wlXSCOtbwqEuWyOAO8yfOo4tJYoEXUA2XcjJChJKaWJNyVKWTWEW4BaAURt0QYtMng==;5:QRdelvPDdS2QdZbJubDfK1OiikAsd0x9DApeG6M860wWPNPU8W2yIH1Uace6DMji0+uun/KZL6PpgNPXOSv9N3mxZzjGb/r74q/ENw6ePVbr9OUzbCYMtS+7c6j+2ABnhGKahRR+Dgvslc4quVfV4tdojBZL1uanNuzsar+OWN4=;7:OnekSIGUoaa8Gr34bH8AHvvu6yyWAqQ4Hbhe49JAfrnrMPUP6stIyGs3Pp+RVa/J3Zc44AYdJ/gIJ+CZxVr6hmCvGv7mccapXZY9jxLV5KSG2quMe9kVcrxnqYgGh/SIGkowPgLJHeVnubIGUznFbVSWif48knwLHfI7qwA6nTbGuF7CoJiEfpV7WZuqKVhKYx1iRJUzdqsv45Yyh/6ta6FqLzT6DdntBx7OxiM/OCI9xXzz8rGJZeOzkmQWPK2Z
x-ms-office365-filtering-correlation-id: efb49774-4e83-4d98-d7c3-08d61c49d2b4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0167;
x-ms-traffictypediagnostic: CY4PR21MB0167:
x-microsoft-antispam-prvs: <CY4PR21MB0167D90EE589CE7DB33E359EFB1E0@CY4PR21MB0167.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(146099531331640)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0167;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0167;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(366004)(346002)(136003)(39860400002)(199004)(189003)(6116002)(1076002)(86612001)(4326008)(97736004)(53936002)(2900100001)(7736002)(107886003)(106356001)(10290500003)(81166006)(105586002)(68736007)(3846002)(99286004)(305945005)(36756003)(8936002)(2906002)(217873002)(54906003)(575784001)(86362001)(110136005)(25786009)(316002)(5660300001)(102836004)(66066001)(76176011)(478600001)(446003)(11346002)(2616005)(8676002)(486006)(476003)(6346003)(186003)(26005)(6666003)(6506007)(6512007)(5250100002)(6436002)(10090500001)(6486002)(72206003)(14454004)(256004)(2501003)(22452003)(81156014)(14444005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0167;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: e3udMgkHEUjnmpUk7l0RsG9O/bExnnkQY9gtGpQz6qu4llgTJuH4rtWQVVVC7OOudQnpt4hfhnpGGkV9oK6Zt0isn9ql0vZGkJa7cH+lbNeHtYvjzg+vCfALAx2BA1W/T4JX6NeOoudy0XI6OQ43Ha8+WNRhyqxW41C7lmsv7UYcTjHzhUlVihTMnvpkc4pz+XoDN6OIPg50X/extTwuCy/608wCKLoRDHtbm9VWYonMrC6Df4M+GYpSNPG4RWaDKt6syQfEQ9RcpJZFbNL4peBxjN55aqW/eYqlmsNA4vn84RwyOyfImnC93zRYmrQZ51KU0VWXLZ4k4vHkK2S8dogGf4YGce5mX8DF2eucTTM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efb49774-4e83-4d98-d7c3-08d61c49d2b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:00:41.9639
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0167
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
index 4b34f71547c6..101d62105c93 100644
--- a/drivers/target/iscsi/iscsi_target_tpg.c
+++ b/drivers/target/iscsi/iscsi_target_tpg.c
@@ -636,8 +636,7 @@ int iscsit_ta_authentication(struct iscsi_portal_group =
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
