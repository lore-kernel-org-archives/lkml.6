Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2263hRET3LzlvNpZ0rtqSTcGjuLshN/YosTDPPjfz4540oRm0L5gHrvXJ3WbxGmdkjUxTRai
ARC-Seal: i=1; a=rsa-sha256; t=1519410970; cv=none;
        d=google.com; s=arc-20160816;
        b=hKL4B1U1p6R7JB8JUFAUQjcLYTu3dCDrh4kiBkv3T31MPpviK2FesbadOYALxhK6i1
         m0fVHwg5pRJBhowWooeQBKHa+uAh3w3GxQQQ87ijJ6eNW8MkY7v1rOX5C7BoMx4WBgva
         H4i/TKrCoDxLaEqd4eRz9YJJGYNAEO+/xlw3AN4WJeJANTDmXH15Zt4+WiAyeGNa9kG7
         XpXbxQGwOglBU5iJR9HsZ/9z08iA4GwdtOGEHzZFBQU6sSHcxCuNrOagUd38oezZHZL2
         KDlbysezabFuwNLBafeyB24RCQanF+EXpAsxT3zsV5EbW8pbFP3OzTgjIB+gpXUbOITW
         KSOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=UOjWduX8ePEyODf9IkH1NKWPBDUB5NqjbGracGXKhiA=;
        b=FmK8o+LunulrN++UjDVA0PStNAY/p93xQJ4o55kEdihPod4spJpPm2gkZ4+lBVG923
         9WjXXsYK+BnuhShc0Btda4Vlb8p/nHY2MHl/4U+jFSZN6q2/3s5CJdp2sm5+ZFcBRzCs
         CPH5Bq5p+ficVohzcyRsSTlWzcD9sfBwOhDiUt/LyAswWHxFXCB6OyYzXhPt7vXF75gb
         30O7ZiAcbpHYSueTDeMlfZT8ynnJ9VRR/E2kytsaVlYxPl9fE8AhO8PQfseS0hmiyXkT
         WLjnW4qizQmrhSXyDTZnKAFVAmoTrYmQSrGEayDdKg8bE2DoJLLk6LmDzLocpsIVIEMV
         +Baw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Moni Shoua <monis@mellanox.com>,
	Mukesh Kacker <mukesh.kacker@oracle.com>,
	Daniel Jurgens <danielj@mellanox.com>,
	Parav Pandit <parav@mellanox.com>,
	Leon Romanovsky <leon@kernel.org>,
	Jason Gunthorpe <jgg@mellanox.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 039/193] RDMA/cma: Make sure that PSN is not over max allowed
Date: Fri, 23 Feb 2018 19:24:32 +0100
Message-Id: <20180223170332.162586532@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593217877707326403?=
X-GMAIL-MSGID: =?utf-8?q?1593217877707326403?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Moni Shoua <monis@mellanox.com>


[ Upstream commit 23a9cd2ad90543e9da3786878d2b2729c095439d ]

This patch limits the initial value for PSN to 24 bits as
spec requires.

Signed-off-by: Moni Shoua <monis@mellanox.com>
Signed-off-by: Mukesh Kacker <mukesh.kacker@oracle.com>
Signed-off-by: Daniel Jurgens <danielj@mellanox.com>
Reviewed-by: Parav Pandit <parav@mellanox.com>
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/core/cma.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -626,6 +626,7 @@ struct rdma_cm_id *rdma_create_id(struct
 	INIT_LIST_HEAD(&id_priv->mc_list);
 	get_random_bytes(&id_priv->seq_num, sizeof id_priv->seq_num);
 	id_priv->id.route.addr.dev_addr.net = get_net(net);
+	id_priv->seq_num &= 0x00ffffff;
 
 	return &id_priv->id;
 }
