Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60D67ECE562
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:57:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A6C220867
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:57:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="JVA1tlv4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A6C220867
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388207AbeITIiV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 04:38:21 -0400
Received: from mail-bl2nam02on0137.outbound.protection.outlook.com ([104.47.38.137]:41534
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387629AbeITI2x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 04:28:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aWEAY4QIMmpNa5U1D9FKMoOzrzzTkqLwu/h+WpasRj4=;
 b=JVA1tlv4nwFozPH0t51mL47LQNsBe0qKOKft5TMxAGsxNFCqkAdk76q/Dtvd4KELHMXprvKTr9jmeXaNrDsUeIjebEjKNvAtWOAXLE1bO9I9pTqcdvC8BTqM+i5ElTO9AOSW/r5kkCZzSGItxiwxmBFWIvIaKOWtc+Z7pGHr3xs=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0822.namprd21.prod.outlook.com (10.173.192.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.6; Thu, 20 Sep 2018 02:47:42 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.010; Thu, 20 Sep 2018
 02:47:42 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     John Fastabend <john.fastabend@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 17/56] bpf: sockmap: write_space events need to
 be passed to TCP handler
Thread-Topic: [PATCH AUTOSEL 4.18 17/56] bpf: sockmap: write_space events need
 to be passed to TCP handler
Thread-Index: AQHUUIxLVp8hHM/0AEmlCC96s7BBSA==
Date:   Thu, 20 Sep 2018 02:47:39 +0000
Message-ID: <20180920024716.58490-17-alexander.levin@microsoft.com>
References: <20180920024716.58490-1-alexander.levin@microsoft.com>
In-Reply-To: <20180920024716.58490-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0822;6:mvLfftvLfbLukp4j9Ajz0Mlexh7PW0dcHjXJHB1MXsrUBDrdT/3QusVLj+FOpgLb4zZWXsFQD6pvJ0I8MOqVTkzQgz8I08WGaKPFIL5JJRc5S313KmmV/ohcPAtBGCi9GQGClIjf9b76y3WauzgHvP5uGdMy18raVMofsTXQzBgolyIf83lkP1m3va6cKjwAUBvibBxLTeCYtgggSw0M0wyeS0m3uolvKRELY03nJHXRCcNpOOlhwFGSaXJlz6AcqCntIvD1skrwDOmQMj9IeNG6lBU2meeEHsx1jjMeZThbSpXcFSQPJvVAqHfBshhJNjGQ8jnm8loqm04rJ6v2J+uODjSBjDsoiYzvzpCCBi22G1z9DFV/cxNtys3GTZuc/MvJRhrRgfHejfQJbe/N7uFTkEmbPvzjpM+RCcoe6HSBAL4PtRrv6UyKS5SEkBiqxwrswJhS5XK9tvjICAcUYw==;5:YbSbJVkeTJm/SQgr8IYcRxCZKkNyR5Hon5xt1TPR2dLBiBa2RCR33rPEAYmVZOhWp0AFTHp2vWszva7yRX+YUrgBBOorWESsCD69ko8BNQi/t+KZJS4N4fmEYtudEE4cD86VsPrgHMaY96lTxpzlPop2Ai+L5mVjbeYrU2oa7oE=;7:9vOROYjfOR/Z/QVAb83EGbfnJkJbzfySKkOWDOOcDGTqxhqmgcnj8SjZ+w0w67j28CsRrevXrTmeaEvZy4k8IT3ZROP+0MAyMMq154QKei32cY/ING+uXs1jGKOUp7PUooX1cDpx+aPg5cGH0cl3QpCqCUoJNX4vdaQ+aZFdOXuv3f93NubHFNn9CYLNvagvhqZ3qLbpkMstVYJD0+GTm6i1ghvcuPA/zx/a2sjP4swcU4r9yfzKhD+pfjhQ2kzs
x-ms-office365-filtering-correlation-id: 146a5fcc-5932-42d4-47d1-08d61ea36fb9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0822;
x-ms-traffictypediagnostic: CY4PR21MB0822:
x-microsoft-antispam-prvs: <CY4PR21MB08222D8305579365C817B49CFB130@CY4PR21MB0822.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231355)(944501410)(52105095)(2018427008)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0822;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0822;
x-forefront-prvs: 0801F2E62B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(346002)(366004)(136003)(39860400002)(199004)(189003)(10290500003)(6512007)(54906003)(110136005)(2501003)(39060400002)(2900100001)(86612001)(446003)(6116002)(316002)(81156014)(81166006)(1076002)(26005)(8936002)(22452003)(86362001)(2906002)(107886003)(2616005)(486006)(256004)(14444005)(99286004)(66066001)(5660300001)(6506007)(217873002)(5250100002)(102836004)(186003)(3846002)(4326008)(6436002)(11346002)(25786009)(68736007)(71190400001)(71200400001)(8676002)(476003)(6346003)(6486002)(36756003)(14454004)(106356001)(10090500001)(53936002)(305945005)(72206003)(76176011)(7736002)(97736004)(478600001)(105586002)(6666003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0822;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: hnOBX5WUkdFmfUx3Tn5+mo63kjHv678ZqAUgWQkcfEiLCBXoy5afPAhrx2VwhbZ4TS7SQq2ji73UMgha3nbmrdIjigIH9jZKW8JY1eIPPxDxTU/5drE757P21LM0oYD3jPDrIJjJOJN+QGN7u2XFW73XzpVuvuGTB5don9VZigEweFHer4wWZzQrEvniugw7ds706gMPp8Tx2aN+kbViCIdDSSR1V4qPGZhTIW5vNVjDrKoDiYGePQyakIkbCgOg6Nf1BIXFrcTjlfPjzH0xeoFXJVjYrUvhFPaUUAoEdet6BQHEMz0gHDEi2DYvr5/tlaYdmb5b9kgyTmsjGRu2bZh/n/IiJeliuGjPMouiBWI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 146a5fcc-5932-42d4-47d1-08d61ea36fb9
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2018 02:47:39.3826
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0822
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
index e7f65afc4e24..ed707b21d152 100644
--- a/kernel/bpf/sockmap.c
+++ b/kernel/bpf/sockmap.c
@@ -1430,12 +1430,15 @@ static void smap_tx_work(struct work_struct *w)
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
