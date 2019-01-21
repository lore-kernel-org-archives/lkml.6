Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08348C2F3A0
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:58:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE4472084C
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548079098;
	bh=P4VSzLHN2/PoZZijPe72Xz+7m82L7f49bJgALkMfZ/c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GDvEbHsF/M4aJ2broF5Pys+c3v5wczmYS7sX9Aj2HRgQDk93W4YVDpObnnlj3begK
	 u53ZqAZWe+Aj/7Xa5vELMmp92nhopBQqtPzPKLf3wSwUEZzNaclVCur+OxtUx66MXg
	 SYtRhhO4UObUTRKX/w4P0BdjHDbuAxe9i0Z6LpXo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731813AbfAUNzt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 08:55:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:40502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731750AbfAUNzn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 08:55:43 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0087320861;
        Mon, 21 Jan 2019 13:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548078942;
        bh=P4VSzLHN2/PoZZijPe72Xz+7m82L7f49bJgALkMfZ/c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Uq071nEZa8BRl4qRtofkF2AFt76gCUjW0u3hy5aqfEfg7zh9lbMI6MdPew8ddN/4X
         m5+c8TOSFZAN+y0rOsuEtQZFut9BpWpp9+buHobWSFPeqn8JLJh1t8cAD5gw/ji+FO
         UqCGhmsog/51uHPpea3+2eo7pR4s8lBm8lKskD/I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 4.9 08/51] proc: Remove empty line in /proc/self/status
Date:   Mon, 21 Jan 2019 14:44:04 +0100
Message-Id: <20190121122454.204712750@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190121122453.700446926@linuxfoundation.org>
References: <20190121122453.700446926@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Guenter Roeck <linux@roeck-us.net>

If CONFIG_SECCOMP=n, /proc/self/status includes an empty line. This causes
the iotop application to bail out with an error message.

File "/usr/local/lib64/python2.7/site-packages/iotop/data.py", line 196,
	in parse_proc_pid_status
key, value = line.split(':\t', 1)
ValueError: need more than 1 value to unpack

The problem is seen in v4.9.y but not upstream because commit af884cd4a5ae6
("proc: report no_new_privs state") has not been backported to v4.9.y.
The backport of commit fae1fa0fc6cc ("proc: Provide details on speculation
flaw mitigations") tried to address the resulting differences but was
wrong, introducing the problem.

Fixes: 51ef9af2a35b ("proc: Provide details on speculation flaw mitigations")
Cc: Kees Cook <keescook@chromium.org>
Cc: Gwendal Grignou <gwendal@chromium.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Acked-by: Kees Cook <keescook@chromium.org>
---
This patch only applies to v4.9.y. v4.4.y also needs to be fixed (see
https://www.spinics.net/lists/stable/msg279131.html), but the fix
is slightly different. v4.14.y and later are not affected.

 fs/proc/array.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/fs/proc/array.c
+++ b/fs/proc/array.c
@@ -346,8 +346,9 @@ static inline void task_seccomp(struct s
 {
 #ifdef CONFIG_SECCOMP
 	seq_put_decimal_ull(m, "Seccomp:\t", p->seccomp.mode);
+	seq_putc(m, '\n');
 #endif
-	seq_printf(m, "\nSpeculation_Store_Bypass:\t");
+	seq_printf(m, "Speculation_Store_Bypass:\t");
 	switch (arch_prctl_spec_ctrl_get(p, PR_SPEC_STORE_BYPASS)) {
 	case -EINVAL:
 		seq_printf(m, "unknown");


