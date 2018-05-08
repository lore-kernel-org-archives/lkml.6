Return-Path: <SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpaNjyT9wZk8K+qe0vnxuepKbObaBa7IgXR6TVl/KJSuEq1yMIVm1A57jlbFL9xJvlUdxzO
ARC-Seal: i=1; a=rsa-sha256; t=1525767297; cv=none;
        d=google.com; s=arc-20160816;
        b=la4Gj9h4IzuArxtlb4TWYGmaHoKTUSOOK3NzDW+cgUGV0+znq2Q5KdsCCUj/ZwncuO
         LHMRXl71l1gsH1IMK5/qyX34L9EEmH0RBsz4U9EHsrby3YK2lNSUXxwEbIe/KXU5Kk8h
         aPcMhG+Ta0Urpf+1UxQSKJVwNZSS4XXM8SfNxd/QaeFfFlya1fwylbciAWnNc7Kqhxkd
         hA2RBSN44BdvNUMKcKJzZmH6ZHo4YZYs10LAGuBps/tDdSxVWdQ4WBlnPre4CYBeOaJE
         5Yz7bSc2SZefZbZ+huDDIjwEt4otf19DGXVNYcI0WvV0zwbB7/SVLAK6dS6YUmwZf77r
         OoOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=w/k1Rt2arlDpIepkfh5WZ+Esk+GH78PhCO9u8s353ME=;
        b=KNXJdufCxB7xmEEWsk/x4uTChnnDdT3ihxgaQAq8VnIzkJDviIkTuV1vdcV2SLX0zG
         Tm99Wi1jmd8vf7bWHki7kGMbzogvHrWvDjg03GXEqgezEEROAEDUiN4AC+918GqXOYGl
         Pz8ToLc9JBChL5M20Ra1WW6gyCcVOP85mHBXh/MaNInoNwKDUSLdc915pS8qtb/qiL/F
         3NA14+xmiiq3OR9H549y2aS+fsolmBj0Ayi/pooqXjPohAYvf5RgcWgZrOYX43uf2MWe
         8EcWlhyxxTyYRhkI/mzqbI02J/bn7HDchVnDFobH5gZYoHcJXYYV/7blIFyhYEMeAi7n
         sAuw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=2o70cc6J;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=2o70cc6J;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	syzkaller <syzkaller@googlegroups.com>,
	Noa Osherovich <noaos@mellanox.com>,
	Leon Romanovsky <leonro@mellanox.com>,
	Doug Ledford <dledford@redhat.com>
Subject: [PATCH 4.14 22/43] RDMA/mlx5: Fix multiple NULL-ptr deref errors in rereg_mr flow
Date: Tue,  8 May 2018 10:10:41 +0200
Message-Id: <20180508074007.576623141@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180508074003.984433784@linuxfoundation.org>
References: <20180508074003.984433784@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599882847801858852?=
X-GMAIL-MSGID: =?utf-8?q?1599882970182709971?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Leon Romanovsky <leonro@mellanox.com>

commit b4bd701ac469075d94ed9699a28755f2862252b9 upstream.

Failure in rereg MR releases UMEM but leaves the MR to be destroyed
by the user. As a result the following scenario may happen:
"create MR -> rereg MR with failure -> call to rereg MR again" and
hit "NULL-ptr deref or user memory access" errors.

Ensure that rereg MR is only performed on a non-dead MR.

Cc: syzkaller <syzkaller@googlegroups.com>
Cc: <stable@vger.kernel.org> # 4.5
Fixes: 395a8e4c32ea ("IB/mlx5: Refactoring register MR code")
Reported-by: Noa Osherovich <noaos@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Doug Ledford <dledford@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/hw/mlx5/mr.c |   32 +++++++++++++++++++++++---------
 1 file changed, 23 insertions(+), 9 deletions(-)

--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -833,25 +833,28 @@ static int mr_umem_get(struct ib_pd *pd,
 		       int *order)
 {
 	struct mlx5_ib_dev *dev = to_mdev(pd->device);
+	struct ib_umem *u;
 	int err;
 
-	*umem = ib_umem_get(pd->uobject->context, start, length,
-			    access_flags, 0);
-	err = PTR_ERR_OR_ZERO(*umem);
+	*umem = NULL;
+
+	u = ib_umem_get(pd->uobject->context, start, length, access_flags, 0);
+	err = PTR_ERR_OR_ZERO(u);
 	if (err) {
-		*umem = NULL;
-		mlx5_ib_err(dev, "umem get failed (%d)\n", err);
+		mlx5_ib_dbg(dev, "umem get failed (%d)\n", err);
 		return err;
 	}
 
-	mlx5_ib_cont_pages(*umem, start, MLX5_MKEY_PAGE_SHIFT_MASK, npages,
+	mlx5_ib_cont_pages(u, start, MLX5_MKEY_PAGE_SHIFT_MASK, npages,
 			   page_shift, ncont, order);
 	if (!*npages) {
 		mlx5_ib_warn(dev, "avoid zero region\n");
-		ib_umem_release(*umem);
+		ib_umem_release(u);
 		return -EINVAL;
 	}
 
+	*umem = u;
+
 	mlx5_ib_dbg(dev, "npages %d, ncont %d, order %d, page_shift %d\n",
 		    *npages, *ncont, *order, *page_shift);
 
@@ -1340,13 +1343,12 @@ int mlx5_ib_rereg_user_mr(struct ib_mr *
 	int access_flags = flags & IB_MR_REREG_ACCESS ?
 			    new_access_flags :
 			    mr->access_flags;
-	u64 addr = (flags & IB_MR_REREG_TRANS) ? virt_addr : mr->umem->address;
-	u64 len = (flags & IB_MR_REREG_TRANS) ? length : mr->umem->length;
 	int page_shift = 0;
 	int upd_flags = 0;
 	int npages = 0;
 	int ncont = 0;
 	int order = 0;
+	u64 addr, len;
 	int err;
 
 	mlx5_ib_dbg(dev, "start 0x%llx, virt_addr 0x%llx, length 0x%llx, access_flags 0x%x\n",
@@ -1354,6 +1356,17 @@ int mlx5_ib_rereg_user_mr(struct ib_mr *
 
 	atomic_sub(mr->npages, &dev->mdev->priv.reg_pages);
 
+	if (!mr->umem)
+		return -EINVAL;
+
+	if (flags & IB_MR_REREG_TRANS) {
+		addr = virt_addr;
+		len = length;
+	} else {
+		addr = mr->umem->address;
+		len = mr->umem->length;
+	}
+
 	if (flags != IB_MR_REREG_PD) {
 		/*
 		 * Replace umem. This needs to be done whether or not UMR is
@@ -1361,6 +1374,7 @@ int mlx5_ib_rereg_user_mr(struct ib_mr *
 		 */
 		flags |= IB_MR_REREG_TRANS;
 		ib_umem_release(mr->umem);
+		mr->umem = NULL;
 		err = mr_umem_get(pd, addr, len, access_flags, &mr->umem,
 				  &npages, &page_shift, &ncont, &order);
 		if (err < 0) {
