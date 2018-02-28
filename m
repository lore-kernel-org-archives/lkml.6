Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3608014-1519801745-2-9042186766484959619
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519801744; b=c+llhgz/6jIZur4husOJF447mM8/Wp0ZBcvmCBOM4YYdlwA
    peo41K5eW2JbkpOqOPFnKCts58l7gQCVj0UM6iXmZKnIdck+CttrBccKRGfTizMi
    zLt/tnlybF3PBhJDkSvxT/frLG/Ut1vtVbkgSaWp+BEbda1t48Q78nWINqBVsgeG
    qevTrMSVf3lk521zuIGOJVpTAr/867NPp2w/5d7I0uJbROVndDn6jMHJAENzP0Hi
    8Nzos986+ttcFOg4V8j2tMq9dlWLLqripZxT1tSbc8LIx/dxrFquZ5VcTab8bI1X
    JcjFyyULEfDdFthygecF10QrvU91hYq7swBBUkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :mime-version:list-id:list-unsubscribe:list-archive:list-post
    :list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1519801744; bh=T
    DAEmK3A/P9iEgFpIYas3cJ7FKF2EZ18QyTCwDgqFeg=; b=PDKyWGjiXgXUUZXQI
    zi5m5Q80jqLyvgFRDqADDTjTJyp0CV53VrZ+49MR8gbX80XSE+ptzLAF/roJT+Bf
    QVSV6boIyW7En3HEEHKvGh44NYuhLG2ppSZbpVKn+Sam4h2joBRPIwozvX0Sdn/R
    j2mzH7WYLe4ivMvgg1gb2o0ubHBrmk7X5bP/5MhLyMhwPW9Z3xgabZhEHccbakqw
    +JVSljIvUxBZd5yaP21DGSCZZT1AzSI1ULUpellk8Gi58hzAvn5l1B+77dc6xyn/
    3o3lHjk6pEN4wXgXi/XoGh+JCgscTnGvZzN3iQLKwFRxGErb55yErBSNYHVUuuOk
    9EkQg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=huawei.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=huawei.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=huawei.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=huawei.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Yisheng Xie <xieyisheng1@huawei.com>
To: <gregkh@linuxfoundation.org>
Subject: [PATCH] staging: android: ashmem: Fix possible deadlock in
 ashmem_ioctl
Date: Wed, 28 Feb 2018 14:59:22 +0800
Message-ID: <1519801162-52182-1-git-send-email-xieyisheng1@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: xieyisheng1@huawei.com, devel@driverdev.osuosl.org,
 linux-kernel@vger.kernel.org, arve@android.com,
 syzbot+d7a918a7a8e1c952bc36@syzkaller.appspotmail.com, ben@decadent.org.uk
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

ashmem_mutex may create a chain of dependencies like:

CPU0                                    CPU1
 mmap syscall                           ioctl syscall
 -> mmap_sem (acquired)                 -> ashmem_ioctl
 -> ashmem_mmap                            -> ashmem_mutex (acquired)
    -> ashmem_mutex (try to acquire)       -> copy_from_user
                                              -> mmap_sem (try to acquire)

There is a lock odering problem between mmap_sem and ashmem_mutex causing
a lockdep splat[1] during a syzcaller test. This patch fixes the problem
by move copy_from_user out of ashmem_mutex.

[1] https://www.spinics.net/lists/kernel/msg2733200.html

Fixes: ce8a3a9e76d0 (staging: android: ashmem: Fix a race condition in pin ioctls)
Reported-by: syzbot+d7a918a7a8e1c952bc36@syzkaller.appspotmail.com
Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
---
 drivers/staging/android/ashmem.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/android/ashmem.c b/drivers/staging/android/ashmem.c
index 6dbba5a..8c55706 100644
--- a/drivers/staging/android/ashmem.c
+++ b/drivers/staging/android/ashmem.c
@@ -702,16 +702,14 @@ static int ashmem_pin_unpin(struct ashmem_area *asma, unsigned long cmd,
 	size_t pgstart, pgend;
 	int ret = -EINVAL;
 
+	if (unlikely(copy_from_user(&pin, p, sizeof(pin))))
+		return -EFAULT;
+
 	mutex_lock(&ashmem_mutex);
 
 	if (unlikely(!asma->file))
 		goto out_unlock;
 
-	if (unlikely(copy_from_user(&pin, p, sizeof(pin)))) {
-		ret = -EFAULT;
-		goto out_unlock;
-	}
-
 	/* per custom, you can pass zero for len to mean "everything onward" */
 	if (!pin.len)
 		pin.len = PAGE_ALIGN(asma->size) - pin.offset;
-- 
1.7.12.4

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
