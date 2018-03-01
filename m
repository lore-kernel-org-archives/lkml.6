Return-Path: <neilb@suse.com>
X-Google-Smtp-Source: AG47ELvKVNtdDZpB5jkE6ka2JzY3i+ua3RRXr4NsgCgW35LkxIQ+5IuyRCM+JBzFOcicZroV9Rw8
ARC-Seal: i=1; a=rsa-sha256; t=1519947134; cv=none;
        d=google.com; s=arc-20160816;
        b=WUPptGqrUhyPny5V8M63/B49eLBJaUEO7J5QZ3+3RRbvg3QqokVt9RZYlHFe7O/Ht7
         4tpax8i0nPUWgDPUX3DC1XE/PD/TckBSCPQPO0+RC+5WzfIsXDTArChJ9teHpKg5r7zM
         VQeO5Vv8YPzCoX83T76i7YeB/3TBB+tXofiiA2dWboLlI8qCeRXvHzvoDRn1ZNLsg5Qr
         W4C9Wc6gETOt1tMq7vJlgPhaK/pOq6i7q/9bLxdwfMJ/M76Rk6Vsdt33e2yLnfxaStOP
         qBXkUcMo87uBRNL4nHVWj7q7z3t1FXpBufJrTtWQz8AxZwg3N74R3cxkt769715JBbby
         bcxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:user-agent:message-id:cc
         :subject:date:to:from:arc-authentication-results;
        bh=WOvboPO8QsTWmYjYHy1JH10F1NjTG7MrMeQPgrAkhJE=;
        b=bUz0PIRqnSfNtjOIl+MSJgVf9I4GMzP1g3FnHUsEq/h4t1NG5y3zObUR0LrExMpkFY
         tiEy+MXQc9kIAig6L7Q2YHWloLQMTJQY5IJAPnNEYgABPe8e/bKrdhKkiBbGKI7alCg7
         SFIE+l3FVbfdNBae2l8pyubilJYpXT84rJmAheYZua4UEtR1H0LjZdog774Ri5tPakeh
         EiHC+vVYJ0qXvhT+S9l9MCqnPhf3QrMDdooI1zU2ltAItaSN/4WSfw1HIlWyQWFrHTFM
         KqjmpPe665GJraLoHIQLcqYfU8QmOzecjSltTKoQw/qfRS8o8di8crSKpLjuFafywCOf
         5pQw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
From: NeilBrown <neilb@suse.com>
To: Oleg Drokin <oleg.drokin@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 James Simmons <jsimmons@infradead.org>,
 Andreas Dilger <andreas.dilger@intel.com>
Date: Fri, 02 Mar 2018 10:31:25 +1100
Subject: [PATCH 00/17] staging: remove requirement that lustre be built as
 module
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Lustre Development List <lustre-devel@lists.lustre.org>
Message-ID: <151994679573.7628.1024109499321778846.stgit@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593780086946421092?=
X-GMAIL-MSGID: =?utf-8?q?1593780086946421092?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The main focus on this series is to remove the requirement that
lustre be built as a module.  The involves moving some initialization
out of the module_init functions and putting it elsewhere.

This lead me to look at various kthreads that are used, resulting is
some of them being changed to simpler work-queues.

Lustre has a 'struct ptlrpc_thread' data structure which appears to
have been created to manage the multiple threads for ptlrpcd - and it
does this quite effectively.
It was also used for managing a few other threads, and it was much
less suitable for these.  Those which haven't been changed to
workqueues have been changed to use kthread interfaces directly.

There are also a few bug-fixes and minor clean-ups.

This series doesn't introduce any new failures in the 'sanity' test
suite.

Thanks,
NeilBrown


---

NeilBrown (17):
      staging: lustre: obd_mount: use correct niduuid suffix.
      staging: lustre: fix bug in osc_enter_cache_try
      staging: lustre: statahead: remove incorrect test on agl_list_empty()
      staging: lustre: obdclass: don't require lct_owner to be non-NULL.
      staging: lustre: lnet: keep ln_nportals consistent
      staging: lustre: get entropy from nid when nid set.
      staging: lustre: ptlrpc: change GFP_NOFS to GFP_KERNEL
      staging: lustre: obdclass: use workqueue for zombie management.
      staging: lustre: ldlm: use delayed_work for pools_recalc
      staging: lustre: ptlrpc: use delayed_work in sec_gc
      staging: lustre: ptlrpc: use workqueue for pinger
      staging: lustre: remove unused flag from ptlrpc_thread
      staging: lustre: remove 'ptlrpc_thread usage' for sai_agl_thread
      staging: lustre: change sai_thread to sai_task.
      staging: lustre: ptlrpc: move thread creation out of module initialization
      staging: lustre: allow monolithic builds
      Revert "staging: Disable lustre file system for MIPS, SH, and XTENSA"


 drivers/staging/lustre/lnet/Kconfig                |    2 
 drivers/staging/lustre/lnet/lnet/api-ni.c          |    7 +
 drivers/staging/lustre/lnet/lnet/lib-ptl.c         |    5 -
 drivers/staging/lustre/lustre/Kconfig              |    1 
 .../staging/lustre/lustre/include/lustre_export.h  |    2 
 .../staging/lustre/lustre/include/lustre_import.h  |    4 
 drivers/staging/lustre/lustre/include/lustre_net.h |   14 -
 drivers/staging/lustre/lustre/include/obd.h        |    2 
 drivers/staging/lustre/lustre/ldlm/ldlm_lockd.c    |   12 +
 drivers/staging/lustre/lustre/ldlm/ldlm_pool.c     |   99 +---------
 .../staging/lustre/lustre/llite/llite_internal.h   |    4 
 drivers/staging/lustre/lustre/llite/llite_lib.c    |   18 ++
 drivers/staging/lustre/lustre/llite/statahead.c    |  197 ++++++++------------
 drivers/staging/lustre/lustre/llite/super25.c      |   17 --
 drivers/staging/lustre/lustre/obdclass/genops.c    |  193 ++------------------
 drivers/staging/lustre/lustre/obdclass/lu_object.c |    7 -
 drivers/staging/lustre/lustre/obdclass/obd_mount.c |    2 
 drivers/staging/lustre/lustre/osc/osc_cache.c      |    2 
 drivers/staging/lustre/lustre/ptlrpc/pinger.c      |   81 ++------
 .../staging/lustre/lustre/ptlrpc/ptlrpc_module.c   |   56 ++++--
 drivers/staging/lustre/lustre/ptlrpc/sec.c         |    6 -
 drivers/staging/lustre/lustre/ptlrpc/sec_bulk.c    |    2 
 drivers/staging/lustre/lustre/ptlrpc/sec_gc.c      |   90 +++------
 drivers/staging/lustre/lustre/ptlrpc/service.c     |    4 
 24 files changed, 259 insertions(+), 568 deletions(-)

--
Signature
