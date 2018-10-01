Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09985C004D2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:41:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B50112083C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:41:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="LGRieVbA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B50112083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730139AbeJAHQs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 03:16:48 -0400
Received: from mail-cys01nam02on0136.outbound.protection.outlook.com ([104.47.37.136]:43745
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729721AbeJAHQr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 03:16:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gQxvDeAUzF19Hv317MAIhM9SQHkrkQHugRaHVCvqq+A=;
 b=LGRieVbAwsnyjmcpLk+qGxx7IKsxj3KW2KDR7GETo98OXCoK++PX8/IcFuvbWQNQZjUw8JWSN8GytmRJAUzi5BkR3sOPXAeaUCO6dhgQgL888nPNVLQS4CgeWoeQz9n1gSEjee/igEdnkbNUqroCDpeOc5Y0wXmyYckGUgxdDqk=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0791.namprd21.prod.outlook.com (10.175.121.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.3; Mon, 1 Oct 2018 00:41:33 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1228.006; Mon, 1 Oct 2018
 00:41:33 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Dan Carpenter <dan.carpenter@oracle.com>,
        Steven French <Steven.French@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 14/17] cifs: read overflow in
 is_valid_oplock_break()
Thread-Topic: [PATCH AUTOSEL 4.4 14/17] cifs: read overflow in
 is_valid_oplock_break()
Thread-Index: AQHUWR+Aw1vEIkwHF0eKs+AO3XTefA==
Date:   Mon, 1 Oct 2018 00:41:33 +0000
Message-ID: <20181001004122.147276-14-alexander.levin@microsoft.com>
References: <20181001004122.147276-1-alexander.levin@microsoft.com>
In-Reply-To: <20181001004122.147276-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0791;6:RglV0aOZEY5Lgu6yCK/aTTLghZ9Xb32Z25wN3sB6ujdSKV1yeEDqonhxU5Zn9nTv3Oe+nHwbyV4mU/XeTNRgOwga07v5sByZakgnMR4Ok627FKQqqCSfUNuZsqP58TJ7JlICnP7Fpw1zKlFMM2/lv+iIcMNIjcpyJB7VGGcubF3rUI3S1wUL3BVCurtwKr8J4qRyKtEY40wHmi7VRF8Fd1f5ZdnWvJUxO0UidlQ9uf1abJfj7SWlqEnleNi8A2AmbYwrSnVKzviNsjrX4EcxPavshT7qrg151MKpToDuZ4sd9w6CyOtE0ymxT6fAlZBc5cPMf54b8YQp4G5U0JZXXIe6i6XT1oJGQZDA4MWFoKUQaAD4L/ZLxu2+uax5uaTlMKeBsh+c7oByV0q8uODJGSqsSP5L7fX/1kpDnXYXKd+meygUOLBaJQY5SJzc06S6DJEKb4gaukX/uj6UmXRe/A==;5:60MOp+2WA9mVBArFsyin1BvkQuYCK+vRzuplYiNK1zSQrQfaDJKCgamlQR82K+73Ii6SxAnv9JlUlZU66vByzzsim92MVfWwzUrimRSRs7dCWNpCDuVPf2kc4qnDc9yt6VZyf7dx/aK5Wja5q1qqj9rIU4n0YQxCP8veoXiO/tU=;7:yL9I91EAxSTTgIsqKujIo7isYa2usWN2fDZTfsM1gUP1xPR/DSBwqgYu8F+pDSFRmi6r/kMIGhcOrdgUoSMut2r5KpqTx/zzDpHSOayMNU8iMVW2yMWE1S5NftKSWXCkfhVMImSLWbY6heLYODXBnaPlG44IgZFd5vuC08CokmzTmH7wSvNiZu9Ctro3EFH8pQdbJUU2P0XyPPcInAgJyeTvjGNOGfUh3yTGxk5cq/RUzuBM9fq7BWO/x46FnQf6
x-ms-office365-filtering-correlation-id: 83299c02-a376-4c2e-92be-08d62736a2d7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0791;
x-ms-traffictypediagnostic: CY4PR21MB0791:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB07910D45018F7919B9A4E8A2FBEF0@CY4PR21MB0791.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(146099531331640)(85827821059158)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(10201501046)(3002001)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0791;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0791;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(346002)(396003)(366004)(376002)(39860400002)(189003)(199004)(69234005)(72206003)(71190400001)(478600001)(316002)(110136005)(14454004)(2616005)(54906003)(105586002)(107886003)(106356001)(186003)(305945005)(26005)(34290500001)(71200400001)(22452003)(7736002)(256004)(14444005)(25786009)(551934003)(10290500003)(99286004)(68736007)(53936002)(486006)(6512007)(446003)(66066001)(36756003)(6506007)(81166006)(81156014)(6486002)(5250100002)(575784001)(86362001)(2501003)(5660300001)(4326008)(11346002)(6116002)(476003)(3846002)(10090500001)(97736004)(1076002)(8676002)(8936002)(102836004)(217873002)(6436002)(76176011)(86612001)(2900100001)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0791;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: bkrNRDpUbJkvTRcmBXILKIhqlDmfQSv5UnFNNNqZG3H4iuMVgyKDg7n/Jw1bOWsOACTmdmO9Ct+KwUbX7ftilL+N/Q+DVllhT28eNM+BSv/oLDZxrVQE6t5T+ZDSm99fOarMNohB/MfMootdaxEi27mxvlkPHnuG7zcUsN5Mzg9WY1KIosu6R30STVmVxy1SDcOM0z4GG0+VeLUpkiY4VvbeSmEJ1RRh1glvb+tQMliMCD81tS3qyNyBomD298lC+5q5j1ZnKZ2XOki6ZMbaOxd/hDghNCXHcP0NbJjmugZQxhsqxq1uwPfO8aOYnI7ecxBPfRtAuHckZDvIaJlsqmtrd3fECuthLJKLhJ+phcc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83299c02-a376-4c2e-92be-08d62736a2d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 00:41:33.1716
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0791
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit 097f5863b1a0c9901f180bbd56ae7d630655faaa ]

We need to verify that the "data_offset" is within bounds.

Reported-by: Dr Silvio Cesare of InfoSect <silvio.cesare@gmail.com>
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Reviewed-by: Aurelien Aptel <aaptel@suse.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 fs/cifs/misc.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/cifs/misc.c b/fs/cifs/misc.c
index 0cc699d9b932..61a09ab2752e 100644
--- a/fs/cifs/misc.c
+++ b/fs/cifs/misc.c
@@ -406,9 +406,17 @@ is_valid_oplock_break(char *buffer, struct TCP_Server_=
Info *srv)
 			(struct smb_com_transaction_change_notify_rsp *)buf;
 		struct file_notify_information *pnotify;
 		__u32 data_offset =3D 0;
+		size_t len =3D srv->total_read - sizeof(pSMBr->hdr.smb_buf_length);
+
 		if (get_bcc(buf) > sizeof(struct file_notify_information)) {
 			data_offset =3D le32_to_cpu(pSMBr->DataOffset);
=20
+			if (data_offset >
+			    len - sizeof(struct file_notify_information)) {
+				cifs_dbg(FYI, "invalid data_offset %u\n",
+					 data_offset);
+				return true;
+			}
 			pnotify =3D (struct file_notify_information *)
 				((char *)&pSMBr->hdr.Protocol + data_offset);
 			cifs_dbg(FYI, "dnotify on %s Action: 0x%x\n",
--=20
2.17.1
