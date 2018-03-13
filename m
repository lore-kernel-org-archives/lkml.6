Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELteo589p6MuNLW4OYl67Lch5tKEy4Fn5VaKJV6BXbql/q7MBDnLQkwfmpG4OBxHyZFNSHVM
ARC-Seal: i=1; a=rsa-sha256; t=1520955564; cv=none;
        d=google.com; s=arc-20160816;
        b=vclUhp4UR0+5ciZvQi1WFI8DMv7USUE66abhpzHSqCocqR4Y2/qVb5WXsuYz7/KBZD
         gMlozch3jqsAbP+2Y1Kr6jr/ruh6mX2FWIAVMkaP0CkusGzrPyHUexifIv6t7mKokDXw
         Diofq+s72sn5bcN5ff6plabt6ZGPJnmwZ650lJmfyCKDlBfPD6PjGSlfnkTt5aMRXhZA
         uB6IaTTWpPTDjVEhsN+Wnrtt0KG0iQjqTu40tJBnvaLjyDUUSYRQUvY1ic/vhALpMJhQ
         ZaVKhZehNtc1hQjSjuWF7xz2MzxKHkmimetf67cToRqgMnaS2S6jfTDbWFUJhtsEZ8TH
         m3qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=zwMT6G2CIjo0qgVSMWf8qnx3PULdAhWaTlv5BOE9uVI=;
        b=UmnPGyVHJnrjvuZ89ztFxDusArZ5zLFt6JWbrJjhrZBR9v6Glwox3BosET06Tj0aPb
         aJIgxlpOXzlmyrweGHvW6EWXyhgCP9P+Rdtmr8nTjUUVILK5V1qn5plLSdKp8lnHHNr4
         lDvykzpZj5sweopXCeIh78btFHkmzQzY/oOrGQSuX9TIbgElSAN+wXQwpCm/lIbR8GMf
         MyqvADnuBeQ4M0WwGJj9vD1dYNPR4YAQ2SQcT2Zz1G5Kk/9TguFWRliSakS5dg0XOrGG
         Gs+7ZkG9f8VpoTvFTPrWCZ0sqsOfRjpbhhz5dCPvxW1fydI9gJs7H2NrRZ+FOPVJePuj
         m9Ow==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Mike Snitzer <snitzer@redhat.com>
Subject: [PATCH 4.14 093/140] dm bufio: avoid false-positive Wmaybe-uninitialized warning
Date: Tue, 13 Mar 2018 16:24:56 +0100
Message-Id: <20180313152504.405779344@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152458.201155692@linuxfoundation.org>
References: <20180313152458.201155692@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594836920413426807?=
X-GMAIL-MSGID: =?utf-8?q?1594837501882016046?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit 590347e4000356f55eb10b03ced2686bd74dab40 upstream.

gcc-6.3 and earlier show a new warning after a seemingly unrelated
change to the arm64 PAGE_KERNEL definition:

In file included from drivers/md/dm-bufio.c:14:0:
drivers/md/dm-bufio.c: In function 'alloc_buffer':
include/linux/sched/mm.h:182:56: warning: 'noio_flag' may be used uninitialized in this function [-Wmaybe-uninitialized]
  current->flags = (current->flags & ~PF_MEMALLOC_NOIO) | flags;
                                                        ^

The same warning happened earlier on linux-3.18 for MIPS and I did a
workaround for that, but now it's come back.

gcc-7 and newer are apparently smart enough to figure this out, and
other architectures don't show it, so the best I could come up with is
to rework the caller slightly in a way that makes it obvious enough to
all arm64 compilers what is happening here.

Fixes: 41acec624087 ("arm64: kpti: Make use of nG dependent on arm64_kernel_unmapped_at_el0()")
Link: https://patchwork.kernel.org/patch/9692829/
Cc: stable@vger.kernel.org
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
[snitzer: moved declarations inside conditional, altered vmalloc return]
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/md/dm-bufio.c |   16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

--- a/drivers/md/dm-bufio.c
+++ b/drivers/md/dm-bufio.c
@@ -386,9 +386,6 @@ static void __cache_size_refresh(void)
 static void *alloc_buffer_data(struct dm_bufio_client *c, gfp_t gfp_mask,
 			       enum data_mode *data_mode)
 {
-	unsigned noio_flag;
-	void *ptr;
-
 	if (c->block_size <= DM_BUFIO_BLOCK_SIZE_SLAB_LIMIT) {
 		*data_mode = DATA_MODE_SLAB;
 		return kmem_cache_alloc(DM_BUFIO_CACHE(c), gfp_mask);
@@ -412,16 +409,15 @@ static void *alloc_buffer_data(struct dm
 	 * all allocations done by this process (including pagetables) are done
 	 * as if GFP_NOIO was specified.
 	 */
+	if (gfp_mask & __GFP_NORETRY) {
+		unsigned noio_flag = memalloc_noio_save();
+		void *ptr = __vmalloc(c->block_size, gfp_mask, PAGE_KERNEL);
 
-	if (gfp_mask & __GFP_NORETRY)
-		noio_flag = memalloc_noio_save();
-
-	ptr = __vmalloc(c->block_size, gfp_mask, PAGE_KERNEL);
-
-	if (gfp_mask & __GFP_NORETRY)
 		memalloc_noio_restore(noio_flag);
+		return ptr;
+	}
 
-	return ptr;
+	return __vmalloc(c->block_size, gfp_mask, PAGE_KERNEL);
 }
 
 /*
