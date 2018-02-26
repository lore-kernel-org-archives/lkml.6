Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224kIvwUIjOGYWtFHSZ1ZfePstbTrjdch9vUMFDgi+jUG+RK3T1FMhW1k82sozqKa6sxQIPU
ARC-Seal: i=1; a=rsa-sha256; t=1519676949; cv=none;
        d=google.com; s=arc-20160816;
        b=ZUfz5uryUONwRIZoLTeByVzcFlTxCM8+Pg2UOLzfX76PonCWzfDkQckKALBqlZN+NF
         Q0bcEhU1l3zmKGy5eX1VcD9mtGa4dx6WdvA1LyHamTM5UldZIYemOe1wLM5ThdQaTkQD
         tE9TZV+lGu1PwwpylNLWfJBnZaJ8rjQ1Ye8P99vYcBFdXaHytERmOcUHAfqvTCcbuwX/
         GB2hxdhK3zPm93duUrtyi1RXc/U4nyZDS8ap7LA4ICJigc7d5EsuhzFSZm8OvTZkJgyq
         A7dvbr5l3mqUNb6fflBZ4fW69FbvR+SYE8WDEMOW7wqntVtFDwYoXj+Hwwx9tLqNnpuH
         1QeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Wyxy9fNfrL/vlJvrsy4DsqqTgSxKBm/tS86/sZxcm60=;
        b=Bq27tpEm4GcVBBrtSZSzrNtHjerlL26xbj0iwWMv4VEE+zCzn9+dlBB8Q9aAnnb9Eu
         53uuNPHbRRixaW9ycE0I1UgdpUkIBCm6MzKjVJjjVt804/VV1fXkerbqhxCqCwesHygf
         aEyFcDe+p/645v0wqjJGaS/vJFZkO3IfqxaeufxeiSKpDm7HF99hVeWfxyf6Vb+VWTGv
         ndjIKnfg32FxIOYJfddUNmQiTnrgnB4BZZsI06SfjsNsoSAfpdEiElnCXK3Jzm/hBcnX
         PclEBLj1weKUCI/BVuit4DmH/uK8awsYRMx/b3HF3hiGWjC9ZWxy9ByJV8rXIy081/72
         7/ow==
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
Subject: [PATCH 4.15 35/64] net: thunderbolt: Tear down connection properly on suspend
Date: Mon, 26 Feb 2018 21:22:12 +0100
Message-Id: <20180226202154.959847066@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180226202153.453363333@linuxfoundation.org>
References: <20180226202153.453363333@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593496776681538793?=
X-GMAIL-MSGID: =?utf-8?q?1593496776681538793?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mika Westerberg <mika.westerberg@linux.intel.com>

commit 8e021a14d908475fea89ef85b5421865f7ad650d upstream.

When suspending to mem or disk the Thunderbolt controller typically goes
down as well tearing down the connection automatically. However, when
suspend to idle is used this does not happen so we need to make sure the
connection is properly disconnected before it can be re-established
during resume.

Fixes: e69b6c02b4c3 ("net: Add support for networking over Thunderbolt cable")
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: stable@vger.kernel.org
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/thunderbolt.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

--- a/drivers/net/thunderbolt.c
+++ b/drivers/net/thunderbolt.c
@@ -1270,10 +1270,7 @@ static int __maybe_unused tbnet_suspend(
 	stop_login(net);
 	if (netif_running(net->dev)) {
 		netif_device_detach(net->dev);
-		tb_ring_stop(net->rx_ring.ring);
-		tb_ring_stop(net->tx_ring.ring);
-		tbnet_free_buffers(&net->rx_ring);
-		tbnet_free_buffers(&net->tx_ring);
+		tbnet_tear_down(net, true);
 	}
 
 	return 0;
