Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67F6BECDFB3
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 04:57:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F143208D4
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 04:57:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="EGJAiCAl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F143208D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbeGNFPD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 01:15:03 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:42694 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725851AbeGNFPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 01:15:02 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6E4qiud023281
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 21:57:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=CXnTOraIabDKL+Zy8Zj4bQVbeSa8xYxd+OawgjtG+Mw=;
 b=EGJAiCAlLdDpwo6tooYmckyeBsTpAQREgPotQR+OHAye1JJgnocqfpL2bqoD9A4NnoGM
 2MmygCnXkjL/n2Ko9aZLqNt2kKrJNlVaNPM2vT1ktjOFDHEuHNjataSDGhus+nih5/zu
 S7LYod3b968LJwo3CU2n+T/BxrovuRFUpkU= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2k7a3ag16h-5
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 21:57:23 -0700
Received: from mx-out.facebook.com (192.168.52.123) by mail.thefacebook.com
 (192.168.16.16) with Microsoft SMTP Server (TLS) id 14.3.361.1; Fri, 13 Jul
 2018 21:57:22 -0700
Received: by dev026.lla1.facebook.com (Postfix, from userid 152872)     id
 34D9A8A443B; Fri, 13 Jul 2018 21:57:14 -0700 (PDT)
Smtp-Origin-Hostprefix: dev
From:   Okash Khawaja <osk@fb.com>
Smtp-Origin-Hostname: dev026.lla1.facebook.com
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        "David S . Miller" <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <kernel-team@fb.com>,
        <linux-kernel@vger.kernel.org>
Smtp-Origin-Cluster: lla1c22
Subject: [PATCH bpf-next v5 1/3] bpf: btf: export btf types and name by offset from lib
Date:   Fri, 13 Jul 2018 21:57:02 -0700
Message-ID: <20180714045704.3779427-2-osk@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180714045704.3779427-1-osk@fb.com>
References: <20180714045704.3779427-1-osk@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-14_02:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces btf__resolve_type() function and exports two
existing functions from libbpf. btf__resolve_type follows modifier
types like const and typedef until it hits a type which actually takes
up memory, and then returns it. This function follows similar pattern
to btf__resolve_size but instead of computing size, it just returns
the type.

These  functions will be used in the followig patch which parses
information inside array of `struct btf_type *`. btf_name_by_offset is
used for printing variable names.

Signed-off-by: Okash Khawaja <osk@fb.com>
Acked-by: Martin KaFai Lau <kafai@fb.com>
Acked-by: Song Liu <songliubraving@fb.com>
Reviewed-by: Jakub Kicinski <jakub.kicinski@netronome.com>

---
 tools/lib/bpf/btf.c |   65 ++++++++++++++++++++++++++++++++++++----------------
 tools/lib/bpf/btf.h |    3 ++
 2 files changed, 48 insertions(+), 20 deletions(-)

--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -17,6 +17,11 @@
 
 #define BTF_MAX_NR_TYPES 65535
 
+#define IS_MODIFIER(k) (((k) == BTF_KIND_TYPEDEF) || \
+		((k) == BTF_KIND_VOLATILE) || \
+		((k) == BTF_KIND_CONST) || \
+		((k) == BTF_KIND_RESTRICT))
+
 static struct btf_type btf_void;
 
 struct btf {
@@ -33,14 +38,6 @@ struct btf {
 	int fd;
 };
 
-static const char *btf_name_by_offset(const struct btf *btf, uint32_t offset)
-{
-	if (offset < btf->hdr->str_len)
-		return &btf->strings[offset];
-	else
-		return NULL;
-}
-
 static int btf_add_type(struct btf *btf, struct btf_type *t)
 {
 	if (btf->types_size - btf->nr_types < 2) {
@@ -190,15 +187,6 @@ static int btf_parse_type_sec(struct btf
 	return 0;
 }
 
-static const struct btf_type *btf_type_by_id(const struct btf *btf,
-					     uint32_t type_id)
-{
-	if (type_id > btf->nr_types)
-		return NULL;
-
-	return btf->types[type_id];
-}
-
 static bool btf_type_is_void(const struct btf_type *t)
 {
 	return t == &btf_void || BTF_INFO_KIND(t->info) == BTF_KIND_FWD;
@@ -234,7 +222,7 @@ int64_t btf__resolve_size(const struct b
 	int64_t size = -1;
 	int i;
 
-	t = btf_type_by_id(btf, type_id);
+	t = btf__type_by_id(btf, type_id);
 	for (i = 0; i < MAX_RESOLVE_DEPTH && !btf_type_is_void_or_null(t);
 	     i++) {
 		size = btf_type_size(t);
@@ -259,7 +247,7 @@ int64_t btf__resolve_size(const struct b
 			return -EINVAL;
 		}
 
-		t = btf_type_by_id(btf, type_id);
+		t = btf__type_by_id(btf, type_id);
 	}
 
 	if (size < 0)
@@ -271,6 +259,26 @@ int64_t btf__resolve_size(const struct b
 	return nelems * size;
 }
 
+int btf__resolve_type(const struct btf *btf, __u32 type_id)
+{
+	const struct btf_type *t;
+	int depth = 0;
+
+	t = btf__type_by_id(btf, type_id);
+	while (depth < MAX_RESOLVE_DEPTH &&
+	       !btf_type_is_void_or_null(t) &&
+	       IS_MODIFIER(BTF_INFO_KIND(t->info))) {
+		type_id = t->type;
+		t = btf__type_by_id(btf, type_id);
+		depth++;
+	}
+
+	if (depth == MAX_RESOLVE_DEPTH || btf_type_is_void_or_null(t))
+		return -EINVAL;
+
+	return type_id;
+}
+
 int32_t btf__find_by_name(const struct btf *btf, const char *type_name)
 {
 	uint32_t i;
@@ -280,7 +288,7 @@ int32_t btf__find_by_name(const struct b
 
 	for (i = 1; i <= btf->nr_types; i++) {
 		const struct btf_type *t = btf->types[i];
-		const char *name = btf_name_by_offset(btf, t->name_off);
+		const char *name = btf__name_by_offset(btf, t->name_off);
 
 		if (name && !strcmp(type_name, name))
 			return i;
@@ -371,3 +379,20 @@ int btf__fd(const struct btf *btf)
 {
 	return btf->fd;
 }
+
+const char *btf__name_by_offset(const struct btf *btf, __u32 offset)
+{
+	if (offset < btf->hdr->str_len)
+		return &btf->strings[offset];
+	else
+		return NULL;
+}
+
+const struct btf_type *btf__type_by_id(const struct btf *btf,
+				       __u32 type_id)
+{
+	if (type_id > btf->nr_types)
+		return NULL;
+
+	return btf->types[type_id];
+}
--- a/tools/lib/bpf/btf.h
+++ b/tools/lib/bpf/btf.h
@@ -17,6 +17,9 @@ void btf__free(struct btf *btf);
 struct btf *btf__new(uint8_t *data, uint32_t size, btf_print_fn_t err_log);
 int32_t btf__find_by_name(const struct btf *btf, const char *type_name);
 int64_t btf__resolve_size(const struct btf *btf, uint32_t type_id);
+int btf__resolve_type(const struct btf *btf, __u32 type_id);
 int btf__fd(const struct btf *btf);
+const char *btf__name_by_offset(const struct btf *btf, __u32 offset);
+const struct btf_type *btf__type_by_id(const struct btf *btf, __u32 type_id);
 
 #endif
