Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx497I5g8hY2e2IqZCqYLvhNlqFCUYVSSNHNurOzmngHGTX+7FOeXl9Sti0f/BCEexpToZXLh
ARC-Seal: i=1; a=rsa-sha256; t=1524652679; cv=none;
        d=google.com; s=arc-20160816;
        b=bcqhvCac9bx+67Q/ujTFqltmA6YNLsFmTvkos4X1l5YOWy6KDFsPWWQV4FadMS2f02
         sgXC6NF49cKpg8zwm1QeHwSIYV+MaJ8GhacAKwRs9qPnlbCtWqnGScDDzdsaIbHIE+iH
         kjBXBj0Z2MEk3dBu6KB/Ll85PVWOuHLfTcKzsWY4pO1V0U6sm5nSWGYwKcQ7d8fKeztR
         Tz/Fa1ly4cgr6dRDe6OXuWainEDDeW/cu8xBPcMF5q2E0B0H1/OedU0+jbtSdr0K6aha
         bow0EqT2SAvh6LsrvsevV4nKXAQDu4VGLxYdr/z8ZiqBNX8B0a7Dz2HVOsgpuHwwzo4q
         Z51g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=V5v2JSDv4r0vxUhKpKqq6D1eEIeMboTNrFs3PoXVDQY=;
        b=T4A2RHE/D/9Rv9gnOevJ8APpUCVAl8oKPicJZH2gs2zxR5boOUuoho199zg6SntJw6
         JPH6YHnEtekULONqXJOTcc6Y9wb9B5TkdciST0b4S5ubbtPV3EslKsI2/l6+6uKs+Hn6
         Riwzw9DoygdalocQK91jLqv03zlOiV68mB2FfIgpGwAR/eH0M2I6/Qt//kI/OO3UkHV2
         AA65AvP8v3IE+DTvi7g3vgL9eXq9hph6TGdThpWBlZu8029n+x2hzO+OV6W8pNd10MWE
         RWw2gRQJzPQ+hp93ZsFZBR3V6XkutkUjv0tWGyBbL0lSZv23sWIUKuMi4c6xIWJTDmtg
         ea9w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Daniel J Blueman <daniel@quora.org>,
	Eric Anholt <eric@anholt.net>
Subject: [PATCH 4.14 006/183] drm/vc4: Fix memory leak during BO teardown
Date: Wed, 25 Apr 2018 12:33:46 +0200
Message-Id: <20180425103242.861086942@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103242.532713678@linuxfoundation.org>
References: <20180425103242.532713678@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598714020312773239?=
X-GMAIL-MSGID: =?utf-8?q?1598714207716893555?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -173,6 +173,7 @@ static void vc4_bo_destroy(struct vc4_bo
 	vc4_bo_set_label(obj, -1);
 
 	if (bo->validated_shader) {
+		kfree(bo->validated_shader->uniform_addr_offsets);
 		kfree(bo->validated_shader->texture_samples);
 		kfree(bo->validated_shader);
 		bo->validated_shader = NULL;
@@ -432,6 +433,7 @@ void vc4_free_object(struct drm_gem_obje
 	}
 
 	if (bo->validated_shader) {
+		kfree(bo->validated_shader->uniform_addr_offsets);
 		kfree(bo->validated_shader->texture_samples);
 		kfree(bo->validated_shader);
 		bo->validated_shader = NULL;
--- a/drivers/gpu/drm/vc4/vc4_validate_shaders.c
+++ b/drivers/gpu/drm/vc4/vc4_validate_shaders.c
@@ -942,6 +942,7 @@ vc4_validate_shader(struct drm_gem_cma_o
 fail:
 	kfree(validation_state.branch_targets);
 	if (validated_shader) {
+		kfree(validated_shader->uniform_addr_offsets);
 		kfree(validated_shader->texture_samples);
 		kfree(validated_shader);
 	}
