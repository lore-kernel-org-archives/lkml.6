Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/FGLHbr7W1qS3jcWRlQx8teCdHF9QGyTsFZTKPf7CZcOPLsXSwidQwwsiKuRazeBOWBiJi
ARC-Seal: i=1; a=rsa-sha256; t=1524405537; cv=none;
        d=google.com; s=arc-20160816;
        b=eNijMvaTnzGRG46GiQgSEghzObfARiX/2b+Fgxth/RuXT/btgk/12fo77IbZF0dPjt
         3U4GBakCOurg5me0bRFvWNVOi6mSNOfMyA7yxZhdH8ZRndP/FTyT+RyL25UyviYiiNts
         JkLKNaBFsIH6xs6qzYJtSK+z0MS/NQR2i/7oa7g+OX+wG8oWvCZbpX1L/SY7h7PqBfBt
         Spf0cLrfNJJ5gjEjaA7A3vr/zNL5jHCTP6fjlRQ68Bdk01OL8H3svwXuwbqVFtL0ppl0
         OzxbtjC7Tb1XRvB7WBh9GE0N8JRLkM742uL6MSNm+Pd+J+8IB9kZsNBug/jS8PPmu5OV
         cYmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=v9Ge2Yx4cEy71g+1w44/jqQ9K6PT4Nval6nKfq+OajI=;
        b=NtVFBrN3BpugJFuWcBw5BWLaax62UqJZyzQ87ZRGend+E4cZazKaZ/uP9xRytcm/Rp
         +xyxgrFPpBxCpke2BIKtmC425NY+jRldv5d+YcUBVZDHC+cJyhkrgr8ZMRGD/hMSplQr
         4N8obzC9StPj8EeIU05EXmyfIs+UXTNe0kv3HsWr+PQGGmVYthx7Xm2lYjUshaHPW0Xw
         JeS6wzsEQ+FQKHWCidcgProgf1scvBtOQtBnPGNha6TSCxTWmeTuFXXf0MGtxYW1eeKc
         N83tszQN9R5DEf2pmSXHnErniAD+GQ/vLaPTpk7HiIDe3j5Fdsmw/wjiq6U1YE+s/i5M
         dlBg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Noa Osherovich <noaos@mellanox.com>,
	Leon Romanovsky <leonro@mellanox.com>,
	Doug Ledford <dledford@redhat.com>
Subject: [PATCH 4.16 103/196] RDMA/mlx5: Protect from NULL pointer derefence
Date: Sun, 22 Apr 2018 15:52:03 +0200
Message-Id: <20180422135109.580023764@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455061180454798?=
X-GMAIL-MSGID: =?utf-8?q?1598455061180454798?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Leon Romanovsky <leonro@mellanox.com>

commit 4289861d88d6c7b5e4c8cc7fe2ad6cdf0cdfc366 upstream.

The mlx5_ib_alloc_implicit_mr() can fail to acquire pages
and the returned mr pointer won't be valid. Ensure that it
is not error prior to access.

Cc: <stable@vger.kernel.org> # 4.10
Fixes: 81713d3788d2 ("IB/mlx5: Add implicit MR support")
Reported-by: Noa Osherovich <noaos@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Doug Ledford <dledford@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/hw/mlx5/mr.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -1223,6 +1223,8 @@ struct ib_mr *mlx5_ib_reg_user_mr(struct
 			return ERR_PTR(-EINVAL);
 
 		mr = mlx5_ib_alloc_implicit_mr(to_mpd(pd), access_flags);
+		if (IS_ERR(mr))
+			return ERR_CAST(mr);
 		return &mr->ibmr;
 	}
 #endif
