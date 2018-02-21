Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224alGH5rS0zXfNzqybKGupa3SdfoRfh4s4EvySjbuD1FfpOYfLG64Vt0WIBaa1uMf58dai2
ARC-Seal: i=1; a=rsa-sha256; t=1519218341; cv=none;
        d=google.com; s=arc-20160816;
        b=kKfTHm7sojJXHn8W1C+28LILauLA0IOuQibqYcr0ZWTqg+9xpkVUp7MCHoEqZeqGyj
         OHK8elOvGKMafy/+raCg5+H+FUuelkbm4C5Lx+FMlWFtxF2TViMEmjnu2dhiQ1WmyrvE
         1y3C5SmhF9Q/yZjP/DuiCnHYKykVNkqFC7lRDVFPFh3meGUY+a+b73Sbvg3QVycTOxGU
         RcEq6+28ON11EpqdASJoLGkqpdpuHaIWLJ8qBArStRxcx28Uih6sSPKEORkamvQqQP/S
         1u6SNsemfAPwjbr13ClS8W3C5wgLG4301BKLk9Q8QcfgYzg60827TkrVOuBR7iM/2uHc
         8Htg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=cCb592ArN7coyaVbkTPlqm0Hv1+dES2XfFRfyWAOqto=;
        b=MyQzZCDDqNFwrGkwIFiJ8drhr2YsJ6hD4q2WFegblb4mQBCuH5nALIhVeW5OoZYcxr
         oFKu8C6LIlSbocfRxQMQuprm72EgHk61uMB6YmI7t3dqXpbXroa+UqH7x27ZYlw3FDwZ
         bQLil53OvEGCcr5YpxrMw08MTO94KBHO8dKPC+r+si1mP5ohHZTAqJ5ToGVZg8iY/jSP
         BHuX7SpBPM8SmIKWmtD/MWF97ouZA0zi86D+C8Je3TfGGt0rH+7czB4A/i5XuyeePgrE
         wmw3P10ARlnLwCC/5CMv83UN2OsdxpfskjFLbl0KiM5b69e0gPkZiTHlZNAlxKqakyFY
         fKzQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Mikulas Patocka <mpatocka@redhat.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 150/167] mvpp2: fix multicast address filter
Date: Wed, 21 Feb 2018 13:49:21 +0100
Message-Id: <20180221124533.009238638@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124524.639039577@linuxfoundation.org>
References: <20180221124524.639039577@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593014704162058522?=
X-GMAIL-MSGID: =?utf-8?q?1593015891438468142?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mikulas Patocka <mpatocka@redhat.com>

commit 7ac8ff95f48cbfa609a060fd6a1e361dd62feeb3 upstream.

IPv6 doesn't work on the MacchiatoBIN board. It is caused by broken
multicast address filter in the mvpp2 driver.

The driver loads doesn't load any multicast entries if "allmulti" is not
set. This condition should be reversed.

The condition !netdev_mc_empty(dev) is useless (because
netdev_for_each_mc_addr is nop if the list is empty).

This patch also fixes a possible overflow of the multicast list - if
mvpp2_prs_mac_da_accept fails, we set the allmulti flag and retry.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Cc: stable@vger.kernel.org
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/ethernet/marvell/mvpp2.c |   11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

--- a/drivers/net/ethernet/marvell/mvpp2.c
+++ b/drivers/net/ethernet/marvell/mvpp2.c
@@ -6888,6 +6888,7 @@ static void mvpp2_set_rx_mode(struct net
 	int id = port->id;
 	bool allmulti = dev->flags & IFF_ALLMULTI;
 
+retry:
 	mvpp2_prs_mac_promisc_set(priv, id, dev->flags & IFF_PROMISC);
 	mvpp2_prs_mac_multi_set(priv, id, MVPP2_PE_MAC_MC_ALL, allmulti);
 	mvpp2_prs_mac_multi_set(priv, id, MVPP2_PE_MAC_MC_IP6, allmulti);
@@ -6895,9 +6896,13 @@ static void mvpp2_set_rx_mode(struct net
 	/* Remove all port->id's mcast enries */
 	mvpp2_prs_mcast_del_all(priv, id);
 
-	if (allmulti && !netdev_mc_empty(dev)) {
-		netdev_for_each_mc_addr(ha, dev)
-			mvpp2_prs_mac_da_accept(priv, id, ha->addr, true);
+	if (!allmulti) {
+		netdev_for_each_mc_addr(ha, dev) {
+			if (mvpp2_prs_mac_da_accept(priv, id, ha->addr, true)) {
+				allmulti = true;
+				goto retry;
+			}
+		}
 	}
 }
 
