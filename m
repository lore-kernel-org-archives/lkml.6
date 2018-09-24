Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F888C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:50:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C767E20684
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:50:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="daspmzOQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C767E20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388263AbeIXUwp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 16:52:45 -0400
Received: from mail-eopbgr720121.outbound.protection.outlook.com ([40.107.72.121]:64608
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731114AbeIXUwo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:52:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0aYdaNvSr4skqqd7z1a/X9HiB4Gkm6jBAxa0HCt9nCE=;
 b=daspmzOQeaHubsS4tOUxAEL+itAONa914noo61gIE/6aCQuVhYXacsPg9v6wXLjG2gHWu7J19Zbnx6t2HzUHA2n5S0uxTQQwSh9IKsTGdW57mvCpo3TviPYabxGLiGGOks4dQ85YNY7jZpQuFm4uCs3Wua7YLQtiFNO/1tlvHkM=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0134.namprd21.prod.outlook.com (10.173.189.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.9; Mon, 24 Sep 2018 14:48:08 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1207.003; Mon, 24 Sep 2018
 14:48:08 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     John Fastabend <john.fastabend@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 13/76] bpf: sockmap, decrement copied count
 correctly in redirect error case
Thread-Topic: [PATCH AUTOSEL 4.18 13/76] bpf: sockmap, decrement copied count
 correctly in redirect error case
Thread-Index: AQHUVBWb3j/P0f2gv0uvpeAjFQ6WgA==
Date:   Mon, 24 Sep 2018 14:48:07 +0000
Message-ID: <20180924144751.164410-13-alexander.levin@microsoft.com>
References: <20180924144751.164410-1-alexander.levin@microsoft.com>
In-Reply-To: <20180924144751.164410-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0134;6:wqiF9PGQYU2rCVzgJMtA+8ublSohD/R5Z4Wj+YnvP6eyZCNIEon4LI4SW2HgOfkqb9N656jHFwDpo5Z+VNcRJa7IOQffvP3PkNVrz4eFpmSlVo8d7kp1pdEfaFieDcvgLzkCxicqU4pexxswkeE5jMtdzJG2t10CFkzNYXhcGPJl4IfetMCDUtUUliDpQ7T9DBO9AoBZasExmDaGAt7EumoeRKh5Yc6cgBbZawx/togD9dgkxIcWQGrmUC1sPSFaZtAp52wFPHnDEutrOHdIsHO+S5NkdXzpe8MTCOcWBVLwtCyQItCKp+F4CHB2noVANfaVEAeVy3zgwTH/7PhSdPL6NsBuXLHhtNsewSHvyzYXbUx4SFv8ijvLkZfGa+/RKBpP/49QOelNjUQOg0NDU8mA2ttD/B10ieM6fps9nH3F35y1FpsmDcMN+Zt92Bb3HjMs/DLl63bSEn9gB8BZDw==;5:2GapaWh0Uicc4l0Q1V79Re2RQErvvJGFbJ9PKDkIRJDaEYR4z2PJQrQN8iCH+kiUVXTcsjur97OmpVbZmFZ/fQ8PHm4J9wVcbj7tdEUCqGvrUDhtW/f2EKwAwBfF5YkeX+Yvk/QfNh2HDGNIBVohCDk8v4z97D19/7op4st8X7U=;7:PTgZhaTiphfamrgV4Bk5fRyywabYNIIEKzqAe2RpouSvKYKThw1qZbHdCEKEgLE5CcpS1Z2JMJL2U1n//utl+n+oOlGsLPYlekJzEoNqBk9DLMe1a3K9WlEuK+yVlhvPFCPokD5PrJJ3DYTAsx9dkSIP5LDCh21FRlGSoIOP+7EQnCbpUCR0m4kvdMDYVTpKAOpchPl1bL4P8n3pnjeqA+mRBn8kov5R4CzsjgKGSIfz3jszQ3rvNkrgOmu7HFSx
x-ms-office365-filtering-correlation-id: f844e706-f785-4964-5bc4-08d6222cbe01
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0134;
x-ms-traffictypediagnostic: CY4PR21MB0134:
x-microsoft-antispam-prvs: <CY4PR21MB01342D2DE1FDDB971D283A75FB170@CY4PR21MB0134.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149066)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0134;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0134;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(136003)(39860400002)(366004)(396003)(199004)(189003)(2900100001)(86612001)(3846002)(106356001)(97736004)(105586002)(478600001)(10290500003)(36756003)(71200400001)(71190400001)(575784001)(6116002)(8936002)(76176011)(186003)(5250100002)(217873002)(2501003)(8676002)(2616005)(102836004)(26005)(81166006)(81156014)(476003)(14444005)(11346002)(446003)(256004)(305945005)(54906003)(486006)(68736007)(86362001)(6486002)(5660300001)(99286004)(4326008)(2906002)(7736002)(110136005)(6346003)(6506007)(6512007)(53936002)(6436002)(25786009)(107886003)(39060400002)(1076002)(14454004)(10090500001)(316002)(72206003)(22452003)(66066001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0134;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: i5S2KaDsYObEVxL04Gj2tVdFAprBUtIELuGa6zuAKj/FTOe5PcLZhY19T06/RCsFsZfC7BAx97htOuOLjgiyKXP4vCOVJ6kA2TF46v2QmUhX7Ho7nQCq2E/BhKNTJgsHEQh7j+39Nsc4pgZLhOithPwU67//wt9Kn49wvVKHRBtFZ8w20XR773lrO1Nx1QWX2Wh3R63wEfzN2vnppv5oNF/Yev/3WTdx89MuZ851+tlolSpkEsWqengmiOuVLoMiZp1vq2W/zHWAY1PuHD2Bn9z7IjBrEuXkP2dXGdhd5/GvwSCVFsOqgvhCwyV/iqhYWcoxOYpi4XqZ+YJkSKbblNWyMqJeKRMuXfDUoWwjjBk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f844e706-f785-4964-5bc4-08d6222cbe01
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 14:48:07.6585
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0134
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Fastabend <john.fastabend@gmail.com>

[ Upstream commit 501ca81760c204ec59b73e4a00bee5971fc0f1b1 ]

Currently, when a redirect occurs in sockmap and an error occurs in
the redirect call we unwind the scatterlist once in the error path
of bpf_tcp_sendmsg_do_redirect() and then again in sendmsg(). Then
in the error path of sendmsg we decrement the copied count by the
send size.

However, its possible we partially sent data before the error was
generated. This can happen if do_tcp_sendpages() partially sends the
scatterlist before encountering a memory pressure error. If this
happens we need to decrement the copied value (the value tracking
how many bytes were actually sent to TCP stack) by the number of
remaining bytes _not_ the entire send size. Otherwise we risk
confusing userspace.

Also we don't need two calls to free the scatterlist one is
good enough. So remove the one in bpf_tcp_sendmsg_do_redirect() and
then properly reduce copied by the number of remaining bytes which
may in fact be the entire send size if no bytes were sent.

To do this use bool to indicate if free_start_sg() should do mem
accounting or not.

Signed-off-by: John Fastabend <john.fastabend@gmail.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 kernel/bpf/sockmap.c | 45 ++++++++++++++++++++++----------------------
 1 file changed, 22 insertions(+), 23 deletions(-)

diff --git a/kernel/bpf/sockmap.c b/kernel/bpf/sockmap.c
index e43730b52ea6..2ddf1501aace 100644
--- a/kernel/bpf/sockmap.c
+++ b/kernel/bpf/sockmap.c
@@ -236,7 +236,7 @@ static int bpf_tcp_init(struct sock *sk)
 }
=20
 static void smap_release_sock(struct smap_psock *psock, struct sock *sock)=
;
-static int free_start_sg(struct sock *sk, struct sk_msg_buff *md);
+static int free_start_sg(struct sock *sk, struct sk_msg_buff *md, bool cha=
rge);
=20
 static void bpf_tcp_release(struct sock *sk)
 {
@@ -248,7 +248,7 @@ static void bpf_tcp_release(struct sock *sk)
 		goto out;
=20
 	if (psock->cork) {
-		free_start_sg(psock->sock, psock->cork);
+		free_start_sg(psock->sock, psock->cork, true);
 		kfree(psock->cork);
 		psock->cork =3D NULL;
 	}
@@ -330,14 +330,14 @@ static void bpf_tcp_close(struct sock *sk, long timeo=
ut)
 	close_fun =3D psock->save_close;
=20
 	if (psock->cork) {
-		free_start_sg(psock->sock, psock->cork);
+		free_start_sg(psock->sock, psock->cork, true);
 		kfree(psock->cork);
 		psock->cork =3D NULL;
 	}
=20
 	list_for_each_entry_safe(md, mtmp, &psock->ingress, list) {
 		list_del(&md->list);
-		free_start_sg(psock->sock, md);
+		free_start_sg(psock->sock, md, true);
 		kfree(md);
 	}
=20
@@ -570,14 +570,16 @@ static void free_bytes_sg(struct sock *sk, int bytes,
 	md->sg_start =3D i;
 }
=20
-static int free_sg(struct sock *sk, int start, struct sk_msg_buff *md)
+static int free_sg(struct sock *sk, int start,
+		   struct sk_msg_buff *md, bool charge)
 {
 	struct scatterlist *sg =3D md->sg_data;
 	int i =3D start, free =3D 0;
=20
 	while (sg[i].length) {
 		free +=3D sg[i].length;
-		sk_mem_uncharge(sk, sg[i].length);
+		if (charge)
+			sk_mem_uncharge(sk, sg[i].length);
 		if (!md->skb)
 			put_page(sg_page(&sg[i]));
 		sg[i].length =3D 0;
@@ -594,9 +596,9 @@ static int free_sg(struct sock *sk, int start, struct s=
k_msg_buff *md)
 	return free;
 }
=20
-static int free_start_sg(struct sock *sk, struct sk_msg_buff *md)
+static int free_start_sg(struct sock *sk, struct sk_msg_buff *md, bool cha=
rge)
 {
-	int free =3D free_sg(sk, md->sg_start, md);
+	int free =3D free_sg(sk, md->sg_start, md, charge);
=20
 	md->sg_start =3D md->sg_end;
 	return free;
@@ -604,7 +606,7 @@ static int free_start_sg(struct sock *sk, struct sk_msg=
_buff *md)
=20
 static int free_curr_sg(struct sock *sk, struct sk_msg_buff *md)
 {
-	return free_sg(sk, md->sg_curr, md);
+	return free_sg(sk, md->sg_curr, md, true);
 }
=20
 static int bpf_map_msg_verdict(int _rc, struct sk_msg_buff *md)
@@ -718,7 +720,7 @@ static int bpf_tcp_ingress(struct sock *sk, int apply_b=
ytes,
 		list_add_tail(&r->list, &psock->ingress);
 		sk->sk_data_ready(sk);
 	} else {
-		free_start_sg(sk, r);
+		free_start_sg(sk, r, true);
 		kfree(r);
 	}
=20
@@ -755,14 +757,10 @@ static int bpf_tcp_sendmsg_do_redirect(struct sock *s=
k, int send,
 		release_sock(sk);
 	}
 	smap_release_sock(psock, sk);
-	if (unlikely(err))
-		goto out;
-	return 0;
+	return err;
 out_rcu:
 	rcu_read_unlock();
-out:
-	free_bytes_sg(NULL, send, md, false);
-	return err;
+	return 0;
 }
=20
 static inline void bpf_md_init(struct smap_psock *psock)
@@ -825,7 +823,7 @@ static int bpf_exec_tx_verdict(struct smap_psock *psock=
,
 	case __SK_PASS:
 		err =3D bpf_tcp_push(sk, send, m, flags, true);
 		if (unlikely(err)) {
-			*copied -=3D free_start_sg(sk, m);
+			*copied -=3D free_start_sg(sk, m, true);
 			break;
 		}
=20
@@ -848,16 +846,17 @@ static int bpf_exec_tx_verdict(struct smap_psock *pso=
ck,
 		lock_sock(sk);
=20
 		if (unlikely(err < 0)) {
-			free_start_sg(sk, m);
+			int free =3D free_start_sg(sk, m, false);
+
 			psock->sg_size =3D 0;
 			if (!cork)
-				*copied -=3D send;
+				*copied -=3D free;
 		} else {
 			psock->sg_size -=3D send;
 		}
=20
 		if (cork) {
-			free_start_sg(sk, m);
+			free_start_sg(sk, m, true);
 			psock->sg_size =3D 0;
 			kfree(m);
 			m =3D NULL;
@@ -1124,7 +1123,7 @@ static int bpf_tcp_sendmsg(struct sock *sk, struct ms=
ghdr *msg, size_t size)
 		err =3D sk_stream_wait_memory(sk, &timeo);
 		if (err) {
 			if (m && m !=3D psock->cork)
-				free_start_sg(sk, m);
+				free_start_sg(sk, m, true);
 			goto out_err;
 		}
 	}
@@ -1580,13 +1579,13 @@ static void smap_gc_work(struct work_struct *w)
 		bpf_prog_put(psock->bpf_tx_msg);
=20
 	if (psock->cork) {
-		free_start_sg(psock->sock, psock->cork);
+		free_start_sg(psock->sock, psock->cork, true);
 		kfree(psock->cork);
 	}
=20
 	list_for_each_entry_safe(md, mtmp, &psock->ingress, list) {
 		list_del(&md->list);
-		free_start_sg(psock->sock, md);
+		free_start_sg(psock->sock, md, true);
 		kfree(md);
 	}
=20
--=20
2.17.1
