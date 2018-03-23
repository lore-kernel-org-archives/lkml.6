Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvC2pjA1Y/NfGcO7c+kRX5ysMOwAAwBG05cYaD0Ru8p5X5pgs+fWSU9EidwtfGpcsQfdHJi
ARC-Seal: i=1; a=rsa-sha256; t=1521799874; cv=none;
        d=google.com; s=arc-20160816;
        b=ACHCYRWzVXAIjp+7V6eXW1tKcvu84BiD7kC0s2IVTzVDsl5oQzj/INYkW7gj6ENSyj
         vzK72f79M6Rg5l/plcLLiXO+pcq9XfTtYFMF8zEy1blEi2UqWlb8GIvsCT0/99yN45OO
         3nsXNZqctz8UrrEiKHzLH0gx2yn329TIBLUgfVbNx23Tx0ZjEqtjF+ux/5CtXdEN6uHY
         CsnB92Gj3Gi19gk1EFexbQbibbVG8VWQNrY3yK4seQ5npAiDtPCM0BkpKNJxBUnZ+sve
         MO+pgCY5m7PnTjz1GHfgH4ODu3RL6vxE2sgJSopewyLJbo4JGfLzfaynVabfpDvgJDsm
         ulyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Y9V+upM4j+Tm7k2uCYOcJ6J09uucOZPFxiebnQpPUis=;
        b=h7U0A9CFcZeQQ8g3NqEck1zzogqvK0vXJ9Rz3RWGwePvW9txLvoDobmtBhcu/2MeLc
         HGFvHBCOV/k4ZIFTkKqDdL4jWU0aGtxnXcPnlve+Z/xXfvN7iuzl+aHUZcMsKx0ubxp4
         xozgh8gh6pWMmISUd2FdaQs8Alpf/dUYnbBOqiniLicVcDNTpKcI0bLeCs7dd+gGL+8h
         /rCVNY4jl2aku5OApIsarl2S/MSTVIBWEdM+Wal12dn1KJiliYVhw8UTNY+ZQwmnfDgr
         eqf091q8KLjbZG1Xw1rdCNkwnAG5FZNrYKFu5fBftaK/ShReZIEIJ7hKR30F1Mp7/II/
         lNWA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
	Jason Gunthorpe <jgg@mellanox.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 138/177] RDMA/iwpm: Fix uninitialized error code in iwpm_send_mapinfo()
Date: Fri, 23 Mar 2018 10:54:26 +0100
Message-Id: <20180323094211.304333706@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094205.090519271@linuxfoundation.org>
References: <20180323094205.090519271@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595721867135742160?=
X-GMAIL-MSGID: =?utf-8?q?1595722824627793162?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Geert Uytterhoeven <geert@linux-m68k.org>


[ Upstream commit 302d6424e4a293a5761997e6c9fc3dfb1e4c355f ]

With gcc-4.1.2:

    drivers/infiniband/core/iwpm_util.c: In function ‘iwpm_send_mapinfo’:
    drivers/infiniband/core/iwpm_util.c:647: warning: ‘ret’ may be used uninitialized in this function

Indeed, if nl_client is not found in any of the scanned has buckets, ret
will be used uninitialized.

Preinitialize ret to -EINVAL to fix this.

Fixes: 30dc5e63d6a5ad24 ("RDMA/core: Add support for iWARP Port Mapper user space service")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Reviewed-by: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/core/iwpm_util.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/infiniband/core/iwpm_util.c
+++ b/drivers/infiniband/core/iwpm_util.c
@@ -664,6 +664,7 @@ int iwpm_send_mapinfo(u8 nl_client, int
 	}
 	skb_num++;
 	spin_lock_irqsave(&iwpm_mapinfo_lock, flags);
+	ret = -EINVAL;
 	for (i = 0; i < IWPM_MAPINFO_HASH_SIZE; i++) {
 		hlist_for_each_entry(map_info, &iwpm_hash_bucket[i],
 				     hlist_node) {
