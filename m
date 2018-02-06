Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752759AbeBFK1n (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 05:27:43 -0500
Received: from mail-wr0-f180.google.com ([209.85.128.180]:36297 "EHLO
        mail-wr0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752661AbeBFK1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 05:27:31 -0500
X-Google-Smtp-Source: AH8x226drpUZExUx5FK0Av9lGZ5vltCPIy1RMp3M+CWjb2eE4GKdbFiuSQxbAUruRUjmUb48ieckaA==
Date: Tue, 6 Feb 2018 11:27:27 +0100
From: Miklos Szeredi <miklos@szeredi.hu>
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Rich Felker <dalias@libc.org>, Szabolcs Nagy <nsz@port70.net>,
        Tomasz Majchrzak <tomasz.majchrzak@intel.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] seq_file: fix incomplete reset on read from zero offset
Message-ID: <20180206102727.GB19579@veci.piliscsaba.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When resetting iterator on a zero offset we need to discard any data
already in the buffer (count), and private state of the iterator (version).

For example this bug results in first line being repeated in /proc/mounts
if doing a zero size read before a non-zero size read.

Reported-by: Rich Felker <dalias@libc.org> 
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Fixes: e522751d605d ("seq_file: reset iterator to first record for zero offset")
Cc: <stable@vger.kernel.org> # v4.10
---
 fs/seq_file.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/fs/seq_file.c
+++ b/fs/seq_file.c
@@ -181,8 +181,11 @@ ssize_t seq_read(struct file *file, char
 	 * if request is to read from zero offset, reset iterator to first
 	 * record as it might have been already advanced by previous requests
 	 */
-	if (*ppos == 0)
+	if (*ppos == 0) {
 		m->index = 0;
+		m->version = 0;
+		m->count = 0;
+	}
 
 	/* Don't assume *ppos is where we left it */
 	if (unlikely(*ppos != m->read_pos)) {
