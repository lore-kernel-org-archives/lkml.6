Return-Path: <SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZreir+/rd2uyFDiD6xyvwfYGJAGC0ifUeZ+crgRBbZu1a9wzziZFHX4Vnm4DKNE1Lx1mN5D
ARC-Seal: i=1; a=rsa-sha256; t=1524838043; cv=none;
        d=google.com; s=arc-20160816;
        b=SfTi4Fu9LZnfcefdGRkB9KJfdLpYRw9/3z7ExC/q/MjeBqv4pFjJTB+z6ulmLRgrUQ
         ofDsefcW5aokzM0Xbtj4dftTnuy+FLy9pG7mlDEu7ayU4KFkITVCEIAw+y0dYwtLMmBk
         dzTyd9vfInsnYOh/Fqlh8aNBVPF7VkFK/BSvfDq6b2niLeaYuMjY51K7AY/MXyvfIEV3
         qqZhB9ZXfEjiRf9cxGzpaQDZ6YfJyY/Oz5LaNd9bYJufkrIwxQKgmiFP1RnczcW+RgED
         PV+8cNKL/el42xxXw1f6OryKKjnmK0UQOM7b3KjWSfJ8HYjANU/j0Wm/Saklx7pPwhw6
         jmxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=YE61RZceaRl1CZsMAOVzEvKpjA/r539K10Woti8gUAE=;
        b=IMQAWyMSClKnmgnEWYXqZLb5wASLCTt3AkRqLvp2b+R0olgmTWtZpIDT24qPl4IoqQ
         eMjF0oMzpijdQaqNFhI4eZQ/pTyIxb/RtfPkArcCc7Wi2ZlxXW43Xu1pQnjqL01eDZR4
         pXb4pv9Tk/Dva5hKzhIz8sst0GZWkHNnq3rUpuCVJPiWNIF4kOJRY4MsonMlMhbX+5nf
         lFPiBXwqXhjKGj7B7Tz0hcosCzMjE5y4LGavrCnfLNeWi9iUeH1epoCwOAwDA3wltG5k
         soYogtxEbWD1Acu1BzkxrVLGayfMK2vL/9Y9eYyBVN/FZtdT6VsA71lFhe3RSJSMNDlD
         JYpQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB50B218C5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Xin Long <lucien.xin@gmail.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 08/80] bonding: do not set slave_dev npinfo before slave_enable_netpoll in bond_enslave
Date: Fri, 27 Apr 2018 15:58:01 +0200
Message-Id: <20180427135733.364754407@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135732.928644313@linuxfoundation.org>
References: <20180427135732.928644313@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598908146234977294?=
X-GMAIL-MSGID: =?utf-8?q?1598908576832097977?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xin Long <lucien.xin@gmail.com>


[ Upstream commit ddea788c63094f7c483783265563dd5b50052e28 ]

After Commit 8a8efa22f51b ("bonding: sync netpoll code with bridge"), it
would set slave_dev npinfo in slave_enable_netpoll when enslaving a dev
if bond->dev->npinfo was set.

However now slave_dev npinfo is set with bond->dev->npinfo before calling
slave_enable_netpoll. With slave_dev npinfo set, __netpoll_setup called
in slave_enable_netpoll will not call slave dev's .ndo_netpoll_setup().
It causes that the lower dev of this slave dev can't set its npinfo.

One way to reproduce it:

  # modprobe bonding
  # brctl addbr br0
  # brctl addif br0 eth1
  # ifconfig bond0 192.168.122.1/24 up
  # ifenslave bond0 eth2
  # systemctl restart netconsole
  # ifenslave bond0 br0
  # ifconfig eth2 down
  # systemctl restart netconsole

The netpoll won't really work.

This patch is to remove that slave_dev npinfo setting in bond_enslave().

Fixes: 8a8efa22f51b ("bonding: sync netpoll code with bridge")
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/bonding/bond_main.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -1656,8 +1656,7 @@ int bond_enslave(struct net_device *bond
 	} /* switch(bond_mode) */
 
 #ifdef CONFIG_NET_POLL_CONTROLLER
-	slave_dev->npinfo = bond->dev->npinfo;
-	if (slave_dev->npinfo) {
+	if (bond->dev->npinfo) {
 		if (slave_enable_netpoll(new_slave)) {
 			netdev_info(bond_dev, "master_dev is using netpoll, but new slave device does not support netpoll\n");
 			res = -EBUSY;
