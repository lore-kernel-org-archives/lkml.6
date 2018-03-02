Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvZX0MtcwGhF5pvn5/Ak90T1G6/6lmws6EqQOh71T18cLe+UkUuf7CfLI/xsVY7Jhr6+EyA
ARC-Seal: i=1; a=rsa-sha256; t=1519980905; cv=none;
        d=google.com; s=arc-20160816;
        b=EcBsu/2F+4CE0n9eWTlLvRSyiTIzZzCYYsBdNx54tx3+FJD6/J10TV+nA4HX/zK7rG
         GDHqCRV4z61Q1C8AuvpOPnVmz18cUAmEfrpRYTP7HoR2qNwa4th63Mc/u8YQ82exj2mI
         9TiEXGaqe5x4yk15Qoc+nIhrSP1H/odhnsOywFBAhf+qOYUzgqY5PVwHvti2tlrAywHY
         oLU0xmTkg6ak8GNJXA1zCY/JWorFo9G/UcJEc7gOWN/IBpyHTpkofMfZzNvqDwlW5RwQ
         76JXb9hhsJz2abAzRHni+kR73g/aaAgJUCaPjPWHz0yWB/3U6Ba2josnMHt6qb1C4s0u
         w6qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=1UkJJRYATthk9mA+e09yK7DmgZcJGO4aWRB9DZ0e7i4=;
        b=Mru75aUcEQC53zjhEHfDOEuLeP4NcDaI/mn8a0MROMG7b9DFVOAJ0kPpjl4mCPXJjC
         yorWW3mSvg+aF9JSaRZASHStb+kdO3ZQng54Rmu3CToxAUsHeKtvdZsP4aWunGaDDbZ7
         BjDDFyBxtyUpaM7NRa0K/kd6MkfhlOg2tlk8RkXBBv9dYXbEn1TA7iWVgZhLo4jAUa+4
         3z1S/d2Fyh+5/lL2dR/ObX3l9sQKdlgyJ1lU/DpQXo9+G+KTj28BvU8lCTTld2qUbK/u
         DkoR9c+6lLe1MYUqhY6ld58bWSPcjYe8OCVCh5lK6pu4EoBmGXd9kaA3qMBrTBkPtGsT
         julw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Eduardo Otubo <otubo@redhat.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 27/34] xen-netfront: enable device after manual module load
Date: Fri,  2 Mar 2018 09:51:23 +0100
Message-Id: <20180302084437.763619472@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084435.842679610@linuxfoundation.org>
References: <20180302084435.842679610@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593815306641088117?=
X-GMAIL-MSGID: =?utf-8?q?1593815498444500138?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eduardo Otubo <otubo@redhat.com>


[ Upstream commit b707fda2df4070785d0fa8a278aa13944c5f51f8 ]

When loading the module after unloading it, the network interface would
not be enabled and thus wouldn't have a backend counterpart and unable
to be used by the guest.

The guest would face errors like:

  [root@guest ~]# ethtool -i eth0
  Cannot get driver information: No such device

  [root@guest ~]# ifconfig eth0
  eth0: error fetching interface information: Device not found

This patch initializes the state of the netfront device whenever it is
loaded manually, this state would communicate the netback to create its
device and establish the connection between them.

Signed-off-by: Eduardo Otubo <otubo@redhat.com>
Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/xen-netfront.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/net/xen-netfront.c
+++ b/drivers/net/xen-netfront.c
@@ -1331,6 +1331,7 @@ static struct net_device *xennet_create_
 
 	netif_carrier_off(netdev);
 
+	xenbus_switch_state(dev, XenbusStateInitialising);
 	return netdev;
 
  exit:
