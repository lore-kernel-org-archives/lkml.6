Return-Path: <SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZr+lytr41Q6yLu59/Z226qZE8VcJfvsHHCbNGsBrCGYdKz2aAI14q79zqF582/nyvjNhV79
ARC-Seal: i=1; a=rsa-sha256; t=1526631659; cv=none;
        d=google.com; s=arc-20160816;
        b=UBfJUYOxAlWyluSAeKiNUCtk2PuS4/7NLEwwnPPW0a5UKg6hYBRJ1QAM45W/hyJgGy
         IiQUBe8IkV/ncpLbYflj2P5ym8RDP4Pvyzj9gemkUvk/LJfeK577E/l6vBW+U82osw+d
         M9YMPlg6sga8b2ZCaHo19SLV2cHU52URTJBw0EO0WIKnw4fys7auTmObSm5CQJ0qRmOL
         NQUIzxI6sfahkeHHSE8UcMy7Ofbt4UBwtoUrhW3ihXQvNpMH3pPy31tNqgQFOkA2FgQf
         B3mIWtzdqQnrbq69AQsd8ofsKxUiC3mmhTE7gzT9b+XxZhmw0Bjrwm3S3kmsnES0rEEc
         dQgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=JIyg3LN0YFpjJFYZ7+HCab1yPBhVbIn2rO7l7XOF1dI=;
        b=Y7fxMkFQZZ1Klfj7esXIOn9mi33mEsMSi1TBwA9bE0S7BnMeeLlE9w5sOONIyTXiK0
         4aIoUDygJvfPTVx5DKM7fsUvULbPnbp4gUbQ1KWdfIMrcybohq3r5NjLOVPgHzpfa/ka
         1PFJiVUxmtf2eCqGe7oPuEoiaKgP4tDRkHVA2zLnrAENT6zOhSBh/9KevgUSFSLrjEn8
         LxDvQwhNyyFVG4ValFMnQ9asEcU4mnMN/YRcabYI9bJvcUzb07r20d2hKPnLKW72/bld
         jbuxPxSHapwaPDWDqXnbaD68lKZ3Xmpv1IP2lCiV9nuEQ2iod6odboBkZWzjBJnrvCBR
         KKSQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=E67gg9UM;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=E67gg9UM;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	syzbot <syzkaller@googlegroups.com>,
	Santosh Shilimkar <santosh.shilimkar@oracle.com>,
	linux-rdma <linux-rdma@vger.kernel.org>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 21/45] rds: do not leak kernel memory to user land
Date: Fri, 18 May 2018 10:15:38 +0200
Message-Id: <20180518081531.399647159@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180518081530.331586165@linuxfoundation.org>
References: <20180518081530.331586165@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600789189843210725?=
X-GMAIL-MSGID: =?utf-8?q?1600789319299571661?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit eb80ca476ec11f67a62691a93604b405ffc7d80c ]

syzbot/KMSAN reported an uninit-value in put_cmsg(), originating
from rds_cmsg_recv().

Simply clear the structure, since we have holes there, or since
rx_traces might be smaller than RDS_MSG_RX_DGRAM_TRACE_MAX.

BUG: KMSAN: uninit-value in copy_to_user include/linux/uaccess.h:184 [inline]
BUG: KMSAN: uninit-value in put_cmsg+0x600/0x870 net/core/scm.c:242
CPU: 0 PID: 4459 Comm: syz-executor582 Not tainted 4.16.0+ #87
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:17 [inline]
 dump_stack+0x185/0x1d0 lib/dump_stack.c:53
 kmsan_report+0x142/0x240 mm/kmsan/kmsan.c:1067
 kmsan_internal_check_memory+0x135/0x1e0 mm/kmsan/kmsan.c:1157
 kmsan_copy_to_user+0x69/0x160 mm/kmsan/kmsan.c:1199
 copy_to_user include/linux/uaccess.h:184 [inline]
 put_cmsg+0x600/0x870 net/core/scm.c:242
 rds_cmsg_recv net/rds/recv.c:570 [inline]
 rds_recvmsg+0x2db5/0x3170 net/rds/recv.c:657
 sock_recvmsg_nosec net/socket.c:803 [inline]
 sock_recvmsg+0x1d0/0x230 net/socket.c:810
 ___sys_recvmsg+0x3fb/0x810 net/socket.c:2205
 __sys_recvmsg net/socket.c:2250 [inline]
 SYSC_recvmsg+0x298/0x3c0 net/socket.c:2262
 SyS_recvmsg+0x54/0x80 net/socket.c:2257
 do_syscall_64+0x309/0x430 arch/x86/entry/common.c:287
 entry_SYSCALL_64_after_hwframe+0x3d/0xa2

Fixes: 3289025aedc0 ("RDS: add receive message trace used by application")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: syzbot <syzkaller@googlegroups.com>
Cc: Santosh Shilimkar <santosh.shilimkar@oracle.com>
Cc: linux-rdma <linux-rdma@vger.kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/rds/recv.c |    1 +
 1 file changed, 1 insertion(+)

--- a/net/rds/recv.c
+++ b/net/rds/recv.c
@@ -558,6 +558,7 @@ static int rds_cmsg_recv(struct rds_inco
 		struct rds_cmsg_rx_trace t;
 		int i, j;
 
+		memset(&t, 0, sizeof(t));
 		inc->i_rx_lat_trace[RDS_MSG_RX_CMSG] = local_clock();
 		t.rx_traces =  rs->rs_rx_traces;
 		for (i = 0; i < rs->rs_rx_traces; i++) {
