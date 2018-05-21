Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZoTi7Pcu2t+VoPahmXGaNfAY/aPXUI0sAOLRex6YPhdTdNo8rMc6Fthn8zuH85jV29nhRrQ
ARC-Seal: i=1; a=rsa-sha256; t=1526937781; cv=none;
        d=google.com; s=arc-20160816;
        b=y8OilTf/d8Tfj4I2BAUo3HN89WgJSK6S+LgnYIukXSnToOuvz+JVuL2vsinhnmPHzH
         QcCUUXWSqt8bnxaHnm8HxXjSQWK6fyCZ4FUqSS3/+fZ/SLuXqLZj9h57jwr3kNqiqIe1
         JdwDMRrLtKT3FvWIAWKu+CJ4tP8CLDV3tO6nvAJl2ZEhVow6BNoi6Q/+ttQIQJcw02iE
         sBglMPPmLVNZE1LsDlItHz/p5O4rxGPH2CBPBpHQFnM/ucphTtLTIoGOYpMKwuv0SQCb
         n2TOGlQP/aOiwwgOnbIGxXXi7MQT16WTtxczoJjCjWtjX6Bon8SOsHHovFtTeta/yP5T
         HMJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=yog8J7Qo2JFEmYEMZxNelD05518A1NlO2ni6S9Fb7z0=;
        b=nUo9VmJ6x2CVZ/zv2TRQIWrE0x1/DfvVkSZxtDSrfLLToNUI0+JEEnWf3b3dWdJVgU
         +V+SpEz4gDXpmX6W9AQxAAJECIkkvI2f7G5w+62JFGm715aXbc0YRcaNMzVc7MUwgTcB
         /Rs4DgOKfGfTGWlbip/WMkRYcQL1opb+TTAg6ssfuBLB0DfRDC7m90zGMkCCIp/lC8M2
         zStQanhp7YhUqFW5NpKmMx/ehXrzUzAfDOCvlKxCzCYjmokxf2GiN5OhGReexFOngihL
         8hfFbjl7ViUy1UfHjw5DEf0AYEE3043PIvmJk+lYk47A6r0iPiUD1tB5gp3yubjonXtc
         5JKg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=h7+A7qZW;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=h7+A7qZW;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"Steven Rostedt (VMware)" <rostedt@goodmis.org>
Subject: [PATCH 4.16 023/110] vsprintf: Replace memory barrier with static_key for random_ptr_key update
Date: Mon, 21 May 2018 23:11:20 +0200
Message-Id: <20180521210505.930147328@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210503.823249477@linuxfoundation.org>
References: <20180521210503.823249477@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601110311606408170?=
X-GMAIL-MSGID: =?utf-8?q?1601110311606408170?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Steven Rostedt (VMware) <rostedt@goodmis.org>

commit 85f4f12d51397f1648e1f4350f77e24039b82d61 upstream.

Reviewing Tobin's patches for getting pointers out early before
entropy has been established, I noticed that there's a lone smp_mb() in
the code. As with most lone memory barriers, this one appears to be
incorrectly used.

We currently basically have this:

	get_random_bytes(&ptr_key, sizeof(ptr_key));
	/*
	 * have_filled_random_ptr_key==true is dependent on get_random_bytes().
	 * ptr_to_id() needs to see have_filled_random_ptr_key==true
	 * after get_random_bytes() returns.
	 */
	smp_mb();
	WRITE_ONCE(have_filled_random_ptr_key, true);

And later we have:

	if (unlikely(!have_filled_random_ptr_key))
		return string(buf, end, "(ptrval)", spec);

/* Missing memory barrier here. */

	hashval = (unsigned long)siphash_1u64((u64)ptr, &ptr_key);

As the CPU can perform speculative loads, we could have a situation
with the following:

	CPU0				CPU1
	----				----
				   load ptr_key = 0
   store ptr_key = random
   smp_mb()
   store have_filled_random_ptr_key

				   load have_filled_random_ptr_key = true

				    BAD BAD BAD! (you're so bad!)

Because nothing prevents CPU1 from loading ptr_key before loading
have_filled_random_ptr_key.

But this race is very unlikely, but we can't keep an incorrect smp_mb() in
place. Instead, replace the have_filled_random_ptr_key with a static_branch
not_filled_random_ptr_key, that is initialized to true and changed to false
when we get enough entropy. If the update happens in early boot, the
static_key is updated immediately, otherwise it will have to wait till
entropy is filled and this happens in an interrupt handler which can't
enable a static_key, as that requires a preemptible context. In that case, a
work_queue is used to enable it, as entropy already took too long to
establish in the first place waiting a little more shouldn't hurt anything.

The benefit of using the static key is that the unlikely branch in
vsprintf() now becomes a nop.

Link: http://lkml.kernel.org/r/20180515100558.21df515e@gandalf.local.home

Cc: stable@vger.kernel.org
Fixes: ad67b74d2469d ("printk: hash addresses printed with %p")
Acked-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 lib/vsprintf.c |   26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -1659,19 +1659,22 @@ char *pointer_string(char *buf, char *en
 	return number(buf, end, (unsigned long int)ptr, spec);
 }
 
-static bool have_filled_random_ptr_key __read_mostly;
+static DEFINE_STATIC_KEY_TRUE(not_filled_random_ptr_key);
 static siphash_key_t ptr_key __read_mostly;
 
-static void fill_random_ptr_key(struct random_ready_callback *unused)
+static void enable_ptr_key_workfn(struct work_struct *work)
 {
 	get_random_bytes(&ptr_key, sizeof(ptr_key));
-	/*
-	 * have_filled_random_ptr_key==true is dependent on get_random_bytes().
-	 * ptr_to_id() needs to see have_filled_random_ptr_key==true
-	 * after get_random_bytes() returns.
-	 */
-	smp_mb();
-	WRITE_ONCE(have_filled_random_ptr_key, true);
+	/* Needs to run from preemptible context */
+	static_branch_disable(&not_filled_random_ptr_key);
+}
+
+static DECLARE_WORK(enable_ptr_key_work, enable_ptr_key_workfn);
+
+static void fill_random_ptr_key(struct random_ready_callback *unused)
+{
+	/* This may be in an interrupt handler. */
+	queue_work(system_unbound_wq, &enable_ptr_key_work);
 }
 
 static struct random_ready_callback random_ready = {
@@ -1685,7 +1688,8 @@ static int __init initialize_ptr_random(
 	if (!ret) {
 		return 0;
 	} else if (ret == -EALREADY) {
-		fill_random_ptr_key(&random_ready);
+		/* This is in preemptible context */
+		enable_ptr_key_workfn(&enable_ptr_key_work);
 		return 0;
 	}
 
@@ -1699,7 +1703,7 @@ static char *ptr_to_id(char *buf, char *
 	unsigned long hashval;
 	const int default_width = 2 * sizeof(ptr);
 
-	if (unlikely(!have_filled_random_ptr_key)) {
+	if (static_branch_unlikely(&not_filled_random_ptr_key)) {
 		spec.field_width = default_width;
 		/* string length must be less than default_width */
 		return string(buf, end, "(ptrval)", spec);
