Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 550C2C43141
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 20:39:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E79A20846
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 20:39:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="XsWe83nG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E79A20846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933431AbeFTUjo (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 16:39:44 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:41858 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S933275AbeFTUjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 16:39:39 -0400
Received: from pps.filterd (m0001255.ppops.net [127.0.0.1])
        by mx0b-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5KKbajD027443
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 13:39:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date : from
 : to : cc : subject : references : mime-version : content-type;
 s=facebook; bh=jCMnufH2flFWcBL7hXIKstrvWGXRUUCFP0LVd/TwFcA=;
 b=XsWe83nGiS4lVBMkyjBtJfypIMdB20emetWwCPrB2k9Z3sFa4b0863c7RNwkUL1B2V4k
 u4jhmrymODKQwBu4I9fxK81MIRFyGC8DkAKPzvEm2PyJBQ9W8XuN/0GWKs8/no4U4NUw
 kwwU4P8xDtex6iRlee2JdpRp6R6ZdbfNmfs= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0b-00082601.pphosted.com with ESMTP id 2jqt1d0vk8-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 13:39:38 -0700
Received: from mx-out.facebook.com (192.168.52.123) by mail.thefacebook.com
 (192.168.16.22) with Microsoft SMTP Server (TLS) id 14.3.319.2; Wed, 20 Jun
 2018 13:39:37 -0700
Received: by dev026.lla1.facebook.com (Postfix, from userid 152872)     id
 3FC9A8A2453; Wed, 20 Jun 2018 13:37:03 -0700 (PDT)
Message-ID: <20180620203703.208599277@fb.com>
User-Agent: quilt/0.63-1
Date:   Wed, 20 Jun 2018 13:30:54 -0700
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
Subject: [PATCH bpf-next 3/3] bpf: btf: json print map dump with btf info
References: <20180620203051.223156973@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline; filename="03-json-print-btf-info-for-map"
X-FB-Internal: Safe
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-20_09:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch modifies `bpftool map dump [-j|-p] id <map-id>` to json-
print and pretty-json-print map dump. It calls btf_dumper introduced in
previous patch to accomplish this.

The patch only prints debug info when -j or -p flags are supplied. Then
too, if the map has associated btf data loaded. Otherwise the usual
debug-less output is printed.

Signed-off-by: Okash Khawaja <osk@fb.com>
Acked-by: Martin KaFai Lau <kafai@fb.com>

---
 tools/bpf/bpftool/map.c |   94 ++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 91 insertions(+), 3 deletions(-)

--- a/tools/bpf/bpftool/map.c
+++ b/tools/bpf/bpftool/map.c
@@ -43,9 +43,13 @@
 #include <unistd.h>
 #include <sys/types.h>
 #include <sys/stat.h>
+#include <linux/err.h>
 
 #include <bpf.h>
 
+#include "json_writer.h"
+#include "btf.h"
+#include "btf_dumper.h"
 #include "main.h"
 
 static const char * const map_type_name[] = {
@@ -508,6 +512,83 @@ static int do_show(int argc, char **argv
 	return errno == ENOENT ? 0 : -1;
 }
 
+
+static int do_dump_btf(struct btf *btf, struct bpf_map_info *map_info,
+		void *key, void *value)
+{
+	int ret;
+
+	jsonw_start_object(json_wtr);
+	jsonw_name(json_wtr, "key");
+
+	ret = btf_dumper_type(btf, json_wtr, map_info->btf_key_type_id, key);
+	if (ret)
+		goto out;
+
+	jsonw_end_object(json_wtr);
+
+	jsonw_start_object(json_wtr);
+	jsonw_name(json_wtr, "value");
+
+	ret = btf_dumper_type(btf, json_wtr, map_info->btf_value_type_id,
+			value);
+
+out:
+	/* end of root object */
+	jsonw_end_object(json_wtr);
+
+	return ret;
+}
+
+static struct btf *get_btf(struct bpf_map_info *map_info)
+{
+	int btf_fd = bpf_btf_get_fd_by_id(map_info->btf_id);
+	struct bpf_btf_info btf_info = { 0 };
+	__u32 len = sizeof(btf_info);
+	uint32_t last_size;
+	int err;
+	struct btf *btf = NULL;
+	void *ptr = NULL, *temp_ptr;
+
+	if (btf_fd < 0)
+		return NULL;
+
+	btf_info.btf_size = 4096;
+	do {
+		last_size = btf_info.btf_size;
+		temp_ptr = realloc(ptr, last_size);
+		if (!temp_ptr) {
+			p_err("unable allocate memory for debug info.");
+			goto exit_free;
+		}
+
+		ptr = temp_ptr;
+		bzero(ptr, last_size);
+		btf_info.btf = ptr_to_u64(ptr);
+		err = bpf_obj_get_info_by_fd(btf_fd, &btf_info, &len);
+	} while (!err && btf_info.btf_size > last_size && last_size == 4096);
+
+	if (err || btf_info.btf_size > last_size) {
+		p_info("can't get btf info. debug info won't be displayed. error: %s",
+				err ? strerror(errno) : "exceeds size retry");
+		goto exit_free;
+	}
+
+	btf = btf__new((uint8_t *) btf_info.btf,
+			btf_info.btf_size, NULL);
+	if (IS_ERR(btf)) {
+		printf("error when initialising btf: %s\n",
+				strerror(PTR_ERR(btf)));
+		btf = NULL;
+	}
+
+exit_free:
+	close(btf_fd);
+	free(ptr);
+
+	return btf;
+}
+
 static int do_dump(int argc, char **argv)
 {
 	void *key, *value, *prev_key;
@@ -516,6 +597,7 @@ static int do_dump(int argc, char **argv
 	__u32 len = sizeof(info);
 	int err;
 	int fd;
+	struct btf *btf = NULL;
 
 	if (argc != 2)
 		usage();
@@ -538,6 +620,8 @@ static int do_dump(int argc, char **argv
 		goto exit_free;
 	}
 
+	btf = get_btf(&info);
+
 	prev_key = NULL;
 	if (json_output)
 		jsonw_start_array(json_wtr);
@@ -550,9 +634,12 @@ static int do_dump(int argc, char **argv
 		}
 
 		if (!bpf_map_lookup_elem(fd, key, value)) {
-			if (json_output)
-				print_entry_json(&info, key, value);
-			else
+			if (json_output) {
+				if (btf)
+					do_dump_btf(btf, &info, key, value);
+				else
+					print_entry_json(&info, key, value);
+			} else
 				print_entry_plain(&info, key, value);
 		} else {
 			if (json_output) {
@@ -584,6 +671,7 @@ exit_free:
 	free(key);
 	free(value);
 	close(fd);
+	btf__free(btf);
 
 	return err;
 }

