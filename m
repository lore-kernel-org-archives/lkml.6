Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDCDDC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:51:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83B6521521
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:51:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="nY5fg3Ko"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83B6521521
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388466AbeITIak (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 04:30:40 -0400
Received: from mail-eopbgr700120.outbound.protection.outlook.com ([40.107.70.120]:3328
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388413AbeITIah (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 04:30:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r92wez6QEt4RRugQocd7dKSjLCJu7IgD5iWQgqsTRAc=;
 b=nY5fg3Ko3FccIrAk5emgfRh6QwZblO+fftUqShiWErWPpSHGck148PkyiNwMtHPRn1MfkpwtcxhuzS8a5N6JIuryCuQ3DE5ocPvQlpgie470d2Dk8tuxqRfxyhPGdAMO0ahTwPCbxBX5rOhzfRmQnumj/7wv3SJngcAslAOvo8Q=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0119.namprd21.prod.outlook.com (10.173.189.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.4; Thu, 20 Sep 2018 02:49:10 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.010; Thu, 20 Sep 2018
 02:49:10 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     John Fastabend <john.fastabend@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 07/25] tls: possible hang when do_tcp_sendpages
 hits sndbuf is full case
Thread-Topic: [PATCH AUTOSEL 4.14 07/25] tls: possible hang when
 do_tcp_sendpages hits sndbuf is full case
Thread-Index: AQHUUIxjcDLu9I9VXEe/6+hQFbi2Mg==
Date:   Thu, 20 Sep 2018 02:48:19 +0000
Message-ID: <20180920024810.58594-7-alexander.levin@microsoft.com>
References: <20180920024810.58594-1-alexander.levin@microsoft.com>
In-Reply-To: <20180920024810.58594-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0119;6:XG80ENRcE1tdqvb5GjXSpXEoawF9WVZ3RaZHfTHVbccU0i4Xs/E+ril320ICQCpSDW5VtnjyGpuCexXL5TXEGx+nPvVLYyrhBn49hJOI7pSZIO0X1+HiIThz/RbFZMxDeOT8PEdN+df5XC1G/U3MmS24tfxm85dVrH4Dm923vSBAgiWEpU8zfebc/gJKqCl6b9mRX89WNVW0PHK27yOcCuSvBQ/MK7nvDOv30rF70x8JbX/V6Lrm03uZiafuVrv/LxPZyZ2j3JDTHq0hQww2vdqiJlu6XGXETCuzSX6KZ+RtBqZLs/8NW/GqRB7VqfSTzp8vrsLYTOtjwiKUnkoRUq6wMp2FGJHlPr7ndgNaCZZ87ZZ0tKAci8ZXXmaIvfZH6XkfiR4sF6YnaS6e1R5ICybyVGyDCe9Aug5IcGzMI80VChiys/BJoO5IFVwuj9JMlzuJaYCLBu+hCSNu7FKeag==;5:MZqhKZNrES8JsDf4rT3Yre6ivUDiT2EBleV9y4uSyV7XYdGW8DzzJYq61exhDHLCWtWLh+zLLM2Ml4fiSe3fw9cAShsndCwWC/NDnZDVAYwpxmh61dFHcXEYigcSILmDLCOWWBVqYIoZFeVdmXuuIh6E569L+l565HxWFpIuzs8=;7:DZ7ClLBrlpnq/4VcULC0XWR4228LqtOW8auSZol+I+Rpfj8Ne8R6PdKhHvC+hKZcG72mmsFYgsDg/m7bCviMNdfjXaP6NvJgprvas6XxKJgMIZWwkAVAL7vmlVGWRDQZ2x8mInx8c4pk+Z1eRwFJ+vBCHwCAwt2HsSJdE9T+uIU2O4odkmlqNPcSMa1E2vhCxJNjlDIIqcCZx6M15bOnL99LCPakgCo/cKroioxwSIQT+EtU/lP4KlKZKAThNbnF
x-ms-office365-filtering-correlation-id: 3477dd14-a79d-4301-af21-08d61ea3a482
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0119;
x-ms-traffictypediagnostic: CY4PR21MB0119:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB01190A48EB1AF8B9405EEFE7FB130@CY4PR21MB0119.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(266576461109395)(85827821059158)(67672495146484)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0119;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0119;
x-forefront-prvs: 0801F2E62B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(396003)(376002)(136003)(39860400002)(189003)(199004)(5660300001)(54906003)(1076002)(478600001)(10090500001)(72206003)(22452003)(107886003)(110136005)(316002)(68736007)(4326008)(76176011)(3846002)(6116002)(25786009)(14454004)(106356001)(39060400002)(99286004)(105586002)(102836004)(6506007)(5250100002)(186003)(2501003)(26005)(6486002)(6436002)(53936002)(6512007)(66066001)(486006)(476003)(2616005)(10290500003)(11346002)(446003)(97736004)(36756003)(2900100001)(2906002)(8936002)(305945005)(217873002)(7736002)(86362001)(8676002)(86612001)(256004)(71200400001)(14444005)(71190400001)(81156014)(81166006);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0119;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: P/e4ycDe9xgpgWx1iCmzcg65DlV5J6PAkpKKxK+si1i0EfJrV3kkwi9gaWNKBFa7V3vsmDRtgTtuFkbcl0gqhe1FZXHi6c8LZ1qwcF/jOQUT8sYRqrjGA1OxWHKAGvUb3kL0BPSkgsosaw7hXm1uOkjWwcwc17I2Ya4jq4YwFmS7U7ZgSRodiZ+61IoTYVo500y/q76fdL4v5COYBABPrwgzGXwunm2fBQkPX65PDr/UsQ4IlWmeWTnhUUfA8hfXjz2TgBdHhLNC5lVeb3G2ccets1Iqd3U/hKz3KE60aLwyLuS6yaNiBIiCxuaR2BLwFW7jmT39BcZU6yW6OMBo88jWcO9gfJ+IAvYkWvHXjfs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3477dd14-a79d-4301-af21-08d61ea3a482
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2018 02:48:19.4134
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0119
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Fastabend <john.fastabend@gmail.com>

[ Upstream commit 67db7cd249e71f64346f481b629724376d063e08 ]

Currently, the lower protocols sk_write_space handler is not called if
TLS is sending a scatterlist via  tls_push_sg. However, normally
tls_push_sg calls do_tcp_sendpage, which may be under memory pressure,
that in turn may trigger a wait via sk_wait_event. Typically, this
happens when the in-flight bytes exceed the sdnbuf size. In the normal
case when enough ACKs are received sk_write_space() will be called and
the sk_wait_event will be woken up allowing it to send more data
and/or return to the user.

But, in the TLS case because the sk_write_space() handler does not
wake up the events the above send will wait until the sndtimeo is
exceeded. By default this is MAX_SCHEDULE_TIMEOUT so it look like a
hang to the user (especially this impatient user). To fix this pass
the sk_write_space event to the lower layers sk_write_space event
which in the TCP case will wake any pending events.

I observed the above while integrating sockmap and ktls. It
initially appeared as test_sockmap (modified to use ktls) occasionally
hanging. To reliably reproduce this reduce the sndbuf size and stress
the tls layer by sending many 1B sends. This results in every byte
needing a header and each byte individually being sent to the crypto
layer.

Signed-off-by: John Fastabend <john.fastabend@gmail.com>
Acked-by: Dave Watson <davejwatson@fb.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/tls/tls_main.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index 055b9992d8c7..fa011318ffe4 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -195,9 +195,14 @@ static void tls_write_space(struct sock *sk)
 {
 	struct tls_context *ctx =3D tls_get_ctx(sk);
=20
-	/* We are already sending pages, ignore notification */
-	if (ctx->in_tcp_sendpages)
+	/* If in_tcp_sendpages call lower protocol write space handler
+	 * to ensure we wake up any waiting operations there. For example
+	 * if do_tcp_sendpages where to call sk_wait_event.
+	 */
+	if (ctx->in_tcp_sendpages) {
+		ctx->sk_write_space(sk);
 		return;
+	}
=20
 	if (!sk->sk_write_pending && tls_is_pending_closed_record(ctx)) {
 		gfp_t sk_allocation =3D sk->sk_allocation;
--=20
2.17.1
