Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49K10o3YsRiPiiVEeVcoGX6BXqxtKhCw+VhPQUdxxYPUDrM+eXnQ7EIvezjUOCN166Eyvo/
ARC-Seal: i=1; a=rsa-sha256; t=1523021480; cv=none;
        d=google.com; s=arc-20160816;
        b=n7ZeHbNkU0EfGRyDJRkd+ZXPlAqYrUiiNy4TDWEpR9+0Tbtai+2cuTh7/+RLln8/q2
         dM5Hvu+LJgZVInZvaPhXWfp459z+0Y0dQ4kI99WeF8cYF1gShBqGlX+WJN9d+uRUtv4X
         mtOJCi0W5Jqtc/TGUP+whPpRTB17i9imr1JYdvnyYY9vnZMqvtN25UenKKQhqk47H4OV
         54gPSZ0pRtHAz4E0d1DZ7QgGNTj+G6FmAke283knKCYbcokmOG8xDgr0KCnubMFjYRBm
         f3XK42MXv46k8kz281Tt4SgW+AQx4flzQmj0X9rLRvCs/3RvNSiWNgVLu0TJwhI5o5W2
         9PZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=qCsxP1+DSZenPwKBU3N37ufBu2DUDOv8fzMKFdqwdbQ=;
        b=m4Jb3N28lF9nFUnwNiDr8tdxga8r3NHhKQcv2qwy6xFN/Of1b+7004v0xiST0f9lXc
         2OgLtdjpUhjrovNaHURz2bHwDPqjC/G3j0wBgbuv241z30B2QAwIbdd2pXa5DKJ/Rbzl
         DHdVhX/k7sLQmW7LvntkJvvlApcFgRQPggxWJnjghGyG/soEI/pZO/XSBRiKihOUW5R3
         JaIL3kCIEAASrX+922OnmwZuk4p3+H7L+6Ph39kvjjuHmoZAvdHfLkjJVADMnaoQLB0z
         PunuzDrpc/UJGB0GP00ddETlzLxMwJHqJb65/hCkURjCS3izQl8SwsWJfEyiarnbvwVe
         z3KA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Matthias Kaehlcke <mka@chromium.org>,
	Grant Grundler <grundler@chromium.org>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Greg Hackmann <ghackmann@google.com>,
	Michael Davidson <md@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH 4.4 19/72] cpumask: Add helper cpumask_available()
Date: Fri,  6 Apr 2018 15:23:20 +0200
Message-Id: <20180406084306.664033652@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084305.210085169@linuxfoundation.org>
References: <20180406084305.210085169@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003771449094703?=
X-GMAIL-MSGID: =?utf-8?q?1597003771449094703?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matthias Kaehlcke <mka@chromium.org>

commit f7e30f01a9e221067bb4b579e3cfc25cd2617467 upstream.

With CONFIG_CPUMASK_OFFSTACK=y cpumask_var_t is a struct cpumask
pointer, otherwise a struct cpumask array with a single element.

Some code dealing with cpumasks needs to validate that a cpumask_var_t
is not a NULL pointer when CONFIG_CPUMASK_OFFSTACK=y. This is typically
done by performing the check always, regardless of the underlying type
of cpumask_var_t. This works in both cases, however clang raises a
warning like this when CONFIG_CPUMASK_OFFSTACK=n:

kernel/irq/manage.c:839:28: error: address of array
'desc->irq_common_data.affinity' will always evaluate to 'true'
[-Werror,-Wpointer-bool-conversion]

Add the inline helper cpumask_available() which only performs the
pointer check if CONFIG_CPUMASK_OFFSTACK=y.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Cc: Grant Grundler <grundler@chromium.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>
Cc: Greg Hackmann <ghackmann@google.com>
Cc: Michael Davidson <md@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Link: http://lkml.kernel.org/r/20170412182030.83657-1-mka@chromium.org
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/cpumask.h |   10 ++++++++++
 1 file changed, 10 insertions(+)

--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -661,6 +661,11 @@ void alloc_bootmem_cpumask_var(cpumask_v
 void free_cpumask_var(cpumask_var_t mask);
 void free_bootmem_cpumask_var(cpumask_var_t mask);
 
+static inline bool cpumask_available(cpumask_var_t mask)
+{
+	return mask != NULL;
+}
+
 #else
 typedef struct cpumask cpumask_var_t[1];
 
@@ -701,6 +706,11 @@ static inline void free_cpumask_var(cpum
 static inline void free_bootmem_cpumask_var(cpumask_var_t mask)
 {
 }
+
+static inline bool cpumask_available(cpumask_var_t mask)
+{
+	return true;
+}
 #endif /* CONFIG_CPUMASK_OFFSTACK */
 
 /* It's common to want to use cpu_all_mask in struct member initializers,
