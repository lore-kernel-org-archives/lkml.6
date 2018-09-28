Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CF6EC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 14:46:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE78A20666
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 14:46:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="cOwcW34b";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="AWvwv8Yk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE78A20666
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729588AbeI1VKm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 17:10:42 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:43256 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729541AbeI1VKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 17:10:41 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8SEjpjs008190;
        Fri, 28 Sep 2018 07:46:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=cnTNTT6n8rr/tiDa80yXxh6VnYgRY5WuL0dB1PC1DUw=;
 b=cOwcW34bJLGn21so4HRSFenwBFCVonBvzGAaATIX6DN8plxB5xAIuEGNdpkLuduPezP8
 VtLJor43xblm4h7rw5KRwAvAjmE6BBbTC2gxsagiEnI8XIeX0neSGDuRk9CmLZfqvf5k
 QBfromYH+OJYWdQsLZHe5v6ETbXUufQYMYc= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2msja2gref-15
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 28 Sep 2018 07:46:12 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.29) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Fri, 28 Sep 2018 10:45:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cnTNTT6n8rr/tiDa80yXxh6VnYgRY5WuL0dB1PC1DUw=;
 b=AWvwv8Yk6Mfz+ILqJlE9n8I53j3yYxqe5KhXuVdWYFxEtz5OLnkUyV5tZFJDovVduzAofuKgPkVEPnvH5rHd/Gl4LtaQ54x65ggnW22k2VLh2p6II2XRchRU1ACIOBsspQW8TZ7OB64Q14xJjSi0BwD9dO2PyPx+X2q3nQJ/C58=
Received: from BY2PR15MB0167.namprd15.prod.outlook.com (10.163.64.141) by
 BY2PR15MB0887.namprd15.prod.outlook.com (10.164.171.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.22; Fri, 28 Sep 2018 14:45:40 +0000
Received: from BY2PR15MB0167.namprd15.prod.outlook.com
 ([fe80::5c5b:75ea:cae:1e68]) by BY2PR15MB0167.namprd15.prod.outlook.com
 ([fe80::5c5b:75ea:cae:1e68%2]) with mapi id 15.20.1164.027; Fri, 28 Sep 2018
 14:45:40 +0000
From:   Roman Gushchin <guro@fb.com>
To:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>, Roman Gushchin <guro@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH v4 bpf-next 02/10] bpf: rework cgroup storage pointer passing
Thread-Topic: [PATCH v4 bpf-next 02/10] bpf: rework cgroup storage pointer
 passing
Thread-Index: AQHUVznsgUf3LANoSkerfP9pfYeedg==
Date:   Fri, 28 Sep 2018 14:45:40 +0000
Message-ID: <20180928144452.5284-3-guro@fb.com>
References: <20180928144452.5284-1-guro@fb.com>
In-Reply-To: <20180928144452.5284-1-guro@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6PR0402CA0022.eurprd04.prod.outlook.com
 (2603:10a6:209::35) To BY2PR15MB0167.namprd15.prod.outlook.com
 (2a01:111:e400:58e0::13)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c092:180::1:8a29]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BY2PR15MB0887;20:ICDpEZwcRmS0JFNuJDpZjeqJwn0jJARdaZIW3hhDVo2zXMiMqwRRLsfi/18Urv35wvhoNXxYO0YzTwBY0sXatIZcwpH9L6tioCjlNwFazGxBLEInTLbw+ZOAA1SHwG1IPBzgVgPdpkf3d0qq4IY73zMUj85ElQtCEbqQT5qnSh4=
x-ms-office365-filtering-correlation-id: 295327ba-0ac1-468e-b9c5-08d625510f24
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BY2PR15MB0887;
x-ms-traffictypediagnostic: BY2PR15MB0887:
x-microsoft-antispam-prvs: <BY2PR15MB088748B50E0DB712FDD36BB3BEEC0@BY2PR15MB0887.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(67672495146484);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(10201501046)(3002001)(3231355)(11241501184)(944501410)(52105095)(93006095)(93001095)(149066)(150057)(6041310)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051);SRVR:BY2PR15MB0887;BCL:0;PCL:0;RULEID:;SRVR:BY2PR15MB0887;
x-forefront-prvs: 0809C12563
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(39860400002)(396003)(136003)(376002)(189003)(199004)(6916009)(476003)(2616005)(5640700003)(6486002)(7736002)(305945005)(1076002)(54906003)(6436002)(486006)(97736004)(46003)(53936002)(6512007)(11346002)(446003)(386003)(6506007)(2906002)(14444005)(256004)(5660300001)(76176011)(102836004)(34290500001)(86362001)(52116002)(575784001)(186003)(99286004)(6116002)(36756003)(71190400001)(71200400001)(8936002)(81166006)(8676002)(1730700003)(81156014)(68736007)(2900100001)(316002)(4326008)(5250100002)(2501003)(106356001)(105586002)(478600001)(25786009)(14454004)(2351001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BY2PR15MB0887;H:BY2PR15MB0167.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: BAItCjF/hu6085ejEJKXdXM+UDCySGPckpNzMFZeDddNFZFl45Vgu/II7CoIeTavKFRi/8MgbZBebbJ0ecuR0KGsv9Um/fUQuoCv166YmDsNa8rb7K5vErx8y64Llr0WtJq0HMRNwCVgh9Y59SrYfGu71DSi0lk/mtXCkPrGH7CiGfj/NBlBQWp0erUHdY2Oa13GuqGsncM90qj2PPXRQpnAjz98q+Yu7LdYoe3wHMkOiAalf8k7p6V/KjbXjJiwW6TMTktES/PBfSTzYzDwX8w83+nw9nGXWys17aeu3xxaESjgVThXYw21m2Sb09ftKFnv3HOe7fcMZOuTfH8TE7PKC6tb9kbYMMMmKQfZg1A=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 295327ba-0ac1-468e-b9c5-08d625510f24
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2018 14:45:40.0881
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR15MB0887
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-28_06:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To simplify the following introduction of per-cpu cgroup storage,
let's rework a bit a mechanism of passing a pointer to a cgroup
storage into the bpf_get_local_storage(). Let's save a pointer
to the corresponding bpf_cgroup_storage structure, instead of
a pointer to the actual buffer.

It will help us to handle per-cpu storage later, which has
a different way of accessing to the actual data.

Signed-off-by: Roman Gushchin <guro@fb.com>
Acked-by: Song Liu <songliubraving@fb.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf-cgroup.h | 13 ++++---------
 kernel/bpf/helpers.c       |  8 ++++++--
 kernel/bpf/local_storage.c |  3 ++-
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
index e9871b012dac..7e0c9a1d48b7 100644
--- a/include/linux/bpf-cgroup.h
+++ b/include/linux/bpf-cgroup.h
@@ -23,7 +23,8 @@ struct bpf_cgroup_storage;
 extern struct static_key_false cgroup_bpf_enabled_key;
 #define cgroup_bpf_enabled static_branch_unlikely(&cgroup_bpf_enabled_key)
=20
-DECLARE_PER_CPU(void*, bpf_cgroup_storage[MAX_BPF_CGROUP_STORAGE_TYPE]);
+DECLARE_PER_CPU(struct bpf_cgroup_storage*,
+		bpf_cgroup_storage[MAX_BPF_CGROUP_STORAGE_TYPE]);
=20
 #define for_each_cgroup_storage_type(stype) \
 	for (stype =3D 0; stype < MAX_BPF_CGROUP_STORAGE_TYPE; stype++)
@@ -115,15 +116,9 @@ static inline void bpf_cgroup_storage_set(struct bpf_c=
group_storage
 					  *storage[MAX_BPF_CGROUP_STORAGE_TYPE])
 {
 	enum bpf_cgroup_storage_type stype;
-	struct bpf_storage_buffer *buf;
-
-	for_each_cgroup_storage_type(stype) {
-		if (!storage[stype])
-			continue;
=20
-		buf =3D READ_ONCE(storage[stype]->buf);
-		this_cpu_write(bpf_cgroup_storage[stype], &buf->data[0]);
-	}
+	for_each_cgroup_storage_type(stype)
+		this_cpu_write(bpf_cgroup_storage[stype], storage[stype]);
 }
=20
 struct bpf_cgroup_storage *bpf_cgroup_storage_alloc(struct bpf_prog *prog,
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 9070b2ace6aa..e42f8789b7ea 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -195,7 +195,8 @@ const struct bpf_func_proto bpf_get_current_cgroup_id_p=
roto =3D {
 };
=20
 #ifdef CONFIG_CGROUP_BPF
-DECLARE_PER_CPU(void*, bpf_cgroup_storage[MAX_BPF_CGROUP_STORAGE_TYPE]);
+DECLARE_PER_CPU(struct bpf_cgroup_storage*,
+		bpf_cgroup_storage[MAX_BPF_CGROUP_STORAGE_TYPE]);
=20
 BPF_CALL_2(bpf_get_local_storage, struct bpf_map *, map, u64, flags)
 {
@@ -204,8 +205,11 @@ BPF_CALL_2(bpf_get_local_storage, struct bpf_map *, ma=
p, u64, flags)
 	 * verifier checks that its value is correct.
 	 */
 	enum bpf_cgroup_storage_type stype =3D cgroup_storage_type(map);
+	struct bpf_cgroup_storage *storage;
=20
-	return (unsigned long) this_cpu_read(bpf_cgroup_storage[stype]);
+	storage =3D this_cpu_read(bpf_cgroup_storage[stype]);
+
+	return (unsigned long)&READ_ONCE(storage->buf)->data[0];
 }
=20
 const struct bpf_func_proto bpf_get_local_storage_proto =3D {
diff --git a/kernel/bpf/local_storage.c b/kernel/bpf/local_storage.c
index 0bd9f19fc557..6742292fb39e 100644
--- a/kernel/bpf/local_storage.c
+++ b/kernel/bpf/local_storage.c
@@ -7,7 +7,8 @@
 #include <linux/rbtree.h>
 #include <linux/slab.h>
=20
-DEFINE_PER_CPU(void*, bpf_cgroup_storage[MAX_BPF_CGROUP_STORAGE_TYPE]);
+DEFINE_PER_CPU(struct bpf_cgroup_storage*,
+	       bpf_cgroup_storage[MAX_BPF_CGROUP_STORAGE_TYPE]);
=20
 #ifdef CONFIG_CGROUP_BPF
=20
--=20
2.17.1

