Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94313C282C7
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 12:08:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 689DC20882
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 12:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548763727;
	bh=iWWXhKvygdYJIatNjdMBxoPxMJzwu02f4giOkYEfpD4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qJ5UAP1g1xaRfMwU1/+yVFoiB8kS4SZcwmw4v2Gm5VBw2OmB2JjHL9YjfOhWtgGqo
	 byhDZ6gyuiJ3KNphGv/hdmoCVqXEFG26EwOS9ff5cQdDjLnbC/uCdN4QAWHia/0hZs
	 BC8322tcutVCVXAOKhJnRdsUHhYSH5r23CdFf/eE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729547AbfA2MIp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 07:08:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:55886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729385AbfA2LjN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:39:13 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2020820857;
        Tue, 29 Jan 2019 11:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548761952;
        bh=iWWXhKvygdYJIatNjdMBxoPxMJzwu02f4giOkYEfpD4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LyhvGD9AYXbakuix5ejG+i1PVhvFcV1SL6tIeXqN4R8p0UFh78Pe/fpun2YZofclN
         OsTfPZX21ZOHwetZAxOovi39Pksc6qSpl3/jP7r69pRfY+0H9QLk678zV2OcssTPgq
         nutZNdGypL0HvSzojx+IFu/yn3HW5fnMaQ0Dneww=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paul Fulghum <paulkf@microgate.com>,
        syzbot <syzbot+c244af085a0159d22879@syzkaller.appspotmail.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 4.20 057/117] tty/n_hdlc: fix __might_sleep warning
Date:   Tue, 29 Jan 2019 12:35:08 +0100
Message-Id: <20190129113210.513361385@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129113207.477505932@linuxfoundation.org>
References: <20190129113207.477505932@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paul Fulghum <paulkf@microgate.com>

commit fc01d8c61ce02c034e67378cd3e645734bc18c8c upstream.

Fix __might_sleep warning[1] in tty/n_hdlc.c read due to copy_to_user
call while current is TASK_INTERRUPTIBLE.  This is a false positive
since the code path does not depend on current state remaining
TASK_INTERRUPTIBLE.  The loop breaks out and sets TASK_RUNNING after
calling copy_to_user.

This patch supresses the warning by setting TASK_RUNNING before calling
copy_to_user.

[1] https://syzkaller.appspot.com/bug?id=17d5de7f1fcab794cb8c40032f893f52de899324

Signed-off-by: Paul Fulghum <paulkf@microgate.com>
Reported-by: syzbot <syzbot+c244af085a0159d22879@syzkaller.appspotmail.com>
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: stable <stable@vger.kernel.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/tty/n_hdlc.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/tty/n_hdlc.c
+++ b/drivers/tty/n_hdlc.c
@@ -597,6 +597,7 @@ static ssize_t n_hdlc_tty_read(struct tt
 				/* too large for caller's buffer */
 				ret = -EOVERFLOW;
 			} else {
+				__set_current_state(TASK_RUNNING);
 				if (copy_to_user(buf, rbuf->buf, rbuf->count))
 					ret = -EFAULT;
 				else


