Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 584C5C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 14:46:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0293D20666
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 14:46:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="TrSjfrSB";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="cDV9ZIQe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0293D20666
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729452AbeI1VKV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 17:10:21 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:51030 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729395AbeI1VKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 17:10:19 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8SEigjC018102;
        Fri, 28 Sep 2018 07:45:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=JVa/5Z6TdFGjbC2sQH36oIWk/zrX8Sn/wS7tQyYpTJY=;
 b=TrSjfrSBHwxd+SFRy/AR61V3dsKMV4tL7o9HgM0/Mcy7rOJ+EHA9PPTof7BeV1+ljtvn
 rysDfE+NZRo188K9Jt0ouA1xOmSeI7uTVNwcngIPT8YxCrAI6qcV5XoeBdY/E1Yy2yqH
 ofWR5qKgDeSBs8FIlQv57ZWs5/jK6N6950Q= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2msn3b08u5-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 28 Sep 2018 07:45:50 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.23) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Fri, 28 Sep 2018 07:45:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JVa/5Z6TdFGjbC2sQH36oIWk/zrX8Sn/wS7tQyYpTJY=;
 b=cDV9ZIQemAbqh9BU4K/KDvxuqvkmb/FxmgvBbaLpy41YyZNBvnrOYWos++Kb+urZIJy3w6CDjOIKNl4L6R6wH/6CzvnKG9tfcqLs6H1q9KfgUaPoNQ0EYsENTUwX2aU6KQdlWccyF41lU3IopdY5pfs1Vgx+2TmofY7fcLPwxFg=
Received: from BY2PR15MB0167.namprd15.prod.outlook.com (10.163.64.141) by
 BY2PR15MB0887.namprd15.prod.outlook.com (10.164.171.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.22; Fri, 28 Sep 2018 14:45:44 +0000
Received: from BY2PR15MB0167.namprd15.prod.outlook.com
 ([fe80::5c5b:75ea:cae:1e68]) by BY2PR15MB0167.namprd15.prod.outlook.com
 ([fe80::5c5b:75ea:cae:1e68%2]) with mapi id 15.20.1164.027; Fri, 28 Sep 2018
 14:45:44 +0000
From:   Roman Gushchin <guro@fb.com>
To:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>, Roman Gushchin <guro@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH v4 bpf-next 03/10] bpf: introduce per-cpu cgroup local storage
Thread-Topic: [PATCH v4 bpf-next 03/10] bpf: introduce per-cpu cgroup local
 storage
Thread-Index: AQHUVznuPsuftTku7kOJM/m/k6qdaQ==
Date:   Fri, 28 Sep 2018 14:45:43 +0000
Message-ID: <20180928144452.5284-4-guro@fb.com>
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
x-microsoft-exchange-diagnostics: 1;BY2PR15MB0887;20:KluuGtlGTJuP+4pDxD2guTG+yeP0hpkbzVB83gU8DXv1BWvw/+I+PST7uVljSBQs1e/GR5do7+qJlrDw5D6ICf4XP8h1t74kx4hKU+KQd4/eKw870NVZF+KDtGQt2ZEH6CJgESf6nvklw0gwgdxJ+5bCj5oB5V65EmF58UKdaYg=
x-ms-office365-filtering-correlation-id: ad920e22-ef0c-4d6f-8fd8-08d625511104
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BY2PR15MB0887;
x-ms-traffictypediagnostic: BY2PR15MB0887:
x-microsoft-antispam-prvs: <BY2PR15MB0887B6429258EE305E5C34A7BEEC0@BY2PR15MB0887.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(788757137089)(67672495146484);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(10201501046)(3002001)(3231355)(11241501184)(944501410)(52105095)(93006095)(93001095)(149066)(150057)(6041310)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051);SRVR:BY2PR15MB0887;BCL:0;PCL:0;RULEID:;SRVR:BY2PR15MB0887;
x-forefront-prvs: 0809C12563
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(39860400002)(396003)(136003)(376002)(189003)(199004)(6916009)(476003)(2616005)(5640700003)(6486002)(7736002)(305945005)(1076002)(54906003)(6436002)(486006)(97736004)(46003)(53936002)(6512007)(11346002)(446003)(386003)(6506007)(2906002)(14444005)(256004)(5660300001)(76176011)(102836004)(34290500001)(86362001)(52116002)(575784001)(186003)(99286004)(6116002)(36756003)(71190400001)(71200400001)(8936002)(81166006)(8676002)(1730700003)(81156014)(68736007)(2900100001)(316002)(4326008)(5250100002)(2501003)(106356001)(105586002)(478600001)(25786009)(14454004)(2351001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BY2PR15MB0887;H:BY2PR15MB0167.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: FpN1Wxi4C6qDMxX7EJ9nvbgx1j5bd8VzeNQE1ne1q8lvHKpMbD7e1iyU7yr9WdiC/8vc5wX4kyVgbhtyWqZV34leaD9NSkSQ1n1m6cFkGKJ16K0tXu/bBnbw+sWCnrto6OvHq9qye/NBqBEUGAY3Lywyk0lvRwjGpgFw2F5Soa6eknsOaU28XnDFrL7C/PLW+ppdqU1UUo1tzQxmFwTwEk2V7uW8UUAJcdr2VJglb0XggKvxAKDWNl4afKH/zZReBTknfeSzgaRA74Ho/ZlhlO0roSLUVTIZ0gEpzVm9J9NQpGcYO2JozGM3nSKwD3GnQWg/IFO/VNvnA1HBOamRtRbLd+o2tMXON9Uml7KHra0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ad920e22-ef0c-4d6f-8fd8-08d625511104
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2018 14:45:43.4459
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

This commit introduced per-cpu cgroup local storage.

Per-cpu cgroup local storage is very similar to simple cgroup storage
(let's call it shared), except all the data is per-cpu.

The main goal of per-cpu variant is to implement super fast
counters (e.g. packet counters), which don't require neither
lookups, neither atomic operations.

>From userspace's point of view, accessing a per-cpu cgroup storage
is similar to other per-cpu map types (e.g. per-cpu hashmaps and
arrays).

Writing to a per-cpu cgroup storage is not atomic, but is performed
by copying longs, so some minimal atomicity is here, exactly
as with other per-cpu maps.

Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Alexei Starovoitov <ast@kernel.org>
Acked-by: Song Liu <songliubraving@fb.com>
---
 include/linux/bpf-cgroup.h |  20 ++++-
 include/linux/bpf.h        |   1 +
 include/linux/bpf_types.h  |   1 +
 include/uapi/linux/bpf.h   |   1 +
 kernel/bpf/helpers.c       |   8 +-
 kernel/bpf/local_storage.c | 150 ++++++++++++++++++++++++++++++++-----
 kernel/bpf/syscall.c       |  11 ++-
 kernel/bpf/verifier.c      |  15 +++-
 8 files changed, 179 insertions(+), 28 deletions(-)

diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
index 7e0c9a1d48b7..588dd5f0bd85 100644
--- a/include/linux/bpf-cgroup.h
+++ b/include/linux/bpf-cgroup.h
@@ -37,7 +37,10 @@ struct bpf_storage_buffer {
 };
=20
 struct bpf_cgroup_storage {
-	struct bpf_storage_buffer *buf;
+	union {
+		struct bpf_storage_buffer *buf;
+		void __percpu *percpu_buf;
+	};
 	struct bpf_cgroup_storage_map *map;
 	struct bpf_cgroup_storage_key key;
 	struct list_head list;
@@ -109,6 +112,9 @@ int __cgroup_bpf_check_dev_permission(short dev_type, u=
32 major, u32 minor,
 static inline enum bpf_cgroup_storage_type cgroup_storage_type(
 	struct bpf_map *map)
 {
+	if (map->map_type =3D=3D BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE)
+		return BPF_CGROUP_STORAGE_PERCPU;
+
 	return BPF_CGROUP_STORAGE_SHARED;
 }
=20
@@ -131,6 +137,10 @@ void bpf_cgroup_storage_unlink(struct bpf_cgroup_stora=
ge *storage);
 int bpf_cgroup_storage_assign(struct bpf_prog *prog, struct bpf_map *map);
 void bpf_cgroup_storage_release(struct bpf_prog *prog, struct bpf_map *map=
);
=20
+int bpf_percpu_cgroup_storage_copy(struct bpf_map *map, void *key, void *v=
alue);
+int bpf_percpu_cgroup_storage_update(struct bpf_map *map, void *key,
+				     void *value, u64 flags);
+
 /* Wrappers for __cgroup_bpf_run_filter_skb() guarded by cgroup_bpf_enable=
d. */
 #define BPF_CGROUP_RUN_PROG_INET_INGRESS(sk, skb)			      \
 ({									      \
@@ -285,6 +295,14 @@ static inline struct bpf_cgroup_storage *bpf_cgroup_st=
orage_alloc(
 	struct bpf_prog *prog, enum bpf_cgroup_storage_type stype) { return 0; }
 static inline void bpf_cgroup_storage_free(
 	struct bpf_cgroup_storage *storage) {}
+static inline int bpf_percpu_cgroup_storage_copy(struct bpf_map *map, void=
 *key,
+						 void *value) {
+	return 0;
+}
+static inline int bpf_percpu_cgroup_storage_update(struct bpf_map *map,
+					void *key, void *value, u64 flags) {
+	return 0;
+}
=20
 #define cgroup_bpf_enabled (0)
 #define BPF_CGROUP_PRE_CONNECT_ENABLED(sk) (0)
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index b457fbe7b70b..018299a595c8 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -274,6 +274,7 @@ struct bpf_prog_offload {
=20
 enum bpf_cgroup_storage_type {
 	BPF_CGROUP_STORAGE_SHARED,
+	BPF_CGROUP_STORAGE_PERCPU,
 	__BPF_CGROUP_STORAGE_MAX
 };
=20
diff --git a/include/linux/bpf_types.h b/include/linux/bpf_types.h
index c9bd6fb765b0..5432f4c9f50e 100644
--- a/include/linux/bpf_types.h
+++ b/include/linux/bpf_types.h
@@ -43,6 +43,7 @@ BPF_MAP_TYPE(BPF_MAP_TYPE_CGROUP_ARRAY, cgroup_array_map_=
ops)
 #endif
 #ifdef CONFIG_CGROUP_BPF
 BPF_MAP_TYPE(BPF_MAP_TYPE_CGROUP_STORAGE, cgroup_storage_map_ops)
+BPF_MAP_TYPE(BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE, cgroup_storage_map_ops)
 #endif
 BPF_MAP_TYPE(BPF_MAP_TYPE_HASH, htab_map_ops)
 BPF_MAP_TYPE(BPF_MAP_TYPE_PERCPU_HASH, htab_percpu_map_ops)
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index aa5ccd2385ed..e2070d819e04 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -127,6 +127,7 @@ enum bpf_map_type {
 	BPF_MAP_TYPE_SOCKHASH,
 	BPF_MAP_TYPE_CGROUP_STORAGE,
 	BPF_MAP_TYPE_REUSEPORT_SOCKARRAY,
+	BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE,
 };
=20
 enum bpf_prog_type {
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index e42f8789b7ea..6502115e8f55 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -206,10 +206,16 @@ BPF_CALL_2(bpf_get_local_storage, struct bpf_map *, m=
ap, u64, flags)
 	 */
 	enum bpf_cgroup_storage_type stype =3D cgroup_storage_type(map);
 	struct bpf_cgroup_storage *storage;
+	void *ptr;
=20
 	storage =3D this_cpu_read(bpf_cgroup_storage[stype]);
=20
-	return (unsigned long)&READ_ONCE(storage->buf)->data[0];
+	if (stype =3D=3D BPF_CGROUP_STORAGE_SHARED)
+		ptr =3D &READ_ONCE(storage->buf)->data[0];
+	else
+		ptr =3D this_cpu_ptr(storage->percpu_buf);
+
+	return (unsigned long)ptr;
 }
=20
 const struct bpf_func_proto bpf_get_local_storage_proto =3D {
diff --git a/kernel/bpf/local_storage.c b/kernel/bpf/local_storage.c
index 6742292fb39e..944eb297465f 100644
--- a/kernel/bpf/local_storage.c
+++ b/kernel/bpf/local_storage.c
@@ -152,6 +152,71 @@ static int cgroup_storage_update_elem(struct bpf_map *=
map, void *_key,
 	return 0;
 }
=20
+int bpf_percpu_cgroup_storage_copy(struct bpf_map *_map, void *_key,
+				   void *value)
+{
+	struct bpf_cgroup_storage_map *map =3D map_to_storage(_map);
+	struct bpf_cgroup_storage_key *key =3D _key;
+	struct bpf_cgroup_storage *storage;
+	int cpu, off =3D 0;
+	u32 size;
+
+	rcu_read_lock();
+	storage =3D cgroup_storage_lookup(map, key, false);
+	if (!storage) {
+		rcu_read_unlock();
+		return -ENOENT;
+	}
+
+	/* per_cpu areas are zero-filled and bpf programs can only
+	 * access 'value_size' of them, so copying rounded areas
+	 * will not leak any kernel data
+	 */
+	size =3D round_up(_map->value_size, 8);
+	for_each_possible_cpu(cpu) {
+		bpf_long_memcpy(value + off,
+				per_cpu_ptr(storage->percpu_buf, cpu), size);
+		off +=3D size;
+	}
+	rcu_read_unlock();
+	return 0;
+}
+
+int bpf_percpu_cgroup_storage_update(struct bpf_map *_map, void *_key,
+				     void *value, u64 map_flags)
+{
+	struct bpf_cgroup_storage_map *map =3D map_to_storage(_map);
+	struct bpf_cgroup_storage_key *key =3D _key;
+	struct bpf_cgroup_storage *storage;
+	int cpu, off =3D 0;
+	u32 size;
+
+	if (map_flags !=3D BPF_ANY && map_flags !=3D BPF_EXIST)
+		return -EINVAL;
+
+	rcu_read_lock();
+	storage =3D cgroup_storage_lookup(map, key, false);
+	if (!storage) {
+		rcu_read_unlock();
+		return -ENOENT;
+	}
+
+	/* the user space will provide round_up(value_size, 8) bytes that
+	 * will be copied into per-cpu area. bpf programs can only access
+	 * value_size of it. During lookup the same extra bytes will be
+	 * returned or zeros which were zero-filled by percpu_alloc,
+	 * so no kernel data leaks possible
+	 */
+	size =3D round_up(_map->value_size, 8);
+	for_each_possible_cpu(cpu) {
+		bpf_long_memcpy(per_cpu_ptr(storage->percpu_buf, cpu),
+				value + off, size);
+		off +=3D size;
+	}
+	rcu_read_unlock();
+	return 0;
+}
+
 static int cgroup_storage_get_next_key(struct bpf_map *_map, void *_key,
 				       void *_next_key)
 {
@@ -287,60 +352,105 @@ void bpf_cgroup_storage_release(struct bpf_prog *pro=
g, struct bpf_map *_map)
 	spin_unlock_bh(&map->lock);
 }
=20
+static size_t bpf_cgroup_storage_calculate_size(struct bpf_map *map, u32 *=
pages)
+{
+	size_t size;
+
+	if (cgroup_storage_type(map) =3D=3D BPF_CGROUP_STORAGE_SHARED) {
+		size =3D sizeof(struct bpf_storage_buffer) + map->value_size;
+		*pages =3D round_up(sizeof(struct bpf_cgroup_storage) + size,
+				  PAGE_SIZE) >> PAGE_SHIFT;
+	} else {
+		size =3D map->value_size;
+		*pages =3D round_up(round_up(size, 8) * num_possible_cpus(),
+				  PAGE_SIZE) >> PAGE_SHIFT;
+	}
+
+	return size;
+}
+
 struct bpf_cgroup_storage *bpf_cgroup_storage_alloc(struct bpf_prog *prog,
 					enum bpf_cgroup_storage_type stype)
 {
 	struct bpf_cgroup_storage *storage;
 	struct bpf_map *map;
+	gfp_t flags;
+	size_t size;
 	u32 pages;
=20
 	map =3D prog->aux->cgroup_storage[stype];
 	if (!map)
 		return NULL;
=20
-	pages =3D round_up(sizeof(struct bpf_cgroup_storage) +
-			 sizeof(struct bpf_storage_buffer) +
-			 map->value_size, PAGE_SIZE) >> PAGE_SHIFT;
+	size =3D bpf_cgroup_storage_calculate_size(map, &pages);
+
 	if (bpf_map_charge_memlock(map, pages))
 		return ERR_PTR(-EPERM);
=20
 	storage =3D kmalloc_node(sizeof(struct bpf_cgroup_storage),
 			       __GFP_ZERO | GFP_USER, map->numa_node);
-	if (!storage) {
-		bpf_map_uncharge_memlock(map, pages);
-		return ERR_PTR(-ENOMEM);
-	}
+	if (!storage)
+		goto enomem;
=20
-	storage->buf =3D kmalloc_node(sizeof(struct bpf_storage_buffer) +
-				    map->value_size, __GFP_ZERO | GFP_USER,
-				    map->numa_node);
-	if (!storage->buf) {
-		bpf_map_uncharge_memlock(map, pages);
-		kfree(storage);
-		return ERR_PTR(-ENOMEM);
+	flags =3D __GFP_ZERO | GFP_USER;
+
+	if (stype =3D=3D BPF_CGROUP_STORAGE_SHARED) {
+		storage->buf =3D kmalloc_node(size, flags, map->numa_node);
+		if (!storage->buf)
+			goto enomem;
+	} else {
+		storage->percpu_buf =3D __alloc_percpu_gfp(size, 8, flags);
+		if (!storage->percpu_buf)
+			goto enomem;
 	}
=20
 	storage->map =3D (struct bpf_cgroup_storage_map *)map;
=20
 	return storage;
+
+enomem:
+	bpf_map_uncharge_memlock(map, pages);
+	kfree(storage);
+	return ERR_PTR(-ENOMEM);
+}
+
+static void free_shared_cgroup_storage_rcu(struct rcu_head *rcu)
+{
+	struct bpf_cgroup_storage *storage =3D
+		container_of(rcu, struct bpf_cgroup_storage, rcu);
+
+	kfree(storage->buf);
+	kfree(storage);
+}
+
+static void free_percpu_cgroup_storage_rcu(struct rcu_head *rcu)
+{
+	struct bpf_cgroup_storage *storage =3D
+		container_of(rcu, struct bpf_cgroup_storage, rcu);
+
+	free_percpu(storage->percpu_buf);
+	kfree(storage);
 }
=20
 void bpf_cgroup_storage_free(struct bpf_cgroup_storage *storage)
 {
-	u32 pages;
+	enum bpf_cgroup_storage_type stype;
 	struct bpf_map *map;
+	u32 pages;
=20
 	if (!storage)
 		return;
=20
 	map =3D &storage->map->map;
-	pages =3D round_up(sizeof(struct bpf_cgroup_storage) +
-			 sizeof(struct bpf_storage_buffer) +
-			 map->value_size, PAGE_SIZE) >> PAGE_SHIFT;
+
+	bpf_cgroup_storage_calculate_size(map, &pages);
 	bpf_map_uncharge_memlock(map, pages);
=20
-	kfree_rcu(storage->buf, rcu);
-	kfree_rcu(storage, rcu);
+	stype =3D cgroup_storage_type(map);
+	if (stype =3D=3D BPF_CGROUP_STORAGE_SHARED)
+		call_rcu(&storage->rcu, free_shared_cgroup_storage_rcu);
+	else
+		call_rcu(&storage->rcu, free_percpu_cgroup_storage_rcu);
 }
=20
 void bpf_cgroup_storage_link(struct bpf_cgroup_storage *storage,
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 8c91d2b41b1e..5742df21598c 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -686,7 +686,8 @@ static int map_lookup_elem(union bpf_attr *attr)
=20
 	if (map->map_type =3D=3D BPF_MAP_TYPE_PERCPU_HASH ||
 	    map->map_type =3D=3D BPF_MAP_TYPE_LRU_PERCPU_HASH ||
-	    map->map_type =3D=3D BPF_MAP_TYPE_PERCPU_ARRAY)
+	    map->map_type =3D=3D BPF_MAP_TYPE_PERCPU_ARRAY ||
+	    map->map_type =3D=3D BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE)
 		value_size =3D round_up(map->value_size, 8) * num_possible_cpus();
 	else if (IS_FD_MAP(map))
 		value_size =3D sizeof(u32);
@@ -705,6 +706,8 @@ static int map_lookup_elem(union bpf_attr *attr)
 		err =3D bpf_percpu_hash_copy(map, key, value);
 	} else if (map->map_type =3D=3D BPF_MAP_TYPE_PERCPU_ARRAY) {
 		err =3D bpf_percpu_array_copy(map, key, value);
+	} else if (map->map_type =3D=3D BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE) {
+		err =3D bpf_percpu_cgroup_storage_copy(map, key, value);
 	} else if (map->map_type =3D=3D BPF_MAP_TYPE_STACK_TRACE) {
 		err =3D bpf_stackmap_copy(map, key, value);
 	} else if (IS_FD_ARRAY(map)) {
@@ -774,7 +777,8 @@ static int map_update_elem(union bpf_attr *attr)
=20
 	if (map->map_type =3D=3D BPF_MAP_TYPE_PERCPU_HASH ||
 	    map->map_type =3D=3D BPF_MAP_TYPE_LRU_PERCPU_HASH ||
-	    map->map_type =3D=3D BPF_MAP_TYPE_PERCPU_ARRAY)
+	    map->map_type =3D=3D BPF_MAP_TYPE_PERCPU_ARRAY ||
+	    map->map_type =3D=3D BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE)
 		value_size =3D round_up(map->value_size, 8) * num_possible_cpus();
 	else
 		value_size =3D map->value_size;
@@ -809,6 +813,9 @@ static int map_update_elem(union bpf_attr *attr)
 		err =3D bpf_percpu_hash_update(map, key, value, attr->flags);
 	} else if (map->map_type =3D=3D BPF_MAP_TYPE_PERCPU_ARRAY) {
 		err =3D bpf_percpu_array_update(map, key, value, attr->flags);
+	} else if (map->map_type =3D=3D BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE) {
+		err =3D bpf_percpu_cgroup_storage_update(map, key, value,
+						       attr->flags);
 	} else if (IS_FD_ARRAY(map)) {
 		rcu_read_lock();
 		err =3D bpf_fd_array_map_update_elem(map, f.file, key, value,
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e90899df585d..a8cc83a970d1 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2074,6 +2074,7 @@ static int check_map_func_compatibility(struct bpf_ve=
rifier_env *env,
 			goto error;
 		break;
 	case BPF_MAP_TYPE_CGROUP_STORAGE:
+	case BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE:
 		if (func_id !=3D BPF_FUNC_get_local_storage)
 			goto error;
 		break;
@@ -2164,7 +2165,8 @@ static int check_map_func_compatibility(struct bpf_ve=
rifier_env *env,
 			goto error;
 		break;
 	case BPF_FUNC_get_local_storage:
-		if (map->map_type !=3D BPF_MAP_TYPE_CGROUP_STORAGE)
+		if (map->map_type !=3D BPF_MAP_TYPE_CGROUP_STORAGE &&
+		    map->map_type !=3D BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE)
 			goto error;
 		break;
 	case BPF_FUNC_sk_select_reuseport:
@@ -5049,6 +5051,12 @@ static int check_map_prog_compatibility(struct bpf_v=
erifier_env *env,
 	return 0;
 }
=20
+static bool bpf_map_is_cgroup_storage(struct bpf_map *map)
+{
+	return (map->map_type =3D=3D BPF_MAP_TYPE_CGROUP_STORAGE ||
+		map->map_type =3D=3D BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE);
+}
+
 /* look for pseudo eBPF instructions that access map FDs and
  * replace them with actual map pointers
  */
@@ -5139,10 +5147,9 @@ static int replace_map_fd_with_map_ptr(struct bpf_ve=
rifier_env *env)
 			}
 			env->used_maps[env->used_map_cnt++] =3D map;
=20
-			if (map->map_type =3D=3D BPF_MAP_TYPE_CGROUP_STORAGE &&
+			if (bpf_map_is_cgroup_storage(map) &&
 			    bpf_cgroup_storage_assign(env->prog, map)) {
-				verbose(env,
-					"only one cgroup storage is allowed\n");
+				verbose(env, "only one cgroup storage of each type is allowed\n");
 				fdput(f);
 				return -EBUSY;
 			}
--=20
2.17.1

