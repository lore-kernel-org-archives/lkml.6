Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16DA1C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:06:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9D07204FD
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:06:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="HPftPCI/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9D07204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728878AbeIBRWP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:22:15 -0400
Received: from mail-eopbgr720115.outbound.protection.outlook.com ([40.107.72.115]:16848
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727222AbeIBRWP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:22:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pbu//Wpi7PxYiQC+vElA9DI5p3gi5mQZ0/UKOXRIwNU=;
 b=HPftPCI/l/j3ZbXWS/oFDGkdkHu62AyJGtFcchhqKIguXxHhrlG66n+8i7QWDUuwWnE9TT19gFltVxy7goFf6iVlyZ1amrQ+xy+vNulSWwYadODtasM9APjMfpi3QokXRUDzpl878Fh4ev5NClW+pOAux90nKx+vfY0eDTFrSNI=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0822.namprd21.prod.outlook.com (10.173.192.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:06:20 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:06:20 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Dan Carpenter <dan.carpenter@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 01/89] misc: mic: SCIF Fix scif_get_new_port()
 error handling
Thread-Topic: [PATCH AUTOSEL 4.14 01/89] misc: mic: SCIF Fix
 scif_get_new_port() error handling
Thread-Index: AQHUQr24vhN/ki3C5E+qLxt2uSx3gg==
Date:   Sun, 2 Sep 2018 13:06:10 +0000
Message-ID: <20180902064918.183387-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0822;6:4F8XETKsD5/fOeYTDB9ByAy+PoPGk7FDaqBZXDpNH3AK3vNavpNZa2OO3hcXla0H9YcxB6284zqVikQYANucpG/ZqSIQZINUg5h6FCpRkpgZvdSe+KspHBsAdRebEpvHuMptAIwp7OE7VSnajWMTCsULB1J6K4Qyyf+Rjf2z/aEwPRpNuNoNOE+zVgcEGWIBm9ATmiIc5rE9V0+2ecT/e9FqMjCsnToYRslcdbJg8nU59pZZe4W/xKa+JyXyvGYUpzNJe+Sl/Kdn+yEc+dUlJgGBp5REmZPnuwlQ5G+fsdEDbmXCxFgBdnjJkgMhRSy81d+RbMskK+wXa8pCNvfKHqpof9iSTkM+VvsAR451qvbMqJJLaphigtV7Fuqanm2PxVCiEjmnxW7mtzuedmJxIwnLtvqgcJWhd86340b7DdQtWUUovQvIleYF5DkgvvjTPJoL7vNgbUVPN0vkLOAz/A==;5:Cns1spLVHlAyC3dCvpxuWWqimEXWpc+wY8LRhNCwFJ0OW5BKj/taTuNmE8hsLLMvpTUyBuM6Ptq4PqZh4uG00KpZWr49j2mNy3EcdJVg7ipc4g5i6eoJ++J9MrNeyrSZmsKEZrbEFy259izecp2niiJtk39VzCI+IvPQCRQgSg4=;7:7AJxI+HaaaHJgptVs277rtxLX+SmlJ0CRyh8qA7GPqx2i0cQ6+CaAb/Zm/Ut4Pw0U39h+DMpfKMQQsc24WeNaWHDA459Q0o8gwH097Q+4/7IU0AS2CTTNF9kXSmyYS9WywYdvHO0YAxWuBjpR046IrDz4ySv7U+T7Cr6Gbni3MdHE4StcZuFRSVN39tn5wRxqNbSpmhbj+TfiXsAyYRhWysnipJ5ATgcmNwbZSplO/NspsUjQ8pFwPtYOL5HXoer
x-ms-office365-filtering-correlation-id: 6f91cc01-fb63-4166-d982-08d610d4e066
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0822;
x-ms-traffictypediagnostic: CY4PR21MB0822:
x-microsoft-antispam-prvs: <CY4PR21MB0822A63547FAC07998F3FA2FFB0D0@CY4PR21MB0822.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3231340)(944501410)(52105095)(2018427008)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0822;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0822;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(136003)(366004)(39860400002)(189003)(199004)(256004)(14444005)(6512007)(486006)(86612001)(97736004)(68736007)(478600001)(25786009)(8676002)(10090500001)(8936002)(2906002)(575784001)(110136005)(86362001)(107886003)(4326008)(186003)(26005)(6346003)(6486002)(53936002)(2616005)(476003)(72206003)(10290500003)(6506007)(81166006)(81156014)(66066001)(22452003)(99286004)(102836004)(5660300001)(217873002)(106356001)(2900100001)(1076002)(6666003)(7736002)(2501003)(14454004)(5250100002)(305945005)(3846002)(54906003)(36756003)(6436002)(105586002)(316002)(6116002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0822;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: KBT1zzXQB/NQ6CPZcrmKfB6FtsnVs6lEgGHLUyhVrUowZFhGj+vCd3hY5IsdoB4dV0xt/oOVZWxtzaT9dKQnUcFdrp5zVTsCVwI0aHr9S9qe4Wu0KlV130Vdcwagh26Td8nEMXcR3SZ6A1rjT3FUMqoomcB36Oh/zX3z7nP2NjRoaK0kZnTDIRowmQdU93PpvtrvcpwOMDe/uSyDeAilptin6oNA6X0sslVcP+ZUbh758lxyx6qFIxPvnwaboBstXm7Yk0zYy0SSdJr6/8fus3U5co4DzURW9RZwI03hdaaiVPv0Rir399jn5saCWyBfELzlrq1v+SB5D17+r2l6I/AEIuuX2GWwvTjWxeWqn/o=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f91cc01-fb63-4166-d982-08d610d4e066
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:06:10.9904
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0822
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit a39284ae9d2ad09975c8ae33f1bd0f05fbfbf6ee ]

There are only 2 callers of scif_get_new_port() and both appear to get
the error handling wrong.  Both treat zero returns as error, but it
actually returns negative error codes and >=3D 0 on success.

Fixes: e9089f43c9a7 ("misc: mic: SCIF open close bind and listen APIs")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/misc/mic/scif/scif_api.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/misc/mic/scif/scif_api.c b/drivers/misc/mic/scif/scif_=
api.c
index ddc9e4b08b5c..56efa9d18a9a 100644
--- a/drivers/misc/mic/scif/scif_api.c
+++ b/drivers/misc/mic/scif/scif_api.c
@@ -370,11 +370,10 @@ int scif_bind(scif_epd_t epd, u16 pn)
 			goto scif_bind_exit;
 		}
 	} else {
-		pn =3D scif_get_new_port();
-		if (!pn) {
-			ret =3D -ENOSPC;
+		ret =3D scif_get_new_port();
+		if (ret < 0)
 			goto scif_bind_exit;
-		}
+		pn =3D ret;
 	}
=20
 	ep->state =3D SCIFEP_BOUND;
@@ -648,13 +647,12 @@ int __scif_connect(scif_epd_t epd, struct scif_port_i=
d *dst, bool non_block)
 			err =3D -EISCONN;
 		break;
 	case SCIFEP_UNBOUND:
-		ep->port.port =3D scif_get_new_port();
-		if (!ep->port.port) {
-			err =3D -ENOSPC;
-		} else {
-			ep->port.node =3D scif_info.nodeid;
-			ep->conn_async_state =3D ASYNC_CONN_IDLE;
-		}
+		err =3D scif_get_new_port();
+		if (err < 0)
+			break;
+		ep->port.port =3D err;
+		ep->port.node =3D scif_info.nodeid;
+		ep->conn_async_state =3D ASYNC_CONN_IDLE;
 		/* Fall through */
 	case SCIFEP_BOUND:
 		/*
--=20
2.17.1
