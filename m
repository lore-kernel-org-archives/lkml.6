Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtB3nlWdYQ2r2c3wUwPibEABQWW+7FVmK37aeynAjdmh1O2CcEr26uU0/RfzlmgByL1Z081
ARC-Seal: i=1; a=rsa-sha256; t=1521798960; cv=none;
        d=google.com; s=arc-20160816;
        b=0GWLlwZWFZE9Hp8Z+rnHgfXL3N90dTRaRGJ0UB6GsPld1cID6zDxzdgJXnIgj4+G/s
         ounqQ0jAu9Z2/cjqR2N6aqgdiB/cdmXmdpWwwsUuTrIiHgMwaSxFjf+/y8/1rtvJuoQW
         b4G4wrPjLdk1HmY6ssSnz3jdmlh1QWgJrJW7MtRHkALL9V7M/1u6xZ+tiChScAX0lUd1
         GZfoeEFNSmBhGPzDMhs1UDu0XP99t3DlJfFwjp8jD+2ehR3T51xLSIfSXlLB8CpVf52t
         h01NcYZQ2dCSpPMd5FCOn+l6nBTEzL8Sv+k6EnC7bVX3tsJTVeMQodrZ6DXJWyIftKen
         Dxjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=h8AjTX0EFVXgnhYu6voj33oKAIkBUaxjtgKOOmC1bgE=;
        b=xV7k9UY1CuHPsJXGdfEbMXdOX5lkOCHTqOidBGQ9u3ObnmHtrhM1ukgaFrP/fPsqox
         WNjz/7oTXvvwumeYfQitsQeVgizMXSH6npEEYXwvMEbGL+vMszaHS+CxCRyH7zST3N8K
         6GUhzchgGsII3/yKdHlroPYjJ05LhMO67hfC1sVL33DJ27KvCUk6Nc2yjLwSmna+UtZO
         4OVyxCHZ3cGOJszvtuClT6Iw+6E4BrFze/8oK/+BniymDwLIeDzX2SmXGMRztKw4thLV
         0xd8/2J27rAWuZvPvccDRclCuLL5zT97wENDnzB/80KGwwZcJIZK7jv52RwACBvvtKfn
         PDAw==
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
Subject: [PATCH 4.15 11/84] RDMA/iwpm: Fix uninitialized error code in iwpm_send_mapinfo()
Date: Fri, 23 Mar 2018 10:53:25 +0100
Message-Id: <20180323095413.643275901@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323095411.913234798@linuxfoundation.org>
References: <20180323095411.913234798@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595721867135742160?=
X-GMAIL-MSGID: =?utf-8?q?1595721867135742160?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
