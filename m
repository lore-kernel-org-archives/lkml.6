Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4E70C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:03:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DE9820841
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:03:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="algOgNRl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DE9820841
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727542AbeIBRTa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:19:30 -0400
Received: from mail-cys01nam02on0094.outbound.protection.outlook.com ([104.47.37.94]:40784
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726155AbeIBRTa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:19:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KHqbKifK3cmnFB1mq9Lujyqpg7xf6A206H04TC2Kk+A=;
 b=algOgNRlk3KWTmEFUTnpatGFGKWSTd+QB9IbIv1YWb95jpl1RBjw4x9ZeSIf14B6Zeyo0o4WHIz/MACaR1vOUFeefbdQCdXue3sWDd8wPpvZ/1FbG8n0izwm0p7YLPg8lb3RSFT73JepNcVU380XbKLHZdtlQL70JqutpU+lMq8=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0150.namprd21.prod.outlook.com (10.173.189.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.4; Sun, 2 Sep 2018 13:03:25 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:03:25 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     James Smart <jsmart2021@gmail.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        James Smart <james.smart@broadcom.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 021/131] scsi: lpfc: Fix driver crash when
 re-registering NVME rports.
Thread-Topic: [PATCH AUTOSEL 4.18 021/131] scsi: lpfc: Fix driver crash when
 re-registering NVME rports.
Thread-Index: AQHUQr1VwwC2RLanU0OSAhp5RdxFgw==
Date:   Sun, 2 Sep 2018 13:03:25 +0000
Message-ID: <20180902064601.183036-21-alexander.levin@microsoft.com>
References: <20180902064601.183036-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064601.183036-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0150;6:+watNsoOkKEwERPbDXuRKcka6CbynZDOgPxFkfc+WA+e4RGtnPN6doXuZKTaXp1JxptgcX/ol0ffsGjdNLaBLJJQVnV6eqwF3djM0pGG4b+YrYe9FEvdZR78EOiElqn85g5+blsNJee/yncJcN7wjbQNBgJeTpA3CXrdb9lmTD/rV+1mvZgIZrMz9Eb4sef0SPe5+Mo6Ywjlayy+PWNsy5Kp7fDtyg6RolCwVrHbW26eCHqF2n2/5agrIMH0u2tipYt1PYbtk90YPGSHKbU2PV3vxKZiqnUpLfIr9IohVzjeA/tXTu1Z3YLk67CCo3u7HW8knkvqYdQBh+a+D1Jfq2iDMbQ2LaMlbZ+7F146AruITvkMTGrTkwZ/H9Ha5LpmENgg3kACU2qqr45KR2OeRlBzGXCQAZiUk92CiCrh4PYQR//vNn8a1Bh+0lSeLogSwHw1tZidc58bPFqjviUsNQ==;5:Ed94+NBtPC3ghjUFa8DxLIt2/hIgCWsaVX5jVN/fkNMzEdV/DAughzt3RP+GsrQ/REUaoIg7XFmy+iGdLuRkvqG/4dLxaFSYQTHnHtXjxDN2YkjbmKs+nAUctgF9zeLgMjqqBl5ijfY4sgvluKH6dNuAT8WBesqXU4TMc1XGnTk=;7:nQXNuK5Y7eJpfXqkq1PSLu+q9qnzdlO5satMmtYtJyUmPoZ0q/oCJ9acWmvxfrjyfGbQPKhQsUIn8yl8pd17GcP+1Id6ZZArpR5FkKToCwc7xM9RaylJBzaMT2piKBhs3gwbwEHfRfP8Y6yz1tjbsNaPmTbKQ12wn3GZDWB1WPkZz/5JYnmzMagIic3nReNgGFlW38u4nFhP2UHmdGqH1YG0s4yP9D3UFE2KVlygVjSn0wlKlT03tyaVA1OOzRTt
x-ms-office365-filtering-correlation-id: 955f3059-79dd-433a-aeb4-08d610d47841
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0150;
x-ms-traffictypediagnostic: CY4PR21MB0150:
x-microsoft-antispam-prvs: <CY4PR21MB0150E05F830F61C344A40863FB0D0@CY4PR21MB0150.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(208715162771679)(28532068793085)(89211679590171)(85827821059158)(146099531331640);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0150;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0150;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(39860400002)(376002)(346002)(136003)(199004)(189003)(256004)(22452003)(2906002)(217873002)(3846002)(68736007)(10090500001)(6506007)(6116002)(1076002)(6436002)(102836004)(486006)(53936002)(76176011)(106356001)(105586002)(7736002)(305945005)(8676002)(316002)(5660300001)(6512007)(99286004)(36756003)(4326008)(97736004)(5250100002)(2616005)(476003)(2900100001)(11346002)(186003)(2501003)(81166006)(26005)(8936002)(81156014)(110136005)(54906003)(107886003)(39060400002)(66066001)(478600001)(86612001)(14454004)(6346003)(6486002)(10290500003)(86362001)(72206003)(25786009)(446003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0150;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: kSIxs4n6tni0NZ0ky2hbIFxaeFU0rYBts6DQloZFMftzMHBLfw84srRnahlIpTzJAvhRXOrELmOa4ALl8OZJjlosToefAbQDbyMktwapzSUyXPK5Pnbkts5NjSWxILFv/htDFuEJneqv2jpOYb5YYOAkVzYcpoW4z97yfKHEhRb/cgL7GQiJBqVMfjt14ESiRl60MPRVETEunEFQBfRVNdcDngx7+Aiq0757+gaxucfWESQIGhKv9RWy79am0ltTnUmrdR+ZUZaESXzOLjY4Qq8BS4tKMnzk2h0fqx91MsVYJcJaGu/OirZU2P84cwMFlZAjjnrqo92p3P0LZ0n72VIA1qzW7leHjhYVNBmr6sc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 955f3059-79dd-433a-aeb4-08d610d47841
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:03:25.4604
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0150
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: James Smart <jsmart2021@gmail.com>

[ Upstream commit 93a3922da428ec0752e8b2ab00c42dadbbf805a9 ]

During remote port loss fault testing, the driver crashed with the
following trace:

general protection fault: 0000 [#1] SMP
RIP: ... lpfc_nvme_register_port+0x250/0x480 [lpfc]
Call Trace:
 lpfc_nlp_state_cleanup+0x1b3/0x7a0 [lpfc]
 lpfc_nlp_set_state+0xa6/0x1d0 [lpfc]
 lpfc_cmpl_prli_prli_issue+0x213/0x440
 lpfc_disc_state_machine+0x7e/0x1e0 [lpfc]
 lpfc_cmpl_els_prli+0x18a/0x200 [lpfc]
 lpfc_sli_sp_handle_rspiocb+0x3b5/0x6f0 [lpfc]
 lpfc_sli_handle_slow_ring_event_s4+0x161/0x240 [lpfc]
 lpfc_work_done+0x948/0x14c0 [lpfc]
 lpfc_do_work+0x16f/0x180 [lpfc]
 kthread+0xc9/0xe0
 ret_from_fork+0x55/0x80

After registering a new remoteport, the driver is pulling an ndlp pointer
from the lpfc rport associated with the private area of a newly registered
remoteport. The private area is uninitialized, so it's garbage.

Correct by pulling the the lpfc rport pointer from the entering ndlp point,
then ndlp value from at rport. Note the entering ndlp may be replacing by
the rport->ndlp due to an address change swap.

Signed-off-by: Dick Kennedy <dick.kennedy@broadcom.com>
Signed-off-by: James Smart <james.smart@broadcom.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/scsi/lpfc/lpfc_nvme.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_nvme.c b/drivers/scsi/lpfc/lpfc_nvme.c
index 76a5a99605aa..d723fd1d7b26 100644
--- a/drivers/scsi/lpfc/lpfc_nvme.c
+++ b/drivers/scsi/lpfc/lpfc_nvme.c
@@ -2687,7 +2687,7 @@ lpfc_nvme_register_port(struct lpfc_vport *vport, str=
uct lpfc_nodelist *ndlp)
 	struct lpfc_nvme_rport *oldrport;
 	struct nvme_fc_remote_port *remote_port;
 	struct nvme_fc_port_info rpinfo;
-	struct lpfc_nodelist *prev_ndlp;
+	struct lpfc_nodelist *prev_ndlp =3D NULL;
=20
 	lpfc_printf_vlog(ndlp->vport, KERN_INFO, LOG_NVME_DISC,
 			 "6006 Register NVME PORT. DID x%06x nlptype x%x\n",
@@ -2736,23 +2736,29 @@ lpfc_nvme_register_port(struct lpfc_vport *vport, s=
truct lpfc_nodelist *ndlp)
 		spin_unlock_irq(&vport->phba->hbalock);
 		rport =3D remote_port->private;
 		if (oldrport) {
+			/* New remoteport record does not guarantee valid
+			 * host private memory area.
+			 */
+			prev_ndlp =3D oldrport->ndlp;
 			if (oldrport =3D=3D remote_port->private) {
-				/* Same remoteport.  Just reuse. */
+				/* Same remoteport - ndlp should match.
+				 * Just reuse.
+				 */
 				lpfc_printf_vlog(ndlp->vport, KERN_INFO,
 						 LOG_NVME_DISC,
 						 "6014 Rebinding lport to "
 						 "remoteport %p wwpn 0x%llx, "
-						 "Data: x%x x%x %p x%x x%06x\n",
+						 "Data: x%x x%x %p %p x%x x%06x\n",
 						 remote_port,
 						 remote_port->port_name,
 						 remote_port->port_id,
 						 remote_port->port_role,
+						 prev_ndlp,
 						 ndlp,
 						 ndlp->nlp_type,
 						 ndlp->nlp_DID);
 				return 0;
 			}
-			prev_ndlp =3D rport->ndlp;
=20
 			/* Sever the ndlp<->rport association
 			 * before dropping the ndlp ref from
@@ -2786,13 +2792,13 @@ lpfc_nvme_register_port(struct lpfc_vport *vport, s=
truct lpfc_nodelist *ndlp)
 		lpfc_printf_vlog(vport, KERN_INFO,
 				 LOG_NVME_DISC | LOG_NODE,
 				 "6022 Binding new rport to "
-				 "lport %p Remoteport %p  WWNN 0x%llx, "
+				 "lport %p Remoteport %p rport %p WWNN 0x%llx, "
 				 "Rport WWPN 0x%llx DID "
-				 "x%06x Role x%x, ndlp %p\n",
-				 lport, remote_port,
+				 "x%06x Role x%x, ndlp %p prev_ndlp %p\n",
+				 lport, remote_port, rport,
 				 rpinfo.node_name, rpinfo.port_name,
 				 rpinfo.port_id, rpinfo.port_role,
-				 ndlp);
+				 ndlp, prev_ndlp);
 	} else {
 		lpfc_printf_vlog(vport, KERN_ERR,
 				 LOG_NVME_DISC | LOG_NODE,
--=20
2.17.1
