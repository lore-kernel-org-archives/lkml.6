Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvuxV+n1iAxaqWy6Aj+RPlTdhhpNE57Zm7lxyjg/ZlA/KE4lzCkPsua5xHBKX7G07Hn3W4C
ARC-Seal: i=1; a=rsa-sha256; t=1521483928; cv=none;
        d=google.com; s=arc-20160816;
        b=AnaBjfxCwJcOifjBs9z6GN6kmV55WdIfNyLiXIMui6RekkdfFZzmIs324v8A3c6Kwb
         t+XNjGkfxr9uJchqPRxC1ttVaa3uI/KNMFC+P2REDfANTXL/xEOioAaAIeu86AasjKaq
         c/Zuq7ZhljQqUmsfzlrtBDpEk+Ybf5cJrj4mNI/XC08FdsluWkBTtWNNGKmb6YgEG/ge
         dGbZOr1TUDVPjtqnGmSGDDkL49LLYeOsDAmCsy1WLp8fGok7woDQPalgHieZcFBuxv03
         SupWwQqnwExf79qQKTAzQ7IY4ztP/qU07axPyksrDuNlRy/ln/QaF0UFsb8TVJ0n7l1D
         dpBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=3kKVNlrFufsh1/Jj82wX7zXNIn+Ha99Vg+vI5hIF4G4=;
        b=YTfKxiJJ+oxf4/hJYkJrCAKV2ZBcLjsspYuTuxKZStrVidXplFrbfVX2HIocl+nwgT
         HhhVkpxBY8meQNsBWJvwiad7a61dJTLtB7/P22THORQKYFr4E/3w3Ak7OACbne0EpqSw
         kP634k3snx+IXIgsGGhaPvcH+DBvfkDI9fE0BkXX/hPiINY15WfuTA3lga6uuh0T59F5
         6H0RxmYhHy3mOdnnIqjiD1onEK9CvxSmQtEUFQSdyQ2Esqkz3WJh2U8XtE0Whe8+2hLS
         vb2GrA2CwwES1T/cQY5KvzmTxoReE1V/EzRLwKtjStSImMk3gEfV07C0vD9AoyqkbiQN
         1J0w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Yao Jin <yao.jin@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Kan Liang <kan.liang@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 141/241] perf evsel: Return exact sub event which failed with EPERM for wildcards
Date: Mon, 19 Mar 2018 19:06:46 +0100
Message-Id: <20180319180757.025219026@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595391531671125432?=
X-GMAIL-MSGID: =?utf-8?q?1595391531671125432?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jin Yao <yao.jin@linux.intel.com>


[ Upstream commit 32ccb130f5325abc81b32b1a538390f46e4860f6 ]

The kernel has a special check for a specific irq_vectors trace event.

TRACE_EVENT_PERF_PERM(irq_work_exit,
	is_sampling_event(p_event) ? -EPERM : 0);

The perf-record fails for this irq_vectors event when it is present,
like when using a wildcard:

  root@skl:/tmp# perf record -a -e irq_vectors:* sleep 2
  Error:
  You may not have permission to collect system-wide stats.

  Consider tweaking /proc/sys/kernel/perf_event_paranoid,
  which controls use of the performance events system by
  unprivileged users (without CAP_SYS_ADMIN).

  The current value is 2:

    -1: Allow use of (almost) all events by all users
  >= 0: Disallow raw tracepoint access by users without CAP_IOC_LOCK
  >= 1: Disallow CPU event access by users without CAP_SYS_ADMIN
  >= 2: Disallow kernel profiling by users without CAP_SYS_ADMIN

  To make this setting permanent, edit /etc/sysctl.conf too, e.g.:

        kernel.perf_event_paranoid = -1

This patch prints out the exact sub event that failed with EPERM for
wildcards to help in understanding what went wrong when this event is
present:

After the patch:

  root@skl:/tmp# perf record -a -e irq_vectors:* sleep 2
  Error:
  No permission to enable irq_vectors:irq_work_exit event.

  You may not have permission to collect system-wide stats.
  ......

Committer notes:

So we have a lot of irq_vectors events:

  [root@jouet ~]# perf list irq_vectors:*

  List of pre-defined events (to be used in -e):

    irq_vectors:call_function_entry                    [Tracepoint event]
    irq_vectors:call_function_exit                     [Tracepoint event]
    irq_vectors:call_function_single_entry             [Tracepoint event]
    irq_vectors:call_function_single_exit              [Tracepoint event]
    irq_vectors:deferred_error_apic_entry              [Tracepoint event]
    irq_vectors:deferred_error_apic_exit               [Tracepoint event]
    irq_vectors:error_apic_entry                       [Tracepoint event]
    irq_vectors:error_apic_exit                        [Tracepoint event]
    irq_vectors:irq_work_entry                         [Tracepoint event]
    irq_vectors:irq_work_exit                          [Tracepoint event]
    irq_vectors:local_timer_entry                      [Tracepoint event]
    irq_vectors:local_timer_exit                       [Tracepoint event]
    irq_vectors:reschedule_entry                       [Tracepoint event]
    irq_vectors:reschedule_exit                        [Tracepoint event]
    irq_vectors:spurious_apic_entry                    [Tracepoint event]
    irq_vectors:spurious_apic_exit                     [Tracepoint event]
    irq_vectors:thermal_apic_entry                     [Tracepoint event]
    irq_vectors:thermal_apic_exit                      [Tracepoint event]
    irq_vectors:threshold_apic_entry                   [Tracepoint event]
    irq_vectors:threshold_apic_exit                    [Tracepoint event]
    irq_vectors:x86_platform_ipi_entry                 [Tracepoint event]
    irq_vectors:x86_platform_ipi_exit                  [Tracepoint event]
  #

And some may be sampled:

  [root@jouet ~]# perf record -e irq_vectors:local* sleep 20s
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.020 MB perf.data (2 samples) ]
  [root@jouet ~]# perf report -D | egrep 'stats:|events:'
  Aggregated stats:
             TOTAL events:        155
              MMAP events:        144
              COMM events:          2
              EXIT events:          1
            SAMPLE events:          2
             MMAP2 events:          4
    FINISHED_ROUND events:          1
         TIME_CONV events:          1
  irq_vectors:local_timer_entry stats:
             TOTAL events:          1
            SAMPLE events:          1
  irq_vectors:local_timer_exit stats:
             TOTAL events:          1
            SAMPLE events:          1
  [root@jouet ~]#

But, as shown in the tracepoint definition at the start of this message,
some, like "irq_vectors:irq_work_exit", may not be sampled, just counted,
i.e. if we try to sample, as when using 'perf record', we get an error:

  [root@jouet ~]# perf record -e irq_vectors:irq_work_exit
  Error:
  You may not have permission to collect system-wide stats.

  Consider tweaking /proc/sys/kernel/perf_event_paranoid,
<SNIP>

The error message is misleading, this patch will help in pointing out
what is the event causing such an error, but the error message needs
improvement, i.e. we need to figure out a way to check if a tracepoint
is counting only, like this one, when all we can do is to count it with
'perf stat', at most printing the delta using interval printing, as in:

   [root@jouet ~]# perf stat -I 5000 -e irq_vectors:irq_work_*
  #           time             counts unit events
       5.000168871                  0      irq_vectors:irq_work_entry
       5.000168871                  0      irq_vectors:irq_work_exit
      10.000676730                  0      irq_vectors:irq_work_entry
      10.000676730                  0      irq_vectors:irq_work_exit
      15.001122415                  0      irq_vectors:irq_work_entry
      15.001122415                  0      irq_vectors:irq_work_exit
      20.001298051                  0      irq_vectors:irq_work_entry
      20.001298051                  0      irq_vectors:irq_work_exit
      25.001485020                  1      irq_vectors:irq_work_entry
      25.001485020                  1      irq_vectors:irq_work_exit
      30.001658706                  0      irq_vectors:irq_work_entry
      30.001658706                  0      irq_vectors:irq_work_exit
  ^C    32.045711878                  0      irq_vectors:irq_work_entry
      32.045711878                  0      irq_vectors:irq_work_exit

  [root@jouet ~]#

But at least, when we use a wildcard, this patch helps a bit.

Signed-off-by: Yao Jin <yao.jin@linux.intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/1491566932-503-1-git-send-email-yao.jin@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/perf/util/evsel.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2400,11 +2400,17 @@ int perf_evsel__open_strerror(struct per
 			      int err, char *msg, size_t size)
 {
 	char sbuf[STRERR_BUFSIZE];
+	int printed = 0;
 
 	switch (err) {
 	case EPERM:
 	case EACCES:
-		return scnprintf(msg, size,
+		if (err == EPERM)
+			printed = scnprintf(msg, size,
+				"No permission to enable %s event.\n\n",
+				perf_evsel__name(evsel));
+
+		return scnprintf(msg + printed, size - printed,
 		 "You may not have permission to collect %sstats.\n\n"
 		 "Consider tweaking /proc/sys/kernel/perf_event_paranoid,\n"
 		 "which controls use of the performance events system by\n"
