Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 862AAC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 04:04:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4894120883
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 04:04:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="jlzCwbui"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729389AbfAIEEh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 23:04:37 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59851 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727828AbfAIEEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 23:04:37 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 099F65C4AA;
        Tue,  8 Jan 2019 22:55:51 -0500 (EST)
        (envelope-from nicolas.pitre@linaro.org)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=/oWaIbI7kf1YpW02K4Zc5hquC
        hM=; b=jlzCwbui5GC/9wY/IYIIaT8RSrLknPxqW424qnBcWwTdOVN1DeG/z7c+U
        c7lI6Tuoy+NeREdbbGJDG3oscKBfhK2jgN2jXXQ6dluJAOqwGjApz2dRncTrgvwv
        yFSPMGUHoAYBkm7xepAo+bSt7DpOP369dfSGxLIBcqOaVKG82Q=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 03CC85C4A9;
        Tue,  8 Jan 2019 22:55:51 -0500 (EST)
        (envelope-from nicolas.pitre@linaro.org)
Received: from yoda.home (unknown [70.82.104.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 1D93D5C4A8;
        Tue,  8 Jan 2019 22:55:48 -0500 (EST)
        (envelope-from nicolas.pitre@linaro.org)
Received: from xanadu.home (xanadu.home [192.168.2.2])
        by yoda.home (Postfix) with ESMTP id CD8FB2DA06F2;
        Tue,  8 Jan 2019 22:55:45 -0500 (EST)
From:   Nicolas Pitre <nicolas.pitre@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Dave Mielke <Dave@mielke.cc>, linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] vcs: poll(): cope with a deallocated vt
Date:   Tue,  8 Jan 2019 22:55:03 -0500
Message-Id: <20190109035504.8413-6-nicolas.pitre@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190109035504.8413-1-nicolas.pitre@linaro.org>
References: <20190109035504.8413-1-nicolas.pitre@linaro.org>
MIME-Version: 1.0
X-Pobox-Relay-ID: 72C0E60C-13C2-11E9-9222-D889C09F693B-78420484!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When VT_DISALLOCATE is used on a vt, user space waiting with poll() on
the corresponding /dev/vcs device is not awakened. This is now fixed by
returning POLLHUP|POLLERR to user space.

Also, in the normal screen update case, we don't set POLLERR anymore as
POLLPRI alone is a much more logical response in a non-error situation,
saving some confusion on the user space side. The only known user app
making use of poll() on /dev/vcs* is BRLTTY which is known to cope with
that change already, so the risk of breakage is pretty much nonexistent.

Signed-off-by: Nicolas Pitre <nico@linaro.org>
---
 drivers/tty/vt/vc_screen.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/vt/vc_screen.c b/drivers/tty/vt/vc_screen.c
index 3dba60825c..1bbe2a30cd 100644
--- a/drivers/tty/vt/vc_screen.c
+++ b/drivers/tty/vt/vc_screen.c
@@ -80,7 +80,7 @@
 struct vcs_poll_data {
 	struct notifier_block notifier;
 	unsigned int cons_num;
-	bool seen_last_update;
+	int event;
 	wait_queue_head_t waitq;
 	struct fasync_struct *fasync;
 };
@@ -94,7 +94,7 @@ vcs_notifier(struct notifier_block *nb, unsigned long c=
ode, void *_param)
 		container_of(nb, struct vcs_poll_data, notifier);
 	int currcons =3D poll->cons_num;
=20
-	if (code !=3D VT_UPDATE)
+	if (code !=3D VT_UPDATE && code !=3D VT_DEALLOCATE)
 		return NOTIFY_DONE;
=20
 	if (currcons =3D=3D 0)
@@ -104,7 +104,7 @@ vcs_notifier(struct notifier_block *nb, unsigned long=
 code, void *_param)
 	if (currcons !=3D vc->vc_num)
 		return NOTIFY_DONE;
=20
-	poll->seen_last_update =3D false;
+	poll->event =3D code;
 	wake_up_interruptible(&poll->waitq);
 	kill_fasync(&poll->fasync, SIGIO, POLL_IN);
 	return NOTIFY_OK;
@@ -261,7 +261,7 @@ vcs_read(struct file *file, char __user *buf, size_t =
count, loff_t *ppos)
=20
 	poll =3D file->private_data;
 	if (count && poll)
-		poll->seen_last_update =3D true;
+		poll->event =3D 0;
 	read =3D 0;
 	ret =3D 0;
 	while (count) {
@@ -616,12 +616,21 @@ static __poll_t
 vcs_poll(struct file *file, poll_table *wait)
 {
 	struct vcs_poll_data *poll =3D vcs_poll_data_get(file);
-	__poll_t ret =3D DEFAULT_POLLMASK|EPOLLERR|EPOLLPRI;
+	__poll_t ret =3D DEFAULT_POLLMASK|EPOLLERR;
=20
 	if (poll) {
 		poll_wait(file, &poll->waitq, wait);
-		if (poll->seen_last_update)
+		switch (poll->event) {
+		case VT_UPDATE:
+			ret =3D DEFAULT_POLLMASK|EPOLLPRI;
+			break;
+		case VT_DEALLOCATE:
+			ret =3D DEFAULT_POLLMASK|EPOLLHUP|EPOLLERR;
+			break;
+		case 0:
 			ret =3D DEFAULT_POLLMASK;
+			break;
+		}
 	}
 	return ret;
 }
--=20
2.20.1

