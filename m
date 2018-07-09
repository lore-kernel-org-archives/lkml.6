Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A202C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 00:40:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4351F208DE
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 00:40:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="E6NxfbAA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4351F208DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933488AbeGIAkI (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 20:40:08 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:53308 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933273AbeGIAkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 20:40:05 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w690ckcV026419
        for <linux-kernel@vger.kernel.org>; Sun, 8 Jul 2018 17:40:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date : from
 : to : cc : subject : references : mime-version : content-type;
 s=facebook; bh=J9AVxK5L0XOcrA+AxlUwQP5NQMhm5btg8Dxz7Juf9cs=;
 b=E6NxfbAAIfb+sCDlqbw2bmGhC/zR48Z7XH9Ws6D77ERb0IbPTQzvxRjsLJeChiKd4fpw
 yKrIk95gu8KC5HJLn9FGTFjOz1JfysLK1NU3j9k12tzhvoHHlUrhuoya5GBvb1a7oumM
 m7pQy3BCWbxSYc6a+ap/bXgKENNq807t1oo= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2k2vts2ada-2
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sun, 08 Jul 2018 17:40:04 -0700
Received: from mx-out.facebook.com (192.168.52.123) by mail.thefacebook.com
 (192.168.16.18) with Microsoft SMTP Server (TLS) id 14.3.361.1; Sun, 8 Jul
 2018 17:40:04 -0700
Received: by dev026.lla1.facebook.com (Postfix, from userid 152872)     id
 8C2408A12A8; Sun,  8 Jul 2018 17:40:02 -0700 (PDT)
Message-ID: <20180709004002.440153594@fb.com>
User-Agent: quilt/0.63-1
Date:   Sun, 8 Jul 2018 17:22:03 -0700
Smtp-Origin-Hostprefix: dev
From:   Okash Khawaja <osk@fb.com>
Smtp-Origin-Hostname: dev026.lla1.facebook.com
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        "David S. Miller" <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <kernel-team@fb.com>,
        <linux-kernel@vger.kernel.org>
Smtp-Origin-Cluster: lla1c22
Subject: [PATCH bpf 1/1] bpf: btf: Fix bitfield extraction for big endian
References: <20180709002202.019053555@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline; filename="fix-btf-bitfields.patch"
X-FB-Internal: Safe
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-08_13:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When extracting bitfield from a number, btf_int_bits_seq_show() builds
a mask and accesses least significant byte of the number in a way
specific to little-endian. This patch fixes that by checking endianness
of the machine and then shifting left and right the unneeded bits.

Thanks to Martin Lau for the help in navigating potential pitfalls when
dealing with endianess and for the final solution.

Fixes: b00b8daec828 ("bpf: btf: Add pretty print capability for data with BTF type info")
Signed-off-by: Okash Khawaja <osk@fb.com>

---
 kernel/bpf/btf.c |   32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -162,6 +162,8 @@
 #define BITS_ROUNDDOWN_BYTES(bits) ((bits) >> 3)
 #define BITS_ROUNDUP_BYTES(bits) \
 	(BITS_ROUNDDOWN_BYTES(bits) + !!BITS_PER_BYTE_MASKED(bits))
+const int one = 1;
+#define is_big_endian() ((*(char *)&one) == 0)
 
 #define BTF_INFO_MASK 0x0f00ffff
 #define BTF_INT_MASK 0x0fffffff
@@ -991,16 +993,13 @@ static void btf_int_bits_seq_show(const
 				  void *data, u8 bits_offset,
 				  struct seq_file *m)
 {
+	u8 left_shift_bits, right_shift_bits;
 	u32 int_data = btf_type_int(t);
 	u16 nr_bits = BTF_INT_BITS(int_data);
 	u16 total_bits_offset;
 	u16 nr_copy_bytes;
 	u16 nr_copy_bits;
-	u8 nr_upper_bits;
-	union {
-		u64 u64_num;
-		u8  u8_nums[8];
-	} print_num;
+	u64 print_num;
 
 	total_bits_offset = bits_offset + BTF_INT_OFFSET(int_data);
 	data += BITS_ROUNDDOWN_BYTES(total_bits_offset);
@@ -1008,21 +1007,20 @@ static void btf_int_bits_seq_show(const
 	nr_copy_bits = nr_bits + bits_offset;
 	nr_copy_bytes = BITS_ROUNDUP_BYTES(nr_copy_bits);
 
-	print_num.u64_num = 0;
-	memcpy(&print_num.u64_num, data, nr_copy_bytes);
-
-	/* Ditch the higher order bits */
-	nr_upper_bits = BITS_PER_BYTE_MASKED(nr_copy_bits);
-	if (nr_upper_bits) {
-		/* We need to mask out some bits of the upper byte. */
-		u8 mask = (1 << nr_upper_bits) - 1;
-
-		print_num.u8_nums[nr_copy_bytes - 1] &= mask;
+	print_num = 0;
+	memcpy(&print_num, data, nr_copy_bytes);
+	if (is_big_endian()) {
+		left_shift_bits = bits_offset;
+		right_shift_bits = BITS_PER_U64 - nr_bits;
+	} else {
+		left_shift_bits = BITS_PER_U64 - nr_copy_bits;
+		right_shift_bits = BITS_PER_U64 - nr_bits;
 	}
 
-	print_num.u64_num >>= bits_offset;
+	print_num <<= left_shift_bits;
+	print_num >>= right_shift_bits;
 
-	seq_printf(m, "0x%llx", print_num.u64_num);
+	seq_printf(m, "0x%llx", print_num);
 }
 
 static void btf_int_seq_show(const struct btf *btf, const struct btf_type *t,

