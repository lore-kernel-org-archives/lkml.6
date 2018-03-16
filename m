Return-Path: <wvw@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1521224739; cv=none;
        d=google.com; s=arc-20160816;
        b=onbsvo4W5n+myImZxd3JwkvRE3Pa8WPOlhhJy2CPxT5ExjvUzheQlzAoLIcPtgwxhH
         IxCQx3rtGYVpN/kHEvOSnJ/YW5E1UYO8zmwzw0KKt+HpZ6ZqwYjbxF90hgNO3eJ8HmRu
         4o8kviVjC4UXwsdro1tXDVk89gsqq8L+yVlxt+slRIzduANo0jAFPX3IOKu0X+aBtDbt
         rsDqxybZtJWJINnpFFPnCL1me8KRBCSWQlIo1gDO9RSN+DkA4dWzqQb7UQ0WZKweBOiB
         xzGSSYIA60VVXIFyw0+MfxoKQcZN2+N/h0yPK2Pa9QQK+AK/cBeTP7tspLujDVjdFwcb
         /z6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=Gmu+7hOHpcO9sKELnNqHUuwXs6/8tIA9e9UIvLdS3Ww=;
        b=JguaFUkXt350+4rLbB1TetIwj/GLiJbktGKfjT11iIrMIbGti4QEtQ6+6mweXo4Av2
         3vkywPiZwDWoorYBvNG9czWny5/2XIv9eaAbW2KKe6oAuphpLz0BtevoyZtOP3nJpNgU
         Yvc1sRRzwOx71aHphlLKmM+/FFY3y/9lKrGZ7YV+Eu0O5KkzA0eHOjRPDA3zHP7jRaEe
         7LOaztge6TxC3fGUUuZkI8LL1yICs9ULIWOq39jtzPlQ3TGAeDHnL+JBfqub/8kqipaE
         ARxesxZTtklx+x+sgkLR21FaUF2VXqaHrxa7fo8tCPjCzkzinsllPbTorXlBY2XpRygn
         i30Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=sdbZfizO;
       spf=pass (google.com: domain of wvw@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=wvw@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=sdbZfizO;
       spf=pass (google.com: domain of wvw@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=wvw@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
X-Google-Smtp-Source: AG47ELvdV91S3EOP8dTD35owa6w79t5vr1kR0QMp6WHAlYDfDmPmllGknsTXYyla1saHewcz4pI0rQ==
From: Wei Wang <wvw@google.com>
X-Google-Original-From: Wei Wang < wvw@google.com >
To: 
Cc: gregkh@linuxfoundation.org,
	toddpoynor@google.com,
	wei.vince.wang@gmail.com,
	Wei Wang <wvw@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Michal Hocko <mhocko@suse.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Jan Kara <jack@suse.cz>,
	=?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
	Hugh Dickins <hughd@google.com>,
	Matthew Wilcox <willy@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Sherry Cheung <SCheung@nvidia.com>,
	"Oliver O'Halloran" <oohall@gmail.com>,
	Andrey Ryabinin <aryabinin@virtuozzo.com>,
	Huang Ying <ying.huang@intel.com>,
	Dennis Zhou <dennisz@fb.com>,
	Pavel Tatashin <pasha.tatashin@oracle.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mm: add config for readahead window
Date: Fri, 16 Mar 2018 11:25:08 -0700
Message-Id: <20180316182512.118361-1-wvw@google.com>
X-Mailer: git-send-email 2.16.2.804.g6dcf76e118-goog
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595119752476729321?=
X-GMAIL-MSGID: =?utf-8?q?1595119752476729321?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Wei Wang <wvw@google.com>

Change VM_MAX_READAHEAD value from the default 128KB to a configurable
value. This will allow the readahead window to grow to a maximum size
bigger than 128KB during boot, which could benefit to sequential read
throughput and thus boot performance.

Signed-off-by: Wei Wang <wvw@google.com>
---
 include/linux/mm.h | 2 +-
 mm/Kconfig         | 8 ++++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index ad06d42adb1a..d7dc6125833e 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2291,7 +2291,7 @@ int __must_check write_one_page(struct page *page);
 void task_dirty_inc(struct task_struct *tsk);
 
 /* readahead.c */
-#define VM_MAX_READAHEAD	128	/* kbytes */
+#define VM_MAX_READAHEAD	CONFIG_VM_MAX_READAHEAD_KB
 #define VM_MIN_READAHEAD	16	/* kbytes (includes current page) */
 
 int force_page_cache_readahead(struct address_space *mapping, struct file *filp,
diff --git a/mm/Kconfig b/mm/Kconfig
index c782e8fb7235..da9ff543bdb9 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -760,3 +760,11 @@ config GUP_BENCHMARK
 	  performance of get_user_pages_fast().
 
 	  See tools/testing/selftests/vm/gup_benchmark.c
+
+config VM_MAX_READAHEAD_KB
+	int "Default max readahead window size in Kilobytes"
+	default 128
+	help
+	  This sets the VM_MAX_READAHEAD value to allow the readahead window
+	  to grow to a maximum size of configured. Increasing this value will
+	  benefit sequential read throughput.
-- 
2.16.2.804.g6dcf76e118-goog
