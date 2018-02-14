Return-Path: <kernel-hardening-return-11781-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x225DUhUtQgktvzvyIOVyCjh0s99VxyoUrJhPQAeHZBhB787xq4KEaY0ZM3Ccth/7rAxGN5Zr
ARC-Seal: i=1; a=rsa-sha256; t=1518639206; cv=none;
        d=google.com; s=arc-20160816;
        b=nmkPGDOPjHs6vMVH8aDZf5Y4wPvmKMfqh8R7Ox93bq5404MUxJFnMq/FbAuDIsNHAJ
         cLhnsyxyNapCCEEnBvVVZof+YStIfcebvGTmH21oTjJxXY740OBRLFrz0BJnPDkWn3Z8
         rxmahdURSbWO0y9g8e+oeudqf9fY2dz0m1HzX3xIn5GhLTfVPID4TLboqy+/IDzrhr4L
         xMdy3KfuiW4aCHxJ9eMRqWzXwpLVespv0kcoiyG7WMJmIVzFMjbSTXtn6rg3cd3Jirbt
         VgDKFFTZDtrFSa0xGTFE+igGHHd+067VLEUyzHEU+YpoXHLvV2vj4g3DbxhO3SyK/HG6
         bg9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:delivered-to:list-id:list-subscribe:list-unsubscribe
         :list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=smehIb4ArLPbw3tPZFoN6IU4SxrkwPtcKkkbEV8Q8f8=;
        b=ghnVq2tVUuCs4CrLviDUep9R5qA8NGNYUB4eHP5I/tzxSC42t/jOcZjSbOQUTRFL3E
         MdKQdyBUG4zkLrcK0osmYhpWA3mdh7ZwsBm8tIVXcddnQf0EHNQDR9I1unDcDrzbQb1i
         muYZvtM/bTCCr8+6JgUQz35+Lne6d7cYZXeYEmiEB49IQCM6zTQ+ZD392TTHQCBRUk02
         RjcgHsQuOvJojrcDO6UkShTv2Sk0r9EhRxT5z0ms+Emy73V5GpapvGN6cBcLYU1hOHv6
         mip7GGhCu1yGDSrs/aUOqwWkQnAf0nVzvvNgtlJsMAmGRIwSPaDMIHcsHvZOfQZG5Dqs
         /Few==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=fail header.i=@infradead.org header.s=bombadil.20170209 header.b=VcvW3ZRO;
       spf=pass (google.com: domain of kernel-hardening-return-11781-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11781-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=fail header.i=@infradead.org header.s=bombadil.20170209 header.b=VcvW3ZRO;
       spf=pass (google.com: domain of kernel-hardening-return-11781-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11781-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
From: Matthew Wilcox <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Wilcox <mawilcox@microsoft.com>,
	linux-mm@kvack.org,
	Kees Cook <keescook@chromium.org>,
	linux-kernel@vger.kernel.org,
	kernel-hardening@lists.openwall.com,
	Joe Perches <joe@perches.com>
Subject: [PATCH v2 5/8] Convert infiniband uverbs to kvzalloc_struct
Date: Wed, 14 Feb 2018 12:11:51 -0800
Message-Id: <20180214201154.10186-6-willy@infradead.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180214201154.10186-1-willy@infradead.org>
References: <20180214201154.10186-1-willy@infradead.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592408624022038998?=
X-GMAIL-MSGID: =?utf-8?q?1592408624022038998?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Matthew Wilcox <mawilcox@microsoft.com>

Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
---
 drivers/infiniband/core/uverbs_cmd.c | 4 ++--
 include/rdma/ib_verbs.h              | 5 +----
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index 256934d1f64f..7e4114a8954d 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -3346,8 +3346,8 @@ int ib_uverbs_ex_create_flow(struct ib_uverbs_file *file,
 		goto err_uobj;
 	}
 
-	flow_attr = kzalloc(sizeof(*flow_attr) + cmd.flow_attr.num_of_specs *
-			    sizeof(union ib_flow_spec), GFP_KERNEL);
+	flow_attr = kvzalloc_struct(flow_attr, flows,
+				    cmd.flow_attr.num_of_specs, GFP_KERNEL);
 	if (!flow_attr) {
 		err = -ENOMEM;
 		goto err_put;
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 73b2387e3f74..895509ee7f80 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -1977,10 +1977,7 @@ struct ib_flow_attr {
 	u32	     flags;
 	u8	     num_of_specs;
 	u8	     port;
-	/* Following are the optional layers according to user request
-	 * struct ib_flow_spec_xxx
-	 * struct ib_flow_spec_yyy
-	 */
+	union ib_flow_spec flows[];
 };
 
 struct ib_flow {
-- 
2.15.1
