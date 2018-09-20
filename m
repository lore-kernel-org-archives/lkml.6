Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D335C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:49:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7D9021521
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:49:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="PBvH5mmv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7D9021521
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388186AbeITIaI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 04:30:08 -0400
Received: from mail-eopbgr700120.outbound.protection.outlook.com ([40.107.70.120]:3328
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732415AbeITI3g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 04:29:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E+VcWz1ObB2zEDwrnKctftIyuSrX+/erGMxSPKw5n5E=;
 b=PBvH5mmvHXz2McvzWHJ6WBYp2/IJtK97+l2eqybh+j3BxQRyMYpgohnKILVcYW9aoK/GHh0vdJ/VAEaF/ZIXL8UGe6nJgo2nbn2HxIVnZV2xi1keBC6ETil3f2vzkq/41rmjks2dMbGKjKsjzqQzsNHNeYTHNQsGmjuxKwopb/k=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0119.namprd21.prod.outlook.com (10.173.189.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.4; Thu, 20 Sep 2018 02:48:29 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.010; Thu, 20 Sep 2018
 02:48:29 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     James Smart <jsmart2021@gmail.com>,
        James Smart <james.smart@broadcom.com>,
        Christoph Hellwig <hch@lst.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 49/56] nvme-fcloop: Fix dropped LS's to removed
 target port
Thread-Topic: [PATCH AUTOSEL 4.18 49/56] nvme-fcloop: Fix dropped LS's to
 removed target port
Thread-Index: AQHUUIxZsm9LLeC4WU211+9qtaI6PQ==
Date:   Thu, 20 Sep 2018 02:48:02 +0000
Message-ID: <20180920024716.58490-49-alexander.levin@microsoft.com>
References: <20180920024716.58490-1-alexander.levin@microsoft.com>
In-Reply-To: <20180920024716.58490-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0119;6:fzQMQxjUJRduLULlIAJ5hlM0oR1eNZQ7+p8cL6Lj+BAFvcTSDUBtxMt5DjV0YnJXW4oxxvxKDAR6Jd5GbOIjxNfzFWc8E4njIGKu+7lIlZlOnjdz4HFhOXpoBEfwtTDbkWTlT0yA+OPWqLaPvfoovPPk4lNDGU85x0U4wdG3I9Gen1AbvrUml38zagRfBoWjNWAAAniXJsKjOZ7gs/3k+eP7LbGy1UVyA9cRC71EcwDLF4KsXYd8se8yFiMtZepgm9RrkqvfPfqEC51QSWK/df6Q9WRYt5uE+VVTPgHk+dtigKVQxUDjTxo5U2rTJoH52Aas4zXocQR7qSR9cZ/OjDdRb+5WSPj/wrZGvbq+ktA8rmo/RLQgTVCYtumnd1N2YxY3CQ4yT9Jqpdhsszw3j7htJp9DFOiAwB16xHApvSosIRihN+RDT0wWYZVNuTws1f5//F38Bgy+bU0dfrUoaw==;5:obViE88adYcM5cRHCfiX9W6CH7ZIcHQUHEqnVVVVW6Qw3HIz9gYrI3iYgg0TQTBF2nryQLuRJt0kV8XnjSRIUbGlJ9FE5JWcOrf2cmNEcxV0AfnKjSz7AAV0zbY1lzmxWRtNJTy4wlO2XKbx2K1HcCdJdu3MKvPXbfqibqUc7WQ=;7:OJyuUSRzRhnI5WBnIP19h15GwYCkKC+thVWCpVg5hLnosc5E8pT8m/N+vLL1LF8nZJGwfo1Gd9B4gjdiQhsiKeyfmokUPncFp9cCLKUZ1MiDmPUwroRW8UGf70m436adrF+/WEypRZM4ZORewFAfTTs9FXJW32FKCGQAp5DjcCuJJtKfsdtK7WmGgPfKvv1UKCs0iOSI1HLKSl5GxMF3hYeUWRYwtvx0/Gd6LzWsIQqI8gAt2kGwXaPnWVAM5aU+
x-ms-office365-filtering-correlation-id: 0a77964e-01c8-4e9b-7108-08d61ea38bba
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0119;
x-ms-traffictypediagnostic: CY4PR21MB0119:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0119E6F23E56F0A6CAF0FCA1FB130@CY4PR21MB0119.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158)(208715162771679)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0119;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0119;
x-forefront-prvs: 0801F2E62B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(396003)(376002)(136003)(39860400002)(189003)(199004)(5660300001)(54906003)(1076002)(478600001)(10090500001)(72206003)(22452003)(107886003)(110136005)(316002)(68736007)(4326008)(76176011)(3846002)(6116002)(25786009)(14454004)(106356001)(39060400002)(99286004)(6666003)(105586002)(102836004)(6506007)(5250100002)(186003)(2501003)(26005)(6486002)(6436002)(53936002)(6512007)(66066001)(486006)(476003)(2616005)(10290500003)(11346002)(446003)(97736004)(36756003)(2900100001)(2906002)(8936002)(305945005)(575784001)(217873002)(7736002)(86362001)(8676002)(86612001)(256004)(71200400001)(14444005)(71190400001)(81156014)(81166006);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0119;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: uWXwWtJ5RePSQl/Ysn0wlu/UksDgK6Qtp0pMzbEbOZokSUDJW2abG/UZc1mLTIWvHjw2xhLLm/P8IexHIj/LsEtNax+DAj0ks9gb/1MTNn+o7L7xIpJnYXggP/lDwTcQSkpYZN2VuGyFTvlwBfy1LAoIcDr1Ko0QdzxaftXz65k7+94A93JXlIgegx4Oaow3M/obt3GqV+xJn89bNtpcYgWjPrLO7zoi52Fjc7gz1Rxx0WWhpgblQ53PcVvNKvIayhkZX7I624vXsRRvKTgivhpmerc2lT7JI/pJNlxL6mjKLMqQDGNTiSQzI4fxZ8xwzHa/TkAY99SjMJstdyvk9W2S0k8ac8m6DTgE4oDxVko=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a77964e-01c8-4e9b-7108-08d61ea38bba
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2018 02:48:02.3042
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0119
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
index 34712def81b1..5251689a1d9a 100644
--- a/drivers/nvme/target/fcloop.c
+++ b/drivers/nvme/target/fcloop.c
@@ -311,7 +311,7 @@ fcloop_tgt_lsrqst_done_work(struct work_struct *work)
 	struct fcloop_tport *tport =3D tls_req->tport;
 	struct nvmefc_ls_req *lsreq =3D tls_req->lsreq;
=20
-	if (tport->remoteport)
+	if (!tport || tport->remoteport)
 		lsreq->done(lsreq, tls_req->status);
 }
=20
@@ -329,6 +329,7 @@ fcloop_ls_req(struct nvme_fc_local_port *localport,
=20
 	if (!rport->targetport) {
 		tls_req->status =3D -ECONNREFUSED;
+		tls_req->tport =3D NULL;
 		schedule_work(&tls_req->work);
 		return ret;
 	}
--=20
2.17.1
