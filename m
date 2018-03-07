Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuWQKaHoiEbVN3kvB3hgiOpU2f63MgWsgpTL3/Lah8sv1nbvJoel34kjhNMmepoCcgpoZYc
ARC-Seal: i=1; a=rsa-sha256; t=1520451669; cv=none;
        d=google.com; s=arc-20160816;
        b=aoXYOsR2OP9eZB5wicvzbZlYH16peKVxTj8hIwV27daVsYFyMGH7XOdz6Y6xpc2Ct9
         utYVqPs3rO5dork99caf9rhmbq5DdRQWt+4kbKTL8+aT0d7uehOX3FHlFXUbfLLPTv7K
         jmEWUFY7z4dc7C7uMkSskKx0hKN1SRlhBO2sh3VO6r+Ye2kJL8LmQNLbnelbQ0wQAuls
         AlFKSIPAsiQ4ySmuxcmE3LH4wjYbsXnrji3AcZpnvkO3DFoJYXyOP8NbAUIXJrhUAcQ4
         QjTgrRN0/o6zHcQkz73iZJMT3PTI/Wc5MxCmUTgL0n7n+WMKzjHqPrJGwjlFEq7+owm/
         B0MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=clUGXujiYt3uRFJpdOSt5O1k2DzpjpL67iEKIR4MG44=;
        b=vmgFwq4n1Zrw0J5KenGnOokrcY57z4ujcliqR70f7y/3AYX1nDY9ADfwATYKpqURuu
         bY8MADOmczjHduhT7Qt/gGL6PQHglTUNAK3XajwIkDXgncwDvffynh7xjG+17ZirT9sV
         xJhCzvplVD9vEITRcVDDZ/y9TcoEBH8yOXu62armP+sd6rEUPMBDbWC3y80cWarKjrUn
         pOO3/ImMgUFPUXmt5KR8h23ZqeJSmsfxS6dBJjS/bijPNA0/MmJ3oGk+aEwmQNeGDYyy
         iH6rmj4pa/TsN9a6RJYHvr0jxZcfQb5htshzXqZEsmPAz1jHfCTCGgZXiEOImGDjuu0e
         UtzQ==
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
Subject: [PATCH 4.15 046/122] net: ipv4: dont allow setting net.ipv4.route.min_pmtu below 68
Date: Wed,  7 Mar 2018 11:37:38 -0800
Message-Id: <20180307191735.623449626@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191729.190879024@linuxfoundation.org>
References: <20180307191729.190879024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594309129773633488?=
X-GMAIL-MSGID: =?utf-8?q?1594309129773633488?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -128,10 +128,13 @@ static int ip_rt_redirect_silence __read
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
@@ -2934,7 +2937,8 @@ static struct ctl_table ipv4_route_table
 		.data		= &ip_rt_min_pmtu,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= &ip_min_valid_pmtu,
 	},
 	{
 		.procname	= "min_adv_mss",
