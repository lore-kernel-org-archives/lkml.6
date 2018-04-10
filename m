Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+UQRprrjfkZ+YoDK8bI73BqiNn8oxQD8REM+tiTrsq9BMXR9VS3sLxU8QO/zTYOTSQKX/Q
ARC-Seal: i=1; a=rsa-sha256; t=1523399704; cv=none;
        d=google.com; s=arc-20160816;
        b=yaAJVXG24FbeCglnxOw4Lj0y5m0Vd0m6NRoy53nDz8l1wJ+5bFRQyojsXKDqCybTnG
         NoQTurT5TJXrJ3xgJwwZuSn6KJ5rSjfCp7hN5vSl17ULydgWOOwAjj+UIuAyUBieqX9v
         4fidiC+gTZ5FRG19rf282eKREebUUH77/o3MHrzTHesvGLDxirYXjOd6UYhrmahbxYib
         0RKavtknLhR0jmBuE0ehfeNr1SLOoUx25gpCeOLWafS6tEfIlJyP5APyKH07jhXv818d
         wIUi9qvLTTQKZPgvGL3tTAkkqRFvA0PhHsZlj8z52XJ0JFKxNiegJMRKCsvESHur1FPx
         XGBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=4uxZzGL3UKtDvBEu29e03rw+wjUJVvL1fOK0tJl9JE0=;
        b=mQb68DXqck0qpRY9H/WQlPt8kFLvii8xgA7KHrlOa8JYNw3ih26h6kttRclzG2iEOg
         2QZcnfrGLSIfxhnLhY6LI4QjC4UJnTs0qLAEbvn/Q1pUGrG8jwU+I3XNc5fpcgUZ88ZN
         dbz1OSFXs1MJYfRWwsTRWIJoodGrmz19ied0TeXvFo0yAcnFLt7D4cmPupRYK6ooiJPB
         Tu7T4zkEb+ZQr0x50ey7Rp61i2y3V3kV5wTWSVcO0AzTxVRpgcemuMVofR0VV+zav9eM
         8cd8IlZ1Sx5O7e6tDHSJiO9J6h/XmIyY2kzP6k/Opr8oX+e/e1dglw0H4U2cBDQdqruT
         OkPA==
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
Subject: [PATCH 4.14 003/138] i40iw: Validate correct IRD/ORD connection parameters
Date: Wed, 11 Apr 2018 00:23:13 +0200
Message-Id: <20180410212902.471577814@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212902.121524696@linuxfoundation.org>
References: <20180410212902.121524696@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597399804350146233?=
X-GMAIL-MSGID: =?utf-8?q?1597400368188323278?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -3841,7 +3842,7 @@ int i40iw_connect(struct iw_cm_id *cm_id
 	}
 
 	cm_node->apbvt_set = true;
-	i40iw_record_ird_ord(cm_node, (u16)conn_param->ird, (u16)conn_param->ord);
+	i40iw_record_ird_ord(cm_node, conn_param->ird, conn_param->ord);
 	if (cm_node->send_rdma0_op == SEND_RDMA_READ_ZERO &&
 	    !cm_node->ord_size)
 		cm_node->ord_size = 1;
