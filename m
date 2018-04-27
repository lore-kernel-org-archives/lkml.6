Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933815AbeD0OE5 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 10:04:57 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:42866 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933783AbeD0OEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 10:04:51 -0400
Date: Fri, 27 Apr 2018 17:04:09 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Alexei Starovoitov <ast@kernel.org>, Martin KaFai Lau <kafai@fb.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH 1/2] bpf: btf: silence uninitialize variable warnings
Message-ID: <20180427140409.GA19583@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8875 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=773
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804270135
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Smatch complains that size can be uninitialized if btf_type_id_size()
returns NULL.  It seems reasonable enough to check for that.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
This goes to the BPF tree (linux-next).

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 22e1046a1a86..e631b6fd60d3 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -1229,7 +1229,8 @@ static int btf_array_check_member(struct btf_verifier_env *env,
 	}
 
 	array_type_id = member->type;
-	btf_type_id_size(btf, &array_type_id, &array_size);
+	if (!btf_type_id_size(btf, &array_type_id, &array_size))
+		return -EINVAL;
 	struct_size = struct_type->size;
 	bytes_offset = BITS_ROUNDDOWN_BYTES(struct_bits_off);
 	if (struct_size - bytes_offset < array_size) {
@@ -1351,6 +1352,8 @@ static void btf_array_seq_show(const struct btf *btf, const struct btf_type *t,
 
 	elem_type_id = array->type;
 	elem_type = btf_type_id_size(btf, &elem_type_id, &elem_size);
+	if (!elem_type)
+		return;
 	elem_ops = btf_type_ops(elem_type);
 	seq_puts(m, "[");
 	for (i = 0; i < array->nelems; i++) {
