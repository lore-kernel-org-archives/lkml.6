Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E995BC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 14:47:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9149D20684
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 14:47:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="mSDqDRwa";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="EopC4QdT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9149D20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729634AbeI1VLI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 17:11:08 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:51114 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726971AbeI1VKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 17:10:42 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8SEij1x018116;
        Fri, 28 Sep 2018 07:46:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=06eXqkH2uD/eqet+025nPN9KjGr/5sXUGZjLiNs4ddk=;
 b=mSDqDRwaBCVt41Oh9AHw+YQsF3Mrjeigx4WdMRKavTA5fCJI4JjvZ7/NXRlpTWlrq0e6
 DY2a5VAWiZ1BAL72ILeoUxVMIzRSvm4iL5WqjHA051LQWly35asNFIpSe+P4aoe57yxu
 vp/7W9E8bdbCS50Ldvc+7qxjZb/9/K/Kc/U= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2msn3b08v8-2
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 28 Sep 2018 07:46:13 -0700
Received: from PRN-CHUB02.TheFacebook.com (2620:10d:c081:35::11) by
 PRN-CHUB05.TheFacebook.com (2620:10d:c081:35::14) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Fri, 28 Sep 2018 07:46:12 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.12) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Fri, 28 Sep 2018 07:46:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=06eXqkH2uD/eqet+025nPN9KjGr/5sXUGZjLiNs4ddk=;
 b=EopC4QdTReCtlKqQtJPxV2LPBXh3SNZmZQXmVNwOJckwVQoWFWKrsXfnFXjmUkmPLAhDr/G+vgP6uPhyAjhS+X5QFOA0ZcyxIR4EIf4R4pRBlRTLJDTDRLYvN8AOrpkjT8sGVS8nh0ohZEV74xmjJMKExxcR5e69Gwl6WMl5xfw=
Received: from BY2PR15MB0167.namprd15.prod.outlook.com (10.163.64.141) by
 BY2PR15MB0453.namprd15.prod.outlook.com (10.163.110.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.22; Fri, 28 Sep 2018 14:46:01 +0000
Received: from BY2PR15MB0167.namprd15.prod.outlook.com
 ([fe80::5c5b:75ea:cae:1e68]) by BY2PR15MB0167.namprd15.prod.outlook.com
 ([fe80::5c5b:75ea:cae:1e68%2]) with mapi id 15.20.1164.027; Fri, 28 Sep 2018
 14:46:01 +0000
From:   Roman Gushchin <guro@fb.com>
To:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>, Roman Gushchin <guro@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH v4 bpf-next 10/10] selftests/bpf: cgroup local storage-based
 network counters
Thread-Topic: [PATCH v4 bpf-next 10/10] selftests/bpf: cgroup local
 storage-based network counters
Thread-Index: AQHUVzn50kav+Are2UODT3Zgz+TG4g==
Date:   Fri, 28 Sep 2018 14:46:00 +0000
Message-ID: <20180928144452.5284-11-guro@fb.com>
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
x-microsoft-exchange-diagnostics: 1;BY2PR15MB0453;20:mplSH0mGxlz01zdekSjv2anTlxwQkbmHsTmzA3xv0+WZCah55ZvdLF4jK6EJDULkODDF6Qgvmh8urWI7ZmzM9Zh4551oAZLopkuIUHxRPrUL9/clIooDIn/nuDSsqtGnBP+1sulJCPC4E9t5Qhk3NRbHpLIlm1faLa9+uffi5NM=
x-ms-office365-filtering-correlation-id: 0816d96f-7584-4826-c48a-08d625511b99
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BY2PR15MB0453;
x-ms-traffictypediagnostic: BY2PR15MB0453:
x-microsoft-antispam-prvs: <BY2PR15MB0453EAAEEAE1102EA848345BBEEC0@BY2PR15MB0453.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(265634631926514)(67672495146484);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231355)(11241501184)(944501410)(52105095)(10201501046)(93006095)(93001095)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201708071742011)(7699051)(76991041);SRVR:BY2PR15MB0453;BCL:0;PCL:0;RULEID:;SRVR:BY2PR15MB0453;
x-forefront-prvs: 0809C12563
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(366004)(136003)(39860400002)(199004)(189003)(478600001)(34290500001)(1076002)(476003)(7736002)(4326008)(25786009)(5250100002)(36756003)(6116002)(68736007)(305945005)(446003)(2501003)(46003)(5660300001)(14454004)(54906003)(486006)(99286004)(575784001)(86362001)(316002)(53936002)(52116002)(6436002)(105586002)(2900100001)(6486002)(76176011)(14444005)(256004)(6916009)(1730700003)(102836004)(8936002)(71190400001)(106356001)(6512007)(97736004)(2616005)(2351001)(81166006)(11346002)(81156014)(2906002)(71200400001)(5640700003)(8676002)(186003)(5024004)(6506007)(386003)(42262002)(309714004);DIR:OUT;SFP:1102;SCL:1;SRVR:BY2PR15MB0453;H:BY2PR15MB0167.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: PMG5yQK1rm3NT044Rzk26PY71u/fCyn6hU9aQpITGwbzlNCPmG90rRunXD3uU51SpE/rhS4/H4w3VbDtD8Vpuz/4DlG8p5EmomBbU8cB0YaTGkr8qsoqPtRFumaxWZGsSLyMtwZz4uFBhg6j7dVZvkkT8t93mzR1j1T2/zTClOSl5C8GVi44WKv8pH82MolslMY0zTyQOpgREg48kr7VKszpQfbzLqX1Xewv46cnBkEwbSQvLqiuL5lXeHDePxCBEdnBaUKm1+yuOtQuYrVYowInWrTlAPZU34KXm3cVvPOZ+KsE1kd9jwQ38QAYCXk+JEBNGm2frl9JyMDk8sUVN/ygMn2GrQlPdmEFX3t0dOU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 0816d96f-7584-4826-c48a-08d625511b99
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2018 14:46:01.0028
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR15MB0453
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-28_06:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds a bpf kselftest, which demonstrates how percpu
and shared cgroup local storage can be used for efficient lookup-free
network accounting.

Cgroup local storage provides generic memory area with a very efficient
lookup free access. To avoid expensive atomic operations for each
packet, per-cpu cgroup local storage is used. Each packet is initially
charged to a per-cpu counter, and only if the counter reaches certain
value (32 in this case), the charge is moved into the global atomic
counter. This allows to amortize atomic operations, keeping reasonable
accuracy.

The test also implements a naive network traffic throttling, mostly to
demonstrate the possibility of bpf cgroup--based network bandwidth
control.

Expected output:
  ./test_netcnt
  test_netcnt:PASS

Signed-off-by: Roman Gushchin <guro@fb.com>
Acked-by: Song Liu <songliubraving@fb.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Alexei Starovoitov <ast@kernel.org>
---
 tools/testing/selftests/bpf/Makefile        |   6 +-
 tools/testing/selftests/bpf/netcnt_common.h |  24 +++
 tools/testing/selftests/bpf/netcnt_prog.c   |  71 +++++++++
 tools/testing/selftests/bpf/test_netcnt.c   | 158 ++++++++++++++++++++
 4 files changed, 257 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/netcnt_common.h
 create mode 100644 tools/testing/selftests/bpf/netcnt_prog.c
 create mode 100644 tools/testing/selftests/bpf/test_netcnt.c

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests=
/bpf/Makefile
index 059d64a0f897..f802de526f57 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -23,7 +23,8 @@ $(TEST_CUSTOM_PROGS): $(OUTPUT)/%: %.c
 TEST_GEN_PROGS =3D test_verifier test_tag test_maps test_lru_map test_lpm_=
map test_progs \
 	test_align test_verifier_log test_dev_cgroup test_tcpbpf_user \
 	test_sock test_btf test_sockmap test_lirc_mode2_user get_cgroup_id_user \
-	test_socket_cookie test_cgroup_storage test_select_reuseport test_section=
_names
+	test_socket_cookie test_cgroup_storage test_select_reuseport test_section=
_names \
+	test_netcnt
=20
 TEST_GEN_FILES =3D test_pkt_access.o test_xdp.o test_l4lb.o test_tcp_estat=
s.o test_obj_id.o \
 	test_pkt_md_access.o test_xdp_redirect.o test_xdp_meta.o sockmap_parse_pr=
og.o     \
@@ -35,7 +36,7 @@ TEST_GEN_FILES =3D test_pkt_access.o test_xdp.o test_l4lb=
.o test_tcp_estats.o test
 	test_get_stack_rawtp.o test_sockmap_kern.o test_sockhash_kern.o \
 	test_lwt_seg6local.o sendmsg4_prog.o sendmsg6_prog.o test_lirc_mode2_kern=
.o \
 	get_cgroup_id_kern.o socket_cookie_prog.o test_select_reuseport_kern.o \
-	test_skb_cgroup_id_kern.o bpf_flow.o
+	test_skb_cgroup_id_kern.o bpf_flow.o netcnt_prog.o
=20
 # Order correspond to 'make run_tests' order
 TEST_PROGS :=3D test_kmod.sh \
@@ -72,6 +73,7 @@ $(OUTPUT)/test_tcpbpf_user: cgroup_helpers.c
 $(OUTPUT)/test_progs: trace_helpers.c
 $(OUTPUT)/get_cgroup_id_user: cgroup_helpers.c
 $(OUTPUT)/test_cgroup_storage: cgroup_helpers.c
+$(OUTPUT)/test_netcnt: cgroup_helpers.c
=20
 .PHONY: force
=20
diff --git a/tools/testing/selftests/bpf/netcnt_common.h b/tools/testing/se=
lftests/bpf/netcnt_common.h
new file mode 100644
index 000000000000..81084c1c2c23
--- /dev/null
+++ b/tools/testing/selftests/bpf/netcnt_common.h
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0
+#ifndef __NETCNT_COMMON_H
+#define __NETCNT_COMMON_H
+
+#include <linux/types.h>
+
+#define MAX_PERCPU_PACKETS 32
+
+struct percpu_net_cnt {
+	__u64 packets;
+	__u64 bytes;
+
+	__u64 prev_ts;
+
+	__u64 prev_packets;
+	__u64 prev_bytes;
+};
+
+struct net_cnt {
+	__u64 packets;
+	__u64 bytes;
+};
+
+#endif
diff --git a/tools/testing/selftests/bpf/netcnt_prog.c b/tools/testing/self=
tests/bpf/netcnt_prog.c
new file mode 100644
index 000000000000..1198abca1360
--- /dev/null
+++ b/tools/testing/selftests/bpf/netcnt_prog.c
@@ -0,0 +1,71 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/bpf.h>
+#include <linux/version.h>
+
+#include "bpf_helpers.h"
+#include "netcnt_common.h"
+
+#define MAX_BPS	(3 * 1024 * 1024)
+
+#define REFRESH_TIME_NS	100000000
+#define NS_PER_SEC	1000000000
+
+struct bpf_map_def SEC("maps") percpu_netcnt =3D {
+	.type =3D BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE,
+	.key_size =3D sizeof(struct bpf_cgroup_storage_key),
+	.value_size =3D sizeof(struct percpu_net_cnt),
+};
+
+struct bpf_map_def SEC("maps") netcnt =3D {
+	.type =3D BPF_MAP_TYPE_CGROUP_STORAGE,
+	.key_size =3D sizeof(struct bpf_cgroup_storage_key),
+	.value_size =3D sizeof(struct net_cnt),
+};
+
+SEC("cgroup/skb")
+int bpf_nextcnt(struct __sk_buff *skb)
+{
+	struct percpu_net_cnt *percpu_cnt;
+	char fmt[] =3D "%d %llu %llu\n";
+	struct net_cnt *cnt;
+	__u64 ts, dt;
+	int ret;
+
+	cnt =3D bpf_get_local_storage(&netcnt, 0);
+	percpu_cnt =3D bpf_get_local_storage(&percpu_netcnt, 0);
+
+	percpu_cnt->packets++;
+	percpu_cnt->bytes +=3D skb->len;
+
+	if (percpu_cnt->packets > MAX_PERCPU_PACKETS) {
+		__sync_fetch_and_add(&cnt->packets,
+				     percpu_cnt->packets);
+		percpu_cnt->packets =3D 0;
+
+		__sync_fetch_and_add(&cnt->bytes,
+				     percpu_cnt->bytes);
+		percpu_cnt->bytes =3D 0;
+	}
+
+	ts =3D bpf_ktime_get_ns();
+	dt =3D ts - percpu_cnt->prev_ts;
+
+	dt *=3D MAX_BPS;
+	dt /=3D NS_PER_SEC;
+
+	if (cnt->bytes + percpu_cnt->bytes - percpu_cnt->prev_bytes < dt)
+		ret =3D 1;
+	else
+		ret =3D 0;
+
+	if (dt > REFRESH_TIME_NS) {
+		percpu_cnt->prev_ts =3D ts;
+		percpu_cnt->prev_packets =3D cnt->packets;
+		percpu_cnt->prev_bytes =3D cnt->bytes;
+	}
+
+	return !!ret;
+}
+
+char _license[] SEC("license") =3D "GPL";
+__u32 _version SEC("version") =3D LINUX_VERSION_CODE;
diff --git a/tools/testing/selftests/bpf/test_netcnt.c b/tools/testing/self=
tests/bpf/test_netcnt.c
new file mode 100644
index 000000000000..7887df693399
--- /dev/null
+++ b/tools/testing/selftests/bpf/test_netcnt.c
@@ -0,0 +1,158 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <errno.h>
+#include <assert.h>
+#include <sys/sysinfo.h>
+#include <sys/time.h>
+
+#include <linux/bpf.h>
+#include <bpf/bpf.h>
+#include <bpf/libbpf.h>
+
+#include "cgroup_helpers.h"
+#include "bpf_rlimit.h"
+#include "netcnt_common.h"
+
+#define BPF_PROG "./netcnt_prog.o"
+#define TEST_CGROUP "/test-network-counters/"
+
+static int bpf_find_map(const char *test, struct bpf_object *obj,
+			const char *name)
+{
+	struct bpf_map *map;
+
+	map =3D bpf_object__find_map_by_name(obj, name);
+	if (!map) {
+		printf("%s:FAIL:map '%s' not found\n", test, name);
+		return -1;
+	}
+	return bpf_map__fd(map);
+}
+
+int main(int argc, char **argv)
+{
+	struct percpu_net_cnt *percpu_netcnt;
+	struct bpf_cgroup_storage_key key;
+	int map_fd, percpu_map_fd;
+	int error =3D EXIT_FAILURE;
+	struct net_cnt netcnt;
+	struct bpf_object *obj;
+	int prog_fd, cgroup_fd;
+	unsigned long packets;
+	unsigned long bytes;
+	int cpu, nproc;
+	__u32 prog_cnt;
+
+	nproc =3D get_nprocs_conf();
+	percpu_netcnt =3D malloc(sizeof(*percpu_netcnt) * nproc);
+	if (!percpu_netcnt) {
+		printf("Not enough memory for per-cpu area (%d cpus)\n", nproc);
+		goto err;
+	}
+
+	if (bpf_prog_load(BPF_PROG, BPF_PROG_TYPE_CGROUP_SKB,
+			  &obj, &prog_fd)) {
+		printf("Failed to load bpf program\n");
+		goto out;
+	}
+
+	if (setup_cgroup_environment()) {
+		printf("Failed to load bpf program\n");
+		goto err;
+	}
+
+	/* Create a cgroup, get fd, and join it */
+	cgroup_fd =3D create_and_get_cgroup(TEST_CGROUP);
+	if (!cgroup_fd) {
+		printf("Failed to create test cgroup\n");
+		goto err;
+	}
+
+	if (join_cgroup(TEST_CGROUP)) {
+		printf("Failed to join cgroup\n");
+		goto err;
+	}
+
+	/* Attach bpf program */
+	if (bpf_prog_attach(prog_fd, cgroup_fd, BPF_CGROUP_INET_EGRESS, 0)) {
+		printf("Failed to attach bpf program");
+		goto err;
+	}
+
+	assert(system("ping localhost -6 -c 10000 -f -q > /dev/null") =3D=3D 0);
+
+	if (bpf_prog_query(cgroup_fd, BPF_CGROUP_INET_EGRESS, 0, NULL, NULL,
+			   &prog_cnt)) {
+		printf("Failed to query attached programs");
+		goto err;
+	}
+
+	map_fd =3D bpf_find_map(__func__, obj, "netcnt");
+	if (map_fd < 0) {
+		printf("Failed to find bpf map with net counters");
+		goto err;
+	}
+
+	percpu_map_fd =3D bpf_find_map(__func__, obj, "percpu_netcnt");
+	if (percpu_map_fd < 0) {
+		printf("Failed to find bpf map with percpu net counters");
+		goto err;
+	}
+
+	if (bpf_map_get_next_key(map_fd, NULL, &key)) {
+		printf("Failed to get key in cgroup storage\n");
+		goto err;
+	}
+
+	if (bpf_map_lookup_elem(map_fd, &key, &netcnt)) {
+		printf("Failed to lookup cgroup storage\n");
+		goto err;
+	}
+
+	if (bpf_map_lookup_elem(percpu_map_fd, &key, &percpu_netcnt[0])) {
+		printf("Failed to lookup percpu cgroup storage\n");
+		goto err;
+	}
+
+	/* Some packets can be still in per-cpu cache, but not more than
+	 * MAX_PERCPU_PACKETS.
+	 */
+	packets =3D netcnt.packets;
+	bytes =3D netcnt.bytes;
+	for (cpu =3D 0; cpu < nproc; cpu++) {
+		if (percpu_netcnt[cpu].packets > MAX_PERCPU_PACKETS) {
+			printf("Unexpected percpu value: %llu\n",
+			       percpu_netcnt[cpu].packets);
+			goto err;
+		}
+
+		packets +=3D percpu_netcnt[cpu].packets;
+		bytes +=3D percpu_netcnt[cpu].bytes;
+	}
+
+	/* No packets should be lost */
+	if (packets !=3D 10000) {
+		printf("Unexpected packet count: %lu\n", packets);
+		goto err;
+	}
+
+	/* Let's check that bytes counter matches the number of packets
+	 * multiplied by the size of ipv6 ICMP packet.
+	 */
+	if (bytes !=3D packets * 104) {
+		printf("Unexpected bytes count: %lu\n", bytes);
+		goto err;
+	}
+
+	error =3D 0;
+	printf("test_netcnt:PASS\n");
+
+err:
+	cleanup_cgroup_environment();
+	free(percpu_netcnt);
+
+out:
+	return error;
+}
--=20
2.17.1

