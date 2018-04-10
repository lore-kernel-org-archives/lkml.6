Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4899rTtuJ8Nz4Q+mJRrPLI+r90388S9FtqghUZ333bLIcCljeq/KP6bNlmgA8NE4sGbLBNL
ARC-Seal: i=1; a=rsa-sha256; t=1523399858; cv=none;
        d=google.com; s=arc-20160816;
        b=zQKzBN6ZwvX1vZNtEsbed+8ZdQ6VnNnf2hEGYYoWgr7V5JNeYazIfk6BQRboa2TXh5
         k0dOV7c1Fk2qXdXDKmnqrTXZN0Ot6PJ7BYVYypKpALxD/COEZZ09k1nb5h/oT8pEIE9i
         hGlnZJJRVJNVTelvVeyvQR+J6IWkHlrH3+3mQ5r5ydILRpK8ERESuQZdQ/3I6SgD9H36
         aPHqXC2V8q1K/T4m0QfwYfmnTcAoeYbIuNRKgVKRvPBkLfYSbxB9r2e4X3/KScm9ORSp
         KP4hkeUA+hy7XlL8XkCZPRDHaYlUdEiNocFGBZDj5B7ytUrw9kZ3G5AHZ/YIOhj8aM1p
         jQ7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=63hQkanNs38MSIhZjxEsdY84QusNfoBaodugVPhIh2I=;
        b=tUUHWLqP/Vlxxq2oy1BIJBf8ISwmN0xhXGAao0OJ5659UV0ML4pshmzDeCr7Ec7tII
         EM6wyIc8LfX09N1DRycb+kED76mYMoKnyEbGHR2H5cXkNABqHnb3+x+Zr+z3vJnuu/Ue
         GEuDybFH90Um1aJBh0ve4CaeLRPp6oayKRdEbL8XAYOZ69DTdYnUI64y8+5lHL6+QZ67
         ioIAx9J7YwHrl0Q/HU+MbvyLmi/ePF5wTHEx1gqjkl+PYLKTi7LpCygH4Ess+7g5W3B/
         gtxmr0VBcPnvmETtzYvKzJZouD8juubj00N2ZgHPUOEDC2Cl40cDUsuVu7Hoc42+HOzT
         mPAA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Parav Pandit <parav@mellanox.com>,
	Mark Bloch <markb@mellanox.com>,
	Leon Romanovsky <leon@kernel.org>,
	Jason Gunthorpe <jgg@mellanox.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 072/138] RDMA/cma: Fix rdma_cm path querying for RoCE
Date: Wed, 11 Apr 2018 00:24:22 +0200
Message-Id: <20180410212910.495781141@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212902.121524696@linuxfoundation.org>
References: <20180410212902.121524696@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597400108734073947?=
X-GMAIL-MSGID: =?utf-8?q?1597400529923049980?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Parav Pandit <parav@mellanox.com>


[ Upstream commit 89838118a515847d3e5c904d2e022779a7173bec ]

The 'if' logic in ucma_query_path was broken with OPA was introduced
and started to treat RoCE paths as as OPA paths. Invert the logic
of the 'if' so only OPA paths are treated as OPA paths.

Otherwise the path records returned to rdma_cma users are mangled
when in RoCE mode.

Fixes: 57520751445b ("IB/SA: Add OPA path record type")
Signed-off-by: Parav Pandit <parav@mellanox.com>
Reviewed-by: Mark Bloch <markb@mellanox.com>
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/core/ucma.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- a/drivers/infiniband/core/ucma.c
+++ b/drivers/infiniband/core/ucma.c
@@ -914,13 +914,14 @@ static ssize_t ucma_query_path(struct uc
 
 		resp->path_data[i].flags = IB_PATH_GMP | IB_PATH_PRIMARY |
 					   IB_PATH_BIDIRECTIONAL;
-		if (rec->rec_type == SA_PATH_REC_TYPE_IB) {
-			ib_sa_pack_path(rec, &resp->path_data[i].path_rec);
-		} else {
+		if (rec->rec_type == SA_PATH_REC_TYPE_OPA) {
 			struct sa_path_rec ib;
 
 			sa_convert_path_opa_to_ib(&ib, rec);
 			ib_sa_pack_path(&ib, &resp->path_data[i].path_rec);
+
+		} else {
+			ib_sa_pack_path(rec, &resp->path_data[i].path_rec);
 		}
 	}
 
