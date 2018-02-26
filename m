Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224CNxuU51ePT3W8Edv4ZF17gMNzocBu7beKTt8bB5cZq0O9JL5FSCB2UOwNZ969k6INPNIS
ARC-Seal: i=1; a=rsa-sha256; t=1519676965; cv=none;
        d=google.com; s=arc-20160816;
        b=tKsgkAYG3vScymHcQiVcMMtmQIMJMk1Seq2yA5pujpTxRgVZlFqFER1cIOJbQstnSu
         SmlB/6SphAQfgWVciZwB1OTfLioXoEcaO3C92hzD/U46tbb7FkKMXq2QDrv/KJlF8I0Q
         cXkWijTDff/kR+pWOn95texKR91CDZn9weXMwCIYebR24M2/ovG2MgU/0Hlv44efXjNw
         TanrF906y4Z/sMVMsOUCgT6zMn1uPxcCoyiyogyZhxN3jLVuelqMHawnYdyvRtJ0RJ5H
         8WigVbp8Oc15oIqeq2+MUMHhhrhn9LFfu3PcciXgtyMycYTsP38Rlw3+sfKGAjwDF6/x
         BGUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=IxE3RGNyRask2fMVvzG8Sys48QSRj5Rs+lImdwFRN+w=;
        b=v7mR6xZwgnJ4fZN9p8+oGAHI64A8JbITvGmagqj6OI13gf/OvnXRoBTW9kgCrkABtQ
         nffvCiOvq6wROWLDxLZq3mslVpaiBWIoAsmyUowJab43Szthi7pBPNDflnLLTKthvW24
         GFlklqRRppAXcYn+xJgddhBDsDO4ooamjZIO4epE4Pu5bK8NElsfnSnuKuYSE5WSaH7n
         UtvR3sQ9cvN+aYD5c3s4lL9if4zdG5LmIAR94w7gAWVv7QixERYk74md9v3gSrtFtcOR
         SeVchH5LRAkvkfOlubDQ8A5znJrCWEFqMD9GJ/tRRyfw9nUuRQio7NaRhBJFqQI6tpAr
         dgGQ==
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
Subject: [PATCH 4.15 64/64] drm/i915/breadcrumbs: Ignore unsubmitted signalers
Date: Mon, 26 Feb 2018 21:22:41 +0100
Message-Id: <20180226202156.178016266@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180226202153.453363333@linuxfoundation.org>
References: <20180226202153.453363333@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593496553533576741?=
X-GMAIL-MSGID: =?utf-8?q?1593496794390506501?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -552,29 +552,16 @@ void intel_engine_remove_wait(struct int
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
@@ -617,9 +604,13 @@ static int intel_breadcrumbs_signaler(vo
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
 
