Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsajq5umNV9R1/6CXNH3hT35dFgMdoPWqefPTO23oQ9TzLiHhGFrry4ITX0OlgCD5ZI3r/9
ARC-Seal: i=1; a=rsa-sha256; t=1520641169; cv=none;
        d=google.com; s=arc-20160816;
        b=ubtXQth/GQ6X7EVGoJ/rLQV01hvBJpbI2mqSyROdWsrl+5MUYZsLbraEYba67r6GTW
         hpMkPxU3BuZNe2ZLgTFr+ADkmFZ3GH35r63b0EXc1XofJmW+S8RHLBLsZNi2a+P8JQGk
         rvJCfRODX/bX23oCoX7yQG5eA0kiv0vZVtUTJr9VerpU8PobJmmj9kg0Uzcujpb4l0Hn
         SFl7+kB4qgBA8nrPbx3hv3Croa/wBNDBiEsLAa1Z7CvJQO1j7ILXHeiPIqqLPMiZM2Fd
         stLVgpeKXgWxXKQSIGsdjOnJZn3SaEEVhS3oGIsxv0S5L74Tl+582rn2IuuxeBoJewrX
         yTpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=7B9uDJ06q/ohNWcNLJceWs8Fllus85GgkM/aepzCx+0=;
        b=VPqwul+YLnmh3BJ5zRK1fUHKSf7UmkGwGjHCU1CWIgVdYyun6rfkNqtIE+hO7zTiir
         2JBTIA8woRFLkT6JEMtU4cLs/9e7EQ+yxvlz41NEbpIlTejmrEe/yQotZdcD9fYGYIHY
         FzgeBjTUxxzUBmfkKWAct4wQT4jRKarKQiEQrooox1Rek8WjNyMs2jCRL2yiFlxrx+0E
         kU0MUvMOexd9RiiaQ9oJwXZuSIb567z/ggq2OjIsNwz7GCNMG9kicr92lpYroZfK/2yb
         Lscurkhd5YTpkxg6xMI4KzbOdWz00w1bANf+TY8yw3qI9PQi2ioKMOnnoN7INtKER++C
         885Q==
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
Subject: [PATCH 3.18 20/21] fib_semantics: Dont match route with mismatching tclassid
Date: Fri,  9 Mar 2018 16:18:42 -0800
Message-Id: <20180310001802.359603741@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180310001801.045114869@linuxfoundation.org>
References: <20180310001801.045114869@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594507835006519942?=
X-GMAIL-MSGID: =?utf-8?q?1594507835006519942?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -514,6 +514,11 @@ int fib_nh_match(struct fib_config *cfg,
 		return 1;
 
 	if (cfg->fc_oif || cfg->fc_gw) {
+#ifdef CONFIG_IP_ROUTE_CLASSID
+		if (cfg->fc_flow &&
+		    cfg->fc_flow != fi->fib_nh->nh_tclassid)
+			return 1;
+#endif
 		if ((!cfg->fc_oif || cfg->fc_oif == fi->fib_nh->nh_oif) &&
 		    (!cfg->fc_gw  || cfg->fc_gw == fi->fib_nh->nh_gw))
 			return 0;
