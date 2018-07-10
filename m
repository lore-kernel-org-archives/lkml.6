Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 121C0C5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 21:45:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE9B6208E5
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 21:45:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Sm2Z4icD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE9B6208E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732421AbeGJVq1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 17:46:27 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:33400 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732310AbeGJVq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 17:46:27 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6ALi5XV024003
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 14:45:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date : from
 : to : cc : subject : references : mime-version : content-type;
 s=facebook; bh=PYN/ZoWxvHdb/ak7cTQYt2wpxJiBcP3XN2pFmJLYUCI=;
 b=Sm2Z4icDa/bNwhnLI4/12dKpTHni6Rh+2JNy5IuOoVVgA+qRtHywv0ZHge6bPOYXiwOU
 ajFikrMv7TQ7CwJn8VNph8D7pvereMs3lQQyJX2shJ/aMwdztXIigZFc63sxzHuS0vlm
 YKBSGs0pteubHS4leCxN5l+k3dqCVA/MjgY= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2k51qarm33-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 14:45:24 -0700
Received: from mx-out.facebook.com (192.168.52.123) by mail.thefacebook.com
 (192.168.16.19) with Microsoft SMTP Server (TLS) id 14.3.361.1; Tue, 10 Jul
 2018 14:45:23 -0700
Received: by dev026.lla1.facebook.com (Postfix, from userid 152872)     id
 5F9E28A0182; Tue, 10 Jul 2018 14:45:22 -0700 (PDT)
Message-ID: <20180710214522.339195416@fb.com>
User-Agent: quilt/0.63-1
Date:   Tue, 10 Jul 2018 14:33:07 -0700
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
Subject: [PATCH bpf v2 1/1] bpf: btf: Fix bitfield extraction for big endian
References: <20180710213306.646146378@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline; filename="fix-btf-bitfields.patch"
X-FB-Internal: Safe
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-10_07:,,
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
 kernel/bpf/btf.c |   30 +++++++++++++-----------------
 1 file changed, 13 insertions(+), 17 deletions(-)

--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -991,16 +991,13 @@ static void btf_int_bits_seq_show(const
 				  void *data, u8 bits_offset,
 				  struct seq_file *m)
 {
+	u16 left_shift_bits, right_shift_bits;
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
@@ -1008,21 +1005,20 @@ static void btf_int_bits_seq_show(const
 	nr_copy_bits = nr_bits + bits_offset;
 	nr_copy_bytes = BITS_ROUNDUP_BYTES(nr_copy_bits);
 
-	print_num.u64_num = 0;
-	memcpy(&print_num.u64_num, data, nr_copy_bytes);
+	print_num = 0;
+	memcpy(&print_num, data, nr_copy_bytes);
 
-	/* Ditch the higher order bits */
-	nr_upper_bits = BITS_PER_BYTE_MASKED(nr_copy_bits);
-	if (nr_upper_bits) {
-		/* We need to mask out some bits of the upper byte. */
-		u8 mask = (1 << nr_upper_bits) - 1;
+#ifdef __BIG_ENDIAN_BITFIELD
+	left_shift_bits = bits_offset;
+#else
+	left_shift_bits = BITS_PER_U64 - nr_copy_bits;
+#endif
+	right_shift_bits = BITS_PER_U64 - nr_bits;
 
-		print_num.u8_nums[nr_copy_bytes - 1] &= mask;
-	}
+	print_num <<= left_shift_bits;
+	print_num >>= right_shift_bits;
 
-	print_num.u64_num >>= bits_offset;
-
-	seq_printf(m, "0x%llx", print_num.u64_num);
+	seq_printf(m, "0x%llx", print_num);
 }
 
 static void btf_int_seq_show(const struct btf *btf, const struct btf_type *t,

