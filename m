Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14DA1ECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:17:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B32CA214AB
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:17:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="JJ4c7wK6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B32CA214AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730946AbeIQInO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:43:14 -0400
Received: from mail-eopbgr710091.outbound.protection.outlook.com ([40.107.71.91]:43296
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729386AbeIQIbC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:31:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5hjBmlqR7qC03mJHPNvHrUNpEQVSEHheEp5+jLbzZp0=;
 b=JJ4c7wK6+yqKi2+aHQscEmRy/khOnO/iDB3o4rfinukEmhOjhR+/nvj0g1TCiD1nPeOh/x8wdqThv4oVD3wmxLjUbluVozp4pvEiTbOQL5JYUX7EKAJm9UExeyY9IIqOb0rW8wR1fnI3++Q+AFtFrjWiiqH6jwi3CJc4ZzIi/wM=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0757.namprd21.prod.outlook.com (10.173.192.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.1164.6; Mon, 17 Sep 2018 03:05:43 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:05:43 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Bart Van Assche <bart.vanassche@wdc.com>,
        Mike Christie <mchristi@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Hannes Reinecke <hare@suse.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 24/57] scsi: target/iscsi: Make
 iscsit_ta_authentication() respect the output buffer size
Thread-Topic: [PATCH AUTOSEL 4.9 24/57] scsi: target/iscsi: Make
 iscsit_ta_authentication() respect the output buffer size
Thread-Index: AQHUTjMT6mN7WougYkiBVHTO2zrn8g==
Date:   Mon, 17 Sep 2018 03:03:58 +0000
Message-ID: <20180917030340.378-24-alexander.levin@microsoft.com>
References: <20180917030340.378-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030340.378-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0757;6:I70Ps5gsmQBb1CsbBFD2DLCZaQtlY7uBk4iB9oo4XsnPQSEcJzKibMGVPQG4lXsNkY3VWNWUZHr8VBwpa2Er3hcWjABOUmIRE4/1R3bQdgsmHuChjvx5fnlTPFeBVNLAxs/lhFoZ+ieZkpCb4soZX/a518gXFgYD+KNkIzYk1+GidkGa/slyBOPwd8r9zqnSbRUQNeHnQKTRcwgR582ohD/nlSZ1bY9UoXWxL5S63KiL9B+SYyy2XrmorUSbX2jTluSKtNbue+qJ92JP8+mklNkmVKCk9VufYNP7RPp5ctOLv7djBudG7iFA/a3/umYva7w2EQXhHaE/jK4JyF9JRfLlU81FdqceVIO4uFToxeEyXQM8onfKoKYW0fhEdWybT7ABfDIBHK/VrK7QpgFx105Y3CCxuumdAPaNtXjyhMUn00EVppFY4/jbTiXX3RKH5BitiY4zNLdyYOxBB3zX1g==;5:w1GZUFHAbIBXfdFWCRjo0szOmCsvvgWIwdPwRJK/sFwPZLXQW9EuOP+a1ly2lvPnGJBa+IjAv7F59dw3tIaI7WifbX8bU6LD+7dCm/h8rV3v6H8dom0TyamA4O0KgW/W0Dy0kWZll5z9QgjVQG3zlUVVC1u5r7FR3xyTCybq+ck=;7:WINczlYddlzyam+nMOLAwm1GQKRxIpyippyK9+B5LkZkQB9PDHOhkjBGAO6C+s8A+JdnzURSb6gGz7eXtebLEDxSwbuXYtoPvNXYiXVV09Wl6ThJGl7IC57sUXzlJGGbzMeAVC9g1OKjwPAw5OgSJYqumyqFwUr8jyfqTbVtjMIltXkoO7rOdQNidzBHEZeX9y17ieMeX5MF/CgPxu6kzQUdzMtHdQWTps8vYivFcozPdQZf8IzKZaqsQVpZbDXM
x-ms-office365-filtering-correlation-id: 863e4908-66c2-4cd9-3088-08d61c4a753e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0757;
x-ms-traffictypediagnostic: CY4PR21MB0757:
x-microsoft-antispam-prvs: <CY4PR21MB07573C8ECE98F61A02424FF1FB1E0@CY4PR21MB0757.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(146099531331640)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0757;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0757;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(366004)(346002)(376002)(396003)(189003)(199004)(8936002)(68736007)(476003)(575784001)(10290500003)(446003)(53936002)(11346002)(6512007)(486006)(86612001)(6436002)(1076002)(256004)(6486002)(2616005)(14444005)(81156014)(81166006)(7736002)(8676002)(217873002)(478600001)(305945005)(3846002)(6116002)(86362001)(4326008)(106356001)(66066001)(186003)(36756003)(99286004)(76176011)(102836004)(107886003)(26005)(2906002)(5660300001)(110136005)(54906003)(10090500001)(22452003)(72206003)(2900100001)(316002)(14454004)(97736004)(105586002)(6506007)(25786009)(6346003)(6666003)(5250100002)(2501003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0757;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: nSg9Vtyu8WuoUFdysH3gxxO+pab6npLrVXWu86t0AIC9baao7kkpEnN93JTA4xEBV6LBFH3m7RooGcjJUYWuRmhIHoR7UwfWCJtDtyUhRIs0CSKOnbu0BhRI/JbmsWrz/OtuG3OCI14vk7XE6mcSTQXJGEjPADqHaPoraykXh/TrZ827PzyzlrVe/NYHsESW8+7aHJVrQqeSStXxAJtXvcPzjsd+8ocXvQRFxAmBSogwt0G05nNamr+7DOtd1pig0yZoZFE68NxPbjcS2b82EzHTLk7g6zLaAWGqf/UIxX5Cxq7rvypChg10jD+/kpm1UE0AGkCm1Fl9Y5I2JTN2Kt6q7AWu575yqoxlKvBQJqM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 863e4908-66c2-4cd9-3088-08d61c4a753e
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:03:58.3835
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0757
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
