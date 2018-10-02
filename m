Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B17CFC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:29:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7867A206B2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:29:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7867A206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729969AbeJBUMx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:12:53 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33134 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729951AbeJBUMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:12:52 -0400
Received: from localhost (24-104-73-23-ip-static.hfc.comcastbusiness.net [24.104.73.23])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 8FD2C266;
        Tue,  2 Oct 2018 13:29:29 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Konstantin Khorenko <khorenko@virtuozzo.com>,
        Andrey Vagin <avagin@openvz.org>,
        Benjamin Coddington <bcodding@redhat.com>,
        Jeff Layton <jlayton@redhat.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 123/228] fs/lock: skip lock owner pid translation in case we are in init_pid_ns
Date:   Tue,  2 Oct 2018 06:23:40 -0700
Message-Id: <20181002132507.756699892@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181002132459.032960735@linuxfoundation.org>
References: <20181002132459.032960735@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Konstantin Khorenko <khorenko@virtuozzo.com>

[ Upstream commit 826d7bc9f013d01e92997883d2fd0c25f4af1f1c ]

If the flock owner process is dead and its pid has been already freed,
pid translation won't work, but we still want to show flock owner pid
number when expecting /proc/$PID/fdinfo/$FD in init pidns.

Reproducer:
process A	process A1	process A2
fork()--------->
exit()		open()
		flock()
		fork()--------->
		exit()		sleep()

Before the patch:
================
(root@vz7)/: cat /proc/${PID_A2}/fdinfo/3
pos:    4
flags:  02100002
mnt_id: 257
lock:   (root@vz7)/:

After the patch:
===============
(root@vz7)/:cat /proc/${PID_A2}/fdinfo/3
pos:    4
flags:  02100002
mnt_id: 295
lock:   1: FLOCK  ADVISORY  WRITE ${PID_A1} b6:f8a61:529946 0 EOF

Fixes: 9d5b86ac13c5 ("fs/locks: Remove fl_nspid and use fs-specific l_pid for remote locks")
Signed-off-by: Konstantin Khorenko <khorenko@virtuozzo.com>
Acked-by: Andrey Vagin <avagin@openvz.org>
Reviewed-by: Benjamin Coddington <bcodding@redhat.com>
Signed-off-by: Jeff Layton <jlayton@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/locks.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/fs/locks.c
+++ b/fs/locks.c
@@ -2072,6 +2072,13 @@ static pid_t locks_translate_pid(struct
 		return -1;
 	if (IS_REMOTELCK(fl))
 		return fl->fl_pid;
+	/*
+	 * If the flock owner process is dead and its pid has been already
+	 * freed, the translation below won't work, but we still want to show
+	 * flock owner pid number in init pidns.
+	 */
+	if (ns == &init_pid_ns)
+		return (pid_t)fl->fl_pid;
 
 	rcu_read_lock();
 	pid = find_pid_ns(fl->fl_pid, &init_pid_ns);


