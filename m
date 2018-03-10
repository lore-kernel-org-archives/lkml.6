Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELscZL8dJx+sjR0mQOyk5b6RX244WYAJ7v/Eqph0e2dP76YrTjnlW7RK0Kd8QBsPdoTceKk2
ARC-Seal: i=1; a=rsa-sha256; t=1520641353; cv=none;
        d=google.com; s=arc-20160816;
        b=0Q0bP6AkyWOAeThHzH4T87ykuFPmcj9RT7bPei6W806702mE+/ty0Cj0qXOpL8rMjo
         RvVFxduV6NV3Q08cbB8iVzdj+16qrzhFySRb6PXyMxxzHtg56NUlMwXhWQxWSFb5JAie
         NrDulQTTt1ScHiJNJk9aYcPOHTM3pwI7b934K7Dhf9tA/GBDNsGLNOac9/ahALiiuGA3
         ni1+kmpUcE4rdlPeAjBqPOPoQsAHwyMLV1SfbFlZShuezhSK4ICGgz8B8mp3RQx88bRG
         6N7ksLtGqthq5CvqZ+fKoyZGLHumHUNbaw5AUaSPKJSdxYpsbMS4cn/v6jxLyq/qBoUQ
         aIiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=+wuq2cVsHvefFZsmL9Z9UVB71+vYnoVilHBeE6O3URA=;
        b=Iia2Jo0puNFpWM95mAxmBErQMYRdkNrKDjzNP5tfR4r25wbSKU3ldwkhtfTJ41lCWu
         3qPpaNILgQ/Z46PBbz+GZi4OvHExIUlgXA6Bx0cjM77qJfJdp/74ml2J8pyy1Iy+duAd
         wvVzlwtgCejth7P9zIc+xgjnh1HG7HJhrExoZoTlNErdZDfsYeKj7FusTCvRz8aMZcfB
         0mpy+DNOvQ4Ind+DLkaoDdcdxe2zePnnMSXyayrC/bdl5/nffGzjleWE41We9Vzn2Fr/
         rrKX4F4aGw0KDUdoxm6ZdjYyk9Vy95pui+iNmXcXMLT4ArTqxBc08+mr2B/i8eAO9EHS
         5egg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Julian Wiedmann <jwi@linux.vnet.ibm.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 52/65] s390/qeth: fix IP removal on offline cards
Date: Fri,  9 Mar 2018 16:18:52 -0800
Message-Id: <20180310001829.153472986@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180310001824.927996722@linuxfoundation.org>
References: <20180310001824.927996722@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594508027769894268?=
X-GMAIL-MSGID: =?utf-8?q?1594508027769894268?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Julian Wiedmann <jwi@linux.vnet.ibm.com>


[ Upstream commit 98d823ab1fbdcb13abc25b420f9bb71bade42056 ]

If the HW is not reachable, then none of the IPs in qeth's internal
table has been registered with the HW yet. So when deleting such an IP,
there's no need to stage it for deregistration - just drop it from
the table.

This fixes the "add-delete-add" scenario on an offline card, where the
the second "add" merely increments the IP's use count. But as the IP is
still set to DISP_ADDR_DELETE from the previous "delete" step,
l3_recover_ip() won't register it with the HW when the card goes online.

Fixes: 5f78e29ceebf ("qeth: optimize IP handling in rx_mode callback")
Signed-off-by: Julian Wiedmann <jwi@linux.vnet.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/s390/net/qeth_l3_main.c |   14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -259,12 +259,8 @@ int qeth_l3_delete_ip(struct qeth_card *
 	if (addr->in_progress)
 		return -EINPROGRESS;
 
-	if (!qeth_card_hw_is_reachable(card)) {
-		addr->disp_flag = QETH_DISP_ADDR_DELETE;
-		return 0;
-	}
-
-	rc = qeth_l3_deregister_addr_entry(card, addr);
+	if (qeth_card_hw_is_reachable(card))
+		rc = qeth_l3_deregister_addr_entry(card, addr);
 
 	hash_del(&addr->hnode);
 	kfree(addr);
@@ -406,11 +402,7 @@ static void qeth_l3_recover_ip(struct qe
 	spin_lock_bh(&card->ip_lock);
 
 	hash_for_each_safe(card->ip_htable, i, tmp, addr, hnode) {
-		if (addr->disp_flag == QETH_DISP_ADDR_DELETE) {
-			qeth_l3_deregister_addr_entry(card, addr);
-			hash_del(&addr->hnode);
-			kfree(addr);
-		} else if (addr->disp_flag == QETH_DISP_ADDR_ADD) {
+		if (addr->disp_flag == QETH_DISP_ADDR_ADD) {
 			if (addr->proto == QETH_PROT_IPV4) {
 				addr->in_progress = 1;
 				spin_unlock_bh(&card->ip_lock);
