Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELssYs6ON20iEnfYm3SiLrzdrEZD0GnhUdS5P30aM7iSwTuiC3oAkcX5rIjpV5XhvJ3l5SET
ARC-Seal: i=1; a=rsa-sha256; t=1520954880; cv=none;
        d=google.com; s=arc-20160816;
        b=EKp7L2TM1UftrPk0TSGvcMygpBxbm+ugcK3voq/YxRNaP0I0g2swVZcI3Hlnc3lr97
         T9UTulE0V6B7ZCiX0ulURQJpjZRyY6vR22kN7lDxZoRnt4mYt2W5tIPoHA3YH81qthfe
         ndeLibanghFh4cLwTlm14rzEYnxu3xa9eJxKpQlwHOIJGjC9WqTK7Q/OjhOOu8jX9+9v
         jL1yYtZFxPmudKfPYWRAsZMUqAxhVpmI9jT12hUbagMyEKZQOcvVjPrERLFI0cVxN14w
         p+WXH9Wrzg9CQWD9P2nxTSRtG/7X+pwfiACdwM8pMLST2XN2fLxFH2WYCklAL8tgKuSU
         nIrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=rZKKDiWKP2zQIkbxEZoE78wCHXsXH9iNpouSNhK/cog=;
        b=o3b9M82z2R5bDz9tvdrFp1S50DRVzFYC7tdDFvLbNXm+L79hOSvqINLJPQMTsJqzZw
         L/LpxhlGESfEF8+RIilXA6fz8GuNHdaAr4MqGvP9FbWHRWWvjFk0WTfgQPEQpeZ8ZJic
         Vkhp2rNON4OxE3t1C7upyWV6qdl1JQbSCBpjSWyKbSQvRNRnF13bhzZBZ1naycKKMuzr
         gVq3g8lmEX5lAyoig3TR/5ztuf85ONHf0QKecpNV+pOR3qYN4ZFkpbYRcjp8lDNexCh9
         r0/p5DwuGXVlOWKzuPuH+mBxppKRYjWCgNFT1TqGfDQW6aHkEiKTQt5umOyB9vDV6qUn
         cx3w==
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
Subject: [PATCH 4.15 005/146] IB/uverbs: Improve lockdep_check
Date: Tue, 13 Mar 2018 16:22:52 +0100
Message-Id: <20180313152321.008018029@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152320.439085687@linuxfoundation.org>
References: <20180313152320.439085687@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594836784682141568?=
X-GMAIL-MSGID: =?utf-8?q?1594836784682141568?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
