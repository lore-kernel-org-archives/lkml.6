Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+tJumZgSNItPfgAVXUfTDbxNVED/ZBvkLiAQLoC/Rk+u+c4VJuoJTM99pwQNyTFq5bN/P2
ARC-Seal: i=1; a=rsa-sha256; t=1524405811; cv=none;
        d=google.com; s=arc-20160816;
        b=R2YKY6R8T3zb+XCzu9oBEQfgTs+mp52e47L5Z0lxNdjduhbU24RU91tkCtk6aycmUM
         doDX8KJj5+Kv3n77BCeMRPzXzF4mdMYpKqu2EvvKrwnakWyjt1IbWXEHHztMp6yRz0+s
         L8b6J3BIhy/IWB/SdMA9d5fhYXY22DDBQer4l0e+3L764/xaTl/5AFgSLxd4CK/CLR5B
         WKapn90lbXvPJP2AcEUMRCll58T/Jtz17JtVOzU1sOwqZUchAvuuINBZjFCDQchlrkj8
         qUmWN0RIZ9eeM0/5CK5RTV90GfyPLT1eyQEkF1FeZc/Gomcw5zDggjApdbXQXs2Nvtyv
         WWxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=LCPLmLYCiiXU0ahOpI0P+lkW2NRca5K4/eF7Ldwwirg=;
        b=mqXpV8Hwlhb6fytvKdhSCp9q9r6jg4TMFSXjl1tb8fl//HPxRgzqYwGTTZNQ13gOV9
         7353E7qzUQUumwzVzfLoB7Td6Hcmy4fC8kwJMLo+897szZPLz2kNdYHwLcTRcdPRuwG4
         /l4gnPHuOsNc2mAUe4nTRugqC3wmL3gh434hMMhf7G0q6GSNlQhOaAOP6envgLv8MbWj
         IKuUCcwVqFeLly1d8IuPqW/6gfT6w7bNCSuVaL6EnVDegqO/HkTo4ifMO/cnApP76ZUZ
         Dl1Myq3hpMEVCFuzEHyQLC3NB0x2E7JkxKHvAm/SCeRM0AjZ8ZdCfqYLEO8I5DoKgEgG
         VXjQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Greg Thelen <gthelen@google.com>,
	Wang Long <wanglong19@meituan.com>,
	Michal Hocko <mhocko@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Tejun Heo <tj@kernel.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH 4.16 196/196] writeback: safer lock nesting
Date: Sun, 22 Apr 2018 15:53:36 +0200
Message-Id: <20180422135114.425056798@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455348272651439?=
X-GMAIL-MSGID: =?utf-8?q?1598455348272651439?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Greg Thelen <gthelen@google.com>

commit 2e898e4c0a3897ccd434adac5abb8330194f527b upstream.

lock_page_memcg()/unlock_page_memcg() use spin_lock_irqsave/restore() if
the page's memcg is undergoing move accounting, which occurs when a
process leaves its memcg for a new one that has
memory.move_charge_at_immigrate set.

unlocked_inode_to_wb_begin,end() use spin_lock_irq/spin_unlock_irq() if
the given inode is switching writeback domains.  Switches occur when
enough writes are issued from a new domain.

This existing pattern is thus suspicious:
    lock_page_memcg(page);
    unlocked_inode_to_wb_begin(inode, &locked);
    ...
    unlocked_inode_to_wb_end(inode, locked);
    unlock_page_memcg(page);

If both inode switch and process memcg migration are both in-flight then
unlocked_inode_to_wb_end() will unconditionally enable interrupts while
still holding the lock_page_memcg() irq spinlock.  This suggests the
possibility of deadlock if an interrupt occurs before unlock_page_memcg().

    truncate
    __cancel_dirty_page
    lock_page_memcg
    unlocked_inode_to_wb_begin
    unlocked_inode_to_wb_end
    <interrupts mistakenly enabled>
                                    <interrupt>
                                    end_page_writeback
                                    test_clear_page_writeback
                                    lock_page_memcg
                                    <deadlock>
    unlock_page_memcg

Due to configuration limitations this deadlock is not currently possible
because we don't mix cgroup writeback (a cgroupv2 feature) and
memory.move_charge_at_immigrate (a cgroupv1 feature).

If the kernel is hacked to always claim inode switching and memcg
moving_account, then this script triggers lockup in less than a minute:

  cd /mnt/cgroup/memory
  mkdir a b
  echo 1 > a/memory.move_charge_at_immigrate
  echo 1 > b/memory.move_charge_at_immigrate
  (
    echo $BASHPID > a/cgroup.procs
    while true; do
      dd if=/dev/zero of=/mnt/big bs=1M count=256
    done
  ) &
  while true; do
    sync
  done &
  sleep 1h &
  SLEEP=$!
  while true; do
    echo $SLEEP > a/cgroup.procs
    echo $SLEEP > b/cgroup.procs
  done

The deadlock does not seem possible, so it's debatable if there's any
reason to modify the kernel.  I suggest we should to prevent future
surprises.  And Wang Long said "this deadlock occurs three times in our
environment", so there's more reason to apply this, even to stable.
Stable 4.4 has minor conflicts applying this patch.  For a clean 4.4 patch
see "[PATCH for-4.4] writeback: safer lock nesting"
https://lkml.org/lkml/2018/4/11/146

Wang Long said "this deadlock occurs three times in our environment"

[gthelen@google.com: v4]
  Link: http://lkml.kernel.org/r/20180411084653.254724-1-gthelen@google.com
[akpm@linux-foundation.org: comment tweaks, struct initialization simplification]
Change-Id: Ibb773e8045852978f6207074491d262f1b3fb613
Link: http://lkml.kernel.org/r/20180410005908.167976-1-gthelen@google.com
Fixes: 682aa8e1a6a1 ("writeback: implement unlocked_inode_to_wb transaction and use it for stat updates")
Signed-off-by: Greg Thelen <gthelen@google.com>
Reported-by: Wang Long <wanglong19@meituan.com>
Acked-by: Wang Long <wanglong19@meituan.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: <stable@vger.kernel.org>	[v4.2+]
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
[natechancellor: Adjust context due to lack of b93b016313b3b]
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/fs-writeback.c                |    7 ++++---
 include/linux/backing-dev-defs.h |    5 +++++
 include/linux/backing-dev.h      |   30 ++++++++++++++++--------------
 mm/page-writeback.c              |   18 +++++++++---------
 4 files changed, 34 insertions(+), 26 deletions(-)

--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -745,11 +745,12 @@ int inode_congested(struct inode *inode,
 	 */
 	if (inode && inode_to_wb_is_valid(inode)) {
 		struct bdi_writeback *wb;
-		bool locked, congested;
+		struct wb_lock_cookie lock_cookie = {};
+		bool congested;
 
-		wb = unlocked_inode_to_wb_begin(inode, &locked);
+		wb = unlocked_inode_to_wb_begin(inode, &lock_cookie);
 		congested = wb_congested(wb, cong_bits);
-		unlocked_inode_to_wb_end(inode, locked);
+		unlocked_inode_to_wb_end(inode, &lock_cookie);
 		return congested;
 	}
 
--- a/include/linux/backing-dev-defs.h
+++ b/include/linux/backing-dev-defs.h
@@ -223,6 +223,11 @@ static inline void set_bdi_congested(str
 	set_wb_congested(bdi->wb.congested, sync);
 }
 
+struct wb_lock_cookie {
+	bool locked;
+	unsigned long flags;
+};
+
 #ifdef CONFIG_CGROUP_WRITEBACK
 
 /**
--- a/include/linux/backing-dev.h
+++ b/include/linux/backing-dev.h
@@ -346,7 +346,7 @@ static inline struct bdi_writeback *inod
 /**
  * unlocked_inode_to_wb_begin - begin unlocked inode wb access transaction
  * @inode: target inode
- * @lockedp: temp bool output param, to be passed to the end function
+ * @cookie: output param, to be passed to the end function
  *
  * The caller wants to access the wb associated with @inode but isn't
  * holding inode->i_lock, mapping->tree_lock or wb->list_lock.  This
@@ -354,12 +354,12 @@ static inline struct bdi_writeback *inod
  * association doesn't change until the transaction is finished with
  * unlocked_inode_to_wb_end().
  *
- * The caller must call unlocked_inode_to_wb_end() with *@lockdep
- * afterwards and can't sleep during transaction.  IRQ may or may not be
- * disabled on return.
+ * The caller must call unlocked_inode_to_wb_end() with *@cookie afterwards and
+ * can't sleep during the transaction.  IRQs may or may not be disabled on
+ * return.
  */
 static inline struct bdi_writeback *
-unlocked_inode_to_wb_begin(struct inode *inode, bool *lockedp)
+unlocked_inode_to_wb_begin(struct inode *inode, struct wb_lock_cookie *cookie)
 {
 	rcu_read_lock();
 
@@ -367,10 +367,10 @@ unlocked_inode_to_wb_begin(struct inode
 	 * Paired with store_release in inode_switch_wb_work_fn() and
 	 * ensures that we see the new wb if we see cleared I_WB_SWITCH.
 	 */
-	*lockedp = smp_load_acquire(&inode->i_state) & I_WB_SWITCH;
+	cookie->locked = smp_load_acquire(&inode->i_state) & I_WB_SWITCH;
 
-	if (unlikely(*lockedp))
-		spin_lock_irq(&inode->i_mapping->tree_lock);
+	if (unlikely(cookie->locked))
+		spin_lock_irqsave(&inode->i_mapping->tree_lock, cookie->flags);
 
 	/*
 	 * Protected by either !I_WB_SWITCH + rcu_read_lock() or tree_lock.
@@ -382,12 +382,13 @@ unlocked_inode_to_wb_begin(struct inode
 /**
  * unlocked_inode_to_wb_end - end inode wb access transaction
  * @inode: target inode
- * @locked: *@lockedp from unlocked_inode_to_wb_begin()
+ * @cookie: @cookie from unlocked_inode_to_wb_begin()
  */
-static inline void unlocked_inode_to_wb_end(struct inode *inode, bool locked)
+static inline void unlocked_inode_to_wb_end(struct inode *inode,
+					    struct wb_lock_cookie *cookie)
 {
-	if (unlikely(locked))
-		spin_unlock_irq(&inode->i_mapping->tree_lock);
+	if (unlikely(cookie->locked))
+		spin_unlock_irqrestore(&inode->i_mapping->tree_lock, cookie->flags);
 
 	rcu_read_unlock();
 }
@@ -434,12 +435,13 @@ static inline struct bdi_writeback *inod
 }
 
 static inline struct bdi_writeback *
-unlocked_inode_to_wb_begin(struct inode *inode, bool *lockedp)
+unlocked_inode_to_wb_begin(struct inode *inode, struct wb_lock_cookie *cookie)
 {
 	return inode_to_wb(inode);
 }
 
-static inline void unlocked_inode_to_wb_end(struct inode *inode, bool locked)
+static inline void unlocked_inode_to_wb_end(struct inode *inode,
+					    struct wb_lock_cookie *cookie)
 {
 }
 
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2501,13 +2501,13 @@ void account_page_redirty(struct page *p
 	if (mapping && mapping_cap_account_dirty(mapping)) {
 		struct inode *inode = mapping->host;
 		struct bdi_writeback *wb;
-		bool locked;
+		struct wb_lock_cookie cookie = {};
 
-		wb = unlocked_inode_to_wb_begin(inode, &locked);
+		wb = unlocked_inode_to_wb_begin(inode, &cookie);
 		current->nr_dirtied--;
 		dec_node_page_state(page, NR_DIRTIED);
 		dec_wb_stat(wb, WB_DIRTIED);
-		unlocked_inode_to_wb_end(inode, locked);
+		unlocked_inode_to_wb_end(inode, &cookie);
 	}
 }
 EXPORT_SYMBOL(account_page_redirty);
@@ -2613,15 +2613,15 @@ void __cancel_dirty_page(struct page *pa
 	if (mapping_cap_account_dirty(mapping)) {
 		struct inode *inode = mapping->host;
 		struct bdi_writeback *wb;
-		bool locked;
+		struct wb_lock_cookie cookie = {};
 
 		lock_page_memcg(page);
-		wb = unlocked_inode_to_wb_begin(inode, &locked);
+		wb = unlocked_inode_to_wb_begin(inode, &cookie);
 
 		if (TestClearPageDirty(page))
 			account_page_cleaned(page, mapping, wb);
 
-		unlocked_inode_to_wb_end(inode, locked);
+		unlocked_inode_to_wb_end(inode, &cookie);
 		unlock_page_memcg(page);
 	} else {
 		ClearPageDirty(page);
@@ -2653,7 +2653,7 @@ int clear_page_dirty_for_io(struct page
 	if (mapping && mapping_cap_account_dirty(mapping)) {
 		struct inode *inode = mapping->host;
 		struct bdi_writeback *wb;
-		bool locked;
+		struct wb_lock_cookie cookie = {};
 
 		/*
 		 * Yes, Virginia, this is indeed insane.
@@ -2690,14 +2690,14 @@ int clear_page_dirty_for_io(struct page
 		 * always locked coming in here, so we get the desired
 		 * exclusion.
 		 */
-		wb = unlocked_inode_to_wb_begin(inode, &locked);
+		wb = unlocked_inode_to_wb_begin(inode, &cookie);
 		if (TestClearPageDirty(page)) {
 			dec_lruvec_page_state(page, NR_FILE_DIRTY);
 			dec_zone_page_state(page, NR_ZONE_WRITE_PENDING);
 			dec_wb_stat(wb, WB_RECLAIMABLE);
 			ret = 1;
 		}
-		unlocked_inode_to_wb_end(inode, locked);
+		unlocked_inode_to_wb_end(inode, &cookie);
 		return ret;
 	}
 	return TestClearPageDirty(page);
