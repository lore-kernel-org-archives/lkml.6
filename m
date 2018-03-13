Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtELzeCndkxenYdASrf/GA/R12Z/4b/HVzUsRSJmuvKVOBTeE0ayf4WorUuIjqonvwuUWyo
ARC-Seal: i=1; a=rsa-sha256; t=1520955459; cv=none;
        d=google.com; s=arc-20160816;
        b=N0/Y+ZvE7F8WwPwlIwAFWJz9h/TVuTixVuD0w99z63wR8lgj+CbJaYrZiPGomKHmjo
         AOYStlreqOD7FNWYom34VUCR9JVSwN71dlzXWMAh5P9qaVX4WzZxXbPg/S2YF3Qtnw/Z
         2Mu/pjz5v6sYHsJN/aQLjz3WRZCLb6OqlEg+7y/oHCcilvnFcROUbixY/thpmtPji0OH
         55cdc9uDFHcSw8eNmD+erdbd0UfCAZ8Vy7Z2ROuNdASxafm41BGig5gYYadkGaKuEIdc
         TdNmQsIEGoLupHQPwYGqP8uwpKIYZYS0W0VbfgAjKhB7Z8XOxKUZfC8skQgPrB09uj4z
         CS+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=lYyOAotJRiYsUUsOiP2mucS+OeyF/Ax1W1Oq6LtefH4=;
        b=nUj/hAMqCpspN54zq54K5g84EOJ9+/KS3NuZ9fX3T7XNmSw6v1xrTxD86DMVI/eUlz
         wyYazSgfbS8W0nFOuAh0l4hlqXOICsa78tMR/OFY+43gc0cmnUzEJmheaGlWwtuCHuWb
         rRbmypr+MYQw+nG4o6hl5TqVqOY41hw7iM5FZeM5wvNgXGOwVz7n6uOGU8kvf/Oqs9WQ
         Eoryiyz8o23YCnAsdeGQ75i+NYYkg1ab6JTo2izwOjyQFWvMgh5vgn4rST+NeLe0rNsh
         L5G20BMxjZEC6qWF5ScvlPbqrNp/3gVMWl4K7u6tnVf4I/Nzic9Tv9/A4XrKIe8HFpbk
         qiKw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Lionel Landwerlin <lionel.g.landwerlin@intel.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Chris Wilson <chris@chris-wilson.co.uk>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	intel-gfx@lists.freedesktop.org
Subject: [PATCH 4.14 057/140] drm/i915/perf: fix perf stream opening lock
Date: Tue, 13 Mar 2018 16:24:20 +0100
Message-Id: <20180313152502.103047885@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152458.201155692@linuxfoundation.org>
References: <20180313152458.201155692@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594836876367995431?=
X-GMAIL-MSGID: =?utf-8?q?1594837392273729673?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lionel Landwerlin <lionel.g.landwerlin@intel.com>

commit f616f2830c1ed79245cfeca900f7e8a3b3c08c06 upstream.

We're seeing on CI that some contexts don't have the programmed OA
period timer that directs the OA unit on how often to write reports.

The issue is that we're not holding the drm lock from when we edit the
context images down to when we set the exclusive_stream variable. This
leaves a window for the deferred context allocation to call
i915_oa_init_reg_state() that will not program the expected OA timer
value, because we haven't set the exclusive_stream yet.

v2: Drop need_lock from gen8_configure_all_contexts() (Matt)

Signed-off-by: Lionel Landwerlin <lionel.g.landwerlin@intel.com>
Reviewed-by: Matthew Auld <matthew.auld@intel.com>
Reviewed-by: Chris Wilson <chris@chris-wilson.co.uk>
Fixes: 701f8231a2f ("drm/i915/perf: prune OA configs")
Bugzilla: https://bugs.freedesktop.org/show_bug.cgi?id=102254
Bugzilla: https://bugs.freedesktop.org/show_bug.cgi?id=103715
Bugzilla: https://bugs.freedesktop.org/show_bug.cgi?id=103755
Link: https://patchwork.freedesktop.org/patch/msgid/20180301110613.1737-1-lionel.g.landwerlin@intel.com
Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: intel-gfx@lists.freedesktop.org
Cc: <stable@vger.kernel.org> # v4.14+
(cherry picked from commit 41d3fdcd15d5ecf29cc73e8b79c2327ebb54b960)
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/i915/i915_perf.c |   38 ++++++++++++--------------------------
 1 file changed, 12 insertions(+), 26 deletions(-)

--- a/drivers/gpu/drm/i915/i915_perf.c
+++ b/drivers/gpu/drm/i915/i915_perf.c
@@ -1300,9 +1300,8 @@ static void i915_oa_stream_destroy(struc
 	 */
 	mutex_lock(&dev_priv->drm.struct_mutex);
 	dev_priv->perf.oa.exclusive_stream = NULL;
-	mutex_unlock(&dev_priv->drm.struct_mutex);
-
 	dev_priv->perf.oa.ops.disable_metric_set(dev_priv);
+	mutex_unlock(&dev_priv->drm.struct_mutex);
 
 	free_oa_buffer(dev_priv);
 
@@ -1754,22 +1753,13 @@ static int gen8_switch_to_updated_kernel
  * Note: it's only the RCS/Render context that has any OA state.
  */
 static int gen8_configure_all_contexts(struct drm_i915_private *dev_priv,
-				       const struct i915_oa_config *oa_config,
-				       bool interruptible)
+				       const struct i915_oa_config *oa_config)
 {
 	struct i915_gem_context *ctx;
 	int ret;
 	unsigned int wait_flags = I915_WAIT_LOCKED;
 
-	if (interruptible) {
-		ret = i915_mutex_lock_interruptible(&dev_priv->drm);
-		if (ret)
-			return ret;
-
-		wait_flags |= I915_WAIT_INTERRUPTIBLE;
-	} else {
-		mutex_lock(&dev_priv->drm.struct_mutex);
-	}
+	lockdep_assert_held(&dev_priv->drm.struct_mutex);
 
 	/* Switch away from any user context. */
 	ret = gen8_switch_to_updated_kernel_context(dev_priv, oa_config);
@@ -1817,8 +1807,6 @@ static int gen8_configure_all_contexts(s
 	}
 
  out:
-	mutex_unlock(&dev_priv->drm.struct_mutex);
-
 	return ret;
 }
 
@@ -1862,7 +1850,7 @@ static int gen8_enable_metric_set(struct
 	 * to make sure all slices/subslices are ON before writing to NOA
 	 * registers.
 	 */
-	ret = gen8_configure_all_contexts(dev_priv, oa_config, true);
+	ret = gen8_configure_all_contexts(dev_priv, oa_config);
 	if (ret)
 		return ret;
 
@@ -1877,7 +1865,7 @@ static int gen8_enable_metric_set(struct
 static void gen8_disable_metric_set(struct drm_i915_private *dev_priv)
 {
 	/* Reset all contexts' slices/subslices configurations. */
-	gen8_configure_all_contexts(dev_priv, NULL, false);
+	gen8_configure_all_contexts(dev_priv, NULL);
 
 	I915_WRITE(GDT_CHICKEN_BITS, (I915_READ(GDT_CHICKEN_BITS) &
 				      ~GT_NOA_ENABLE));
@@ -2127,6 +2115,10 @@ static int i915_oa_stream_init(struct i9
 	if (ret)
 		goto err_oa_buf_alloc;
 
+	ret = i915_mutex_lock_interruptible(&dev_priv->drm);
+	if (ret)
+		goto err_lock;
+
 	ret = dev_priv->perf.oa.ops.enable_metric_set(dev_priv,
 						      stream->oa_config);
 	if (ret)
@@ -2134,23 +2126,17 @@ static int i915_oa_stream_init(struct i9
 
 	stream->ops = &i915_oa_stream_ops;
 
-	/* Lock device for exclusive_stream access late because
-	 * enable_metric_set() might lock as well on gen8+.
-	 */
-	ret = i915_mutex_lock_interruptible(&dev_priv->drm);
-	if (ret)
-		goto err_lock;
-
 	dev_priv->perf.oa.exclusive_stream = stream;
 
 	mutex_unlock(&dev_priv->drm.struct_mutex);
 
 	return 0;
 
-err_lock:
+err_enable:
 	dev_priv->perf.oa.ops.disable_metric_set(dev_priv);
+	mutex_unlock(&dev_priv->drm.struct_mutex);
 
-err_enable:
+err_lock:
 	free_oa_buffer(dev_priv);
 
 err_oa_buf_alloc:
