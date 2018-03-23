Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvtDSBjxQDsKjZi1Td5cqArO+FjGW0e7EQVNfYhpGu/7LjMc7PBseq3N9hLhn4mb/phh+7L
ARC-Seal: i=1; a=rsa-sha256; t=1521800178; cv=none;
        d=google.com; s=arc-20160816;
        b=mdFFB8of5y7Nz54URnkA+TiSGwN17gH87cLCwbvDMN1qtcO0vPEeuz+9dtoXCj/xgz
         0pjPtNw4ojq815LU4YC+67BY4Jc0nYc3Aff8LAiqT7dt59bjewvor6siaWh8B6NZJlNd
         72FpZ6AarJxabTRmQO1OkwNo4snCau6+AVmhLl5TdeoOJDrf9h7YgDHV3pVV2x7VQ+WO
         cnRL0mz4d5Eco1SseQ2eao0mrjjmj7U/vXApT1fWZLRWILvM4GchjLkpb6qFoH6WsZ9P
         uIwrivUe6+s6yLPxBxr7RY+I6EYvGDEXyxgu16V7QozucsWojpQLnUlg8ke/9Oa9oXCC
         /l0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=9jj03mo7AZBUKnlFQ4rzUyAWiXXVHBwlFIDJto3orAM=;
        b=ne4YLUGs0bYadib8TMR6jwSnhigu2X1SiGChns9HQwLEsQjMLGElVMu5BsAFBJwRfy
         0LmuOTjfdXwH4km4NkNjBt3L2rmtZK6c05lbn4qJS/eZcspW+lCs/7vux7lGG54Vt0pI
         bEAEPY6ihuk8yy5kaChyJgoIISQfucqMiNNJSCymCHi9WXBmTbL/VaoeE1IwIaEaveOa
         mqwKyHC/0q2lOoYC1MYLmRWw09u8FqMpKy01VStn+4qW2CKyhWE7CyiGGo9AGTQr8f7Q
         iQwRN1acWiExfqvWBSTNrOPKIKJBtYxWpQ27jRXD1XAAYUYx5g9qegZ2AXGqW6arKLsC
         +oRg==
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
Subject: [PATCH 4.4 76/97] RDMA/iwpm: Fix uninitialized error code in iwpm_send_mapinfo()
Date: Fri, 23 Mar 2018 10:55:03 +0100
Message-Id: <20180323094201.832652287@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094157.535925724@linuxfoundation.org>
References: <20180323094157.535925724@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595721867135742160?=
X-GMAIL-MSGID: =?utf-8?q?1595723144147158720?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -663,6 +663,7 @@ int iwpm_send_mapinfo(u8 nl_client, int
 	}
 	skb_num++;
 	spin_lock_irqsave(&iwpm_mapinfo_lock, flags);
+	ret = -EINVAL;
 	for (i = 0; i < IWPM_MAPINFO_HASH_SIZE; i++) {
 		hlist_for_each_entry(map_info, &iwpm_hash_bucket[i],
 				     hlist_node) {
