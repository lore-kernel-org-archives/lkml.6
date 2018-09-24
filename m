Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DEAFECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:49:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D385C2098A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:49:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="KssQMCHw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D385C2098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732936AbeIXUve (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 16:51:34 -0400
Received: from mail-bn3nam01on0094.outbound.protection.outlook.com ([104.47.33.94]:39765
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732151AbeIXUvc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:51:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JwO8YWOlkcyVqJyU5KYEyVSUq6+yl8pLlYjC39DxexM=;
 b=KssQMCHwn57uoH9gxmo/vejmygXs2mLSx13qB6FG43mV1rEp5UH106+a7eBkQzM3LVlrwLogGW9iph+FEr9Xso1y1LdJucTrfOlMZyyceahr5misWJF5oxKlf1RTTfYIE5ojVNvouUyPp6bOUuvDkJLXjhNaT0Hwi88SrVMorqI=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0744.namprd21.prod.outlook.com (10.173.189.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.2; Mon, 24 Sep 2018 14:48:58 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1207.003; Mon, 24 Sep 2018
 14:48:58 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     John Fastabend <john.fastabend@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 51/76] bpf: avoid misuse of psock when
 TCP_ULP_BPF collides with another ULP
Thread-Topic: [PATCH AUTOSEL 4.18 51/76] bpf: avoid misuse of psock when
 TCP_ULP_BPF collides with another ULP
Thread-Index: AQHUVBWq7w5BF4AKPECMLAfGNCmnOw==
Date:   Mon, 24 Sep 2018 14:48:32 +0000
Message-ID: <20180924144751.164410-50-alexander.levin@microsoft.com>
References: <20180924144751.164410-1-alexander.levin@microsoft.com>
In-Reply-To: <20180924144751.164410-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0744;6:PBHggVQjoGRDDEdCr7rYz6LfnXh9OI+rpUa2aOK4bwhzX/tmWTjivUay/mLcsEyaxQKwDdpT5MPy7GLNeFazr5NCmqVaAgPOvQA+9BpwW5Swxd8DcgvgC5U6wbIWwfHZYYYPpXGEUy/bz2WHYzgyZF54ugjPXUE3z4qAWvz/InJV4fympDPN/O1GU/BL9vXjotjLjBX/4OSwL5C1+U348orRhiZ0EHIy62o6gKgrp2kEb55NJBk6ReA+A3yOHLse4eQ6ozph/9NrfAQSA1f1kI7gdHh7HZvHpMMPBjfLZAgz4xe+fAh3pkUP3mmEYyGGdp3+GHub07128zkYZrUJiQDvd2GpRpvk7guXDntDurBGANKUsO7L4jIPjAE/nsrb+tojbPs5gzmz7N9bcoPwukDW/r1vB/tskFUvL92bqDuWZbIl6aqCnUUzAz+MGmRT3CIQVopd4p7BlcRwrrpFjw==;5:v04UhZ4YLLaDJYgkzMh5PjaLnEtA0v/xo6OcxycBrCVckuTNsUXIfA44flg3tcnscsQLW3ZudhTyoYeV67OP52EXdoW89F1Pzck1D2DlgIcoD464FJ3EcJfeFv8l/Et/ifJpViL4P9ob9qfXoOnM0Jck3vSqjxFV4zpum5dP06I=;7:pKMiDc0fQYgS2C94b732PR+gurtGBfVOe9hFhieZZKNxbO+TMuOLfMMwXFDqjhSw/7gVptR2fIzKfZGqDl/D1EkfJmVEPdStkz85Iwqn5LndlTE5hp/g6ayPxMsSZNkk2xQKSBkk++Y7+kJZfnQ9IS+gTWZuVAqMnrVVm9MYVuVnwvHgXCq6vY5G0PAKtf2Wjuz2DdCLYkaoH8OjPOMVcaKrSVMh4bfOiDa6nT94Iu34S4NjpC1+76f8xLST0W/v
x-ms-office365-filtering-correlation-id: faf017b7-866c-4e4d-06a6-08d6222cdc3f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0744;
x-ms-traffictypediagnostic: CY4PR21MB0744:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0744E915F7812D434A09E577FB170@CY4PR21MB0744.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(2018427008)(10201501046)(93006095)(93001095)(3002001)(6055026)(149066)(150027)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0744;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0744;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(346002)(39860400002)(376002)(366004)(189003)(199004)(11346002)(446003)(476003)(86362001)(575784001)(186003)(81166006)(6506007)(8676002)(81156014)(6666003)(5660300001)(486006)(99286004)(53936002)(305945005)(6512007)(6436002)(2616005)(71200400001)(71190400001)(68736007)(6486002)(102836004)(10090500001)(7736002)(36756003)(97736004)(86612001)(316002)(3846002)(6116002)(1076002)(217873002)(14444005)(256004)(54906003)(110136005)(107886003)(10290500003)(4326008)(478600001)(39060400002)(22452003)(5250100002)(26005)(8936002)(2906002)(2501003)(2900100001)(66066001)(72206003)(105586002)(14454004)(76176011)(25786009)(106356001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0744;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: QDEwGPQ4fJAQAcmJkycI7NJkQcswHHqkHpH52USGfuhTveqUZdfCb62InTY8d3y4cpboM/VHhs5Mx7ztyLb2XVFcGG00GbJNAMndL8QZalFpTyHnmBj5CIJh9pTldieszs13qYMTCBfkw5F2U63cCHg1lRgyzXm9BVxU2qumzK0nyPPVo8VX0wqBf/el/2whszPhO2S8vmueX1VEXSnNGTMwtUDFTRNP3rEQ9DUl42fhEaDw0fuZWEnFJJQ6hhI45cucyaTcXs6ghrK/DdUDn8Iu920MSWxDE2YCdkqEI/7EPlo0CGTfptbNdOGXx7/YPKRqnuBAEzG/KR8z/wPJaAbNmL5+KJQpPz9/S4h1nlQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: faf017b7-866c-4e4d-06a6-08d6222cdc3f
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 14:48:32.8913
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0744
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Fastabend <john.fastabend@gmail.com>

[ Upstream commit 597222f72a94118f593e4f32bf58ae7e049a0df1 ]

Currently we check sk_user_data is non NULL to determine if the sk
exists in a map. However, this is not sufficient to ensure the psock
or the ULP ops are not in use by another user, such as kcm or TLS. To
avoid this when adding a sock to a map also verify it is of the
correct ULP type. Additionally, when releasing a psock verify that
it is the TCP_ULP_BPF type before releasing the ULP. The error case
where we abort an update due to ULP collision can cause this error
path.

For example,

  __sock_map_ctx_update_elem()
     [...]
     err =3D tcp_set_ulp_id(sock, TCP_ULP_BPF) <- collides with TLS
     if (err)                                <- so err out here
        goto out_free
     [...]
  out_free:
     smap_release_sock() <- calling tcp_cleanup_ulp releases the
                            TLS ULP incorrectly.

Fixes: 2f857d04601a ("bpf: sockmap, remove STRPARSER map_flags and add mult=
i-map support")
Signed-off-by: John Fastabend <john.fastabend@gmail.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 kernel/bpf/sockmap.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/sockmap.c b/kernel/bpf/sockmap.c
index 2ddf1501aace..9463e135812e 100644
--- a/kernel/bpf/sockmap.c
+++ b/kernel/bpf/sockmap.c
@@ -1462,10 +1462,16 @@ static void smap_destroy_psock(struct rcu_head *rcu=
)
 	schedule_work(&psock->gc_work);
 }
=20
+static bool psock_is_smap_sk(struct sock *sk)
+{
+	return inet_csk(sk)->icsk_ulp_ops =3D=3D &bpf_tcp_ulp_ops;
+}
+
 static void smap_release_sock(struct smap_psock *psock, struct sock *sock)
 {
 	if (refcount_dec_and_test(&psock->refcnt)) {
-		tcp_cleanup_ulp(sock);
+		if (psock_is_smap_sk(sock))
+			tcp_cleanup_ulp(sock);
 		write_lock_bh(&sock->sk_callback_lock);
 		smap_stop_sock(psock, sock);
 		write_unlock_bh(&sock->sk_callback_lock);
@@ -1892,6 +1898,10 @@ static int __sock_map_ctx_update_elem(struct bpf_map=
 *map,
 	 * doesn't update user data.
 	 */
 	if (psock) {
+		if (!psock_is_smap_sk(sock)) {
+			err =3D -EBUSY;
+			goto out_progs;
+		}
 		if (READ_ONCE(psock->bpf_parse) && parse) {
 			err =3D -EBUSY;
 			goto out_progs;
--=20
2.17.1
