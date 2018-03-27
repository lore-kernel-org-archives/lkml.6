Return-Path: <andreyknvl@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522169875; cv=none;
        d=google.com; s=arc-20160816;
        b=ouvuTCJPYyQlqcdnmzME9pRLNFhvnLbcYaLlvxQ+RChsKGvCgXgFPCBN5kTtf0cCU5
         RxrJoW40m/RdSF7WSfOU3k260ScQQ0mrMcGkl4rR9fPOCsxTDwqZVf5LzNA6rMuwi1rF
         tq4GaU85ihd3PE5TvlfFmJpA/mYS3g7mH8e1zfHZO1Em265pQR0kbgZgoHHPfoCFTai1
         RAORcQcEiXCLueNon2fuh33n1Fg7YwhR1aFKd9ctyt25BaMhIn6iovKLpSZdiX0dtULn
         d9SRo6jNMSFO1UrYXk59k2DFK30rmamkO26FDUOfuaoG1U/ATHov86I8JGMfLGOy4CMG
         eJwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=zLiSxNYCnbZDGOudEgmHw5G2g+Qsz+FQUgsgraVMNdU=;
        b=Q1wXWajroQDe6mU4Mc6+nwKNQtAJl8RBDcDnnSj0ajDuR6qFfZfdFXgnvVKflwMF6j
         UKV5JsuCTGtQVndSWGSzW9CfsPpz5pCDwgeky0KccD8Pon4FwRKqULRGP4IdvvYztTkb
         aCUX/0dtJruR4h2nsklpfPmWI5pQ5wA7ewWFEx3ZGU6Ph5XFRN5I0fDwhQ9i32m3adqP
         oBR4R1VAW3llPtVRNTEJOKSbgYd5u9/2uTjPV9mm0/KzWD9jsTx5L2z5z5ft3Jm3Wajb
         A+75BdBbm4HKkiwFOOQVNQNXVave9CSEwCuQpd3LeuC+QP6Etq4SPDJ1fhC4fJo5TUAh
         EGDg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=dCo2qWPk;
       spf=pass (google.com: domain of andreyknvl@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andreyknvl@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=dCo2qWPk;
       spf=pass (google.com: domain of andreyknvl@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andreyknvl@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
X-Google-Smtp-Source: AIpwx48QI24nLLjNvxbcD2UT2yQZ6pWgReRkH9he5h6cS3juE62VyMrI+6oe5NRpvpUIOW/Duw1EiA==
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
	Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>
Subject: [RFC PATCH v2 5/6] lib, arm64: untag addrs passed to strncpy_from_user and strnlen_user
Date: Tue, 27 Mar 2018 18:57:41 +0200
Message-Id: <1a761b77620457f3bb57d327343765068cd652eb.1522169685.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.17.0.rc0.231.g781580f067-goog
In-Reply-To: <cover.1522169685.git.andreyknvl@google.com>
References: <cover.1522169685.git.andreyknvl@google.com>
In-Reply-To: <cover.1522169685.git.andreyknvl@google.com>
References: <cover.1522169685.git.andreyknvl@google.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596110798857108837?=
X-GMAIL-MSGID: =?utf-8?q?1596110798857108837?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

strncpy_from_user and strnlen_user accept user addresses as arguments, and
do not go through the same path as copy_from_user and others, so here we
need to separately handle the case of tagged user addresses as well.

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
2.17.0.rc0.231.g781580f067-goog
