Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/JZw00iVKwrVY+YrwRMRUB2UrlAUaL2kHJRz5u1l7tiA4I1vgXXOyGVCAIi5kB8auTqHOB
ARC-Seal: i=1; a=rsa-sha256; t=1523021943; cv=none;
        d=google.com; s=arc-20160816;
        b=C1/1tT26Br6sgmtKbjctSv8oxzVOwQbnr2h9hQ1/fEIPWq2LTcvQCgyFE1Xk3EpM7V
         stwu8Nqfqp3jSNIsnLi64O+yKt4modOLlHsMuFhdOr2fVgLP3n5gmiM8LgPk9eSp2Itd
         2/ZZHowL4ApfwnuR/PPgVk+nhDTaNC75BF3vIiNwLfUbeIkMEGLMO1x0Ay17yvfnr2Mw
         DFrJ9kxzr6zzysOdZpiKBTwQmccDGDb/On/nVqBJSTqfhHgb1ZB1SXg4owei8pf8msU4
         ODsgQgVqhqzUL1Af4qeZV3ztihpiJ7EB51jOxMugalX+5VIeZ5yB5/U7a1JZ7qOZuAsr
         BwcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=K1/1vim7ljSoEEN5xjAXJUovQZNaKBXuUbHyCk0zy1s=;
        b=qmYKVUTNE1+CiLp+9T27cdsU5Ew01j+q6J3HWGwQQVh9ov9X4h/Olkn+thwwd3cwRB
         9LcoxtsxC9v07xovWbX1ka+2D3BOxQl0wSvHZ5YCqzFOhDp3UcGOUOYCqdhfUHHKk8+X
         ktTfZbwCDh/xsnZCWcXHnr7tZjF/kkeon6QjDupH9OJ57CeC51yd+MHHh+k8IOp1vS3/
         22A6zEjhcxcK1mri0z87iKyaRqdE2jrOLATUXqewnf8WMrfBxmQn+1zN8p2LeRpl71qW
         65ZCBi7WBWm9HKwmgKGyFgHxIjM/UcGQEYy8WRSwakP50lHQ5Z2MQZYRJzJWWcqap4wc
         iOWQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Eric Dumazet <eric.dumazet@gmail.com>,
	syzbot+0502b00edac2a0680b61@syzkaller.appspotmail.com,
	Florian Westphal <fw@strlen.de>,
	Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 4.14 33/67] netfilter: x_tables: add and use xt_check_proc_name
Date: Fri,  6 Apr 2018 15:24:03 +0200
Message-Id: <20180406084345.762337018@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084341.225558262@linuxfoundation.org>
References: <20180406084341.225558262@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003601518094155?=
X-GMAIL-MSGID: =?utf-8?q?1597004256795060475?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Florian Westphal <fw@strlen.de>

commit b1d0a5d0cba4597c0394997b2d5fced3e3841b4e upstream.

recent and hashlimit both create /proc files, but only check that
name is 0 terminated.

This can trigger WARN() from procfs when name is "" or "/".
Add helper for this and then use it for both.

Cc: Eric Dumazet <eric.dumazet@gmail.com>
Reported-by: Eric Dumazet <eric.dumazet@gmail.com>
Reported-by: <syzbot+0502b00edac2a0680b61@syzkaller.appspotmail.com>
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/netfilter/x_tables.h |    2 ++
 net/netfilter/x_tables.c           |   30 ++++++++++++++++++++++++++++++
 net/netfilter/xt_hashlimit.c       |   16 ++++++++++------
 net/netfilter/xt_recent.c          |    6 +++---
 4 files changed, 45 insertions(+), 9 deletions(-)

--- a/include/linux/netfilter/x_tables.h
+++ b/include/linux/netfilter/x_tables.h
@@ -285,6 +285,8 @@ unsigned int *xt_alloc_entry_offsets(uns
 bool xt_find_jump_offset(const unsigned int *offsets,
 			 unsigned int target, unsigned int size);
 
+int xt_check_proc_name(const char *name, unsigned int size);
+
 int xt_check_match(struct xt_mtchk_param *, unsigned int size, u_int8_t proto,
 		   bool inv_proto);
 int xt_check_target(struct xt_tgchk_param *, unsigned int size, u_int8_t proto,
--- a/net/netfilter/x_tables.c
+++ b/net/netfilter/x_tables.c
@@ -423,6 +423,36 @@ textify_hooks(char *buf, size_t size, un
 	return buf;
 }
 
+/**
+ * xt_check_proc_name - check that name is suitable for /proc file creation
+ *
+ * @name: file name candidate
+ * @size: length of buffer
+ *
+ * some x_tables modules wish to create a file in /proc.
+ * This function makes sure that the name is suitable for this
+ * purpose, it checks that name is NUL terminated and isn't a 'special'
+ * name, like "..".
+ *
+ * returns negative number on error or 0 if name is useable.
+ */
+int xt_check_proc_name(const char *name, unsigned int size)
+{
+	if (name[0] == '\0')
+		return -EINVAL;
+
+	if (strnlen(name, size) == size)
+		return -ENAMETOOLONG;
+
+	if (strcmp(name, ".") == 0 ||
+	    strcmp(name, "..") == 0 ||
+	    strchr(name, '/'))
+		return -EINVAL;
+
+	return 0;
+}
+EXPORT_SYMBOL(xt_check_proc_name);
+
 int xt_check_match(struct xt_mtchk_param *par,
 		   unsigned int size, u_int8_t proto, bool inv_proto)
 {
--- a/net/netfilter/xt_hashlimit.c
+++ b/net/netfilter/xt_hashlimit.c
@@ -915,8 +915,9 @@ static int hashlimit_mt_check_v1(const s
 	struct hashlimit_cfg3 cfg = {};
 	int ret;
 
-	if (info->name[sizeof(info->name) - 1] != '\0')
-		return -EINVAL;
+	ret = xt_check_proc_name(info->name, sizeof(info->name));
+	if (ret)
+		return ret;
 
 	ret = cfg_copy(&cfg, (void *)&info->cfg, 1);
 
@@ -933,8 +934,9 @@ static int hashlimit_mt_check_v2(const s
 	struct hashlimit_cfg3 cfg = {};
 	int ret;
 
-	if (info->name[sizeof(info->name) - 1] != '\0')
-		return -EINVAL;
+	ret = xt_check_proc_name(info->name, sizeof(info->name));
+	if (ret)
+		return ret;
 
 	ret = cfg_copy(&cfg, (void *)&info->cfg, 2);
 
@@ -948,9 +950,11 @@ static int hashlimit_mt_check_v2(const s
 static int hashlimit_mt_check(const struct xt_mtchk_param *par)
 {
 	struct xt_hashlimit_mtinfo3 *info = par->matchinfo;
+	int ret;
 
-	if (info->name[sizeof(info->name) - 1] != '\0')
-		return -EINVAL;
+	ret = xt_check_proc_name(info->name, sizeof(info->name));
+	if (ret)
+		return ret;
 
 	return hashlimit_mt_check_common(par, &info->hinfo, &info->cfg,
 					 info->name, 3);
--- a/net/netfilter/xt_recent.c
+++ b/net/netfilter/xt_recent.c
@@ -361,9 +361,9 @@ static int recent_mt_check(const struct
 			info->hit_count, XT_RECENT_MAX_NSTAMPS - 1);
 		return -EINVAL;
 	}
-	if (info->name[0] == '\0' ||
-	    strnlen(info->name, XT_RECENT_NAME_LEN) == XT_RECENT_NAME_LEN)
-		return -EINVAL;
+	ret = xt_check_proc_name(info->name, sizeof(info->name));
+	if (ret)
+		return ret;
 
 	if (ip_pkt_list_tot && info->hit_count < ip_pkt_list_tot)
 		nstamp_mask = roundup_pow_of_two(ip_pkt_list_tot) - 1;
