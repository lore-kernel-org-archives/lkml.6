Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELttZdHYUNw2L8Aj+jwhwVd5eputiZS6cWQe7LLMoJnIfcniOxLkL0CE17uDX0ROVsGnHBUC
ARC-Seal: i=1; a=rsa-sha256; t=1519981149; cv=none;
        d=google.com; s=arc-20160816;
        b=cGb2oQNPD2Bpy7mUxsiyuuMshKGoELn4TdufrJORdd8vF/oqUcGqdQme0GX5nI8Q9z
         JrPmioCtZqDqbYuv7fGAnBix9Yga5Al1qv8ykhElxSOKEEB+mY5FSkP25C+ASGCuOxVW
         TrJ/alfBcUGB8apbwe31QJ7k+k8wrKQlOkla1dtYS2wPWivN6StIV74jKnUpI48dkdTT
         idhAyxTREX7VZF0n8G5l1FQw4xNeFat2uw+ECs2gU8I8wOeFTZtXTBUUF7YPkU3yPEuD
         MqEJsvVK9uWOJlLAibvQUkJsqrtxgBX11X6N8xVa3Es6Hl930YKrO8GFipTPqhoe5eRr
         2MRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=fy8ft5X1/1Y03Qjz/QP/EvyNdzlIu4zSrzkn+6+uIJE=;
        b=BBuqVmkvoxuqU7i2uCHH5wnTR5/cct6IMVS7l5s60W3OHbFMdapiSZHybJxmiquBph
         DezHMFSbFlWirRzLgM2WWx+NxdjVBd/8VgKK/eKs0M1MgwgVpdtcVxSFWmfonIzLnGfC
         lh9nPiA3p/yowm3n0ixGBAVs3RDRBUtyZS/1DN2Trdyeoi6ysZmC3BC5LxlRABizJhLA
         ++cg0VP7y/6eo+BBFxZJ/AS4VBXv99z74kSFfCjbXMjemB0/dbBmbh/kGolPjzdf5weS
         JFXQUwy8I641JH1GWLBV+0+ltfwwyyzt0qlLUUxqBo7e06Pt5kbMau0EUxeQJUbwYXCX
         usCg==
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
Subject: [PATCH 4.9 48/56] xen-netfront: enable device after manual module load
Date: Fri,  2 Mar 2018 09:51:34 +0100
Message-Id: <20180302084451.981249355@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084449.568562222@linuxfoundation.org>
References: <20180302084449.568562222@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593815306641088117?=
X-GMAIL-MSGID: =?utf-8?q?1593815753536508216?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1345,6 +1345,7 @@ static struct net_device *xennet_create_
 
 	netif_carrier_off(netdev);
 
+	xenbus_switch_state(dev, XenbusStateInitialising);
 	return netdev;
 
  exit:
