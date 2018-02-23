Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227e7Gj/g6jhVWrSMC9km2u8WVWjyurfK7dEw7vHPYFkLQD/1C4f4X0E0+44cNc/oKDmo3Zq
ARC-Seal: i=1; a=rsa-sha256; t=1519412261; cv=none;
        d=google.com; s=arc-20160816;
        b=OYMdIfMWHmJS9G30le8AHcY/PnlgPjX7UPESyaOZdpEcdz7KD/kfAhQko1WCzE/yYo
         w+PNONcR5P8MYliS32H/klVcBA2pl36EdMx0DXTFHW0WJ+KXK5HZiwoHwDyVlp79Jocu
         y/XMkzyDWBmh7C0/W8E5zmHWaQcbjkPAXK567E816yjTGzJupcLvNkqFHqwaiNJ+TSk9
         QDdzTTZhxkjNgHFK5/zo90itLQDL3K4gx9qSdCofiVXy3mMLE8cVXHXyBrDhZvJLEZSu
         in7HS493kYI9Q3qsFIyKt6ZyNxn2p9qYURWI8jewWg8safAYnLVnBS7yCxL6TQVvMFO2
         PeLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=gNZx/VKeFMRlLrkxd6ROYuPtdRCqPk27ogQY3hxq8d8=;
        b=iWyep3K/5uS6KV2UffzW0g9Q7UoFn3PYldzBdKf03g41iIPLUWJjX9MT9hE/ZotshS
         Z4JASDTzJnhLlM69i69QEGSJPNZZYu0AiGD6lfMPay2XyTy5D88Fb8vsLnTR/cLwxXGM
         Y+lDEKvNMtqm56wY8bUCz5YOsknTFdCuWkEcnStp22afDo/RgMHelNY+FtPvX9YUfbM2
         CtjisdbWqX8jxZovu8KT1BZGjhQ/QwsfbOyOHK0MHvMBcfDVEqeXetvPXlcjsdptPi3c
         32egHI5b8Tyb6tbD2K3HTOdMQc+nmtMjAPqATAQZdnqeQNj5DErBZCpv7oGWNh9aoBeB
         O9ew==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	syzbot <syzkaller@googlegroups.com>,
	Sowmini Varadhan <sowmini.varadhan@oracle.com>,
	Santosh Shilimkar <santosh.shilimkar@oracle.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.15 20/45] rds: tcp: atomically purge entries from rds_tcp_conn_list during netns delete
Date: Fri, 23 Feb 2018 19:28:59 +0100
Message-Id: <20180223170718.465791414@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170715.197760019@linuxfoundation.org>
References: <20180223170715.197760019@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593218326118294645?=
X-GMAIL-MSGID: =?utf-8?q?1593219231490963117?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sowmini Varadhan <sowmini.varadhan@oracle.com>

commit f10b4cff98c6977668434fbf5dd58695eeca2897 upstream.

The rds_tcp_kill_sock() function parses the rds_tcp_conn_list
to find the rds_connection entries marked for deletion as part
of the netns deletion under the protection of the rds_tcp_conn_lock.
Since the rds_tcp_conn_list tracks rds_tcp_connections (which
have a 1:1 mapping with rds_conn_path), multiple tc entries in
the rds_tcp_conn_list will map to a single rds_connection, and will
be deleted as part of the rds_conn_destroy() operation that is
done outside the rds_tcp_conn_lock.

The rds_tcp_conn_list traversal done under the protection of
rds_tcp_conn_lock should not leave any doomed tc entries in
the list after the rds_tcp_conn_lock is released, else another
concurrently executiong netns delete (for a differnt netns) thread
may trip on these entries.

Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Acked-by: Santosh Shilimkar <santosh.shilimkar@oracle.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/rds/tcp.c |    9 +++++++--
 net/rds/tcp.h |    1 +
 2 files changed, 8 insertions(+), 2 deletions(-)

--- a/net/rds/tcp.c
+++ b/net/rds/tcp.c
@@ -307,7 +307,8 @@ static void rds_tcp_conn_free(void *arg)
 	rdsdebug("freeing tc %p\n", tc);
 
 	spin_lock_irqsave(&rds_tcp_conn_lock, flags);
-	list_del(&tc->t_tcp_node);
+	if (!tc->t_tcp_node_detached)
+		list_del(&tc->t_tcp_node);
 	spin_unlock_irqrestore(&rds_tcp_conn_lock, flags);
 
 	kmem_cache_free(rds_tcp_conn_slab, tc);
@@ -532,8 +533,12 @@ static void rds_tcp_kill_sock(struct net
 
 		if (net != c_net || !tc->t_sock)
 			continue;
-		if (!list_has_conn(&tmp_list, tc->t_cpath->cp_conn))
+		if (!list_has_conn(&tmp_list, tc->t_cpath->cp_conn)) {
 			list_move_tail(&tc->t_tcp_node, &tmp_list);
+		} else {
+			list_del(&tc->t_tcp_node);
+			tc->t_tcp_node_detached = true;
+		}
 	}
 	spin_unlock_irq(&rds_tcp_conn_lock);
 	list_for_each_entry_safe(tc, _tc, &tmp_list, t_tcp_node) {
--- a/net/rds/tcp.h
+++ b/net/rds/tcp.h
@@ -12,6 +12,7 @@ struct rds_tcp_incoming {
 struct rds_tcp_connection {
 
 	struct list_head	t_tcp_node;
+	bool			t_tcp_node_detached;
 	struct rds_conn_path	*t_cpath;
 	/* t_conn_path_lock synchronizes the connection establishment between
 	 * rds_tcp_accept_one and rds_tcp_conn_path_connect
