Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751553AbeBXVvx (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Feb 2018 16:51:53 -0500
Received: from sonic306-22.consmr.mail.ne1.yahoo.com ([66.163.189.84]:41415
        "EHLO sonic306-22.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751399AbeBXVvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Feb 2018 16:51:51 -0500
X-YMail-OSG: 80j.57cVM1lTdLC7QKcGYN5j0rebEwUVKYEy5353dr.FeeAKHblhKDQsIWk0Z5l
 CnJOZRoWzSzVDwSyq.TcVFcMxFixJRXlBg0JBYe2bjwhlMjjzvaUbueK1j2y9nIt68d7kX5AF7yt
 nrykH5JcOTl9TAPTxBhZZm2iMNenkolpLwR2tpG_T83.72p.OsgutoqCOwVOkm7LjaWWEG2dy3II
 AlkEgvIKd2zA98TJiO4ZHpYJPsl7Ye6ut2ifMAFt6z612JWgHBoRvpYp6mRNxsSVVWkVdvUXf67F
 fSbZGR30Pc7zaVVJpnCA4rcCLRNln7ri5jDJ.xa9OsTj2AMNfoHvLMsKQG57.AroYPj9g5EtJz0Q
 5STu5H1NagbszMVXTurDGCMXk7_hkD3ubduH.4nvPCJ1KiHptDhC1tjPT5RSleJi.0F1k66EguMr
 H5IYPePRt0aty_ruAkYyapXyC.XGenq_ITapXMPIIqxiADEUiUeF1LGY4glerJ.acTxNVkK_6fIP
 sPzoVVP126TobS_suKJeAJFwtzoXJdGW6qFpjaQSpvVZqzAkp
From: Denis Du <dudenis2000@yahoo.ca>
To: davem@davemloft.net
Cc: khc@pm.waw.pl, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Denis Du <dudenis2000@yahoo.ca>
Subject: [PATCH] netdev: carrier detect ok, don't turn off negotiation
Date: Sat, 24 Feb 2018 16:51:42 -0500
Message-Id: <1519509102-5629-1-git-send-email-dudenis2000@yahoo.ca>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sometimes when physical lines have a just good noise to make the protocol
handshaking fail, but the carrier detect still good. Then after remove of
the noise, nobody will trigger this protocol to be start again to cause
the link to never come back. The fix is when the carrier is still on, not
terminate the protocol handshaking.

Signed-off-by: Denis Du <dudenis2000@yahoo.ca>
---
 drivers/net/wan/hdlc_ppp.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wan/hdlc_ppp.c b/drivers/net/wan/hdlc_ppp.c
index afeca6b..ab8b3cb 100644
--- a/drivers/net/wan/hdlc_ppp.c
+++ b/drivers/net/wan/hdlc_ppp.c
@@ -574,7 +574,10 @@ static void ppp_timer(struct timer_list *t)
 			ppp_cp_event(proto->dev, proto->pid, TO_GOOD, 0, 0,
 				     0, NULL);
 			proto->restart_counter--;
-		} else
+		} else if (netif_carrier_ok(proto->dev))
+			ppp_cp_event(proto->dev, proto->pid, TO_GOOD, 0, 0,
+				     0, NULL);
+		else
 			ppp_cp_event(proto->dev, proto->pid, TO_BAD, 0, 0,
 				     0, NULL);
 		break;
-- 
2.1.4
