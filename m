Return-Path: <SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZoZijfDl45t9zf3VhNll+o0L46f6bGGLjjxzW1tN88FEH0/S2Grc88/sbeRhPSBaHNIdhSE
ARC-Seal: i=1; a=rsa-sha256; t=1524837984; cv=none;
        d=google.com; s=arc-20160816;
        b=DiRT1LDtgX4yH+2eKA5FmzbRhQHMqYkFoIhvys+mvD+IAQPQ3gQYD/ig8bcfP/X/10
         hLwlyyTs3z3zyZh20SXBOy1EnsrnyOULzQzvDPrWmNwp4YHjoFhqgh9f1zA3hGCJh9d4
         8wlkYUX1jLbfF/sII6A5dQBURkn8Jt3JNrZ1EBOLhMB5cZ3wK4Ozv6sbJtg8GY1oW8Ih
         JOUi/P2kGzAIZXw+1Dh2OF9XwCkC1pJKcwlWfnf6jxR2z2CNknrHCEsods6QWk2AMmEB
         Ew1ewT6jNnP6IXcP6HzZIhHfs7DdZqxOq/5ZM48cPac537z/Tgc0CEyLYjW90ud3ivRM
         7wVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=flA2e6/uDDt66UYmq8oGdXiRjkTlMGbylBQiGzQnf0k=;
        b=xeadU5HlC+gQONUz2qeI0xNQTeNJAaTLd1ScyRdiNvvbdkqdVRdO/rUs5fRvPG0tH6
         L/R/rPjeAfvlsX0ITW1H5UQ74KZOCb19Bdv2X3t0bKbF5h2nGdcMrah4myLuMbYBbEwN
         giRnZ3dBxhhCnMkA4B1V8ZN2MDphP3KUt8uTG9h/TqOcVAtpZwu83x4HEGqBvd/kUz00
         N5bmGB1IjfJ14BRWknfAxEHhNlqt7gUIt2LQ6CLXFjl48rzDOnaT0DjlwBr6kedrBDDw
         9HoEcHBbtPmn2SAGg583aUfa25p5zXmrY/zIwj00RWCdMInUTSYzFi0YCOa9HrYPyM4M
         d8LA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6AF421890
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Wolfgang Bumiller <w.bumiller@proxmox.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 18/80] net: fix deadlock while clearing neighbor proxy table
Date: Fri, 27 Apr 2018 15:58:11 +0200
Message-Id: <20180427135733.827936085@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135732.928644313@linuxfoundation.org>
References: <20180427135732.928644313@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598908284337908803?=
X-GMAIL-MSGID: =?utf-8?q?1598908515191534019?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -55,7 +55,8 @@ static void neigh_timer_handler(unsigned
 static void __neigh_notify(struct neighbour *n, int type, int flags,
 			   u32 pid);
 static void neigh_update_notify(struct neighbour *neigh, u32 nlmsg_pid);
-static int pneigh_ifdown(struct neigh_table *tbl, struct net_device *dev);
+static int pneigh_ifdown_and_unlock(struct neigh_table *tbl,
+				    struct net_device *dev);
 
 #ifdef CONFIG_PROC_FS
 static const struct file_operations neigh_stat_seq_fops;
@@ -291,8 +292,7 @@ int neigh_ifdown(struct neigh_table *tbl
 {
 	write_lock_bh(&tbl->lock);
 	neigh_flush_dev(tbl, dev);
-	pneigh_ifdown(tbl, dev);
-	write_unlock_bh(&tbl->lock);
+	pneigh_ifdown_and_unlock(tbl, dev);
 
 	del_timer_sync(&tbl->proxy_timer);
 	pneigh_queue_purge(&tbl->proxy_queue);
@@ -681,9 +681,10 @@ int pneigh_delete(struct neigh_table *tb
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
@@ -691,16 +692,23 @@ static int pneigh_ifdown(struct neigh_ta
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
 
