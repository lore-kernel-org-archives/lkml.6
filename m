Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFF3AC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:57:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F9B020867
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:57:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="MFSiaQxX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F9B020867
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387765AbeITI2y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 04:28:54 -0400
Received: from mail-eopbgr700094.outbound.protection.outlook.com ([40.107.70.94]:25376
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387719AbeITI2x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 04:28:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kF8KXYZApD1JUfQwz+TFhMqeXHxqlGA27oZ5QUd3zNc=;
 b=MFSiaQxX3wB/C2ZrcP8UCb8D9HnA3NNjSgOzpzIZ4zjEIXOHxI0MgM296KiXbTo5+tUCV2vliQ3hhdokWYwusU9jILHNaltpWgKK/S7/NoOFFNGbg50fE3IcOgNX+Ct22puIuPIeYL04NYcqM4SGKQOvOO0jCIm+JPLcRDO3OTs=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0822.namprd21.prod.outlook.com (10.173.192.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.6; Thu, 20 Sep 2018 02:47:38 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.010; Thu, 20 Sep 2018
 02:47:38 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     John Fastabend <john.fastabend@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 16/56] tls: possible hang when do_tcp_sendpages
 hits sndbuf is full case
Thread-Topic: [PATCH AUTOSEL 4.18 16/56] tls: possible hang when
 do_tcp_sendpages hits sndbuf is full case
Thread-Index: AQHUUIxLsYhaUdtCBkqA83CuwDzRlw==
Date:   Thu, 20 Sep 2018 02:47:38 +0000
Message-ID: <20180920024716.58490-16-alexander.levin@microsoft.com>
References: <20180920024716.58490-1-alexander.levin@microsoft.com>
In-Reply-To: <20180920024716.58490-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0822;6:DdmL3EBfXWsp0jSYKN4atMqIk6yfv6pzq7qlrHGXOBfDGNrd9LrYAQfHkMrNIO71sqoKHTCE1pf5uxx8PpWLbHsOLKMmLWUMIR7PPd6EevCMvLkRpKhIv0HNhSWZqwsZJuCuk4azYvegnFKgXy8yLab8i3YMRQdrPeapXUNw0snoJ3d9HXBQtN3zDRsrmcj90HjXx5jsPUWlzdXh4MOTMYbWiBfRXzOiLptxhuiD98HDlHlry00naUfx/JDY2xdXZMcWFJWifU8gFR5t/TrFnZ3S0/XfXlDEextnfjdfw4opfNnO518d70xBYfVlGXN4Ruz6avf4Hn3mK6cGqk4uC2aWqFkR7btG3+PSRXpi5EZ2/Bd5gC+m6gOfFJK9F52DCjzbPXJ3JA2TzQ7lGre6rLvQBDUGamWq1YuADWVXApU97o6BCQHjp1Nho/kOaAoGmi8RJw9Qf/zd+FVWAH7YUg==;5:Sp3JuXUBsfqOCQB21jIqa858R+lBkXhG0H7ne3d6Wza+t5GtAjDK1tw/2JzCkbnoURLHrmT0gUSY4KAiD1rDkGkdjrvEeokeN33FVFuSSKqj46TgHpXw2IhBoAuDmavYPFVZUFhGFPO35lPPOMAsOGM/h7k1lgGAeNyRC4XcLQI=;7:yzP5tCvQac5TEw+K3MeRkz6qvK2wvhV+HQUIBdCDDss7irRm6b1P8/5IdLHmab22vrX4DQQSy+MvcxvvaQAoACj3luvV4kEFACxS9U3PBkQkEiqTLYCKzF7waX+GDkS08vueBNbDekbjzFDaNqk6LBwxuDjQYwlrNk1Z4Tdu5XM4iS+HTtLEpDoGRkx0WgrsmH3oJunSlLYsiBiOwb0dSKjePMGnHT3+Ud0t/llDCBMlU3sgPLQryIhal/sD4dcu
x-ms-office365-filtering-correlation-id: cf64ba8c-2085-459c-88c4-08d61ea36db1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0822;
x-ms-traffictypediagnostic: CY4PR21MB0822:
x-microsoft-antispam-prvs: <CY4PR21MB082262FCCA4FABEFB748FFA2FB130@CY4PR21MB0822.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(266576461109395)(85827821059158)(67672495146484)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231355)(944501410)(52105095)(2018427008)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0822;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0822;
x-forefront-prvs: 0801F2E62B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(346002)(366004)(136003)(39860400002)(199004)(189003)(10290500003)(6512007)(54906003)(110136005)(2501003)(39060400002)(2900100001)(86612001)(446003)(6116002)(316002)(81156014)(81166006)(1076002)(26005)(8936002)(22452003)(86362001)(2906002)(107886003)(2616005)(486006)(256004)(14444005)(99286004)(66066001)(5660300001)(6506007)(217873002)(5250100002)(102836004)(186003)(3846002)(4326008)(6436002)(11346002)(25786009)(68736007)(71190400001)(71200400001)(8676002)(476003)(6346003)(6486002)(36756003)(14454004)(106356001)(10090500001)(53936002)(305945005)(72206003)(76176011)(7736002)(97736004)(478600001)(105586002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0822;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: rPmrFRKLXvMjd9CrFxadgiuaN0NRJ38OXfz0YxNzac+hMk9xPBwaQF4Zsrt6+ZfzKEATNpasZX2RJtMM1NIQPNoQvDSotcWOQP7tCRaBjhj9nsZ9p9ncncnC9LdAJZfh7op7qBV24lWTmyLo/6WZeTTVL4MywtMZGUz9z5+6nNnVa0ihYZpTFXYdqB3u2g2V07tnoVkLBD+tGdvZ9lXKhW0BmkME3WW57HeaW52BIkleZcxOY+oqUE9tp/rnG8bjKA+wtvSwHEXp7DKhwgNS/9exPkboEUSEaECTz+KuYoPg+7wDzbTDeRQYiBEPJsl9jGlObhgqXRB8BY6V3svG7ir3SiKrS45jkLpPSybeh4A=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf64ba8c-2085-459c-88c4-08d61ea36db1
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2018 02:47:38.6482
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0822
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
index 45188d920013..e9d33fc46fac 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -222,9 +222,14 @@ static void tls_write_space(struct sock *sk)
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
