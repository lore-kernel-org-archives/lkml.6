Return-Path: <SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZr5QiBf8Buzs55Si6hrKdYJ2/nc+F/nIxXyYn9viAGRD0742dOt318JkqdXvgdS7+K9owca
ARC-Seal: i=1; a=rsa-sha256; t=1524837778; cv=none;
        d=google.com; s=arc-20160816;
        b=lzBrlaQbkQrP6DpYXNqO1JXCCwx8MVSqzH7Rh2QI6lUjF47Xz7TwX9bgHQp2XZnBpn
         c20tREOHYW/aDeytn15FNBsEmWRP2yNHvJM+tuXl0BjskTg3TtRoemCtFRvaLdg+hy6b
         y5a6kq5Csh0e/9/B93Le6mye00Y2/INxG5+CHYGuD8KJfFIE9ITbrX0LItOBp7qErOvT
         LU4AE0DgJ71pqMasxOB08mnWw8p6YrXEb5kw08jxKR6oEBnBV+g7r35lcQpZb/He1GGU
         A/8CMyF8DOzJy7SHorW6gLjJ701PGdLnbhxp1K9DyxTE4HEImIFKq1sq/G3OLbkmmYH2
         R0hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=E4tnjRm4VFfkwJK9hzhgnvRk0/hbBoxs4nTEMIKyuJA=;
        b=p+Ee4YCcnAgIlvzwOGFliXuWgWZYX8hzPymOYjLBZlOuvXpO3FWt4v/UBIEKRkBFdm
         MRh9lwcnV2tZe6uOCQu+MgaDf6Xedzc68YX1tz3ik+rXwlXZ6hdrSEoQtHd/CW34bucO
         7IYyw0osrP90J4JMotFA8PpQUSKQhCpcvrEoJijukULFgBcw/iDIsWG+lvB6fT3XOg/R
         vVopqqghk4jmASzcuD8TFbM958QEqDo4XfSxshlwi+uHne4wJdyYN73KPmrOWmG+VI6b
         2QyA6ug49e++zDI84BwluGIgxr0pTUtvuG2RvXPuy3k6OVrXMNDCHvqvFrMw1s87iG4I
         Bfsw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3048921897
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Daniel J Blueman <daniel@quora.org>,
	Eric Anholt <eric@anholt.net>
Subject: [PATCH 4.9 03/74] drm/vc4: Fix memory leak during BO teardown
Date: Fri, 27 Apr 2018 15:57:53 +0200
Message-Id: <20180427135710.038433411@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135709.899303463@linuxfoundation.org>
References: <20180427135709.899303463@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598908298275033537?=
X-GMAIL-MSGID: =?utf-8?q?1598908298275033537?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daniel J Blueman <daniel@quora.org>

commit c0db1b677e1d584fab5d7ac76a32e1c0157542e0 upstream.

During BO teardown, an indirect list 'uniform_addr_offsets' wasn't being
freed leading to leaking many 128B allocations. Fix the memory leak by
releasing it at teardown time.

Cc: stable@vger.kernel.org
Fixes: 6d45c81d229d ("drm/vc4: Add support for branching in shader validation.")
Signed-off-by: Daniel J Blueman <daniel@quora.org>
Signed-off-by: Eric Anholt <eric@anholt.net>
Reviewed-by: Eric Anholt <eric@anholt.net>
Link: https://patchwork.freedesktop.org/patch/msgid/20180402071035.25356-1-daniel@quora.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/vc4/vc4_bo.c               |    2 ++
 drivers/gpu/drm/vc4/vc4_validate_shaders.c |    1 +
 2 files changed, 3 insertions(+)

--- a/drivers/gpu/drm/vc4/vc4_bo.c
+++ b/drivers/gpu/drm/vc4/vc4_bo.c
@@ -80,6 +80,7 @@ static void vc4_bo_destroy(struct vc4_bo
 	struct vc4_dev *vc4 = to_vc4_dev(obj->dev);
 
 	if (bo->validated_shader) {
+		kfree(bo->validated_shader->uniform_addr_offsets);
 		kfree(bo->validated_shader->texture_samples);
 		kfree(bo->validated_shader);
 		bo->validated_shader = NULL;
@@ -328,6 +329,7 @@ void vc4_free_object(struct drm_gem_obje
 	}
 
 	if (bo->validated_shader) {
+		kfree(bo->validated_shader->uniform_addr_offsets);
 		kfree(bo->validated_shader->texture_samples);
 		kfree(bo->validated_shader);
 		bo->validated_shader = NULL;
--- a/drivers/gpu/drm/vc4/vc4_validate_shaders.c
+++ b/drivers/gpu/drm/vc4/vc4_validate_shaders.c
@@ -874,6 +874,7 @@ vc4_validate_shader(struct drm_gem_cma_o
 fail:
 	kfree(validation_state.branch_targets);
 	if (validated_shader) {
+		kfree(validated_shader->uniform_addr_offsets);
 		kfree(validated_shader->texture_samples);
 		kfree(validated_shader);
 	}
