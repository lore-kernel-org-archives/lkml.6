Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuu2j4J0lULiQfWoHZ62g2L7dt8LAG1PXNcnkdo2q9s+FoCXDDP6WfUMGzNC+wWUmQy8xZh
ARC-Seal: i=1; a=rsa-sha256; t=1519676736; cv=none;
        d=google.com; s=arc-20160816;
        b=hAEUpIi2Lwpk/FBCShcuo15rZ61izCYL3wnRWb/9ZlresocnlD1JACZGWA+d6icezk
         zEAeA5zkjJuNMSpAMZDgg+SWQN5ZmbnbTaNo3ElQjAlNAS1Chray3YTqsDBMk8Qqc76Y
         ZaELod3ga9PAGHWp/JDVr+bhRc1WUk2AR3KDiIt8xQYoZX4z0JLVNXg8mzopg3EPSHeL
         SkaZNOEdzhywcnzB9gjKJt1XuulaL8LSz4X6hbw8dYdP7Oid/6vA4svzrDYPXxeKM2hD
         /Yow2OxJirIVjGLuX/DzkkGb9YiJkZ1jkCIdiHPzB9HueKDdEbwM6gz0sasMfPVGcvg1
         UMpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=3mIrBXEndz43gsHFVh5qGHayZahYsD3+qFQ05TSDQh8=;
        b=ipmOrRdowUgbz0dXTv3vERIwiI9N4rRkmOl8Naada29N/swKCYXZB7V14j4ai7YmPY
         oZDh10k2GoSQln7Vx6u4nrMm/eB7qG43BUFoXTZ3V/Wr/B+RsZhPdTZtxntWP5lPxPT7
         f30j2Wy2biJYXrCmz/wQXmGw8GMwVpPWuN6aDWEQdHkIMECGVnWkOQlv88FSb8Yz1f6u
         il+8uOnPSLz0NAfgenDVAVpY6ZrLpf1yNWYDHcue5YtkcWXDXh2w9D1HIaFkYbhj2bAA
         CqnhMiDxlTnlrjchifvahYqOWkhSFP3hV2lRdHf4PzHpf+lGsZSD8LcUImgBLUSjOfR/
         1VXA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Chris Wilson <chris@chris-wilson.co.uk>,
	Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: [PATCH 4.14 54/54] drm/i915/breadcrumbs: Ignore unsubmitted signalers
Date: Mon, 26 Feb 2018 21:22:31 +0100
Message-Id: <20180226202147.506513200@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180226202144.375869933@linuxfoundation.org>
References: <20180226202144.375869933@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593496553533576741?=
X-GMAIL-MSGID: =?utf-8?q?1593496553533576741?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chris Wilson <chris@chris-wilson.co.uk>

commit 117172c8f9d40ba1de8cb35c6e614422faa03330 upstream.

When a request is preempted, it is unsubmitted from the HW queue and
removed from the active list of breadcrumbs. In the process, this
however triggers the signaler and it may see the clear rbtree with the
old, and still valid, seqno, or it may match the cleared seqno with the
now zero rq->global_seqno. This confuses the signaler into action and
signaling the fence.

Fixes: d6a2289d9d6b ("drm/i915: Remove the preempted request from the execution queue")
Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
Cc: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: <stable@vger.kernel.org> # v4.12+
Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20180206094633.30181-1-chris@chris-wilson.co.uk
(cherry picked from commit fd10e2ce9905030d922e179a8047a4d50daffd8e)
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20180213090154.17373-1-chris@chris-wilson.co.uk
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/i915/intel_breadcrumbs.c |   29 ++++++++++-------------------
 1 file changed, 10 insertions(+), 19 deletions(-)

--- a/drivers/gpu/drm/i915/intel_breadcrumbs.c
+++ b/drivers/gpu/drm/i915/intel_breadcrumbs.c
@@ -541,29 +541,16 @@ void intel_engine_remove_wait(struct int
 	spin_unlock_irq(&b->rb_lock);
 }
 
-static bool signal_valid(const struct drm_i915_gem_request *request)
-{
-	return intel_wait_check_request(&request->signaling.wait, request);
-}
-
 static bool signal_complete(const struct drm_i915_gem_request *request)
 {
 	if (!request)
 		return false;
 
-	/* If another process served as the bottom-half it may have already
-	 * signalled that this wait is already completed.
-	 */
-	if (intel_wait_complete(&request->signaling.wait))
-		return signal_valid(request);
-
-	/* Carefully check if the request is complete, giving time for the
+	/*
+	 * Carefully check if the request is complete, giving time for the
 	 * seqno to be visible or if the GPU hung.
 	 */
-	if (__i915_request_irq_complete(request))
-		return true;
-
-	return false;
+	return __i915_request_irq_complete(request);
 }
 
 static struct drm_i915_gem_request *to_signaler(struct rb_node *rb)
@@ -606,9 +593,13 @@ static int intel_breadcrumbs_signaler(vo
 			request = i915_gem_request_get_rcu(request);
 		rcu_read_unlock();
 		if (signal_complete(request)) {
-			local_bh_disable();
-			dma_fence_signal(&request->fence);
-			local_bh_enable(); /* kick start the tasklets */
+			if (!test_bit(DMA_FENCE_FLAG_SIGNALED_BIT,
+				      &request->fence.flags)) {
+				local_bh_disable();
+				dma_fence_signal(&request->fence);
+				GEM_BUG_ON(!i915_gem_request_completed(request));
+				local_bh_enable(); /* kick start the tasklets */
+			}
 
 			spin_lock_irq(&b->rb_lock);
 
