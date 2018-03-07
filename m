Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754426AbeCGNNy (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 08:13:54 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:52301 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754331AbeCGNNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 08:13:51 -0500
X-Google-Smtp-Source: AG47ELtW/7WfDmReuOoOQLr2ziW/Zt6wC8TybXzJDjobhGPXAZPl8VOtYGKQ1CGlperecGfkDXNklg==
Date: Wed, 7 Mar 2018 14:13:41 +0100
From: Andrea Parri <parri.andrea@gmail.com>
To: Will Deacon <will.deacon@arm.com>
Cc: linux-kernel@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jason Wessel <jason.wessel@windriver.com>
Subject: Re: [PATCH] Documentation/locking: Document the semantics of
 spin_is_locked()
Message-ID: <20180307131341.GA28486@andrea>
References: <1519814372-19941-1-git-send-email-parri.andrea@gmail.com>
 <20180228105631.GA7681@arm.com>
 <20180228112403.GA32228@andrea>
 <20180228113456.GC7681@arm.com>
 <20180228121523.GA354@andrea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180228121523.GA354@andrea>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 28, 2018 at 01:15:23PM +0100, Andrea Parri wrote:
> On Wed, Feb 28, 2018 at 11:34:56AM +0000, Will Deacon wrote:

[...]

>> only if there's some evidence that you've looked at the callsites
>> and determined that they won't break.

I looked at the callsites for {,raw_}spin_is_locked() (reported below):

In most cases (40+), these primitives are used within BUG_ON/WARN_ON or
the like; a handful of other cases using these with no concurrency, for
checking "self-lock", or for heuristics.

I confirm that the "ipc/sem.c" case, mentioned in the arm64 and powerpc
commits adding smp_mb() to their arch_spin_is_locked(), disappeared.

And that the "debug_core" case seems to be the only case requiring some
thoughts: my understanding (but I Cc the KGDB maintainers, so that they
can correct me, or provide other details) is that KGDB does not rely on
implicit barriers in raw_spin_is_locked().

(This seems instead to rely on barriers in the IPIs sending/handling, in
 part., kgdb_roundup_cpus, kgdb_nmicallback; yes, these barriers are not
 documented, but I've discussed with Daniel, Jason about the eventuality
 of adding such documentations/inline comments.)

(N.B. I have _not_ tested any of these observations, say by removing the
 smp_mb() from your implementation; so, you know...)

  Andrea


./mm/khugepaged.c:1222:						VM_BUG_ON(NR_CPUS != 1 && !spin_is_locked(&khugepaged_mm_lock));
./mm/khugepaged.c:1663:						VM_BUG_ON(NR_CPUS != 1 && !spin_is_locked(&khugepaged_mm_lock));
./mm/swap.c:828:						VM_BUG_ON(NR_CPUS != 1 && !spin_is_locked(&lruvec_pgdat(lruvec)->lru_lock));
./security/apparmor/file.c:497:					old = rcu_dereference_protected(fctx->label, spin_is_locked(&fctx->lock));
./net/netfilter/ipset/ip_set_hash_gen.h:18:			__ipset_dereference_protected(p, spin_is_locked(&(set)->lock))
./fs/ocfs2/dlmglue.c:760:					mlog_bug_on_msg(spin_is_locked(&res->l_lock),
./fs/ocfs2/inode.c:1194:					mlog_bug_on_msg(spin_is_locked(&oi->ip_lock),
./fs/userfaultfd.c:156:						VM_BUG_ON(spin_is_locked(&ctx->fault_pending_wqh.lock));
./fs/userfaultfd.c:158:						VM_BUG_ON(spin_is_locked(&ctx->fault_wqh.lock));
./fs/userfaultfd.c:160:						VM_BUG_ON(spin_is_locked(&ctx->event_wqh.lock));
./fs/userfaultfd.c:162:						VM_BUG_ON(spin_is_locked(&ctx->fd_wqh.lock));
./fs/userfaultfd.c:919:						VM_BUG_ON(!spin_is_locked(&wqh->lock));
./virt/kvm/arm/vgic/vgic.c:192:					DEBUG_SPINLOCK_BUG_ON(!spin_is_locked(&irq->irq_lock));
./virt/kvm/arm/vgic/vgic.c:269:					DEBUG_SPINLOCK_BUG_ON(!spin_is_locked(&vgic_cpu->ap_list_lock));
./virt/kvm/arm/vgic/vgic.c:307:					DEBUG_SPINLOCK_BUG_ON(!spin_is_locked(&irq->irq_lock));
./virt/kvm/arm/vgic/vgic.c:663:					DEBUG_SPINLOCK_BUG_ON(!spin_is_locked(&irq->irq_lock));
./virt/kvm/arm/vgic/vgic.c:694:					DEBUG_SPINLOCK_BUG_ON(!spin_is_locked(&vgic_cpu->ap_list_lock));
./virt/kvm/arm/vgic/vgic.c:715:					DEBUG_SPINLOCK_BUG_ON(!spin_is_locked(&vgic_cpu->ap_list_lock));
./virt/kvm/kvm_main.c:3934:					WARN_ON(raw_spin_is_locked(&kvm_count_lock));
./kernel/debug/debug_core.c:527:				if (!raw_spin_is_locked(&dbg_slave_lock))
./kernel/debug/debug_core.c:755:				raw_spin_is_locked(&dbg_master_lock)) {
./kernel/locking/spinlock_debug.c:98:				SPIN_BUG_ON(!raw_spin_is_locked(lock), lock, "already unlocked");
./kernel/locking/mutex-debug.c:39:				SMP_DEBUG_LOCKS_WARN_ON(!spin_is_locked(&lock->wait_lock));
./kernel/locking/mutex-debug.c:54:				SMP_DEBUG_LOCKS_WARN_ON(!spin_is_locked(&lock->wait_lock));
./kernel/futex.c:1368:						if (WARN_ON_SMP(!q->lock_ptr || !spin_is_locked(q->lock_ptr))
./kernel/printk/printk_safe.c:281:				if (in_nmi() && raw_spin_is_locked(&logbuf_lock)) { // same cpu (printk in nmi)
./kernel/printk/printk_safe.c:314:	    			raw_spin_is_locked(&logbuf_lock)) { // same cpu (printk in nmi)
./include/net/sock.h:1529:					return !sk->sk_lock.owned && !spin_is_locked(&sk->sk_lock.slock); // returns in BUG_ON/WARN_ON_ONCE
./arch/x86/pci/i386.c:62:					WARN_ON_SMP(!spin_is_locked(&pcibios_fwaddrmap_lock));
./arch/cris/arch-v32/drivers/cryptocop.c:3446:			printk("cryptocop_completed_jobs_lock %d\n", spin_is_locked(&cryptocop_completed_jobs_lock));
./arch/cris/arch-v32/drivers/cryptocop.c:3447:			printk("cryptocop_job_queue_lock %d\n", spin_is_locked(&cryptocop_job_queue_lock));
./arch/cris/arch-v32/drivers/cryptocop.c:3448:			printk("descr_pool_lock %d\n", spin_is_locked(&descr_pool_lock));
./arch/cris/arch-v32/drivers/cryptocop.c:3449:			printk("cryptocop_sessions_lock %d\n", spin_is_locked(cryptocop_sessions_lock));
./arch/cris/arch-v32/drivers/cryptocop.c:3450:			printk("running_job_lock %d\n", spin_is_locked(running_job_lock));
./arch/cris/arch-v32/drivers/cryptocop.c:3451:			printk("cryptocop_process_lock %d\n", spin_is_locked(cryptocop_process_lock));
./arch/parisc/kernel/firmware.c:208:        			if (spin_is_locked(&pdc_lock)) // self-lock: if (is_locked) unlock(pdc_lock)
./drivers/staging/irda/drivers/sir_dev.c:637:			if(spin_is_locked(&dev->tx_lock)) { 	// for debug
./drivers/staging/lustre/lustre/osc/osc_cl_internal.h:189:	return spin_is_locked(&obj->oo_lock); // for assert
./drivers/tty/serial/sn_console.c:891:				if (spin_is_locked(&port->sc_port.lock)) { // single lock
./drivers/tty/serial/sn_console.c:908:				if (!spin_is_locked(&port->sc_port.lock) // single lock
./drivers/misc/sgi-xp/xpc_channel.c:31:				DBUG_ON(!spin_is_locked(&ch->lock));
./drivers/misc/sgi-xp/xpc_channel.c:85:				DBUG_ON(!spin_is_locked(&ch->lock));
./drivers/misc/sgi-xp/xpc_channel.c:761:			DBUG_ON(!spin_is_locked(&ch->lock));
./drivers/misc/sgi-xp/xpc_sn2.c:1674:				DBUG_ON(!spin_is_locked(&ch->lock));
./drivers/misc/sgi-xp/xpc_uv.c:1186:				DBUG_ON(!spin_is_locked(&ch->lock));
./drivers/net/ethernet/smsc/smsc911x.h:70:			WARN_ON_SMP(!spin_is_locked(&pdata->mac_lock))
./drivers/net/ethernet/intel/igbvf/mbx.c:267:			WARN_ON_ONCE(!spin_is_locked(&hw->mbx_lock));
./drivers/net/ethernet/intel/igbvf/mbx.c:305:			WARN_ON_ONCE(!spin_is_locked(&hw->mbx_lock));
./drivers/net/ethernet/intel/i40e/i40e_main.c:1527:		WARN(!spin_is_locked(&vsi->mac_filter_hash_lock),
./drivers/net/wireless/zydas/zd1211rw/zd_mac.c:238:		ZD_ASSERT(!spin_is_locked(&mac->lock));
./drivers/scsi/fnic/fnic_scsi.c:184:				int sh_locked = spin_is_locked(host->host_lock); // self-lock: if (!is_locked) lock(host_lock)
./drivers/scsi/snic/snic_scsi.c:2004:				SNIC_BUG_ON(!spin_is_locked(io_lock));
./drivers/scsi/snic/snic_scsi.c:2607:				SNIC_BUG_ON(!spin_is_locked(io_lock));
./drivers/atm/nicstar.c:2692:					if (spin_is_locked(&card->int_lock)) {	// optimization ("Probably it isn't worth spinning")
./drivers/hv/hv_balloon.c:644:					WARN_ON_ONCE(!spin_is_locked(&dm_device.ha_lock));
