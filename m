Return-Path: <kernel-hardening-return-12226-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELsdnMp53CFxY9grJqinFQl50sL336FUFyGDcfKw4dQ2tAYHazIx0kDIEL0yJqozG90PoNT6
ARC-Seal: i=1; a=rsa-sha256; t=1520479919; cv=none;
        d=google.com; s=arc-20160816;
        b=PaZ4nUNCf4d/5Qa73zaecjjKZmSKctgrrPBxfvVZMBeGR/+CsbeTl3WqHxPvcN5D9w
         G+3Xs8coNnf/ktDVbKz6ji9tu2GGW71CLXJcMAda0xd2j8cH/aGR8MVqrXP3WmjYNbyi
         DTtEDTPDs+2Cvn+sWyXSitJ9+Q4bLfK8tIFOEoHsT445JCEpeWmbG+DnfoP3q57TS3J5
         fN1pT10b2DZLKBjm3w/pZBLQeP97UFflKWHhA0L0CNhUSp7e1D2XWZyzGY1EO/qD/ebQ
         Ego4JfuE9LnwyCdO0Gr10XwgUQWGeeAFyjIT3NLijHtCGLKcG4AxYqCFFMoxg/V3/AnI
         pVCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:delivered-to:list-id:list-subscribe:list-unsubscribe
         :list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=8/JGD5N21/88rNE1JK/d3aTTu7fmmAKPKkK5krfJrBY=;
        b=dXDqJVN95OBqC6gvsfwr+Bn4+NAzrChwWBDbGsAiVaM/aIAsfu6BnchQTOuWCG8jm7
         b7GOmw/W55WV9EvN4SeU4EotySmukl9HDJS5zDtseW5dVWyZS2yYfpEY19LF0llDBFPN
         bu4z2ETzhibxN08rB1meL6Ebd2qbxFLUgOvpyrmtvmYTX2q5/kABrJEnZ+ywsk7y8JyI
         q5MZo47ElFDQioZ3cpOl/4gt12GJTsoZKjO/pwB1lJRMjUpyZsh5kdJCFEcotXrnfam1
         blyJLrfh7HaJJMvXsKlGUvhcWMFWu39je8wPodTmOp6q+tboxtGJHIH8hnGSkTq+zFyQ
         93CA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=Ez7imv8+;
       spf=pass (google.com: domain of kernel-hardening-return-12226-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12226-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=Ez7imv8+;
       spf=pass (google.com: domain of kernel-hardening-return-12226-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12226-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
From: Kees Cook <keescook@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kees Cook <keescook@chromium.org>,
	linux-kernel@vger.kernel.org,
	corbet@lwn.net,
	gustavo@embeddedor.com,
	rostedt@goodmis.org,
	Chris Mason <clm@fb.com>,
	Josef Bacik <jbacik@fb.com>,
	David Sterba <dsterba@suse.com>,
	"David S. Miller" <davem@davemloft.net>,
	Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
	Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
	Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Masahiro Yamada <yamada.masahiro@socionext.com>,
	Borislav Petkov <bp@suse.de>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Ian Abbott <abbotti@mev.co.uk>,
	"Tobin C. Harding" <me@tobin.cc>,
	Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
	Petr Mladek <pmladek@suse.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
	linux-btrfs@vger.kernel.org,
	netdev@vger.kernel.org,
	kernel-hardening@lists.openwall.com
Subject: [PATCH 2/3] net: Remove accidental VLAs from proc buffers
Date: Wed,  7 Mar 2018 19:30:46 -0800
Message-Id: <1520479847-39174-3-git-send-email-keescook@chromium.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1520479847-39174-1-git-send-email-keescook@chromium.org>
References: <1520479847-39174-1-git-send-email-keescook@chromium.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594338752220559863?=
X-GMAIL-MSGID: =?utf-8?q?1594338752220559863?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

In the quest to remove all stack VLAs from the kernel[1], this refactors
the stack array size calculation to avoid using max(), which makes the
compiler think the size isn't fixed.

[1] https://lkml.org/lkml/2018/3/7/621

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 net/ipv4/proc.c | 10 ++++------
 net/ipv6/proc.c | 10 ++++------
 2 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/net/ipv4/proc.c b/net/ipv4/proc.c
index dc5edc8f7564..c23c43803435 100644
--- a/net/ipv4/proc.c
+++ b/net/ipv4/proc.c
@@ -46,8 +46,6 @@
 #include <net/sock.h>
 #include <net/raw.h>
 
-#define TCPUDP_MIB_MAX max_t(u32, UDP_MIB_MAX, TCP_MIB_MAX)
-
 /*
  *	Report socket allocation statistics [mea@utu.fi]
  */
@@ -400,11 +398,11 @@ static int snmp_seq_show_ipstats(struct seq_file *seq, void *v)
 
 static int snmp_seq_show_tcp_udp(struct seq_file *seq, void *v)
 {
-	unsigned long buff[TCPUDP_MIB_MAX];
+	unsigned long buff[SIMPLE_MAX(UDP_MIB_MAX, TCP_MIB_MAX)];
 	struct net *net = seq->private;
 	int i;
 
-	memset(buff, 0, TCPUDP_MIB_MAX * sizeof(unsigned long));
+	memset(buff, 0, sizeof(buff));
 
 	seq_puts(seq, "\nTcp:");
 	for (i = 0; snmp4_tcp_list[i].name; i++)
@@ -421,7 +419,7 @@ static int snmp_seq_show_tcp_udp(struct seq_file *seq, void *v)
 			seq_printf(seq, " %lu", buff[i]);
 	}
 
-	memset(buff, 0, TCPUDP_MIB_MAX * sizeof(unsigned long));
+	memset(buff, 0, sizeof(buff));
 
 	snmp_get_cpu_field_batch(buff, snmp4_udp_list,
 				 net->mib.udp_statistics);
@@ -432,7 +430,7 @@ static int snmp_seq_show_tcp_udp(struct seq_file *seq, void *v)
 	for (i = 0; snmp4_udp_list[i].name; i++)
 		seq_printf(seq, " %lu", buff[i]);
 
-	memset(buff, 0, TCPUDP_MIB_MAX * sizeof(unsigned long));
+	memset(buff, 0, sizeof(buff));
 
 	/* the UDP and UDP-Lite MIBs are the same */
 	seq_puts(seq, "\nUdpLite:");
diff --git a/net/ipv6/proc.c b/net/ipv6/proc.c
index b67814242f78..5b0874c26802 100644
--- a/net/ipv6/proc.c
+++ b/net/ipv6/proc.c
@@ -30,10 +30,8 @@
 #include <net/transp_v6.h>
 #include <net/ipv6.h>
 
-#define MAX4(a, b, c, d) \
-	max_t(u32, max_t(u32, a, b), max_t(u32, c, d))
-#define SNMP_MIB_MAX MAX4(UDP_MIB_MAX, TCP_MIB_MAX, \
-			IPSTATS_MIB_MAX, ICMP_MIB_MAX)
+#define SNMP_MIB_MAX SIMPLE_MAX(SIMPLE_MAX(UDP_MIB_MAX, TCP_MIB_MAX), \
+				SIMPLE_MAX(IPSTATS_MIB_MAX, ICMP_MIB_MAX))
 
 static int sockstat6_seq_show(struct seq_file *seq, void *v)
 {
@@ -199,7 +197,7 @@ static void snmp6_seq_show_item(struct seq_file *seq, void __percpu *pcpumib,
 	int i;
 
 	if (pcpumib) {
-		memset(buff, 0, sizeof(unsigned long) * SNMP_MIB_MAX);
+		memset(buff, 0, sizeof(buff));
 
 		snmp_get_cpu_field_batch(buff, itemlist, pcpumib);
 		for (i = 0; itemlist[i].name; i++)
@@ -218,7 +216,7 @@ static void snmp6_seq_show_item64(struct seq_file *seq, void __percpu *mib,
 	u64 buff64[SNMP_MIB_MAX];
 	int i;
 
-	memset(buff64, 0, sizeof(u64) * SNMP_MIB_MAX);
+	memset(buff64, 0, sizeof(buff64));
 
 	snmp_get_cpu_field64_batch(buff64, itemlist, mib, syncpoff);
 	for (i = 0; itemlist[i].name; i++)
-- 
2.7.4
