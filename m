Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtbZ0vo3uZOkzOyXGrtRdug/emFObSyQLLE2pu179lbbIOGTZEO1ytpeth0bLSOtc9RXfQC
ARC-Seal: i=1; a=rsa-sha256; t=1519410788; cv=none;
        d=google.com; s=arc-20160816;
        b=RhQr4pTXbBjOSlkI9pVOxO0Zh2Mm1z7aTy6Gcf+a52jL8LVvAFOxxHM3dpBtExJ385
         2LdCLsO7TfjUqDE491iI1Yrgggu6EB+c/WzOlHDEGmfdq1ZKMw8Shdkj57LFn0r23VTu
         hFhEVOmnQYn+3aZZnchDo9XznkEnWo9L5jG9D5TQ1BHfAOgGTAtl0lhKuWNl57+UFMlr
         zAj4sz/DRE6+5Uo4ncT4Y9y5cZ5d8mrr2Q7mlqeAw/Uc8dDyYrk1Kr1pSmu2XxdtnSiK
         lNeKetf6nsTLB923ATQRpNZ4r5goouz1pbZl+QS6JegjhEg6GvIt4AC3nwbhtqxWuYJx
         KpIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=cvOC+6qnWEQHzpKgIl6r3fHUvFfYmO3tts/IVjVimE0=;
        b=VMfwkydlxTQrXYmYeoL0h5e4j8sRIdrbCekQVzgP5r/2wRK6TCTdd73DQNd//Xhbr+
         HFJkGNYS6EnubGvNg82SLM5ciwCE5Dfxxz7nnY8zQ1n/HSMgK5ZOuMJooywQ0c3im6oI
         +wBhRMmcH4GhTn5cjDW3TzLd0+Ou0d1zgt+Ols3PJFovJA5QwPG35bM+XD1QkexUFZtz
         yR3Tf+W8xD8ydhl1yTiDgsTOrHoiu8zYwD2V3TMeNXYgs0hQ79dBtWy35eMF8RHtHph6
         nCeSzUEdKgMnZ1am+NDJmUUD8TbMIVnu1GULiNguRxJZoY0plbVPyeLN6TO3StkB4U5G
         HzVA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	syzbot+4396883fa8c4f64e0175@syzkaller.appspotmail.com,
	Dmitry Vyukov <dvyukov@google.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 4.4 015/193] netfilter: x_tables: fix int overflow in xt_alloc_table_info()
Date: Fri, 23 Feb 2018 19:24:08 +0100
Message-Id: <20180223170328.496659583@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593217534990919232?=
X-GMAIL-MSGID: =?utf-8?q?1593217686951082362?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dmitry Vyukov <dvyukov@google.com>

commit 889c604fd0b5f6d3b8694ade229ee44124de1127 upstream.

syzkaller triggered OOM kills by passing ipt_replace.size = -1
to IPT_SO_SET_REPLACE. The root cause is that SMP_ALIGN() in
xt_alloc_table_info() causes int overflow and the size check passes
when it should not. SMP_ALIGN() is no longer needed leftover.

Remove SMP_ALIGN() call in xt_alloc_table_info().

Reported-by: syzbot+4396883fa8c4f64e0175@syzkaller.appspotmail.com
Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/netfilter/x_tables.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

--- a/net/netfilter/x_tables.c
+++ b/net/netfilter/x_tables.c
@@ -38,8 +38,6 @@ MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Harald Welte <laforge@netfilter.org>");
 MODULE_DESCRIPTION("{ip,ip6,arp,eb}_tables backend module");
 
-#define SMP_ALIGN(x) (((x) + SMP_CACHE_BYTES-1) & ~(SMP_CACHE_BYTES-1))
-
 struct compat_delta {
 	unsigned int offset; /* offset in kernel */
 	int delta; /* delta in 32bit user land */
@@ -954,7 +952,7 @@ struct xt_table_info *xt_alloc_table_inf
 		return NULL;
 
 	/* Pedantry: prevent them from hitting BUG() in vmalloc.c --RR */
-	if ((SMP_ALIGN(size) >> PAGE_SHIFT) + 2 > totalram_pages)
+	if ((size >> PAGE_SHIFT) + 2 > totalram_pages)
 		return NULL;
 
 	if (sz <= (PAGE_SIZE << PAGE_ALLOC_COSTLY_ORDER))
