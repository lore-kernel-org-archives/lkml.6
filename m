Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936927AbeE1KPR (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:15:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:35198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936913AbeE1KPD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:15:03 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 025/268] tools lib traceevent: Simplify pointer print logic and fix %pF
Date: Mon, 28 May 2018 11:59:59 +0200
Message-Id: <20180528100204.933706663@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100202.045206534@linuxfoundation.org>
References: <20180528100202.045206534@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

[ Upstream commit 38d70b7ca1769f26c0b79f3c08ff2cc949712b59 ]

When processing %pX in pretty_print(), simplify the logic slightly by
incrementing the ptr to the format string if isalnum(ptr[1]) is true.
This follows the logic a bit more closely to what is in the kernel.

Also, this fixes a small bug where %pF was not giving the offset of the
function.

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Link: http://lkml.kernel.org/r/20180112004822.260262257@goodmis.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/lib/traceevent/event-parse.c |   17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

--- a/tools/lib/traceevent/event-parse.c
+++ b/tools/lib/traceevent/event-parse.c
@@ -4905,21 +4905,22 @@ static void pretty_print(struct trace_se
 				else
 					ls = 2;
 
-				if (*(ptr+1) == 'F' || *(ptr+1) == 'f' ||
-				    *(ptr+1) == 'S' || *(ptr+1) == 's') {
+				if (isalnum(ptr[1]))
 					ptr++;
+
+				if (*ptr == 'F' || *ptr == 'f' ||
+				    *ptr == 'S' || *ptr == 's') {
 					show_func = *ptr;
-				} else if (*(ptr+1) == 'M' || *(ptr+1) == 'm') {
-					print_mac_arg(s, *(ptr+1), data, size, event, arg);
-					ptr++;
+				} else if (*ptr == 'M' || *ptr == 'm') {
+					print_mac_arg(s, *ptr, data, size, event, arg);
 					arg = arg->next;
 					break;
-				} else if (*(ptr+1) == 'I' || *(ptr+1) == 'i') {
+				} else if (*ptr == 'I' || *ptr == 'i') {
 					int n;
 
-					n = print_ip_arg(s, ptr+1, data, size, event, arg);
+					n = print_ip_arg(s, ptr, data, size, event, arg);
 					if (n > 0) {
-						ptr += n;
+						ptr += n - 1;
 						arg = arg->next;
 						break;
 					}
