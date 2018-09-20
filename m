Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DF71C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:53:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A4C921521
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:53:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="XF0cbKoN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A4C921521
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388645AbeITIez (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 04:34:55 -0400
Received: from mail-bl2nam02on0090.outbound.protection.outlook.com ([104.47.38.90]:36192
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388294AbeITIa1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 04:30:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j9uHqCLr/ekC2MejX7CFS6uEY9HkJ/6SWY+kVYJVvs4=;
 b=XF0cbKoNv1yIOtt7I+JhleKlAmPmnVB+/PdsOGZRfvCUm0IhqYjfmq+YNwIpqJ4ZWNumL9JptASjeni6ssIKvCvv5nwgrDvGgISSs1zQWI3w1lIO0gsgSym/6GA/6awM7j/ZmJqFkcIigVOgcDwOzg8kE2LohidpFQ5aKuxrWU4=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0744.namprd21.prod.outlook.com (10.173.189.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.6; Thu, 20 Sep 2018 02:49:18 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.010; Thu, 20 Sep 2018
 02:49:18 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     James Smart <jsmart2021@gmail.com>,
        James Smart <james.smart@broadcom.com>,
        Christoph Hellwig <hch@lst.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 20/25] nvme-fcloop: Fix dropped LS's to removed
 target port
Thread-Topic: [PATCH AUTOSEL 4.14 20/25] nvme-fcloop: Fix dropped LS's to
 removed target port
Thread-Index: AQHUUIxpYWE/IyJockis7Le6kfGkMw==
Date:   Thu, 20 Sep 2018 02:48:29 +0000
Message-ID: <20180920024810.58594-20-alexander.levin@microsoft.com>
References: <20180920024810.58594-1-alexander.levin@microsoft.com>
In-Reply-To: <20180920024810.58594-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0744;6:CtNmZ95BmuAepG1r1irywpgiqzI0quCx34U3g2bjtZUVql5MmZF4+zTOO6+KgASHh3NzqLP1RhUXHIfwhxNBJ1hbzF0yaHQPKwudNsWIFJ4V2TYVqYqlqiNKCVhyuDP28hof6ITIeef6ppHSlUdgdrJzOo2lKC+sL52CFQdK/keocnF2B89nniNbQ2XI4fjgp3Q+H6AGibAA2HayPg5eTzStxemNGKxkaT5N4qBehNB7lQ2i26qGQfoVdMJViNROwbGDDdfA1cA1EJpe0HEolAhQHsIXEiGPUDXE3tAGiyS/WYXSsZdbYwR8aLhkMKCSSvI5BaUdN/7QB6y2ycRL6icbYLjztTwzrlNmokXdvgJ/GoRhQLLrvIu8wGZt6PPALzM5quOZJsJ3ACTNNc+HKkXMjCEznJHuwAYsWypVoEcqHEyfBdiUUJ/c+Qt0oBqaFrM21Y4jRuR/75IGtmSwVw==;5:mfZgU6G4MUx3YjB4N8Tmw9KP4eRBiy2knJ4fNGqMomKII1qK1o6nxsFjY85ToaULxmnhFN9bN2Mcvg+uOOu8QQf2yFFpSk15LXQKMgLOYA0jFHiu04uJl2+JgugSVmexP3g/X0YjXriLLw0DU0y3tDDEo5mzDJDggsLY1ErY6lA=;7:HLidXFGXW7tq51lA63eGzIhMXfT4T8tfacRrGJ64gMRToxFti1iWSnKraw8iOQoacO4LHgRlugVrLrAjh6cckzI2ecz1gh2z2+/s22uFJkPYzYpi0J0rnjIB78ST7NwvJdNjDsHeCPfJCF+97nSU0TcmPfg4cJLOQqI8lugUTDji54y1rdH2ItxrEP1w9+T4vEz+E8EJYBODw1zw6VLetmSanmedhtjb2xwu1S4z4otC9RUkQ4NfWxx7+nmQVQZ6
x-ms-office365-filtering-correlation-id: ebfbf50d-fce6-4a81-eeda-08d61ea3a8d4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0744;
x-ms-traffictypediagnostic: CY4PR21MB0744:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB07447F9A42B4F04CCC5F3F3FFB130@CY4PR21MB0744.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158)(208715162771679)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231355)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0744;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0744;
x-forefront-prvs: 0801F2E62B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(396003)(376002)(346002)(136003)(189003)(199004)(8936002)(6436002)(10090500001)(110136005)(217873002)(54906003)(6512007)(53936002)(68736007)(5660300001)(14444005)(256004)(6666003)(71190400001)(6486002)(316002)(39060400002)(446003)(11346002)(105586002)(476003)(106356001)(478600001)(2616005)(2906002)(186003)(25786009)(10290500003)(486006)(71200400001)(72206003)(66066001)(4326008)(14454004)(22452003)(36756003)(102836004)(86612001)(97736004)(8676002)(305945005)(7736002)(1076002)(86362001)(575784001)(81156014)(26005)(76176011)(6506007)(5250100002)(107886003)(2900100001)(99286004)(3846002)(2501003)(81166006)(6116002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0744;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: yxg2XFoDE3u3qlxLPixWBeqCOAmKsIpB8AYFl9xBJ/syPEmuDsVBmDL9UtrcFIttG/WEwWmilkHUD6CY5vtozm9GbbnvONhD2FkEBBZQ05jdSvzLAwkUzyCbDTTYkxV5+9KB00JZGosJ+hC7XIywRIXKs6D6OvAaZqKL1ePxqqpEfYytAO7FZX7o0Y9ZSBpEHVUnRdVmhq+yMHxbC7oEEkGuSWRLKkz6uD9NgALh7rTbZjE/dUL41F4araEnD/1rHti70xFsqqFGPNuda2M/vKFou56HXvYKH2ijSL1zIgPIYxlns2w195q4M44EOIVhNxWbgideSacwB0u3G2wMgkPRznqYiHXu2yL7H5O4txI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebfbf50d-fce6-4a81-eeda-08d61ea3a8d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2018 02:48:29.6789
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0744
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: James Smart <jsmart2021@gmail.com>

[ Upstream commit afd299ca996929f4f98ac20da0044c0cdc124879 ]

When a targetport is removed from the config, fcloop will avoid calling
the LS done() routine thinking the targetport is gone. This leaves the
initiator reset/reconnect hanging as it waits for a status on the
Create_Association LS for the reconnect.

Change the filter in the LS callback path. If tport null (set when
failed validation before "sending to remote port"), be sure to call
done. This was the main bug. But, continue the logic that only calls
done if tport was set but there is no remoteport (e.g. case where
remoteport has been removed, thus host doesn't expect a completion).

Signed-off-by: James Smart <james.smart@broadcom.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/nvme/target/fcloop.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
index c0080f6ab2f5..0b0a4825b3eb 100644
--- a/drivers/nvme/target/fcloop.c
+++ b/drivers/nvme/target/fcloop.c
@@ -300,7 +300,7 @@ fcloop_tgt_lsrqst_done_work(struct work_struct *work)
 	struct fcloop_tport *tport =3D tls_req->tport;
 	struct nvmefc_ls_req *lsreq =3D tls_req->lsreq;
=20
-	if (tport->remoteport)
+	if (!tport || tport->remoteport)
 		lsreq->done(lsreq, tls_req->status);
 }
=20
@@ -318,6 +318,7 @@ fcloop_ls_req(struct nvme_fc_local_port *localport,
=20
 	if (!rport->targetport) {
 		tls_req->status =3D -ECONNREFUSED;
+		tls_req->tport =3D NULL;
 		schedule_work(&tls_req->work);
 		return ret;
 	}
--=20
2.17.1
