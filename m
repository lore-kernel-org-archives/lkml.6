Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47BC3ECE565
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:20:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEFA8214C5
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:20:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="nqcetSE7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEFA8214C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730572AbeIQIpd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:45:33 -0400
Received: from mail-bl2nam02on0103.outbound.protection.outlook.com ([104.47.38.103]:18657
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729645AbeIQIaX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:30:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/4UthTZ0Xi30xGpHmAb2x4K220zlyatx76rxaiAVoEY=;
 b=nqcetSE755+HYQnK7hgToabbFQwzq9ZxkvNPxxJv32ixXx1M2DE9rCBXEwQiOcjoaY/Xc2DQsyZagNr4kPUh8OQgaM7O3CLMXXNfg+ZDhiAS3T8jT/jYnOPeyLnsia1OgUx/oig+VObIEIdNOcyMKh+hj/kbBYBTAYigqcTWMYg=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0133.namprd21.prod.outlook.com (10.173.189.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.11; Mon, 17 Sep 2018 03:04:59 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:04:59 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Andreas Gruenbacher <agruenba@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 74/87] iomap: complete partial direct I/O writes
 synchronously
Thread-Topic: [PATCH AUTOSEL 4.14 74/87] iomap: complete partial direct I/O
 writes synchronously
Thread-Index: AQHUTjL41lQb7aNja0O9+230DB7mBA==
Date:   Mon, 17 Sep 2018 03:03:12 +0000
Message-ID: <20180917030220.245686-74-alexander.levin@microsoft.com>
References: <20180917030220.245686-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030220.245686-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0133;6:Bbfv0lr/h4F5vQkMjfMAVHV7Zgx4d7KySooE2JRw1bd2p1wBPn/DQHE6tqTUfPZ77Ra5vvZnvo9qerri8diHlFrzEmPyV4RT4+0UDr5OBFuDXvjfgZ7x5kc0F1MiCgH7oqBlrXhMDe0KhYP0gGsFJTt2+KIpKx+0Y7ydZyqlr5Xp79emz1rOHipD/IkEuCAYeTA4LfsdYQw0hNBYFC0NTXacj3MsSDiJrGxUnhSEBHGUh3arGp/svj556vHFjRkJWhdWl0V7nrAmrXBzB8o5m9FxrG8mkEdn0aPEuSmDVqrYnPg24itcxpsN7ykqYfWxhzeK+chIJWqPXtAq2zWe9OqZxNlWAzJDceXe8eAWrcT07dswrXLpZL5kfWzl1uYz1E0xPGsK/qbYChSiQjWZ1igESocIb6baDWCHzH8d/gS15Va8L0d9bWAbD48a3YD1Irpvy/0WMcaA5sxNsyEusQ==;5:28QCm7G/sa9asQXFr4bRfmR9KoXI64DUH0m1bGeIEwr1GXkm/g8wBFD0w6YdIc+pWsCDmeaZcphKvN1YRM1XWdalzEl+IiCBB7Il9iHlovg0QafUwXL9un1Gi5Jb3q/76K63+Ki6+fIUUM/Ts+MLcmxekOlJmTq+Kpij05Nok4M=;7:Ig22jmgXJ1N6hDhkfr6odj+RPxgIdfP9+HjenPOgusvIniHRAADSfTHhEaGz3JJq2BamWtKYK/KjhRbs49WkuqWOlzkekgvkDH3nOF/dR0Zi2xT96opwenKQF4wmPoEQuFlbevZxcM5tm2gQHIT1zrRPTWyOvfJX/CYNVzEp/6zjvnVUFuyFURwgSEryNnDw+1cCIVzIAzBX5LAN/Cb3nrvWCMCpFRzR0OR1Ot4SnzKICBmvbdu12QGEktjQcHyr
x-ms-office365-filtering-correlation-id: b23e3a1c-6c4c-42ff-04f0-08d61c4a5b01
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0133;
x-ms-traffictypediagnostic: CY4PR21MB0133:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB013332B9A80AEF35E747A647FB1E0@CY4PR21MB0133.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(278428928389397)(146099531331640)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231355)(944501410)(52105095)(2018427008)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0133;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0133;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(396003)(39860400002)(376002)(346002)(189003)(199004)(102836004)(53936002)(8676002)(486006)(476003)(3846002)(6116002)(76176011)(10290500003)(97736004)(217873002)(256004)(5660300001)(107886003)(6506007)(478600001)(110136005)(2501003)(10090500001)(305945005)(7736002)(446003)(11346002)(36756003)(2906002)(1076002)(22452003)(5250100002)(2616005)(26005)(316002)(106356001)(25786009)(68736007)(86362001)(575784001)(14454004)(72206003)(105586002)(99286004)(6486002)(6436002)(6512007)(86612001)(6666003)(81166006)(81156014)(186003)(2900100001)(54906003)(8936002)(4326008)(66066001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0133;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: xOZmhxVgLHYwACZx2N1FbKNJxyQ1mBbdijQVZZ+s1ocDgoR7XlZUF45bIIzJKaNB8Ybeby9HvMbpV8DB4QuHa57DS+nqqrnYNL0WCG8l8MFNFwdpUp7fbIG9kT1A5XW4UYhlgrj0lLqjvjOxJxbe5d2FqoJAQGfWqcqBL3mpHyy6IhQnupnoWHCUL53mehBHj/YYtyLeynG6UcLiaFME300wIl/BQGO9LZ4VlQqtcbVAWbVLdqIW672S97sTJ0kjX8D3MsHXolezKUwuBEJeuP6XFQwvkZaCAfqgAt7UnWmxIOQBcXXKBJMK/HceECFooX7ZnprbQ7TGsqhiHwdJXh1Ojk9AtsZi+rsD1bnDJcU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b23e3a1c-6c4c-42ff-04f0-08d61c4a5b01
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:03:12.1184
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0133
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andreas Gruenbacher <agruenba@redhat.com>

[ Upstream commit ebf00be37de35788cad72f4f20b4a39e30c0be4a ]

According to xfstest generic/240, applications seem to expect direct I/O
writes to either complete as a whole or to fail; short direct I/O writes
are apparently not appreciated.  This means that when only part of an
asynchronous direct I/O write succeeds, we can either fail the entire
write, or we can wait for the partial write to complete and retry the
remaining write as buffered I/O.  The old __blockdev_direct_IO helper
has code for waiting for partial writes to complete; the new
iomap_dio_rw iomap helper does not.

The above mentioned fallback mode is needed for gfs2, which doesn't
allow block allocations under direct I/O to avoid taking cluster-wide
exclusive locks.  As a consequence, an asynchronous direct I/O write to
a file range that contains a hole will result in a short write.  In that
case, wait for the short write to complete to allow gfs2 to recover.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 fs/iomap.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/fs/iomap.c b/fs/iomap.c
index d4801f8dd4fd..8f7673a69273 100644
--- a/fs/iomap.c
+++ b/fs/iomap.c
@@ -693,6 +693,7 @@ struct iomap_dio {
 	atomic_t		ref;
 	unsigned		flags;
 	int			error;
+	bool			wait_for_completion;
=20
 	union {
 		/* used during submission and for synchronous completion: */
@@ -793,9 +794,8 @@ static void iomap_dio_bio_end_io(struct bio *bio)
 		iomap_dio_set_error(dio, blk_status_to_errno(bio->bi_status));
=20
 	if (atomic_dec_and_test(&dio->ref)) {
-		if (is_sync_kiocb(dio->iocb)) {
+		if (dio->wait_for_completion) {
 			struct task_struct *waiter =3D dio->submit.waiter;
-
 			WRITE_ONCE(dio->submit.waiter, NULL);
 			wake_up_process(waiter);
 		} else if (dio->flags & IOMAP_DIO_WRITE) {
@@ -980,13 +980,12 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *ite=
r,
 	dio->end_io =3D end_io;
 	dio->error =3D 0;
 	dio->flags =3D 0;
+	dio->wait_for_completion =3D is_sync_kiocb(iocb);
=20
 	dio->submit.iter =3D iter;
-	if (is_sync_kiocb(iocb)) {
-		dio->submit.waiter =3D current;
-		dio->submit.cookie =3D BLK_QC_T_NONE;
-		dio->submit.last_queue =3D NULL;
-	}
+	dio->submit.waiter =3D current;
+	dio->submit.cookie =3D BLK_QC_T_NONE;
+	dio->submit.last_queue =3D NULL;
=20
 	if (iov_iter_rw(iter) =3D=3D READ) {
 		if (pos >=3D dio->i_size)
@@ -1016,7 +1015,7 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *ite=
r,
 	WARN_ON_ONCE(ret);
 	ret =3D 0;
=20
-	if (iov_iter_rw(iter) =3D=3D WRITE && !is_sync_kiocb(iocb) &&
+	if (iov_iter_rw(iter) =3D=3D WRITE && !dio->wait_for_completion &&
 	    !inode->i_sb->s_dio_done_wq) {
 		ret =3D sb_init_dio_done_wq(inode->i_sb);
 		if (ret < 0)
@@ -1031,8 +1030,10 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *it=
er,
 				iomap_dio_actor);
 		if (ret <=3D 0) {
 			/* magic error code to fall back to buffered I/O */
-			if (ret =3D=3D -ENOTBLK)
+			if (ret =3D=3D -ENOTBLK) {
+				dio->wait_for_completion =3D true;
 				ret =3D 0;
+			}
 			break;
 		}
 		pos +=3D ret;
@@ -1046,7 +1047,7 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *ite=
r,
 		iomap_dio_set_error(dio, ret);
=20
 	if (!atomic_dec_and_test(&dio->ref)) {
-		if (!is_sync_kiocb(iocb))
+		if (!dio->wait_for_completion)
 			return -EIOCBQUEUED;
=20
 		for (;;) {
--=20
2.17.1
