Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48uRHsKGA9nCHoKtftyO6pwyoESVj26tCl7PQ+PXBHID561BAdIJCH+hn942ZtyWAbpTAei
ARC-Seal: i=1; a=rsa-sha256; t=1522346794; cv=none;
        d=google.com; s=arc-20160816;
        b=YSxkjSU9gXizN+6lnyNNtqhoHNqBq56eYWevGTZ76cc6KaGRD7aubHfymyovKDrtoS
         0KkDEFRZOlSsp0ckoO3j51nc6Ec/XtYt6W/AoNtr4wJGyJ3mkMHxBB4gqbmgRHziXkqy
         jY5aC+wo/Rp1zY2XE0gzKie8tpSd6/maJlKF9ASzuciBE1SJoetk5z+YY7pxMZ0CPUoa
         172ucjvIEjb+hL+glCGP4kXWj6+uRNamRCY9M5OlKeVpZ6ipt5nh9y48CgxleduFXpKd
         heus8FSSxaqF9HwDpqV22HEzq5n2weNik/E9vzzfNGX7ci+WeTi5HRKQt0SAbid/yNMH
         621g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=TtpI/9zcDzsNd05TffRksmMP/tkQRcJURfnbs51Wbgg=;
        b=oqJ2zkXFQHoC0tNc6dZTcUteCJN4N3GpDlyl5/eWSilVlEc4bo/Z5rXZpGaC7uDLXc
         PJU09g+LJAzMHpXSZHcTuIEpvX3K5apKbBflhocc/50mS6oLrrmJ/2ZYmiwZ2b8gWAla
         9zSMg219JI5h6rEjtDsuicYHS18UwxfSAxM54KdYFN1SQqKDJm9bEi7rCQTJaGJ433J5
         wjvC7Kvzc2dvcQ8jbKZCunV7YJ4NMdDk9HuvyvSbrO+H7BEbgwqD+0Cfc+pjyGiS3DAM
         +hbV9D2wmvbKPf4vrSja0fHFcUlnSDTV2xFk0eFm7yIHDTqNyaxZ2mgqu7MIJ8JwTXqj
         cSjA==
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
Subject: [PATCH 4.9 17/28] netlink: avoid a double skb free in genlmsg_mcast()
Date: Thu, 29 Mar 2018 20:00:36 +0200
Message-Id: <20180329175735.374546334@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180329175733.447823703@linuxfoundation.org>
References: <20180329175733.447823703@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596296114205984093?=
X-GMAIL-MSGID: =?utf-8?q?1596296312861338710?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1128,7 +1128,7 @@ static int genlmsg_mcast(struct sk_buff
 	if (!err)
 		delivered = true;
 	else if (err != -ESRCH)
-		goto error;
+		return err;
 	return delivered ? 0 : -ESRCH;
  error:
 	kfree_skb(skb);
