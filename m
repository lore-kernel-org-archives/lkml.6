Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+cKf3ZGQD/Gk+Zo+irOuJ68e+sXdFDDAYA1EzhU88gUTSndJRfjTpaSl4d2w/Cbl9uWXGV
ARC-Seal: i=1; a=rsa-sha256; t=1522346585; cv=none;
        d=google.com; s=arc-20160816;
        b=ai2UXmRB2j9gNILZ7cfeJgqSn25jhGPusOPhWR869OdJkkoLACXpT95srQ6/l1uSiG
         XkFXSq0lTCMsw5YBIA2J7tq21iWKBz+4uHyBzQb2KN6keBISQU9c3dY6jXpHkSvrHz31
         ++9vvT1xZmjfRHtiOoPyPBFgsgnk1lTFf++/tEP20rwnzdowfJZWA3yOfK9X0usrXm4N
         5aT4YpslCdiAW55RJ7l/VbxCLSYdVYIU0KyExJOsuQlXev253Hr73mpAmGyuiR893tU8
         lGBc/DLU//XVuwumOypy+un0drKnlG/tNkPMjE+aIoRkEdkWr5IK7s8yWmyYzy5F4O9G
         vLbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=f2rWHV7X+VzOAdj7mwYMp624qf4hnKJ1YkC8SaSJrGI=;
        b=AmmuQbkuZdxtYvgg7wWrSdsJHfEPOjuT0st3WznE3Q8t2xyOfKNw9xuX0g4mrkVS/0
         cFUujUh8pS93KWy8iSZkar4mT0z0pwa1EdoMPCjaoGz8KO5sm8MCy4vknB5EC2iaq5n5
         Yl1rY8WJrqM7PiuA8PsKzqfrzKycOugKN742JOKu7ZHU5tbaYcvXvNCgWoM9E6mkL7M9
         NKYfqMBLEcqbhoqipZtd0U/XDRV9bJXPQkQNHMoJJuYGQN43172DMktDD8AWn8SIT9ci
         vprBWUaIoyMAWOMqUpOtpEWabHJ1O4z7oC5GnoDx1BnjSKVpYuKege9u7HqWO1HDTyMt
         7D+g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Alexey Kodanev <alexey.kodanev@oracle.com>,
	Shannon Nelson <shannon.nelson@oracle.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.15 09/47] macvlan: filter out unsupported feature flags
Date: Thu, 29 Mar 2018 19:59:50 +0200
Message-Id: <20180329175729.812639758@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180329175729.225211114@linuxfoundation.org>
References: <20180329175729.225211114@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596296092990311959?=
X-GMAIL-MSGID: =?utf-8?q?1596296092990311959?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shannon Nelson <shannon.nelson@oracle.com>


[ Upstream commit 13fbcc8dc573482dd3f27568257fd7087f8935f4 ]

Adding a macvlan device on top of a lowerdev that supports
the xfrm offloads fails with a new regression:
  # ip link add link ens1f0 mv0 type macvlan
  RTNETLINK answers: Operation not permitted

Tracing down the failure shows that the macvlan device inherits
the NETIF_F_HW_ESP and NETIF_F_HW_ESP_TX_CSUM feature flags
from the lowerdev, but with no dev->xfrmdev_ops API filled
in, it doesn't actually support xfrm.  When the request is
made to add the new macvlan device, the XFRM listener for
NETDEV_REGISTER calls xfrm_api_check() which fails the new
registration because dev->xfrmdev_ops is NULL.

The macvlan creation succeeds when we filter out the ESP
feature flags in macvlan_fix_features(), so let's filter them
out like we're already filtering out ~NETIF_F_NETNS_LOCAL.
When XFRM support is added in the future, we can add the flags
into MACVLAN_FEATURES.

This same problem could crop up in the future with any other
new feature flags, so let's filter out any flags that aren't
defined as supported in macvlan.

Fixes: d77e38e612a0 ("xfrm: Add an IPsec hardware offloading API")
Reported-by: Alexey Kodanev <alexey.kodanev@oracle.com>
Signed-off-by: Shannon Nelson <shannon.nelson@oracle.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/macvlan.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/macvlan.c
+++ b/drivers/net/macvlan.c
@@ -1036,7 +1036,7 @@ static netdev_features_t macvlan_fix_fea
 	lowerdev_features &= (features | ~NETIF_F_LRO);
 	features = netdev_increment_features(lowerdev_features, features, mask);
 	features |= ALWAYS_ON_FEATURES;
-	features &= ~NETIF_F_NETNS_LOCAL;
+	features &= (ALWAYS_ON_FEATURES | MACVLAN_FEATURES);
 
 	return features;
 }
