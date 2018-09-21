Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13EBCC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 17:15:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DF0021547
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 17:15:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="rYztxd9U";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="Bbvpij5k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DF0021547
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390947AbeIUXE1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 19:04:27 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:40860 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390713AbeIUXEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 19:04:25 -0400
Received: from pps.filterd (m0001255.ppops.net [127.0.0.1])
        by mx0b-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8LH8jq5025307;
        Fri, 21 Sep 2018 10:14:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=er77GbJqleuN+/V5Yfk9jh5VvzDtIMS+8ZjtGjOfXeI=;
 b=rYztxd9UIsqFElQXCEXNt21ZKX7ysJLLlSvYH/i1y4MqexC/ZF+ruGn2QsZiYmqk5BWk
 QBW9ch7B+/4nVaRpwT0vUy2rYwj4BBLiU1wP56bvBY1NPIouRmZbV7Z3XE8nf5D9Fa5s
 DzXInjdHRIhb7FUzlqFtj840HnYnDKMaCvw= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0b-00082601.pphosted.com with ESMTP id 2mn27brkv8-7
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 21 Sep 2018 10:14:14 -0700
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.24) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Fri, 21 Sep 2018 10:14:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=er77GbJqleuN+/V5Yfk9jh5VvzDtIMS+8ZjtGjOfXeI=;
 b=Bbvpij5kDPMTDxHOLo6aV/JyIKBUw63xap7UjoUpql/FhS8g1dRGRrTszVjZya2IWEmU/34UWTz9sQ6rkW8oiCWN6QVcrCBw3A8P7IE8qUEGXIN/42ewS7J1OCGEBQAOaXbYAX59XZDmIdQrA3tCI6iQuTLUfAFJbgMaD65eTBg=
Received: from BY2PR15MB0167.namprd15.prod.outlook.com (10.163.64.141) by
 BY2PR15MB0232.namprd15.prod.outlook.com (10.163.64.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.18; Fri, 21 Sep 2018 17:14:08 +0000
Received: from BY2PR15MB0167.namprd15.prod.outlook.com
 ([fe80::5c5b:75ea:cae:1e68]) by BY2PR15MB0167.namprd15.prod.outlook.com
 ([fe80::5c5b:75ea:cae:1e68%2]) with mapi id 15.20.1143.017; Fri, 21 Sep 2018
 17:14:08 +0000
From:   Roman Gushchin <guro@fb.com>
To:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>, Roman Gushchin <guro@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH bpf-next 2/9] bpf: rework cgroup storage pointer passing
Thread-Topic: [PATCH bpf-next 2/9] bpf: rework cgroup storage pointer passing
Thread-Index: AQHUUc6BRSI+QCxycUqayvwq3kbvpw==
Date:   Fri, 21 Sep 2018 17:14:08 +0000
Message-ID: <20180921171353.11050-2-guro@fb.com>
References: <20180921171353.11050-1-guro@fb.com>
In-Reply-To: <20180921171353.11050-1-guro@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR10CA0052.namprd10.prod.outlook.com
 (2603:10b6:300:2c::14) To BY2PR15MB0167.namprd15.prod.outlook.com
 (2a01:111:e400:58e0::13)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::7:15ea]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BY2PR15MB0232;20:njNhVwFJhPcK0F4m4vi/2x1p9haL5YCs5WPS5HFLGbudSSHGmqSBw0oYSsBy6fBHoSFFQRjwY1tMiljkR/Ui+RldpQykT5UWFDpdGL2dk6urorzzRbSmZjIcmWuLynSfKsXl2S1iGtOeeRRunK8I6OEB3AUPNa4WEJV8JaSeBhI=
x-ms-office365-filtering-correlation-id: 78a375b8-93d2-4b67-d900-08d61fe5a3ea
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BY2PR15MB0232;
x-ms-traffictypediagnostic: BY2PR15MB0232:
x-microsoft-antispam-prvs: <BY2PR15MB02325602AF4E57580B2F7251BE120@BY2PR15MB0232.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(67672495146484);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823302057)(3231355)(11241501184)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(201708071742011)(7699051);SRVR:BY2PR15MB0232;BCL:0;PCL:0;RULEID:;SRVR:BY2PR15MB0232;
x-forefront-prvs: 0802ADD973
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(376002)(136003)(396003)(366004)(199004)(189003)(386003)(5640700003)(14444005)(186003)(86362001)(486006)(6512007)(36756003)(99286004)(256004)(6436002)(6486002)(5250100002)(54906003)(6916009)(71200400001)(71190400001)(2900100001)(476003)(11346002)(76176011)(575784001)(102836004)(2616005)(52116002)(8676002)(46003)(81166006)(305945005)(6506007)(106356001)(25786009)(2351001)(5660300001)(6116002)(97736004)(81156014)(53936002)(316002)(2906002)(4326008)(446003)(1730700003)(1076002)(478600001)(7736002)(68736007)(2501003)(105586002)(8936002)(14454004)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BY2PR15MB0232;H:BY2PR15MB0167.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: KP8pC3hx2AqziTk2Ij5oGfQBsfOYgunPOIv5yr+B9c48ziSTTdHBUpwH3iST36Kuf12zCn5nJvavr6PsKArnXHak3ipZjWhw5z3+sKobnecAAmyJ0uhb+IaauX03SuonJnDDFRdbsyvhPk2xgG06vdoB2JhT835l7Nmb/4+FV8AC1UApBHsY2gR8ANbDgQICAwkVKQY6ymjOqT2I3JbZtQtd3HiUjuKAcDsVS5xq0IPyg1ER3/C3ZjviFQrppo4cmjwTrH0W9lqzDlYUG9uv9OBDQtyjy9pF0LNkVtHfsckSvhCW079YVFoXCA2udpjgrWpofXzVw1ejYyXZcaCHNAawF8fNGgvXShqViSs6ZoY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 78a375b8-93d2-4b67-d900-08d61fe5a3ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2018 17:14:08.5524
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR15MB0232
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-21_07:,,
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

