Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BBC0C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 14:46:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F037320676
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 14:46:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Yur9j+mh";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="QYCSlHpN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F037320676
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729336AbeI1VKM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 17:10:12 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:43106 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726867AbeI1VKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 17:10:11 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8SEjXTs008033;
        Fri, 28 Sep 2018 07:45:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=2mX2FwJepfbv3V5dkmt3uIUx+JZYpPpD/53L3bBxgpA=;
 b=Yur9j+mh4PqrrzAudF135wFeWGu6o+9ugUghZC+fvzXpGL+vjMhxcpqaszCKhzCDR7Bj
 eGjNbUMC1Z6nyslJyJ2uAYJ2jJUC7qN+26LG1K4UQ2kY2oRY+KQalNRHGTn/vSDN5aIS
 lE1EKTHt1qQ1wlO+Yx7KKyRKLcgO0xSeAAo= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2msja2grjt-14
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 28 Sep 2018 07:45:42 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.21) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Fri, 28 Sep 2018 07:45:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2mX2FwJepfbv3V5dkmt3uIUx+JZYpPpD/53L3bBxgpA=;
 b=QYCSlHpN1PiTv9wj45FmVvytA7weyi5JwAb/qJFClNcxaXvPj5734BbY0H2jjr12rLQpxiCkU42p57uq6JeK9pwO3ppj4+mVdksRMoBS+bHuFo7yiZ18podxEgFKNyUdT147OMia1mDenen0IMcjVeM4KNWIWe4Jar3tYGHmCCc=
Received: from BY2PR15MB0167.namprd15.prod.outlook.com (10.163.64.141) by
 BY2PR15MB0887.namprd15.prod.outlook.com (10.164.171.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.22; Fri, 28 Sep 2018 14:45:36 +0000
Received: from BY2PR15MB0167.namprd15.prod.outlook.com
 ([fe80::5c5b:75ea:cae:1e68]) by BY2PR15MB0167.namprd15.prod.outlook.com
 ([fe80::5c5b:75ea:cae:1e68%2]) with mapi id 15.20.1164.027; Fri, 28 Sep 2018
 14:45:36 +0000
From:   Roman Gushchin <guro@fb.com>
To:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>, Roman Gushchin <guro@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH v4 bpf-next 01/10] bpf: extend cgroup bpf core to allow
 multiple cgroup storage types
Thread-Topic: [PATCH v4 bpf-next 01/10] bpf: extend cgroup bpf core to allow
 multiple cgroup storage types
Thread-Index: AQHUVznqiy9OfXU8cEyLtriMg5IYBw==
Date:   Fri, 28 Sep 2018 14:45:36 +0000
Message-ID: <20180928144452.5284-2-guro@fb.com>
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
x-microsoft-exchange-diagnostics: 1;BY2PR15MB0887;20:G7wmfsrqsH4e4fMi6/OHKP+RBDSNL4dsf7cWnULRHUZZlxbHgMLrwcmdg2Lva9fcHDXgT3DPFoOB++6aS/gbzx4KACOn7DO/jkp3hDTAEhbj04wbz/DbBpVF81/hjQzaU8fmGBmQimzKv7m2oB8jHwjU5pQLyb0Ut4wSetfepF4=
x-ms-office365-filtering-correlation-id: 1ad450e2-2af2-4fd2-49e9-08d625510ce5
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BY2PR15MB0887;
x-ms-traffictypediagnostic: BY2PR15MB0887:
x-microsoft-antispam-prvs: <BY2PR15MB0887C4A68EDB985D0352A9CBBEEC0@BY2PR15MB0887.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(788757137089)(67672495146484);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(10201501046)(3002001)(3231355)(11241501184)(944501410)(52105095)(93006095)(93001095)(149066)(150057)(6041310)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051);SRVR:BY2PR15MB0887;BCL:0;PCL:0;RULEID:;SRVR:BY2PR15MB0887;
x-forefront-prvs: 0809C12563
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(39860400002)(396003)(136003)(376002)(189003)(199004)(6916009)(476003)(2616005)(5640700003)(53946003)(6486002)(7736002)(305945005)(1076002)(54906003)(6436002)(486006)(97736004)(46003)(53936002)(6512007)(11346002)(446003)(386003)(6506007)(2906002)(5024004)(14444005)(256004)(5660300001)(76176011)(102836004)(34290500001)(86362001)(52116002)(575784001)(186003)(99286004)(6116002)(36756003)(71190400001)(71200400001)(8936002)(81166006)(8676002)(1730700003)(81156014)(68736007)(2900100001)(316002)(4326008)(5250100002)(2501003)(106356001)(105586002)(478600001)(25786009)(14454004)(2351001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BY2PR15MB0887;H:BY2PR15MB0167.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: nsO+OZSDdSwzaRUBWdCPJ/pJcyvhRexiRO7/nxhgIvR3xFCa4PzpEi5gtSH8/KJfCl6NG35ft3NxRlxjqefnJTzuqCmfR3q163SPn/xI9ycdFkg+EvPJchj4eAvXdQKR/jSBFa9jlgsESvLRM2G+3ctHI9ZYwrIESd1qLE4jfXhEyJVYsK4/siB4w+DkvKQ/tZV7NKF6tMXLWBbLwD/Kyp5a6ZQbZkI8X51Hyqc1P2XCEQLxADdGfB/JIfHhXSxaDazr3yymRBtJNUTTJ4beq+DLdtjMwaztJxFhSdLxA48KA0QwrW9Wk8bU8jx9PP/VFCXXPNb1+yuqesKIgCHVgEOn0JLoUUcfy++mTscB0SM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ad450e2-2af2-4fd2-49e9-08d625510ce5
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2018 14:45:36.8214
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

In order to introduce per-cpu cgroup storage, let's generalize
bpf cgroup core to support multiple cgroup storage types.
Potentially, per-node cgroup storage can be added later.

This commit is mostly a formal change that replaces
cgroup_storage pointer with a array of cgroup_storage pointers.
It doesn't actually introduce a new storage type,
it will be done later.

Each bpf program is now able to have one cgroup storage of each type.

Signed-off-by: Roman Gushchin <guro@fb.com>
Acked-by: Song Liu <songliubraving@fb.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf-cgroup.h | 38 ++++++++++++++------
 include/linux/bpf.h        | 11 ++++--
 kernel/bpf/cgroup.c        | 74 ++++++++++++++++++++++++++------------
 kernel/bpf/helpers.c       | 15 ++++----
 kernel/bpf/local_storage.c | 18 ++++++----
 kernel/bpf/syscall.c       |  9 +++--
 kernel/bpf/verifier.c      |  8 +++--
 net/bpf/test_run.c         | 20 +++++++----
 8 files changed, 136 insertions(+), 57 deletions(-)

diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
index f91b0f8ff3a9..e9871b012dac 100644
--- a/include/linux/bpf-cgroup.h
+++ b/include/linux/bpf-cgroup.h
@@ -2,6 +2,7 @@
 #ifndef _BPF_CGROUP_H
 #define _BPF_CGROUP_H
=20
+#include <linux/bpf.h>
 #include <linux/errno.h>
 #include <linux/jump_label.h>
 #include <linux/percpu.h>
@@ -22,7 +23,10 @@ struct bpf_cgroup_storage;
 extern struct static_key_false cgroup_bpf_enabled_key;
 #define cgroup_bpf_enabled static_branch_unlikely(&cgroup_bpf_enabled_key)
=20
-DECLARE_PER_CPU(void*, bpf_cgroup_storage);
+DECLARE_PER_CPU(void*, bpf_cgroup_storage[MAX_BPF_CGROUP_STORAGE_TYPE]);
+
+#define for_each_cgroup_storage_type(stype) \
+	for (stype =3D 0; stype < MAX_BPF_CGROUP_STORAGE_TYPE; stype++)
=20
 struct bpf_cgroup_storage_map;
=20
@@ -43,7 +47,7 @@ struct bpf_cgroup_storage {
 struct bpf_prog_list {
 	struct list_head node;
 	struct bpf_prog *prog;
-	struct bpf_cgroup_storage *storage;
+	struct bpf_cgroup_storage *storage[MAX_BPF_CGROUP_STORAGE_TYPE];
 };
=20
 struct bpf_prog_array;
@@ -101,18 +105,29 @@ int __cgroup_bpf_run_filter_sock_ops(struct sock *sk,
 int __cgroup_bpf_check_dev_permission(short dev_type, u32 major, u32 minor=
,
 				      short access, enum bpf_attach_type type);
=20
-static inline void bpf_cgroup_storage_set(struct bpf_cgroup_storage *stora=
ge)
+static inline enum bpf_cgroup_storage_type cgroup_storage_type(
+	struct bpf_map *map)
 {
+	return BPF_CGROUP_STORAGE_SHARED;
+}
+
+static inline void bpf_cgroup_storage_set(struct bpf_cgroup_storage
+					  *storage[MAX_BPF_CGROUP_STORAGE_TYPE])
+{
+	enum bpf_cgroup_storage_type stype;
 	struct bpf_storage_buffer *buf;
=20
-	if (!storage)
-		return;
+	for_each_cgroup_storage_type(stype) {
+		if (!storage[stype])
+			continue;
=20
-	buf =3D READ_ONCE(storage->buf);
-	this_cpu_write(bpf_cgroup_storage, &buf->data[0]);
+		buf =3D READ_ONCE(storage[stype]->buf);
+		this_cpu_write(bpf_cgroup_storage[stype], &buf->data[0]);
+	}
 }
=20
-struct bpf_cgroup_storage *bpf_cgroup_storage_alloc(struct bpf_prog *prog)=
;
+struct bpf_cgroup_storage *bpf_cgroup_storage_alloc(struct bpf_prog *prog,
+					enum bpf_cgroup_storage_type stype);
 void bpf_cgroup_storage_free(struct bpf_cgroup_storage *storage);
 void bpf_cgroup_storage_link(struct bpf_cgroup_storage *storage,
 			     struct cgroup *cgroup,
@@ -265,13 +280,14 @@ static inline int cgroup_bpf_prog_query(const union b=
pf_attr *attr,
 	return -EINVAL;
 }
=20
-static inline void bpf_cgroup_storage_set(struct bpf_cgroup_storage *stora=
ge) {}
+static inline void bpf_cgroup_storage_set(
+	struct bpf_cgroup_storage *storage[MAX_BPF_CGROUP_STORAGE_TYPE]) {}
 static inline int bpf_cgroup_storage_assign(struct bpf_prog *prog,
 					    struct bpf_map *map) { return 0; }
 static inline void bpf_cgroup_storage_release(struct bpf_prog *prog,
 					      struct bpf_map *map) {}
 static inline struct bpf_cgroup_storage *bpf_cgroup_storage_alloc(
-	struct bpf_prog *prog) { return 0; }
+	struct bpf_prog *prog, enum bpf_cgroup_storage_type stype) { return 0; }
 static inline void bpf_cgroup_storage_free(
 	struct bpf_cgroup_storage *storage) {}
=20
@@ -293,6 +309,8 @@ static inline void bpf_cgroup_storage_free(
 #define BPF_CGROUP_RUN_PROG_SOCK_OPS(sock_ops) ({ 0; })
 #define BPF_CGROUP_RUN_PROG_DEVICE_CGROUP(type,major,minor,access) ({ 0; }=
)
=20
+#define for_each_cgroup_storage_type(stype) for (; false; )
+
 #endif /* CONFIG_CGROUP_BPF */
=20
 #endif /* _BPF_CGROUP_H */
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 988a00797bcd..b457fbe7b70b 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -272,6 +272,13 @@ struct bpf_prog_offload {
 	u32			jited_len;
 };
=20
+enum bpf_cgroup_storage_type {
+	BPF_CGROUP_STORAGE_SHARED,
+	__BPF_CGROUP_STORAGE_MAX
+};
+
+#define MAX_BPF_CGROUP_STORAGE_TYPE __BPF_CGROUP_STORAGE_MAX
+
 struct bpf_prog_aux {
 	atomic_t refcnt;
 	u32 used_map_cnt;
@@ -289,7 +296,7 @@ struct bpf_prog_aux {
 	struct bpf_prog *prog;
 	struct user_struct *user;
 	u64 load_time; /* ns since boottime */
-	struct bpf_map *cgroup_storage;
+	struct bpf_map *cgroup_storage[MAX_BPF_CGROUP_STORAGE_TYPE];
 	char name[BPF_OBJ_NAME_LEN];
 #ifdef CONFIG_SECURITY
 	void *security;
@@ -358,7 +365,7 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const =
union bpf_attr *kattr,
  */
 struct bpf_prog_array_item {
 	struct bpf_prog *prog;
-	struct bpf_cgroup_storage *cgroup_storage;
+	struct bpf_cgroup_storage *cgroup_storage[MAX_BPF_CGROUP_STORAGE_TYPE];
 };
=20
 struct bpf_prog_array {
diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 549f6fbcc461..00f6ed2e4f9a 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -25,6 +25,7 @@ EXPORT_SYMBOL(cgroup_bpf_enabled_key);
  */
 void cgroup_bpf_put(struct cgroup *cgrp)
 {
+	enum bpf_cgroup_storage_type stype;
 	unsigned int type;
=20
 	for (type =3D 0; type < ARRAY_SIZE(cgrp->bpf.progs); type++) {
@@ -34,8 +35,10 @@ void cgroup_bpf_put(struct cgroup *cgrp)
 		list_for_each_entry_safe(pl, tmp, progs, node) {
 			list_del(&pl->node);
 			bpf_prog_put(pl->prog);
-			bpf_cgroup_storage_unlink(pl->storage);
-			bpf_cgroup_storage_free(pl->storage);
+			for_each_cgroup_storage_type(stype) {
+				bpf_cgroup_storage_unlink(pl->storage[stype]);
+				bpf_cgroup_storage_free(pl->storage[stype]);
+			}
 			kfree(pl);
 			static_branch_dec(&cgroup_bpf_enabled_key);
 		}
@@ -97,6 +100,7 @@ static int compute_effective_progs(struct cgroup *cgrp,
 				   enum bpf_attach_type type,
 				   struct bpf_prog_array __rcu **array)
 {
+	enum bpf_cgroup_storage_type stype;
 	struct bpf_prog_array *progs;
 	struct bpf_prog_list *pl;
 	struct cgroup *p =3D cgrp;
@@ -125,7 +129,9 @@ static int compute_effective_progs(struct cgroup *cgrp,
 				continue;
=20
 			progs->items[cnt].prog =3D pl->prog;
-			progs->items[cnt].cgroup_storage =3D pl->storage;
+			for_each_cgroup_storage_type(stype)
+				progs->items[cnt].cgroup_storage[stype] =3D
+					pl->storage[stype];
 			cnt++;
 		}
 	} while ((p =3D cgroup_parent(p)));
@@ -232,7 +238,9 @@ int __cgroup_bpf_attach(struct cgroup *cgrp, struct bpf=
_prog *prog,
 {
 	struct list_head *progs =3D &cgrp->bpf.progs[type];
 	struct bpf_prog *old_prog =3D NULL;
-	struct bpf_cgroup_storage *storage, *old_storage =3D NULL;
+	struct bpf_cgroup_storage *storage[MAX_BPF_CGROUP_STORAGE_TYPE],
+		*old_storage[MAX_BPF_CGROUP_STORAGE_TYPE] =3D {NULL};
+	enum bpf_cgroup_storage_type stype;
 	struct bpf_prog_list *pl;
 	bool pl_was_allocated;
 	int err;
@@ -254,34 +262,44 @@ int __cgroup_bpf_attach(struct cgroup *cgrp, struct b=
pf_prog *prog,
 	if (prog_list_length(progs) >=3D BPF_CGROUP_MAX_PROGS)
 		return -E2BIG;
=20
-	storage =3D bpf_cgroup_storage_alloc(prog);
-	if (IS_ERR(storage))
-		return -ENOMEM;
+	for_each_cgroup_storage_type(stype) {
+		storage[stype] =3D bpf_cgroup_storage_alloc(prog, stype);
+		if (IS_ERR(storage[stype])) {
+			storage[stype] =3D NULL;
+			for_each_cgroup_storage_type(stype)
+				bpf_cgroup_storage_free(storage[stype]);
+			return -ENOMEM;
+		}
+	}
=20
 	if (flags & BPF_F_ALLOW_MULTI) {
 		list_for_each_entry(pl, progs, node) {
 			if (pl->prog =3D=3D prog) {
 				/* disallow attaching the same prog twice */
-				bpf_cgroup_storage_free(storage);
+				for_each_cgroup_storage_type(stype)
+					bpf_cgroup_storage_free(storage[stype]);
 				return -EINVAL;
 			}
 		}
=20
 		pl =3D kmalloc(sizeof(*pl), GFP_KERNEL);
 		if (!pl) {
-			bpf_cgroup_storage_free(storage);
+			for_each_cgroup_storage_type(stype)
+				bpf_cgroup_storage_free(storage[stype]);
 			return -ENOMEM;
 		}
=20
 		pl_was_allocated =3D true;
 		pl->prog =3D prog;
-		pl->storage =3D storage;
+		for_each_cgroup_storage_type(stype)
+			pl->storage[stype] =3D storage[stype];
 		list_add_tail(&pl->node, progs);
 	} else {
 		if (list_empty(progs)) {
 			pl =3D kmalloc(sizeof(*pl), GFP_KERNEL);
 			if (!pl) {
-				bpf_cgroup_storage_free(storage);
+				for_each_cgroup_storage_type(stype)
+					bpf_cgroup_storage_free(storage[stype]);
 				return -ENOMEM;
 			}
 			pl_was_allocated =3D true;
@@ -289,12 +307,15 @@ int __cgroup_bpf_attach(struct cgroup *cgrp, struct b=
pf_prog *prog,
 		} else {
 			pl =3D list_first_entry(progs, typeof(*pl), node);
 			old_prog =3D pl->prog;
-			old_storage =3D pl->storage;
-			bpf_cgroup_storage_unlink(old_storage);
+			for_each_cgroup_storage_type(stype) {
+				old_storage[stype] =3D pl->storage[stype];
+				bpf_cgroup_storage_unlink(old_storage[stype]);
+			}
 			pl_was_allocated =3D false;
 		}
 		pl->prog =3D prog;
-		pl->storage =3D storage;
+		for_each_cgroup_storage_type(stype)
+			pl->storage[stype] =3D storage[stype];
 	}
=20
 	cgrp->bpf.flags[type] =3D flags;
@@ -304,21 +325,27 @@ int __cgroup_bpf_attach(struct cgroup *cgrp, struct b=
pf_prog *prog,
 		goto cleanup;
=20
 	static_branch_inc(&cgroup_bpf_enabled_key);
-	if (old_storage)
-		bpf_cgroup_storage_free(old_storage);
+	for_each_cgroup_storage_type(stype) {
+		if (!old_storage[stype])
+			continue;
+		bpf_cgroup_storage_free(old_storage[stype]);
+	}
 	if (old_prog) {
 		bpf_prog_put(old_prog);
 		static_branch_dec(&cgroup_bpf_enabled_key);
 	}
-	bpf_cgroup_storage_link(storage, cgrp, type);
+	for_each_cgroup_storage_type(stype)
+		bpf_cgroup_storage_link(storage[stype], cgrp, type);
 	return 0;
=20
 cleanup:
 	/* and cleanup the prog list */
 	pl->prog =3D old_prog;
-	bpf_cgroup_storage_free(pl->storage);
-	pl->storage =3D old_storage;
-	bpf_cgroup_storage_link(old_storage, cgrp, type);
+	for_each_cgroup_storage_type(stype) {
+		bpf_cgroup_storage_free(pl->storage[stype]);
+		pl->storage[stype] =3D old_storage[stype];
+		bpf_cgroup_storage_link(old_storage[stype], cgrp, type);
+	}
 	if (pl_was_allocated) {
 		list_del(&pl->node);
 		kfree(pl);
@@ -339,6 +366,7 @@ int __cgroup_bpf_detach(struct cgroup *cgrp, struct bpf=
_prog *prog,
 			enum bpf_attach_type type, u32 unused_flags)
 {
 	struct list_head *progs =3D &cgrp->bpf.progs[type];
+	enum bpf_cgroup_storage_type stype;
 	u32 flags =3D cgrp->bpf.flags[type];
 	struct bpf_prog *old_prog =3D NULL;
 	struct bpf_prog_list *pl;
@@ -385,8 +413,10 @@ int __cgroup_bpf_detach(struct cgroup *cgrp, struct bp=
f_prog *prog,
=20
 	/* now can actually delete it from this cgroup list */
 	list_del(&pl->node);
-	bpf_cgroup_storage_unlink(pl->storage);
-	bpf_cgroup_storage_free(pl->storage);
+	for_each_cgroup_storage_type(stype) {
+		bpf_cgroup_storage_unlink(pl->storage[stype]);
+		bpf_cgroup_storage_free(pl->storage[stype]);
+	}
 	kfree(pl);
 	if (list_empty(progs))
 		/* last program was detached, reset flags to zero */
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 1991466b8327..9070b2ace6aa 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -194,16 +194,18 @@ const struct bpf_func_proto bpf_get_current_cgroup_id=
_proto =3D {
 	.ret_type	=3D RET_INTEGER,
 };
=20
-DECLARE_PER_CPU(void*, bpf_cgroup_storage);
+#ifdef CONFIG_CGROUP_BPF
+DECLARE_PER_CPU(void*, bpf_cgroup_storage[MAX_BPF_CGROUP_STORAGE_TYPE]);
=20
 BPF_CALL_2(bpf_get_local_storage, struct bpf_map *, map, u64, flags)
 {
-	/* map and flags arguments are not used now,
-	 * but provide an ability to extend the API
-	 * for other types of local storages.
-	 * verifier checks that their values are correct.
+	/* flags argument is not used now,
+	 * but provides an ability to extend the API.
+	 * verifier checks that its value is correct.
 	 */
-	return (unsigned long) this_cpu_read(bpf_cgroup_storage);
+	enum bpf_cgroup_storage_type stype =3D cgroup_storage_type(map);
+
+	return (unsigned long) this_cpu_read(bpf_cgroup_storage[stype]);
 }
=20
 const struct bpf_func_proto bpf_get_local_storage_proto =3D {
@@ -214,3 +216,4 @@ const struct bpf_func_proto bpf_get_local_storage_proto=
 =3D {
 	.arg2_type	=3D ARG_ANYTHING,
 };
 #endif
+#endif
diff --git a/kernel/bpf/local_storage.c b/kernel/bpf/local_storage.c
index 22ad967d1e5f..0bd9f19fc557 100644
--- a/kernel/bpf/local_storage.c
+++ b/kernel/bpf/local_storage.c
@@ -7,7 +7,7 @@
 #include <linux/rbtree.h>
 #include <linux/slab.h>
=20
-DEFINE_PER_CPU(void*, bpf_cgroup_storage);
+DEFINE_PER_CPU(void*, bpf_cgroup_storage[MAX_BPF_CGROUP_STORAGE_TYPE]);
=20
 #ifdef CONFIG_CGROUP_BPF
=20
@@ -251,6 +251,7 @@ const struct bpf_map_ops cgroup_storage_map_ops =3D {
=20
 int bpf_cgroup_storage_assign(struct bpf_prog *prog, struct bpf_map *_map)
 {
+	enum bpf_cgroup_storage_type stype =3D cgroup_storage_type(_map);
 	struct bpf_cgroup_storage_map *map =3D map_to_storage(_map);
 	int ret =3D -EBUSY;
=20
@@ -258,11 +259,12 @@ int bpf_cgroup_storage_assign(struct bpf_prog *prog, =
struct bpf_map *_map)
=20
 	if (map->prog && map->prog !=3D prog)
 		goto unlock;
-	if (prog->aux->cgroup_storage && prog->aux->cgroup_storage !=3D _map)
+	if (prog->aux->cgroup_storage[stype] &&
+	    prog->aux->cgroup_storage[stype] !=3D _map)
 		goto unlock;
=20
 	map->prog =3D prog;
-	prog->aux->cgroup_storage =3D _map;
+	prog->aux->cgroup_storage[stype] =3D _map;
 	ret =3D 0;
 unlock:
 	spin_unlock_bh(&map->lock);
@@ -272,24 +274,26 @@ int bpf_cgroup_storage_assign(struct bpf_prog *prog, =
struct bpf_map *_map)
=20
 void bpf_cgroup_storage_release(struct bpf_prog *prog, struct bpf_map *_ma=
p)
 {
+	enum bpf_cgroup_storage_type stype =3D cgroup_storage_type(_map);
 	struct bpf_cgroup_storage_map *map =3D map_to_storage(_map);
=20
 	spin_lock_bh(&map->lock);
 	if (map->prog =3D=3D prog) {
-		WARN_ON(prog->aux->cgroup_storage !=3D _map);
+		WARN_ON(prog->aux->cgroup_storage[stype] !=3D _map);
 		map->prog =3D NULL;
-		prog->aux->cgroup_storage =3D NULL;
+		prog->aux->cgroup_storage[stype] =3D NULL;
 	}
 	spin_unlock_bh(&map->lock);
 }
=20
-struct bpf_cgroup_storage *bpf_cgroup_storage_alloc(struct bpf_prog *prog)
+struct bpf_cgroup_storage *bpf_cgroup_storage_alloc(struct bpf_prog *prog,
+					enum bpf_cgroup_storage_type stype)
 {
 	struct bpf_cgroup_storage *storage;
 	struct bpf_map *map;
 	u32 pages;
=20
-	map =3D prog->aux->cgroup_storage;
+	map =3D prog->aux->cgroup_storage[stype];
 	if (!map)
 		return NULL;
=20
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index b3c2d09bcf7a..8c91d2b41b1e 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -988,10 +988,15 @@ static int find_prog_type(enum bpf_prog_type type, st=
ruct bpf_prog *prog)
 /* drop refcnt on maps used by eBPF program and free auxilary data */
 static void free_used_maps(struct bpf_prog_aux *aux)
 {
+	enum bpf_cgroup_storage_type stype;
 	int i;
=20
-	if (aux->cgroup_storage)
-		bpf_cgroup_storage_release(aux->prog, aux->cgroup_storage);
+	for_each_cgroup_storage_type(stype) {
+		if (!aux->cgroup_storage[stype])
+			continue;
+		bpf_cgroup_storage_release(aux->prog,
+					   aux->cgroup_storage[stype]);
+	}
=20
 	for (i =3D 0; i < aux->used_map_cnt; i++)
 		bpf_map_put(aux->used_maps[i]);
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e986518d7bc3..e90899df585d 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5171,11 +5171,15 @@ static int replace_map_fd_with_map_ptr(struct bpf_v=
erifier_env *env)
 /* drop refcnt of maps used by the rejected program */
 static void release_maps(struct bpf_verifier_env *env)
 {
+	enum bpf_cgroup_storage_type stype;
 	int i;
=20
-	if (env->prog->aux->cgroup_storage)
+	for_each_cgroup_storage_type(stype) {
+		if (!env->prog->aux->cgroup_storage[stype])
+			continue;
 		bpf_cgroup_storage_release(env->prog,
-					   env->prog->aux->cgroup_storage);
+			env->prog->aux->cgroup_storage[stype]);
+	}
=20
 	for (i =3D 0; i < env->used_map_cnt; i++)
 		bpf_map_put(env->used_maps[i]);
diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index f4078830ea50..0c423b8cd75c 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -12,7 +12,7 @@
 #include <linux/sched/signal.h>
=20
 static __always_inline u32 bpf_test_run_one(struct bpf_prog *prog, void *c=
tx,
-					    struct bpf_cgroup_storage *storage)
+		struct bpf_cgroup_storage *storage[MAX_BPF_CGROUP_STORAGE_TYPE])
 {
 	u32 ret;
=20
@@ -28,13 +28,20 @@ static __always_inline u32 bpf_test_run_one(struct bpf_=
prog *prog, void *ctx,
=20
 static u32 bpf_test_run(struct bpf_prog *prog, void *ctx, u32 repeat, u32 =
*time)
 {
-	struct bpf_cgroup_storage *storage =3D NULL;
+	struct bpf_cgroup_storage *storage[MAX_BPF_CGROUP_STORAGE_TYPE] =3D { 0 }=
;
+	enum bpf_cgroup_storage_type stype;
 	u64 time_start, time_spent =3D 0;
 	u32 ret =3D 0, i;
=20
-	storage =3D bpf_cgroup_storage_alloc(prog);
-	if (IS_ERR(storage))
-		return PTR_ERR(storage);
+	for_each_cgroup_storage_type(stype) {
+		storage[stype] =3D bpf_cgroup_storage_alloc(prog, stype);
+		if (IS_ERR(storage[stype])) {
+			storage[stype] =3D NULL;
+			for_each_cgroup_storage_type(stype)
+				bpf_cgroup_storage_free(storage[stype]);
+			return -ENOMEM;
+		}
+	}
=20
 	if (!repeat)
 		repeat =3D 1;
@@ -53,7 +60,8 @@ static u32 bpf_test_run(struct bpf_prog *prog, void *ctx,=
 u32 repeat, u32 *time)
 	do_div(time_spent, repeat);
 	*time =3D time_spent > U32_MAX ? U32_MAX : (u32)time_spent;
=20
-	bpf_cgroup_storage_free(storage);
+	for_each_cgroup_storage_type(stype)
+		bpf_cgroup_storage_free(storage[stype]);
=20
 	return ret;
 }
--=20
2.17.1

