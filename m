Return-Path: <kernel-hardening-return-12227-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELs9iVEfDf9HjxOn7fTHInaQ+Z6uBew2720wz1zgS0aipTL/LY63D/PvQExL2wdUaBPP+PjD
ARC-Seal: i=1; a=rsa-sha256; t=1520479927; cv=none;
        d=google.com; s=arc-20160816;
        b=nZpcsWXDT1rVirYfnfnxrHM66k/pvEaChZooRO201mhaWBKDBcVDrnRh9V3ytjLGey
         JaqCY3tttF9Juux6YFVGsj7A9sMCu7f6/l/dJLq1kNMdQ3eJi0Qi6ksY5vcfpzCwjA0r
         ratnxomPMI3lAyItWXaI5x/hKzsl7HmOM6tuIcyuGD4yz3dsuv1zvSStHtwfr5OVKbQH
         kznmmjvN+fHsGdnNOR9KsNG98bnSoVjFoSHCjoTBh9rUvHLaoI3jSYQk7qOGj/it60+j
         pU6dGDj+PKZ0f6wN07IN4FYaZryPI04MBOVwx8E/GyD1kG8q0dBN4J8VTVCl8xGDGnx/
         oGhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:delivered-to:list-id:list-subscribe:list-unsubscribe
         :list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=/vHLZGS16nbwTMecQJI11d8xIWqeetkTGSb9vfbhh9M=;
        b=kiGC7zBb3J+vSXESSRPjQKCQKAWh4FA3BJRU4b6Ydoy+ctYEs0dxkMvDwIhqdGYAAC
         oVvZ/aA/JxrJB0rFY4/eT66yMBz5aT+pKWqZ+h8PS9Hxdfk9nTio5bnVCM70jJJkGMkM
         Wqu5E0wAriY+9i24bE6oQDOqKKga8NPlTk6JZG9Iojgp328JuzO1jFzREd9DXBklXxVO
         tjQMVXESDRMggxoTQdUId9sTtlmsMk3FiUL3eQCaDKUfLMpX4S0d2XnqPny3qaAgorZO
         kvzA0RSAeVt6zYNborGLTzUXBRbPCu6mzf59RR2LMBuGFQDD7O9H1w5+fCh1l80WO0tV
         soag==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=VNJDAjgL;
       spf=pass (google.com: domain of kernel-hardening-return-12227-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12227-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=VNJDAjgL;
       spf=pass (google.com: domain of kernel-hardening-return-12227-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12227-gregkh=linuxfoundation.org@lists.openwall.com;
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
Subject: [PATCH 3/3] btrfs: tree-checker: Avoid accidental stack VLA
Date: Wed,  7 Mar 2018 19:30:47 -0800
Message-Id: <1520479847-39174-4-git-send-email-keescook@chromium.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1520479847-39174-1-git-send-email-keescook@chromium.org>
References: <1520479847-39174-1-git-send-email-keescook@chromium.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594338759916191449?=
X-GMAIL-MSGID: =?utf-8?q?1594338759916191449?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

In the quest to remove all stack VLAs from the kernel[1], this refactors
the stack array size calculation to avoid using max(), which makes the
compiler think the size isn't fixed.

[1] https://lkml.org/lkml/2018/3/7/621

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/btrfs/tree-checker.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index c3c8d48f6618..59bd07694118 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -341,7 +341,8 @@ static int check_dir_item(struct btrfs_root *root,
 		 */
 		if (key->type == BTRFS_DIR_ITEM_KEY ||
 		    key->type == BTRFS_XATTR_ITEM_KEY) {
-			char namebuf[max(BTRFS_NAME_LEN, XATTR_NAME_MAX)];
+			char namebuf[SIMPLE_MAX(BTRFS_NAME_LEN,
+						XATTR_NAME_MAX)];
 
 			read_extent_buffer(leaf, namebuf,
 					(unsigned long)(di + 1), name_len);
-- 
2.7.4
