Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968477AbeEZAUK (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 20:20:10 -0400
Received: from mail-wr0-f171.google.com ([209.85.128.171]:35781 "EHLO
        mail-wr0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S968411AbeEZAUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 20:20:08 -0400
X-Google-Smtp-Source: AB8JxZp+NYUS8nw55Cze4WCPOygzHM0Q0ICL150br1cDCgyc+WBUZjbKs2XhBRU+gfOK5oco9ipPSuaqZJ4tWKmi8hI=
MIME-Version: 1.0
From: Stephane Eranian <eranian@google.com>
Date: Fri, 25 May 2018 17:19:54 -0700
Message-ID: <CABPqkBRi5T2-hqgywLundiu=w1ekbjdAeKCrzRaUUrMSPSxvFw@mail.gmail.com>
Subject: [BUG] perf/inject: crash in pipe mode
To: LKML <linux-kernel@vger.kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>, mingo@elte.hu,
        Peter Zijlstra <peterz@infradead.org>, Andi Kleen <ak@linux.intel.com>,
        Vince Weaver <vincent.weaver@maine.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


With the latest tip.git perf, if you run

$ perf record -a -o - sleep 2 | perf inject -b -i - | perf buildid-list -i -
SEGFAULT in perf inject:
free_dup_event (oe=0x555555d25b88, oe=0x555555d25b88,
event=0x3030310931303031) at util/ordered-events.c:86
86 oe->cur_alloc_size -= event->header.size;
(gdb) bt
#0  free_dup_event (oe=0x555555d25b88, oe=0x555555d25b88,
event=0x3030310931303031) at util/ordered-events.c:86
#1  ordered_events__free (oe=oe@entry=0x555555d25b88) at
util/ordered-events.c:310
#2  0x00005555557964f8 in __perf_session__process_pipe_events
(session=0x555555d1f910) at util/session.c:1778
#3  perf_session__process_events (session=session@entry=0x555555d1f910) at
util/session.c:1958
#4  0x00005555556ef9b2 in __cmd_inject (inject=0x7fffffffda40) at
builtin-inject.c:697
#5  cmd_inject (argc=<optimized out>, argv=<optimized out>) at
builtin-inject.c:871
#6  0x000055555572e8b1 in run_builtin (p=0x555555be8f98 <commands+600>,
argc=4, argv=0x7fffffffe460) at perf.c:303
#7  0x000055555572ebae in handle_internal_command (argc=4,
argv=0x7fffffffe460) at perf.c:355
#8  0x00005555556ae1e1 in run_argv (argcp=<synthetic pointer>,
argv=<synthetic pointer>) at perf.c:399
#9  main (argc=<optimized out>, argv=0x7fffffffe460) at perf.c:521

In general I think the pipe mode is not very well tested. I think it could
be made the default file format. I believe perf can
autodetect file vs. pipe mode perf.data using the header.size field. This
would simplify a few things inside perf and ensure
the pipe mode format is well tested.
