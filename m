Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsQxqqlQAaHkjFSkRGaodvEOWfZ5f73ZhV0k58A/a9htIQ+bPylHlAifYShiFbtIweUycH2
ARC-Seal: i=1; a=rsa-sha256; t=1520451932; cv=none;
        d=google.com; s=arc-20160816;
        b=M8U+lHILPX8bppfcgVyGjdaPc1OKSYWsrSMgScJvFjNUiLohTRDlzEaFxAi33R8G6Y
         YcskYhO7MlBSNruGqPVNwW7+MB2ew7KGQcgQXuWEWiP+9xEZb9Onb3UR3Tmn+4+5ekBP
         7UhDBl8r20wF7hGqY5CaLmJ/avgTJrgtiCKr2vrEnkaNk6A46W6imtbGMmEkvUZNQJv8
         qpXuNtv5LS8YCAWl+ux1WNVEnFMTL8tjD0b19soVEp2K+81U4CRmuUGS5LUxgWO/aJKq
         0jpCBYUbr/zhZ8jvs9Onknd1N79IKMNPsBF2pzOxGrTct/v9NcveKh/FofGO47amrxcf
         /wVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=b/C26Ly8X9t6JuRGnAtQ0MooyZ5FLOAXG/s4T5eUkUI=;
        b=gttz4Cw2IHygmSQNrxTxypiM9hwzlQ68tjmL8RkbVHlEAvfLvOY73eQjLD7tBJIIvX
         FylY4ovGJYxAzlQe5p3rQI3H4LUJH/WBpQ3YwOAbg+VjeUWqTe40DbNs3rnD7fM2SEAQ
         cwW10MNXQpkUKwhwWtcq9KDWanpt/ZHxgOd0DNVbxbhWHTIxT07HpeG78/hZFbxJLt8E
         L7Ct5JdggW9rEAW8/TwmnkYcLGqYobSU9/5+7b8t1jIWu2wnHAx/qaIwMbFZkCbc4oDG
         0DjJODiaax40LxbCVQgzf7GBdKfiL7ImNE7E+GyJqgGrD4O/ELuVsyFltYUUVE8GMp2M
         HN8w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jianlin Shi <jishi@redhat.com>,
	Stefano Brivio <sbrivio@redhat.com>,
	David Ahern <dsahern@gmail.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 035/110] fib_semantics: Dont match route with mismatching tclassid
Date: Wed,  7 Mar 2018 11:38:18 -0800
Message-Id: <20180307191044.258297415@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191039.748351103@linuxfoundation.org>
References: <20180307191039.748351103@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594309206599443413?=
X-GMAIL-MSGID: =?utf-8?q?1594309404749948878?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stefano Brivio <sbrivio@redhat.com>


[ Upstream commit a8c6db1dfd1b1d18359241372bb204054f2c3174 ]

In fib_nh_match(), if output interface or gateway are passed in
the FIB configuration, we don't have to check next hops of
multipath routes to conclude whether we have a match or not.

However, we might still have routes with different realms
matching the same output interface and gateway configuration,
and this needs to cause the match to fail. Otherwise the first
route inserted in the FIB will match, regardless of the realms:

 # ip route add 1.1.1.1 dev eth0 table 1234 realms 1/2
 # ip route append 1.1.1.1 dev eth0 table 1234 realms 3/4
 # ip route list table 1234
 1.1.1.1 dev eth0 scope link realms 1/2
 1.1.1.1 dev eth0 scope link realms 3/4
 # ip route del 1.1.1.1 dev ens3 table 1234 realms 3/4
 # ip route list table 1234
 1.1.1.1 dev ens3 scope link realms 3/4

whereas route with realms 3/4 should have been deleted instead.

Explicitly check for fc_flow passed in the FIB configuration
(this comes from RTA_FLOW extracted by rtm_to_fib_config()) and
fail matching if it differs from nh_tclassid.

The handling of RTA_FLOW for multipath routes later in
fib_nh_match() is still needed, as we can have multiple RTA_FLOW
attributes that need to be matched against the tclassid of each
next hop.

v2: Check that fc_flow is set before discarding the match, so
    that the user can still select the first matching rule by
    not specifying any realm, as suggested by David Ahern.

Reported-by: Jianlin Shi <jishi@redhat.com>
Signed-off-by: Stefano Brivio <sbrivio@redhat.com>
Acked-by: David Ahern <dsahern@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/fib_semantics.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/net/ipv4/fib_semantics.c
+++ b/net/ipv4/fib_semantics.c
@@ -654,6 +654,11 @@ int fib_nh_match(struct fib_config *cfg,
 					    fi->fib_nh, cfg, extack))
 				return 1;
 		}
+#ifdef CONFIG_IP_ROUTE_CLASSID
+		if (cfg->fc_flow &&
+		    cfg->fc_flow != fi->fib_nh->nh_tclassid)
+			return 1;
+#endif
 		if ((!cfg->fc_oif || cfg->fc_oif == fi->fib_nh->nh_oif) &&
 		    (!cfg->fc_gw  || cfg->fc_gw == fi->fib_nh->nh_gw))
 			return 0;
