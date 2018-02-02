Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226/izMTnQXFwfT7P5YpHnlH9aDwa+o2Kog+LPiQKK/4n0NcnFiV7aS5TJl0QnVGZRghrbDz
ARC-Seal: i=1; a=rsa-sha256; t=1517591041; cv=none;
        d=google.com; s=arc-20160816;
        b=GQtsYZ5gb5Ca/YN3ul44HKhUsMyMLf8+7a+DfYOdpUmiz+bknwPX9H6UWCphRA+rsD
         Pf6FeD/LL8oUqYRueMi3Nix1rsSp0PWZTrpcO9M4wVIo+7kQfMJIa1UdhZ3pgc8Pkbsc
         jTEzcMpQpPKV0zqjy8J/sH4H47szC0QPa6jzpGFTsB/IhxAQGyWZ81d73Kk2EwA4K4w9
         n/XBFr/xHo5Eqqq7JrsPrwU3cMwjmWJ5CVPImLNbfy1617J89G3zVhTqkAS1j4dMTkR4
         NDQOKbQWU6QUwHMS/3DWyVZFPuiS2Im+r8H+BIo5YKHnCrTUCuIest94MZIrMGKM1Pq1
         QoNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=kRFKkvY3ne7zdefsjKQCbshrFyOhQYrz1ONv8RK7Kkk=;
        b=rBW0mRgygOtxbKJJhndH8R5DY9Y32OY8stoI44iGHgLjgfa7kL0LTpw0bjwu1RqUrR
         z8+9SUZ/luiq88u0nYgIeHked4TuXi430WLiSuBQQbOWD6X4LJJk8vZ0PNOuEPEFfnQj
         GUozKNjrU44Bp27Eyi+NIZ2xSyfBUfDp3Kmefb6eVMEcLquhgnfIuYAqau86QaUEsfMR
         tNeMfArVzFpEULIAx8mjcLl1iFKFddjjc6F4lIxRqq/amAceYCj7m1yz2GRoiY4op7Zu
         YI5mbOTdvuz9Ai9rB9FRwS6SIz2h5YhdsL99RgyB7zdiEILlmFwxs5KovNua9GJCuSVr
         Q48A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	shaoyun liu <shaoyun.liu@amd.com>,
	Felix Kuehling <Felix.Kuehling@amd.com>,
	Oded Gabbay <oded.gabbay@gmail.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 31/86] drm/amdkfd: Fix SDMA oversubsription handling
Date: Fri,  2 Feb 2018 17:57:51 +0100
Message-Id: <20180202140825.428756966@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140822.679101338@linuxfoundation.org>
References: <20180202140822.679101338@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309437743981845?=
X-GMAIL-MSGID: =?utf-8?q?1591309544295343691?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Felix Kuehling <Felix.Kuehling@amd.com>


[ Upstream commit 8c946b8988acec785bcf67088b6bd0747f36d2d3 ]

SDMA only supports a fixed number of queues. HWS cannot handle
oversubscription.

Signed-off-by: shaoyun liu <shaoyun.liu@amd.com>
Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
Reviewed-by: Oded Gabbay <oded.gabbay@gmail.com>
Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c |   18 +++++++++++++++++
 1 file changed, 18 insertions(+)

--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -205,6 +205,24 @@ int pqm_create_queue(struct process_queu
 
 	switch (type) {
 	case KFD_QUEUE_TYPE_SDMA:
+		if (dev->dqm->queue_count >=
+			CIK_SDMA_QUEUES_PER_ENGINE * CIK_SDMA_ENGINE_NUM) {
+			pr_err("Over-subscription is not allowed for SDMA.\n");
+			retval = -EPERM;
+			goto err_create_queue;
+		}
+
+		retval = create_cp_queue(pqm, dev, &q, properties, f, *qid);
+		if (retval != 0)
+			goto err_create_queue;
+		pqn->q = q;
+		pqn->kq = NULL;
+		retval = dev->dqm->ops.create_queue(dev->dqm, q, &pdd->qpd,
+						&q->properties.vmid);
+		pr_debug("DQM returned %d for create_queue\n", retval);
+		print_queue(q);
+		break;
+
 	case KFD_QUEUE_TYPE_COMPUTE:
 		/* check if there is over subscription */
 		if ((sched_policy == KFD_SCHED_POLICY_HWS_NO_OVERSUBSCRIPTION) &&
