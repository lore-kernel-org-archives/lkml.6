Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224RpVNE9PzQeSPaxGHwhHoIh+vvwWj/kCurfTPmLVhG2iGqF9sGZvB9uWrvVw2ynT3UFxVW
ARC-Seal: i=1; a=rsa-sha256; t=1517590940; cv=none;
        d=google.com; s=arc-20160816;
        b=0+fedKG4+71RKeiNtpvqamZPU05pXuVya5Z8+GTavRgrbJLqmFnNoLGIeq/GsQYRsY
         vfJeLpNEc5BikI+31m9GG9xQO6axRvFg4xAx+bLn3VBWmphSRzYmVPHchFQVhiT061FE
         5l8DNpF9GPVRR30v0D7kjcnaAL2aLLv0sMT3zbMWQYCC2LGqPwEe8X0C+6J4SaWTio98
         8ylDvLqNixdYLMOsT7GIM7wnOW261wjmYp+ZLzId7gOcJ9vkaSbC/6+ERXhQHWe4k3a6
         kyGhDhWWwX4+sb7FZQ7qv8R/FAA5Bc4V7hsJO8Qo4qF2C9xqlf9YzffPBM4jwF1iq/GM
         ENiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=JIj7g/cSUXY8YZDVGsVZk/QDjlVg/TZPnPLdCHOWibQ=;
        b=l34TYWhOQGKLhj8MZnWZO2LvD1WEmucQxMCXq3lI3DCCRQ2lKXpZPIGvDORk04pGwO
         AMvUZrO7s4erngupON7cMpyuDgKQN2tlwBNMz+WJTzDsRqauxwlTVMrdER1bJd6q6RRX
         tgl00tDTtvyEBumEHlUr7lBdf4tax37oyo9/0eM2BipxFYoXRyk2oM3k9sxggbAtrF1k
         mYFs8iR1ektjzSmeJTRk465qtS0NotU016UTvO6ZEGIPLi603PUQrOeW+uWk1n0HUrbD
         8WxodVpTZ2GzhfWVZ4QPVIY0Z2tR94SQrTnatc4x/hL/dJIAfJbQ+fQlc939V+UM+hna
         lQLw==
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
Subject: [PATCH 4.4 32/67] drm/amdkfd: Fix SDMA oversubsription handling
Date: Fri,  2 Feb 2018 17:58:01 +0100
Message-Id: <20180202140819.157522461@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140815.091718203@linuxfoundation.org>
References: <20180202140815.091718203@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309437743981845?=
X-GMAIL-MSGID: =?utf-8?q?1591309437743981845?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
