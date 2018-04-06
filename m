Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48DQjPdulbIBVwySRJmllSkV21bIRFOB2F35h0RmL17/46RPk6heLq3wou0P5yPa4pQP9aX
ARC-Seal: i=1; a=rsa-sha256; t=1523021450; cv=none;
        d=google.com; s=arc-20160816;
        b=UQ9D69PiHvpJkKjVlXsr31jSksm2ZI/qhe7QHv5CLXN/mudvKqnZyBcKAzFtdMSueP
         AZcZqi1yjZSrwfVe9dM08ydlEKeHSHK5+IBqDpj8wno6eUba48FfOgIEkm5qWamB8xMQ
         t6FpXnEdd0xnMNZSrDbmC4LFVtc4iBkKTjGnNIBVsVxlc+E28UT8Xsvxr4snsi170I8u
         HnX/Ux3nMzVI/xxOV3QRyU2rScUTM4neHRnUiQe96qau8z4tCGmYUnCtoUlYLsTMc9L7
         OGYQ6xt4Kc7d3MMCwsVjBRFwj8ymG3nV55tOAj6hvo5GQ/PCgzWvPBvCn/Riks1YEU53
         9ErQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=+OvFQwsYEnXd2VK3JGArbUahU7jgTZvVeicyJ2D5hwQ=;
        b=UAYRNpUfxS73dgiULFnA2rj/dpOIqJc437pozxmhdisPis9UUqEubG1leIebPRCwKq
         XnOCt7ycUwoUA83LoSJEdfjzb/Hvs1TQPbuem6Bq8Pjgn6TUp9Eqxy7pV29aSR4uezvI
         x9J/4fqCPFgIU8QgO4EmHU9FmbKeF8AnPxhRlO9yW4HTsE+qaVpYs1GGjYR3mMPSvEnS
         40+wNy9DOCuXrj9vQgRN+hgcceaptk6bP8/LeASsz0dTeSChTx/l5ywYFfiPTgF/1SeI
         f05eSZWhqtoavMfLAAAqLGxi2wZZ3uoETIU9aPGRnxNxuxyy9Jdpu7jBnzec97Rpv+hG
         qLOw==
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
Subject: [PATCH 4.4 40/72] netfilter: x_tables: add and use xt_check_proc_name
Date: Fri,  6 Apr 2018 15:23:41 +0200
Message-Id: <20180406084308.508186111@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084305.210085169@linuxfoundation.org>
References: <20180406084305.210085169@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003601518094155?=
X-GMAIL-MSGID: =?utf-8?q?1597003740129810483?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
 net/netfilter/xt_hashlimit.c       |    5 +++--
 net/netfilter/xt_recent.c          |    6 +++---
 4 files changed, 38 insertions(+), 5 deletions(-)

--- a/include/linux/netfilter/x_tables.h
+++ b/include/linux/netfilter/x_tables.h
@@ -247,6 +247,8 @@ unsigned int *xt_alloc_entry_offsets(uns
 bool xt_find_jump_offset(const unsigned int *offsets,
 			 unsigned int target, unsigned int size);
 
+int xt_check_proc_name(const char *name, unsigned int size);
+
 int xt_check_match(struct xt_mtchk_param *, unsigned int size, u_int8_t proto,
 		   bool inv_proto);
 int xt_check_target(struct xt_tgchk_param *, unsigned int size, u_int8_t proto,
--- a/net/netfilter/x_tables.c
+++ b/net/netfilter/x_tables.c
@@ -366,6 +366,36 @@ textify_hooks(char *buf, size_t size, un
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
@@ -668,8 +668,9 @@ static int hashlimit_mt_check(const stru
 
 	if (info->cfg.gc_interval == 0 || info->cfg.expire == 0)
 		return -EINVAL;
-	if (info->name[sizeof(info->name)-1] != '\0')
-		return -EINVAL;
+	ret = xt_check_proc_name(info->name, sizeof(info->name));
+	if (ret)
+		return ret;
 	if (par->family == NFPROTO_IPV4) {
 		if (info->cfg.srcmask > 32 || info->cfg.dstmask > 32)
 			return -EINVAL;
--- a/net/netfilter/xt_recent.c
+++ b/net/netfilter/xt_recent.c
@@ -364,9 +364,9 @@ static int recent_mt_check(const struct
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
