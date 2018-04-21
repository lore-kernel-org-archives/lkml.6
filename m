Return-Path: <toddpoynor@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524279546; cv=none;
        d=google.com; s=arc-20160816;
        b=QYN7bK7gwL4Q9XikdINYsyU/EfN6qQh4i4yMNMNYX8/aYfeiPuv9gUfc//kRLT+slF
         Ugr1Yc2bQppwxP3AomPHRYIY6qEqdzBFsJ5bdtizZrrifLt59rG7T0tn8+koe6uqjuJL
         6CXlZJQp2yDCD1xaSU28YeNDgSiawFm5+gNLlnfaqpVULo8l5TX4rF/vVZAgUbJm0Fa3
         CVUQqx1iTJ4Tl2F+6zzf+9srJYUmcWdLMoOXElGgKWwZsHOYLoTbuAIuA1yljrtl5rKJ
         SsbUYf5RArwokw2CJXdnPkAg/YIpFeJvdiAovunh+/DXo3LGxdMyrjiLlptr32Ik/4Ry
         Vohg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=TOIaQbYjeyTKRWN7JKLdZ4m1bj9nHDfKx1oeSVGapO8=;
        b=I4i2DTctwO8aQt8V7YK85p8Z0IHjL6DAiDdXgRhpo9J7rUQLm0Ks/A383Kn3J8y+Uc
         0PmMVpWcWqIZYgVtKt9PnVbtL/WQSaC3HEyktxjdvuVBSkDD+TmhrVevRzBiXMqsQqpH
         C7lwv28sVaFe8oQC4Ub7TLLjNYLy2RZJ/Vq/p7X800FYfkXRKlGUKEA6HjCUajqqxuBo
         c5Bp7coMKCaESqt4XBJIrhtWV6ATDJKWOOmJTCk/9UF9JEgpHcw6AJEU9tOhaTi4Dhqv
         /vSuV4H2szxcuZDaGE8LShuEyLnoMytUEMsadfr+6WpnZCxJFvo07JNdLwmJnsnQqWnD
         ugAg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=DvoNVgb4;
       spf=pass (google.com: domain of toddpoynor@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=toddpoynor@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=DvoNVgb4;
       spf=pass (google.com: domain of toddpoynor@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=toddpoynor@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
X-Google-Smtp-Source: AIpwx48fcs/UpFErMD3TJszYuAR0MBd22k6EwXEKmPtbO7v8wWhJmL2rUGYmPhQN83Dh+uv2n0fc0w==
From: Todd Poynor <toddpoynor@google.com>
To: Laura Abbott <labbott@redhat.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org,
	Todd Poynor <toddpoynor@google.com>
Subject: [PATCH] staging: android: ion: remove duplicate buffer field initializes
Date: Fri, 20 Apr 2018 19:56:29 -0700
Message-Id: <20180421025629.214879-1-toddpoynor@google.com>
X-Mailer: git-send-email 2.17.0.484.g0c8726318c-goog
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598322949283532026?=
X-GMAIL-MSGID: =?utf-8?q?1598322949283532026?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

As a result of various previous patches, ion_buffer_create() now
has two sets of identical statements for initializing two fields of
the buffer struct, next to each other.  Remove one set.

Move the initialization of these two fields together with the
statements that initialize the other two fields from the function
parameters, prior to the heap allocate() call, for consistency.

Signed-off-by: Todd Poynor <toddpoynor@google.com>
Acked-by: Sumit Semwal <sumit.semwal@linaro.org>
---
 drivers/staging/android/ion/ion.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/android/ion/ion.c b/drivers/staging/android/ion/ion.c
index e74db7902549..269a431646be 100644
--- a/drivers/staging/android/ion/ion.c
+++ b/drivers/staging/android/ion/ion.c
@@ -74,6 +74,8 @@ static struct ion_buffer *ion_buffer_create(struct ion_heap *heap,
 
 	buffer->heap = heap;
 	buffer->flags = flags;
+	buffer->dev = dev;
+	buffer->size = len;
 
 	ret = heap->ops->allocate(heap, buffer, len, flags);
 
@@ -93,11 +95,7 @@ static struct ion_buffer *ion_buffer_create(struct ion_heap *heap,
 		goto err1;
 	}
 
-	buffer->dev = dev;
-	buffer->size = len;
 
-	buffer->dev = dev;
-	buffer->size = len;
 	INIT_LIST_HEAD(&buffer->attachments);
 	mutex_init(&buffer->lock);
 	mutex_lock(&dev->buffer_lock);
-- 
2.17.0.484.g0c8726318c-goog
