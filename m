Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99ED8C43141
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 20:39:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5034F20846
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 20:39:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="QA/wT90g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5034F20846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933388AbeFTUjk (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 16:39:40 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:45674 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933097AbeFTUji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 16:39:38 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5KKZAeE030393
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 13:39:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date : from
 : to : cc : subject : references : mime-version : content-type;
 s=facebook; bh=lq/oIsJbPANub3qdvy/PR+2pAQeT+lhywcguFCiUDKs=;
 b=QA/wT90g6FimbJumWX/jn4t/WIusyQ1WeU8gFKB+aIoy4ICw6QA1HyL/X+FdG5+W5aYP
 vLuDo0mnIItbyNjqYi5bc84XI14dISMVj9WJ0wF5HEoTSl3iFN0lg5m6WFEYIhicPCtt
 95TxeowijByfLMTJNL7wEydQCaWWDMZu87k= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2jqvy2r6nd-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 13:39:38 -0700
Received: from mx-out.facebook.com (192.168.52.123) by mail.thefacebook.com
 (192.168.16.21) with Microsoft SMTP Server (TLS) id 14.3.319.2; Wed, 20 Jun
 2018 13:39:37 -0700
Received: by dev026.lla1.facebook.com (Postfix, from userid 152872)     id
 09EDC8A0910; Wed, 20 Jun 2018 13:37:03 -0700 (PDT)
Message-ID: <20180620203702.996737905@fb.com>
User-Agent: quilt/0.63-1
Date:   Wed, 20 Jun 2018 13:30:52 -0700
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
Subject: [PATCH bpf-next 1/3] bpf: btf: export btf types and name by offset from lib
References: <20180620203051.223156973@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline; filename="01-export-from-libbtf.patch"
X-FB-Internal: Safe
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-20_09:,,
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
 
+int32_t btf__resolve_type(const struct btf *btf, uint32_t type_id)
+{
+	const struct btf_type *t;
+	int depth = 0;
+
+	t = btf__type_by_id(btf, type_id);
+	while (depth < MAX_RESOLVE_DEPTH &&
+			!btf_type_is_void_or_null(t) &&
+			IS_MODIFIER(BTF_INFO_KIND(t->info))) {
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
+const char *btf__name_by_offset(const struct btf *btf, uint32_t offset)
+{
+	if (offset < btf->hdr->str_len)
+		return &btf->strings[offset];
+	else
+		return NULL;
+}
+
+const struct btf_type *btf__type_by_id(const struct btf *btf,
+					     uint32_t type_id)
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
+int32_t btf__resolve_type(const struct btf *btf, uint32_t type_id);
 int btf__fd(const struct btf *btf);
+const char *btf__name_by_offset(const struct btf *btf, uint32_t offset);
+const struct btf_type *btf__type_by_id(const struct btf *btf, uint32_t type_id);
 
 #endif

