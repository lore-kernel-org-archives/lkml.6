Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1878ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 12:50:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C0B620657
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 12:50:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="bTX+kfJs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C0B620657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729162AbeJaVrx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 17:47:53 -0400
Received: from mail-eopbgr80082.outbound.protection.outlook.com ([40.107.8.82]:57133
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728582AbeJaVrx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 17:47:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZSU6gig2dDF+bjWk5XU1U9ww1gFmlUL11zDk+l949wQ=;
 b=bTX+kfJsG1Zsup8OiE4BKIkDVeqR09NBH5KBXvLVQJ6Ozp1b7HngcS97XHZ6NYxpPqrXdncidIMNUpq+lKuKCF7FI+uY6aCOf8SA7WK8ICSVK7RJ60IGvq+gGPc9+98UqD1QMuZ+Rn2K9EnA5HzKpR+8UZEMETE1KXdzWS2+e3k=
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com (52.134.126.145) by
 AM0PR04MB5283.eurprd04.prod.outlook.com (20.177.42.80) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.21; Wed, 31 Oct 2018 12:49:52 +0000
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::989c:6296:ecdc:89ff]) by AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::989c:6296:ecdc:89ff%2]) with mapi id 15.20.1273.027; Wed, 31 Oct 2018
 12:49:52 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        David Howells <dhowells@redhat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
CC:     "J. Bruce Fields" <bfields@fieldses.org>,
        Jeff Layton <jlayton@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [RFC] sunrpc: Fix flood of warnings from iov_iter_kvec in linux-next
Thread-Topic: [RFC] sunrpc: Fix flood of warnings from iov_iter_kvec in
 linux-next
Thread-Index: AQHUcRg3TN/bKsDJj0m0E7u3lXqO1w==
Date:   Wed, 31 Oct 2018 12:49:52 +0000
Message-ID: <8a65d1322e08b9590d18a53cd623f71b0fe559e8.1540989230.git.leonard.crestez@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [95.76.156.53]
x-mailer: git-send-email 2.17.1
x-clientproxiedby: AM5PR0201CA0004.eurprd02.prod.outlook.com
 (2603:10a6:203:3d::14) To AM0PR04MB4290.eurprd04.prod.outlook.com
 (2603:10a6:208:67::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB5283;6:zRNbgwVvhy8a426UDV2OOvrxKsu2jlXLzdBFRHVEmLRF8K+DywZfb3yKwibkBpMtg5xA2Fqof5RXseHQhu+ou2SD79Q0E5UxM50+ivqcjmOp2oZnhIz2JX4hRBIsEF/kgihQTi37vCTOFnIcA3ZxARqt0k9JiXW19kqBZqsUmXWKq4G2WOK+8QDNwLs9jMlrGNUCcydx2o76K2ipgT40WJNaR9LgAQZNBuUKlE6A16y8k1oDkFIUJxWfNw4zNzdU/3xNHCZhhSRs3b4UJGF4oXmAxn3gjBjP9B9nTfJsdmJ8oQpFllPOCoceSNFsFqTIeQWlYSSevByOVwxUUVLXW+ftjAtshftjo+9FWfQWqjGhXysZRmI3vduQiZhwHmL56BpvtZZe1EkN1ucHFIgT7hTgjKsXIUEmZcAlRTSZg5jwYrbH/HgdTAu+zr/vEnxG4xqRVMuBgAu4T7l82Q5mXA==;5:M+1ExQF+/dWvFyAY1qHON2cXdCFudM34amLGo9BYD44YdbEKyVL31oM9iM+uPtWxivv1+YLSsszhUa1oJjVr5zTGnIrfWrFkRSuo6M3cTEVEfPCxMWpNnBX34e2IMvBcUwF2PpZDegUVJ4O9eudNJgfLwPuBnJQVZX1iAPR36So=;7:6YaLykY4aKV6xt0QlLZ9QoOAdN7vlzR+5+hJZar9Z/xFU9Zpx8fcj7yHp2zWKfl+plkMtiZJ7F3jFNMjeuIxy2iUDKx3rTKTRONhE+NVH8UXY+2LZ6XQvj6dTPR/8mSgJSzlSgULupL7ph3sXetEgw==
x-ms-office365-filtering-correlation-id: ca2c8aa2-b07a-4416-1684-08d63f2f5985
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB5283;
x-ms-traffictypediagnostic: AM0PR04MB5283:
x-microsoft-antispam-prvs: <AM0PR04MB528323D91FB2091D9F963724EECD0@AM0PR04MB5283.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231382)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:AM0PR04MB5283;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB5283;
x-forefront-prvs: 084285FC5C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(396003)(39860400002)(376002)(346002)(199004)(189003)(51234002)(71200400001)(118296001)(110136005)(71190400001)(36756003)(186003)(966005)(68736007)(4326008)(25786009)(305945005)(54906003)(316002)(97736004)(14444005)(2900100001)(5250100002)(256004)(7736002)(478600001)(486006)(86362001)(99286004)(2616005)(476003)(102836004)(386003)(6506007)(45080400002)(6436002)(6116002)(66066001)(3846002)(6486002)(53936002)(50226002)(8936002)(6306002)(81156014)(6512007)(8676002)(81166006)(105586002)(44832011)(2906002)(52116002)(106356001)(5660300001)(26005)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5283;H:AM0PR04MB4290.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 84KllBK9TQMtncLmo9/F57FsT2Y7STruVHrB708J6Fd6WQ00Zy0DbGSmTJQAlJHZt0fN48s6lHPfhHPqwaJpoPtchLHGWCu0LCM/K8zWKXtckiFeolBbXtJfHTabCYCQfKJaeKGUNI4qI+TeuUpEsRLqXg4ACZS8ojQpv9/6iL2LVUL02W7HUSsZnJWDRMfKt+ZNqn+Xtb4b22tedWH/nWz4UMDqhLIAZnZsBMn4uhRU4UI0gpB2Ui65KPi98xAt7bYK67ev29gygBxaMn1zL95rrWujTt7jkHWe7AcOJdYnPNTROAaFRin+I9alBtWCcX6rtTYcg+oM9AN29A/ZvVF5GXCo7LZJcTbi/ja79mM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca2c8aa2-b07a-4416-1684-08d63f2f5985
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2018 12:49:52.4598
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5283
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit aa563d7bca6e ("iov_iter: Separate type from direction and
use accessor functions") the iov_iter_kvec and iov_iter_bvec functions
warn if the direction parameter contains anything other than READ/WRITE.

That commit also updated users of iov_iter_kvec/bvec but a new call was
added on a different branch by commit 277e4ab7d530 ("SUNRPC: Simplify
TCP receive code by switching to using iterators")

This causes a flood of warnings in linux-next like this:

------------[ cut here ]------------
WARNING: CPU: 0 PID: 110 at ../lib/iov_iter.c:1082 iov_iter_kvec+0x4c/0x5c
Modules linked in:
CPU: 0 PID: 110 Comm: kworker/u3:2 Tainted: G        W         4.19.0-next-=
20181031 #157
Hardware name: Freescale i.MX6 SoloLite (Device Tree)
Workqueue: xprtiod xs_stream_data_receive_workfn
[<c0112908>] (unwind_backtrace) from [<c010d238>] (show_stack+0x10/0x14)
[<c010d238>] (show_stack) from [<c0b3894c>] (dump_stack+0xb0/0xe8)
[<c0b3894c>] (dump_stack) from [<c0126e14>] (__warn+0xe0/0x10c)
[<c0126e14>] (__warn) from [<c0126f54>] (warn_slowpath_null+0x3c/0x48)
[<c0126f54>] (warn_slowpath_null) from [<c04b225c>] (iov_iter_kvec+0x4c/0x5=
c)
[<c04b225c>] (iov_iter_kvec) from [<c0a2c650>] (xs_stream_data_receive_work=
fn+0x538/0x8e0)
[<c0a2c650>] (xs_stream_data_receive_workfn) from [<c014609c>] (process_one=
_work+0x2ac/0x6fc)
[<c014609c>] (process_one_work) from [<c014678c>] (worker_thread+0x2a0/0x57=
4)
[<c014678c>] (worker_thread) from [<c014c43c>] (kthread+0x134/0x14c)
[<c014c43c>] (kthread) from [<c01010b4>] (ret_from_fork+0x14/0x20)
Exception stack(0xec9fbfb0 to 0xec9fbff8)
bfa0:                                     00000000 00000000 00000000 000000=
00
bfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 000000=
00
bfe0: 00000000 00000000 00000000 00000000 00000013 00000000
irq event stamp: 91225
hardirqs last  enabled at (91233): [<c0186630>] console_unlock+0x3e4/0x5d0
hardirqs last disabled at (91250): [<c01862c8>] console_unlock+0x7c/0x5d0
softirqs last  enabled at (91266): [<c0102500>] __do_softirq+0x360/0x524
softirqs last disabled at (91277): [<c012e66c>] irq_exit+0xf8/0x1a4
---[ end trace bc12311e869d672a ]---

This fix updates sunrpc code and make nfs boot cleanly.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
---
 net/sunrpc/xprtsock.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

You can treat this as a bug report; I did a brief search and didn't see
anyone else complain about this specific issue. Big ugly stacktrace was
included so that it hopefully shows up in searches.

Here is a mention of a different conflict between iov_iter and sunrpc:
	https://lkml.org/lkml/2018/10/29/64

diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index 1b51e04d3566..ae77c71c1f64 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -359,20 +359,20 @@ xs_sock_recvmsg(struct socket *sock, struct msghdr *m=
sg, int flags, size_t seek)
=20
 static ssize_t
 xs_read_kvec(struct socket *sock, struct msghdr *msg, int flags,
 		struct kvec *kvec, size_t count, size_t seek)
 {
-	iov_iter_kvec(&msg->msg_iter, READ | ITER_KVEC, kvec, 1, count);
+	iov_iter_kvec(&msg->msg_iter, READ, kvec, 1, count);
 	return xs_sock_recvmsg(sock, msg, flags, seek);
 }
=20
 static ssize_t
 xs_read_bvec(struct socket *sock, struct msghdr *msg, int flags,
 		struct bio_vec *bvec, unsigned long nr, size_t count,
 		size_t seek)
 {
-	iov_iter_bvec(&msg->msg_iter, READ | ITER_BVEC, bvec, nr, count);
+	iov_iter_bvec(&msg->msg_iter, READ, bvec, nr, count);
 	return xs_sock_recvmsg(sock, msg, flags, seek);
 }
=20
 static ssize_t
 xs_read_discard(struct socket *sock, struct msghdr *msg, int flags,
--=20
2.17.1

