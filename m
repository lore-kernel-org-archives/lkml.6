Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvIROHQcKzDZVdPm6Oz2bLJVlv5MgBAdaHyEKIhqEfU7GzhLXggR8mv1t+hYcg6ae3UsMN3
ARC-Seal: i=1; a=rsa-sha256; t=1520641311; cv=none;
        d=google.com; s=arc-20160816;
        b=AAJMArYftO4M3bRyfF0H9SCXYpiB+Li6vttvkhH9AdbDLcT64XblmMG17uV7061R5F
         6XI5fHTijOqy+F7dh6npkLri3DJJzJ0y/qTMVfZ2mw/5eKgQRTzTAxq4DY9tm6H2CDIX
         fl+FkuBMYKwDTc/bS3M6ySWp+YJ+fu4pTKmeglgnj/vJPrZzsvfA+5Yna80HAlwg96no
         408nuYOzXU5JNJPr6DrhIfR7CLcyowIcds3AI3aoqybyRV/QRblmNzOCubCG+mCIuqCo
         4Tv1K+mKhS0GV2gDj+1xLc3coOsL0i58k/xqbS5+m1eZmTITBycoglig2LeWMGdgkQoj
         RjrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=NZhu3MuHcRLtQOFp4KfbpCediTvVSxq4Varm3hob34U=;
        b=XfFyay8YX2aSA2hfAQg6xk7/c3OBz6wYef7nEAcCSmWfR2DCZPcGs0zvq+sJ+3U6uK
         Xyf3MXaHg4cAh0Bw5t2dImV3wQbRTBS2eR3a7TnxET64X4/m1TJVFmwO0ZNowclZXT0R
         Lm9Ai+nK/l0EmMuAfCCrkYfDTa9TqXTvYakiVR3jjtAePIuewobGOjRrJViF43UgEz3O
         KGvgP8y8prUDW8mHEHY3DLbojNiAbRtxMWOCo4otkJyHvEyiH1/zvajAjEIcywUouZxq
         +xo1nCc4f3lJlmGjibxmSlDVF0LAPM7I0Nb+d3+PxjxTG43PwhmYOb90OZTwWvE6KgbW
         rxyw==
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
Subject: [PATCH 4.9 34/65] fib_semantics: Dont match route with mismatching tclassid
Date: Fri,  9 Mar 2018 16:18:34 -0800
Message-Id: <20180310001827.701835041@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180310001824.927996722@linuxfoundation.org>
References: <20180310001824.927996722@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594507835006519942?=
X-GMAIL-MSGID: =?utf-8?q?1594507983745843248?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -640,6 +640,11 @@ int fib_nh_match(struct fib_config *cfg,
 					    fi->fib_nh, cfg))
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
