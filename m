Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 153A1ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:02:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCC6C214C5
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:02:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="g/MK8XBm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCC6C214C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729589AbeIQI2D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:28:03 -0400
Received: from mail-by2nam03on0117.outbound.protection.outlook.com ([104.47.42.117]:22121
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729566AbeIQI2C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:28:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iyhw2Gfobxw53zKAGxn9AOeZCCvtXB8+u2uds+jnPhw=;
 b=g/MK8XBmvzTBVPCObt/c8eRYUemad85dqPZnz6+02RqKrE8e/+apyLqEJcrVtjpKa3vDuo58blSqc2qE3jHNZB+koujyh0djpjDbQYopSVONPH5pf7Y2WdMqJDHHHZ3YuWYhfVyywIrO4y5egrvzDj+R526L1m9CF4W+vaDPrGk=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0168.namprd21.prod.outlook.com (10.173.192.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.12; Mon, 17 Sep 2018 03:02:44 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:02:44 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Andreas Gruenbacher <agruenba@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 109/136] iomap: complete partial direct I/O
 writes synchronously
Thread-Topic: [PATCH AUTOSEL 4.18 109/136] iomap: complete partial direct I/O
 writes synchronously
Thread-Index: AQHUTjK2AbI1uztdJkqilGIDcn7uiQ==
Date:   Mon, 17 Sep 2018 03:01:21 +0000
Message-ID: <20180917030006.245495-109-alexander.levin@microsoft.com>
References: <20180917030006.245495-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030006.245495-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0168;6:M2CdbTLNdTGWSNqSVfK5W7+cywkxewT+Z8ALcsoTiPi8c1o7rukgzngNUZ0bHZCAHORVSRmuc/i0VIgW9qdhhFm5blIlQOUHj46MFeVFvBS6QdwXfc4DoBRpgAI/Oof5nu4zY4cy1m+mBIsf1BgalUg5nwVgj04YdXBwNrlsxnC2Rfw3p39fCVnAZEzwHJ1V7S+y0M7++USIrZ2urVYt9X7tQsqPWVTOdAxeOwLlM5r98Bi2PXHz/Rmk5ML6zrm3LA8W/TKydW1UYIz/RBqag1uq2io8Ch0C68tpnmfwsYVSlh3RD8ufZOtAtEwC0Bk/EXZu3AbAg6tGJIQUYbVZfUxp0P0+8u3hemoQyRee2HUFcLj0QLSxgfthTNqifnGNuvOi3tqS7uHoGKqS/egUsPK8IP3A6WlfSrGqcp68FXMUGvqWd6sXjFGaw9t+QBAIydXiJqNDzTM8uabBuxy7RQ==;5:mLUooblr7GTYEnDiTQWxMvlK2xerByAbfzuWiPjXWEcycKwmffuPJlz8PgVi18qlr5kNY4n2N/MEu6NDyHezM1W7LRh0ACysU2msuspvO49DpZGOhUBy09AOfXOOcHmVOumwX9tOBCqTDdiB8tufCEEpgVi/3H9wZ/FI/uJ05MU=;7:Nvx4LOOwD+LayUTaxjDi/6b/v7oOU9DATWIjBTMqxHtY0PjjnEomZ5d4tixavlw/7osYdHkNyVqp2mZb85xxHP78cYJeeaMDZcqtcjm8dNLZjUg/iwiy4I0ApqCkjlVENL0vQVhnhaotZNoDy6m+dgt4V6isaAhTgKJGZbn2D+2kZQnsq2zVnEbsniQWO69O926470FDMO3lvkKuaPPRXkcZC5ShYBbNwzXXv1hwQVbFNGUiX178EBsDvFFDDhsn
x-ms-office365-filtering-correlation-id: f1131c73-d4ed-4c88-0935-08d61c4a0a34
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0168;
x-ms-traffictypediagnostic: CY4PR21MB0168:
x-microsoft-antispam-prvs: <CY4PR21MB016899E7C0954951F2378C78FB1E0@CY4PR21MB0168.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(278428928389397)(146099531331640)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0168;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0168;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(366004)(39860400002)(346002)(136003)(199004)(189003)(11346002)(4326008)(105586002)(106356001)(486006)(446003)(6436002)(2616005)(22452003)(107886003)(10090500001)(25786009)(476003)(14454004)(110136005)(54906003)(316002)(2906002)(76176011)(99286004)(575784001)(36756003)(186003)(26005)(6346003)(5660300001)(7736002)(305945005)(10290500003)(8676002)(81156014)(81166006)(6486002)(68736007)(6666003)(102836004)(6116002)(3846002)(1076002)(53936002)(217873002)(72206003)(97736004)(6506007)(8936002)(86362001)(256004)(6512007)(2501003)(5250100002)(2900100001)(478600001)(66066001)(86612001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0168;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: H/COVEDmaNkTbJjsf+RSUYT4jzdmjkJn4vCpYMfelJIF9Nzv1KILLcWdZnwQvJm+NF1K9jEic/k/FWVNRqxYce7D1f9q2r66Sx8W3/GXqMe7dGj67xrnP/gN/ogPqpcjgoPJchkvY629UWURng4JeDJgz+gMMVTnhViXIjSveL/phiFvXzXROYJG1EAbVb2N/TgZYuniGmhYV8LM12DZuQZeckIHUWuTecT2/Se+MuA5SjhFNukoWNW6+nazpuxrSop7cJhc1A15ogWZXVC/LEHxpk6nb4hLuOASqwX4TBFWEet8RMlwlT0NZBmW0rjNTDRV6W7RNgAJbBK49e38do7sQkUTgVswS//PdPI9bI0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1131c73-d4ed-4c88-0935-08d61c4a0a34
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:01:21.0416
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0168
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
index 0d0bd8845586..af6144fd4919 100644
--- a/fs/iomap.c
+++ b/fs/iomap.c
@@ -811,6 +811,7 @@ struct iomap_dio {
 	atomic_t		ref;
 	unsigned		flags;
 	int			error;
+	bool			wait_for_completion;
=20
 	union {
 		/* used during submission and for synchronous completion: */
@@ -914,9 +915,8 @@ static void iomap_dio_bio_end_io(struct bio *bio)
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
@@ -1131,13 +1131,12 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *i=
ter,
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
@@ -1187,7 +1186,7 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *ite=
r,
 		dio_warn_stale_pagecache(iocb->ki_filp);
 	ret =3D 0;
=20
-	if (iov_iter_rw(iter) =3D=3D WRITE && !is_sync_kiocb(iocb) &&
+	if (iov_iter_rw(iter) =3D=3D WRITE && !dio->wait_for_completion &&
 	    !inode->i_sb->s_dio_done_wq) {
 		ret =3D sb_init_dio_done_wq(inode->i_sb);
 		if (ret < 0)
@@ -1202,8 +1201,10 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *it=
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
@@ -1224,7 +1225,7 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *ite=
r,
 		dio->flags &=3D ~IOMAP_DIO_NEED_SYNC;
=20
 	if (!atomic_dec_and_test(&dio->ref)) {
-		if (!is_sync_kiocb(iocb))
+		if (!dio->wait_for_completion)
 			return -EIOCBQUEUED;
=20
 		for (;;) {
--=20
2.17.1
