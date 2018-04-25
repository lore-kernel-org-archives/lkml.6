Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48C6oZfXwJbY5SPZRwOK/00ntSyl6UUaoPd+e1TXhKPnWkJ/4+RWDR/23G7Kb02Ms7CktxP
ARC-Seal: i=1; a=rsa-sha256; t=1524652706; cv=none;
        d=google.com; s=arc-20160816;
        b=FpOzmOwe/QHdeHPqUK0Kcsuz4mnh0upPgdWIoeCfrf5qM7Grumc5dHFcKh5T9jY+oy
         PsDw/armystZddLGRT2ltOup0nWSsQZ3LXPyhpRV87RCmp+hC+DjEzFjQXta7SbimqfA
         ZEAg1OaBJXivdvSuDjbs5UJt6hyJgWzoFm2aZIXfLff4/mfGSt9WznUeZjxkJN0q8Gc8
         NhkuDCrsRVlWbRjG2Ht0e8pA3zR6WuF2DJ6uqETgzynL+IVTVCCbbxj76XXp1otTVpQ2
         v+uHXQvcZYoH54KQRao7OvsdV4EmyD53/sn93ITUf6EJ6oJe9xGsvhnNYO3xbux6gp3E
         N7mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=SlmbVhkViWkKfX3GuKBGEm8hLAIowRHpefiiKLtKOwk=;
        b=d6HvYokXBodK+taJQL3/myujrHq7gvByd0hcVBxt+OEV+qyyYjR7RszCJ6T2dCwWkc
         Z67Ud6kxdqfbqXyl7TRZ0+z3Kj5qEgOxIMZQtgcIJWI/mQkt7GKos4b3/aqttfH8sXaD
         OvgLjlxLBYf7Xq+SzoRhSvFGcPtKJj36KFyTL/GobKml4eccYjaM/UaexM8eFTuNPTrq
         YPrYwjNw+dzB/sqx2Nq34VWXrRlvf6ms3qQUdi4f68HQYQkIWON/O4o+NVU7mWp3TqcE
         bWJaVn2L/VHzVxuCoIG7Yd4UU7jmK0z+Agoplssvn26NoCWmd4ZXJYHdhvlpJ2TWW8LV
         5Uwg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Adrian Hunter <adrian.hunter@intel.com>,
	David Ahern <dsahern@gmail.com>,
	Hendrick Brueckner <brueckner@linux.vnet.ibm.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Thomas Richter <tmricht@linux.vnet.ibm.com>,
	Wang Nan <wangnan0@huawei.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 040/183] perf callchain: Fix attr.sample_max_stack setting
Date: Wed, 25 Apr 2018 12:34:20 +0200
Message-Id: <20180425103244.184508826@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103242.532713678@linuxfoundation.org>
References: <20180425103242.532713678@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598714236429791543?=
X-GMAIL-MSGID: =?utf-8?q?1598714236429791543?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnaldo Carvalho de Melo <acme@redhat.com>


[ Upstream commit 249d98e567e25dd03e015e2d31e1b7b9648f34df ]

When setting the "dwarf" unwinder for a specific event and not
specifying the max-stack, the attr.sample_max_stack ended up using an
uninitialized callchain_param.max_stack, fix it by using designated
initializers for that callchain_param variable, zeroing all non
explicitely initialized struct members.

Here is what happened:

  # perf trace -vv --no-syscalls --max-stack 4 -e probe_libc:inet_pton/call-graph=dwarf/ ping -6 -c 1 ::1
  callchain: type DWARF
  callchain: stack dump size 8192
  perf_event_attr:
    type                             2
    size                             112
    config                           0x730
    { sample_period, sample_freq }   1
    sample_type                      IP|TID|TIME|ADDR|CALLCHAIN|CPU|PERIOD|RAW|REGS_USER|STACK_USER|DATA_SRC
    exclude_callchain_user           1
    { wakeup_events, wakeup_watermark } 1
    sample_regs_user                 0xff0fff
    sample_stack_user                8192
    sample_max_stack                 50656
  sys_perf_event_open failed, error -75
  Value too large for defined data type
  # perf trace -vv --no-syscalls --max-stack 4 -e probe_libc:inet_pton/call-graph=dwarf/ ping -6 -c 1 ::1
  callchain: type DWARF
  callchain: stack dump size 8192
  perf_event_attr:
    type                             2
    size                             112
    config                           0x730
    sample_type                      IP|TID|TIME|ADDR|CALLCHAIN|CPU|PERIOD|RAW|REGS_USER|STACK_USER|DATA_SRC
    exclude_callchain_user           1
    sample_regs_user                 0xff0fff
    sample_stack_user                8192
    sample_max_stack                 30448
  sys_perf_event_open failed, error -75
  Value too large for defined data type
  #

Now the attr.sample_max_stack is set to zero and the above works as
expected:

  # perf trace --no-syscalls --max-stack 4 -e probe_libc:inet_pton/call-graph=dwarf/ ping -6 -c 1 ::1
  PING ::1(::1) 56 data bytes
  64 bytes from ::1: icmp_seq=1 ttl=64 time=0.072 ms

  --- ::1 ping statistics ---
  1 packets transmitted, 1 received, 0% packet loss, time 0ms
  rtt min/avg/max/mdev = 0.072/0.072/0.072/0.000 ms
       0.000 probe_libc:inet_pton:(7feb7a998350))
                                         __inet_pton (inlined)
                                         gaih_inet.constprop.7 (/usr/lib64/libc-2.26.so)
                                         __GI_getaddrinfo (inlined)
                                         [0xffffaa39b6108f3f] (/usr/bin/ping)
  #

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Hendrick Brueckner <brueckner@linux.vnet.ibm.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Thomas Richter <tmricht@linux.vnet.ibm.com>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-is9tramondqa9jlxxsgcm9iz@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/perf/util/evsel.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -722,14 +722,14 @@ static void apply_config_terms(struct pe
 	struct perf_evsel_config_term *term;
 	struct list_head *config_terms = &evsel->config_terms;
 	struct perf_event_attr *attr = &evsel->attr;
-	struct callchain_param param;
+	/* callgraph default */
+	struct callchain_param param = {
+		.record_mode = callchain_param.record_mode,
+	};
 	u32 dump_size = 0;
 	int max_stack = 0;
 	const char *callgraph_buf = NULL;
 
-	/* callgraph default */
-	param.record_mode = callchain_param.record_mode;
-
 	list_for_each_entry(term, config_terms, list) {
 		switch (term->type) {
 		case PERF_EVSEL__CONFIG_TERM_PERIOD:
