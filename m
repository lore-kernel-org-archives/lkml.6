Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0163C2F3A0
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:51:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D44B21019
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548078697;
	bh=YuGOCtoCW/X5aUbEsxOeTDmZ/VEvgxrj1W5GFIo0xW4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NGbK2qORaf3k2vyuf4qFFSE02kjZLGxmpAPovVvDPHmV3fxAZuDlWgPgg4fyMGXwq
	 Fv1cytQ2UEE9LYnEV505bFSPyN5yJY4NdI43lf2CYx5rOu0Psyttqk17ZZTT/hrfa/
	 +8F+rSSyScvPjDUmbIklcLGUF3o0xGHvOiL2rRpc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730318AbfAUNvf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 08:51:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:34488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729394AbfAUNvd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 08:51:33 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 59C902087F;
        Mon, 21 Jan 2019 13:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548078692;
        bh=YuGOCtoCW/X5aUbEsxOeTDmZ/VEvgxrj1W5GFIo0xW4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d5+4oLJTV50OE7Cm/fE3d3IG84+pgJV82p3GiP/uiOn5oWTRXYE2W3yWFqIiA+5r7
         tFSR39FCqJMZqL1pLMdBt1DelfR+MTg3PaoOGoo2wKblOz/ApXISAIBtPL9ni1ibCn
         SC8pkQ/UlNWLGfBAK3eE5MDV+7jCpbGYNXJsO2kI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jiri Slaby <jslaby@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        kernel test robot <rong.a.chen@intel.com>,
        Dmitry Safonov <dima@arista.com>
Subject: [PATCH 4.14 01/59] tty/ldsem: Wake up readers after timed out down_write()
Date:   Mon, 21 Jan 2019 14:43:26 +0100
Message-Id: <20190121122456.659715887@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190121122456.529172919@linuxfoundation.org>
References: <20190121122456.529172919@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dmitry Safonov <dima@arista.com>

commit 231f8fd0cca078bd4396dd7e380db813ac5736e2 upstream.

ldsem_down_read() will sleep if there is pending writer in the queue.
If the writer times out, readers in the queue should be woken up,
otherwise they may miss a chance to acquire the semaphore until the last
active reader will do ldsem_up_read().

There was a couple of reports where there was one active reader and
other readers soft locked up:
  Showing all locks held in the system:
  2 locks held by khungtaskd/17:
   #0:  (rcu_read_lock){......}, at: watchdog+0x124/0x6d1
   #1:  (tasklist_lock){.+.+..}, at: debug_show_all_locks+0x72/0x2d3
  2 locks held by askfirst/123:
   #0:  (&tty->ldisc_sem){.+.+.+}, at: ldsem_down_read+0x46/0x58
   #1:  (&ldata->atomic_read_lock){+.+...}, at: n_tty_read+0x115/0xbe4

Prevent readers wait for active readers to release ldisc semaphore.

Link: lkml.kernel.org/r/20171121132855.ajdv4k6swzhvktl6@wfg-t540p.sh.intel.com
Link: lkml.kernel.org/r/20180907045041.GF1110@shao2-debian
Cc: Jiri Slaby <jslaby@suse.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: stable@vger.kernel.org
Reported-by: kernel test robot <rong.a.chen@intel.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/tty/tty_ldsem.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

--- a/drivers/tty/tty_ldsem.c
+++ b/drivers/tty/tty_ldsem.c
@@ -307,6 +307,16 @@ down_write_failed(struct ld_semaphore *s
 	if (!locked)
 		ldsem_atomic_update(-LDSEM_WAIT_BIAS, sem);
 	list_del(&waiter.list);
+
+	/*
+	 * In case of timeout, wake up every reader who gave the right of way
+	 * to writer. Prevent separation readers into two groups:
+	 * one that helds semaphore and another that sleeps.
+	 * (in case of no contention with a writer)
+	 */
+	if (!locked && list_empty(&sem->write_wait))
+		__ldsem_wake_readers(sem);
+
 	raw_spin_unlock_irq(&sem->wait_lock);
 
 	__set_current_state(TASK_RUNNING);


