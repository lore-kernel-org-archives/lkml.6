Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2E64C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 23:01:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 846DE218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 23:01:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mailprotect.be header.i=@mailprotect.be header.b="Zeuus+SR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbfBNXBY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 18:01:24 -0500
Received: from out002.mailprotect.be ([83.217.72.86]:33055 "EHLO
        out002.mailprotect.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725818AbfBNXBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 18:01:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mailprotect.be; s=mail; h=Content-Transfer-Encoding:MIME-Version:Message-Id
        :Date:Subject:Cc:To:From:reply-to:sender:bcc:in-reply-to:references:
        content-type; bh=zpb5w9CT9sHjej57BpCvlY7wqgLq4HoZoQvZDsuXvvE=; b=Zeuus+SRweY2
        zbgJ30pK8HZnDyydO9lT0RctxfiHTMrx/jFF1Y5Qe1smPYrwC+3DGb+rgGWrKOAl3ywjuXd6UicXN
        K6OZ/WBxmgousP7GF3vuPg7oShsHKdK5YCtIdM9uaSUfWavlTNoUKYekdHswteiQLVePXQVFFfM95
        BthDgh55VimyIoIJxTGd+br9auT9vggTqDIJnUtEQvEl0uZmkfcMFY9aeFeSB1Xo/MwouqE/dDAWi
        i8F/LVwiZ1lwt1U3At+7CFicofO92oV3q3AYYcMc0AcETFE+THP98S9LUvidjvTpiqV/wjrDgVb3K
        FSbZJUsHm08bwd8fV66yMA==;
Received: from smtp-auth.mailprotect.be ([178.208.39.159])
        by com-mpt-out002.mailprotect.be with esmtp (Exim 4.89)
        (envelope-from <bvanassche@acm.org>)
        id 1guQ0E-0000Nz-2q; Fri, 15 Feb 2019 00:01:10 +0100
Received: from desktop-bart.svl.corp.google.com (unknown [104.133.8.89])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by smtp-auth.mailprotect.be (Postfix) with ESMTPSA id 3D0B0C0482;
        Fri, 15 Feb 2019 00:01:04 +0100 (CET)
From:   Bart Van Assche <bvanassche@acm.org>
To:     peterz@infradead.org
Cc:     mingo@redhat.com, will.deacon@arm.com, tj@kernel.org,
        longman@redhat.com, johannes.berg@intel.com,
        linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v7 00/23] locking/lockdep: Add support for dynamic keys
Date:   Thu, 14 Feb 2019 15:00:35 -0800
Message-Id: <20190214230058.196511-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Originating-IP: 178.208.39.159
X-SpamExperts-Domain: mailprotect.be
X-SpamExperts-Username: 178.208.39.128/27
Authentication-Results: mailprotect.be; auth=pass smtp.auth=178.208.39.128/27@mailprotect.be
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: Combined (0.11)
X-Recommended-Action: accept
X-Filter-ID: EX5BVjFpneJeBchSMxfU5i2F0EZrCXYK7q9PKh7Nfl9602E9L7XzfQH6nu9C/Fh9KJzpNe6xgvOx
 q3u0UDjvO1tLifGj39bI0bcPyaJsYTbXCyMe5v8y2H30acbVA7+CsLowAEMLnIs/c915wTAPANfX
 yKo+pvzCeHRww82sG/8HW2me2F11ZDpUG2A5Oiv0I5mALh2L1FvYZOvwUqXjvDk55wR+TsdsSUF6
 GKzdvFr/HXw7HB6/ASdSFy6HwS/kPXDwAtkmamZ68x0sIvfyXcDIKE+0kbt+hzad+8LmAP3bC8dt
 /CV3fELBVC/AS5PvSbXcS42ZV4hGYRCvRHS3A+fHzJ6mVE7ewsipSVIfs4auXN7Us6OO1kPtU+sG
 f2TVQ2EZL/JNL8UUAaUS/T4q/hyWVd53YytHpjB/ujB/2NTsysIQh3c1tpyciYbqCvvgzE++dJZh
 hWbGyID6cWhsJRhb5RzkLIvXya0B9hweynIpEbHgsgY3JWab+g/Mh1jtnnOnAcd69x18pg0p8FqR
 rrmbyc5aB71wGr2Wbtmzh89JTRBxdS0lhfyuKilVxvWjCdK5dbUFdaYh4OLOUeZKO4TBa7kme6ff
 96X9WP+3jk3tmIFaDD4TWIFiEa5mMMUSLa4ZkP9no3WRJx0hup35xLEFb9QeNTYUvSitCjSGnslw
 RJ/eXhAiot4MY812nNgiO2B1IFiHtS2zeU6+EFbIav1GLZIAvsr3sDHzA2GMniGOUaCLF46jsGXY
 GJEtOeBZ++DuIQUs/5JJj4C/n4CILiiJn9FKl1uqsvZ2/m280jQFECBX8dC8mC8xujdjoglKKenZ
 4w4qDc4HZex6fUMuJlnuoMVjUUEMmaAsT8aJIz8bcCTHsCYe2wmYCB7xseRFzEoKM98/XKtk+qzD
 l4xIxvdjzQ6YC7Heg3Xf7O1TOd67Ls9WWc6wTLIXbppOJEzaSJPdeEQUiqBJRfq+izDSWJ7PSOfj
 rB2jdI9e0mBSBdqGq05aBP0sYrxCRNI4wfY6PAlbDjazCbhs7qBpykynMhZzgI5+GoeVe2OIbKwv
 b4b5ngTXDUyA7RCJuVQgauu2YZ3+aEDZVOv2xukYFFcG81BrMyfpYuyanAZpMXssfrVm+NgHVpHc
 Jtrt453xQ+N6qfxrMj7OwUd6hWTwF5n5azV39MS5H4HvZszNarbzMxr8TXtewLN4qcc/ax8c2Vpv
 oDZJZsug3pdB9KiChSREFnbR3+CM3IMHJikFQDsw2EE=
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

Please consider these patches for kernel v5.1.

Thanks,

Bart.

The changes compared to v6 are:
- For delayed freeing, adopted Peter's approach since that approach does not
  require to sleep in the context from which data structures are freed.
- Instead of delayed freeing list_entries[] elements, free these immediately.
- Added two patches that fix a false positive lockdep complaint in the block
  layer.
- Split several patches to make these easier to read.

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
  
Bart Van Assche (23):
  locking/lockdep: Fix two 32-bit compiler warnings
  locking/lockdep: Fix reported required memory size (1/2)
  locking/lockdep: Fix reported required memory size (2/2)
  locking/lockdep: Avoid that add_chain_cache() adds an invalid chain to
    the cache
  locking/lockdep: Reorder struct lock_class members
  locking/lockdep: Make zap_class() remove all matching lock order
    entries
  locking/lockdep: Initialize the locks_before and locks_after lists
    earlier
  locking/lockdep: Split lockdep_free_key_range() and
    lockdep_reset_lock()
  locking/lockdep: Make it easy to detect whether or not inside a
    selftest
  locking/lockdep: Update two outdated comments
  locking/lockdep: Free lock classes that are no longer in use
  locking/lockdep: Reuse list entries that are no longer in use
  locking/lockdep: Introduce lockdep_next_lockchain() and
    lock_chain_count()
  locking/lockdep: Fix a comment in add_chain_cache()
  locking/lockdep: Reuse lock chains that have been freed
  locking/lockdep: Check data structure consistency
  locking/lockdep: Verify whether lock objects are small enough to be
    used as class keys
  locking/lockdep: Add support for dynamic keys
  kernel/workqueue: Use dynamic lockdep keys for workqueues
  locking/spinlock: Introduce spin_lock_init_key()
  block: Avoid that flushing triggers a lockdep complaint
  lockdep tests: Fix run_tests.sh
  lockdep tests: Test dynamic key registration

 block/blk-flush.c                             |   5 +-
 block/blk.h                                   |   1 +
 include/linux/lockdep.h                       |  50 +-
 include/linux/spinlock.h                      |  15 +
 include/linux/workqueue.h                     |  28 +-
 kernel/locking/lockdep.c                      | 887 +++++++++++++++---
 kernel/locking/lockdep_internals.h            |   3 +-
 kernel/locking/lockdep_proc.c                 |  12 +-
 kernel/workqueue.c                            |  59 +-
 lib/locking-selftest.c                        |   2 +
 tools/lib/lockdep/include/liblockdep/common.h |   2 +
 tools/lib/lockdep/include/liblockdep/mutex.h  |  11 +-
 tools/lib/lockdep/run_tests.sh                |   6 +-
 tools/lib/lockdep/tests/ABBA.c                |   9 +
 14 files changed, 910 insertions(+), 180 deletions(-)

-- 
2.21.0.rc0.258.g878e2cd30e-goog

