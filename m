Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07D76C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 19:16:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A15DB24F78
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 19:16:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="AEqrFsxj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A15DB24F78
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753510AbeGBTQ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 15:16:27 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:59300 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752629AbeGBTQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 15:16:24 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w62JEgMH006499
        for <linux-kernel@vger.kernel.org>; Mon, 2 Jul 2018 12:16:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date : from
 : to : cc : subject : references : mime-version : content-type;
 s=facebook; bh=+ut4ARZtwREB61nQz6nzW8UIzm8UxyPOMSeXC9SKInU=;
 b=AEqrFsxj6pZxpmIs9eFp8pgZZgVCrFMNilG4NFdyeGjLHn1KzXsPi4k7+sHI1WuFrpTf
 RGWcdf+uxqZ+f+TXWOmzndcZIPRUDEjAG9/NS9B63VZKUNRGahISXD9+4EV7rtbLJPJa
 iZ40FloCkjdShnE+ekhwvfMVj7/PG3eJlVs= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2jypqv8k4f-2
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 12:16:23 -0700
Received: from mx-out.facebook.com (192.168.52.123) by mail.thefacebook.com
 (192.168.16.17) with Microsoft SMTP Server (TLS) id 14.3.361.1; Mon, 2 Jul
 2018 12:16:21 -0700
Received: by dev026.lla1.facebook.com (Postfix, from userid 152872)     id
 A479E8A4542; Mon,  2 Jul 2018 12:13:24 -0700 (PDT)
Message-ID: <20180702191324.570616684@fb.com>
User-Agent: quilt/0.63-1
Date:   Mon, 2 Jul 2018 11:39:15 -0700
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
Subject: [PATCH bpf-next v2 2/3] bpf: btf: add btf print functionality
References: <20180702183913.669030439@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline; filename="02-add-btf-dump-map.patch"
X-FB-Internal: Safe
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-02_06:,,
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
 tools/bpf/bpftool/btf_dumper.c |  263 +++++++++++++++++++++++++++++++++++++++++
 tools/bpf/bpftool/btf_dumper.h |   23 +++
 2 files changed, 286 insertions(+)

--- /dev/null
+++ b/tools/bpf/bpftool/btf_dumper.c
@@ -0,0 +1,263 @@
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
+#include "btf_dumper.h"
+
+#define BITS_PER_BYTE_MASK (BITS_PER_BYTE - 1)
+#define BITS_PER_BYTE_MASKED(bits) ((bits) & BITS_PER_BYTE_MASK)
+#define BITS_ROUNDDOWN_BYTES(bits) ((bits) >> 3)
+#define BITS_ROUNDUP_BYTES(bits) \
+	(BITS_ROUNDDOWN_BYTES(bits) + !!BITS_PER_BYTE_MASKED(bits))
+
+static int btf_dumper_do_type(const struct btf_dumper *d, uint32_t type_id,
+			      uint8_t bit_offset, const void *data);
+
+static void btf_dumper_ptr(const void *data, json_writer_t *jw,
+			   bool is_plain_text)
+{
+	if (is_plain_text)
+		jsonw_printf(jw, "%p", *((uintptr_t *)data));
+	else
+		jsonw_printf(jw, "%u", *((uintptr_t *)data));
+}
+
+static int btf_dumper_modifier(const struct btf_dumper *d, uint32_t type_id,
+			       const void *data)
+{
+	int32_t actual_type_id = btf__resolve_type(d->btf, type_id);
+	int ret;
+
+	if (actual_type_id < 0)
+		return actual_type_id;
+
+	ret = btf_dumper_do_type(d, actual_type_id, 0, data);
+
+	return ret;
+}
+
+static void btf_dumper_enum(const void *data, json_writer_t *jw)
+{
+	jsonw_printf(jw, "%d", *((int32_t *)data));
+}
+
+static int btf_dumper_array(const struct btf_dumper *d, uint32_t type_id,
+			    const void *data)
+{
+	const struct btf_type *t = btf__type_by_id(d->btf, type_id);
+	struct btf_array *arr = (struct btf_array *)(t + 1);
+	int64_t elem_size;
+	int ret = 0;
+	uint32_t i;
+
+	elem_size = btf__resolve_size(d->btf, arr->type);
+	if (elem_size < 0)
+		return elem_size;
+
+	jsonw_start_array(d->jw);
+	for (i = 0; i < arr->nelems; i++) {
+		ret = btf_dumper_do_type(d, arr->type, 0,
+					 data + (i * elem_size));
+		if (ret)
+			break;
+	}
+
+	jsonw_end_array(d->jw);
+	return ret;
+}
+
+static void btf_dumper_int_bits(uint32_t int_type, uint8_t bit_offset,
+				const void *data, json_writer_t *jw,
+				bool is_plain_text)
+{
+	uint32_t bits = BTF_INT_BITS(int_type);
+	uint16_t total_bits_offset;
+	uint16_t bytes_to_copy;
+	uint16_t bits_to_copy;
+	uint8_t upper_bits;
+	union {
+		uint64_t u64_num;
+		uint8_t u8_nums[8];
+	} print_num;
+
+	total_bits_offset = bit_offset + BTF_INT_OFFSET(int_type);
+	data += BITS_ROUNDDOWN_BYTES(total_bits_offset);
+	bit_offset = BITS_PER_BYTE_MASKED(total_bits_offset);
+	bits_to_copy = bits + bit_offset;
+	bytes_to_copy = BITS_ROUNDUP_BYTES(bits_to_copy);
+
+	print_num.u64_num = 0;
+	memcpy(&print_num.u64_num, data, bytes_to_copy);
+
+	upper_bits = BITS_PER_BYTE_MASKED(bits_to_copy);
+	if (upper_bits) {
+		uint8_t mask = (1 << upper_bits) - 1;
+
+		print_num.u8_nums[bytes_to_copy - 1] &= mask;
+	}
+
+	print_num.u64_num >>= bit_offset;
+
+	if (is_plain_text)
+		jsonw_printf(jw, "0x%llx", print_num.u64_num);
+	else
+		jsonw_printf(jw, "%llu", print_num.u64_num);
+}
+
+static int btf_dumper_int(const struct btf_type *t, uint8_t bit_offset,
+			  const void *data, json_writer_t *jw,
+			  bool is_plain_text)
+{
+	uint32_t *int_type = (uint32_t *)(t + 1);
+	uint32_t bits = BTF_INT_BITS(*int_type);
+	int ret = 0;
+
+	/* if this is bit field */
+	if (bit_offset || BTF_INT_OFFSET(*int_type) ||
+	    BITS_PER_BYTE_MASKED(bits)) {
+		btf_dumper_int_bits(*int_type, bit_offset, data, jw,
+				    is_plain_text);
+		return ret;
+	}
+
+	switch (BTF_INT_ENCODING(*int_type)) {
+	case 0:
+		if (BTF_INT_BITS(*int_type) == 64)
+			jsonw_printf(jw, "%lu", *((uint64_t *)data));
+		else if (BTF_INT_BITS(*int_type) == 32)
+			jsonw_printf(jw, "%u", *((uint32_t *)data));
+		else if (BTF_INT_BITS(*int_type) == 16)
+			jsonw_printf(jw, "%hu", *((uint16_t *)data));
+		else if (BTF_INT_BITS(*int_type) == 8)
+			jsonw_printf(jw, "%hhu", *((uint8_t *)data));
+		else
+			btf_dumper_int_bits(*int_type, bit_offset, data, jw,
+					    is_plain_text);
+		break;
+	case BTF_INT_SIGNED:
+		if (BTF_INT_BITS(*int_type) == 64)
+			jsonw_printf(jw, "%ld", *((int64_t *)data));
+		else if (BTF_INT_BITS(*int_type) == 32)
+			jsonw_printf(jw, "%d", *((int32_t *)data));
+		else if (BTF_INT_BITS(*int_type) ==  16)
+			jsonw_printf(jw, "%hd", *((int16_t *)data));
+		else if (BTF_INT_BITS(*int_type) ==  8)
+			jsonw_printf(jw, "%hhd", *((int8_t *)data));
+		else
+			btf_dumper_int_bits(*int_type, bit_offset, data, jw,
+					    is_plain_text);
+		break;
+	case BTF_INT_CHAR:
+		if (*((char *)data) == '\0')
+			jsonw_null(jw);
+		else if (isprint(*((char *)data)))
+			jsonw_printf(jw, "\"%c\"", *((char *)data));
+		else
+			if (is_plain_text)
+				jsonw_printf(jw, "%hhx", *((char *)data));
+			else
+				jsonw_printf(jw, "%hhd", *((char *)data));
+		break;
+	case BTF_INT_BOOL:
+		jsonw_bool(jw, *((int *)data));
+		break;
+	default:
+		/* shouldn't happen */
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+
+static int btf_dumper_struct(const struct btf_dumper *d, uint32_t type_id,
+			     const void *data)
+{
+	const struct btf_type *t = btf__type_by_id(d->btf, type_id);
+	struct btf_member *m;
+	int ret = 0;
+	int i, vlen;
+
+	if (!t)
+		return -EINVAL;
+
+	vlen = BTF_INFO_VLEN(t->info);
+	jsonw_start_object(d->jw);
+	m = (struct btf_member *)(t + 1);
+
+	for (i = 0; i < vlen; i++) {
+		jsonw_name(d->jw, btf__name_by_offset(d->btf, m[i].name_off));
+		ret = btf_dumper_do_type(d, m[i].type,
+					 BITS_PER_BYTE_MASKED(m[i].offset), data
+					 + BITS_ROUNDDOWN_BYTES(m[i].offset));
+		if (ret)
+			return ret;
+	}
+
+	jsonw_end_object(d->jw);
+
+	return 0;
+}
+
+static int btf_dumper_do_type(const struct btf_dumper *d, uint32_t type_id,
+			      uint8_t bit_offset, const void *data)
+{
+	const struct btf_type *t = btf__type_by_id(d->btf, type_id);
+	int ret = 0;
+
+	switch (BTF_INFO_KIND(t->info)) {
+	case BTF_KIND_INT:
+		ret = btf_dumper_int(t, bit_offset, data, d->jw,
+				     d->is_plain_text);
+		break;
+	case BTF_KIND_STRUCT:
+	case BTF_KIND_UNION:
+		ret = btf_dumper_struct(d, type_id, data);
+		break;
+	case BTF_KIND_ARRAY:
+		ret = btf_dumper_array(d, type_id, data);
+		break;
+	case BTF_KIND_ENUM:
+		btf_dumper_enum(data, d->jw);
+		break;
+	case BTF_KIND_PTR:
+		btf_dumper_ptr(data, d->jw, d->is_plain_text);
+		break;
+	case BTF_KIND_UNKN:
+		jsonw_printf(d->jw, "(unknown)");
+		break;
+	case BTF_KIND_FWD:
+		/* map key or value can't be forward */
+		ret = -EINVAL;
+		break;
+	case BTF_KIND_TYPEDEF:
+	case BTF_KIND_VOLATILE:
+	case BTF_KIND_CONST:
+	case BTF_KIND_RESTRICT:
+		ret = btf_dumper_modifier(d, type_id, data);
+		break;
+	default:
+		jsonw_printf(d->jw, "(unsupported-kind");
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+
+int32_t btf_dumper_type(const struct btf_dumper *d, uint32_t type_id,
+			const void *data)
+{
+	if (!d)
+		return -EINVAL;
+
+	return btf_dumper_do_type(d, type_id, 0, data);
+}
--- /dev/null
+++ b/tools/bpf/bpftool/btf_dumper.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2018 Facebook */
+
+#ifndef BTF_DUMPER_H
+#define BTF_DUMPER_H
+
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
+int32_t btf_dumper_type(const struct btf_dumper *d, uint32_t type_id,
+			const void *data);
+
+#endif

