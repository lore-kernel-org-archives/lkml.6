Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2B2EECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:11:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6197F20693
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:11:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="f8ircwOa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6197F20693
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731624AbeIQIhI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:37:08 -0400
Received: from mail-sn1nam02on0110.outbound.protection.outlook.com ([104.47.36.110]:23375
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730578AbeIQIck (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:32:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5hjBmlqR7qC03mJHPNvHrUNpEQVSEHheEp5+jLbzZp0=;
 b=f8ircwOa3HIaVLf5OI3rP+2C+N08WN4VkkvMDrYuIWg1UCAaYzqEELcmf5VeIwFULzHWbhFplK+Ml9m2x9plXWgeA+tpyEFnMmB4roz2HJ6yI4szU55B5OXTZf03kYtxYlJWw826anBNCGpX0oXFEvn4kQMlmzKk5Y7A3QsizcA=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0742.namprd21.prod.outlook.com (10.173.189.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.6; Mon, 17 Sep 2018 03:07:07 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:07:07 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Bart Van Assche <bart.vanassche@wdc.com>,
        Mike Christie <mchristi@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Hannes Reinecke <hare@suse.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 17/43] scsi: target/iscsi: Make
 iscsit_ta_authentication() respect the output buffer size
Thread-Topic: [PATCH AUTOSEL 4.4 17/43] scsi: target/iscsi: Make
 iscsit_ta_authentication() respect the output buffer size
Thread-Index: AQHUTjM4180JDj/zX0qPH8HENbXFIg==
Date:   Mon, 17 Sep 2018 03:04:59 +0000
Message-ID: <20180917030445.484-17-alexander.levin@microsoft.com>
References: <20180917030445.484-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030445.484-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0742;6:/FfBAgusoHlc8fIFzIN8z0A4b0uOTO4YhXcMZc1f0bFWd6Z+0P01sShprt1Uw/phh+YJIUAz5LBsMrv9KUQ9C34irp62QbCJ8KsHgqW4/X1q2QwOp90LMN/cAkeOb8aYs5anzu58LLEeqIOKaLx5lRlSLx5BOCSexHmeCJnL4gARBJwPB4el/3NskRmQw34hrJqF1s38FgprDzIqcqdmtMwQGFYOZRIF0ZiMZnfddrVticw/C9rvSS1kspDtFcHqQl+2+Y0Zh3IOY8vybqO8eZDVYW6BJfRv4hJOeQGOAiYekCuQ9vFYMR0A/lFdPrU46LCRReX8DufuP+0PmuKdoHKiPDjeSt4WX/424RXGO9yVJPEIzkn52aHLG3ehXZBIQIKEUeJIRBbs6nVJvkV1kX4FkDM3lpsrMRUddoOHdmnS1PyQhbZuDcPUJfkYcboUKlNJ3I/bqPOBnn21UXI77Q==;5:TxsAlUfSCjLCeKBXX8zkRnbvnv6syr90H6gW31QeiEcIktoGl3O9gOxydx8bHWTHPG/paAI1BgoukvZ6k1S29fUEAjo4TpB7+k7xUXPdFu1saVYxADlIXHH746D5VdB5ALWIZI6SGLb2ZrI/mm8rtUPzsxL5whvw7u7ZVdy9FkY=;7:e8UecEkd0k3Bht5deKblKbY5v2hRmZ/L5F21Va2WeHOqYRr1T8tgDHP2ONvO5qrPDBXPRB4LWPEDs54/N2Oq0dcSI5T5Yofe2qPgwYrQvb9rMJN5/pwuwQjEnHkVB6zzc2zLUx6QYBpwkebSaE3QXceI8NR4fyIH+K+GVFPTfP7q84zLlvF/1ByH8U6E+kUByAKH0DtHXqhBl7WmFsN0XjLR6nPTmF+YYzkYPEMgn47ogqsSlw/W404IOBd3+5eY
x-ms-office365-filtering-correlation-id: 35902721-60f7-4fbd-9d62-08d61c4aa6f9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0742;
x-ms-traffictypediagnostic: CY4PR21MB0742:
x-microsoft-antispam-prvs: <CY4PR21MB0742AB54B9F17E1C8C4B4578FB1E0@CY4PR21MB0742.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(146099531331640)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0742;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0742;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(346002)(366004)(396003)(376002)(199004)(189003)(6486002)(6436002)(6512007)(53936002)(4326008)(3846002)(217873002)(25786009)(2616005)(1076002)(14444005)(6506007)(186003)(6346003)(11346002)(446003)(26005)(2900100001)(6116002)(486006)(102836004)(256004)(107886003)(476003)(86612001)(575784001)(86362001)(2501003)(14454004)(97736004)(66066001)(76176011)(6666003)(316002)(54906003)(110136005)(99286004)(68736007)(10090500001)(22452003)(81156014)(2906002)(36756003)(8676002)(8936002)(81166006)(7736002)(305945005)(105586002)(5660300001)(106356001)(10290500003)(478600001)(72206003)(5250100002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0742;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: 6GEnF1doPLrzXsuJ6nus4b0+wcuRzKxxLu7f2sE/lp+2QqQsRF2xBg0ickwvydk5yPBl1cr8zNKIt1QPoFXhPu3d6vJo41LBVKXWAfPph8yz3tMN01XdcUYXTF6+cN12aKV9z9BuG48Bx2UepDO0FbvFiwpko+djQIElbHZPl3i7OKd8kmOU5KOHYKw5JT0heKxs9SFBsHnXeUr2oK/oYKZYpJOMs/7qmaBEPe6McQL6UkYqiMcWAKgp2hn1UqVVw8fu9rZipNDxynaZ1Ui/llPmnOp8vBhsZmyUi7NdMyKcxEVrL7godo1yIJ7z1VxX+QlpN1ma7jAxwmdoSlWtX/Y2Aop9G5XvAC4DnC9PhQU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35902721-60f7-4fbd-9d62-08d61c4aa6f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:04:59.3986
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0742
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
index 63e1dcc5914d..761b065a40bb 100644
--- a/drivers/target/iscsi/iscsi_target_tpg.c
+++ b/drivers/target/iscsi/iscsi_target_tpg.c
@@ -637,8 +637,7 @@ int iscsit_ta_authentication(struct iscsi_portal_group =
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
