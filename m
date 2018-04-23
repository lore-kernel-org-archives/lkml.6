Return-Path: <kernel-hardening-return-13096-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AB8JxZpDZcV971zI31qyPYa7ZR1mDJN9Ti2254s2yZfVtWrWLzL1Z++BsY9NSShBAhZ9kgp6d7ZN
ARC-Seal: i=1; a=rsa-sha256; t=1524488240; cv=none;
        d=google.com; s=arc-20160816;
        b=rcJ4vsd/MGsWieL/4e5NTGeNVQVZKKCmYJGnGz26LiR5FQI/rqn6lCAlQ4bz/h0Vjt
         JzARpDBnyi55ptRxTC72eDNoIuBGDAFzlMpBktFNoBpelzmF2PgbbSIfIJJadqO/MCG/
         a6v0egElkHE11xeKHpKyI/dUPk7jmGLC16JrpdFH3tNmZLeaMxMRpaR7jdhrz64zZ0Ez
         elTxTJ3IpJ6ZN7aBkRwKAWBd6wbMsJxuYiVZJLnnNg6Zj/m8D5JCq42xlV5g8NWu/Dih
         XYvNr9PS8r+5VjmBMJvYZ9CrWgMciZaEOj6ZYK6zAI8klbmYHzA0VQBzPh22qqmUgLTV
         g3Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:delivered-to:list-id:list-subscribe:list-unsubscribe
         :list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=U09LcbMGiUra9N5GfBrZ9Z2qeNHUrpNbiO9P5fSzuZo=;
        b=oJj+YktNwJQBvRwOpEB9wM5cbcVpQQ/yOXztpbrPYp4BQCiioroOeL6PL4fdejKQa/
         g3MEYu8UbVo9GghgjkYzfcd68BlK6/CvZTNmbo17DAQAGxExowOqrLf9VjevSiTG4PWN
         53qllmahypVcqp2+Cgc4JkadSiGlWYzibDNpI4jhgnmdnqPs2/DXjj2r8o9lxsphXrvM
         iLrmaHPdNmf9enVikps0FOwrDO0c9k7b7RF3nF403XhFVIkAhuOb1bqlW6mtn02nFNMf
         QCAe2c+A/rEMh3C8aZKPMkkm8HQEj44YxvaHeOOJS5FXoDgGd0GHg7FN3KBffnOXQJI2
         7RTQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Xq0nRWIz;
       spf=pass (google.com: domain of kernel-hardening-return-13096-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13096-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Xq0nRWIz;
       spf=pass (google.com: domain of kernel-hardening-return-13096-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13096-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
From: Igor Stoppa <igor.stoppa@gmail.com>
X-Google-Original-From: Igor Stoppa <igor.stoppa@huawei.com>
To: willy@infradead.org,
	keescook@chromium.org,
	paul@paul-moore.com,
	sds@tycho.nsa.gov,
	mhocko@kernel.org,
	corbet@lwn.net
Cc: labbott@redhat.com,
	linux-cc=david@fromorbit.com,
	--cc=rppt@linux.vnet.ibm.com,
	--security-module@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-hardening@lists.openwall.com,
	igor.stoppa@gmail.com,
	Igor Stoppa <igor.stoppa@huawei.com>
Subject: [PATCH 8/9] Preliminary self test for pmalloc rare write
Date: Mon, 23 Apr 2018 16:54:57 +0400
Message-Id: <20180423125458.5338-9-igor.stoppa@huawei.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180423125458.5338-1-igor.stoppa@huawei.com>
References: <20180423125458.5338-1-igor.stoppa@huawei.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598541780529999427?=
X-GMAIL-MSGID: =?utf-8?q?1598541780529999427?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Try to alter locked but modifiable pools.
The test neds some cleanup and expansion.
It is provided primarily as reference.

Signed-off-by: Igor Stoppa <igor.stoppa@huawei.com>
---
 mm/test_pmalloc.c | 75 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/mm/test_pmalloc.c b/mm/test_pmalloc.c
index c8835207a400..e8e945e4a4a3 100644
--- a/mm/test_pmalloc.c
+++ b/mm/test_pmalloc.c
@@ -122,6 +122,80 @@ static void test_oovm(void)
 	pmalloc_destroy_pool(pool);
 }
 
+#define REGION_SIZE (PAGE_SIZE / 4)
+#define REGION_NUMBERS 12
+static inline void fill_region(char *addr, char c)
+{
+	size_t i;
+
+	for (i = 0; i < REGION_SIZE - 1; i++)
+		addr[i] = c;
+	addr[i] = '\0';
+}
+
+static inline void init_regions(char *array)
+{
+	size_t i;
+
+	for (i = 0; i < REGION_NUMBERS; i++)
+		fill_region(array + REGION_SIZE * i, i + 'A');
+}
+
+static inline void show_regions(char *array)
+{
+	size_t i;
+
+	for (i = 0; i < REGION_NUMBERS; i++)
+		pr_info("%s", array + REGION_SIZE * i);
+}
+
+static inline void init_big_injection(char *big_injection)
+{
+	size_t i;
+
+	for (i = 0; i < PAGE_SIZE * 3; i++)
+		big_injection[i] = 'X';
+}
+
+/* Verify rewritable feature. */
+static int test_rare_write(void)
+{
+	struct pmalloc_pool *pool;
+	char *array;
+	char injection[] = "123456789";
+	unsigned short size = sizeof(injection);
+	char *big_injection;
+
+
+	pr_notice("Test pmalloc_rare_write()");
+	pool = pmalloc_create_pool(PMALLOC_RW);
+	array = pzalloc(pool, REGION_SIZE * REGION_NUMBERS);
+	init_regions(array);
+	pmalloc_protect_pool(pool);
+	pr_info("------------------------------------------------------");
+	pmalloc_rare_write(pool, array, injection, size);
+	pmalloc_rare_write(pool, array + REGION_SIZE, injection, size);
+	pmalloc_rare_write(pool,
+			   array + 5 * REGION_SIZE / 2 - size / 2,
+			   injection, size);
+	pmalloc_rare_write(pool, array + 3 * REGION_SIZE - size / 2,
+			   injection, size);
+	show_regions(array);
+	pmalloc_destroy_pool(pool);
+	pr_info("------------------------------------------------------");
+	pool = pmalloc_create_pool(PMALLOC_RW);
+	array = pzalloc(pool, REGION_SIZE * REGION_NUMBERS);
+	init_regions(array);
+	pmalloc_protect_pool(pool);
+	big_injection = vmalloc(PAGE_SIZE * 3);
+	init_big_injection(big_injection);
+	pmalloc_rare_write(pool, array + REGION_SIZE / 2, big_injection,
+			   PAGE_SIZE * 2);
+	show_regions(array);
+	pr_info("------------------------------------------------------");
+	return 0;
+}
+
 /**
  * test_pmalloc()  -main entry point for running the test cases
  */
@@ -135,4 +209,5 @@ void test_pmalloc(void)
 		       test_is_pmalloc_object())))
 		return;
 	test_oovm();
+	test_rare_write();
 }
-- 
2.14.1
