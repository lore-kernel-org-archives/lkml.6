Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1356EC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 21:07:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4BDC2176F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 21:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549314464;
	bh=YG3gLhHCItxKRLkiqzjLjfv0P4jXp8JpzDQCk0nccYA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=aY6OflD8xhm++AszZo4ALkpgx03dEOrtTRJzrxXbMJCocyA0ddkd2+fUSMdAGGziz
	 LqVb5tbrpZHRR/o3gSuGzTHmM0U4VMXdCgyagpFHJYx3hQh90N+hmsLL+EjKDul+kI
	 QYv47w/9jzgdnIwGolaFn5RvD83UZ9kEHrTjXllg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729802AbfBDVHi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 16:07:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:32966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729534AbfBDVHf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 16:07:35 -0500
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D3012083B;
        Mon,  4 Feb 2019 21:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549314455;
        bh=YG3gLhHCItxKRLkiqzjLjfv0P4jXp8JpzDQCk0nccYA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=zm31fbbCvAkvAxQ+GHo51tYfOhEaOlnyRDkP2AvxwRkMbLVUA5I36vl/J6h8RTddD
         1w/RmMlq5EPJ0pq+9kCRRYXNL79FRE5H1hKeJZv1rRbk9Qd7hbG8My+KhtCk9NnWPL
         RGb7nDxjPJ5v+D6ICuPMAZo1t8VRdsfT3wMXkgmc=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH 2/2] tracing: Use strncpy instead of memcpy for string keys in hist triggers
Date:   Mon,  4 Feb 2019 15:07:24 -0600
Message-Id: <50c35ae1267d64eee975b8125e151e600071d4dc.1549309756.git.tom.zanussi@linux.intel.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1549309756.git.tom.zanussi@linux.intel.com>
References: <cover.1549309756.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1549309756.git.tom.zanussi@linux.intel.com>
References: <cover.1549309756.git.tom.zanussi@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Zanussi <tom.zanussi@linux.intel.com>

Because there may be random garbage beyond a string's null terminator,
it's not correct to copy the the complete character array for use as a
hist trigger key.  This results in multiple histogram entries for the
'same' string key.

So, in the case of a string key, use strncpy instead of memcpy to
avoid copying in the extra bytes.

Before, using the gdbus entries in the following hist trigger as an
example:

  # echo 'hist:key=comm' > /sys/kernel/debug/tracing/events/sched/sched_waking/trigger
  # cat /sys/kernel/debug/tracing/events/sched/sched_waking/hist

  ...

  { comm: ImgDecoder #4                      } hitcount:        203
  { comm: gmain                              } hitcount:        213
  { comm: gmain                              } hitcount:        216
  { comm: StreamTrans #73                    } hitcount:        221
  { comm: mozStorage #3                      } hitcount:        230
  { comm: gdbus                              } hitcount:        233
  { comm: StyleThread#5                      } hitcount:        253
  { comm: gdbus                              } hitcount:        256
  { comm: gdbus                              } hitcount:        260
  { comm: StyleThread#4                      } hitcount:        271

  ...

  # cat /sys/kernel/debug/tracing/events/sched/sched_waking/hist | egrep gdbus | wc -l
  51

After:

  # cat /sys/kernel/debug/tracing/events/sched/sched_waking/hist | egrep gdbus | wc -l
  1

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
---
 kernel/trace/trace_events_hist.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index c4a667503bf0..1b349689b897 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -4695,9 +4695,10 @@ static inline void add_to_key(char *compound_key, void *key,
 		/* ensure NULL-termination */
 		if (size > key_field->size - 1)
 			size = key_field->size - 1;
-	}
 
-	memcpy(compound_key + key_field->offset, key, size);
+		strncpy(compound_key + key_field->offset, (char *)key, size);
+	} else
+		memcpy(compound_key + key_field->offset, key, size);
 }
 
 static void
-- 
2.14.1

