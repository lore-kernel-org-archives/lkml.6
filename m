Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtrBLBhPFylF33GyKFzPYCCqb+N+pQ1x7RdXzI1DNNomFLgeLO/AoyV7O92DSp+iI1apAeF
ARC-Seal: i=1; a=rsa-sha256; t=1521483067; cv=none;
        d=google.com; s=arc-20160816;
        b=rkk0FVf4oaAKpZ7O9GT/Z7wW7xlMCAue1kBJOGH0CniEyed12N1fmivceCTM4TQ76T
         hmM1aKzNjlv/O6I/oHEYPr4vOSt0jGv8/0jufe6ccmpyUrFw1UzzNHNqJ2dxZoU2YJbD
         dSJeX3rtdcSzGnFjNhAP56xjz/U6D8hFHQmjMpFCB3EIMOWW+5dtaQl8ujHjxiJQLLJ8
         igNBpR9myhWJ4ifBWM8UwO1LgHcOr9GA2Ajhf5En0dQIMViUEvlD9bUhDch/gh6SbULL
         +fiAwRXGayuXWlkfubxzYlpqh6bGDJK2ENaZNMzQSTwj/jQ+RkLYQPiW7yoMqmVZp5jy
         3dig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Lm8v4JKFaP39l9nwZmRYveX2dCR3VX/K9KEmHUq4fxI=;
        b=xh+yqPp7tEQw0XyRtNcKEcNcXixvd8KAcKaUBq2vfkw0PajPmBgQiJ+UBal2C5pH9D
         cuDX0LHfV/wLifQHffcDmCEadvoi8+0Tur4erZeLEA1dByHy37CKmNZY0TIA1KLRazuw
         P5SO5idAOZv4xdllu2BApiuqBs8pcXMEFR8+ySzo0PygonjclhKBNf0mDTY+d+pwDGLA
         XOhDjWFlFXVVwdwr9OTq3Zx73SKF5qES2PQKOajaom5ei0UHhznlA47eVMG7R9h0FZua
         aquatvoqLclVh8by1FCkh7JP513qGy1VhU7BRIk20KFP2S+GFvQzHKAEOhf9inr6z6y3
         bwZQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Stephen Hemminger <sthemmin@microsoft.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 55/68] veth: set peer GSO values
Date: Mon, 19 Mar 2018 19:06:33 +0100
Message-Id: <20180319171835.597351843@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319171827.899658615@linuxfoundation.org>
References: <20180319171827.899658615@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390628799057705?=
X-GMAIL-MSGID: =?utf-8?q?1595390628799057705?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stephen Hemminger <stephen@networkplumber.org>


[ Upstream commit 72d24955b44a4039db54a1c252b5031969eeaac3 ]

When new veth is created, and GSO values have been configured
on one device, clone those values to the peer.

For example:
   # ip link add dev vm1 gso_max_size 65530 type veth peer name vm2

This should create vm1 <--> vm2 with both having GSO maximum
size set to 65530.

Signed-off-by: Stephen Hemminger <sthemmin@microsoft.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/veth.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -382,6 +382,9 @@ static int veth_newlink(struct net *src_
 	if (ifmp && (dev->ifindex != 0))
 		peer->ifindex = ifmp->ifi_index;
 
+	peer->gso_max_size = dev->gso_max_size;
+	peer->gso_max_segs = dev->gso_max_segs;
+
 	err = register_netdevice(peer);
 	put_net(net);
 	net = NULL;
