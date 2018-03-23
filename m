Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELs4CnqGawbRt8kgwkMaIThaC/A6fOOhDXp/H7Z8rIHhiXJNy6KBL1wopmuL7ShRIZDi7LXu
ARC-Seal: i=1; a=rsa-sha256; t=1521800245; cv=none;
        d=google.com; s=arc-20160816;
        b=fwyH9X4TrBrlhv04ruIlEL2xxoJhjsf9VGOmiYJ2YddvLNkbiHT+UdP5ad4jw2EVtz
         kG/sInpkTsmrOsdzkZjQeKkmcXII/jz+nXgr4e9KhaLfgWstNGAV/Pu1t55GEEwsKpGH
         MIrb4j8sXNGRZw0TcmCYwUcu8xBv/Cx9LhzPmeh4z+YbBeVds9Da4SzYOSDo51Lm/G5H
         hJ4VZDwgi0RSUIUmgSpVM9MfMzL6R/p0XGC+93F0lTE92CmS6X5CTydLXhj7XV1Mx2N5
         MhYLiVKv2CysqzH1691WtW1AXnmtFu5khRW1jlJz+uq54nu+THxXvkJsggRGuJ9WXwfT
         4g3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=zcVtOewfMzfpi3M6yZozydzrFl4D8SzeRBux2x306UQ=;
        b=BlFLDQvRHKX+St/q5R6+kMA5euOR6hbqnp8PzgUcVtd28Pty9hvpTqaPLWrEDy1+tE
         s6sQRVCHADAa5Gn4LPzGMbbrFuh0dz2TSMz4xsqGgEbZ6jnT9QLz2ggdwno2+JBhO5BZ
         2nW/ALQopGrZKvyEivJlHUrYmCvfYsv9OsP0T6tgOjOQ+INaIze/EX4RUPMZHtu/A2hO
         1LsTmQyesVXfjsCeysIC9PnOLfIICeCkIvLG0qOIrsmqW6i1Ey5kkmXsdSD5kUVJT74z
         H+bgRW5qTWL4odE+Yv+0J525k6wBPDDbkVI/EPmUePUeij1P4mVWCh6pGDC9JuucOVsP
         bNZw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Artemy Kovalyov <artemyko@mellanox.com>,
	Leon Romanovsky <leon@kernel.org>,
	Jason Gunthorpe <jgg@mellanox.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 85/97] IB/umem: Fix use of npages/nmap fields
Date: Fri, 23 Mar 2018 10:55:12 +0100
Message-Id: <20180323094202.264089737@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094157.535925724@linuxfoundation.org>
References: <20180323094157.535925724@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595721963671487333?=
X-GMAIL-MSGID: =?utf-8?q?1595723214686724764?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Artemy Kovalyov <artemyko@mellanox.com>


[ Upstream commit edf1a84fe37c51290e2c88154ecaf48dadff3d27 ]

In ib_umem structure npages holds original number of sg entries, while
nmap is number of DMA blocks returned by dma_map_sg.

Fixes: c5d76f130b28 ('IB/core: Add umem function to read data from user-space')
Signed-off-by: Artemy Kovalyov <artemyko@mellanox.com>
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/core/umem.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/infiniband/core/umem.c
+++ b/drivers/infiniband/core/umem.c
@@ -354,7 +354,7 @@ int ib_umem_copy_from(void *dst, struct
 		return -EINVAL;
 	}
 
-	ret = sg_pcopy_to_buffer(umem->sg_head.sgl, umem->nmap, dst, length,
+	ret = sg_pcopy_to_buffer(umem->sg_head.sgl, umem->npages, dst, length,
 				 offset + ib_umem_offset(umem));
 
 	if (ret < 0)
