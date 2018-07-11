Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF3C3C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 03:29:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 664E620849
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 03:29:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="VDvVYzwz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 664E620849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732519AbeGKDbN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 23:31:13 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:38930 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732365AbeGKDbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 23:31:09 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6B3Pc04004755
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 20:28:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date : from
 : to : cc : subject : references : mime-version : content-type;
 s=facebook; bh=UOlkrQqFy3aHoebnRqT5SO5NeWtBiQb59NCHuTnc5+8=;
 b=VDvVYzwzGQ8PCYwr+9wmqUPQQ37gMChnNOpkTvZyXHBgB9QRKxm4qfO/KRfm6FKpeIex
 pKz+owowDBPXUsm7PSwSW/dBi2a5ApbzjQroOTjOgxWancQjLxBUuFCc5UBK12GY5ob0
 hWxxP9/liVnYC6lQuUb0C3I1+vMX1A1sDTs= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2k599k02kc-3
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 20:28:57 -0700
Received: from mx-out.facebook.com (192.168.52.123) by mail.thefacebook.com
 (192.168.16.16) with Microsoft SMTP Server (TLS) id 14.3.361.1; Tue, 10 Jul
 2018 20:28:57 -0700
Received: by dev026.lla1.facebook.com (Postfix, from userid 152872)     id
 C2BF98A468C; Tue, 10 Jul 2018 20:25:57 -0700 (PDT)
Message-ID: <20180711032557.728015225@fb.com>
User-Agent: quilt/0.63-1
Date:   Tue, 10 Jul 2018 20:21:10 -0700
Smtp-Origin-Hostprefix: dev
From:   Okash Khawaja <osk@fb.com>
Smtp-Origin-Hostname: dev026.lla1.facebook.com
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        "David S. Miller" <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <kernel-team@fb.com>,
        <linux-kernel@vger.kernel.org>
Smtp-Origin-Cluster: lla1c22
Subject: [PATCH bpf-next v4 2/3] bpf: btf: add btf print functionality
References: <20180711032108.631367556@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline; filename="02-add-btf-dump-map.patch"
X-FB-Internal: Safe
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-10_09:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This consumes functionality exported in the previous patch. It does the
main job of printing with BTF data. This is used in the following patch
to provide a more readable output of a map's dump. It relies on
json_writer to do json printing. Below is sample output where map keys
are ints and values are of type struct A:

typedef int int_type;
enum E {
        E0,
        E1,
};

struct B {
        int x;
        int y;
};

struct A {
        int m;
        unsigned long long n;
        char o;
        int p[8];
        int q[4][8];
        enum E r;
        void *s;
        struct B t;
        const int u;
        int_type v;
        unsigned int w1: 3;
        unsigned int w2: 3;
};

$ sudo bpftool map dump id 14
[{
        "key": 0,
        "value": {
            "m": 1,
            "n": 2,
            "o": "c",
            "p": [15,16,17,18,15,16,17,18
            ],
            "q": [[25,26,27,28,25,26,27,28
                ],[35,36,37,38,35,36,37,38
                ],[45,46,47,48,45,46,47,48
                ],[55,56,57,58,55,56,57,58
                ]
            ],
            "r": 1,
            "s": 0x7ffd80531cf8,
            "t": {
                "x": 5,
                "y": 10
            },
            "u": 100,
            "v": 20,
            "w1": 0x7,
            "w2": 0x3
        }
    }
]

This patch uses json's {} and [] to imply struct/union and array. More
explicit information can be added later. For example, a command line
option can be introduced to print whether a key or value is struct
or union, name of a struct etc. This will however come at the expense
of duplicating info when, for example, printing an array of structs.
enums are printed as ints without their names.

Signed-off-by: Okash Khawaja <osk@fb.com>

---
 tools/bpf/bpftool/btf_dumper.c |  248 +++++++++++++++++++++++++++++++++++++++++
 tools/bpf/bpftool/main.h       |   15 ++
 2 files changed, 263 insertions(+)

--- /dev/null
+++ b/tools/bpf/bpftool/btf_dumper.c
@@ -0,0 +1,248 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2018 Facebook */
+
+#include <linux/btf.h>
+#include <linux/err.h>
+#include <stdio.h> /* for (FILE *) used by json_writer */
+#include <linux/bitops.h>
+#include <string.h>
+#include <ctype.h>
+
+#include "btf.h"
+#include "json_writer.h"
+#include "main.h"
+
+#define BITS_PER_BYTE_MASK (BITS_PER_BYTE - 1)
+#define BITS_PER_BYTE_MASKED(bits) ((bits) & BITS_PER_BYTE_MASK)
+#define BITS_ROUNDDOWN_BYTES(bits) ((bits) >> 3)
+#define BITS_ROUNDUP_BYTES(bits) \
+	(BITS_ROUNDDOWN_BYTES(bits) + !!BITS_PER_BYTE_MASKED(bits))
+
+static int btf_dumper_do_type(const struct btf_dumper *d, __u32 type_id,
+			      __u8 bit_offset, const void *data);
+
+static void btf_dumper_ptr(const void *data, json_writer_t *jw,
+			   bool is_plain_text)
+{
+	if (is_plain_text)
+		jsonw_printf(jw, "%p", *((unsigned long *)data));
+	else
+		jsonw_printf(jw, "%u", *((unsigned long *)data));
+}
+
+static int btf_dumper_modifier(const struct btf_dumper *d, __u32 type_id,
+			       const void *data)
+{
+	int actual_type_id;
+
+	actual_type_id = btf__resolve_type(d->btf, type_id);
+	if (actual_type_id < 0)
+		return actual_type_id;
+
+	return btf_dumper_do_type(d, actual_type_id, 0, data);
+}
+
+static void btf_dumper_enum(const void *data, json_writer_t *jw)
+{
+	jsonw_printf(jw, "%d", *(int *)data);
+}
+
+static int btf_dumper_array(const struct btf_dumper *d, __u32 type_id,
+			    const void *data)
+{
+	const struct btf_type *t = btf__type_by_id(d->btf, type_id);
+	struct btf_array *arr = (struct btf_array *)(t + 1);
+	long long elem_size;
+	int ret = 0;
+	__u32 i;
+
+	elem_size = btf__resolve_size(d->btf, arr->type);
+	if (elem_size < 0)
+		return elem_size;
+
+	jsonw_start_array(d->jw);
+	for (i = 0; i < arr->nelems; i++) {
+		ret = btf_dumper_do_type(d, arr->type, 0,
+					 data + i * elem_size);
+		if (ret)
+			break;
+	}
+
+	jsonw_end_array(d->jw);
+	return ret;
+}
+
+static void btf_dumper_int_bits(__u32 int_type, __u8 bit_offset,
+				const void *data, json_writer_t *jw,
+				bool is_plain_text)
+{
+	int left_shift_bits, right_shift_bits;
+	int nr_bits = BTF_INT_BITS(int_type);
+	int total_bits_offset;
+	int bytes_to_copy;
+	int bits_to_copy;
+	__u64 print_num;
+
+	total_bits_offset = bit_offset + BTF_INT_OFFSET(int_type);
+	data += BITS_ROUNDDOWN_BYTES(total_bits_offset);
+	bit_offset = BITS_PER_BYTE_MASKED(total_bits_offset);
+	bits_to_copy = bit_offset + nr_bits;
+	bytes_to_copy = BITS_ROUNDUP_BYTES(bits_to_copy);
+
+	print_num = 0;
+	memcpy(&print_num, data, bytes_to_copy);
+#ifdef __BIG_ENDIAN_BITFIELD
+	left_shift_bits = bit_offset;
+#else
+	left_shift_bits = 64 - bits_to_copy;
+#endif
+	right_shift_bits = 64 - nr_bits;
+
+	print_num <<= left_shift_bits;
+	print_num >>= right_shift_bits;
+	if (is_plain_text)
+		jsonw_printf(jw, "0x%llx", print_num);
+	else
+		jsonw_printf(jw, "%llu", print_num);
+}
+
+static int btf_dumper_int(const struct btf_type *t, __u8 bit_offset,
+			  const void *data, json_writer_t *jw,
+			  bool is_plain_text)
+{
+	__u32 *int_type;
+	__u32 nr_bits;
+
+	int_type = (__u32 *)(t + 1);
+	nr_bits = BTF_INT_BITS(*int_type);
+	/* if this is bit field */
+	if (bit_offset || BTF_INT_OFFSET(*int_type) ||
+	    BITS_PER_BYTE_MASKED(nr_bits)) {
+		btf_dumper_int_bits(*int_type, bit_offset, data, jw,
+				    is_plain_text);
+		return 0;
+	}
+
+	switch (BTF_INT_ENCODING(*int_type)) {
+	case 0:
+		if (BTF_INT_BITS(*int_type) == 64)
+			jsonw_printf(jw, "%lu", *(__u64 *)data);
+		else if (BTF_INT_BITS(*int_type) == 32)
+			jsonw_printf(jw, "%u", *(__u32 *)data);
+		else if (BTF_INT_BITS(*int_type) == 16)
+			jsonw_printf(jw, "%hu", *(__u16 *)data);
+		else if (BTF_INT_BITS(*int_type) == 8)
+			jsonw_printf(jw, "%hhu", *(__u8 *)data);
+		else
+			btf_dumper_int_bits(*int_type, bit_offset, data, jw,
+					    is_plain_text);
+		break;
+	case BTF_INT_SIGNED:
+		if (BTF_INT_BITS(*int_type) == 64)
+			jsonw_printf(jw, "%ld", *(long long *)data);
+		else if (BTF_INT_BITS(*int_type) == 32)
+			jsonw_printf(jw, "%d", *(int *)data);
+		else if (BTF_INT_BITS(*int_type) == 16)
+			jsonw_printf(jw, "%hd", *(short *)data);
+		else if (BTF_INT_BITS(*int_type) == 8)
+			jsonw_printf(jw, "%hhd", *(char *)data);
+		else
+			btf_dumper_int_bits(*int_type, bit_offset, data, jw,
+					    is_plain_text);
+		break;
+	case BTF_INT_CHAR:
+		if (isprint(*(char *)data))
+			jsonw_printf(jw, "\"%c\"", *(char *)data);
+		else
+			if (is_plain_text)
+				jsonw_printf(jw, "0x%hhx", *(char *)data);
+			else
+				jsonw_printf(jw, "\"\\u00%02hhx\"",
+					     *(char *)data);
+		break;
+	case BTF_INT_BOOL:
+		jsonw_bool(jw, *(int *)data);
+		break;
+	default:
+		/* shouldn't happen */
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int btf_dumper_struct(const struct btf_dumper *d, __u32 type_id,
+			     const void *data)
+{
+	const struct btf_type *t;
+	struct btf_member *m;
+	const void *data_off;
+	int ret = 0;
+	int i, vlen;
+
+	t = btf__type_by_id(d->btf, type_id);
+	if (!t)
+		return -EINVAL;
+
+	vlen = BTF_INFO_VLEN(t->info);
+	jsonw_start_object(d->jw);
+	m = (struct btf_member *)(t + 1);
+
+	for (i = 0; i < vlen; i++) {
+		data_off = data + BITS_ROUNDDOWN_BYTES(m[i].offset);
+		jsonw_name(d->jw, btf__name_by_offset(d->btf, m[i].name_off));
+		ret = btf_dumper_do_type(d, m[i].type,
+					 BITS_PER_BYTE_MASKED(m[i].offset),
+					 data_off);
+		if (ret)
+			break;
+	}
+
+	jsonw_end_object(d->jw);
+
+	return ret;
+}
+
+static int btf_dumper_do_type(const struct btf_dumper *d, __u32 type_id,
+			      __u8 bit_offset, const void *data)
+{
+	const struct btf_type *t = btf__type_by_id(d->btf, type_id);
+
+	switch (BTF_INFO_KIND(t->info)) {
+	case BTF_KIND_INT:
+		return btf_dumper_int(t, bit_offset, data, d->jw,
+				     d->is_plain_text);
+	case BTF_KIND_STRUCT:
+	case BTF_KIND_UNION:
+		return btf_dumper_struct(d, type_id, data);
+	case BTF_KIND_ARRAY:
+		return btf_dumper_array(d, type_id, data);
+	case BTF_KIND_ENUM:
+		btf_dumper_enum(data, d->jw);
+		return 0;
+	case BTF_KIND_PTR:
+		btf_dumper_ptr(data, d->jw, d->is_plain_text);
+		return 0;
+	case BTF_KIND_UNKN:
+		jsonw_printf(d->jw, "(unknown)");
+		return 0;
+	case BTF_KIND_FWD:
+		/* map key or value can't be forward */
+		jsonw_printf(d->jw, "(fwd-kind-invalid)");
+		return -EINVAL;
+	case BTF_KIND_TYPEDEF:
+	case BTF_KIND_VOLATILE:
+	case BTF_KIND_CONST:
+	case BTF_KIND_RESTRICT:
+		return btf_dumper_modifier(d, type_id, data);
+	default:
+		jsonw_printf(d->jw, "(unsupported-kind");
+		return -EINVAL;
+	}
+}
+
+int btf_dumper_type(const struct btf_dumper *d, __u32 type_id,
+		    const void *data)
+{
+	return btf_dumper_do_type(d, type_id, 0, data);
+}
--- a/tools/bpf/bpftool/main.h
+++ b/tools/bpf/bpftool/main.h
@@ -131,4 +131,19 @@ unsigned int get_page_size(void);
 unsigned int get_possible_cpus(void);
 const char *ifindex_to_bfd_name_ns(__u32 ifindex, __u64 ns_dev, __u64 ns_ino);
 
+struct btf_dumper {
+	const struct btf *btf;
+	json_writer_t *jw;
+	bool is_plain_text;
+};
+
+/* btf_dumper_type - print data along with type information
+ * @d: an instance containing context for dumping types
+ * @type_id: index in btf->types array. this points to the type to be dumped
+ * @data: pointer the actual data, i.e. the values to be printed
+ *
+ * Returns zero on success and negative error code otherwise
+ */
+int btf_dumper_type(const struct btf_dumper *d, __u32 type_id,
+		    const void *data);
 #endif

