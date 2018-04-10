Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48E5610wsAdCTSw/TRhbJ0PyepLwGJZJaeoUs9IDfFy+dPEkNeOL+YO+QVH/XxbQHseTYQT
ARC-Seal: i=1; a=rsa-sha256; t=1523399632; cv=none;
        d=google.com; s=arc-20160816;
        b=uFdNetSDTyAzZaaR6CVjaOwRCQ18x569jlStA71ru2/RkE3o+GluA9MQiBr0n0E89B
         gJgia5JcBf0V4hqjPHCY1BRJk7JYTDyUY08xMdetO43sFdIw1KdpGzX35O8hZ0sb/igq
         P7qOzGW13HzRKvjqztyRbpx5C1hUmMiDZgUHb9SGmlr2/I5EaVdPSegY4BDITFioyYUQ
         o4I8Ywn+o8bC+Z8JGaUtPBhv0YMCZ/zXqnQUtlyp38SRD1vOlQ9/QDkjpei+/q55MLyd
         dPtvc8PJAXWp4gf9vQk+euW6towQkzoDDj729O7V2WL4h9plRMY8y7XAtQYjWxG/k+KI
         rM5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=6RmVIAweZhH9uPgsknS6DH4T6HxtW1DSZ/S8JDTSmDY=;
        b=FflbRm7EX15JewPfd/Tv3k2oFSiKZorq2ClbpXrbJKX4woltbaXvdZ1AAdHm+Bsx3S
         ycXZNa2JYE2rKWBgS4+eT32iK3kk4/iu01aJOSAkntX9ObgHfRB4XaF4D8jNt0XgIwwI
         m8EZ6r91pPfPJPH1UpCkvAA/0O8eUdUPECmXut3Vd6PWfQY9zQ13OwH+YtMh+R+oKGfn
         j7+F0UUSMRfZAlJFkFGHItZHShNA3Y+Pg4J5r+h/cJ1jVqrT5ITTiCa/TeQyVZgXhXLT
         1or8rmFs8qcwXvlfrMOlQyL5lqWu/3GMkgyog6nFPF8YJjX1OtJhayfa2eq2hfNl05vq
         HQZw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Shiraz Saleem <shiraz.saleem@intel.com>,
	Jason Gunthorpe <jgg@mellanox.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 001/138] i40iw: Fix sequence number for the first partial FPDU
Date: Wed, 11 Apr 2018 00:23:11 +0200
Message-Id: <20180410212902.284736406@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212902.121524696@linuxfoundation.org>
References: <20180410212902.121524696@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597399796931292081?=
X-GMAIL-MSGID: =?utf-8?q?1597400293061675611?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shiraz Saleem <shiraz.saleem@intel.com>


[ Upstream commit df8b13a1b23356d01dfc4647a5629cdb0f4ce566 ]

Partial FPDU processing is broken as the sequence number
for the first partial FPDU is wrong due to incorrect
Q2 buffer offset. The offset should be 64 rather than 16.

Fixes: 786c6adb3a94 ("i40iw: add puda code")
Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/hw/i40iw/i40iw_d.h    |    1 +
 drivers/infiniband/hw/i40iw/i40iw_puda.c |    2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/infiniband/hw/i40iw/i40iw_d.h
+++ b/drivers/infiniband/hw/i40iw/i40iw_d.h
@@ -93,6 +93,7 @@
 #define RDMA_OPCODE_MASK        0x0f
 #define RDMA_READ_REQ_OPCODE    1
 #define Q2_BAD_FRAME_OFFSET     72
+#define Q2_FPSN_OFFSET          64
 #define CQE_MAJOR_DRV           0x8000
 
 #define I40IW_TERM_SENT 0x01
--- a/drivers/infiniband/hw/i40iw/i40iw_puda.c
+++ b/drivers/infiniband/hw/i40iw/i40iw_puda.c
@@ -1376,7 +1376,7 @@ static void i40iw_ieq_handle_exception(s
 	u32 *hw_host_ctx = (u32 *)qp->hw_host_ctx;
 	u32 rcv_wnd = hw_host_ctx[23];
 	/* first partial seq # in q2 */
-	u32 fps = qp->q2_buf[16];
+	u32 fps = *(u32 *)(qp->q2_buf + Q2_FPSN_OFFSET);
 	struct list_head *rxlist = &pfpdu->rxlist;
 	struct list_head *plist;
 
