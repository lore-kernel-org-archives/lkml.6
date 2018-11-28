Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6988CC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 23:45:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DEB0206B2
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 23:45:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mailprotect.be header.i=@mailprotect.be header.b="pb2DWsiG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DEB0206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbeK2Krg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 05:47:36 -0500
Received: from out002.mailprotect.be ([83.217.72.86]:60091 "EHLO
        out002.mailprotect.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726933AbeK2Krf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 05:47:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mailprotect.be; s=mail; h=Content-Transfer-Encoding:MIME-Version:Message-Id
        :Date:Subject:Cc:To:From:reply-to:sender:bcc:in-reply-to:references:
        content-type; bh=1/7AFsj7N4GIY7D1kBW421BikfeU2Y6w4Nklp5X4/tU=; b=pb2DWsiGAIlp
        Nuj6GFhMAWgg+9PfbxGyejAX0HD3yIp0N8Q5AymSKNNfQuWJ3M+UVh2J3JJ5MhXWMRv2afThlJndC
        PWb7VNHhU/TBsuQJtAoR8VtYbrmz0aWXkRlFrdaPjoyK97ltPNVableBqWrMIlQRSr9mzs3+tDDAW
        /8UygCKCE/WYoZkdN80yAhReFIkwB+6FKjyKwquuFgQIo0tkjRmefKvZrciOakU0rNm4FdAY4t3KA
        oYzVeg4leh6aKAeIP47YB1O8EdcYMs0pK0jGRCEo8Vl8qZwEdOMKmXgCMqWQyePaeKA5niDL/MTFL
        j07IchtotLrIHWFPUymVNg==;
Received: from smtp-auth.mailprotect.be ([178.208.39.159])
        by com-mpt-out002.mailprotect.be with esmtp (Exim 4.89)
        (envelope-from <bvanassche@acm.org>)
        id 1gS9Un-000Fif-4y; Thu, 29 Nov 2018 00:43:54 +0100
Received: from desktop-bart.svl.corp.google.com (unknown [104.133.8.89])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by smtp-auth.mailprotect.be (Postfix) with ESMTPSA id C6122C11FB;
        Thu, 29 Nov 2018 00:43:34 +0100 (CET)
From:   Bart Van Assche <bvanassche@acm.org>
To:     mingo@redhat.com
Cc:     peterz@infradead.org, tj@kernel.org, johannes.berg@intel.com,
        linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 00/27] locking/lockdep: Add support for dynamic keys
Date:   Wed, 28 Nov 2018 15:42:58 -0800
Message-Id: <20181128234325.110011-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.20.0.rc0.387.gc7a69e6b6c-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Originating-IP: 178.208.39.159
X-SpamExperts-Domain: mailprotect.be
X-SpamExperts-Username: 178.208.39.128/27
Authentication-Results: mailprotect.be; auth=pass smtp.auth=178.208.39.128/27@mailprotect.be
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: Combined (0.09)
X-Recommended-Action: accept
X-Filter-ID: EX5BVjFpneJeBchSMxfU5iGA521eyw8UkcnOIF+Sar5602E9L7XzfQH6nu9C/Fh9KJzpNe6xgvOx
 q3u0UDjvO1tLifGj39bI0bcPyaJsYTb/+zriNZuqQk0xRpGwjn+MTR8dtByWYYhgj25jR+mEA3YO
 AtfhCcV13BpIh8lqRXSSiFVwqwU9VgKUrYQ0lqWyB41b1wEpWO6ik9HITpMsqebHcXK5F5szpMR3
 ucwUCaulpCLw+Xb9GLNy0GASgpn9t8C9mOBdONdnsxgsk1D2p09kN7MM31r8n6t5T2S20aXloSSI
 aSz2hO/q9CpN2f95q2ydL+V39l/HBScm+SV6be+d9aVwS6cHCn1lU19HAi33Iz6Zvpm8cPQnANwk
 DQ5BNCNwpGn8jfSb3NCl2WUq09dCYgcgr835yVjKQZA6hJL1LiMHCxRezvZaFOrUVh8zaVyj66M1
 yz85ZZhpUrhTRbASVYnBhdKUnGmBdHG7BUn2dK6UtSEdwn3yFtfkzf2g6K04cY809V1JdCwiLdDQ
 Dow7RSjhmGOVelXQaHGaUkCLb5mum9xAXSaS3KKPtTZXWZip9+GhedmPokL8D3vhvY6dhwYzYMxd
 D9vfHZcjDv9O+eyolGM4l8rlxuGfhU+3NYPzMyldJaF5xZTjcWEFHpu0VYQwuqxmozzkDLIpUMoG
 SJj2/VGV7PqOahGXkaU4twU/8XGrHu5QsNBEHc0tEDNi5zR1WYi0E09NG6GB18nXQzDvPzq7iERC
 6EDedzAjUcZaxG4od/IZov2eAJ4OJ5PtRVkPryfKs6DA7QYq3G1BRp7ylSZxUEGgJw4nFzgd7yt3
 7BfpyvvZ6l+boZNfkk++GRKi3fJfRTPr/PuJHE36okpX82/BtXToloueSaXs0TK8OQ3cB9QF11y7
 2DRSHKQElPJyNJdgFsJFEs/93MWvvmKx+ij7Qjp2hZqAJbny5AnI+wExEi2ZXZcwFmj/G9G9XUMB
 gNDO+NkNGowFW+REN2PQUubU67h4IQuWPMZ4HKssSJVidkER7VZq4yeVz8oBMMMFnt8VzQUPDSXZ
 uD7+tXK85NWt4CYBo2l7vp9TheM8Ply7UNk9s+JR29DmIqQBJ7TPMihJUfmPOEFZaWOoGwSHnDFQ
 4P4YDtlBXByrTecUvjKvjZONtLXg4KjauZafx+OvKcOyQvUosS9CO/I=
X-Report-Abuse-To: spam@com-mpt-mgt001.mailprotect.be
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo and Peter,

A known shortcoming of the current lockdep implementation is that it requires
lock keys to be allocated statically and that this key sharing can cause false
positive deadlock reports. This patch series adds support for dynamic keys in
the lockdep code. I'm not claiming that this patch series is perfect. However,
the code in this patch series survives nontrivial tests so I think it's worth
a look. Two unrelated changes in this patch series are:
- Improve the lockdep tests.
- Complain if no name has been assigned to a lock object.

Thanks,
    
Bart.

Bart Van Assche (27):
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
  timekeeping: Assign a name to tk_core.seq.dep_map
  net/core: Assign a name to devnet_rename_seq.dep_map
  locking/lockdep: Complain if a lock object has no name
  locking/lockdep: Remove a superfluous INIT_LIST_HEAD() statement
  locking/lockdep: Make concurrent lockdep_reset_lock() calls safe
  locking/lockdep: Stop using RCU primitives to access all_lock_classes
  locking/lockdep: Make zap_class() remove all matching lock order
    entries
  locking/lockdep: Reorder struct lock_class members
  locking/lockdep: Retain the class key and name while freeing a lock
    class
  locking/lockdep: Free lock classes that are no longer in use
  locking/lockdep: Rename lock_list.entry into
    lock_list.lock_order_entry
  locking/lockdep: Reuse list entries that are no longer in use
  locking/lockdep: Check data structure consistency
  locking/lockdep: Introduce __lockdep_free_key_range()
  locking/lockdep: Add support for dynamic keys
  kernel/workqueue: Use dynamic lockdep keys for workqueues
  lockdep tests: Test dynamic key registration

 include/linux/lockdep.h                       |  45 +-
 include/linux/workqueue.h                     |  28 +-
 kernel/locking/lockdep.c                      | 640 +++++++++++++++---
 kernel/locking/lockdep_proc.c                 |   2 +-
 kernel/time/timekeeping.c                     |   4 +-
 kernel/workqueue.c                            |  60 +-
 net/core/dev.c                                |   2 +-
 tools/lib/lockdep/include/liblockdep/common.h |   3 +
 tools/lib/lockdep/include/liblockdep/mutex.h  |  12 +-
 tools/lib/lockdep/include/liblockdep/rwlock.h |   6 +-
 tools/lib/lockdep/lockdep.c                   |   5 +
 tools/lib/lockdep/run_tests.sh                |  38 +-
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
 30 files changed, 726 insertions(+), 178 deletions(-)
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
2.20.0.rc0.387.gc7a69e6b6c-goog

