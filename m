Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx493d6w2JVZXBKmSGc9aZeKICziP9uvwBlqJ7iygCHf8ZJHTQ6ogKNjHcQXTfvwI5yAAgxrA
ARC-Seal: i=1; a=rsa-sha256; t=1524652687; cv=none;
        d=google.com; s=arc-20160816;
        b=UnoFQ2p1xbj8SFuHqOupPsL30yGQKR/CGtYHsjcqXY+kpu2MixhnRhgNo5KmIf6yRa
         zV4CG4ikUS24GbzsMEKLtnevqfuOlmuIGKqMj2FqeoD0LyWqMY9uxC5+9E88CMJS7O8K
         N9qFNTZ8VhkwZVrvsuthAKA0GOQAOKJMb9qmXJyGpmsT1dvYoxLGrCJNgUvCYheuUZDA
         2vtb66TZsFLb33DquQV7BHnos9/zYY6gM+xEfB7lteU/VduwP349YHHSwyGMaXaASt5H
         ONpQEzm/uuxOAQP9K6IDwk2a6H8bIFoZR3Tq0S39Ky5x1re0Gi4EQPuSZiQUI7GMaOQB
         OXrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=nX+SWSyRQnW4DGU4BUWBUI46YiQSmqbqn4yeCQNb89I=;
        b=UbrsKKhuhXx2FjWOO9bIZTF+vqRGSG5rNcPayeyF3E15fmfigLT5axo7033630TkRx
         QWLAiso9wqAgtibuBWhfXLdS2IRMMW+hIqpRiW7j7VIUqSPhjTEVW2kje7m8UhGjiZvz
         +uBJqyT2Fq8tg0Oz8PVN7hnHMegWgoZDkQFEQNui4T1WLa3tCvlG3V8j2X3ouDDwsYmV
         MFmlb5CtOMd5+vX3adYl1bfeAyP+42DH/G5YnQ1/v02m+uU2OuIURWNbz5URsT7VFc+H
         iGfUtjcWX9G3bpb2Xm2TZwRQYm8CiIwX5WqKcxEb/8qJZvNAngc8CpatZVlbK+lnAuIH
         bb8Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Xidong Wang <wangxidong_97@163.com>,
	Chris Wilson <chris@chris-wilson.co.uk>,
	Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Subject: [PATCH 4.14 009/183] drm/i915: Do no use kfree() to free a kmem_cache_alloc() return value
Date: Wed, 25 Apr 2018 12:33:49 +0200
Message-Id: <20180425103242.977593179@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103242.532713678@linuxfoundation.org>
References: <20180425103242.532713678@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598713962825548350?=
X-GMAIL-MSGID: =?utf-8?q?1598714216360697912?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xidong Wang <wangxidong_97@163.com>

commit fcf1fadf4c65eea6c519c773d2d9901e8ad94f5f upstream.

Along the eb_lookup_vmas() error path, the return value from
kmem_cache_alloc() was freed using kfree(). Fix it to use the proper
kmem_cache_free() instead.

Fixes: d1b48c1e7184 ("drm/i915: Replace execbuf vma ht with an idr")
Signed-off-by: Xidong Wang <wangxidong_97@163.com>
Cc: Chris Wilson <chris@chris-wilson.co.uk>
Cc: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Cc: <stable@vger.kernel.org> # v4.14+
Reviewed-by: Chris Wilson <chris@chris-wilson.co.uk>
Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
Link: https://patchwork.freedesktop.org/patch/msgid/20180404093824.9313-1-chris@chris-wilson.co.uk
(cherry picked from commit 6be1187dbffa0027ea379c53f7ca0c782515c610)
Signed-off-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/i915/i915_gem_execbuffer.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpu/drm/i915/i915_gem_execbuffer.c
+++ b/drivers/gpu/drm/i915/i915_gem_execbuffer.c
@@ -722,7 +722,7 @@ static int eb_lookup_vmas(struct i915_ex
 
 		err = radix_tree_insert(handles_vma, handle, vma);
 		if (unlikely(err)) {
-			kfree(lut);
+			kmem_cache_free(eb->i915->luts, lut);
 			goto err_obj;
 		}
 
