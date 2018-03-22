Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3449376-1521745364-2-12152818838888654215
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521745364; b=eLBfS+SQ9ncj9V1yUm5TKF3cBm9xD9kau5CARWT3KoMaez3
    NKhZpePVOfLNv0qbLj4JxnnHPnQPiMSifRAswJ44QVeOSF/R2C8dRAwBFQ8vqiKR
    o2XeGcXJSL/lYx7paB+G4Q9dHEmM/KEXzZPJmXBs7Y6zdWgqGbTxRRmNBn2OhnJZ
    G6P59efMS+e7AvNzFgovvkUdG8E1RnDs9Pf72vAZwx9v9AWVIY2hunn5d4KBfCCm
    fTMhZpNqaODJupXuifqO+AwAd0JUG0vYZRix6M+/jZRiuUc0Xa2Wz8A3lx+5wdSj
    0EBdy6DvORoq15RGjxd9Ypl/UQ8QKSIal/Rp67g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:reply-to:cc:mime-version
    :content-type:content-transfer-encoding:sender; s=arctest; t=
    1521745364; bh=vOv16ot9gFpdOo1LLQ4mvyxX7VScV0g1el5KfJU8zo4=; b=x
    ABPHrAiZ53Agjpewo7xF8QcET41etwQHMZe3Q+qGeogwlpJhNuXbJlz0Dd6jy00w
    BFFD5qItu1HaI9Uw1hblqZELIrPPqz/ELbwB6rKCPIux2X0eeFxHzcy3Ey5LkKgF
    0rz4GqGTc/rszPzqHZUhGbHq/vHZvVEbOakaASm/c36NJDp0xscY9DLFLQaEie88
    YVNkI5ANPlypPSZmk+U6F3Rj9scu8leD+Ng67RusfUGufVaRAIN6T56x2ckMBHIb
    b/XAfoCesJCb1C5R4qa7uqtKN/iNz4nnPaH8n/PNdjPRMttPmzDLb8u40SK4Zv6k
    eycWl1fD/hRgcJdWwnZwA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxonhyperv.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxonhyperv.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxonhyperv.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxonhyperv.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-Remote-Delivered-To: driverdev-devel@osuosl.org
x-originating-ip: 107.180.71.197
From: Haiyang Zhang <haiyangz@linuxonhyperv.com>
To: davem@davemloft.net,
	netdev@vger.kernel.org
Subject: [PATCH net-next,1/2] hv_netvsc: Fix the return status in RX path
Date: Thu, 22 Mar 2018 12:01:13 -0700
Message-Id: <20180322190114.25596-2-haiyangz@linuxonhyperv.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180322190114.25596-1-haiyangz@linuxonhyperv.com>
References: <20180322190114.25596-1-haiyangz@linuxonhyperv.com>
X-CMAE-Envelope: MS4wfJxrdB/sZuO5WJD5gIkqVBMrkATf51xAXKNrLFPBpjDvv3lxJrV4fJAb0A7eGbO+BGgfQNP1az1qWuG9pxE4W/0s3B1YXjwDML5hxXBUlU6ReiR7l7V/
 8mGlJqbN8XLK+pYKFxOLAM7CJpjZVxMLr5snQ6f0JKbPew6Ki139BJF+4qpnIN9Qn3Jrb7TAAOGmH3Rd12FTNHR12Y7+SvR2uqREkIr7uLEH0A5RFzZQ9UXG
 8Av5QQkJ87Rxtn+y+F60IHZR3AAynEcToxtm9VFuRL3V6XGy88xqlLSkeJFhAx38XREizWahNvIfUvzEYEx723abvxBZaRtuHi+qpZWgyQNN2RqTL3zYC523
 2r+hVG6O6bnpz+xszdxlXUJMfUxsh1kxrvfAG5OpWNaKNdQNPQSxSjZDc6TqPy7t9chZ/Vxvo/d1tYWUXOt4lQrWII5wwQlOQlBmh9LbefwR1d8QJYbq5ALi
 Q9MkwBuu1ymNrcayKMJYSrCYnOipkA8d+0yLzg==
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Reply-To: haiyangz@microsoft.com
Cc: olaf@aepfle.de, sthemmin@microsoft.com, haiyangz@microsoft.com,
 linux-kernel@vger.kernel.org, devel@linuxdriverproject.org,
 vkuznets@redhat.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Haiyang Zhang <haiyangz@microsoft.com>

As defined in hyperv_net.h, the NVSP_STAT_SUCCESS is one not zero.
Some functions returns 0 when it actually means NVSP_STAT_SUCCESS.
This patch fixes them.

In netvsc_receive(), it puts the last RNDIS packet's receive status
for all packets in a vmxferpage which may contain multiple RNDIS
packets.
This patch puts NVSP_STAT_FAIL in the receive completion if one of
the packets in a vmxferpage fails.

Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/net/hyperv/netvsc.c       | 8 ++++++--
 drivers/net/hyperv/netvsc_drv.c   | 2 +-
 drivers/net/hyperv/rndis_filter.c | 4 ++--
 3 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/net/hyperv/netvsc.c b/drivers/net/hyperv/netvsc.c
index aa95e81af6e5..1ddb2c39b6e4 100644
--- a/drivers/net/hyperv/netvsc.c
+++ b/drivers/net/hyperv/netvsc.c
@@ -1098,12 +1098,16 @@ static int netvsc_receive(struct net_device *ndev,
 		void *data = recv_buf
 			+ vmxferpage_packet->ranges[i].byte_offset;
 		u32 buflen = vmxferpage_packet->ranges[i].byte_count;
+		int ret;
 
 		trace_rndis_recv(ndev, q_idx, data);
 
 		/* Pass it to the upper layer */
-		status = rndis_filter_receive(ndev, net_device,
-					      channel, data, buflen);
+		ret = rndis_filter_receive(ndev, net_device,
+					   channel, data, buflen);
+
+		if (unlikely(ret != NVSP_STAT_SUCCESS))
+			status = NVSP_STAT_FAIL;
 	}
 
 	enq_receive_complete(ndev, net_device, q_idx,
diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
index cdb78eefab67..33607995be62 100644
--- a/drivers/net/hyperv/netvsc_drv.c
+++ b/drivers/net/hyperv/netvsc_drv.c
@@ -818,7 +818,7 @@ int netvsc_recv_callback(struct net_device *net,
 	u64_stats_update_end(&rx_stats->syncp);
 
 	napi_gro_receive(&nvchan->napi, skb);
-	return 0;
+	return NVSP_STAT_SUCCESS;
 }
 
 static void netvsc_get_drvinfo(struct net_device *net,
diff --git a/drivers/net/hyperv/rndis_filter.c b/drivers/net/hyperv/rndis_filter.c
index 2dc00f714482..591fb8080f11 100644
--- a/drivers/net/hyperv/rndis_filter.c
+++ b/drivers/net/hyperv/rndis_filter.c
@@ -443,10 +443,10 @@ int rndis_filter_receive(struct net_device *ndev,
 			"unhandled rndis message (type %u len %u)\n",
 			   rndis_msg->ndis_msg_type,
 			   rndis_msg->msg_len);
-		break;
+		return NVSP_STAT_FAIL;
 	}
 
-	return 0;
+	return NVSP_STAT_SUCCESS;
 }
 
 static int rndis_filter_query_device(struct rndis_device *dev,
-- 
2.15.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
