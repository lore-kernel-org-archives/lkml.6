Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+rYi7LzLwStWit56TkjCyVin2FD0t/T0J42crmJesALThTmluORTRZ0vrbmnNeoHRhiArS
ARC-Seal: i=1; a=rsa-sha256; t=1523399574; cv=none;
        d=google.com; s=arc-20160816;
        b=V1PBGkpgU8MQjacWu2hv2xeP8/pGfcA1570I8QRvhwBuZtzhlAe8urd+gja/LJNxAC
         fWCtkOIlv1lFG3fMruNekkwRuX1vtdrX7gn5bO/XNvZDbFaDKeGw+v2snTalpizorbDN
         Ydi7OXXFqZSDm3AZIAkK5g30sZCv9C7WOTUewj1fJ3aenuiQayvi/DXxkUL1UqkA7eHE
         MS5JUkqcYrD/Ke6P2iwNsBqjqhl1dcUEkpQ8+ZBxSd8C6nizO5TsLXQRbFdO/1sclMaN
         Zifc6ovFoXKK4BSYicRLKX2C8XwllZQcbVYKJ66NGHIMuciTA4JVPY9F7dFQfpp9KnRF
         Csqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=H8mqPQvo2KVQTXq3CqX5ZO6pntX4GO1HioD0kL7ye68=;
        b=tfzg2HA77f35/Wi94JCfgri7MU0kG4w825d0MdAGcRXzi5Cpm19ysV6rZpTeaiHvML
         MiRfm4yQTtFNQxaYm34zBj6d3v2znL2+/zRGgXtxD3N+Muub519sBYg22Wquj3ASdmPJ
         dgtNDUU/lHN0AC4xiaqSvAg060/pcsmaUVbpKm16VzsMrwLDpzBpvdYkDItK9Wbgu8Jj
         rEglP0v3bSWsUKUfajHvyAn3ZGe37IiwqpEFBjx7jvqArBSheu9+A3bDTxWIl+cna6tI
         mt9NkyP+tUQ9CIWaMOxG/Vq18879OtVegENGXzxQq0QktpulEh8SRtEW4jBfXNTgK43z
         +tng==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Miguel Fadon Perlines <mfadon@teldat.com>,
	David Ahern <dsahern@gmail.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.15 139/168] vrf: Fix use after free and double free in vrf_finish_output
Date: Wed, 11 Apr 2018 00:24:41 +0200
Message-Id: <20180410212806.989341969@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212800.144079021@linuxfoundation.org>
References: <20180410212800.144079021@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597400232573875068?=
X-GMAIL-MSGID: =?utf-8?q?1597400232573875068?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Ahern <dsahern@gmail.com>


[ Upstream commit 82dd0d2a9a76fc8fa2b18d80b987d455728bf83a ]

Miguel reported an skb use after free / double free in vrf_finish_output
when neigh_output returns an error. The vrf driver should return after
the call to neigh_output as it takes over the skb on error path as well.

Patch is a simplified version of Miguel's patch which was written for 4.9,
and updated to top of tree.

Fixes: 8f58336d3f78a ("net: Add ethernet header for pass through VRF device")
Signed-off-by: Miguel Fadon Perlines <mfadon@teldat.com>
Signed-off-by: David Ahern <dsahern@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/vrf.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/drivers/net/vrf.c
+++ b/drivers/net/vrf.c
@@ -578,12 +578,13 @@ static int vrf_finish_output(struct net
 	if (!IS_ERR(neigh)) {
 		sock_confirm_neigh(skb, neigh);
 		ret = neigh_output(neigh, skb);
+		rcu_read_unlock_bh();
+		return ret;
 	}
 
 	rcu_read_unlock_bh();
 err:
-	if (unlikely(ret < 0))
-		vrf_tx_error(skb->dev, skb);
+	vrf_tx_error(skb->dev, skb);
 	return ret;
 }
 
