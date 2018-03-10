Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELti2TAcyraOHNGuSbAA4FBK+GgTyoFQMubGiD0T8hEhD39WbqYat/8s302JbpcifE9w/JHM
ARC-Seal: i=1; a=rsa-sha256; t=1520641167; cv=none;
        d=google.com; s=arc-20160816;
        b=eur+nxAb4aMk7T+Z8KBm6FXt5eORk3lJO5oG07pIW/Ri1e7u6EhDrS+3Fu6dfJ68x0
         SNJq5yjFkiJa0uLJJiKH5HZRAALlhwxTR/N7Hcko9x9IX9MUjxHV1lcQFhC/7nNqPCN9
         CYWLMwm29gsPi6E5bQcJjKNbO5D3oIqNmE4ToT8cUbKHhWUmprtEGJuD2sBv+kq6k66w
         ilMis+R1zkIjrQ9gz+Oe8NguyCStT+z95A5766K0UqZotNDhCZ83edFhMDuVgtZqA2Kx
         DzNoWhiUq5tLtUe0C9/q4Lh5qTMsRPC7eFteB4jUgoNiT1EXBgGXTTmzkD7QkOCxGL2t
         zCPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=tRKndvsJxnI8vCZJkO4ZuTxhY8qIoWTfzhPvGDqMb8U=;
        b=hXYVRGqKWryKWzljPioAZ7fgS5OT7/syQTvOaoC5zzFn+9hwSBQ0rHue64nKrgmYYA
         ge3TNfYfTVs2DQayX7x1FnIvCN1Jp3Erg0xwGxVNdsdEDXML0UE9SM7iyjSBuUY5yZkr
         QTFSW+8Em/MTTPewPkduRLNLG73hM+qEswHsI0AxluaFLu82f31kl7IZ4k72k0jH03m3
         1DubBGOoVmpTE2YM/7981VnHsgfr3fFyuU1Naz7IqV8exNiNgb1XY7TckIxgHyBecCI2
         TOtmuCTZ1C1Pr2WF6fzb2XEssqnSq5OezsHslhQBcjknXWEskJpviHEdMe1Q4HBKJzeT
         4z5Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jianlin Shi <jishi@redhat.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Stefano Brivio <sbrivio@redhat.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 3.18 19/21] net: ipv4: dont allow setting net.ipv4.route.min_pmtu below 68
Date: Fri,  9 Mar 2018 16:18:41 -0800
Message-Id: <20180310001802.292238473@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180310001801.045114869@linuxfoundation.org>
References: <20180310001801.045114869@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594507833206218413?=
X-GMAIL-MSGID: =?utf-8?q?1594507833206218413?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sabrina Dubroca <sd@queasysnail.net>


[ Upstream commit c7272c2f1229125f74f22dcdd59de9bbd804f1c8 ]

According to RFC 1191 sections 3 and 4, ICMP frag-needed messages
indicating an MTU below 68 should be rejected:

    A host MUST never reduce its estimate of the Path MTU below 68
    octets.

and (talking about ICMP frag-needed's Next-Hop MTU field):

    This field will never contain a value less than 68, since every
    router "must be able to forward a datagram of 68 octets without
    fragmentation".

Furthermore, by letting net.ipv4.route.min_pmtu be set to negative
values, we can end up with a very large PMTU when (-1) is cast into u32.

Let's also make ip_rt_min_pmtu a u32, since it's only ever compared to
unsigned ints.

Reported-by: Jianlin Shi <jishi@redhat.com>
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
Reviewed-by: Stefano Brivio <sbrivio@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/route.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -122,9 +122,11 @@ static int ip_rt_redirect_silence __read
 static int ip_rt_error_cost __read_mostly	= HZ;
 static int ip_rt_error_burst __read_mostly	= 5 * HZ;
 static int ip_rt_mtu_expires __read_mostly	= 10 * 60 * HZ;
-static int ip_rt_min_pmtu __read_mostly		= 512 + 20 + 20;
+static u32 ip_rt_min_pmtu __read_mostly		= 512 + 20 + 20;
 static int ip_rt_min_advmss __read_mostly	= 256;
 
+static int ip_min_valid_pmtu __read_mostly	= IPV4_MIN_MTU;
+
 /*
  *	Interface to generic destination cache.
  */
@@ -2629,7 +2631,8 @@ static struct ctl_table ipv4_route_table
 		.data		= &ip_rt_min_pmtu,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= &ip_min_valid_pmtu,
 	},
 	{
 		.procname	= "min_adv_mss",
