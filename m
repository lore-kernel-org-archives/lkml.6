Return-Path: <SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpcnvFABXeiU+MhAdkZIsIiIhNjgfFGr6glFZL+o4nTLSQmUS2/FmyDqcfIgr+XeFzBD0FH
ARC-Seal: i=1; a=rsa-sha256; t=1527156163; cv=none;
        d=google.com; s=arc-20160816;
        b=tjBM8EkylR5CLznSryKCoxvq+HyViOTA54ubjp0nNpezpl99DLSEgDvbJ1+t2Cxgbd
         mha/B0qDSBcn3NTssv4GGy3FRDuZ/XhGXiWe7Mtr9xvuj8GKzXmu1M9Vkd657WAEid7j
         8CirSuHGTozUEyXJc/JoVq9KvIUPMk0lbJlGzqdvY3JrJJPmk+Lnpk9Hbz23t39TWk03
         KhZuCrgvX4b2IkST28IeZyOEcMbHBvmGPpEX2RNksqRns8cCdaRP1kAFqCd1vWTL0CtI
         cm2HiyPs3Ax74a9s9bacGEPEQxHhsOwZzojZsC7HTIfCh4j9oHC8wGNjkYGoI8uLwO/9
         gApw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=GyVdLmelDnqA6X6a6TBOTWzv/Heim4FHNf1/JVvu9lk=;
        b=rqZX2cCWoKs2rcRS8I4llzrtmCmI8l47InL2khHYT0IFZj4umMELmcVmtMiXAiMkoW
         f6MMTNqvTn1D460MHum5KZC8dsVa3b45s2nIH0CpTQhr3hPIFQsXbFwKDF+Y0Le7/3VV
         HEhpzxlbXS4gvXljg4fKL4riNAAofsBUn6FqICPS/wjnGmO4TmYa4jGNjht3KEDUn4hD
         W5BPdqRlE99sbwT4VcHbdP0EdYtc8Cz3buUTiYHoLyYNPzmA/j502TWXGUZK6Q3NCwIn
         OQYY5AC89kj8wQXGgk/53gL41nQkap5vP4+KSdlkAr+LMMAmYpf4h2M4lmbWvlU++4Sm
         VmsQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=F6Pagy/K;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=F6Pagy/K;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	syzbot+31e8daa8b3fc129e75f2@syzkaller.appspotmail.com,
	Omar Sandoval <osandov@fb.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.16 086/161] loop: fix LOOP_GET_STATUS lock imbalance
Date: Thu, 24 May 2018 11:38:31 +0200
Message-Id: <20180524093028.748525266@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093018.331893860@linuxfoundation.org>
References: <20180524093018.331893860@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601338714974386803?=
X-GMAIL-MSGID: =?utf-8?q?1601339301690307433?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Omar Sandoval <osandov@fb.com>

commit bdac616db9bbadb90b7d6a406144571015e138f7 upstream.

Commit 2d1d4c1e591f made loop_get_status() drop lo_ctx_mutex before
returning, but the loop_get_status_old(), loop_get_status64(), and
loop_get_status_compat() wrappers don't call loop_get_status() if the
passed argument is NULL. The callers expect that the lock is dropped, so
make sure we drop it in that case, too.

Reported-by: syzbot+31e8daa8b3fc129e75f2@syzkaller.appspotmail.com
Fixes: 2d1d4c1e591f ("loop: don't call into filesystem while holding lo_ctl_mutex")
Signed-off-by: Omar Sandoval <osandov@fb.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/block/loop.c |   33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1287,12 +1287,13 @@ static int
 loop_get_status_old(struct loop_device *lo, struct loop_info __user *arg) {
 	struct loop_info info;
 	struct loop_info64 info64;
-	int err = 0;
+	int err;
 
-	if (!arg)
-		err = -EINVAL;
-	if (!err)
-		err = loop_get_status(lo, &info64);
+	if (!arg) {
+		mutex_unlock(&lo->lo_ctl_mutex);
+		return -EINVAL;
+	}
+	err = loop_get_status(lo, &info64);
 	if (!err)
 		err = loop_info64_to_old(&info64, &info);
 	if (!err && copy_to_user(arg, &info, sizeof(info)))
@@ -1304,12 +1305,13 @@ loop_get_status_old(struct loop_device *
 static int
 loop_get_status64(struct loop_device *lo, struct loop_info64 __user *arg) {
 	struct loop_info64 info64;
-	int err = 0;
+	int err;
 
-	if (!arg)
-		err = -EINVAL;
-	if (!err)
-		err = loop_get_status(lo, &info64);
+	if (!arg) {
+		mutex_unlock(&lo->lo_ctl_mutex);
+		return -EINVAL;
+	}
+	err = loop_get_status(lo, &info64);
 	if (!err && copy_to_user(arg, &info64, sizeof(info64)))
 		err = -EFAULT;
 
@@ -1530,12 +1532,13 @@ loop_get_status_compat(struct loop_devic
 		       struct compat_loop_info __user *arg)
 {
 	struct loop_info64 info64;
-	int err = 0;
+	int err;
 
-	if (!arg)
-		err = -EINVAL;
-	if (!err)
-		err = loop_get_status(lo, &info64);
+	if (!arg) {
+		mutex_unlock(&lo->lo_ctl_mutex);
+		return -EINVAL;
+	}
+	err = loop_get_status(lo, &info64);
 	if (!err)
 		err = loop_info64_to_compat(&info64, arg);
 	return err;
