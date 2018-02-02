Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2270qQQJBCK1k1zf5nrg5KPHVmN3OqtCaqmjOIdJygvFaMU9fM9x5x8fSI3+PL4OZ7xkvmlx
ARC-Seal: i=1; a=rsa-sha256; t=1517591397; cv=none;
        d=google.com; s=arc-20160816;
        b=PewpZerovvwrLnjg/yRkRfEKaxAChfOfL8daR1kD3K6Q1mf7MbqN3GghLN0f8+4P4Y
         aIS4zJqiRRtKZxS3hzl5JKVhDIS3ynh+qbDBnRGG6dsap06r/6IiWm/DJ7w3lxTzg6+K
         DSq/GIDf1+SMa/zthgosPOgrtHqQdrV0mhBayYsU/Y9iTgnf+ytBecj+d3CKiFiKOutr
         UHcvMCwg6CEgaM6rYRpm9rczJ7NRPQsWI6ouZFvextn1e7xOeWn57rOgGZGvKfweW0Ag
         /VGRPSwKY87nVgbtmoGgUfKO+WdfxQu82oNZIyo81fX/tw41n83ltVN0stIGMkg6OB2W
         pPZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=X/EWyOMbDNpDN3pOiJXyH4jtHaQS2Vd8PKeBcNQVOp8=;
        b=tIdFy3nhF6b08L5KD8Of4cmDvdqsaDtjLoz7cAtD6MWxxOOc2Fd0y6/agET2529caI
         Jm5htpWpUlGmoqS4SeEZXr33B14NQaCpgJnGMcZK0atbAMoqsogpfbRqm/BNzwwcEFfv
         8TPNPR5E1n2LJD651K2MG11c1FSsw6JwG831ZKDROfi/aTsYeG3fv3QhT+Sy6BkO/GG4
         42lsWlZR3Dv/dqKqnRYgyri49f15FxX4W3SovS37hMIyUyUAWHFhHUo8H5zCmfWEMaAy
         4tT/XHxb82YwQllVmmnssjnejhp/wJ9DzU66NxUS1EN3p2aR80ZFKQc8fhzXoXfUIVP6
         E6sg==
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
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 064/156] drm/amdkfd: Fix SDMA oversubsription handling
Date: Fri,  2 Feb 2018 17:57:25 +0100
Message-Id: <20180202140843.187197082@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140840.242829545@linuxfoundation.org>
References: <20180202140840.242829545@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309437743981845?=
X-GMAIL-MSGID: =?utf-8?q?1591309917397531561?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Felix Kuehling <Felix.Kuehling@amd.com>


[ Upstream commit 8c946b8988acec785bcf67088b6bd0747f36d2d3 ]

SDMA only supports a fixed number of queues. HWS cannot handle
oversubscription.

Signed-off-by: shaoyun liu <shaoyun.liu@amd.com>
Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
Reviewed-by: Oded Gabbay <oded.gabbay@gmail.com>
Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c |   18 +++++++++++++++++
 1 file changed, 18 insertions(+)

--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -184,6 +184,24 @@ int pqm_create_queue(struct process_queu
 
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
