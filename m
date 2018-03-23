Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELugVuELq+mXUVJDHz5Iwy24lLA5huadyoRmDKik4SnwnqBeZ8E/9lNlBdSR9aaO/EfVnedJ
ARC-Seal: i=1; a=rsa-sha256; t=1521800243; cv=none;
        d=google.com; s=arc-20160816;
        b=wlbeLo2wFaLU1Sv0/OIsU/H1jJxiXjZ9nAOTNLRNJEgDsAbp63eQ9b2gFzpq7wgNwo
         wuHEnKLu60UfZi/fLtdSO40IL/Wth9kr+B8nFmXiHIB0UccAAzSYKGSbQoqyafqhNGQ0
         4uyxFCQkrDfSE4Dv9eVFJCxW0V1oIljJR5+JDmukZQuTSMS/V89X96n3Qem6Q01bjnhe
         ZcAJRHW5WA5l2wlmXklw5zg+LiXSahsilfnBELXl2fLq/SD1GsMKF1giMse3yoonQyS9
         9riQXWJdl2TXV38pm8RuSYaFbuCAK2DfxPMwt88qauZvtm5TY/Zkwvl1IEWGZeODLOD4
         XbCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=nVNapHmOuAWxPt5wkKQ5hYuweRGlxrQRad0AeQ/dSsw=;
        b=0KWmXl9q0VAQJIr7TlqA9J0GVWBeGuYQt3bPtO9SRanRWSKdHHOPXs7R8fycnACcIS
         585Njlpekg8S5O4L/PoabgAr329tfQlkwO+9mw8yr7Fs/DW03J5fKZv9xQGfIK8DyTTa
         NOG39MMVSdVonAe4VO2/c6DgaJPPolsYl9tcoyIQVgHmFUCDzJ2jTfKFSO13tpwRa1wd
         cvI3JEVUBNLoTXUdA3eRyxuqpanRHQvVNJotkGP7Cbh+ce7sIPlrNHJA89NyV8ob+P5b
         ruHCii/lJlDZaCsJ54ZKcXeDcg++qofCtE9msXewvdXC+tzSMhxZYYHBEAwCNHBWKrdl
         Tpzw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Parav Pandit <parav@mellanox.com>,
	Daniel Jurgens <danielj@mellanox.com>,
	Leon Romanovsky <leon@kernel.org>,
	Jason Gunthorpe <jgg@mellanox.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 84/97] RDMA/cma: Use correct size when writing netlink stats
Date: Fri, 23 Mar 2018 10:55:11 +0100
Message-Id: <20180323094202.218451631@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094157.535925724@linuxfoundation.org>
References: <20180323094157.535925724@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595722010857190263?=
X-GMAIL-MSGID: =?utf-8?q?1595723211652536463?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Parav Pandit <parav@mellanox.com>


[ Upstream commit 7baaa49af3716fb31877c61f59b74d029ce15b75 ]

The code was using the src size when formatting the dst. They are almost
certainly the same value but it reads wrong.

Fixes: ce117ffac2e9 ("RDMA/cma: Export AF_IB statistics")
Signed-off-by: Parav Pandit <parav@mellanox.com>
Reviewed-by: Daniel Jurgens <danielj@mellanox.com>
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/core/cma.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -4007,7 +4007,7 @@ static int cma_get_id_stats(struct sk_bu
 					  RDMA_NL_RDMA_CM_ATTR_SRC_ADDR))
 				goto out;
 			if (ibnl_put_attr(skb, nlh,
-					  rdma_addr_size(cma_src_addr(id_priv)),
+					  rdma_addr_size(cma_dst_addr(id_priv)),
 					  cma_dst_addr(id_priv),
 					  RDMA_NL_RDMA_CM_ATTR_DST_ADDR))
 				goto out;
