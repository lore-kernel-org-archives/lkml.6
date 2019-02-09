Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69E74C169C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 01:17:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24AB12177B
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 01:17:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="KDdZcpcL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbfBIBRZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 20:17:25 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:57212 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726524AbfBIBRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 20:17:21 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x191AcI1007146
        for <linux-kernel@vger.kernel.org>; Fri, 8 Feb 2019 17:17:20 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=ssCPaO8uIVt/v+Qv/3wrgPTpPrKwDI95IQdsxO18BHc=;
 b=KDdZcpcLtmoVsVCBo0g4DmTKH2iGHhCPRXBBEV7lTmqsjO/B/cKemdEc18X4y1OoWvPh
 cnOIPciCtmoow+1r76OgBGoMzpFSnV6gHh5Ktb3UJDOBgpDmEbU6QhJ1QV/IsRwEoaZG
 V41OoKSyjdAerENuc8cy3OXOnJNq7PZBjV4= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2qhk218b9r-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 17:17:20 -0800
Received: from mx-out.facebook.com (2620:10d:c0a1:3::13) by
 mail.thefacebook.com (2620:10d:c021:18::175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1531.3;
 Fri, 8 Feb 2019 17:17:09 -0800
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id C48B562E2A0D; Fri,  8 Feb 2019 17:17:08 -0800 (PST)
Smtp-Origin-Hostprefix: devbig
From:   Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <kernel-team@fb.com>,
        <peterz@infradead.org>, <acme@redhat.com>,
        Song Liu <songliubraving@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH 3/9] bpf: bpftool: use bpf_program__get_prog_info_linear() in prog.c:do_dump()
Date:   Fri, 8 Feb 2019 17:16:59 -0800
Message-ID: <20190209011705.2160185-4-songliubraving@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190209011705.2160185-1-songliubraving@fb.com>
References: <20190209011705.2160185-1-songliubraving@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-09_01:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patches uses bpf_program__get_prog_info_linear() to simplify the
logic in prog.c do_dump().

Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Song Liu <songliubraving@fb.com>
---
 tools/bpf/bpftool/prog.c | 266 +++++++++------------------------------
 1 file changed, 59 insertions(+), 207 deletions(-)

diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index 0640e9bc0ada..206b820df7c2 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -393,41 +393,31 @@ static int do_show(int argc, char **argv)
 
 static int do_dump(int argc, char **argv)
 {
-	unsigned int finfo_rec_size, linfo_rec_size, jited_linfo_rec_size;
-	void *func_info = NULL, *linfo = NULL, *jited_linfo = NULL;
-	unsigned int nr_finfo, nr_linfo = 0, nr_jited_linfo = 0;
+	struct bpf_prog_info_linear *info_linear;
 	struct bpf_prog_linfo *prog_linfo = NULL;
-	unsigned long *func_ksyms = NULL;
-	struct bpf_prog_info info = {};
-	unsigned int *func_lens = NULL;
+	enum {DUMP_JITED, DUMP_XLATED} mode;
 	const char *disasm_opt = NULL;
-	unsigned int nr_func_ksyms;
-	unsigned int nr_func_lens;
+	struct bpf_prog_info *info;
 	struct dump_data dd = {};
-	__u32 len = sizeof(info);
+	void *func_info = NULL;
 	struct btf *btf = NULL;
-	unsigned int buf_size;
 	char *filepath = NULL;
 	bool opcodes = false;
 	bool visual = false;
 	char func_sig[1024];
 	unsigned char *buf;
 	bool linum = false;
-	__u32 *member_len;
-	__u64 *member_ptr;
+	__u32 member_len;
+	__u64 arrays;
 	ssize_t n;
-	int err;
 	int fd;
 
 	if (is_prefix(*argv, "jited")) {
 		if (disasm_init())
 			return -1;
-
-		member_len = &info.jited_prog_len;
-		member_ptr = &info.jited_prog_insns;
+		mode = DUMP_JITED;
 	} else if (is_prefix(*argv, "xlated")) {
-		member_len = &info.xlated_prog_len;
-		member_ptr = &info.xlated_prog_insns;
+		mode = DUMP_XLATED;
 	} else {
 		p_err("expected 'xlated' or 'jited', got: %s", *argv);
 		return -1;
@@ -466,175 +456,50 @@ static int do_dump(int argc, char **argv)
 		return -1;
 	}
 
-	err = bpf_obj_get_info_by_fd(fd, &info, &len);
-	if (err) {
-		p_err("can't get prog info: %s", strerror(errno));
-		return -1;
-	}
-
-	if (!*member_len) {
-		p_info("no instructions returned");
-		close(fd);
-		return 0;
-	}
+	if (mode == DUMP_JITED)
+		arrays = 1UL << BPF_PROG_INFO_JITED_INSNS;
+	else
+		arrays = 1UL << BPF_PROG_INFO_XLATED_INSNS;
 
-	buf_size = *member_len;
+	arrays |= 1UL << BPF_PROG_INFO_JITED_KSYMS;
+	arrays |= 1UL << BPF_PROG_INFO_JITED_FUNC_LENS;
+	arrays |= 1UL << BPF_PROG_INFO_FUNC_INFO;
+	arrays |= 1UL << BPF_PROG_INFO_LINE_INFO;
+	arrays |= 1UL << BPF_PROG_INFO_JITED_LINE_INFO;
 
-	buf = malloc(buf_size);
-	if (!buf) {
-		p_err("mem alloc failed");
-		close(fd);
+	info_linear = bpf_program__get_prog_info_linear(fd, arrays);
+	close(fd);
+	if (IS_ERR_OR_NULL(info_linear)) {
+		p_err("can't get prog info: %s", strerror(errno));
 		return -1;
 	}
 
-	nr_func_ksyms = info.nr_jited_ksyms;
-	if (nr_func_ksyms) {
-		func_ksyms = malloc(nr_func_ksyms * sizeof(__u64));
-		if (!func_ksyms) {
-			p_err("mem alloc failed");
-			close(fd);
-			goto err_free;
-		}
-	}
-
-	nr_func_lens = info.nr_jited_func_lens;
-	if (nr_func_lens) {
-		func_lens = malloc(nr_func_lens * sizeof(__u32));
-		if (!func_lens) {
-			p_err("mem alloc failed");
-			close(fd);
+	info = &info_linear->info;
+	if (mode == DUMP_JITED) {
+		if (info->jited_prog_len == 0) {
+			p_info("no instructions returned");
 			goto err_free;
 		}
-	}
-
-	nr_finfo = info.nr_func_info;
-	finfo_rec_size = info.func_info_rec_size;
-	if (nr_finfo && finfo_rec_size) {
-		func_info = malloc(nr_finfo * finfo_rec_size);
-		if (!func_info) {
-			p_err("mem alloc failed");
-			close(fd);
+		buf = (unsigned char *)(info->jited_prog_insns);
+		member_len = info->jited_prog_len;
+	} else {	/* DUMP_XLATED */
+		if (info->xlated_prog_len == 0) {
+			p_err("error retrieving insn dump: kernel.kptr_restrict set?");
 			goto err_free;
 		}
+		buf = (unsigned char *)info->xlated_prog_insns;
+		member_len = info->xlated_prog_len;
 	}
 
-	linfo_rec_size = info.line_info_rec_size;
-	if (info.nr_line_info && linfo_rec_size && info.btf_id) {
-		nr_linfo = info.nr_line_info;
-		linfo = malloc(nr_linfo * linfo_rec_size);
-		if (!linfo) {
-			p_err("mem alloc failed");
-			close(fd);
-			goto err_free;
-		}
-	}
-
-	jited_linfo_rec_size = info.jited_line_info_rec_size;
-	if (info.nr_jited_line_info &&
-	    jited_linfo_rec_size &&
-	    info.nr_jited_ksyms &&
-	    info.nr_jited_func_lens &&
-	    info.btf_id) {
-		nr_jited_linfo = info.nr_jited_line_info;
-		jited_linfo = malloc(nr_jited_linfo * jited_linfo_rec_size);
-		if (!jited_linfo) {
-			p_err("mem alloc failed");
-			close(fd);
-			goto err_free;
-		}
-	}
-
-	memset(&info, 0, sizeof(info));
-
-	*member_ptr = ptr_to_u64(buf);
-	*member_len = buf_size;
-	info.jited_ksyms = ptr_to_u64(func_ksyms);
-	info.nr_jited_ksyms = nr_func_ksyms;
-	info.jited_func_lens = ptr_to_u64(func_lens);
-	info.nr_jited_func_lens = nr_func_lens;
-	info.nr_func_info = nr_finfo;
-	info.func_info_rec_size = finfo_rec_size;
-	info.func_info = ptr_to_u64(func_info);
-	info.nr_line_info = nr_linfo;
-	info.line_info_rec_size = linfo_rec_size;
-	info.line_info = ptr_to_u64(linfo);
-	info.nr_jited_line_info = nr_jited_linfo;
-	info.jited_line_info_rec_size = jited_linfo_rec_size;
-	info.jited_line_info = ptr_to_u64(jited_linfo);
-
-	err = bpf_obj_get_info_by_fd(fd, &info, &len);
-	close(fd);
-	if (err) {
-		p_err("can't get prog info: %s", strerror(errno));
-		goto err_free;
-	}
-
-	if (*member_len > buf_size) {
-		p_err("too many instructions returned");
-		goto err_free;
-	}
-
-	if (info.nr_jited_ksyms > nr_func_ksyms) {
-		p_err("too many addresses returned");
-		goto err_free;
-	}
-
-	if (info.nr_jited_func_lens > nr_func_lens) {
-		p_err("too many values returned");
-		goto err_free;
-	}
-
-	if (info.nr_func_info != nr_finfo) {
-		p_err("incorrect nr_func_info %d vs. expected %d",
-		      info.nr_func_info, nr_finfo);
-		goto err_free;
-	}
-
-	if (info.func_info_rec_size != finfo_rec_size) {
-		p_err("incorrect func_info_rec_size %d vs. expected %d",
-		      info.func_info_rec_size, finfo_rec_size);
-		goto err_free;
-	}
-
-	if (linfo && info.nr_line_info != nr_linfo) {
-		p_err("incorrect nr_line_info %u vs. expected %u",
-		      info.nr_line_info, nr_linfo);
-		goto err_free;
-	}
-
-	if (info.line_info_rec_size != linfo_rec_size) {
-		p_err("incorrect line_info_rec_size %u vs. expected %u",
-		      info.line_info_rec_size, linfo_rec_size);
-		goto err_free;
-	}
-
-	if (jited_linfo && info.nr_jited_line_info != nr_jited_linfo) {
-		p_err("incorrect nr_jited_line_info %u vs. expected %u",
-		      info.nr_jited_line_info, nr_jited_linfo);
-		goto err_free;
-	}
-
-	if (info.jited_line_info_rec_size != jited_linfo_rec_size) {
-		p_err("incorrect jited_line_info_rec_size %u vs. expected %u",
-		      info.jited_line_info_rec_size, jited_linfo_rec_size);
-		goto err_free;
-	}
-
-	if ((member_len == &info.jited_prog_len &&
-	     info.jited_prog_insns == 0) ||
-	    (member_len == &info.xlated_prog_len &&
-	     info.xlated_prog_insns == 0)) {
-		p_err("error retrieving insn dump: kernel.kptr_restrict set?");
-		goto err_free;
-	}
-
-	if (info.btf_id && btf__get_from_id(info.btf_id, &btf)) {
+	if (info->btf_id && btf__get_from_id(info->btf_id, &btf)) {
 		p_err("failed to get btf");
 		goto err_free;
 	}
 
-	if (nr_linfo) {
-		prog_linfo = bpf_prog_linfo__new(&info);
+	func_info = (void *)info->func_info;
+
+	if (info->nr_line_info) {
+		prog_linfo = bpf_prog_linfo__new(info);
 		if (!prog_linfo)
 			p_info("error in processing bpf_line_info.  continue without it.");
 	}
@@ -647,9 +512,9 @@ static int do_dump(int argc, char **argv)
 			goto err_free;
 		}
 
-		n = write(fd, buf, *member_len);
+		n = write(fd, buf, member_len);
 		close(fd);
-		if (n != *member_len) {
+		if (n != member_len) {
 			p_err("error writing output file: %s",
 			      n < 0 ? strerror(errno) : "short write");
 			goto err_free;
@@ -657,19 +522,19 @@ static int do_dump(int argc, char **argv)
 
 		if (json_output)
 			jsonw_null(json_wtr);
-	} else if (member_len == &info.jited_prog_len) {
+	} else if (mode == DUMP_JITED) {
 		const char *name = NULL;
 
-		if (info.ifindex) {
-			name = ifindex_to_bfd_params(info.ifindex,
-						     info.netns_dev,
-						     info.netns_ino,
+		if (info->ifindex) {
+			name = ifindex_to_bfd_params(info->ifindex,
+						     info->netns_dev,
+						     info->netns_ino,
 						     &disasm_opt);
 			if (!name)
 				goto err_free;
 		}
 
-		if (info.nr_jited_func_lens && info.jited_func_lens) {
+		if (info->nr_jited_func_lens && info->jited_func_lens) {
 			struct kernel_sym *sym = NULL;
 			struct bpf_func_info *record;
 			char sym_name[SYM_MAX_NAME];
@@ -677,17 +542,16 @@ static int do_dump(int argc, char **argv)
 			__u64 *ksyms = NULL;
 			__u32 *lens;
 			__u32 i;
-
-			if (info.nr_jited_ksyms) {
+			if (info->nr_jited_ksyms) {
 				kernel_syms_load(&dd);
-				ksyms = (__u64 *) info.jited_ksyms;
+				ksyms = (__u64 *) info->jited_ksyms;
 			}
 
 			if (json_output)
 				jsonw_start_array(json_wtr);
 
-			lens = (__u32 *) info.jited_func_lens;
-			for (i = 0; i < info.nr_jited_func_lens; i++) {
+			lens = (__u32 *) info->jited_func_lens;
+			for (i = 0; i < info->nr_jited_func_lens; i++) {
 				if (ksyms) {
 					sym = kernel_syms_search(&dd, ksyms[i]);
 					if (sym)
@@ -699,7 +563,7 @@ static int do_dump(int argc, char **argv)
 				}
 
 				if (func_info) {
-					record = func_info + i * finfo_rec_size;
+					record = func_info + i * info->func_info_rec_size;
 					btf_dumper_type_only(btf, record->type_id,
 							     func_sig,
 							     sizeof(func_sig));
@@ -736,49 +600,37 @@ static int do_dump(int argc, char **argv)
 			if (json_output)
 				jsonw_end_array(json_wtr);
 		} else {
-			disasm_print_insn(buf, *member_len, opcodes, name,
+			disasm_print_insn(buf, member_len, opcodes, name,
 					  disasm_opt, btf, NULL, 0, 0, false);
 		}
 	} else if (visual) {
 		if (json_output)
 			jsonw_null(json_wtr);
 		else
-			dump_xlated_cfg(buf, *member_len);
+			dump_xlated_cfg(buf, member_len);
 	} else {
 		kernel_syms_load(&dd);
-		dd.nr_jited_ksyms = info.nr_jited_ksyms;
-		dd.jited_ksyms = (__u64 *) info.jited_ksyms;
+		dd.nr_jited_ksyms = info->nr_jited_ksyms;
+		dd.jited_ksyms = (__u64 *) info->jited_ksyms;
 		dd.btf = btf;
 		dd.func_info = func_info;
-		dd.finfo_rec_size = finfo_rec_size;
+		dd.finfo_rec_size = info->func_info_rec_size;
 		dd.prog_linfo = prog_linfo;
 
 		if (json_output)
-			dump_xlated_json(&dd, buf, *member_len, opcodes,
+			dump_xlated_json(&dd, buf, member_len, opcodes,
 					 linum);
 		else
-			dump_xlated_plain(&dd, buf, *member_len, opcodes,
+			dump_xlated_plain(&dd, buf, member_len, opcodes,
 					  linum);
 		kernel_syms_destroy(&dd);
 	}
 
-	free(buf);
-	free(func_ksyms);
-	free(func_lens);
-	free(func_info);
-	free(linfo);
-	free(jited_linfo);
-	bpf_prog_linfo__free(prog_linfo);
+	free(info_linear);
 	return 0;
 
 err_free:
-	free(buf);
-	free(func_ksyms);
-	free(func_lens);
-	free(func_info);
-	free(linfo);
-	free(jited_linfo);
-	bpf_prog_linfo__free(prog_linfo);
+	free(info_linear);
 	return -1;
 }
 
-- 
2.17.1

