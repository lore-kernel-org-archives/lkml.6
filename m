Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuKEjCHj9Hf1J1uzpARwLO+Htw9eoQuJYg3lxZn31Q3GqMITfymPGRv5QXmi2ZhTCh2D4am
ARC-Seal: i=1; a=rsa-sha256; t=1519412156; cv=none;
        d=google.com; s=arc-20160816;
        b=Z5k8uOtKbEyMkXObZ//zQS/NaTzFkVXkZsnObCqg+X/YP8IjAtfUvbXJQLxvLKk3R7
         zokgimp1JjsumdgOAnpGmO6/d5/nisCb7Gexob2Cci+Oat/T/Y3ibodRRfI4CZ+1THK/
         ozg8uENI65WUrmd9YkVX2v8SF0z4hbvwvweeqS5UIm2juXiAMofPbEnLV+UKAgpL3Y54
         B/m/AxP3tJNZIVJfQU/W0xosI9xFSayIQxqW/UEbqtAeyAWg7srdVZtUroqINYQWpBV/
         5Wr+kt+ne9CogLid+tlzOWYtFxq/VsOg7/QDsjZMjuxCPglPz7HcxotHcVVmhl5D5G+m
         zKTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=aeKtqPtPXqNLaEzXRrKictfO9CDrf0Xq7Mb3WcHufBE=;
        b=MV3jMxh/iPLtGfu9v2fQqKmFPF9Po9YH20zP0G7w2VIUdse1a50DF8cluWQpu93Msw
         u41uXfazxdep8U8V8c142y0ptKWtbFdCIkpqAjreb68T/pqTaPESb7fLKyudBaPFWGTm
         ciK4trhwDr+QkbTGSIP4EIt4xb3B9fssbFH/h0KRbOx9fDqfbajqmypveaVCm5LdykSw
         1CNmB7f2RuIRQC0yeQgYK+tLPzsjkstUKMHCWoFSO/gYtBDXgtdLveGLxtzHHhjwdQT7
         hUQDTlrGwY59cPSfowoI69DAk5FDXs60/nABUDR/aPwsb5/WxozZcHhztJIxrsApMbaO
         9oIQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Stefan Schake <stschake@gmail.com>,
	Eric Anholt <eric@anholt.net>,
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 143/159] drm/vc4: Release fence after signalling
Date: Fri, 23 Feb 2018 19:27:31 +0100
Message-Id: <20180223170800.313006422@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170743.086611315@linuxfoundation.org>
References: <20180223170743.086611315@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593219120908525240?=
X-GMAIL-MSGID: =?utf-8?q?1593219120908525240?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stefan Schake <stschake@gmail.com>


[ Upstream commit babc8110057cb9ca542c3c1666cbda4e8ccf9250 ]

We were never releasing the initial fence reference that is obtained
through dma_fence_init.

Link: https://github.com/anholt/linux/issues/122
Fixes: cdec4d361323 ("drm/vc4: Expose dma-buf fences for V3D rendering.")
Signed-off-by: Stefan Schake <stschake@gmail.com>
Signed-off-by: Eric Anholt <eric@anholt.net>
Reviewed-by: Eric Anholt <eric@anholt.net>
Link: https://patchwork.freedesktop.org/patch/msgid/1512236444-301-1-git-send-email-stschake@gmail.com
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/vc4/vc4_gem.c |    4 +++-
 drivers/gpu/drm/vc4/vc4_irq.c |    1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/vc4/vc4_gem.c
+++ b/drivers/gpu/drm/vc4/vc4_gem.c
@@ -829,8 +829,10 @@ vc4_complete_exec(struct drm_device *dev
 	/* If we got force-completed because of GPU reset rather than
 	 * through our IRQ handler, signal the fence now.
 	 */
-	if (exec->fence)
+	if (exec->fence) {
 		dma_fence_signal(exec->fence);
+		dma_fence_put(exec->fence);
+	}
 
 	if (exec->bo) {
 		for (i = 0; i < exec->bo_count; i++)
--- a/drivers/gpu/drm/vc4/vc4_irq.c
+++ b/drivers/gpu/drm/vc4/vc4_irq.c
@@ -139,6 +139,7 @@ vc4_irq_finish_render_job(struct drm_dev
 	list_move_tail(&exec->head, &vc4->job_done_list);
 	if (exec->fence) {
 		dma_fence_signal_locked(exec->fence);
+		dma_fence_put(exec->fence);
 		exec->fence = NULL;
 	}
 	vc4_submit_next_render_job(dev);
