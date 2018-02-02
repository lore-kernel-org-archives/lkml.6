Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227O+JH+Rya9Th0Us8ceLI/5t4ovkH8JnrrNq9xuuI/zoKd38mINwmu4QAvfoDmvBtWtQNt7
ARC-Seal: i=1; a=rsa-sha256; t=1517591319; cv=none;
        d=google.com; s=arc-20160816;
        b=ipAoOYUIxptKV+RZ+WhbiOCvno1DRrVGp7Y0JQ5vcYkrelqAAJYjCOSPINsSYjJGZf
         KXLALfWumBBBXRxQZuUujjDkDKzmjr2I74VHRK5GDgpLgMA5qYlGlly+jgtmH3g8ndsP
         ZMHvXErMwNvlnxd2Qda8t2NXfdXETbL+Vv53CVTRTNw3+V4tdjt5lRK6Tsg9wlV/Xc0P
         FCS3UMjBp71XJj6sB3t8Wqmyur7nnOGEyTDNWUagOMAMf3Zbrk5kzfJaMNewBUtOtjsE
         eQbu9vlTdbAknYVmKF8Gu1M7ZYNKqQegOxz8+d/lwTiEyAdSet1mJnS+nyfIo1CgfJOH
         t2eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=NIihBQelUkmaFIjcHYcIaZmC4jf+L2E1EgWZt06hYYo=;
        b=vk0o12OcIEoYdFkOQiAO2rDJBSY5kylWf6xkx7I1rMfxY89+20HjG7LdoxENbdHV/S
         wIl2tUnBGukco7UHg9lIYFOV2HM3VGKfEl8rHEh4UBtAbv+cYPy8qkYOPDZgOqFkMYAU
         NvSVTz83N8zu9y8QQzuPnAKKFH9yq27VaIxsvMahddkVXzyWE3ApaUbTPA3mB4Kz8N4+
         C+MZ+rwlRsuYVDBG8YGEZ6sb00HnQRU6I83eNY4P8YG3eAS/Ilvp7VhV4spvAtaR+irI
         aR0tAaUHpIwOLmtBlfJztMobpuowvh7LVgXAWJpTw70VgXKnXiwrS9R5fJ8QtqntpvlN
         1kpQ==
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
Subject: [PATCH 4.14 031/156] drm/vc4: Account for interrupts in flight
Date: Fri,  2 Feb 2018 17:56:52 +0100
Message-Id: <20180202140841.741635524@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140840.242829545@linuxfoundation.org>
References: <20180202140840.242829545@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309601142574512?=
X-GMAIL-MSGID: =?utf-8?q?1591309835617311682?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stefan Schake <stschake@gmail.com>


[ Upstream commit 253696ccd613fbdaa5aba1de44c461a058e0a114 ]

Synchronously disable the IRQ to make the following cancel_work_sync
invocation effective.

An interrupt in flight could enqueue further overflow mem work. As we
free the binner BO immediately following vc4_irq_uninstall this caused
a NULL pointer dereference in the work callback vc4_overflow_mem_work.

Link: https://github.com/anholt/linux/issues/114
Signed-off-by: Stefan Schake <stschake@gmail.com>
Fixes: d5b1a78a772f ("drm/vc4: Add support for drawing 3D frames.")
Signed-off-by: Eric Anholt <eric@anholt.net>
Reviewed-by: Eric Anholt <eric@anholt.net>
Link: https://patchwork.freedesktop.org/patch/msgid/1510275907-993-2-git-send-email-stschake@gmail.com
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/vc4/vc4_irq.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/gpu/drm/vc4/vc4_irq.c
+++ b/drivers/gpu/drm/vc4/vc4_irq.c
@@ -208,6 +208,9 @@ vc4_irq_postinstall(struct drm_device *d
 {
 	struct vc4_dev *vc4 = to_vc4_dev(dev);
 
+	/* Undo the effects of a previous vc4_irq_uninstall. */
+	enable_irq(dev->irq);
+
 	/* Enable both the render done and out of memory interrupts. */
 	V3D_WRITE(V3D_INTENA, V3D_DRIVER_IRQS);
 
@@ -225,6 +228,9 @@ vc4_irq_uninstall(struct drm_device *dev
 	/* Clear any pending interrupts we might have left. */
 	V3D_WRITE(V3D_INTCTL, V3D_DRIVER_IRQS);
 
+	/* Finish any interrupt handler still in flight. */
+	disable_irq(dev->irq);
+
 	cancel_work_sync(&vc4->overflow_mem_work);
 }
 
