Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELs5X/cxop/wepEwsn210xhrCEhGiX4oB2vmbnv3H+9Rq5IS65kugse0eI/M7bgNtZFlB5nS
ARC-Seal: i=1; a=rsa-sha256; t=1519410872; cv=none;
        d=google.com; s=arc-20160816;
        b=M+QVFpPXm+g7og+KrJe8dsxemf6XdHG2ZLAZhDtHmZqO5E1Kaz7i6f1JQlswygPSUj
         egAsNCCo4kVASzTpMIy5kK62d4b8Wih8hyxtRXjQXP14hPnn36eDDQS4sEvMTmYr+3uW
         RVjlRWR3BMoKx9UidJ/mTInfEHLx1Us/aaBJ0/XDzOWrXx+8bak4lXtn28qXJFbfufhF
         Nhg6l5XpmeCSHe42mJFilYx/d8NrAI2HVZuw7I8dUd7b1mWIL4BxWO5tSDd9673dFSaW
         DFsQbXNs3pVTygDOTe43Dt1pBVkXkjY0lUsK2P6joux9Uu4d0DsSQNKFjA2z9+NqLRnw
         K2Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=aZUoiu8gD5qNhUJu/StKGiukfbeMoKv0YIHq/X5+GYg=;
        b=zhYQSxyuzqK+8Mj6bsIPgKyPhIK5o+HgsFOOii/HP8GwdDqka/8+wOL+e45qD51ctu
         KRR+LKxyMLdYhrXeS8xmCv2p6gEfREWVG9kFm/yY8zwOcuVjApixqHvn3nCItawqD2/8
         0vy5P6QMsrUN1W3DFRYKDm3DH0zgvwqcpeg2mCvS75lGENujNL0L5TyCmh6Fc14EcMyU
         e0BJ6B8Eb3KSSR7qKeDsgCp/WwBDpf5pfguT9OU5mnjExLEfZw7DFXiw6EtA2e7Mzeoj
         HsqOefg8j/vbwgHJTUmOXh2LCXECS5jQ+lZv4ZICIhnrraocbErLL1iH2rT1RSdAo7aa
         mR2w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
	Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 043/193] powerpc/perf: Fix oops when grouping different pmu events
Date: Fri, 23 Feb 2018 19:24:36 +0100
Message-Id: <20180223170332.800079565@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593217645800636005?=
X-GMAIL-MSGID: =?utf-8?q?1593217774922429968?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>


[ Upstream commit 5aa04b3eb6fca63d2e9827be656dcadc26d54e11 ]

When user tries to group imc (In-Memory Collections) event with
normal event, (sometime) kernel crashes with following log:

    Faulting instruction address: 0x00000000
    [link register   ] c00000000010ce88 power_check_constraints+0x128/0x980
    ...
    c00000000010e238 power_pmu_event_init+0x268/0x6f0
    c0000000002dc60c perf_try_init_event+0xdc/0x1a0
    c0000000002dce88 perf_event_alloc+0x7b8/0xac0
    c0000000002e92e0 SyS_perf_event_open+0x530/0xda0
    c00000000000b004 system_call+0x38/0xe0

'event_base' field of 'struct hw_perf_event' is used as flags for
normal hw events and used as memory address for imc events. While
grouping these two types of events, collect_events() tries to
interpret imc 'event_base' as a flag, which causes a corruption
resulting in a crash.

Consider only those events which belongs to 'perf_hw_context' in
collect_events().

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Reviewed-By: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/perf/core-book3s.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -1381,7 +1381,7 @@ static int collect_events(struct perf_ev
 	int n = 0;
 	struct perf_event *event;
 
-	if (!is_software_event(group)) {
+	if (group->pmu->task_ctx_nr == perf_hw_context) {
 		if (n >= max_count)
 			return -1;
 		ctrs[n] = group;
@@ -1389,7 +1389,7 @@ static int collect_events(struct perf_ev
 		events[n++] = group->hw.config;
 	}
 	list_for_each_entry(event, &group->sibling_list, group_entry) {
-		if (!is_software_event(event) &&
+		if (event->pmu->task_ctx_nr == perf_hw_context &&
 		    event->state != PERF_EVENT_STATE_OFF) {
 			if (n >= max_count)
 				return -1;
