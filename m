Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtoXdz4njkWGeuoBMY/ynmJjxKT5hISn2Bvc8nvsqk4ywHt6OECPXCyQ5e4HFKcpmj/Rnrp
ARC-Seal: i=1; a=rsa-sha256; t=1520955436; cv=none;
        d=google.com; s=arc-20160816;
        b=LxoTXOFxRIT5WPMkdPwnSEBx5euqx/C4AVwVnbqoPanKTIqrtfGb7+NItdH6eJcMul
         3fBgT36Ui3Js+lFvxsU4QQU0UrLoTVvH0potRUn3myHDfyNTFBLILQy0PUtLReljaxGg
         rQKOBvBC7ejoh2g7vTunCz0/5zByVJv12RDK3L43LD1Ng5NA1iGjee37KyJQk7ND/ka7
         kyPXCB8ZIwNxVGK2gcmNoACK7BkKqUZUBu6KhcO7xT2b65OWdvU9jb4NSYAEwp8Hv1QT
         immdz9uk+x08xLPts4WF2A/NtKYxSkZ+nPoVY7jTK4iGtQrhuESXhilMjVOYNbO3G8An
         xQzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Rx+ZOfbWGPWQE4HacIGogtz21AThOgPgmjNpyhrqDbI=;
        b=USW6HCcep7RGnYAMtWtSH2qjC0Ps1wSJ0X3h2sQE+wOdgk1AfvWN+i+wexeYzJEr5i
         V4YIuQT1zqwGpDA99wyZ9W0HkZl+UageP2eiaE4GT9ZqpUQc/crqTZ8R9y7eIH8/j3AM
         zhaByTjRzezyqQHG9DO5vRAHrRiID2dCdhlbKhgPTQlTQzQzoEWykZ8ZQ/Im6EL5aEr+
         xXXOy1X3t7st+XgITcX1tSmTv5MiemLYbZZ7uuDViFxSJJK9PeHl/ZUw5sqPHslnCqaF
         V4IH44y/GWFJ77lW1gGOC21VEC2Jefi7TwcW3NeTSYAYIcfveU3k6sX5H1eW67l1rcgE
         TywQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Leon Romanovsky <leon@kernel.org>,
	Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH 4.14 049/140] IB/uverbs: Improve lockdep_check
Date: Tue, 13 Mar 2018 16:24:12 +0100
Message-Id: <20180313152501.583060985@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152458.201155692@linuxfoundation.org>
References: <20180313152458.201155692@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594836784682141568?=
X-GMAIL-MSGID: =?utf-8?q?1594837367734050462?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jason Gunthorpe <jgg@mellanox.com>

commit 104f268d439b3c21c83708e52946a4d8d37f3d0f upstream.

This is really being used as an assert that the expected usecnt
is being held and implicitly that the usecnt is valid. Rename it to
assert_uverbs_usecnt and tighten the checks to only accept valid
values of usecnt (eg 0 and < -1 are invalid).

The tigher checkes make the assertion cover more cases and is more
likely to find bugs via syzkaller/etc.

Fixes: 3832125624b7 ("IB/core: Add support for idr types")
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/core/rdma_core.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

--- a/drivers/infiniband/core/rdma_core.c
+++ b/drivers/infiniband/core/rdma_core.c
@@ -407,13 +407,13 @@ static int __must_check remove_commit_fd
 	return ret;
 }
 
-static void lockdep_check(struct ib_uobject *uobj, bool exclusive)
+static void assert_uverbs_usecnt(struct ib_uobject *uobj, bool exclusive)
 {
 #ifdef CONFIG_LOCKDEP
 	if (exclusive)
-		WARN_ON(atomic_read(&uobj->usecnt) > 0);
+		WARN_ON(atomic_read(&uobj->usecnt) != -1);
 	else
-		WARN_ON(atomic_read(&uobj->usecnt) == -1);
+		WARN_ON(atomic_read(&uobj->usecnt) <= 0);
 #endif
 }
 
@@ -452,7 +452,7 @@ int __must_check rdma_remove_commit_uobj
 		WARN(true, "ib_uverbs: Cleanup is running while removing an uobject\n");
 		return 0;
 	}
-	lockdep_check(uobj, true);
+	assert_uverbs_usecnt(uobj, true);
 	ret = _rdma_remove_commit_uobject(uobj, RDMA_REMOVE_DESTROY);
 
 	up_read(&ucontext->cleanup_rwsem);
@@ -482,7 +482,7 @@ int rdma_explicit_destroy(struct ib_uobj
 		WARN(true, "ib_uverbs: Cleanup is running while removing an uobject\n");
 		return 0;
 	}
-	lockdep_check(uobject, true);
+	assert_uverbs_usecnt(uobject, true);
 	ret = uobject->type->type_class->remove_commit(uobject,
 						       RDMA_REMOVE_DESTROY);
 	if (ret)
@@ -569,7 +569,7 @@ static void lookup_put_fd_uobject(struct
 
 void rdma_lookup_put_uobject(struct ib_uobject *uobj, bool exclusive)
 {
-	lockdep_check(uobj, exclusive);
+	assert_uverbs_usecnt(uobj, exclusive);
 	uobj->type->type_class->lookup_put(uobj, exclusive);
 	/*
 	 * In order to unlock an object, either decrease its usecnt for
