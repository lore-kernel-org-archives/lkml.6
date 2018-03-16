Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtVV90bUSuChdCfA4/E8YMU1sZedSf+gI1sxUh0JLvF4EeWAHNHQ68Y0sXMvHKXUVgjj4z6
ARC-Seal: i=1; a=rsa-sha256; t=1521215093; cv=none;
        d=google.com; s=arc-20160816;
        b=o2REtIXaiAW/lGwiT76dVwifPlfICGKzloHRGF/bVPxhSO9ya27utHGe4g7M9Xanj1
         wlLelTDI7cZDdhr/mXHhWtw8336oIH1eEQSrJY3RtfnnLhM6pnQY06VksnFbJKyebn1z
         X9A5979MooxleKqlid/FSt280XIHx2oM06364/xnAjroCTSxmn4mPVg3q4+/ZPpjjaDr
         iStTik8PQnsY9vImRBjimBYPN43N/FwgWtHz5+K2M7AwYTrrJfP0fvXNHFFp4TEp9G+d
         p9PlA+AKWaHc0BBSY1xmyrQ1wp/eU1evejD5LyUsqO5CByBpQMTGkQpemdPl72YlCamw
         dj+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=c2lPHNpoojhHKtPQPLvR6Q9uSmY7A2YgMWzdVVaKdNg=;
        b=xBo+6UZ61pw5NHTle5yJU7THOhUaEXfK3Hmo8k8vVv8o/+NNhsk2mxVe4KajGov+L5
         rs/JiP2eFz0LnzR6ekVkQVGWBq71SSQvKSLsgF9p9PjzCOGSN2WEEyIuHl+1T3nVNmJd
         hlCn0LcvLV/Nrk/qluHRlIcScunAE1iqbMy1iEB/cxeOVmZCm+j8oKusXRS+aCcfgmOr
         FJej9RaY25atQn9wOJvg1MBMxUNY8nhqyXnskgFgxPgU0yHOQwQdxZJVhOq1FFCdzXP7
         8gYI/+B9W7hiy1UI+JNikKm5ICxvX3NNxAw4n8lVHNMpyHMl+GCFf8udPh7Rbs2BfINr
         KdZQ==
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
Subject: [PATCH 4.15 126/128] IB/mlx5: revisit -Wmaybe-uninitialized warning
Date: Fri, 16 Mar 2018 16:24:27 +0100
Message-Id: <20180316152342.717305290@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152336.199007505@linuxfoundation.org>
References: <20180316152336.199007505@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595109274281837049?=
X-GMAIL-MSGID: =?utf-8?q?1595109638457433270?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
 
