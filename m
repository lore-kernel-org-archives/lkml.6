Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18414C65BAF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 01:15:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0E0B20850
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 01:15:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mailprotect.be header.i=@mailprotect.be header.b="jAve/Q8K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0E0B20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbeLGBPL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 20:15:11 -0500
Received: from out002.mailprotect.be ([83.217.72.86]:44521 "EHLO
        out002.mailprotect.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725998AbeLGBNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 20:13:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mailprotect.be; s=mail; h=Content-Transfer-Encoding:MIME-Version:Message-Id
        :Date:Subject:Cc:To:From:reply-to:sender:bcc:in-reply-to:references:
        content-type; bh=hsf7h37nW8pehSJXMykR3iIJj33WobwJ/0sVOK1RxFM=; b=jAve/Q8KEWFq
        BXOyHLWUP5jzoCIyILNWeXyvA4sCa4/C5HFSa0TyKNPEMhK/YAUJgM4a8x+b2xdkTuoHA64jUEcxc
        0lFNd94aC9demnrO0Y6eQzsICO38gqwQZFNGn/GmwuVaiv3p5uNcBDuiND2ql3XWhi0gYc41ODlcz
        qd3k+9ffh11vYXnVT5sSgCzoxmLHLwzHzjHogD4pQOpXoD2JLA5TWw3QF0RRH7PPhcvYD+0TpJZXv
        TYR1Wqw5oLCEU7DHuwSmuHvIf5dCDRQzEEWevsNISawQsUmF+pNebxcgriGDmTjcTOQ3ltRDPxSGO
        h6dDYWeCTowFIri5Rds3GA==;
Received: from smtp-auth.mailprotect.be ([178.208.39.155])
        by com-mpt-out002.mailprotect.be with esmtp (Exim 4.89)
        (envelope-from <bvanassche@acm.org>)
        id 1gV4hG-000C2b-8c; Fri, 07 Dec 2018 02:12:51 +0100
Received: from desktop-bart.svl.corp.google.com (unknown [104.133.8.89])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by smtp-auth.mailprotect.be (Postfix) with ESMTPSA id 36272C0787;
        Fri,  7 Dec 2018 02:12:31 +0100 (CET)
From:   Bart Van Assche <bvanassche@acm.org>
To:     mingo@redhat.com
Cc:     peterz@infradead.org, tj@kernel.org, longman@redhat.com,
        johannes.berg@intel.com, linux-kernel@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v3 00/24] locking/lockdep: Add support for dynamic keys
Date:   Thu,  6 Dec 2018 17:11:24 -0800
Message-Id: <20181207011148.251812-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.20.0.rc2.403.gdbc3b29805-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Originating-IP: 178.208.39.155
X-SpamExperts-Domain: mailprotect.be
X-SpamExperts-Username: 178.208.39.128/27
Authentication-Results: mailprotect.be; auth=pass smtp.auth=178.208.39.128/27@mailprotect.be
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: Combined (0.05)
X-Recommended-Action: accept
X-Filter-ID: EX5BVjFpneJeBchSMxfU5uQSd1NxaeQn8x5CxFBgdGp602E9L7XzfQH6nu9C/Fh9KJzpNe6xgvOx
 q3u0UDjvO1tLifGj39bI0bcPyaJsYTb/+zriNZuqQk0xRpGwjn+MTR8dtByWYYhgj25jR+mEA3YO
 AtfhCcV13BpIh8lqRXSSiFVwqwU9VgKUrYQ0lqWyFDaym8oavoPYsm7m1mVEGf0/5ST3nkt5XYDK
 YAuRpmF7E2F3eqKXiTd2ECUghryWsXVhPBs4K8hVtp6La00Uv8ZB14E0iQtvqvjtp9rD8If9bcHJ
 zTYM7Gz36QU/LMAv2LIdN6g+xapQ+GADhfNh4CTg127TqHZDxA/kZB41Rh8wUGmdr3B4qT9RiswA
 A6TjCkmYneWmOLktMt7B24JcugzjEiJdFHfKejKhxr74HTqN0nsLdCG7LGfReC1C1uWeBldNoc4/
 ugpbufbubK+x4pGqVAT1vWFeEhEnVslbRXVRh+7MnWbw7fXOUdDwPDg2bN87qJveuvI4FkaTzox5
 7en0TkQuIdVjxFJSAPHvCxKJKuWBdR7YVGu3dD+xoi67r0TCUZsaG+mLAH7VoDC8TGpF0nrTJnXQ
 ungkKNbjrbxYFX5W98JZfM4UDzp+I2t3/FxvddG4mRHKJlnoc+LvLMw4Oh2LkwsmIC+tUiJAU2Hq
 vcLZCDNz7FE5l8aegTfrXgepXw2uOkh8BWaRmYTapEnuVpgRu+5Csn5Mqn0EOmQ4zJ5Xvbj1fZ7U
 ZAcZAKRxmEeggn4dXb7yqusq0s5DtPzYuBzwts9dc5EAHEHZgW6UZdC9xnXnL/pVo6UJflxizBq4
 o6xB5AMMdSDguIlqHHJIe5U4rz33MPOIlGKEX4NMFgsxYIHCku08yYLbMWIz8Sz3rXkToGgoPkqM
 hPcHscFEFmAKKS84AwX/iljz3fd1vw8CKdLIQ0mXmruaJQIiW79QHVjQAf5k9dHsv/ZOrTrG9MTh
 grJJ0yYP54MxhfGWgwomWRcGIJOYPo3qjuJ89r6TOdr62U9MDkWGkPl9AMOpyKA69LF1Ge2GaGfx
 mfos7YTXbqll+CkEp8Abhi88xg9tdbvxd+VhQOn2K5bYwN40eTXlWiUAYdLmsJdAoPJvtp9WlTt+
 Kq0eQx3E5oYrsjSrzniyQYOvVIVbP1OsRtMGMevVVKNikwLQ0fq/FOtFj5jedxzVymPEjnK9ocrD
 Qs1Q7QbJ8LleNweIjcZcgw==
X-Report-Abuse-To: spam@com-mpt-mgt001.mailprotect.be
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo and Peter,

A known shortcoming of the current lockdep implementation is that it requires
lock keys to be allocated statically. This forces certain unrelated
synchronization objects to share keys and this key sharing can cause false
positive deadlock reports. This patch series adds support for dynamic keys in
the lockdep code and eliminates a class of false positive reports from the
workqueue implementation.

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

Bart Van Assche (24):
  lockdep tests: Display compiler warning and error messages
  lockdep tests: Fix shellcheck warnings
  lockdep tests: Improve testing accuracy
  lockdep tests: Run lockdep tests a second time under Valgrind
  liblockdep: Rename "trywlock" into "trywrlock"
  liblockdep: Add dummy print_irqtrace_events() implementation
  lockdep tests: Test the lockdep_reset_lock() implementation
  locking/lockdep: Declare local symbols static
  locking/lockdep: Inline __lockdep_init_map()
  locking/lockdep: Introduce lock_class_cache_is_registered()
  locking/lockdep: Remove a superfluous INIT_LIST_HEAD() statement
  locking/lockdep: Make concurrent lockdep_reset_lock() calls safe
  locking/lockdep: Stop using RCU primitives to access all_lock_classes
  locking/lockdep: Make zap_class() remove all matching lock order
    entries
  locking/lockdep: Reorder struct lock_class members
  locking/lockdep: Retain the class key and name while freeing a lock
    class
  locking/lockdep: Free lock classes that are no longer in use
  locking/lockdep: Reuse list entries that are no longer in use
  locking/lockdep: Check data structure consistency
  locking/lockdep: Introduce __lockdep_free_key_range()
  locking/lockdep: Verify whether lock objects are small enough to be
    used as class keys
  locking/lockdep: Add support for dynamic keys
  kernel/workqueue: Use dynamic lockdep keys for workqueues
  lockdep tests: Test dynamic key registration

 include/linux/lockdep.h                       |  37 +-
 include/linux/workqueue.h                     |  28 +-
 kernel/locking/lockdep.c                      | 647 +++++++++++++++---
 kernel/workqueue.c                            |  60 +-
 tools/lib/lockdep/include/liblockdep/common.h |   3 +
 tools/lib/lockdep/include/liblockdep/mutex.h  |  12 +-
 tools/lib/lockdep/include/liblockdep/rwlock.h |   6 +-
 tools/lib/lockdep/lockdep.c                   |   5 +
 tools/lib/lockdep/run_tests.sh                |  39 +-
 tools/lib/lockdep/tests/AA.sh                 |   2 +
 tools/lib/lockdep/tests/ABA.sh                |   2 +
 tools/lib/lockdep/tests/ABBA.c                |  12 +
 tools/lib/lockdep/tests/ABBA.sh               |   2 +
 tools/lib/lockdep/tests/ABBA_2threads.sh      |   2 +
 tools/lib/lockdep/tests/ABBCCA.c              |   4 +
 tools/lib/lockdep/tests/ABBCCA.sh             |   2 +
 tools/lib/lockdep/tests/ABBCCDDA.c            |   5 +
 tools/lib/lockdep/tests/ABBCCDDA.sh           |   2 +
 tools/lib/lockdep/tests/ABCABC.c              |   4 +
 tools/lib/lockdep/tests/ABCABC.sh             |   2 +
 tools/lib/lockdep/tests/ABCDBCDA.c            |   5 +
 tools/lib/lockdep/tests/ABCDBCDA.sh           |   2 +
 tools/lib/lockdep/tests/ABCDBDDA.c            |   5 +
 tools/lib/lockdep/tests/ABCDBDDA.sh           |   2 +
 tools/lib/lockdep/tests/WW.sh                 |   2 +
 tools/lib/lockdep/tests/unlock_balance.c      |   2 +
 tools/lib/lockdep/tests/unlock_balance.sh     |   2 +
 27 files changed, 731 insertions(+), 165 deletions(-)
 create mode 100755 tools/lib/lockdep/tests/AA.sh
 create mode 100755 tools/lib/lockdep/tests/ABA.sh
 create mode 100755 tools/lib/lockdep/tests/ABBA.sh
 create mode 100755 tools/lib/lockdep/tests/ABBA_2threads.sh
 create mode 100755 tools/lib/lockdep/tests/ABBCCA.sh
 create mode 100755 tools/lib/lockdep/tests/ABBCCDDA.sh
 create mode 100755 tools/lib/lockdep/tests/ABCABC.sh
 create mode 100755 tools/lib/lockdep/tests/ABCDBCDA.sh
 create mode 100755 tools/lib/lockdep/tests/ABCDBDDA.sh
 create mode 100755 tools/lib/lockdep/tests/WW.sh
 create mode 100755 tools/lib/lockdep/tests/unlock_balance.sh

-- 
2.20.0.rc2.403.gdbc3b29805-goog

