Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+ctp74kvXsmXg/xI+JT2aLeinZ/ApMtjROsmXCFTCT2E6y5Oa/w+2ds5YtVlMQVZhtvMw8
ARC-Seal: i=1; a=rsa-sha256; t=1523399165; cv=none;
        d=google.com; s=arc-20160816;
        b=y4BmMYeUPkxfzz8gQuSNiFPNdzhcdd3gK07f1RUMj17qcsNNEOpz68DNIEyPMaPbjb
         UQXR04JhLjo2Lwu7jcLRE3lY4p2uZRl3zxqia9Q1MD1YPyPc8Jh2dghgItHGckTL4w18
         fFR4ksRsUV41QfsE99QC6BX4WpwZi1KbLSxov0ZoypeYr6rqRyt4UqFoNIGPKbscS+/s
         u4m8zkTC7CpaHjvCAly67AsXAZCpOz3C+O59ufwgFb7EH81zJC2mx9MW+Sb4Af7xcf4f
         QO94a6eldjVn/8FKOwRzA8Ozggp6M0JyF3hYd4TpBVx7HUZ7mCe8hmLZtaNkGwW9YD+P
         cJGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=x1Z6LvZBUksDknGWv+/jMGFoPM8RbwFg2CKjMhGTskQ=;
        b=BXicl1BAjQnqMARWbGINlXTfoYQyVo/9iQTN20hp8Xod9PR1iJ+u8WPur9LMYCqG9I
         aaA7BkznOVjlCrJtxAnomi/7RmVMYJrsbrXhUTLwfHYhphzKBZ0lGHo6RmVSmUHlA61v
         oaXD5KGzuLAHbq8f6RrLVkScugnbF3iAh1XTW5ixRG+ZhfRUmbiooex+fcSpRz8gbz/w
         BsBHY8fZwAgArwN/YfCgf68lueY0+baLcOIzAc4s2XyVeawAbTuToP7bUYggZdKAAxpn
         KIrqMAb+rnai2ltuMERW9VV/9ijR4mFInScRpdf7338FaW+rwqiSoMvCAo9CCOYkoZse
         EzyA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
	Shiraz Saleem <shiraz.saleem@intel.com>,
	Jason Gunthorpe <jgg@mellanox.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 003/168] i40iw: Validate correct IRD/ORD connection parameters
Date: Wed, 11 Apr 2018 00:22:25 +0200
Message-Id: <20180410212800.327539566@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212800.144079021@linuxfoundation.org>
References: <20180410212800.144079021@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597399804350146233?=
X-GMAIL-MSGID: =?utf-8?q?1597399804350146233?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tatyana Nikolova <tatyana.e.nikolova@intel.com>


[ Upstream commit ce9ce74145aa6814a370a9ff4f5a1d719baaced1 ]

Casting to u16 before validating IRD/ORD connection
parameters could cause recording wrong IRD/ORD values
in the cm_node. Validate the IRD/ORD parameters as
they are passed by the application before recording
them.

Fixes: f27b4746f378 ("i40iw: add connection management code")
Signed-off-by: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/hw/i40iw/i40iw_cm.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/drivers/infiniband/hw/i40iw/i40iw_cm.c
+++ b/drivers/infiniband/hw/i40iw/i40iw_cm.c
@@ -125,7 +125,8 @@ static u8 i40iw_derive_hw_ird_setting(u1
  * @conn_ird: connection IRD
  * @conn_ord: connection ORD
  */
-static void i40iw_record_ird_ord(struct i40iw_cm_node *cm_node, u16 conn_ird, u16 conn_ord)
+static void i40iw_record_ird_ord(struct i40iw_cm_node *cm_node, u32 conn_ird,
+				 u32 conn_ord)
 {
 	if (conn_ird > I40IW_MAX_IRD_SIZE)
 		conn_ird = I40IW_MAX_IRD_SIZE;
@@ -3849,7 +3850,7 @@ int i40iw_connect(struct iw_cm_id *cm_id
 	}
 
 	cm_node->apbvt_set = true;
-	i40iw_record_ird_ord(cm_node, (u16)conn_param->ird, (u16)conn_param->ord);
+	i40iw_record_ird_ord(cm_node, conn_param->ird, conn_param->ord);
 	if (cm_node->send_rdma0_op == SEND_RDMA_READ_ZERO &&
 	    !cm_node->ord_size)
 		cm_node->ord_size = 1;
