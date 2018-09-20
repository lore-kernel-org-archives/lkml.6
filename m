Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9947FECE562
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:49:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4879121521
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:49:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="OpRExXwc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4879121521
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388479AbeITIal (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 04:30:41 -0400
Received: from mail-eopbgr700120.outbound.protection.outlook.com ([40.107.70.120]:3328
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387646AbeITIak (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 04:30:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wawoB/JqVqlRDaOcR1GgcMjHLie/E2z41bnwFCgQ5Rw=;
 b=OpRExXwcYqpiOL8v7xKbWZEwGjy3GSaCTLEXx3hLrKmvno8d1HqnxEZGhin5SVeSeHRBUe/xuyF5SHl0lsWDDhiwAMhzj3zcoR3/x8bPFGSWy3hSjFg7eZJOaTBVFp4Xu6GjV7o1NUQx7lnSXLcv7Vr1UoHrokygrc0UX4yNiX0=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0119.namprd21.prod.outlook.com (10.173.189.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.4; Thu, 20 Sep 2018 02:49:11 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.010; Thu, 20 Sep 2018
 02:49:11 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     John Fastabend <john.fastabend@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 08/25] bpf: sockmap: write_space events need to
 be passed to TCP handler
Thread-Topic: [PATCH AUTOSEL 4.14 08/25] bpf: sockmap: write_space events need
 to be passed to TCP handler
Thread-Index: AQHUUIxj11GGQs0AhkC9Ea4qzG0LEw==
Date:   Thu, 20 Sep 2018 02:48:20 +0000
Message-ID: <20180920024810.58594-8-alexander.levin@microsoft.com>
References: <20180920024810.58594-1-alexander.levin@microsoft.com>
In-Reply-To: <20180920024810.58594-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0119;6:IMUw5DWaxyY5FEH2UUiTzAkokhleDCN+Xi6DJ7zCfkQ7zMw56HbkZV6hsRDI3mEn5PMw3Zc6TWEQZuvrwfgXFb04ESn1WQZAPoyiStxTOyuG99yrOLSYrkKOns9xxbz8mH0y+BTmPC8xVw8AUE/RmIhhMv8V+M9r9DdqMRxnAo4BiDzasNpk6zYUtvISd6Rqh4U33uTWIyO54wiinwrRjcgXy6e0UjvwfWAVo5k1byuoRtpgV+HFjcTY7RUKHGSYLpBh0AUfl1X8z0xtwm/nbo+zSyd+zUwU53HCjIKfRmRA0SNnF8Ejf2sCCDlhDzmCcHYn4QaLzb6VhzZgtOZn+sN1jZP6zeAE6OOwEJ7JTxkfEMAzZtfztnbxQu/6+dHQWKExyNRaCS5LL5YC5VMTMGW0kvs3k/Wo2v33e71btZIZmmTJ77j7WXSYPgVnC9kG1FQiis1VXfu6rGY9vbZJjw==;5:KZ2Uu9RTtt/cmKRDa9tfINGaDP0mqlU8sObk92hcEwQ7ApTXgwu98a2xMZLqtctGxvyoRvoCHF9K6YSFVYPxJuC3EyHASgc6BNkBJZdA3WtBQad/gGqBHrBdpFbTEgiphHiOa+FeAgCbGn8FICJmbQxXruMCHhGyIsdppIhQD/0=;7:uMb3aewUXi++65udQkr5CE04Tg/Trj9tgh/0R3dkgVx3q9kskRBK2JPA8mqwBTQhU7jHaoPN/0TF8+eKXjsv9ngBuJCbGEs+kNDfhzki8hcsPn8H/ICQVLEPR3553qbNzI6mGJtR2FYNEh11cgW9JFMqDWNCjyYOfB5fuLvnmOn0e/s3gpg3ZTZKuCOFcUjCMbh/CSQXAakWlMCLwSIDpd2+LwEdYvz16GNhbmRsBNDamUh8HjVkrXSwaImsCZep
x-ms-office365-filtering-correlation-id: dd6ad783-c3be-4364-356d-08d61ea3a4ca
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0119;
x-ms-traffictypediagnostic: CY4PR21MB0119:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0119F49CBC7FDB9AD1176FBDFB130@CY4PR21MB0119.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0119;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0119;
x-forefront-prvs: 0801F2E62B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(396003)(376002)(136003)(39860400002)(189003)(199004)(5660300001)(54906003)(1076002)(478600001)(10090500001)(72206003)(22452003)(107886003)(110136005)(316002)(68736007)(4326008)(76176011)(3846002)(6116002)(25786009)(14454004)(106356001)(39060400002)(99286004)(6666003)(105586002)(102836004)(6506007)(5250100002)(186003)(2501003)(26005)(6486002)(6436002)(53936002)(6512007)(66066001)(486006)(476003)(2616005)(10290500003)(11346002)(446003)(97736004)(36756003)(2900100001)(2906002)(8936002)(305945005)(217873002)(7736002)(86362001)(8676002)(86612001)(256004)(71200400001)(14444005)(71190400001)(81156014)(81166006);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0119;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 9eoJPaChdAR0X76Zh5ZeJ9noy9lWNa6GO1g8Z85j8cHl3OOhaONaM0cICoX5O4VsY84by/II4ukUxIAlvJGMmtbJIDmKGPFsmJuUnLHy4CBhOTpxSaT28QsyxIG6SU0bqsX23yCzKfAA9P0AtvwYXlaBzD6IhLtdJ0wxH7sgDQ/yge5Me+pbQKODQpKxQ7zGHsIxUhpcl+e3rZzVtzOMf+vhNj1+/d9rUVjJEvF+BYnps+AddA2iJEdXrIsptEt+yHYV4FUpYfb/j6xn0muBGRyhquF9AvUtPItK7gmosrhub1eGcom/7nuyXVI7XWdVQGQuS3smUCNl+w7oAO8de/3CV3jkBxhOIZ5EGffYkDQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd6ad783-c3be-4364-356d-08d61ea3a4ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2018 02:48:20.2415
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0119
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Fastabend <john.fastabend@gmail.com>

[ Upstream commit 9b2e0388bec8ec5427403e23faff3b58dd1c3200 ]

When sockmap code is using the stream parser it also handles the write
space events in order to handle the case where (a) verdict redirects
skb to another socket and (b) the sockmap then sends the skb but due
to memory constraints (or other EAGAIN errors) needs to do a retry.

But the initial code missed a third case where the
skb_send_sock_locked() triggers an sk_wait_event(). A typically case
would be when sndbuf size is exceeded. If this happens because we
do not pass the write_space event to the lower layers we never wake
up the event and it will wait for sndtimeo. Which as noted in ktls
fix may be rather large and look like a hang to the user.

To reproduce the best test is to reduce the sndbuf size and send
1B data chunks to stress the memory handling. To fix this pass the
event from the upper layer to the lower layer.

Signed-off-by: John Fastabend <john.fastabend@gmail.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 kernel/bpf/sockmap.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/bpf/sockmap.c b/kernel/bpf/sockmap.c
index 53a4787c08d8..20eaddfa691c 100644
--- a/kernel/bpf/sockmap.c
+++ b/kernel/bpf/sockmap.c
@@ -313,12 +313,15 @@ static void smap_tx_work(struct work_struct *w)
 static void smap_write_space(struct sock *sk)
 {
 	struct smap_psock *psock;
+	void (*write_space)(struct sock *sk);
=20
 	rcu_read_lock();
 	psock =3D smap_psock_sk(sk);
 	if (likely(psock && test_bit(SMAP_TX_RUNNING, &psock->state)))
 		schedule_work(&psock->tx_work);
+	write_space =3D psock->save_write_space;
 	rcu_read_unlock();
+	write_space(sk);
 }
=20
 static void smap_stop_sock(struct smap_psock *psock, struct sock *sk)
--=20
2.17.1
