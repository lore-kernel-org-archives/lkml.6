Return-Path: <SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrn0xtSbsO8a6BMEybGnNwCEpeKEmhr54qLkkfxYyx1Yac3pht/XLNxd3wTzdW0CsfFuNdb
ARC-Seal: i=1; a=rsa-sha256; t=1526631520; cv=none;
        d=google.com; s=arc-20160816;
        b=TvnfQEFLUiS3WlMeEy+4Sej30ybZT7RS19pxeme6W3e2u+b6gKxc2U6V/eLkN5shSd
         BBUO80aO4lV06cAzlyTvNuLOngbQ4ieaKz1sTZN9rgOjkzjAX4Rm+L734M6JuCMS8P/c
         iG1o4bsp5+LRJTWbvCCnCDRbgEI0uA3wgCQ2zS9hNQAvIX6IFiQV4MipvW/smMFaYHv4
         O438U69ufYkQMT1qfwTA6Pz7+r6A9sYDT82kfGcro4eKZSuYEV51O1Tbdb+SOcn6cryb
         K/uoW0iBeiyJoZOi8CnscPUFliU6eJPpYn+NgSrR9F/TMM2lPSNGDGH5X95OfGL/4g/m
         e4xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=wHEbqQB2bVkd7Cwo5epZpZ9+jN7UQmlV1nEjMBMVlPY=;
        b=kF3HhM6Hdg4KW+ok1JQLsHRUWJtEth7nQANHP35PQTipVjvWTRKEfX0ybx5hm6pF0q
         0FCS8IYhy0focRQfLNiOnQmwrhbZTUVvnkpWXd1EQMPpFIxgkb5eDGlb+/Gif2oMftf/
         FKgd4zX8/R4ADIjP3K5zO71NrC2hzKRGn9pOXfTahi7nOfRG6MmkKX3zYPtNo35JV4gS
         rysvKcSzXC7uztWZTVZeP4Vv8+HsFInVH6gk5Ebff1DeOZOO4mZrxXZhL6mH3iHcSKno
         vW9D6WCSw7nIFcygNpNsH2J/rUBiRFIytKqE6e6bos8OwzNe+5Eyov0eTZm3aMjpuV4F
         n8ug==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=kTHYC++t;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=kTHYC++t;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.16 49/55] ipv4: reset fnhe_mtu_locked after cache route flushed
Date: Fri, 18 May 2018 10:15:45 +0200
Message-Id: <20180518081459.708662342@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180518081457.428920292@linuxfoundation.org>
References: <20180518081457.428920292@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600789172530377053?=
X-GMAIL-MSGID: =?utf-8?q?1600789172530377053?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hangbin Liu <liuhangbin@gmail.com>

[ Upstream commit 0e8411e426e277f55bd21e287ec89fab6f8eacae ]

After route cache is flushed via ipv4_sysctl_rtcache_flush(), we forget
to reset fnhe_mtu_locked in rt_bind_exception(). When pmtu is updated
in __ip_rt_update_pmtu(), it will return directly since the pmtu is
still locked. e.g.

+ ip netns exec client ping 10.10.1.1 -c 1 -s 1400 -M do
PING 10.10.1.1 (10.10.1.1) 1400(1428) bytes of data.
>From 10.10.0.254 icmp_seq=1 Frag needed and DF set (mtu = 0)

Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/route.c |    1 +
 1 file changed, 1 insertion(+)

--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -1376,6 +1376,7 @@ static bool rt_bind_exception(struct rta
 			fnhe->fnhe_gw = 0;
 			fnhe->fnhe_pmtu = 0;
 			fnhe->fnhe_expires = 0;
+			fnhe->fnhe_mtu_locked = false;
 			fnhe_flush_routes(fnhe);
 			orig = NULL;
 		}
