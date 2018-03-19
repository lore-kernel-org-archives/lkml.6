Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtnHMeUHdrauaApRhgeEPa3iBqFyMhGkH1vWrp5QZaoDMSAKJ2anmrCG3p9ssjyLcN0myO8
ARC-Seal: i=1; a=rsa-sha256; t=1521483695; cv=none;
        d=google.com; s=arc-20160816;
        b=AN9GXvjziJGAFo2oSDmL/oRpfd/fW58Izb5MMbOyhbsuvokIe/QF2s4OQw+IydAvRC
         XMhs+jZlGnNi52Td3B2NAXH4YcHqKmxO+BicEI7HYKKiQEZ0ISJNKIU3MVnvEU/69JOT
         2sCcaWZERNgd9PDxrvx76j2W+dUDrxqiatM3RSLZrRVIi2CWCrapqzwXAmAAwlfmMnSJ
         zTdMr1+dxqxwlNrQuCZfMmoqanq0PtRZGioDKBzFBTTA/aMmaHI6fGYzxZpFPWQU+vSu
         4naZd1zN0Bds3/nLHrAPRwkpQNtgU0r1XmJcQE2dNcs91YtRd/c6xcKEGFgDtNunDfe1
         BBDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=RJiZ5QV9XF03gno7MiAq5x5NCekwUbhCnniF2gMMHBI=;
        b=gL0hECk6lJWQofw21m8Uh+aIwZCCElZFIbdH9SMrZBthurQuaguCJ2OnseMz/jJlqh
         WlhZwWKdC2ZmfqyPY2q6IOPQh7SDs6be9G7kQHTL19IoFLAr2s5JrA/9Bboq3UvkFt+2
         cVrEWCBQZOXI8J3yLTiJCCY4cfDUXlrfsHU4XgJ4N6EX545ratTZ9hbpdpuENjchPjQi
         urZ5Xt1sdxlo0qrYswW5Hz02nzMQm+A4Z4Pyx4PeykOqeEorEoYmnTEtTaNVxz8Dm/vy
         eAWFPL9u0fiAK8kYJkgZKFkV+qTjzn7vG6doHrWbp+1LYmJ6lpkkeOF8iWQqTJBMFUik
         iskQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	zhoucm1 <david1.zhou@amd.com>,
	=?UTF-8?q?Nicolai=20H=C3=A4hnle?= <nicolai.haehnle@amd.com>,
	Samuel Pitoiset <samuel.pitoiset@gmail.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 083/241] drm/ttm: never add BO that failed to validate to the LRU list
Date: Mon, 19 Mar 2018 19:05:48 +0100
Message-Id: <20180319180754.634525827@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595391288087740628?=
X-GMAIL-MSGID: =?utf-8?q?1595391288087740628?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "Nicolai H�hnle" <nicolai.haehnle@amd.com>


[ Upstream commit c2c139cf435b18939204800fa72c53a7207bdd68 ]

Fixes a potential race condition in amdgpu that looks as follows:

Task 1: attempt ttm_bo_init, but ttm_bo_validate fails
Task 1: add BO to global list anyway
Task 2: grabs hold of the BO, waits on its reservation lock
Task 1: releases its reference of the BO; never gives up the
        reservation lock

The patch "drm/amdgpu: fix a potential deadlock in
amdgpu_bo_create_restricted()" attempts to fix that by releasing
the reservation lock in amdgpu code; unfortunately, it introduces
a use-after-free when this race _doesn't_ happen.

This patch should fix the race properly by never adding the BO
to the global list in the first place.

Cc: zhoucm1 <david1.zhou@amd.com>
Signed-off-by: Nicolai Hähnle <nicolai.haehnle@amd.com>
Tested-by: Samuel Pitoiset <samuel.pitoiset@gmail.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/ttm/ttm_bo.c |   12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

--- a/drivers/gpu/drm/ttm/ttm_bo.c
+++ b/drivers/gpu/drm/ttm/ttm_bo.c
@@ -1209,18 +1209,20 @@ int ttm_bo_init(struct ttm_bo_device *bd
 	if (likely(!ret))
 		ret = ttm_bo_validate(bo, placement, interruptible, false);
 
-	if (!resv) {
+	if (!resv)
 		ttm_bo_unreserve(bo);
 
-	} else if (!(bo->mem.placement & TTM_PL_FLAG_NO_EVICT)) {
+	if (unlikely(ret)) {
+		ttm_bo_unref(&bo);
+		return ret;
+	}
+
+	if (resv && !(bo->mem.placement & TTM_PL_FLAG_NO_EVICT)) {
 		spin_lock(&bo->glob->lru_lock);
 		ttm_bo_add_to_lru(bo);
 		spin_unlock(&bo->glob->lru_lock);
 	}
 
-	if (unlikely(ret))
-		ttm_bo_unref(&bo);
-
 	return ret;
 }
 EXPORT_SYMBOL(ttm_bo_init);
