Return-Path: <SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqJou9ANBV0l3Zli9m+d6oNXI/4vyQIMpy7lC43V8kQX+91AkEAvRwTqscwAp/kQj+LhkZi
ARC-Seal: i=1; a=rsa-sha256; t=1524837910; cv=none;
        d=google.com; s=arc-20160816;
        b=jVLEEqe+rBhZ4TDwv9+EjdwvtwcE9Wh7gGlNI1+kzvP4FjK0kOAAx/k92Uy81jdmk8
         36FvLWHJQAb5kHHYGNiYwvml1XM51X1HsvlUBV0AaRjwPQ8EfEg8Vgd3xQ3ezlf2X+GS
         J9n2/r0ACxU1HcXAW+2lYhIvuT82iNXL6NbZ4WsTeG0ya0DZdJ3W2NASqbmPUEpScKYv
         vpf25BoSOKtPYw75yJLeYKfeQYZl+p9la0dP8FDHjhU5RehGS8ujnVvx11alNBL5iMyT
         vCBAF+GexOHKf2pwHVGtyREa/7IacZs7jceuhwm/frecczXVpk1vQ78ZQFVppnCFBWyA
         48Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=HM0mrEf/dUkHdZeKm2AGCPN2gtGk+drgDON01rSLcuQ=;
        b=HP8I2TBYwp5KTRWSsoI+isshymtxWlDXIZg9v1/He5J6WvllnsQ/3vqPqWeGb4uKBz
         IbBjUU0YT45wCBnMO8cg128M2BU/Fx5eHURCHjMNNmEvX5y3cqzMTWjuEh0hqWFuVmfi
         U9YGmJgn4tW5/hk21b1roNCPouoKhn9nt37zQgoeFVQ/lyuyh1tNg0TXyazVqjQnx3Xz
         FoGSj1nG53lzxF30d1EM6fuCSjG99pTHojpVEXEdhGPWcwXboVstcRHC7jBuZh1RsvGv
         JscjYzgqEGZ5FIS5EwZF5497/Ui+/3GyFHLGpujPt3slK9pfcI2zzogYpsdm9SdPu4c3
         FNIw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56EA521890
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Wolfgang Bumiller <w.bumiller@proxmox.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 64/74] net: fix deadlock while clearing neighbor proxy table
Date: Fri, 27 Apr 2018 15:58:54 +0200
Message-Id: <20180427135712.601244945@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135709.899303463@linuxfoundation.org>
References: <20180427135709.899303463@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598908284337908803?=
X-GMAIL-MSGID: =?utf-8?q?1598908436991664992?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wolfgang Bumiller <w.bumiller@proxmox.com>


[ Upstream commit 53b76cdf7e8fecec1d09e38aad2f8579882591a8 ]

When coming from ndisc_netdev_event() in net/ipv6/ndisc.c,
neigh_ifdown() is called with &nd_tbl, locking this while
clearing the proxy neighbor entries when eg. deleting an
interface. Calling the table's pndisc_destructor() with the
lock still held, however, can cause a deadlock: When a
multicast listener is available an IGMP packet of type
ICMPV6_MGM_REDUCTION may be sent out. When reaching
ip6_finish_output2(), if no neighbor entry for the target
address is found, __neigh_create() is called with &nd_tbl,
which it'll want to lock.

Move the elements into their own list, then unlock the table
and perform the destruction.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=199289
Fixes: 6fd6ce2056de ("ipv6: Do not depend on rt->n in ip6_finish_output2().")
Signed-off-by: Wolfgang Bumiller <w.bumiller@proxmox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/core/neighbour.c |   28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -54,7 +54,8 @@ do {						\
 static void neigh_timer_handler(unsigned long arg);
 static void __neigh_notify(struct neighbour *n, int type, int flags);
 static void neigh_update_notify(struct neighbour *neigh);
-static int pneigh_ifdown(struct neigh_table *tbl, struct net_device *dev);
+static int pneigh_ifdown_and_unlock(struct neigh_table *tbl,
+				    struct net_device *dev);
 
 #ifdef CONFIG_PROC_FS
 static const struct file_operations neigh_stat_seq_fops;
@@ -254,8 +255,7 @@ int neigh_ifdown(struct neigh_table *tbl
 {
 	write_lock_bh(&tbl->lock);
 	neigh_flush_dev(tbl, dev);
-	pneigh_ifdown(tbl, dev);
-	write_unlock_bh(&tbl->lock);
+	pneigh_ifdown_and_unlock(tbl, dev);
 
 	del_timer_sync(&tbl->proxy_timer);
 	pneigh_queue_purge(&tbl->proxy_queue);
@@ -645,9 +645,10 @@ int pneigh_delete(struct neigh_table *tb
 	return -ENOENT;
 }
 
-static int pneigh_ifdown(struct neigh_table *tbl, struct net_device *dev)
+static int pneigh_ifdown_and_unlock(struct neigh_table *tbl,
+				    struct net_device *dev)
 {
-	struct pneigh_entry *n, **np;
+	struct pneigh_entry *n, **np, *freelist = NULL;
 	u32 h;
 
 	for (h = 0; h <= PNEIGH_HASHMASK; h++) {
@@ -655,16 +656,23 @@ static int pneigh_ifdown(struct neigh_ta
 		while ((n = *np) != NULL) {
 			if (!dev || n->dev == dev) {
 				*np = n->next;
-				if (tbl->pdestructor)
-					tbl->pdestructor(n);
-				if (n->dev)
-					dev_put(n->dev);
-				kfree(n);
+				n->next = freelist;
+				freelist = n;
 				continue;
 			}
 			np = &n->next;
 		}
 	}
+	write_unlock_bh(&tbl->lock);
+	while ((n = freelist)) {
+		freelist = n->next;
+		n->next = NULL;
+		if (tbl->pdestructor)
+			tbl->pdestructor(n);
+		if (n->dev)
+			dev_put(n->dev);
+		kfree(n);
+	}
 	return -ENOENT;
 }
 
