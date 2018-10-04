Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D85C9C00449
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 02:58:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9031213A2
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 02:58:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9031213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbeJDJtH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 05:49:07 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:42118 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727312AbeJDJtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 05:49:06 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w942vxZI008539
        for <linux-kernel@vger.kernel.org>; Wed, 3 Oct 2018 19:57:59 -0700
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2mw8fs89dn-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 19:57:59 -0700
Received: from mx-out.facebook.com (192.168.52.123) by mail.thefacebook.com
 (192.168.16.11) with Microsoft SMTP Server (TLS) id 14.3.361.1; Wed, 3 Oct
 2018 19:57:54 -0700
Received: by devbig007.ftw2.facebook.com (Postfix, from userid 572438)  id
 16AAE760B52; Wed,  3 Oct 2018 19:57:51 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Alexei Starovoitov <ast@kernel.org>
Smtp-Origin-Hostname: devbig007.ftw2.facebook.com
To:     "David S . Miller" <davem@davemloft.net>
CC:     <daniel@iogearbox.net>, <luto@amacapital.net>,
        <viro@zeniv.linux.org.uk>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next 3/6] tools/bpf: sync uapi/bpf.h
Date:   Wed, 3 Oct 2018 19:57:47 -0700
Message-ID: <20181004025750.498303-4-ast@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181004025750.498303-1-ast@kernel.org>
References: <20181004025750.498303-1-ast@kernel.org>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-04_01:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sync uapi/bpf.h from kernel into tools

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/include/uapi/linux/bpf.h | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index f9187b41dff6..c0df8dd99edc 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -154,6 +154,7 @@ enum bpf_prog_type {
 	BPF_PROG_TYPE_LIRC_MODE2,
 	BPF_PROG_TYPE_SK_REUSEPORT,
 	BPF_PROG_TYPE_FLOW_DISSECTOR,
+	BPF_PROG_TYPE_FILE_FILTER,
 };
 
 enum bpf_attach_type {
@@ -175,6 +176,7 @@ enum bpf_attach_type {
 	BPF_CGROUP_UDP6_SENDMSG,
 	BPF_LIRC_MODE2,
 	BPF_FLOW_DISSECTOR,
+	BPF_CGROUP_FILE_OPEN,
 	__MAX_BPF_ATTACH_TYPE
 };
 
@@ -2215,6 +2217,18 @@ union bpf_attr {
  *		pointer that was returned from bpf_sk_lookup_xxx\ ().
  *	Return
  *		0 on success, or a negative error in case of failure.
+ *
+ * int bpf_get_file_path(struct bpf_file_info *file, char *buf, u32 size_of_buf)
+ * 	Description
+ * 		Reconstruct the full path of *file* and store it into *buf* of
+ * 		*size_of_buf*. The *size_of_buf* must be strictly positive.
+ * 		On success, the helper makes sure that the *buf* is NUL-terminated.
+ * 		On failure, it is filled with string "(error)".
+ * 		This helper should only be used for debugging.
+ * 		'char *path' should never be used for permission checks.
+ * 	Return
+ * 		0 on success, or a negative error in case of failure.
+ *
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -2303,7 +2317,8 @@ union bpf_attr {
 	FN(skb_ancestor_cgroup_id),	\
 	FN(sk_lookup_tcp),		\
 	FN(sk_lookup_udp),		\
-	FN(sk_release),
+	FN(sk_release),			\
+	FN(get_file_path),
 
 /* integer value in 'imm' field of BPF_CALL instruction selects which helper
  * function eBPF program intends to call
@@ -2896,4 +2911,15 @@ struct bpf_flow_keys {
 	};
 };
 
+struct bpf_file_info {
+	__u64 inode;
+	__u32 dev_major;
+	__u32 dev_minor;
+	__u32 fs_magic;
+	__u32 mnt_id;
+	__u32 nlink;
+	__u32 mode;	/* file mode S_ISDIR, S_ISLNK, 0755, etc */
+	__u32 flags;	/* open flags O_RDWR, O_CREAT, etc */
+};
+
 #endif /* _UAPI__LINUX_BPF_H__ */
-- 
2.17.1

