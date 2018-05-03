Return-Path: <andreyknvl@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525356958; cv=none;
        d=google.com; s=arc-20160816;
        b=UhSVS9La3U4qpPNJ/VRkNgjd7R6LMXeinZQvorsKJlQz7/pqdrz7DzboqrSbfYApP0
         29B/w5rs7efFST+UbGlgt2aKmIOjops4kqKvka4EnILVHq7lraVusQj+f12BUdx+mP0e
         VfZ3W8VuVgxk596Ne11RXitbWVl3l1OD0DxDBNSdnN+6VlhW83KdNDrhFPQmosJtK4ty
         1h98oN6kIK5YobxTRVheQQWh9Uj2ob+qjK/sJ0TxSt7PFkwGqPiP+zbrnWTGNKv45aM6
         JcCZYh+eAAkMpQ+8NYbgd9WmFLzKVyLF6wI9cSclsZ2/k5xnvfZfUZPk7Pn8wFpJvXAi
         gJkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=M5UHAvrtR5/eJhShSI1YJ0Xmi/BIFkhr39NHkoB1ybI=;
        b=auQLNnj2u6DzcusxPN9p7MuRXuXL/sJzyK5J9rWBSWArUs2f29HRaQG78m0q6nNfmb
         mW1T5m+xjtq5yAWvzui/CdOIu8P57xeAgAGCVK9UwcuBjKDKxxGkKA6PD4X2iAjnmLZA
         5hvY8oQtOArPQqzvemjdkzhkpVzr1C0FgCFLANAq83QtlEKaRPguB06e5faQHlCFIwN/
         EaJ+DHWYt9y6KATXKM6Y/+pM9i4K3SoQsDMmw+DnD/ee+Ef8vdnDngj+2htb8wZvlpRl
         DsmCZAxXhqjt9LTxeUZ29vWxyGZAFo266aQizboF4xHBkFyS2Ly2oODMP6TuX+wLzxZe
         INbg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=dbEUj9y/;
       spf=pass (google.com: domain of andreyknvl@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andreyknvl@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=dbEUj9y/;
       spf=pass (google.com: domain of andreyknvl@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andreyknvl@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
X-Google-Smtp-Source: AB8JxZrtgvBbu51uuNOrM930KRxctyDs8aDRqxQKJDoQnvKSatdZ45lFj+2+C4ayBT0TuQT8vva3KA==
From: Andrey Konovalov <andreyknvl@google.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Mark Rutland <mark.rutland@arm.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Andrey Konovalov <andreyknvl@google.com>,
	James Morse <james.morse@arm.com>,
	Kees Cook <keescook@chromium.org>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Kate Stewart <kstewart@linuxfoundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ingo Molnar <mingo@kernel.org>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
	Zi Yan <zi.yan@cs.rutgers.edu>,
	linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: Dmitry Vyukov <dvyukov@google.com>,
	Kostya Serebryany <kcc@google.com>,
	Evgeniy Stepanov <eugenis@google.com>,
	Lee Smith <Lee.Smith@arm.com>,
	Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
	Jacob Bramley <Jacob.Bramley@arm.com>,
	Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
	Chintan Pandya <cpandya@codeaurora.org>
Subject: [PATCH v2 5/6] lib, arm64: untag addrs passed to strncpy_from_user and strnlen_user
Date: Thu,  3 May 2018 16:15:43 +0200
Message-Id: <98e18e4ca8e40bb8e7ea8e622833ce9123207e1e.1525356769.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
In-Reply-To: <cover.1525356769.git.andreyknvl@google.com>
References: <cover.1525356769.git.andreyknvl@google.com>
In-Reply-To: <cover.1525356769.git.andreyknvl@google.com>
References: <cover.1525356769.git.andreyknvl@google.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599452698192835305?=
X-GMAIL-MSGID: =?utf-8?q?1599452698192835305?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

strncpy_from_user and strnlen_user accept user addresses as arguments, and
do not go through the same path as copy_from_user and others, so here we
need to handle the case of tagged user addresses separately.

Untag user pointers passed to these functions.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 lib/strncpy_from_user.c | 2 ++
 lib/strnlen_user.c      | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/lib/strncpy_from_user.c b/lib/strncpy_from_user.c
index b53e1b5d80f4..97467cd2bc59 100644
--- a/lib/strncpy_from_user.c
+++ b/lib/strncpy_from_user.c
@@ -106,6 +106,8 @@ long strncpy_from_user(char *dst, const char __user *src, long count)
 	if (unlikely(count <= 0))
 		return 0;
 
+	src = untagged_addr(src);
+
 	max_addr = user_addr_max();
 	src_addr = (unsigned long)src;
 	if (likely(src_addr < max_addr)) {
diff --git a/lib/strnlen_user.c b/lib/strnlen_user.c
index 60d0bbda8f5e..8b5f56466e00 100644
--- a/lib/strnlen_user.c
+++ b/lib/strnlen_user.c
@@ -108,6 +108,8 @@ long strnlen_user(const char __user *str, long count)
 	if (unlikely(count <= 0))
 		return 0;
 
+	str = untagged_addr(str);
+
 	max_addr = user_addr_max();
 	src_addr = (unsigned long)str;
 	if (likely(src_addr < max_addr)) {
-- 
2.17.0.441.gb46fe60e1d-goog
