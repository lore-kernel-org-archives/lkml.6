Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+wBn7BhNBTGUJ0a5SuSSc723t/0GD1UQnzjoHhOZ0QlaNdVJQpImkBNU/De7tYRs6AuTcW
ARC-Seal: i=1; a=rsa-sha256; t=1522346766; cv=none;
        d=google.com; s=arc-20160816;
        b=Z4a/hOpgLXaVFg9WRBltmjCI+qJXKR9OQ6ybfGeEIHiX/eD3c4ASszdNYAqRdADvJ4
         K2QlTS9oI2bdGBgq0fXQVSZ4yyxr1m3N39ieInhadgbjacO1g1bRZayvSdrYFVnqJGJC
         d486rLwiX1J6fTssA31cDPec0X76y4CcUpBT+GFqERjO8vrijQcMOE4OFLM/taS8YTrq
         4H/41FSRqMRCBq32kCqytsqyvIXaPr312yp/NRO+Xn351tdOgHBxeHAvj9q5arvwgsGg
         g6JU1uWbzGmjUqP2Mmezl8JL2TBO5GY5Ns50LWST185F7VDlIKl8lw16+vX4X8biOGIB
         fPWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Yc1AOezl0jt65rWtkKMHsKzeGGjq+oouVcx/FvkJAZ0=;
        b=Xp/dPan6fnJ3B6MnXnUJWruBPNfjKepK17Uks/UHv9YNBAsWvJKMldupdxbG9uBXpB
         IzBfqY2ex/vTJCs4oBYANAHz6L18LiYLTBMp2uLdwvmoCgAHiPS9nhv7ef50gFLSitgm
         SbcJo1Rl85uLhM5gIJJEtSE5/4dka/N7f8AOquVWYmCjqGnK72QEfOUcveIz4pjhp0TO
         DCg+/H0/i6Dnfe+u2+DHLhskRhmsAX3nENeBvt4bjqH7bvCFCu2Vot61ppqrl75ikjfs
         zDCBW4F1d8qdQzzg93hIgEFVkiJnwErARZ/OJNkCq6LpsbMlWpSsi7ae911W4Cz7Yctn
         hGYA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Ben Hutchings <ben.hutchings@codethink.co.uk>,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 29/43] netlink: avoid a double skb free in genlmsg_mcast()
Date: Thu, 29 Mar 2018 20:00:24 +0200
Message-Id: <20180329175733.169513971@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180329175730.190353692@linuxfoundation.org>
References: <20180329175730.190353692@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596296114205984093?=
X-GMAIL-MSGID: =?utf-8?q?1596296283894424669?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nicolas Dichtel <nicolas.dichtel@6wind.com>


[ Upstream commit 02a2385f37a7c6594c9d89b64c4a1451276f08eb ]

nlmsg_multicast() consumes always the skb, thus the original skb must be
freed only when this function is called with a clone.

Fixes: cb9f7a9a5c96 ("netlink: ensure to loop over all netns in genlmsg_multicast_allns()")
Reported-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/netlink/genetlink.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/netlink/genetlink.c
+++ b/net/netlink/genetlink.c
@@ -1106,7 +1106,7 @@ static int genlmsg_mcast(struct sk_buff
 	if (!err)
 		delivered = true;
 	else if (err != -ESRCH)
-		goto error;
+		return err;
 	return delivered ? 0 : -ESRCH;
  error:
 	kfree_skb(skb);
