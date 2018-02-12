Return-Path: <neilb@suse.com>
X-Google-Smtp-Source: AH8x227fFRQTwvWBiuZyE864wJVszjhBtEl66DU0ec9Y3Xf5oXg1ebJ9R20mlRL28zQOQwf+Mp5R
ARC-Seal: i=1; a=rsa-sha256; t=1518470572; cv=none;
        d=google.com; s=arc-20160816;
        b=TCBdC3jb0Vjk8REQzaK+pBVIKUXlh6CubdxHRRPMcbsSeNMbJJ45rZYtOUJNH6nfA0
         wdrJtEhJ2Qu+gECBO9OcV0HXigQYlA+EZKdM6iV5FsIHTdx+iurobTaqlufWxHd8vxA/
         vMPm9QYbj5n3cYfphVTFzWbFmkyZ+nO+I+t+lXaxKW6wLKDKF51gD7EH2yv4ZnxJpaXV
         CKD7lpPcgSvLxNUkAchV2yFWJWSIRucpOuv3QIsPnQJyot6Odq5liJKJS36NDpSjUwER
         vuJm8HIPRTb2tTZifpOW9OIE8WJE7JE+aMBmCJtjZw8C05q6bvCn8dEkPLrwWRArEuKd
         HUWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:user-agent:message-id:cc
         :subject:date:to:from:arc-authentication-results;
        bh=M4/e1Z3Ep1Xc2X11knsfx+Wk7wuLq7FyZNZ4srr7OMk=;
        b=w+WjsdVgL1ptVMRLBQnlZapr4aH74/9xMeW/GzmKBOvg00Uetc9LAJfFjuVYeKEXho
         goQIyQmVPlT9dkxa8Ix4W4XFqmGeajjSzB6GMyhP/ytKvAhfNPRC71aCgfyljRPSlp7C
         61qDFs4FQr4Zm7JzKPyxFGOkF1Byl4697Ku/KbOuM8dXBhn1zhJ4/3uHaatKXQZWxEaw
         YSqSGLIy/Pn6NnrRXG6s68RO+mTvuhpz4WbumiqMvHXD+SkKOBBqcruzdovr83sJHCwm
         gTgt9UX9hvtrorBCAVxyzhMsR0rOuABknwvaVxqrTwb1d/bKpgm/j2henBsR5iWKWvuU
         TA1A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
From: NeilBrown <neilb@suse.com>
To: Oleg Drokin <oleg.drokin@intel.com>,
 Andreas Dilger <andreas.dilger@intel.com>,
 James Simmons <jsimmons@infradead.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Tue, 13 Feb 2018 08:22:36 +1100
Subject: [PATCH 00/19] RESEND staging: lustre: use standard wait_event macros
Cc: lkml <linux-kernel@vger.kernel.org>, lustre <lustre-devel@lists.lustre.org>
Message-ID: <151847037709.22826.16175867257667686132.stgit@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592231798688368382?=
X-GMAIL-MSGID: =?utf-8?q?1592231798688368382?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,
 this is a resend of patch series that I sent a little over a month
 ago.  Since then I've recieved Reviewed-By:from James Simmons
 (thanks) and confirmation that it passes his testing.
 I cannot quite say that all tests pass for me with these patch,
 but the tests produce the same results both with and without the
 patches.

 No non-trivial changes - a couple of typos in change descriptions
 fixes, and reviewed-by's added.

Previous intro text:
Hi,
 this is a revised version of the patch series I sent under a similar
 subject in mid December.
 Improvements are:
   - new wait_event_idle* macros are now in include/linux/wait.h which
     Ack from peterz.
   - *all* waits are now TASK_IDLE or TASK_INTERRUPTIBLE and so don't
     affect the load average.  There is no need to choose whether load
     is appropriate or not in each case.
   - all l_wait_event() users are handled so l_wait_event() is
     removed.  The one case I had left out before uses
     wait_event_idle_exclusive() with and option of using
     wait_event_idle_exclusive_lifo() is that ever gets approved.

 I think this set is ready to go.
 If you only review two patches, please review

    staging: lustre: simplify waiting in ldlm_completion_ast()
and
    staging: lustre: remove back_to_sleep()

 as in both of those, the actual behaviour of the current code (as I
 understand it) doesn't seem to agree with comments/debug message, or
 just generally looks odd.

Thanks,
NeilBrown

---

NeilBrown (19):
      sched/wait: add wait_event_idle() functions.
      staging: lustre: discard SVC_SIGNAL and related functions
      staging: lustre: replace simple cases of l_wait_event() with wait_event().
      staging: lustre: discard cfs_time_seconds()
      staging: lustre: use wait_event_idle_timeout() where appropriate.
      staging: lustre: introduce and use l_wait_event_abortable()
      staging: lustre: simplify l_wait_event when intr handler but no timeout.
      staging: lustre: simplify waiting in ldlm_completion_ast()
      staging: lustre: open code polling loop instead of using l_wait_event()
      staging: lustre: simplify waiting in ptlrpc_invalidate_import()
      staging: lustre: remove back_to_sleep()
      staging: lustre: make polling loop in ptlrpc_unregister_bulk more obvious
      staging: lustre: use wait_event_idle_timeout in ptlrpcd()
      staging: lustre: improve waiting in sptlrpc_req_refresh_ctx
      staging: lustre: use explicit poll loop in ptlrpc_service_unlink_rqbd
      staging: lustre: use explicit poll loop in ptlrpc_unregister_reply
      staging: lustre: remove l_wait_event from ptlrpc_set_wait
      staging: lustre: replace l_wait_event_exclusive_head() with wait_event_idle_exclusive
      staging: lustre: remove l_wait_event() and related code


 .../lustre/include/linux/libcfs/libcfs_debug.h     |    4 
 .../lustre/include/linux/libcfs/libcfs_time.h      |    2 
 .../lustre/include/linux/libcfs/linux/linux-time.h |    7 
 .../staging/lustre/lnet/klnds/o2iblnd/o2iblnd.c    |    8 -
 .../staging/lustre/lnet/klnds/o2iblnd/o2iblnd_cb.c |    4 
 .../staging/lustre/lnet/klnds/socklnd/socklnd.c    |    6 
 .../staging/lustre/lnet/klnds/socklnd/socklnd_cb.c |   22 +
 drivers/staging/lustre/lnet/libcfs/debug.c         |    2 
 drivers/staging/lustre/lnet/libcfs/fail.c          |    2 
 drivers/staging/lustre/lnet/libcfs/tracefile.c     |    4 
 drivers/staging/lustre/lnet/lnet/acceptor.c        |    2 
 drivers/staging/lustre/lnet/lnet/api-ni.c          |    4 
 drivers/staging/lustre/lnet/lnet/lib-move.c        |    4 
 drivers/staging/lustre/lnet/lnet/net_fault.c       |   14 -
 drivers/staging/lustre/lnet/lnet/peer.c            |    2 
 drivers/staging/lustre/lnet/lnet/router.c          |    8 -
 drivers/staging/lustre/lnet/selftest/conrpc.c      |    4 
 drivers/staging/lustre/lnet/selftest/rpc.c         |    2 
 drivers/staging/lustre/lnet/selftest/selftest.h    |    2 
 drivers/staging/lustre/lnet/selftest/timer.c       |    2 
 drivers/staging/lustre/lustre/include/lustre_dlm.h |    2 
 drivers/staging/lustre/lustre/include/lustre_lib.h |  296 ++------------------
 drivers/staging/lustre/lustre/include/lustre_mdc.h |    2 
 drivers/staging/lustre/lustre/include/lustre_net.h |    8 -
 drivers/staging/lustre/lustre/ldlm/ldlm_flock.c    |   30 --
 drivers/staging/lustre/lustre/ldlm/ldlm_lock.c     |   14 -
 drivers/staging/lustre/lustre/ldlm/ldlm_lockd.c    |   12 -
 drivers/staging/lustre/lustre/ldlm/ldlm_pool.c     |   17 -
 drivers/staging/lustre/lustre/ldlm/ldlm_request.c  |   55 +---
 drivers/staging/lustre/lustre/ldlm/ldlm_resource.c |   14 -
 drivers/staging/lustre/lustre/llite/llite_lib.c    |   23 +-
 drivers/staging/lustre/lustre/llite/statahead.c    |   60 ++--
 drivers/staging/lustre/lustre/lov/lov_object.c     |    6 
 drivers/staging/lustre/lustre/lov/lov_request.c    |   12 -
 drivers/staging/lustre/lustre/mdc/mdc_request.c    |    5 
 drivers/staging/lustre/lustre/mgc/mgc_request.c    |   19 -
 drivers/staging/lustre/lustre/obdclass/cl_io.c     |   23 +-
 drivers/staging/lustre/lustre/obdclass/genops.c    |   24 +-
 drivers/staging/lustre/lustre/obdclass/llog_obd.c  |    5 
 .../staging/lustre/lustre/obdecho/echo_client.c    |    2 
 drivers/staging/lustre/lustre/osc/osc_cache.c      |   28 +-
 drivers/staging/lustre/lustre/osc/osc_object.c     |    6 
 drivers/staging/lustre/lustre/osc/osc_page.c       |    6 
 drivers/staging/lustre/lustre/osc/osc_request.c    |    6 
 drivers/staging/lustre/lustre/ptlrpc/client.c      |  101 +++----
 drivers/staging/lustre/lustre/ptlrpc/events.c      |    7 
 drivers/staging/lustre/lustre/ptlrpc/import.c      |   51 +--
 drivers/staging/lustre/lustre/ptlrpc/niobuf.c      |   15 +
 .../staging/lustre/lustre/ptlrpc/pack_generic.c    |    9 -
 drivers/staging/lustre/lustre/ptlrpc/pinger.c      |   28 +-
 .../staging/lustre/lustre/ptlrpc/ptlrpc_internal.h |    2 
 drivers/staging/lustre/lustre/ptlrpc/ptlrpcd.c     |   18 +
 drivers/staging/lustre/lustre/ptlrpc/recover.c     |   12 -
 drivers/staging/lustre/lustre/ptlrpc/sec.c         |   34 ++
 drivers/staging/lustre/lustre/ptlrpc/sec_gc.c      |   23 --
 drivers/staging/lustre/lustre/ptlrpc/service.c     |   84 +++---
 include/linux/wait.h                               |  114 ++++++++
 57 files changed, 516 insertions(+), 762 deletions(-)

--
Signature
