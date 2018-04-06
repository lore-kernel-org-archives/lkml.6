Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/KcoBo2mBGy9///DOEC73n+TWORTlGYBgN/fEboZbPYVsaaSfTZRmdLB9SN7bdKwu6/yeR
ARC-Seal: i=1; a=rsa-sha256; t=1523021586; cv=none;
        d=google.com; s=arc-20160816;
        b=Vl5LD5Hdaziuh6jBejL3+Vp2hNZrxDPwQ+U01//b9p0Z6ivdy6iHWCZtQ9QS3eOf6Q
         P+BiDyAZdGGue//VmeZDHylNr8BRzDJ7axGAQVwf+B9fFWmUmQGLvlI5vclH7rJg0GfQ
         LbFU126YXU4xmoudq2M7L5V2tf8vziXYoAL8AgwNw/CxbQUhSahhUyPXxhjCzM21qO14
         FQWNWOfciknKZCc5GTcwhhnhiOpATKY0DcKgtChGj59EQa2/BldEIsVurcvD4Xr1Tt5D
         6+bIimgWA9d/uN6n3V5dJgGW8HGZL7S093nR/7Uz5nuHJR0WgLi4moupCh5w2UMz3oY4
         Yu3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=hsopG5z7DmoPth+czQ4m5oXG8R0SM5k9cMj1rLEx2eY=;
        b=aT4muWyW0xJ5zgwHYYLBy3KuItNGIvraiG8krlt9W+jN+MvdWW7RoCCVScHfYNxJBt
         Y1uVwRk7KQwvt9GgWuHuk2nHYwn3tDVbmVclY51/lwRKim3+1nCF+cuq1MsIS8DxZX0q
         +flK1TAtIdrdn0matYKm8a7IxNfKNKKkSBjGKmTd3TspvP/4OjE9O8Dlw97HW0O4g4Xi
         5z9mWQaA7Pf+sTAK+rkWEWVsjU+wg21VCok0NcI3SD238ge16MP+5gxzbhAFPbJNuYJD
         OzFAvQSnk3FheNjgtCzU3mLp4q92Zw001ZxZzp4yC/pgyKUbmiRQs/AS2owFGF3B7i9K
         fINg==
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
Subject: [PATCH 4.9 018/102] cpumask: Add helper cpumask_available()
Date: Fri,  6 Apr 2018 15:22:59 +0200
Message-Id: <20180406084334.167293827@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084331.507038179@linuxfoundation.org>
References: <20180406084331.507038179@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003771449094703?=
X-GMAIL-MSGID: =?utf-8?q?1597003883335114358?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -680,6 +680,11 @@ void alloc_bootmem_cpumask_var(cpumask_v
 void free_cpumask_var(cpumask_var_t mask);
 void free_bootmem_cpumask_var(cpumask_var_t mask);
 
+static inline bool cpumask_available(cpumask_var_t mask)
+{
+	return mask != NULL;
+}
+
 #else
 typedef struct cpumask cpumask_var_t[1];
 
@@ -720,6 +725,11 @@ static inline void free_cpumask_var(cpum
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
