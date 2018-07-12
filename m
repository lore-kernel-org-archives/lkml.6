Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01E51C468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 03:18:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4CA921471
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 03:18:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Ag5njaf+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4CA921471
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbeGLDZc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 23:25:32 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:42828 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726410AbeGLDZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 23:25:31 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6C3F9At011919
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 20:18:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date : from
 : to : cc : subject : references : mime-version : content-type;
 s=facebook; bh=+vyVn1B1LHAJhtZUdW5s44PMoA1HXDKjX2pCgTORUgU=;
 b=Ag5njaf+yOX9emSC1IAtFA2aEQzIM8olrN+UxATV5I5nSxjLqFHPQuyVWnWlI+YoYy1k
 Rw1YOdK90LZbVZo+i5yhEMWBQt8IGSgdfmL7Mirl3AP9gYb8BnD0sQpidZqwi759alEn
 mcnI3O94gSeqze3Fx67ts7iRniVY0wvFv3s= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2k5te58jcx-2
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 20:18:00 -0700
Received: from mx-out.facebook.com (192.168.52.123) by mail.thefacebook.com
 (192.168.16.24) with Microsoft SMTP Server (TLS) id 14.3.361.1; Wed, 11 Jul
 2018 20:17:58 -0700
Received: by dev026.lla1.facebook.com (Postfix, from userid 152872)     id
 DF3408A45E9; Wed, 11 Jul 2018 20:15:03 -0700 (PDT)
Message-ID: <20180712031503.775316871@fb.com>
User-Agent: quilt/0.63-1
Date:   Wed, 11 Jul 2018 20:08:06 -0700
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
Subject: [PATCH bpf-next v5 3/3] bpf: btf: print map dump and lookup with btf info
References: <20180712030803.875913594@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline; filename="03-json-print-btf-info-for-map"
X-FB-Internal: Safe
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-12_02:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch augments the output of bpftool's map dump and map lookup
commands to print data along side btf info, if the correspondin btf
info is available. The outputs for each of  map dump and map lookup
commands are augmented in two ways:

1. when neither of -j and -p are supplied, btf-ful map data is printed
whose aim is human readability. This means no commitments for json- or
backward- compatibility.

2. when either -j or -p are supplied, a new json object named
"formatted" is added for each key-value pair. This object contains the
same data as the key-value pair, but with btf info. "formatted" object
promises json- and backward- compatibility. Below is a sample output.

$ bpftool map dump -p id 8
[{
        "key": ["0x0f","0x00","0x00","0x00"
        ],
        "value": ["0x03", "0x00", "0x00", "0x00", ...
        ],
        "formatted": {
                "key": 15,
                "value": {
                        "int_field":  3,
                        ...
                }
        }
}
]

This patch calls btf_dumper introduced in previous patch to accomplish
the above. Indeed, btf-ful info is only displayed if btf data for the
given map is available. Otherwise existing output is displayed as-is.

Signed-off-by: Okash Khawaja <osk@fb.com>

---
 tools/bpf/bpftool/map.c |  217 ++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 201 insertions(+), 16 deletions(-)

--- a/tools/bpf/bpftool/map.c
+++ b/tools/bpf/bpftool/map.c
@@ -34,6 +34,7 @@
 #include <assert.h>
 #include <errno.h>
 #include <fcntl.h>
+#include <linux/err.h>
 #include <stdbool.h>
 #include <stdio.h>
 #include <stdlib.h>
@@ -44,6 +45,8 @@
 
 #include <bpf.h>
 
+#include "btf.h"
+#include "json_writer.h"
 #include "main.h"
 
 static const char * const map_type_name[] = {
@@ -148,8 +151,109 @@ int map_parse_fd_and_info(int *argc, cha
 	return fd;
 }
 
+static int do_dump_btf(const struct btf_dumper *d,
+		       struct bpf_map_info *map_info, void *key,
+		       void *value)
+{
+	int ret;
+
+	/* start of key-value pair */
+	jsonw_start_object(d->jw);
+
+	jsonw_name(d->jw, "key");
+
+	ret = btf_dumper_type(d, map_info->btf_key_type_id, key);
+	if (ret)
+		goto err_end_obj;
+
+	jsonw_name(d->jw, "value");
+
+	ret = btf_dumper_type(d, map_info->btf_value_type_id, value);
+
+err_end_obj:
+	/* end of key-value pair */
+	jsonw_end_object(d->jw);
+
+	return ret;
+}
+
+static int get_btf(struct bpf_map_info *map_info, struct btf **btf)
+{
+	struct bpf_btf_info btf_info = { 0 };
+	__u32 len = sizeof(btf_info);
+	__u32 last_size;
+	int btf_fd;
+	void *ptr;
+	int err;
+
+	err = 0;
+	*btf = NULL;
+	btf_fd = bpf_btf_get_fd_by_id(map_info->btf_id);
+	if (btf_fd < 0)
+		return 0;
+
+	/* we won't know btf_size until we call bpf_obj_get_info_by_fd(). so
+	 * let's start with a sane default - 4KiB here - and resize it only if
+	 * bpf_obj_get_info_by_fd() needs a bigger buffer.
+	 */
+	btf_info.btf_size = 4096;
+	last_size = btf_info.btf_size;
+	ptr = malloc(last_size);
+	if (!ptr) {
+		err = -ENOMEM;
+		goto exit_free;
+	}
+
+	bzero(ptr, last_size);
+	btf_info.btf = ptr_to_u64(ptr);
+	err = bpf_obj_get_info_by_fd(btf_fd, &btf_info, &len);
+
+	if (!err && btf_info.btf_size > last_size) {
+		void *temp_ptr;
+
+		last_size = btf_info.btf_size;
+		temp_ptr = realloc(ptr, last_size);
+		if (!temp_ptr) {
+			err = -ENOMEM;
+			goto exit_free;
+		}
+		ptr = temp_ptr;
+		bzero(ptr, last_size);
+		btf_info.btf = ptr_to_u64(ptr);
+		err = bpf_obj_get_info_by_fd(btf_fd, &btf_info, &len);
+	}
+
+	if (err || btf_info.btf_size > last_size) {
+		err = errno;
+		goto exit_free;
+	}
+
+	*btf = btf__new((__u8 *)btf_info.btf, btf_info.btf_size, NULL);
+	if (IS_ERR(*btf)) {
+		err = PTR_ERR(btf);
+		*btf = NULL;
+	}
+
+exit_free:
+	close(btf_fd);
+	free(ptr);
+
+	return err;
+}
+
+static json_writer_t *get_btf_writer(void)
+{
+	json_writer_t *jw = jsonw_new(stdout);
+
+	if (!jw)
+		return NULL;
+	jsonw_pretty(jw, true);
+
+	return jw;
+}
+
 static void print_entry_json(struct bpf_map_info *info, unsigned char *key,
-			     unsigned char *value)
+			     unsigned char *value, struct btf *btf)
 {
 	jsonw_start_object(json_wtr);
 
@@ -158,6 +262,16 @@ static void print_entry_json(struct bpf_
 		print_hex_data_json(key, info->key_size);
 		jsonw_name(json_wtr, "value");
 		print_hex_data_json(value, info->value_size);
+		if (btf) {
+			struct btf_dumper d = {
+				.btf = btf,
+				.jw = json_wtr,
+				.is_plain_text = false,
+			};
+
+			jsonw_name(json_wtr, "formatted");
+			do_dump_btf(&d, info, key, value);
+		}
 	} else {
 		unsigned int i, n;
 
@@ -508,10 +622,12 @@ static int do_show(int argc, char **argv
 
 static int do_dump(int argc, char **argv)
 {
+	struct bpf_map_info info = {};
 	void *key, *value, *prev_key;
 	unsigned int num_elems = 0;
-	struct bpf_map_info info = {};
 	__u32 len = sizeof(info);
+	json_writer_t *btf_wtr;
+	struct btf *btf = NULL;
 	int err;
 	int fd;
 
@@ -537,8 +653,27 @@ static int do_dump(int argc, char **argv
 	}
 
 	prev_key = NULL;
+
+	err = get_btf(&info, &btf);
+	if (err) {
+		p_err("failed to get btf");
+		goto exit_free;
+	}
+
 	if (json_output)
 		jsonw_start_array(json_wtr);
+	else
+		if (btf) {
+			btf_wtr = get_btf_writer();
+			if (!btf_wtr) {
+				p_info("failed to create json writer for btf. falling back to plain output");
+				btf__free(btf);
+				btf = NULL;
+			} else {
+				jsonw_start_array(btf_wtr);
+			}
+		}
+
 	while (true) {
 		err = bpf_map_get_next_key(fd, prev_key, key);
 		if (err) {
@@ -549,9 +684,19 @@ static int do_dump(int argc, char **argv
 
 		if (!bpf_map_lookup_elem(fd, key, value)) {
 			if (json_output)
-				print_entry_json(&info, key, value);
+				print_entry_json(&info, key, value, btf);
 			else
-				print_entry_plain(&info, key, value);
+				if (btf) {
+					struct btf_dumper d = {
+						.btf = btf,
+						.jw = btf_wtr,
+						.is_plain_text = true,
+					};
+
+					do_dump_btf(&d, &info, key, value);
+				} else {
+					print_entry_plain(&info, key, value);
+				}
 		} else {
 			if (json_output) {
 				jsonw_name(json_wtr, "key");
@@ -574,14 +719,19 @@ static int do_dump(int argc, char **argv
 
 	if (json_output)
 		jsonw_end_array(json_wtr);
-	else
+	else if (btf) {
+		jsonw_end_array(btf_wtr);
+		jsonw_destroy(&btf_wtr);
+	} else {
 		printf("Found %u element%s\n", num_elems,
 		       num_elems != 1 ? "s" : "");
+	}
 
 exit_free:
 	free(key);
 	free(value);
 	close(fd);
+	btf__free(btf);
 
 	return err;
 }
@@ -637,6 +787,8 @@ static int do_lookup(int argc, char **ar
 {
 	struct bpf_map_info info = {};
 	__u32 len = sizeof(info);
+	json_writer_t *btf_wtr;
+	struct btf *btf = NULL;
 	void *key, *value;
 	int err;
 	int fd;
@@ -661,27 +813,60 @@ static int do_lookup(int argc, char **ar
 		goto exit_free;
 
 	err = bpf_map_lookup_elem(fd, key, value);
-	if (!err) {
-		if (json_output)
-			print_entry_json(&info, key, value);
-		else
+	if (err) {
+		if (errno == ENOENT) {
+			if (json_output) {
+				jsonw_null(json_wtr);
+			} else {
+				printf("key:\n");
+				fprint_hex(stdout, key, info.key_size, " ");
+				printf("\n\nNot found\n");
+			}
+		} else {
+			p_err("lookup failed: %s", strerror(errno));
+		}
+
+		goto exit_free;
+	}
+
+	/* here means bpf_map_lookup_elem() succeeded */
+	err = get_btf(&info, &btf);
+	if (err) {
+		p_err("failed to get btf");
+		goto exit_free;
+	}
+
+	if (json_output) {
+		print_entry_json(&info, key, value, btf);
+	} else if (btf) {
+		/* if here json_wtr wouldn't have been initialised,
+		 * so let's create separate writer for btf
+		 */
+		btf_wtr = get_btf_writer();
+		if (!btf_wtr) {
+			p_info("failed to create json writer for btf. falling back to plain output");
+			btf__free(btf);
+			btf = NULL;
 			print_entry_plain(&info, key, value);
-	} else if (errno == ENOENT) {
-		if (json_output) {
-			jsonw_null(json_wtr);
 		} else {
-			printf("key:\n");
-			fprint_hex(stdout, key, info.key_size, " ");
-			printf("\n\nNot found\n");
+			struct btf_dumper d = {
+				.btf = btf,
+				.jw = btf_wtr,
+				.is_plain_text = true,
+			};
+
+			do_dump_btf(&d, &info, key, value);
+			jsonw_destroy(&btf_wtr);
 		}
 	} else {
-		p_err("lookup failed: %s", strerror(errno));
+		print_entry_plain(&info, key, value);
 	}
 
 exit_free:
 	free(key);
 	free(value);
 	close(fd);
+	btf__free(btf);
 
 	return err;
 }

