Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 051C5C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:09:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DCF32064D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:09:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="HfKgb4q8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DCF32064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729497AbeIXVMM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 17:12:12 -0400
Received: from mail-eopbgr720093.outbound.protection.outlook.com ([40.107.72.93]:21257
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731151AbeIXUuy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:50:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AOlibVdUI6Ao64Q+kxtHXv47vtcuD7BK7+x7faM8jWg=;
 b=HfKgb4q8q/xS8KJxwUue/rUlTz4k7bS7M2olaF9yOPvN+hNx9lxHfWwrRZOGjH9VEFUOFmoIJA1ry44hm8NNatzqV+seqasJd07tp3HQrlCeexeBIeJMWRWMYcM4x6C/7/KSEUG1gGWIMcGBUlGRYOyRh08aC15ExNYzBYwC+9A=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0821.namprd21.prod.outlook.com (10.173.192.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.3; Mon, 24 Sep 2018 14:48:17 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1207.003; Mon, 24 Sep 2018
 14:48:17 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 27/76] bpf: fix msg->data/data_end after sg shift
 repair in bpf_msg_pull_data
Thread-Topic: [PATCH AUTOSEL 4.18 27/76] bpf: fix msg->data/data_end after sg
 shift repair in bpf_msg_pull_data
Thread-Index: AQHUVBWhCeSZRQ415EqtgigSJLDVaQ==
Date:   Mon, 24 Sep 2018 14:48:17 +0000
Message-ID: <20180924144751.164410-27-alexander.levin@microsoft.com>
References: <20180924144751.164410-1-alexander.levin@microsoft.com>
In-Reply-To: <20180924144751.164410-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0821;6:d0U9iidJ1wjhcs7cYzweZNZqL/ONvKnDWpJ0Vb9JZuzXwINsV1yc2zrdiqM+oQGbXY+1TPSxGXeXbguIU298X4JPZ4N1EQVKUjlAzGAoA3DJJHuHlfARVLGeoWzGBKfqfSYcBzr6R0H+wGUWd3hryZdouY8ZTHXWHjrSJtix7F2eVA3FO6t4Dml+FMXuDfSSk8Ji6fYa8zNQqPYzIfzavfkREpZ0MNJNxBpRjznGxr4TNVYR6EMLPuZPUf5H6+DnvGaqK6+NSKSAHue/TWTbe+lS9/GSwOmTj4qB2qW0qa6tSf2svQlJ9TlrnPJbsKepX7melB2R3M1lYQNoPzz+ge0TP+0q1rP2wNrh1eqJJAzm9SJDRYKKrFZKXsE4gQN0Xsu8HHvcJM3NbZksvHgYXNSFocHBKQK7Xq/FAxh4OOQkGZF/fdxuV6SAl1eeWhyf9EwDY6Br0nWNvB/Jo1LTCg==;5:M8Cn3RvFVelpGSXYCrsaySxZztf2Gwm/bBmwhIeB0RRPITiNmvX2wYAWOLE9TfZ7cFee25xhbbCZB1uYJa393bvlgyqyr71Tc5uSQ+WwLv+DZCGIWZvt5zdDYRRtr+TV/k1YETwG4trb98B8g7mu2DtqFRXNUcVtNndDQ0QTNs8=;7:7rB8xbSL4oqtYJxyrrmJEU7nWKxAJifq7SWyWnrpFqJ6/jRssXzlB0WaCE9xw9yUosJcyuMuEbCxarhKKT/2oWkRGlltRNVpvikk/NBsxNfFSt81Gw6UlgZce5qCT0BYm0iKUF83JHsqDO0eJEdXrYICnfwMPFS2yB/NGyXhwtKRGJNgn65CdgHopOqCFAyvoquP7sCU7ua8ZtxAWP2mcKcWrQU7tkQ7xsJPZE/oHBjcNpVmm61mzIA4qR7vQr1x
x-ms-office365-filtering-correlation-id: 1665f08d-802f-445e-68e7-08d6222cc3bb
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0821;
x-ms-traffictypediagnostic: CY4PR21MB0821:
x-microsoft-antispam-prvs: <CY4PR21MB0821F2E3ED185BA9431D9F89FB170@CY4PR21MB0821.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(131327999870524)(85827821059158)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(6055026)(149066)(150027)(6041310)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0821;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0821;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(136003)(376002)(346002)(39860400002)(189003)(199004)(2900100001)(86612001)(81166006)(81156014)(8676002)(8936002)(1076002)(4326008)(25786009)(3846002)(6116002)(86362001)(99286004)(486006)(76176011)(54906003)(71190400001)(71200400001)(22452003)(316002)(106356001)(105586002)(6346003)(478600001)(10290500003)(6506007)(26005)(7736002)(305945005)(72206003)(186003)(476003)(446003)(11346002)(14454004)(2616005)(110136005)(217873002)(6486002)(53936002)(102836004)(5660300001)(14444005)(256004)(6512007)(6436002)(107886003)(66066001)(97736004)(36756003)(10090500001)(2501003)(68736007)(5250100002)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0821;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: Purjtx14SHimXm6xh+9vjVi0biTTsuyuKqBuK6AW6wvbTJ9vEmYZuqDJgKDqamRg+et1+6EQG4pT+w/Cj1XvSN3dGKNRZGhg1e3wtHXL51Qk8rEXfgweJaCsQjlNV9MqLlXD+XmIHTJCtD3EhU2P8gIItIulrnjZ0Bg8evnmDH+eetyV2MhtderU7EeUJmc68PNKn+Wd77een6ICcvgQggKEApwBsYCSQ48aLaR2PXWpkp5aShDsVZh57y3kXFAFg8D+Pju/gLN539y46dpJ9kZ+OhRiL2YUJwu4snlHXHQQOBccoEkndCV9MSiSydrHxKx+FNgrJN2UyF7zYz5eTSBN/fRlh4Uqkz8YjKI3Ueg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1665f08d-802f-445e-68e7-08d6222cc3bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 14:48:17.6437
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0821
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Borkmann <daniel@iogearbox.net>

[ Upstream commit 0e06b227c5221dd51b5569de93f3b9f532be4a32 ]

In the current code, msg->data is set as sg_virt(&sg[i]) + start - offset
and msg->data_end relative to it as msg->data + bytes. Using iterator i
to point to the updated starting scatterlist element holds true for some
cases, however not for all where we'd end up pointing out of bounds. It
is /correct/ for these ones:

1) When first finding the starting scatterlist element (sge) where we
   find that the page is already privately owned by the msg and where
   the requested bytes and headroom fit into the sge's length.

However, it's /incorrect/ for the following ones:

2) After we made the requested area private and updated the newly allocated
   page into first_sg slot of the scatterlist ring; when we find that no
   shift repair of the ring is needed where we bail out updating msg->data
   and msg->data_end. At that point i will point to last_sg, which in this
   case is the next elem of first_sg in the ring. The sge at that point
   might as well be invalid (e.g. i =3D=3D msg->sg_end), which we use for
   setting the range of sg_virt(&sg[i]). The correct one would have been
   first_sg.

3) Similar as in 2) but when we find that a shift repair of the ring is
   needed. In this case we fix up all sges and stop once we've reached the
   end. In this case i will point to will point to the new msg->sg_end,
   and the sge at that point will be invalid. Again here the requested
   range sits in first_sg.

Fixes: 015632bb30da ("bpf: sk_msg program helper bpf_sk_msg_pull_data")
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: John Fastabend <john.fastabend@gmail.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/core/filter.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index a9f8d71575c7..e713a8791815 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2300,6 +2300,7 @@ BPF_CALL_4(bpf_msg_pull_data,
 	if (unlikely(start >=3D offset + len))
 		return -EINVAL;
=20
+	first_sg =3D i;
 	/* The start may point into the sg element so we need to also
 	 * account for the headroom.
 	 */
@@ -2307,8 +2308,6 @@ BPF_CALL_4(bpf_msg_pull_data,
 	if (!msg->sg_copy[i] && bytes_sg_total <=3D len)
 		goto out;
=20
-	first_sg =3D i;
-
 	/* At this point we need to linearize multiple scatterlist
 	 * elements or a single shared page. Either way we need to
 	 * copy into a linear buffer exclusively owned by BPF. Then
@@ -2390,7 +2389,7 @@ BPF_CALL_4(bpf_msg_pull_data,
 	if (msg->sg_end < 0)
 		msg->sg_end +=3D MAX_SKB_FRAGS;
 out:
-	msg->data =3D sg_virt(&sg[i]) + start - offset;
+	msg->data =3D sg_virt(&sg[first_sg]) + start - offset;
 	msg->data_end =3D msg->data + bytes;
=20
 	return 0;
--=20
2.17.1
