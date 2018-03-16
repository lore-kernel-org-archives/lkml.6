Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvri8NanlLcxxOWj8v6nWUDE5oArWJaNsnlVNsc31YfvIAF/I7Pz6WOO8sqb49YxT0PZy87
ARC-Seal: i=1; a=rsa-sha256; t=1521214242; cv=none;
        d=google.com; s=arc-20160816;
        b=ZbvFhU+XWDn5LbuUQ4he09P3WGjRm6l3Nm08BiZPTrSOj50W8bicKuRDmmDPShmFCC
         bWsWg6JX3XnLzmH6872zWsTQ26xrrfAvyVf1nJCyJcHFuLsRKXmuGc1Yp6ImGDHHDlbC
         9TROgqz2ViGjBmrTSiC3ZQGJJs0pwseF2Z/JXg/sz8ZYR3lL/Bz36wIAy1rJoulTsKxr
         hON7/Tepc+H0k6RdwW+acLXepPS6fTL+LCgopToKCGMNivfwUhFAjrBll58XpWtccg1e
         0U83leDu/wMDmcXHJOFbvHc8CcaTYfjt8AnkYbfDpI37JAK7Dk2WJqZTFMTQG/+D9I0o
         IkmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=t0VXFtpL9oDcGvkg4hZWl1DVl3U0oe4CYbfnLGK5rcc=;
        b=gIOuh+U3uMJO6ccBXMuG95j+2XYyTbNOzx4QQx8B9hPUsTJICSBVllkV/sZkCnW8Bw
         JiYIWVvk/JZ9htA+I04jsICsDhg6STDhXugKsEZhLHS/zcbSRih4ycyjlGaTLbo+VwG+
         RImHSzdK0rFZz79WmkZBxqtZX+AHYDY9Gs03yTldATFf0s2of+c448nZYE7OxA9xXO7G
         efWwxEGjywC1ujaJGs11GDrijWkv0pzbAq5kZTzObjjFqXYU7MEdk/uHHjT9wkGCaxKS
         TsXzgrY2d2uKeHLZqzLfxV8v+/Q53s+HhNYeICpjnVr4X4v/ID00+z943yc8VBCVZKSx
         Lpsw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Sergey Gorenko <sergeygo@mellanox.com>,
	Laurence Oberman <loberman@redhat.com>,
	Leon Romanovsky <leon@kernel.org>,
	Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH 4.9 25/86] IB/mlx5: Fix incorrect size of klms in the memory region
Date: Fri, 16 Mar 2018 16:22:48 +0100
Message-Id: <20180316152319.073220372@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152317.167709497@linuxfoundation.org>
References: <20180316152317.167709497@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595108745265350287?=
X-GMAIL-MSGID: =?utf-8?q?1595108745265350287?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sergey Gorenko <sergeygo@mellanox.com>

commit da343b6d90e11132f1e917d865d88ee35d6e6d00 upstream.

The value of mr->ndescs greater than mr->max_descs is set in the
function mlx5_ib_sg_to_klms() if sg_nents is greater than
mr->max_descs. This is an invalid value and it causes the
following error when registering mr:

mlx5_0:dump_cqe:276:(pid 193): dump error cqe
00000000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00000010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00000020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00000030: 00 00 00 00 0f 00 78 06 25 00 00 8b 08 1e 8f d3

Cc: <stable@vger.kernel.org> # 4.5
Fixes: b005d3164713 ("mlx5: Add arbitrary sg list support")
Signed-off-by: Sergey Gorenko <sergeygo@mellanox.com>
Tested-by: Laurence Oberman <loberman@redhat.com>
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/hw/mlx5/mr.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -1821,7 +1821,6 @@ mlx5_ib_sg_to_klms(struct mlx5_ib_mr *mr
 
 	mr->ibmr.iova = sg_dma_address(sg) + sg_offset;
 	mr->ibmr.length = 0;
-	mr->ndescs = sg_nents;
 
 	for_each_sg(sgl, sg, sg_nents, i) {
 		if (unlikely(i >= mr->max_descs))
@@ -1833,6 +1832,7 @@ mlx5_ib_sg_to_klms(struct mlx5_ib_mr *mr
 
 		sg_offset = 0;
 	}
+	mr->ndescs = i;
 
 	if (sg_offset_p)
 		*sg_offset_p = sg_offset;
