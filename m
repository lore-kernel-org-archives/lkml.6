Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227AlfsDqhgTwHeV10yOMfp1ask/I34FDdCqPt3PPpypavFcqvxEYDRZCSGG1NVEUeVnLSPP
ARC-Seal: i=1; a=rsa-sha256; t=1519676952; cv=none;
        d=google.com; s=arc-20160816;
        b=cYrEKk4ME44d/g5m5z/pUeGV1Z5WkgWe86S97mQGwQllD/5YLse6U56DsOoI7PlDvF
         A0ktbbwHkTd+iVNSg6mjpIKfc+HjzRksAaXh1C+SBCYub+ma+7ANvrmX9mLAKfSGIaOw
         cys1Nf8wpDcou6YrqadJX1KHqqMN5yjqMc+3XdWRenOt/UzM9lyjOeP9Uq09dazX69u/
         7oq5lBUHcGiLAIuHXgKw2geZAhShVhfbwCndBQLwWgvltVmU2i/O6E3szl5iK58bAAg/
         T7chYyFJD7ZdUoOWzUc6XALOYmS0elkaumL4XSnkrImE5/6mXGMgSo2mycpvTaEtlR4M
         HnKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=baOIid8oY2g8bNzNp7h3XsAXuw3KbA20liZJjFS00HA=;
        b=K25MWJc639Dpo8zLW+w9XLYVbVh4o9UT7t15NGZvnxELpLNej3c0o/POrhu8/e3yUR
         laA8ILpx1aubsA9j0YyGdjfX17FMsoWUaXXxvJM+4po0iBaw11adipULfmc2Sz/lo8WT
         T1wKMeMkWObjO8xpcfTJT57LIlR4Xn7oKKsrwht/xkJQIugKKQHMYwDV5JRgMwd6cqEg
         PbSqNgrWELvJQJoc0KxsyIErBPaMvYkFjJ6GgEc+3eCWAEnxezxH2eRXUuKfPDGYsH2J
         CiPB67OdJlKi5cvOV6CA0FtsGodjFUMLI4ljVj2Kl8s16Ox9/4McSqoa4w04QxYnJBiD
         FoGw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.15 36/64] net: thunderbolt: Run disconnect flow asynchronously when logout is received
Date: Mon, 26 Feb 2018 21:22:13 +0100
Message-Id: <20180226202155.000369917@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180226202153.453363333@linuxfoundation.org>
References: <20180226202153.453363333@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593496780746856879?=
X-GMAIL-MSGID: =?utf-8?q?1593496780746856879?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mika Westerberg <mika.westerberg@linux.intel.com>

commit 027d351c541744c0c780dd5801c63e4b90750b90 upstream.

The control channel calls registered callbacks when control messages
such as XDomain protocol messages are received. The control channel
handling is done in a worker running on system workqueue which means the
networking driver can't run tear down flow which includes sending
disconnect request and waiting for a reply in the same worker. Otherwise
reply is never received (as the work is already running) and the
operation times out.

To fix this run disconnect ThunderboltIP flow asynchronously once
ThunderboltIP logout message is received.

Fixes: e69b6c02b4c3 ("net: Add support for networking over Thunderbolt cable")
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: stable@vger.kernel.org
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/thunderbolt.c |   14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

--- a/drivers/net/thunderbolt.c
+++ b/drivers/net/thunderbolt.c
@@ -166,6 +166,8 @@ struct tbnet_ring {
  * @connected_work: Worker that finalizes the ThunderboltIP connection
  *		    setup and enables DMA paths for high speed data
  *		    transfers
+ * @disconnect_work: Worker that handles tearing down the ThunderboltIP
+ *		     connection
  * @rx_hdr: Copy of the currently processed Rx frame. Used when a
  *	    network packet consists of multiple Thunderbolt frames.
  *	    In host byte order.
@@ -190,6 +192,7 @@ struct tbnet {
 	int login_retries;
 	struct delayed_work login_work;
 	struct work_struct connected_work;
+	struct work_struct disconnect_work;
 	struct thunderbolt_ip_frame_header rx_hdr;
 	struct tbnet_ring rx_ring;
 	atomic_t frame_id;
@@ -445,7 +448,7 @@ static int tbnet_handle_packet(const voi
 	case TBIP_LOGOUT:
 		ret = tbnet_logout_response(net, route, sequence, command_id);
 		if (!ret)
-			tbnet_tear_down(net, false);
+			queue_work(system_long_wq, &net->disconnect_work);
 		break;
 
 	default:
@@ -659,6 +662,13 @@ static void tbnet_login_work(struct work
 	}
 }
 
+static void tbnet_disconnect_work(struct work_struct *work)
+{
+	struct tbnet *net = container_of(work, typeof(*net), disconnect_work);
+
+	tbnet_tear_down(net, false);
+}
+
 static bool tbnet_check_frame(struct tbnet *net, const struct tbnet_frame *tf,
 			      const struct thunderbolt_ip_frame_header *hdr)
 {
@@ -881,6 +891,7 @@ static int tbnet_stop(struct net_device
 
 	napi_disable(&net->napi);
 
+	cancel_work_sync(&net->disconnect_work);
 	tbnet_tear_down(net, true);
 
 	tb_ring_free(net->rx_ring.ring);
@@ -1195,6 +1206,7 @@ static int tbnet_probe(struct tb_service
 	net = netdev_priv(dev);
 	INIT_DELAYED_WORK(&net->login_work, tbnet_login_work);
 	INIT_WORK(&net->connected_work, tbnet_connected_work);
+	INIT_WORK(&net->disconnect_work, tbnet_disconnect_work);
 	mutex_init(&net->connection_lock);
 	atomic_set(&net->command_id, 0);
 	atomic_set(&net->frame_id, 0);
