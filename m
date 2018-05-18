Return-Path: <SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZoDyPUYX3CQL1P5legwEqG7VeTHXz/HYVk3wB2DqA8P70afLZRr/3PxFl1AB+bc1mHDP9xz
ARC-Seal: i=1; a=rsa-sha256; t=1526631597; cv=none;
        d=google.com; s=arc-20160816;
        b=OwNMC2nqTaxa/vDo+7hPqpC0K/PSuGVtH5IMePGwcp29waUOMjLDXV6aOP2zr0xHEk
         SDr/2AJ89J+V3U4Wo/VH5M3C+W8BuvDJXxvmwnSLnlXDGfo2V+uulDdh54wR018SwnNv
         968vSdWVvK8X7WH0kCyMnE2SN43oXx1ChFYBRV/SQPynPKHtxCvdFwtmCa69FjJMID84
         SDz3NlBxtoEWkoxZG2nxHBquE3shzBh1ds6MBN85DXBmwCsM2CFMkRvzOUX7fc0+xpMu
         FXfno7JNSKTu/r69AsYk8rbgDgjETou42xn+zpEnwBTu8mesQlnMbBgcnKb7cHIZH4AW
         rqoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=d/zY8CVv+C5V7fw4cnGQl5ygvZOz3ADAhgOijdLZuYQ=;
        b=Uj6lxzXil780lT/vxk1hoExggAq5rmsJ3cgBdfY8OdGOrEW/srdOX+Ek4zmpvVvhV/
         icYdPeq3Jm/ubQvdKTBQ25rtA5qNOTP7I358pMgMovNpr9q6R1q8albhBTmd39ZJY05B
         0m8hxeklTP5tndmdLTqSm+pVr1pZ+qVsCaj3qToFpblv0khmExqy4SbNDvjgfAw399Nr
         oRIiEmp3eqejT0EMJInDKekdNS3zlSk4cOjEuB+jkUQiu+E0SmU2ujloqQS/gW3KWg0k
         y+rJZp620WGl1alBc300szYUbzCebzOqWYfdb3USy+LIUyOyM1Qp6dRmsq8QNU45e3MN
         hYDg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=QQj9pszU;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=QQj9pszU;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Grygorii Strashko <grygorii.strashko@ti.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 08/45] net: ethernet: ti: cpsw: fix packet leaking in dual_mac mode
Date: Fri, 18 May 2018 10:15:25 +0200
Message-Id: <20180518081530.755618799@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180518081530.331586165@linuxfoundation.org>
References: <20180518081530.331586165@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600789083638521342?=
X-GMAIL-MSGID: =?utf-8?q?1600789253539560433?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Grygorii Strashko <grygorii.strashko@ti.com>

[ Upstream commit 5e5add172ea81152d518b161ec5706503ad3d799 ]

In dual_mac mode packets arrived on one port should not be forwarded by
switch hw to another port. Only Linux Host can forward packets between
ports. The below test case (reported in [1]) shows that packet arrived on
one port can be leaked to anoter (reproducible with dual port evms):
 - connect port 1 (eth0) to linux Host 0 and run tcpdump or Wireshark
 - connect port 2 (eth1) to linux Host 1 with vlan 1 configured
 - ping <IPx> from Host 1 through vlan 1 interface.
ARP packets will be seen on Host 0.

Issue happens because dual_mac mode is implemnted using two vlans: 1 (Port
1+Port 0) and 2 (Port 2+Port 0), so there are vlan records created for for
each vlan. By default, the ALE will find valid vlan record in its table
when vlan 1 tagged packet arrived on Port 2 and so forwards packet to all
ports which are vlan 1 members (like Port.

To avoid such behaviorr the ALE VLAN ID Ingress Check need to be enabled
for each external CPSW port (ALE_PORTCTLn.VID_INGRESS_CHECK) so ALE will
drop ingress packets if Rx port is not VLAN member.

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/ti/cpsw.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/net/ethernet/ti/cpsw.c
+++ b/drivers/net/ethernet/ti/cpsw.c
@@ -1260,6 +1260,8 @@ static inline void cpsw_add_dual_emac_de
 	cpsw_ale_add_ucast(cpsw->ale, priv->mac_addr,
 			   HOST_PORT_NUM, ALE_VLAN |
 			   ALE_SECURE, slave->port_vlan);
+	cpsw_ale_control_set(cpsw->ale, slave_port,
+			     ALE_PORT_DROP_UNKNOWN_VLAN, 1);
 }
 
 static void soft_reset_slave(struct cpsw_slave *slave)
