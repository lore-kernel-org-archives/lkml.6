Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 922F6C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:45:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E6DA20847
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:45:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="y4/LvtNg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E6DA20847
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730185AbeKCDxa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 23:53:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:49138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729726AbeKCDx3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 23:53:29 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A93472084A;
        Fri,  2 Nov 2018 18:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541184316;
        bh=ykjjhBma7OItygPziPJYhStkgF4tvg7aDg406vvXyUE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=y4/LvtNgYVbLdiunw/Eeib4V/QOKvIxg3x6VydQWX8s26yaa1f6xyeli6Kzq8Xeg/
         J704s+oppkBLk9wwuK6bFcRpGNXA2H1g0r5zJe/OCTS+1ypSbZ6rq6jD7AK7mJMahd
         3vZKDEMACqkHwXW9qCcNqfDZ4uBAgeybk1BRv5/c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xin Long <lucien.xin@gmail.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.18 133/150] sctp: not free the new asoc when sctp_wait_for_connect returns err
Date:   Fri,  2 Nov 2018 19:34:55 +0100
Message-Id: <20181102182911.962521064@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181102182902.250560510@linuxfoundation.org>
References: <20181102182902.250560510@linuxfoundation.org>
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

From: Xin Long <lucien.xin@gmail.com>

[ Upstream commit c863850ce22e1b0bb365d49cadf51f4765153ae4 ]

When sctp_wait_for_connect is called to wait for connect ready
for sp->strm_interleave in sctp_sendmsg_to_asoc, a panic could
be triggered if cpu is scheduled out and the new asoc is freed
elsewhere, as it will return err and later the asoc gets freed
again in sctp_sendmsg.

[  285.840764] list_del corruption, ffff9f0f7b284078->next is LIST_POISON1 (dead000000000100)
[  285.843590] WARNING: CPU: 1 PID: 8861 at lib/list_debug.c:47 __list_del_entry_valid+0x50/0xa0
[  285.846193] Kernel panic - not syncing: panic_on_warn set ...
[  285.846193]
[  285.848206] CPU: 1 PID: 8861 Comm: sctp_ndata Kdump: loaded Not tainted 4.19.0-rc7.label #584
[  285.850559] Hardware name: Red Hat KVM, BIOS 0.5.1 01/01/2011
[  285.852164] Call Trace:
...
[  285.872210]  ? __list_del_entry_valid+0x50/0xa0
[  285.872894]  sctp_association_free+0x42/0x2d0 [sctp]
[  285.873612]  sctp_sendmsg+0x5a4/0x6b0 [sctp]
[  285.874236]  sock_sendmsg+0x30/0x40
[  285.874741]  ___sys_sendmsg+0x27a/0x290
[  285.875304]  ? __switch_to_asm+0x34/0x70
[  285.875872]  ? __switch_to_asm+0x40/0x70
[  285.876438]  ? ptep_set_access_flags+0x2a/0x30
[  285.877083]  ? do_wp_page+0x151/0x540
[  285.877614]  __sys_sendmsg+0x58/0xa0
[  285.878138]  do_syscall_64+0x55/0x180
[  285.878669]  entry_SYSCALL_64_after_hwframe+0x44/0xa9

This is a similar issue with the one fixed in Commit ca3af4dd28cf
("sctp: do not free asoc when it is already dead in sctp_sendmsg").
But this one can't be fixed by returning -ESRCH for the dead asoc
in sctp_wait_for_connect, as it will break sctp_connect's return
value to users.

This patch is to simply set err to -ESRCH before it returns to
sctp_sendmsg when any err is returned by sctp_wait_for_connect
for sp->strm_interleave, so that no asoc would be freed due to
this.

When users see this error, they will know the packet hasn't been
sent. And it also makes sense to not free asoc because waiting
connect fails, like the second call for sctp_wait_for_connect in
sctp_sendmsg_to_asoc.

Fixes: 668c9beb9020 ("sctp: implement assign_number for sctp_stream_interleave")
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Acked-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sctp/socket.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -1939,8 +1939,10 @@ static int sctp_sendmsg_to_asoc(struct s
 		if (sp->strm_interleave) {
 			timeo = sock_sndtimeo(sk, 0);
 			err = sctp_wait_for_connect(asoc, &timeo);
-			if (err)
+			if (err) {
+				err = -ESRCH;
 				goto err;
+			}
 		} else {
 			wait_connect = true;
 		}


