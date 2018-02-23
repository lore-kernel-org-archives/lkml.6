Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2260eQ96+vIuEGNNc2UO68SQfFqsmOR9fYSxAiCGVw/BiY8MKMfRAXr7td+hLBJFm+CIqmHZ
ARC-Seal: i=1; a=rsa-sha256; t=1519410864; cv=none;
        d=google.com; s=arc-20160816;
        b=uaK8rM1TufDBqOJ509F6+0eD6SCGs2K1IdgZjyzyVE046J1IUD7ifA2GZEOetSAB5P
         +ztfYK78hIiYD5LgHyvWDqdJw7pElXa5U9V+2kR7kTcKNd7Ar48QXN5rj+QItE7fArLp
         X5ZfqIWHKWV98JeCkI3PheZCkIjVycTwbZIUfWyMRsLJg7OOQpgFy+IHjuVrqYpSIqKn
         YVi8M11foZekTDh89wu5thCCbcsj9DQIB7GRHMkXbH0jF+0JanOEyQH+EWX0xn5/7w2V
         i93NEn/xn3zmcxMBATcAOvJkeY5eGu94T9gN86CdGEnCiSh3eb9EKQ0pZHByZgn/28iU
         bxVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=/3EJjkdSfzZ20XZy2GVYRT9SLMmAoJfjeVSxHkMsJds=;
        b=IYJpUiW0UOhQGE07UDzOiraGK7IEkMdunXpOgLkaMbBGio1dp8+jku67EOGrFFIvSG
         LbzwDEfb+h/9tw/l73K+oGvvtMVnPGs5awEl+t2IGnMLqj/6FO8bdK9kDe/wYMAluJn1
         R42jMGnevNCIf7V5v84T+j8zblx3ayIguhNzc/CjjHP/dUpgz/jSyircw7IAVrl8L7vv
         8E7lg78gpySzyKlRpS4WB1kxNIZHRaaoydzYW7X62VcWn8AEwaAqELzNNquY/ItG9qZn
         tEz+eJ1VmCNkXGGvXVLD+3N+zOLkyLIbkQKcbRnEa4woEh+lKMNIVKhc4XZPwledBFfB
         +dsw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	David Howells <dhowells@redhat.com>,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 4.4 009/193] Provide a function to create a NUL-terminated string from unterminated data
Date: Fri, 23 Feb 2018 19:24:02 +0100
Message-Id: <20180223170327.540076280@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593217552383694521?=
X-GMAIL-MSGID: =?utf-8?q?1593217766480936283?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Howells <dhowells@redhat.com>

commit f35157417215ec138c920320c746fdb3e04ef1d5 upstream.

Provide a function, kmemdup_nul(), that will create a NUL-terminated string
from an unterminated character array where the length is known in advance.

This is better than kstrndup() in situations where we already know the
string length as the strnlen() in kstrndup() is superfluous.

Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/string.h |    1 +
 mm/util.c              |   24 ++++++++++++++++++++++++
 2 files changed, 25 insertions(+)

--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -122,6 +122,7 @@ extern char *kstrdup(const char *s, gfp_
 extern const char *kstrdup_const(const char *s, gfp_t gfp);
 extern char *kstrndup(const char *s, size_t len, gfp_t gfp);
 extern void *kmemdup(const void *src, size_t len, gfp_t gfp);
+extern char *kmemdup_nul(const char *s, size_t len, gfp_t gfp);
 
 extern char **argv_split(gfp_t gfp, const char *str, int *argcp);
 extern void argv_free(char **argv);
--- a/mm/util.c
+++ b/mm/util.c
@@ -80,6 +80,8 @@ EXPORT_SYMBOL(kstrdup_const);
  * @s: the string to duplicate
  * @max: read at most @max chars from @s
  * @gfp: the GFP mask used in the kmalloc() call when allocating memory
+ *
+ * Note: Use kmemdup_nul() instead if the size is known exactly.
  */
 char *kstrndup(const char *s, size_t max, gfp_t gfp)
 {
@@ -118,6 +120,28 @@ void *kmemdup(const void *src, size_t le
 EXPORT_SYMBOL(kmemdup);
 
 /**
+ * kmemdup_nul - Create a NUL-terminated string from unterminated data
+ * @s: The data to stringify
+ * @len: The size of the data
+ * @gfp: the GFP mask used in the kmalloc() call when allocating memory
+ */
+char *kmemdup_nul(const char *s, size_t len, gfp_t gfp)
+{
+	char *buf;
+
+	if (!s)
+		return NULL;
+
+	buf = kmalloc_track_caller(len + 1, gfp);
+	if (buf) {
+		memcpy(buf, s, len);
+		buf[len] = '\0';
+	}
+	return buf;
+}
+EXPORT_SYMBOL(kmemdup_nul);
+
+/**
  * memdup_user - duplicate memory region from user space
  *
  * @src: source address in user space
