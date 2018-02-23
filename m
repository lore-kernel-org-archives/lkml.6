Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuLY3iPy6vKxvwJsYWKRJdnAVFUKS+bqbsKw9TwW+HxBV19kh2mu5Jm2zNMO4i0HUpFiBDY
ARC-Seal: i=1; a=rsa-sha256; t=1519410801; cv=none;
        d=google.com; s=arc-20160816;
        b=OBIdyFHrEqbAOJn7fbgabw1+K/8bAAfJdJMR+Ddym0it25FSc8I9qlUVHzGe5sQjQk
         4eOUOxzZUP6KHQyk87LG8QkUogkKgEq/uXg0gLMF6d2NpcTG7a+280wbtsREBRTUH7Ni
         b15JEZ+AqaVwCzOzvRB4gh87mZ1BG37Nw5JGQ3TZ9ItgDRr9XdKegdKbzRxY5lmuMSGl
         wy/50s5jWj6+9L3VV+VthLfdkhJR5eEFza+HtuFpk4SEc/Ei9JU8rl6M9hLs/YZjlUYP
         kAH4kyn2skyq9I/Rvh4/CBZ6jWn7BolpJScIbMEftRtD8NwsvzdLqeQdZrVDd1/EIJeO
         Nvjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=J9qgXukxcpAIcB/AyfAt+GnWaCEGNQT3zusfMGNtUEE=;
        b=oPYzVbuzNaAzGhp28NNB6dkWPDkOlPU61msmODeQ6aRWwY49NXwBt55if5ImWB8q0N
         3sovAytar6pALugBZVnVXsPUPaIcFoWPxLI+3xt5ysU9CF1IoNMAuJFCHf7GD9otq0jh
         rPmQupfuknwNH4SeiFVm29KYlZmqSQPL9/c8ZJ0DUBFEQGnjbnemxmhy5ve53CUOLVnf
         F1kDEmYdS5ykD5ePT2V8tjEn5CzdHCYIvpKyZlKR7tINWf87Z1RoC3wsRliUt1FyUBDO
         TvImEM/rdd4fFmb5X7D5gTlOM/GBpighGNbNJt7fYjYSIB0OCrPB0ye4ZGLdfZgr0IF4
         wZsw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	syzbot+5cb189720978275e4c75@syzkaller.appspotmail.com,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Florian Westphal <fw@strlen.de>,
	Eric Dumazet <edumazet@google.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 4.4 019/193] netfilter: xt_RATEEST: acquire xt_rateest_mutex for hash insert
Date: Fri, 23 Feb 2018 19:24:12 +0100
Message-Id: <20180223170329.070324493@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593217546378915154?=
X-GMAIL-MSGID: =?utf-8?q?1593217701005641128?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Cong Wang <xiyou.wangcong@gmail.com>

commit 7dc68e98757a8eccf8ca7a53a29b896f1eef1f76 upstream.

rateest_hash is supposed to be protected by xt_rateest_mutex,
and, as suggested by Eric, lookup and insert should be atomic,
so we should acquire the xt_rateest_mutex once for both.

So introduce a non-locking helper for internal use and keep the
locking one for external.

Reported-by: <syzbot+5cb189720978275e4c75@syzkaller.appspotmail.com>
Fixes: 5859034d7eb8 ("[NETFILTER]: x_tables: add RATEEST target")
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
Reviewed-by: Florian Westphal <fw@strlen.de>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/netfilter/xt_RATEEST.c |   22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

--- a/net/netfilter/xt_RATEEST.c
+++ b/net/netfilter/xt_RATEEST.c
@@ -40,23 +40,31 @@ static void xt_rateest_hash_insert(struc
 	hlist_add_head(&est->list, &rateest_hash[h]);
 }
 
-struct xt_rateest *xt_rateest_lookup(const char *name)
+static struct xt_rateest *__xt_rateest_lookup(const char *name)
 {
 	struct xt_rateest *est;
 	unsigned int h;
 
 	h = xt_rateest_hash(name);
-	mutex_lock(&xt_rateest_mutex);
 	hlist_for_each_entry(est, &rateest_hash[h], list) {
 		if (strcmp(est->name, name) == 0) {
 			est->refcnt++;
-			mutex_unlock(&xt_rateest_mutex);
 			return est;
 		}
 	}
-	mutex_unlock(&xt_rateest_mutex);
+
 	return NULL;
 }
+
+struct xt_rateest *xt_rateest_lookup(const char *name)
+{
+	struct xt_rateest *est;
+
+	mutex_lock(&xt_rateest_mutex);
+	est = __xt_rateest_lookup(name);
+	mutex_unlock(&xt_rateest_mutex);
+	return est;
+}
 EXPORT_SYMBOL_GPL(xt_rateest_lookup);
 
 void xt_rateest_put(struct xt_rateest *est)
@@ -104,8 +112,10 @@ static int xt_rateest_tg_checkentry(cons
 		rnd_inited = true;
 	}
 
-	est = xt_rateest_lookup(info->name);
+	mutex_lock(&xt_rateest_mutex);
+	est = __xt_rateest_lookup(info->name);
 	if (est) {
+		mutex_unlock(&xt_rateest_mutex);
 		/*
 		 * If estimator parameters are specified, they must match the
 		 * existing estimator.
@@ -143,11 +153,13 @@ static int xt_rateest_tg_checkentry(cons
 
 	info->est = est;
 	xt_rateest_hash_insert(est);
+	mutex_unlock(&xt_rateest_mutex);
 	return 0;
 
 err2:
 	kfree(est);
 err1:
+	mutex_unlock(&xt_rateest_mutex);
 	return ret;
 }
 
