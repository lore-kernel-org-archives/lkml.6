Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41C98ECE562
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:47:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E578221522
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:47:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="O8g2FlBc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E578221522
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387837AbeITI25 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 04:28:57 -0400
Received: from mail-eopbgr700094.outbound.protection.outlook.com ([40.107.70.94]:25376
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387789AbeITI25 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 04:28:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RvbkoSdiElqNGdyDsjNq5XkkpMCqcXJI34D6ug5RXbQ=;
 b=O8g2FlBcNoBCNg0REABzN/dTjssBMFtkRJjHizkKmX4X5D0rx8tGcu+xkU58N+pe4EGOjtS6Vb3kfC1du9QET222lyVnok7OHQLrBP1wZxK5ktXh9ZLlFnmkLpRLeiJPVHnlN6BR0OFVThfJ+8e3l1tzqecuDO1KFqjYD1raq8g=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0822.namprd21.prod.outlook.com (10.173.192.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.6; Thu, 20 Sep 2018 02:47:44 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.010; Thu, 20 Sep 2018
 02:47:44 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Kevin Yang <yyd@google.com>, Neal Cardwell <ncardwell@google.com>,
        Yuchung Cheng <ycheng@google.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 22/56] tcp_bbr: add bbr_check_probe_rtt_done()
 helper
Thread-Topic: [PATCH AUTOSEL 4.18 22/56] tcp_bbr: add
 bbr_check_probe_rtt_done() helper
Thread-Index: AQHUUIxNWA/V1AmseE63MtCSUOxjEA==
Date:   Thu, 20 Sep 2018 02:47:42 +0000
Message-ID: <20180920024716.58490-22-alexander.levin@microsoft.com>
References: <20180920024716.58490-1-alexander.levin@microsoft.com>
In-Reply-To: <20180920024716.58490-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0822;6:nvXcQtTboI+tO/q4zVmNRj8eu7h8E1V/FS96X7weWvjOkNF/MgDpO10cE33z5HnWXV9hbEeUURuaWg/6DynW1zQ3JzXuv6h0YPtiGf1CfhSkRi9JW48vpAHBunr4jZA3MfPX4jygSJlc617zNa1NtBp4xuPciPfWdpvibkwHy+tfYHgwE78tOVAtyz5RP/Cyuc/zZwOqeo1H4cMAs3wvtY/u4tTZZDhO/N3hWCtDXTnlac/pYq5i+tImzDb+f9h7kqkhpHeuMn67QnnndyEEuAH9m9O2TAVId6YDAhIArJo3Zil4wFIfNL36Cg3cFnbxnL6y3EcWYaB2xV4cVk6CRFj4ZEPQDfoRI08mK+R+6KJXNyTnzODGRtXCITU3K695fxnHwqasaBWqWPZGEmbGu5h8cacaAaSf3NWibv7Pv/x8ZDvJl5w7nskfzYDPavALh49lCoWvpbjQDIvrTfJDcQ==;5:C0jzDteF43RUayg+rTfi/Ley0WItF82hTamN0oeCPslRjDc06y9INzjS0SRGFhWzjOifcPXVarfwcyTN9hBSn+C6hSHqvxl+o1pwvKefuX1Evvhm+l4qLMiJ+i9JmQdw081ORF53bTS6eOGBKkDwtw0ZM8vihTneOJWMZE/+aFM=;7:5MzKSHdUsqe2Tihq0SpDvv+W0GqOKu6AxRDZcp83mY6481tFq0toqrVkynGmJd/IcnISvU1Wknw5UbFjayOewKTIUXJS6QwB3i1pZM89uOIPf0mRWbebWfrY8MOapCFYYzCSKRNizLGrT9VSFsvw2L1tTZxRW+vzVb8TBzJuYhb4xi7LkqjdozZdpCOnj53/CF/wkwVnGMK6meHH/fkUsZjohx1crx+QNYA7b7p/O9pHb4e7QlGMb9Wsp9jKmHds
x-ms-office365-filtering-correlation-id: 47767d82-4d59-4306-ac29-08d61ea37123
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0822;
x-ms-traffictypediagnostic: CY4PR21MB0822:
x-microsoft-antispam-prvs: <CY4PR21MB0822F492AD9D20007AA582C1FB130@CY4PR21MB0822.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(211936372134217)(153496737603132)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231355)(944501410)(52105095)(2018427008)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0822;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0822;
x-forefront-prvs: 0801F2E62B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(346002)(366004)(136003)(39860400002)(199004)(189003)(10290500003)(6512007)(54906003)(110136005)(2501003)(2900100001)(86612001)(446003)(6116002)(316002)(81156014)(81166006)(1076002)(26005)(8936002)(22452003)(86362001)(2906002)(107886003)(2616005)(486006)(256004)(14444005)(99286004)(66066001)(5660300001)(6506007)(217873002)(5250100002)(102836004)(186003)(3846002)(4326008)(6436002)(11346002)(25786009)(68736007)(71190400001)(71200400001)(8676002)(476003)(6346003)(6486002)(36756003)(14454004)(106356001)(10090500001)(53936002)(305945005)(72206003)(76176011)(7736002)(97736004)(478600001)(105586002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0822;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: /xX0bXI8GBYsV0QzwcecpDaXlnPAH9pjge3BdCkmfbUZz8O3+O0uc9naVCYwkercLizMtoOcrDml6X60+qxzWud7qBjm3UYXCbnKKE1BFqfI09zU9OMu1n+UiFhETkzoCBlQ28z3Dx7koaEEv2CtN/myTcHMafK4p+3IO7oBogsD5pfJH5lANIBzbVP1whj7MB7WpMbbog3dUKyH4fINHF7AxF/FETHFZBu1RzJsXbTor/iyVweC9qUwevj+l8TIwOC3D014jOtvrWe/cc5cdQGBp2jnF+faf2tzRcZn2JEPokbSct7jqW2w9E/87IZ0+rqiFGFUAY+xSrhLJiqad12WlDiCaQ2TA8hJRV5/K1I=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47767d82-4d59-4306-ac29-08d61ea37123
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2018 02:47:42.5388
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0822
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kevin Yang <yyd@google.com>

[ Upstream commit fb99886224294b2291d267da41395022fa4200e2 ]

This patch add a helper function bbr_check_probe_rtt_done() to
  1. check the condition to see if bbr should exit probe_rtt mode;
  2. process the logic of exiting probe_rtt mode.

Fixes: 0f8782ea1497 ("tcp_bbr: add BBR congestion control")
Signed-off-by: Kevin Yang <yyd@google.com>
Signed-off-by: Neal Cardwell <ncardwell@google.com>
Signed-off-by: Yuchung Cheng <ycheng@google.com>
Reviewed-by: Soheil Hassas Yeganeh <soheil@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/ipv4/tcp_bbr.c | 34 ++++++++++++++++++----------------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/net/ipv4/tcp_bbr.c b/net/ipv4/tcp_bbr.c
index 4bfff3c87e8e..5880015dee36 100644
--- a/net/ipv4/tcp_bbr.c
+++ b/net/ipv4/tcp_bbr.c
@@ -95,11 +95,10 @@ struct bbr {
 	u32     mode:3,		     /* current bbr_mode in state machine */
 		prev_ca_state:3,     /* CA state on previous ACK */
 		packet_conservation:1,  /* use packet conservation? */
-		restore_cwnd:1,	     /* decided to revert cwnd to old value */
 		round_start:1,	     /* start of packet-timed tx->ack round? */
 		idle_restart:1,	     /* restarting after idle? */
 		probe_rtt_round_done:1,  /* a BBR_PROBE_RTT round at 4 pkts? */
-		unused:12,
+		unused:13,
 		lt_is_sampling:1,    /* taking long-term ("LT") samples now? */
 		lt_rtt_cnt:7,	     /* round trips in long-term interval */
 		lt_use_bw:1;	     /* use lt_bw as our bw estimate? */
@@ -392,17 +391,11 @@ static bool bbr_set_cwnd_to_recover_or_restore(
 		cwnd =3D tcp_packets_in_flight(tp) + acked;
 	} else if (prev_state >=3D TCP_CA_Recovery && state < TCP_CA_Recovery) {
 		/* Exiting loss recovery; restore cwnd saved before recovery. */
-		bbr->restore_cwnd =3D 1;
+		cwnd =3D max(cwnd, bbr->prior_cwnd);
 		bbr->packet_conservation =3D 0;
 	}
 	bbr->prev_ca_state =3D state;
=20
-	if (bbr->restore_cwnd) {
-		/* Restore cwnd after exiting loss recovery or PROBE_RTT. */
-		cwnd =3D max(cwnd, bbr->prior_cwnd);
-		bbr->restore_cwnd =3D 0;
-	}
-
 	if (bbr->packet_conservation) {
 		*new_cwnd =3D max(cwnd, tcp_packets_in_flight(tp) + acked);
 		return true;	/* yes, using packet conservation */
@@ -744,6 +737,20 @@ static void bbr_check_drain(struct sock *sk, const str=
uct rate_sample *rs)
 		bbr_reset_probe_bw_mode(sk);  /* we estimate queue is drained */
 }
=20
+static void bbr_check_probe_rtt_done(struct sock *sk)
+{
+	struct tcp_sock *tp =3D tcp_sk(sk);
+	struct bbr *bbr =3D inet_csk_ca(sk);
+
+	if (!(bbr->probe_rtt_done_stamp &&
+	      after(tcp_jiffies32, bbr->probe_rtt_done_stamp)))
+		return;
+
+	bbr->min_rtt_stamp =3D tcp_jiffies32;  /* wait a while until PROBE_RTT */
+	tp->snd_cwnd =3D max(tp->snd_cwnd, bbr->prior_cwnd);
+	bbr_reset_mode(sk);
+}
+
 /* The goal of PROBE_RTT mode is to have BBR flows cooperatively and
  * periodically drain the bottleneck queue, to converge to measure the tru=
e
  * min_rtt (unloaded propagation delay). This allows the flows to keep que=
ues
@@ -802,12 +809,8 @@ static void bbr_update_min_rtt(struct sock *sk, const =
struct rate_sample *rs)
 		} else if (bbr->probe_rtt_done_stamp) {
 			if (bbr->round_start)
 				bbr->probe_rtt_round_done =3D 1;
-			if (bbr->probe_rtt_round_done &&
-			    after(tcp_jiffies32, bbr->probe_rtt_done_stamp)) {
-				bbr->min_rtt_stamp =3D tcp_jiffies32;
-				bbr->restore_cwnd =3D 1;  /* snap to prior_cwnd */
-				bbr_reset_mode(sk);
-			}
+			if (bbr->probe_rtt_round_done)
+				bbr_check_probe_rtt_done(sk);
 		}
 	}
 	/* Restart after idle ends only once we process a new S/ACK for data */
@@ -858,7 +861,6 @@ static void bbr_init(struct sock *sk)
 	bbr->has_seen_rtt =3D 0;
 	bbr_init_pacing_rate_from_rtt(sk);
=20
-	bbr->restore_cwnd =3D 0;
 	bbr->round_start =3D 0;
 	bbr->idle_restart =3D 0;
 	bbr->full_bw_reached =3D 0;
--=20
2.17.1
