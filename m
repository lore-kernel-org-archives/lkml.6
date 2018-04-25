Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+LHhsdm8aM2QvVnXDmX9U4W9CatcUvCQfC0BtJ96pO54b4KnlY8jXoIX53l7qOEPeGk1mq
ARC-Seal: i=1; a=rsa-sha256; t=1524652848; cv=none;
        d=google.com; s=arc-20160816;
        b=k0fpD0tx5BFMI+r83OTXnjUJR9Ga59x8CVGjGEd7MfQip9Cb0Nn+kj+Wm8KGGybiOw
         hKZRBpEwT+Z8R48DRsYjTao28yPePzka7z1lnM5HxVJtCjtrkr0Y6+2AqbQ0EDN6l+tl
         weAZuC53sOFDCEQLbaHmLtRmScuaEATXDaB7JAeFkxfEgVgmZ/EIKPsM0J1hZRTyhlKZ
         p5QNx2hYCNy5CddAl3+WZ6yz5KStlYJzpm/K938YyvzyqDG7Xco2v3HQL7gz6VPywDP5
         e8xjM1UAreqMh3ytVOK/DzbHE4WBH01lRn8lWfZUHZjQzGiGykmSut+vUO4JlIGZ2IU3
         h/vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=GZK4zOQXWfwz9r7Frug/gLzwuan+63+jW6tfTEjMmPI=;
        b=LHvLVEpied5O9SjbAnn01Ra3fZG3TtNuXko4+OC+GV0jXBpxmxeAQARS8J0ESX8Ehx
         TCK7Ekm7Of6K2A2d2JhOo7SRgm201qGhfhtfE5lsuxgleVXRoSM5xSjqzMvfdahGmyBN
         hVouoxIbMkeA4OIu/SJ2qd/d4+muscO6vF7eshWDah2KgtAjHN5+WOAr9ob88Grys619
         6T5dQoRLhQbWCDFXw1bDMWrulocovNQNvrw7mhZr4ek5xwxDr5a+VQvs/MFGQze5tqrq
         lor9iwlkmo4bwS8TTMiSHugq6W/3tJdQ4nd2fzjizYatDzxOqf5RtqALHIZyj1S6CCV7
         kRng==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jason Gunthorpe <jgg@mellanox.com>,
	Matan Barak <matanb@mellanox.com>,
	Doug Ledford <dledford@redhat.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 091/183] RDMA/uverbs: Use an unambiguous errno for method not supported
Date: Wed, 25 Apr 2018 12:35:11 +0200
Message-Id: <20180425103246.143393149@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103242.532713678@linuxfoundation.org>
References: <20180425103242.532713678@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598714385388363453?=
X-GMAIL-MSGID: =?utf-8?q?1598714385388363453?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jason Gunthorpe <jgg@mellanox.com>


[ Upstream commit 3624a8f02568f08aef299d3b117f2226f621177d ]

Returning EOPNOTSUPP is problematic because it can also be
returned by the method function, and we use it in quite a few
places in drivers these days.

Instead, dedicate EPROTONOSUPPORT to indicate that the ioctl framework
is enabled but the requested object and method are not supported by
the kernel. No other case will return this code, and it lets userspace
know to fall back to write().

grep says we do not use it today in drivers/infiniband subsystem.

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Reviewed-by: Matan Barak <matanb@mellanox.com>
Signed-off-by: Doug Ledford <dledford@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/core/uverbs_ioctl.c |   19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

--- a/drivers/infiniband/core/uverbs_ioctl.c
+++ b/drivers/infiniband/core/uverbs_ioctl.c
@@ -245,16 +245,13 @@ static long ib_uverbs_cmd_verbs(struct i
 	uintptr_t data[UVERBS_OPTIMIZE_USING_STACK_SZ / sizeof(uintptr_t)];
 #endif
 
-	if (hdr->reserved)
-		return -EINVAL;
-
 	object_spec = uverbs_get_object(ib_dev, hdr->object_id);
 	if (!object_spec)
-		return -EOPNOTSUPP;
+		return -EPROTONOSUPPORT;
 
 	method_spec = uverbs_get_method(object_spec, hdr->method_id);
 	if (!method_spec)
-		return -EOPNOTSUPP;
+		return -EPROTONOSUPPORT;
 
 	if ((method_spec->flags & UVERBS_ACTION_FLAG_CREATE_ROOT) ^ !file->ucontext)
 		return -EINVAL;
@@ -310,6 +307,16 @@ static long ib_uverbs_cmd_verbs(struct i
 
 	err = uverbs_handle_method(buf, ctx->uattrs, hdr->num_attrs, ib_dev,
 				   file, method_spec, ctx->uverbs_attr_bundle);
+
+	/*
+	 * EPROTONOSUPPORT is ONLY to be returned if the ioctl framework can
+	 * not invoke the method because the request is not supported.  No
+	 * other cases should return this code.
+	*/
+	if (unlikely(err == -EPROTONOSUPPORT)) {
+		WARN_ON_ONCE(err == -EPROTONOSUPPORT);
+		err = -EINVAL;
+	}
 out:
 #ifdef UVERBS_OPTIMIZE_USING_STACK_SZ
 	if (ctx_size > UVERBS_OPTIMIZE_USING_STACK_SZ)
@@ -348,7 +355,7 @@ long ib_uverbs_ioctl(struct file *filp,
 		}
 
 		if (hdr.reserved) {
-			err = -EOPNOTSUPP;
+			err = -EPROTONOSUPPORT;
 			goto out;
 		}
 
