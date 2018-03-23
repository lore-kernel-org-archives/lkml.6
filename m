Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuSOyamyCRHubh3QXg2ShXiq1ATgpvLvKf4cF8k8I7C0IfggxFuiriDN+JiG51f2pmoog4j
ARC-Seal: i=1; a=rsa-sha256; t=1521799251; cv=none;
        d=google.com; s=arc-20160816;
        b=cbHcj1HpCLH6GlQKA3hHPYEJ+W45pODuZQ4y27RwEteM6vrzCVLQfEBxz8tX/2yTxt
         5K7ZYkOtx9bgSxozqIq2aqDWMry6RnNT0sWgLVmXvzIyU0GA1hTsMxrMXkcLdZNpod/x
         Yktq3Zjp+gEhmsnolZXNyHHsFOfvxj8E25TUDbMRrSn2LKgYMNSOJCxTmLzIwW64oUCz
         JSZ2Fqkb9TYiWE+aYGKewwi8s/P1byJ2Uuv2U2gYJRIPEaY8g96X9/2rBNCoVqe/UhCm
         UxO857R0QcXiWt8dE+u8W7PuPuG/raJ1LKrWUTsCpgjTb1RX+YecVk2zH5cOjuBjyHiP
         7G3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=8Ub7ymPfBqF5BI0krCLB16vf3tQ5rT02i8L9HRhIHmQ=;
        b=DdqzYFMCXOvKakJ/ZWrVoGfwXo60DNpyJGDTqwbv/mhwaRwoZ9fm9bvol0biWAivxE
         4fVWNxiImNxsJ8xDLTIJ63kndByjqiczoNies5s/azqtslTBDRMuOgn+MdE4QxdiYvJj
         6r8YFha80tdsrrkS/3/FWWHoD87W/Xdimgo/Z7IvR1B51WEFiwJxR+8D2c48tTmep+gV
         FIfLnyxLPlPJ0ekq4cUmJous8hSHJlSKII/b/rsOCae7/5Khlrv8SNfEw8CAK2cSmq8J
         XxABSpkYIK6VqI+ebDhe7/fgOdsHk6FkVN0p67UZQN18PVhe9GbB9ysCu3C5eb7PfIcm
         VpKw==
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
Subject: [PATCH 4.14 09/77] RDMA/iwpm: Fix uninitialized error code in iwpm_send_mapinfo()
Date: Fri, 23 Mar 2018 10:53:43 +0100
Message-Id: <20180323094142.828763080@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094142.260022880@linuxfoundation.org>
References: <20180323094142.260022880@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595721867135742160?=
X-GMAIL-MSGID: =?utf-8?q?1595722172107901976?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -654,6 +654,7 @@ int iwpm_send_mapinfo(u8 nl_client, int
 	}
 	skb_num++;
 	spin_lock_irqsave(&iwpm_mapinfo_lock, flags);
+	ret = -EINVAL;
 	for (i = 0; i < IWPM_MAPINFO_HASH_SIZE; i++) {
 		hlist_for_each_entry(map_info, &iwpm_hash_bucket[i],
 				     hlist_node) {
