Return-Path: <agruenba@redhat.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522753981; cv=none;
        d=google.com; s=arc-20160816;
        b=FIISBF0SAJ20EeT1RbpV1ys60azxoAXrefBIWyY4B1vLXOLPNUtbbYOosVeIlBOZaw
         V1zsqjJC5tUJDdIp+93Dg4NfYHfEmt884nTOr1tYUPHdf6LEdY85ar5Hz9zIzGZPxigu
         8fqnQd5hn0pcHTsrdvgrb6OMISFYa+MugFTdwakt/Wd+E0MzL/MFNzNMVTKb7WxFx3sJ
         f+492uQSFYCp1T5xym79Dj1Pet0Ctf7KkEkxbITvQT8Cucbg8RmPzBkkN6umj02s3FHC
         Es9qplIdqYwl2qgK8XcpIHWbN5UZ4v9L7SothSw7AxL8M9YyHnU0ecabIquJV72XdodF
         sg8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:mime-version
         :arc-authentication-results;
        bh=4Bs9pzd+Ka30sx0ZB7WuH6eovKv6YHHmuJatw9/pQbo=;
        b=Z6JQa1khWKBm6szsMJDbXGZXLgAzHx8vopXYuPJB0Xtt51YkgG/yIKl7p9ktBtKOqk
         3jpiceXc53x1t5XdhTZstgAORH/vkpweKbW9xxJ/3Ot2ExsHmE6ka37TKz+Fa7jnhJk6
         TU/MknLK40/ZjdSfPv9SrQoeBzfuDNPWn8YJBqgt0UEm6FDl3Y5qGLJW1FvM8woFkgDZ
         QSnD3CsskOVVlRgrSNDWh7xxBoMJ7CvGzpuxyZwte29do+NI/LiaoS8/vffjk18h5UGw
         xviMGSsRzl9PznDq82TWq3JvpVqROjPWxejhF4bHDRHrRZdJcRlxyF8cPzJb9geukpfK
         Pg2w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of agruenba@redhat.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=agruenba@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of agruenba@redhat.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=agruenba@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
X-Google-Smtp-Source: AIpwx49fUstCN8al6wbjSjCU74jhqqrVa9b+Iz6ixuKuSMTTPsMwRH30X+gKwrz6CaU+h+dp/p93kWtYOhfyDyd5vJE=
MIME-Version: 1.0
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Tue, 3 Apr 2018 13:13:00 +0200
Message-ID: <CAHc6FU4B9SeO_5LcVmf4OhYeYW0K1V+LjKe2TJ9U4DipVCqNVw@mail.gmail.com>
Subject: How to get lockref patch merged?
To: Andrew Morton <akpm@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Herbert Xu <herbert@gondor.apana.org.au>
Cc: Bob Peterson <rpeterso@redhat.com>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596723278896067339?=
X-GMAIL-MSGID: =?utf-8?q?1596723278896067339?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hello,

what's the best way to get the following lockref patch merged? The
maintainers file doesn't list a maintainer. Should we go straight to
Linus? Does one of you want to take it?

We have a gfs2 patch that depends on it.

Thanks,
Andreas

---------- Forwarded message ----------
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: 29 March 2018 at 14:06
Subject: [PATCH v2 1/2] lockref: Add lockref_put_not_zero
To: cluster-devel@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, NeilBrown
<neilb@suse.com>, Thomas Graf <tgraf@suug.ch>, Herbert Xu
<herbert@gondor.apana.org.au>, Tom Herbert <tom@quantonium.net>,
Andreas Gruenbacher <agruenba@redhat.com>


Put a lockref unless the lockref is dead or its count would become zero.
This is the same as lockref_put_or_lock except that the lock is never
left held.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 include/linux/lockref.h |  1 +
 lib/lockref.c           | 28 ++++++++++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/include/linux/lockref.h b/include/linux/lockref.h
index 2eac32095113..99f17cc8e163 100644
--- a/include/linux/lockref.h
+++ b/include/linux/lockref.h
@@ -37,6 +37,7 @@ struct lockref {
 extern void lockref_get(struct lockref *);
 extern int lockref_put_return(struct lockref *);
 extern int lockref_get_not_zero(struct lockref *);
+extern int lockref_put_not_zero(struct lockref *);
 extern int lockref_get_or_lock(struct lockref *);
 extern int lockref_put_or_lock(struct lockref *);

diff --git a/lib/lockref.c b/lib/lockref.c
index 47169ed7e964..3d468b53d4c9 100644
--- a/lib/lockref.c
+++ b/lib/lockref.c
@@ -80,6 +80,34 @@ int lockref_get_not_zero(struct lockref *lockref)
 }
 EXPORT_SYMBOL(lockref_get_not_zero);

+/**
+ * lockref_put_not_zero - Decrements count unless count <= 1 before decrement
+ * @lockref: pointer to lockref structure
+ * Return: 1 if count updated successfully or 0 if count would become zero
+ */
+int lockref_put_not_zero(struct lockref *lockref)
+{
+       int retval;
+
+       CMPXCHG_LOOP(
+               new.count--;
+               if (old.count <= 1)
+                       return 0;
+       ,
+               return 1;
+       );
+
+       spin_lock(&lockref->lock);
+       retval = 0;
+       if (lockref->count > 1) {
+               lockref->count--;
+               retval = 1;
+       }
+       spin_unlock(&lockref->lock);
+       return retval;
+}
+EXPORT_SYMBOL(lockref_put_not_zero);
+
 /**
  * lockref_get_or_lock - Increments count unless the count is 0 or dead
  * @lockref: pointer to lockref structure
--
2.14.3
