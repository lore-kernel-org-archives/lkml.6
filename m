Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227j+7EuprvGKEZB4kRqcY57ALhr6mdzz0VLX8oFn2iE2dllJZKu+Xqzjlwk1TvA1n0YOL/t
ARC-Seal: i=1; a=rsa-sha256; t=1519217722; cv=none;
        d=google.com; s=arc-20160816;
        b=uC2EDwokM+B+QLKpQIVGQjVZW4R1b8lVygPV9eD/cy584R071YM1Hl+X3VNX5Kh6DU
         CKhXtpMDavi0XIH/inpmNcsNT5fnUugtOPyu8Fpk6dgV7mumm+7Lp4RUb8HyEW+Npm8m
         cjY9euP8QWM1DO+oUDmPeNlSfuRm9Y6EWEfLzrWfLdtksx56odyh58Csnsmu1ebfsid5
         lMbsrZu9WDcItFzdrPfz0I4g37PcA6kVbzKdqE+esQyC5zy2P28el6feHxZQxVytLTry
         Z81JfhbfYjG2WYRs5YOoGgZUGn0BxQHcg+xHLBB4WMI2Ezwgx2UPjohU5O98jnzDs73L
         +xVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=L4RVWN1mfubz3WsfTCYt/xthMB6z6bvzAcC2bBr5tRA=;
        b=Tn9PnHA9EHfIolajjotyVMCY3YeHwlg9bAhPIPtd5MlHtLHPuDO/NsIzB5WkwHq5cY
         HsMbdcje73rjr3gU4H4RX+iGYaBExNC8fwaTN2T2IDPsemnhYAVcOZp4zNj6QpNIPC49
         raxrfZQ4FRKnieLXBwXiMKg+yJeQYsg9tUpoPDnyg2g6obLLp90mM27Y3G6qz0Uweb/Z
         yKOKewGNAGjMR9ER1MvLV9ylLLZonWwldFgqPkj27KUR0DCJ7kub8MjJH/v1pbBAkkCT
         siqYFPw2M668H9omSsIPZZR12I/O0t/Ws5PDZ5lZuO5pajXag3ZOFyv/xJv8n4+XjemB
         eC+g==
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
Subject: [PATCH 4.9 31/77] mvpp2: fix multicast address filter
Date: Wed, 21 Feb 2018 13:48:40 +0100
Message-Id: <20180221124433.501918970@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124432.172390020@linuxfoundation.org>
References: <20180221124432.172390020@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593014704162058522?=
X-GMAIL-MSGID: =?utf-8?q?1593015242710041092?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -5657,6 +5657,7 @@ static void mvpp2_set_rx_mode(struct net
 	int id = port->id;
 	bool allmulti = dev->flags & IFF_ALLMULTI;
 
+retry:
 	mvpp2_prs_mac_promisc_set(priv, id, dev->flags & IFF_PROMISC);
 	mvpp2_prs_mac_multi_set(priv, id, MVPP2_PE_MAC_MC_ALL, allmulti);
 	mvpp2_prs_mac_multi_set(priv, id, MVPP2_PE_MAC_MC_IP6, allmulti);
@@ -5664,9 +5665,13 @@ static void mvpp2_set_rx_mode(struct net
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
 
