Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753483AbeC1OJm (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 10:09:42 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:46307 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752725AbeC1OJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 10:09:40 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Rajvi Jingar <rajvi.jingar@intel.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] tracing: avoid string overflow
Date: Wed, 28 Mar 2018 16:09:10 +0200
Message-Id: <20180328140920.2842153-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K0:q6WMWnbtXTvRuKklsylCCybv53yK04Nv170eUp4JJqZR066zstl
 6wAkHd8Fm//XqlEZBgHJAfaaK3orKoiHGpm/loziCQaVrKI2U1algS5VdTzeoo2CaiFtvv0
 s6gUyVkWRrp01i9G282cO+PEVqmDpYjpW/nMWwkLvs4SeJVwDb0zbK0B2aFq2LBRZsMB48v
 A9zwlv4v2YYjrD/51oyHg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:gPP4Bn5ChHw=:RLnRScZYxECAleqv7wDUAb
 tQJMKdRsVb0NEfP7BYAoflSJWTxvNtakZjAxiMhLgEWoZ8tM3fWkd3HikzQvn5xmc0rXD/NE1
 l0RmDm3WvXJyc7qs5z+eBhTGsvJ3H61EpZ1sPWpFtKzw2UGwgOVB0ghWkafCd5dCBJgliJ6zO
 hNi0P9I3hFmHpDHlviWtHASX73fftQ5MXFGfqe4f6PboGK+5nG2PJlD+f1jNUshypwbdZC1aT
 6QRlilr0SbRrHiwU8VT0nYxn8RCr/uAJyZvpgOdRrpO85TRJ4l2k+4VQo76lpnx7wrAwvt9hB
 S2PofzD19GxqjW34Ar6SCwyAzJyyKTfHDd0fVHkJFOmphfSCnszNFm08F8JnE6B7/Fe/LIMZx
 RGvq3L35gVGgdkKmbMbcS0OCtCWRqHK42F5fY6/SrwOBBd63UDWeJhn2LsVgdvJfHOGMsRZe7
 cbqVNQUxX9DjD4QPHO3eBKkSTRed/dE6zRCjLLpyOjyKYhULpcyTicDOPJvrgJvE9Akym3S+4
 BkfbJG0ZtyYXQlLdOkANLU0uop/Yy72OJMcEblKmRPYLDzD80evS1SwTAm66Pzi0NvrICeleO
 ms5BM+PE+K0rFr8SXdb4S5od3Mv5sAI96aMX99yFtM6mT0+yS1H/arWksg4tU+vk5Jg9G+7Ap
 wfjYr2yT2f/Vq4Xhz3s7HRYfzvYWwo29fSaOmsVGh8+1oWwMgx3CMbNVK7OTo19HUmHlZ0fvj
 AI+FWCfCbezx9MNoDbUcf7jMWuyu2yf9bf3Nlw==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'err' is used as a NUL-terminated string, but using strncpy() with the length
equal to the buffer size may result in lack of the termination:

kernel/trace/trace_events_hist.c: In function 'hist_err_event':
kernel/trace/trace_events_hist.c:396:3: error: 'strncpy' specified bound 256 equals destination size [-Werror=stringop-truncation]
   strncpy(err, var, MAX_FILTER_STR_VAL);

This changes it to use the safer strscpy() instead.

Fixes: f404da6e1d46 ("tracing: Add 'last error' error facility for hist triggers")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 kernel/trace/trace_events_hist.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 4f027642ceef..8357f36d7a1e 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -393,7 +393,7 @@ static void hist_err_event(char *str, char *system, char *event, char *var)
 	else if (system)
 		snprintf(err, MAX_FILTER_STR_VAL, "%s.%s", system, event);
 	else
-		strncpy(err, var, MAX_FILTER_STR_VAL);
+		strscpy(err, var, MAX_FILTER_STR_VAL);
 
 	hist_err(str, err);
 }
-- 
2.9.0
