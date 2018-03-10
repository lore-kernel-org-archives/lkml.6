Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELun/W9lP/tVVW7Zbl7hXYr1ui4GMYjoztNn9FJ89zNfibVYm13IjdVmW1iDvOG98sXCSrCA
ARC-Seal: i=1; a=rsa-sha256; t=1520641319; cv=none;
        d=google.com; s=arc-20160816;
        b=mp3HgPzcic+j/Gq4zvoPsRHN9ntKQYyXUHLeP8WLSWtvVy+kgVjG5LoQ+eFxDWZZDo
         yknx8e7dCykAjTzKYfKSDKDc3B5BxAxegsQFkjeqKNMiTVQemPsojSukZnYjFYynwiCl
         He4h4yiYCLTzC5cj78IgqN8SlNNXNuc615jYjNLI8WqT4tDQGgAHMNRBK+OpfrWC6xgH
         DE+ZWWfns8wg9R6fXS5MJd8OFydFK7wKOwtc1COMnq2AMZpynZjlG++6UCdeZf4A8Kw8
         vr2GLxpDri26FPdPA2q5eC2bhF/AzUYVLRbdA4ZY522eDRwDnyxLPHAqcE48c0GAGZyK
         4vPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=WXqHqCOWTSQ5rQrZJqb6HOqguu0NGEgY3EWaOL5AMQw=;
        b=Q+eZqjogaRQWHfh0d1JgWSBN05w7tdRH8DjK+zdYzbGjhni82g0/0HUMCkNl8NSzBW
         SHtcB4MI+h+6Nnv/x72C2G/NsRChA1iySW2ZF/8I/OtfslIaTTvNVOw75R5KKdFU3iwS
         q8L1HHL/jAxCO7Jv32vDkW0GrK7G8ibFbwuXN97cgC4KYPkhvU0G55g4T01kxuDp0JIm
         BvzfO4pMCL+Se7BIV7FYSsfv0MR+29NenwgniCEBq0RRyE6IgSFANb4S/t2qKeWk5vDm
         FTi9IMIMuwQEAbxsOU4wSj7LHyKS66WrWQS4ihiOX6+W3hvdncMZyYalkrUDI+NY3lIT
         veUA==
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
Subject: [PATCH 4.9 38/65] net: ipv4: dont allow setting net.ipv4.route.min_pmtu below 68
Date: Fri,  9 Mar 2018 16:18:38 -0800
Message-Id: <20180310001828.061558481@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180310001824.927996722@linuxfoundation.org>
References: <20180310001824.927996722@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594507833206218413?=
X-GMAIL-MSGID: =?utf-8?q?1594507992535281451?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
 net/ipv4/route.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -126,10 +126,13 @@ static int ip_rt_redirect_silence __read
 static int ip_rt_error_cost __read_mostly	= HZ;
 static int ip_rt_error_burst __read_mostly	= 5 * HZ;
 static int ip_rt_mtu_expires __read_mostly	= 10 * 60 * HZ;
-static int ip_rt_min_pmtu __read_mostly		= 512 + 20 + 20;
+static u32 ip_rt_min_pmtu __read_mostly		= 512 + 20 + 20;
 static int ip_rt_min_advmss __read_mostly	= 256;
 
 static int ip_rt_gc_timeout __read_mostly	= RT_GC_TIMEOUT;
+
+static int ip_min_valid_pmtu __read_mostly	= IPV4_MIN_MTU;
+
 /*
  *	Interface to generic destination cache.
  */
@@ -2772,7 +2775,8 @@ static struct ctl_table ipv4_route_table
 		.data		= &ip_rt_min_pmtu,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= &ip_min_valid_pmtu,
 	},
 	{
 		.procname	= "min_adv_mss",
