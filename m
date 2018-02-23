Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224dmE+xmWkFfnhjM/EehwePyGaAQwP2VwXaMajER3ub/URvu9pZ6AE20qzgtcXkWhMlQ+I+
ARC-Seal: i=1; a=rsa-sha256; t=1519412239; cv=none;
        d=google.com; s=arc-20160816;
        b=rFcclJ7RZQSaQN0567Kss7h+f46Us4J9C16FfZ7y1BSjdXfVM4UT9tSCP61xn2j9co
         jDUWwVdu299tT+9uFI7xhy893HqHEHcbBnx7hos8btwKFvRtp/CukiKzcAlG0yrFSpox
         S3eYK6Sl+QBa1KCrZg0QYg0f4Sb5M1VAuz8vy5HCn1fBfNnrDFskK43ON39CapsEVRjT
         5TM4ltY9KD1l8lj2ok4M003SrDAq7vpMo4XKcuTNG3HBoDjt8b356+tLqP8gBC2EfrsE
         iAJ7FxjX779GLP2nofgyRYoFV0u23sGfAxl3s/0ekw+KT+uCsxlmVD074UDlQty5BWTX
         GSRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=2BXqbO32PxuwbvW3hoHZbfPIKU/BKZBrF+FtANLbc6g=;
        b=R5M5mP7j2tQY2f6WYpvMlhpwI8Ld3ymGpaXyFRRfhYB/7JVYHunHJT8uqMVDJckDhH
         a1FG2zoJ3gS4fVkH6bzoeblHcOzgarwWtAcEKF1mQCaUvpeDW5VTZKVor6+xsdNUP6BX
         IXsHHTS7m1DedV7BXHGN+0vXiDPmEFXcrghRbyK0/D+1/Or7olnXA3cM+6fqctUhJlMk
         m+eAF+NHo4ywi8q1kIr3DJCQvZCLRGO+cMp0Jafzf7lSxPgxipj8OUDjhwUyPpqeNZK0
         +b6euANHkunVifHb9SjdEcdBAYfK7DhSakYyXz3eMTzfNTPocU1K/5lpTm6h7sjSAiVl
         Hw1w==
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
Subject: [PATCH 4.15 13/45] netfilter: x_tables: fix int overflow in xt_alloc_table_info()
Date: Fri, 23 Feb 2018 19:28:52 +0100
Message-Id: <20180223170717.445038853@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170715.197760019@linuxfoundation.org>
References: <20180223170715.197760019@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593217534990919232?=
X-GMAIL-MSGID: =?utf-8?q?1593219208474581171?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
 net/netfilter/x_tables.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/net/netfilter/x_tables.c
+++ b/net/netfilter/x_tables.c
@@ -39,7 +39,6 @@ MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Harald Welte <laforge@netfilter.org>");
 MODULE_DESCRIPTION("{ip,ip6,arp,eb}_tables backend module");
 
-#define SMP_ALIGN(x) (((x) + SMP_CACHE_BYTES-1) & ~(SMP_CACHE_BYTES-1))
 #define XT_PCPU_BLOCK_SIZE 4096
 
 struct compat_delta {
@@ -1000,7 +999,7 @@ struct xt_table_info *xt_alloc_table_inf
 		return NULL;
 
 	/* Pedantry: prevent them from hitting BUG() in vmalloc.c --RR */
-	if ((SMP_ALIGN(size) >> PAGE_SHIFT) + 2 > totalram_pages)
+	if ((size >> PAGE_SHIFT) + 2 > totalram_pages)
 		return NULL;
 
 	info = kvmalloc(sz, GFP_KERNEL);
