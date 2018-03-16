Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsRAI2ZbvhpeqddCM8Zy/opCFjTISlHfClNcjg+Gw2K/YLEs+t9n5evRbw76mpeFsR5YyXT
ARC-Seal: i=1; a=rsa-sha256; t=1521214746; cv=none;
        d=google.com; s=arc-20160816;
        b=ul9hQHIfl2rNsdFw9Tg0iKHoUJPtUbC0unYWeDb0ePynKrdFur8b60OUw3XmFn2Zly
         RwaDYj4epZdxlSoFtWwchKCw7rj1KqOqm/di1XOzMu1O1NmLgkEX3m+A0YDowBLkpI2X
         BkjajHxTwTs1inanG7lhOAOgYk4SDJES4xzQcp9P0XNxWscwFZU7wFy1xxa9gqxKxU6z
         VLovFeuPzmrhU9RHNTuBsxpwIarcOxdwiZNqIOeRYlB3TflyFBpM/b5dXMemCQ0IAPUW
         wellGVk/STTqbXWVFbGn7a8kuWff+ia495xW3CdRyo58E4dAD8oj/dIBgykZZigjoQsN
         eeFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=SJPB9NUFaimNdoOsc4wf+4vODhgP0Q1dYlVorfZh3dY=;
        b=D2ji/DucbPYFvN8HLQKwL0pRR91BOZ59UBAMIJHKTI83I+NbXXqTOegvyHCKnpX+Te
         CJSrt6FEa9R3xX1B+nDZT6sABOZKYgfJQFjZTYDuuodIzJwdY7J9Jt3Cs0/3BKAY1dVQ
         rHqRdMdVISXAT6qj/HhIEwIt0dSXaPHAjdQYahOheoAat7mcd3Jvqzn/ZcKpALx5h/H/
         wxljgZDMPSGuBIIADGqzOCkYzVagCtEtOPXiOJCFgxCy3tpEL57BeNfZ2eXM0CfqSt+h
         9RV3Jj+9xvaGICqRqI1dJhOnDgHX5YfwY/0piYSN6ft/L2WzhxI2KcbZCnRWi1Xhr8ia
         HDqw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Jason Gunthorpe <jgg@mellanox.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 107/109] IB/mlx5: revisit -Wmaybe-uninitialized warning
Date: Fri, 16 Mar 2018 16:24:16 +0100
Message-Id: <20180316152335.655237781@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152329.844663293@linuxfoundation.org>
References: <20180316152329.844663293@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595109274281837049?=
X-GMAIL-MSGID: =?utf-8?q?1595109274281837049?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>


[ Upstream commit 1b19b95169cd52fe82cd442fec0b279fe25cc838 ]

A warning that I thought I had fixed before occasionally comes
back in rare randconfig builds (I found 7 instances in the last
100000 builds, originally it was much more frequent):

drivers/infiniband/hw/mlx5/mr.c: In function 'mlx5_ib_reg_user_mr':
drivers/infiniband/hw/mlx5/mr.c:1229:5: error: 'order' may be used uninitialized in this function [-Werror=maybe-uninitialized]
  if (order <= mr_cache_max_order(dev)) {
     ^
drivers/infiniband/hw/mlx5/mr.c:1247:8: error: 'ncont' may be used uninitialized in this function [-Werror=maybe-uninitialized]
drivers/infiniband/hw/mlx5/mr.c:1247:8: error: 'page_shift' may be used uninitialized in this function [-Werror=maybe-uninitialized]
drivers/infiniband/hw/mlx5/mr.c:1260:2: error: 'npages' may be used uninitialized in this function [-Werror=maybe-uninitialized]

I've looked at all those findings again and noticed that they are all
with CONFIG_INFINIBAND_USER_MEM=n, which means ib_umem_get() returns
an error unconditionally and we never initialize or use those variables.
This triggers a condition in gcc iff mr_umem_get() is partially but not
entirely inlined, which in turn depends on the exact combination of
optimization settings. This is a known problem with gcc, with no
easy solution in the compiler, so this adds another workaround that
should be more reliable than my previous attempt.

Returning an error from mlx5_ib_reg_user_mr() earlier means that we
can completely bypass the logic that caused the warning, the compiler
can now see that the variable is never accessed.

Fixes: 14ab8896f5d9 ("IB/mlx5: avoid bogus -Wmaybe-uninitialized warning")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/hw/mlx5/mr.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -1206,6 +1206,9 @@ struct ib_mr *mlx5_ib_reg_user_mr(struct
 	int err;
 	bool use_umr = true;
 
+	if (!IS_ENABLED(CONFIG_INFINIBAND_USER_MEM))
+		return ERR_PTR(-EINVAL);
+
 	mlx5_ib_dbg(dev, "start 0x%llx, virt_addr 0x%llx, length 0x%llx, access_flags 0x%x\n",
 		    start, virt_addr, length, access_flags);
 
