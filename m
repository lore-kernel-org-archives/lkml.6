Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CD59C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 21:03:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4162B206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 21:03:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mailprotect.be header.i=@mailprotect.be header.b="ETQAXqWr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727671AbfAIVDA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 16:03:00 -0500
Received: from out002.mailprotect.be ([83.217.72.86]:52053 "EHLO
        out002.mailprotect.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727463AbfAIVCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 16:02:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mailprotect.be; s=mail; h=Content-Transfer-Encoding:MIME-Version:Message-Id
        :Date:Subject:Cc:To:From:reply-to:sender:bcc:in-reply-to:references:
        content-type; bh=dAWHnBVifCdpTGDNfla1j4qfIcG66d7Hc1cBkKXWv0w=; b=ETQAXqWrytRs
        CeaIHRIZjG8aCVkCK5d2LUd77+5FuKSWQfsk2we9zYyYOv6xOshueEmB1i0/zSHpMuRDFhpwyVbmy
        lFrlCI1CvIxBGhMYn4P5phnKUKoEvs5KJ5xt7UYgcDK0HFdqOSMxMpLA0ypdwWYx7A9ur4CWAPMXE
        DDcZsRQa8GNpMCG8RMRetwzDi/B0/Dm/07ET38iun61x8Rx3meuw2MJPZ//5yvzvcblUJc0095VNm
        rbHpkOSBIPVqaGE6H0suDUkUv4Rg7MDev4iXxQCacSqByp1pJWUC0GxayevYzvFSlzYZgWPv9TiO7
        X9bAFEzw3XtGUruqZfEq5g==;
Received: from smtp-auth.mailprotect.be ([178.208.39.159])
        by com-mpt-out002.mailprotect.be with esmtp (Exim 4.89)
        (envelope-from <bvanassche@acm.org>)
        id 1ghKzk-0009BS-HD; Wed, 09 Jan 2019 22:02:37 +0100
Received: from desktop-bart.svl.corp.google.com (unknown [104.133.8.89])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by smtp-auth.mailprotect.be (Postfix) with ESMTPSA id 96550C0687;
        Wed,  9 Jan 2019 22:02:15 +0100 (CET)
From:   Bart Van Assche <bvanassche@acm.org>
To:     peterz@infradead.org
Cc:     mingo@redhat.com, tj@kernel.org, longman@redhat.com,
        johannes.berg@intel.com, linux-kernel@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v6 00/16] locking/lockdep: Add support for dynamic keys
Date:   Wed,  9 Jan 2019 13:01:48 -0800
Message-Id: <20190109210204.192109-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.20.1.97.g81188d93c3-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Originating-IP: 178.208.39.159
X-SpamExperts-Domain: mailprotect.be
X-SpamExperts-Username: 178.208.39.128/27
Authentication-Results: mailprotect.be; auth=pass smtp.auth=178.208.39.128/27@mailprotect.be
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: Combined (0.09)
X-Recommended-Action: accept
X-Filter-ID: EX5BVjFpneJeBchSMxfU5t1vnmGkDRFWzyFpD7pRDrx602E9L7XzfQH6nu9C/Fh9KJzpNe6xgvOx
 q3u0UDjvO1tLifGj39bI0bcPyaJsYTb/+zriNZuqQk0xRpGwjn+MTR8dtByWYYhgj25jR+mEA3YO
 AtfhCcV13BpIh8lqRXSSiFVwqwU9VgKUrYQ0lqWyFDaym8oavoPYsm7m1mVEGf0/5ST3nkt5XYDK
 YAuRpmF7E2F3eqKXiTd2ECUghryWsXVhPBs4K8hVtp6La00Uv8ZB14E0iQtvqvjtp9rD8If9bcHJ
 zTYM7Gz36QU/LMAv2NvVTAgxeBzXlksY/yYeSCTg127TqHZDxA/kZB41Rh8wUGmdr3B4qT9RiswA
 A6TjCkmYneWmOLktMt7B24JcugzjEiJdFHfKejKhxr74HTqN0nsLdCG7LGfReC1C1uWeBldNoc4/
 ugpbufbubK+x4pGqVAT1vWFeEhEnVslbRXVRh+7MnWbw7fXOUdDwPDg2bN87qJveuvI4FkaTzox5
 7en0TkQuIdVjxFJSAPHvCxKJKuWBdR7YVGu3dD+xoi67r0TCUZsaG+mLAH7VoDC8TGpF0nrTJnXQ
 ungkKNbjrbxYFX5W98JZfM4UDzp+I2t3/FxvddG4mRHKJlnoc+LvLMw4Oh2LkwsmIC+tUiJAU2Hq
 vcLZCDNz7FE5l8aegTfrXgepXw2uOkh8BWaRmYTapEnuVpgRu+5Csn5Mqn0EOmQ4zJ5Xvbj1fZ7U
 ZAcZAKRxmEeggn4dXb7yqusq0s5DtM/sUUZb14X3gCbNsAtCtmkbcwVca7gGJPckzuMV42ixzBq4
 o6xB5AMMdSDguIlqHHJIe5U4rz33MPOIlGKEX4NMFgsxYIHCku08yYLbMWIz8Sz3rXkToGgoPkqM
 hPcHscFEFmAKKS84AwX/iljz3fd1vw8CKdLIQ0mXmruaJQIitkL3QAQzhbCIUL0r0uNWhfkfrFRq
 Cik1FlhzAnce1KiWgwomWRcGIJOYPo3qjuJ8Dg/kZ2rBdh8HP0IdYe7j8cOpyKA69LF1Ge2GaGfx
 mfos7YTXbqll+CkEp8Abhi88xg9tdbvxd+VhQOn2K5bYwN40eTXlWiUAYdLmsJdAoPJvtp9WlTt+
 Kq0eQx3E5oYrsjSrzniyQYOvVIVbP1OsRtMGMevVVKNikwLQ0fq/FOtFj5jedxzVymPEjnK9ocrD
 Qs1Q7QbJ8LleNweIjcZcgw==
X-Report-Abuse-To: spam@com-mpt-mgt001.mailprotect.be
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter and Ingo,

A known shortcoming of the current lockdep implementation is that it requires
lock keys to be allocated statically. This forces certain unrelated
synchronization objects to share keys and this key sharing can cause false
positive deadlock reports. This patch series adds support for dynamic keys in
the lockdep code and eliminates a class of false positive reports from the
workqueue implementation.

The changes compared to v5 are:
- Modified zap_class() such that it doesn't try to free a list entry that
  is already being freed.
- Added a patch that fixes an existing bug in add_chain_cache().
- Improved the code that reports the size needed for lockdep data structures
  further.
- Rebased and retested this patch series on top of kernel v5.0-rc1.

The changes compared to v4 are:
- Introduced the function lockdep_set_selftest_task() to fix a build failure
  for CONFIG_LOCKDEP=n.
- Fixed a use-after-free issue in is_dynamic_key() by adding the following
  code in that function: if (!debug_locks) return true;
- Changed if (WARN_ON_ONCE(!pf)) into if (!pf) to avoid that the new lockdep
  implementation triggers more kernel warnings than the current implementation.
  This keeps the build happy when doing regression tests.
- Added a synchronize_rcu() call at the end of lockdep_unregister_key() to
  avoid a use-after-free.

The changes compared to v3 are:
- Rework the code that frees objects that are no longer used such that it
  is now guaranteed that a grace period elapses between last use and freeing.
- The lockdep self tests pass again.
- Avoid that the patch that removes all matching lock order entries can
  cause list corruption. Note: the change in this patch to realize that
  is removed again by a later patch. In other words, this change is only
  necessary to make the series bisectable.
- Rebased this patch series on top of the tip/locking/core branch.

The changes compared to v2 are:
- Made sure that all schedule_free_zapped_classes() calls are protected
  with the graph lock.
- When removing a lock class, only recalculate lock chains that have been
  modified.
- Combine a list_del() and list_add_tail() call into a list_move_tail()
  call in register_lock_class().
- Use an RCU read lock instead of the graph lock inside is_dynamic_key().

The changes compared to v1 are:
- Addressed Peter's review comments: remove the list_head that I had added
  to struct lock_list again, replaced all_list_entries and free_list_entries
  by two bitmaps, use call_rcu() to free lockdep objects, add a BUILD_BUG_ON()
  that compares the size of struct lock_class_key and raw_spin_lock_t.
- Addressed the "unknown symbol" errors reported by the build bot by adding a
  few #ifdef / #endif directives. Addressed the 32-bit warnings by using %d
  instead of %ld for array indices and by casting the array indices to
  unsigned int.
- Removed several WARN_ON_ONCE(!class->hash_entry.pprev) statements since
  these duplicate the code in check_data_structures().
- Left out the patch that causes lockdep to complain if no name has been
  assigned to a lock object. That patch namely causes the build bot to
  complain about certain lock objects but I have not yet had the time to
  figure out the identity of these lock objects.
  
Bart.

Bart Van Assche (16):
  locking/lockdep: Fix reported required memory size
  locking/lockdep: Avoid that add_chain_cache() adds an invalid chain to
    the cache
  locking/lockdep: Make zap_class() remove all matching lock order
    entries
  locking/lockdep: Reorder struct lock_class members
  locking/lockdep: Initialize the locks_before and locks_after lists
    earlier
  locking/lockdep: Split lockdep_free_key_range() and
    lockdep_reset_lock()
  locking/lockdep: Make it easy to detect whether or not inside a
    selftest
  locking/lockdep: Free lock classes that are no longer in use
  locking/lockdep: Reuse list entries that are no longer in use
  locking/lockdep: Introduce lockdep_next_lockchain() and
    lock_chain_count()
  locking/lockdep: Reuse lock chains that have been freed
  locking/lockdep: Check data structure consistency
  locking/lockdep: Verify whether lock objects are small enough to be
    used as class keys
  locking/lockdep: Add support for dynamic keys
  kernel/workqueue: Use dynamic lockdep keys for workqueues
  lockdep tests: Test dynamic key registration

 include/linux/lockdep.h                       |  42 +-
 include/linux/workqueue.h                     |  28 +-
 kernel/locking/lockdep.c                      | 940 +++++++++++++++---
 kernel/locking/lockdep_internals.h            |   3 +-
 kernel/locking/lockdep_proc.c                 |  12 +-
 kernel/workqueue.c                            |  60 +-
 lib/locking-selftest.c                        |   2 +
 tools/lib/lockdep/include/liblockdep/common.h |   2 +
 tools/lib/lockdep/include/liblockdep/mutex.h  |  11 +-
 tools/lib/lockdep/tests/ABBA.c                |   9 +
 10 files changed, 923 insertions(+), 186 deletions(-)

-- 
2.20.1.97.g81188d93c3-goog

