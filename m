Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CC59ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:48:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D741E2098A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:48:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="oN7XyhVX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D741E2098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731083AbeIXUut (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 16:50:49 -0400
Received: from mail-eopbgr720093.outbound.protection.outlook.com ([40.107.72.93]:21257
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730115AbeIXUur (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:50:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qa9dP8m1RLG2osKJIAbVKAMLRTBxuJ97BfAZFfh5Upg=;
 b=oN7XyhVX+ZcgxZ070GTpLNfpbLT8BHoZRGTmrxQEJOBmH9P1ZvmKu87c4wpvLKCQI7M5nDZfLQIVdfBzZYxA52xl3Al0tNhhqph5OvenAqF4ub5vDkfEIu6cpVoz/k1lCp7V4xi+Fl58wPYi3iu550dVVAXG7cHQkIdD6pWg2GA=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0821.namprd21.prod.outlook.com (10.173.192.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.3; Mon, 24 Sep 2018 14:48:13 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1207.003; Mon, 24 Sep 2018
 14:48:13 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 20/76] bpf: fix several offset tests in
 bpf_msg_pull_data
Thread-Topic: [PATCH AUTOSEL 4.18 20/76] bpf: fix several offset tests in
 bpf_msg_pull_data
Thread-Index: AQHUVBWej8ngv/OZTEiC1KI7g0MoZg==
Date:   Mon, 24 Sep 2018 14:48:13 +0000
Message-ID: <20180924144751.164410-20-alexander.levin@microsoft.com>
References: <20180924144751.164410-1-alexander.levin@microsoft.com>
In-Reply-To: <20180924144751.164410-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0821;6:Aq2ebywaEs+1xZcjIc8GgU8B14hF4l6YjjDwcjNWsyTI05Gee90ytF1QZ3hTv21DiJK+f8neyDfUzKs1peOgHKnnsPa7gCHYgQ9RiXnWj8UokgRahtkinTY/djtXa80ya8k9Oq0K7yyKatvTNbf8781lrY+8X/p2GrPGwKgfV6MkZPAjKY8uNB8aBmXX6W2IumHKcwJ89kkKArdTt5NBAZPhb3obOCQu/a3cJtV5fleAxUrKfVcR9Xu1BuQhe3tbrRspB3eu/P0sYcx1lIhvPhhJfaYgp98sGLEW1MbC7aFsXfiMAx+226yXKAx1jAGnliZw4eWkeCzCExj7Av4J0JRpjBnWR6n0c6Gl/T/Hxfzkr2hTxIx1Bmj58uRPYukFpEMFdSr2T9UrsNgXAncRtcl9ewG3IUN87GB6VQKyzLzn89DoLKm3NKFIEFO5zRKdO85X5g8wfbvW9IMLi67dLQ==;5:umtXrpctoBuZQqDiyRbNFNrrtrygkKmHEXJ67+FM6aHdCqbVUiPDV4twZSbt2+RzqZkArrHdkwES7TLM4FN0eq0Cr7eZ0bwfStZl3/MWDiPiRnU5v2QBaNX4B7xebn1SL51rp6OF2qMXtSXCmGLXX8JiLjLsCU/1H1g93TkHqv8=;7:d6XwQPHgaih9riVOB/FELKEiB53I2bGl4GAaeO+LpHj3x1tK8P4kcuZwL7U/SIrZcy1GXxRK8WRU2qkmqf401joOKR5KUHBBrZhtnKxMOTP/vBK324DffY0FpmBopecSdejRH9HbEBJ4KrSF7qThIIg0VDfigIW6RXyTyUIyxYS2uc8uFGzx2VKsicbL0y9DaAHwcX6QEyCXrYrI20mr1bJd+lCWEy7Wt2gR/AjYF8L37rc5cKkX1DfqCksJwB6V
x-ms-office365-filtering-correlation-id: 48a638dd-126c-46d0-5f02-08d6222cc11e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0821;
x-ms-traffictypediagnostic: CY4PR21MB0821:
x-microsoft-antispam-prvs: <CY4PR21MB0821E18E8BDB9567315FE897FB170@CY4PR21MB0821.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(6055026)(149066)(150027)(6041310)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0821;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0821;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(136003)(376002)(346002)(39860400002)(189003)(199004)(2900100001)(86612001)(81166006)(81156014)(8676002)(8936002)(1076002)(4326008)(25786009)(3846002)(6116002)(86362001)(99286004)(486006)(76176011)(54906003)(71190400001)(71200400001)(22452003)(316002)(106356001)(105586002)(6346003)(478600001)(10290500003)(6506007)(26005)(7736002)(305945005)(72206003)(186003)(476003)(446003)(11346002)(14454004)(2616005)(110136005)(217873002)(6486002)(53936002)(102836004)(5660300001)(14444005)(256004)(6512007)(6436002)(107886003)(66066001)(97736004)(36756003)(10090500001)(2501003)(68736007)(5250100002)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0821;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: 4f+JHqetUUZnKbZLtNhg40CAlo01ujqGGUnXz2Fzl3gTOgoq2upE5D997xzMF0QlYRaaMCrX2IVawMTu/CRSBik+cQOOe4TnbBIjQ4fnA09beUtexbsZqKLP0vt2zRDqNzgyhZ80+8/PW5NxcOVuEygqxBdYZCGUilpfkkijgEL28If5DVNpJ5SC4jjhFFnSxeW5tFGiUhjAv4W6jM2zm7315U4Esjz4wwB6meAujEpnZlD+k1cRd+Bmow368NyOWyrTCUsuk9XC624Ke9isdhhoLdF6Z4dwbFHySDspQ4K6AfNWFG7S+5jtc9SxdnWG4JJqWAKDzGmBP/96AeyR8iD+blou3XCDvhGQ5bGH5pc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48a638dd-126c-46d0-5f02-08d6222cc11e
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 14:48:13.1881
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0821
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Borkmann <daniel@iogearbox.net>

[ Upstream commit 5b24109b0563d45094c470684c1f8cea1af269f8 ]

While recently going over bpf_msg_pull_data(), I noticed three
issues which are fixed in here:

1) When we attempt to find the first scatterlist element (sge)
   for the start offset, we add len to the offset before we check
   for start < offset + len, whereas it should come after when
   we iterate to the next sge to accumulate the offsets. For
   example, given a start offset of 12 with a sge length of 8
   for the first sge in the list would lead us to determine this
   sge as the first sge thinking it covers first 16 bytes where
   start is located, whereas start sits in subsequent sges so
   we would end up pulling in the wrong data.

2) After figuring out the starting sge, we have a short-cut test
   in !msg->sg_copy[i] && bytes <=3D len. This checks whether it's
   not needed to make the page at the sge private where we can
   just exit by updating msg->data and msg->data_end. However,
   the length test is not fully correct. bytes <=3D len checks
   whether the requested bytes (end - start offsets) fit into the
   sge's length. The part that is missing is that start must not
   be sge length aligned. Meaning, the start offset into the sge
   needs to be accounted as well on top of the requested bytes
   as otherwise we can access the sge out of bounds. For example
   the sge could have length of 8, our requested bytes could have
   length of 8, but at a start offset of 4, so we also would need
   to pull in 4 bytes of the next sge, when we jump to the out
   label we do set msg->data to sg_virt(&sg[i]) + start - offset
   and msg->data_end to msg->data + bytes which would be oob.

3) The subsequent bytes < copy test for finding the last sge has
   the same issue as in point 2) but also it tests for less than
   rather than less or equal to. Meaning if the sge length is of
   8 and requested bytes of 8 while having the start aligned with
   the sge, we would unnecessarily go and pull in the next sge as
   well to make it private.

Fixes: 015632bb30da ("bpf: sk_msg program helper bpf_sk_msg_pull_data")
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: John Fastabend <john.fastabend@gmail.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/core/filter.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 9dfd145eedcc..a9f8d71575c7 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2276,10 +2276,10 @@ BPF_CALL_4(bpf_msg_pull_data,
 	   struct sk_msg_buff *, msg, u32, start, u32, end, u64, flags)
 {
 	unsigned int len =3D 0, offset =3D 0, copy =3D 0;
+	int bytes =3D end - start, bytes_sg_total;
 	struct scatterlist *sg =3D msg->sg_data;
 	int first_sg, last_sg, i, shift;
 	unsigned char *p, *to, *from;
-	int bytes =3D end - start;
 	struct page *page;
=20
 	if (unlikely(flags || end <=3D start))
@@ -2289,9 +2289,9 @@ BPF_CALL_4(bpf_msg_pull_data,
 	i =3D msg->sg_start;
 	do {
 		len =3D sg[i].length;
-		offset +=3D len;
 		if (start < offset + len)
 			break;
+		offset +=3D len;
 		i++;
 		if (i =3D=3D MAX_SKB_FRAGS)
 			i =3D 0;
@@ -2300,7 +2300,11 @@ BPF_CALL_4(bpf_msg_pull_data,
 	if (unlikely(start >=3D offset + len))
 		return -EINVAL;
=20
-	if (!msg->sg_copy[i] && bytes <=3D len)
+	/* The start may point into the sg element so we need to also
+	 * account for the headroom.
+	 */
+	bytes_sg_total =3D start - offset + bytes;
+	if (!msg->sg_copy[i] && bytes_sg_total <=3D len)
 		goto out;
=20
 	first_sg =3D i;
@@ -2320,12 +2324,12 @@ BPF_CALL_4(bpf_msg_pull_data,
 		i++;
 		if (i =3D=3D MAX_SKB_FRAGS)
 			i =3D 0;
-		if (bytes < copy)
+		if (bytes_sg_total <=3D copy)
 			break;
 	} while (i !=3D msg->sg_end);
 	last_sg =3D i;
=20
-	if (unlikely(copy < end - start))
+	if (unlikely(bytes_sg_total > copy))
 		return -EINVAL;
=20
 	page =3D alloc_pages(__GFP_NOWARN | GFP_ATOMIC, get_order(copy));
--=20
2.17.1
