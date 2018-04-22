Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4893k7LZsSMnTRF6iyZYjFB/XyM5YGvSasQCCuWcNMnCC86RBWnpOSGp8wURJrSQvdZr9iV
ARC-Seal: i=1; a=rsa-sha256; t=1524406031; cv=none;
        d=google.com; s=arc-20160816;
        b=AGq4xKtLXjqIqfee4mqPPe+bLnB9wv/AWFftAKWFjBfmTRUVbfFers+blOszRSO/oQ
         76xdjMdu9F3Se3bLqO5kyBVGTL8eiHT2ToS4bps6UHAGML7GCAoC0+6Pb1aNAZAfx1rf
         0KEZsXj89fZZ3fMRxrFAVfbNwoFZ3V0yj6Z4W21HHOjC0fwEeFEyCD+lX85IfyDmRFer
         bRtBau3AkVhAe5m/lpYfZeMrPSm1NNvWr1/4FeWVGsyaXVkdx35wK7/lmUjOf1Eim2jz
         JOk7CCiEd+aR9NZmswakmRb9lblYLLXrzCSpYW5OyVzart1ZSMPya11i1J/cRTcbhnHH
         AEkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=wXD1Pfao/6F4AwY6qR3NnjkD/aDRFEbMTdKKvK9VbPs=;
        b=m1zWWGxNGJgDW1kzicnOMK3SpOww+VtYJCMkWk3m0eFjRqPK5cWZoYuE2HwMbVy4Gf
         GNN+tDDeV6FOta2k/tqLTivY2Cu8nG0JJms8l67csRqtmPeTJg1V6RQm8ifLYTRuDjqz
         wKPQgxinb/S+OSKkSL5J1imwN9wJ7uqIxbdNjG6woNvYHXMgJduQ+905dONhUxX5bXOe
         453atUOW0IZZShZkSD7TN2IXdf0yrOmF9sVJoYNY4jvzlE4AYKy+yhOuJ4FySpIPhuc0
         07/+dGnH/+GYajk9ZQYgqJAkO1ieSqhSm4OTSDBWZgolrR6idXpjVU43Jjbyj7AiEtbA
         BNSQ==
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
Subject: [PATCH 4.14 087/164] RDMA/mlx5: Protect from NULL pointer derefence
Date: Sun, 22 Apr 2018 15:52:34 +0200
Message-Id: <20180422135138.989701109@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135135.400265110@linuxfoundation.org>
References: <20180422135135.400265110@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455061180454798?=
X-GMAIL-MSGID: =?utf-8?q?1598455578835777368?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1220,6 +1220,8 @@ struct ib_mr *mlx5_ib_reg_user_mr(struct
 			return ERR_PTR(-EINVAL);
 
 		mr = mlx5_ib_alloc_implicit_mr(to_mpd(pd), access_flags);
+		if (IS_ERR(mr))
+			return ERR_CAST(mr);
 		return &mr->ibmr;
 	}
 #endif
