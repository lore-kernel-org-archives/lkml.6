Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 828A8C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 01:24:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BA6B21A6D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 01:24:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NAUg+HbJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BA6B21A6D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387911AbeHGDf4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 23:35:56 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40973 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731331AbeHGDf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 23:35:56 -0400
Received: by mail-pf1-f194.google.com with SMTP id y10-v6so7701296pfn.8
        for <linux-kernel@vger.kernel.org>; Mon, 06 Aug 2018 18:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=OmEbpA5E3TywmtVkscx5dzs2EkbrqmpVYG01UCZaGwE=;
        b=NAUg+HbJeL2eeMflsmYRhLfvrLALdFInERKAPoiNduuMYb+lzZvGsef+vfBLahbj8P
         FjFDXInCkPRifSgEg3++LnK/URLucH1MaJvyZGlYILiuIeazb/JdW1rN3iUYKOUEoesG
         EnG7enSi13NR7p1p1DeYghF7/24yXAHPazzeS4Q1D90HE2IAkCHVAK5yrTNmGj1UukwV
         8J4lsQIhR9TS4KdnW2z9bLHgX3LihEIu/Tk9QJNGz66w4C8u4bFsr8kJgTZ47A/LMtA9
         Io05OCAiHusbVqSIROcYNbYmtPuolWJ00mNuktqxDYEoetlqslXoHCekTcVrRm92m/Bi
         Uusg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=OmEbpA5E3TywmtVkscx5dzs2EkbrqmpVYG01UCZaGwE=;
        b=kpsQ+/zZ/6YhyECEq88YImyXXzHlPXwEjhKGuVCU/6CFkb+xNn9wBIwQWwvawam0tQ
         CI9olr3urLY5xLAHl4oybgKfQFELzaz6rjSnLP/rFW95hutoFQ2poTm7XHb48jax10dI
         qsy0OEPkQACTnzxR5RQAFexhUf4C9zN7g+L7zEPyXAqmq0QAxB0jM9bP0jzp5bBKcdZj
         BdDzWnMnKBil96844OnNRQDxY6k1lpEpt+0ZUup8SWuRoMZXOe1QKMgEYO27QbsBxVcZ
         9fNU6e9yNjyLsJH/PbevV7BRwH1rE6DL5zUbBw+72rsSaX7GZU+2w4g4+y40maYuPFDN
         LFSA==
X-Gm-Message-State: AOUpUlFFQUmiR7qeGGomaDJ7HCqQuekw5LMjdiKCBexDFknNCNB1Y3GG
        9EV7u10nm63QoFkzWE10ylRztZwLA0o=
X-Google-Smtp-Source: AAOMgpfomouh9tHK/ekZfza1jJvVncN2AwJxK3hgykYQyk+2uOTGeB8vmf1oAL8bzyb5IMLlfq4GKg==
X-Received: by 2002:a65:5144:: with SMTP id g4-v6mr16513819pgq.21.1533605046591;
        Mon, 06 Aug 2018 18:24:06 -0700 (PDT)
Received: from localhost ([104.133.8.110])
        by smtp.gmail.com with ESMTPSA id x2-v6sm25859005pfi.166.2018.08.06.18.24.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Aug 2018 18:24:05 -0700 (PDT)
From:   Stephane Eranian <eranian@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     acme@redhat.com, peterz@infradead.org, mingo@elte.hu,
        jolsa@redhat.com
Subject: [PATCH] perf ordered_events: fix crash in free_dup_event()
Date:   Mon,  6 Aug 2018 18:23:35 -0700
Message-Id: <1533605015-19514-1-git-send-email-eranian@google.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Depending on memory allocations, it was possible to get a SEGFAULT in
free_dup_event() because the event pointer was bogus:

perf[1354]: segfault at ffffffff00000006 ip 00000000004b7fc7

Initially, I thought it was some double free. But it turns out
it looked more like a buffer overrun. Adding padding before
the union perf_event field in struct ordered_event avoided the
problem. But it was not obvious where this could be coming from
given the accesses to the struct, i.e.,  no internal array.

Then, it struck me that the following was bogus in __dup_event():

 __dup_event(struct ordered_events *oe, union perf_event *event)
{
   ...
   union perf_event *new_event;
   new_event = memdup(event, event->header.size);
   ...
}

The problem here is that header.size <= sizeof(*new_event). The code
was trying to copy only what was necessary, but then, the allocation
was also only partial. In other words if the event was not the largest
possible for the union, it would not be fully backed by memory, likely
causing troubles.

This patch fixes the problem by passing the size of the union and not
that of the actual event.

Signed-off-by: Stephane Eranian <eranian@google.com>

---
 tools/perf/util/ordered-events.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/ordered-events.c b/tools/perf/util/ordered-events.c
index bad9e0296e9a..a90dbe5df019 100644
--- a/tools/perf/util/ordered-events.c
+++ b/tools/perf/util/ordered-events.c
@@ -66,9 +66,9 @@ static union perf_event *__dup_event(struct ordered_events *oe,
 	union perf_event *new_event = NULL;
 
 	if (oe->cur_alloc_size < oe->max_alloc_size) {
-		new_event = memdup(event, event->header.size);
+		new_event = memdup(event, sizeof(*event));
 		if (new_event)
-			oe->cur_alloc_size += event->header.size;
+			oe->cur_alloc_size += sizeof(*event);
 	}
 
 	return new_event;
-- 
2.18.0.597.ga71716f1ad-goog

