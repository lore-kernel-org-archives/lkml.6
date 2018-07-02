Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58D28C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 19:16:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F38B524F71
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 19:16:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="BkmwmqSn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F38B524F71
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753522AbeGBTQp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 15:16:45 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:52000 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753110AbeGBTQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 15:16:24 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.22/8.16.0.22) with SMTP id w62JEEY0022334
        for <linux-kernel@vger.kernel.org>; Mon, 2 Jul 2018 12:16:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date : from
 : to : cc : subject : references : mime-version : content-type;
 s=facebook; bh=ajdeqjHwi4l9DRY5ayOa5lkRzapRMy3lqwTgR73VZvE=;
 b=BkmwmqSnisP4JPQFZuQWy4FfKqK+6sCJHHwuxGJwCE+6fpKJz3ijuu0rwbVC/lihb2hk
 oSCn1+QhzpUhK266PGMfDVKn+i9k0kfV4K1A6fgDTZbJF0FTk93y4la2L6miIn+AAZi7
 Cjgk2tLwB/SYOwEc3Y8qch7YNkcY56VjDnE= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by m0089730.ppops.net with ESMTP id 2jysfkr4gq-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 12:16:24 -0700
Received: from mx-out.facebook.com (192.168.52.123) by mail.thefacebook.com
 (192.168.16.20) with Microsoft SMTP Server (TLS) id 14.3.361.1; Mon, 2 Jul
 2018 12:16:22 -0700
Received: by dev026.lla1.facebook.com (Postfix, from userid 152872)     id
 BAE218A416E; Mon,  2 Jul 2018 12:13:24 -0700 (PDT)
Message-ID: <20180702191324.683291855@fb.com>
User-Agent: quilt/0.63-1
Date:   Mon, 2 Jul 2018 11:39:16 -0700
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
Subject: [PATCH bpf-next v2 3/3] bpf: btf: print map dump and lookup with btf info
References: <20180702183913.669030439@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline; filename="03-json-print-btf-info-for-map"
X-FB-Internal: Safe
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-02_06:,,
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
 tools/bpf/bpftool/map.c |  174 +++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 166 insertions(+), 8 deletions(-)

--- a/tools/bpf/bpftool/map.c
+++ b/tools/bpf/bpftool/map.c
@@ -41,9 +41,13 @@
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
@@ -148,8 +152,99 @@ int map_parse_fd_and_info(int *argc, cha
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
+		return ret;
+
+	jsonw_name(d->jw, "value");
+
+	ret = btf_dumper_type(d, map_info->btf_value_type_id, value);
+
+	/* end of key-value pair */
+	jsonw_end_object(d->jw);
+
+	return ret;
+}
+
+static struct btf *get_btf(struct bpf_map_info *map_info)
+{
+	int btf_fd = bpf_btf_get_fd_by_id(map_info->btf_id);
+	struct bpf_btf_info btf_info = { 0 };
+	__u32 len = sizeof(btf_info);
+	void *ptr = NULL, *temp_ptr;
+	struct btf *btf = NULL;
+	uint32_t last_size;
+	int err;
+
+	if (btf_fd < 0)
+		return NULL;
+
+	/* we won't know btf_size until we call bpf_obj_get_info_by_fd(). so
+	 * let's start with a sane default - 4KiB here - and resize it only if
+	 * bpf_obj_get_info_by_fd() needs a bigger buffer. the do-while loop
+	 * below should run a maximum of two iterations and that will be when
+	 * we have to resize to a bigger buffer.
+	 */
+	btf_info.btf_size = 4096;
+	do {
+		last_size = btf_info.btf_size;
+		temp_ptr = realloc(ptr, last_size);
+		if (!temp_ptr) {
+			p_err("unable to allocate memory for debug info");
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
+		       err ? strerror(errno) : "exceeds size retry");
+		goto exit_free;
+	}
+
+	btf = btf__new((uint8_t *)btf_info.btf,
+		       btf_info.btf_size, NULL);
+	if (IS_ERR(btf)) {
+		printf("error when initialising btf: %s\n",
+		       strerror(PTR_ERR(btf)));
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
 
@@ -158,6 +253,15 @@ static void print_entry_json(struct bpf_
 		print_hex_data_json(key, info->key_size);
 		jsonw_name(json_wtr, "value");
 		print_hex_data_json(value, info->value_size);
+		if (btf) {
+			struct btf_dumper d = {
+				.btf = btf,
+				.jw = json_wtr,
+				.is_plain_text = false,
+			};
+			jsonw_name(json_wtr, "formatted");
+			do_dump_btf(&d, info, key, value);
+		}
 	} else {
 		unsigned int i, n;
 
@@ -508,10 +612,12 @@ static int do_show(int argc, char **argv
 
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
 
@@ -537,8 +643,22 @@ static int do_dump(int argc, char **argv
 	}
 
 	prev_key = NULL;
+
+	btf = get_btf(&info);
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
@@ -549,9 +669,18 @@ static int do_dump(int argc, char **argv
 
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
+					do_dump_btf(&d, &info, key, value);
+				} else {
+					print_entry_plain(&info, key, value);
+				}
 		} else {
 			if (json_output) {
 				jsonw_name(json_wtr, "key");
@@ -574,14 +703,19 @@ static int do_dump(int argc, char **argv
 
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
@@ -637,6 +771,8 @@ static int do_lookup(int argc, char **ar
 {
 	struct bpf_map_info info = {};
 	__u32 len = sizeof(info);
+	json_writer_t *btf_wtr;
+	struct btf *btf = NULL;
 	void *key, *value;
 	int err;
 	int fd;
@@ -662,10 +798,31 @@ static int do_lookup(int argc, char **ar
 
 	err = bpf_map_lookup_elem(fd, key, value);
 	if (!err) {
-		if (json_output)
-			print_entry_json(&info, key, value);
-		else
+		btf = get_btf(&info);
+		if (json_output) {
+			print_entry_json(&info, key, value, btf);
+		} else if (btf) {
+			/* if here json_wtr wouldn't have been initialised,
+			 * so let's create separate writer for btf
+			 */
+			btf_wtr = get_btf_writer();
+			if (!btf_wtr) {
+				p_info("failed to create json writer for btf. falling back to plain output");
+				btf__free(btf);
+				btf = NULL;
+				print_entry_plain(&info, key, value);
+			} else {
+				struct btf_dumper d = {
+					.btf = btf,
+					.jw = btf_wtr,
+					.is_plain_text = true,
+				};
+				do_dump_btf(&d, &info, key, value);
+				jsonw_destroy(&btf_wtr);
+			}
+		} else {
 			print_entry_plain(&info, key, value);
+		}
 	} else if (errno == ENOENT) {
 		if (json_output) {
 			jsonw_null(json_wtr);
@@ -682,6 +839,7 @@ exit_free:
 	free(key);
 	free(value);
 	close(fd);
+	btf__free(btf);
 
 	return err;
 }

