Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/Q74/aqcNMVVKX3SLO9jh89rn/KNHkhjsv1at2xYG8FZ/Q1JkB35BYXiMMse5y/drIpsmQ
ARC-Seal: i=1; a=rsa-sha256; t=1524406656; cv=none;
        d=google.com; s=arc-20160816;
        b=RryIMi9fz+3i+1BySCftZ0tVNoRzNWfR9C00Kr8onxksNUKK3jSjWgaK8HRynx2NHY
         IqmJn2Xe00SfBlELNlKzliR6qZVxSxiD5Us1v3qvM/yTLvwDRSECPvBuM7MZXQBmqRp9
         kzhEXoZbT8fFMMaUZeRxEbsnh8hpaIE7rZMzm6v94g0T7Vs6jWCsS6KSthjAZbMTqkaA
         nYmSWSh5BxENyukg4hBaYv7FinsQ/pL/y9+69IDYEGACJMFOz1iPS9mVSJj7KZOfU7Kr
         C58vFRB2UpKFseNUODdPN8i9MR1OmPHa7LiQ8Pdv6Xzat+1tkwRPBV7OhJQSkxhLk6n7
         +xYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=9bQR1odaMQ/SRU2bzBERgf284pcQJXNkiy56f3PK/ug=;
        b=vuOzicCssJKqcgIxBPPufjNy/90aT8JYpsmTVbo153ge7LwnSImaERjZsa2KNVmhK1
         0YF50Xr3Uv03YIDIJlLLqflmim9onrLJTS5fCr3TGVu8rOkOooeMK0Hst3mQE3g7nYPq
         5CKeIKwJi6icrLbR9NLJ3x0L/avwjdhttNyQwnINyMUzhMglgXnnePPA/Bb2ArJf2rzw
         yefltnnhkxIXUiUadXyCZfdrYz34V25lJnwo4RZTSYiCAuJR3JZouFn6OJXpWzryZdl9
         5pO1sN2IIcu7eV0spRNQ2C8lTdvwzx9YDuYUTP4YljAC9RMpQnaB7v9nR+RD0O+7s1bb
         N02Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Alexander Schmid <alex@modula-shop-systems.de>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH 4.4 55/97] IB/srp: Fix completion vector assignment algorithm
Date: Sun, 22 Apr 2018 15:53:33 +0200
Message-Id: <20180422135308.352834384@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135304.577223025@linuxfoundation.org>
References: <20180422135304.577223025@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455094734674658?=
X-GMAIL-MSGID: =?utf-8?q?1598456233992122277?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bart Van Assche <bart.vanassche@wdc.com>

commit 3a148896b24adf8688dc0c59af54531931677a40 upstream.

Ensure that cv_end is equal to ibdev->num_comp_vectors for the
NUMA node with the highest index. This patch improves spreading
of RDMA channels over completion vectors and thereby improves
performance, especially on systems with only a single NUMA node.
This patch drops support for the comp_vector login parameter by
ignoring the value of that parameter since I have not found a
good way to combine support for that parameter and automatic
spreading of RDMA channels over completion vectors.

Fixes: d92c0da71a35 ("IB/srp: Add multichannel support")
Reported-by: Alexander Schmid <alex@modula-shop-systems.de>
Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Alexander Schmid <alex@modula-shop-systems.de>
Cc: stable@vger.kernel.org
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/ulp/srp/ib_srp.c |   10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

--- a/drivers/infiniband/ulp/srp/ib_srp.c
+++ b/drivers/infiniband/ulp/srp/ib_srp.c
@@ -3311,12 +3311,10 @@ static ssize_t srp_create_target(struct
 				      num_online_nodes());
 		const int ch_end = ((node_idx + 1) * target->ch_count /
 				    num_online_nodes());
-		const int cv_start = (node_idx * ibdev->num_comp_vectors /
-				      num_online_nodes() + target->comp_vector)
-				     % ibdev->num_comp_vectors;
-		const int cv_end = ((node_idx + 1) * ibdev->num_comp_vectors /
-				    num_online_nodes() + target->comp_vector)
-				   % ibdev->num_comp_vectors;
+		const int cv_start = node_idx * ibdev->num_comp_vectors /
+				     num_online_nodes();
+		const int cv_end = (node_idx + 1) * ibdev->num_comp_vectors /
+				   num_online_nodes();
 		int cpu_idx = 0;
 
 		for_each_online_cpu(cpu) {
