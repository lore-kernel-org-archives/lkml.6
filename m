Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227oly0FLbRDlCsO3HneWFYtsH2KBpg5wBM6skuTz6QXei0SDvzs+nyvozMbcJKQEzINdsF/
ARC-Seal: i=1; a=rsa-sha256; t=1518184033; cv=none;
        d=google.com; s=arc-20160816;
        b=XGyskvHDSZxGh4zROuqffB6CPHI9qfU6qDwGHXd+LXWDJlU0A+jw2pbfWvLClLcHkT
         6LZiuFuc480W4WQjh1L/Ul1TYFf4x0R2lEu1rqkzCwliZ2jvDIIfopt10z1HnR7bcy9T
         2gHjY0iO/r3URUe/oX8kmqRGY+919aLTN0KyYGacH39mT/qZR+PhJUBR1/78LcEAQRYg
         6n7QC4ZFRzdCEikax1heWSG0psTupBwvwdp26OeXx+y56nSJz8YYGXxJvlMSvTXAne7n
         6gUAQ3XcD9c62pt7NpOEqU0MCTcipWh5QVgwyDXrPNUN/uWXI2dV/nqqJd96XQuc2ozm
         xb+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=4wRl9CqA03B3h8g6lpEI9CZWf2qK0LwWm0REpoCdB4c=;
        b=qq6O5+t6X6Hmjbw9v2QfQ4VR1AITkc4Xh2VWZAUcDNdTwgxzzPUTUmtNizpQSnC9OE
         viaPejyXalsIDkpEy4JbjeQ0xb3YzCDOc4Q8v4EGnI39lAWmZOmlPlQn3vyGzIb89DEc
         VR+Ca2qaEwwgP1z30GisLjyXX9eQ/bK6KrHYZcve7W10NpTWquNsUaaf7LdjM6nXBjDP
         Yu/mlaTbBcfl0FO+o1EHxm0Fak9yW/tN44TbwW8nWFtXBmeG1N2ZvSWy9shdioiFs/af
         WkMSBQHPqdJYwjAKnrFVhpXmEfY6+wsjrlpqP61omByD/aiAr/CDoPUHkIYVeCPtEkXV
         eMlA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Wei Wang <weiwan@google.com>,
	Eric Dumazet <edumazet@google.com>,
	Martin KaFai Lau <kafai@fb.com>,
	Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.15 09/23] ipv6: change route cache aging logic
Date: Fri,  9 Feb 2018 14:40:07 +0100
Message-Id: <20180209133938.854044659@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180209133938.366024920@linuxfoundation.org>
References: <20180209133938.366024920@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591931341619920020?=
X-GMAIL-MSGID: =?utf-8?q?1591931341619920020?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wei Wang <weiwan@google.com>


[ Upstream commit 31afeb425f7fad8bcf9561aeb0b8405479f97a98 ]

In current route cache aging logic, if a route has both RTF_EXPIRE and
RTF_GATEWAY set, the route will only be removed if the neighbor cache
has no NTF_ROUTER flag. Otherwise, even if the route has expired, it
won't get deleted.
Fix this logic to always check if the route has expired first and then
do the gateway neighbor cache check if previous check decide to not
remove the exception entry.

Fixes: 1859bac04fb6 ("ipv6: remove from fib tree aged out RTF_CACHE dst")
Signed-off-by: Wei Wang <weiwan@google.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Acked-by: Martin KaFai Lau <kafai@fb.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/route.c |   20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -1586,12 +1586,19 @@ static void rt6_age_examine_exception(st
 	 * EXPIRES exceptions - e.g. pmtu-generated ones are pruned when
 	 * expired, independently from their aging, as per RFC 8201 section 4
 	 */
-	if (!(rt->rt6i_flags & RTF_EXPIRES) &&
-	    time_after_eq(now, rt->dst.lastuse + gc_args->timeout)) {
-		RT6_TRACE("aging clone %p\n", rt);
+	if (!(rt->rt6i_flags & RTF_EXPIRES)) {
+		if (time_after_eq(now, rt->dst.lastuse + gc_args->timeout)) {
+			RT6_TRACE("aging clone %p\n", rt);
+			rt6_remove_exception(bucket, rt6_ex);
+			return;
+		}
+	} else if (time_after(jiffies, rt->dst.expires)) {
+		RT6_TRACE("purging expired route %p\n", rt);
 		rt6_remove_exception(bucket, rt6_ex);
 		return;
-	} else if (rt->rt6i_flags & RTF_GATEWAY) {
+	}
+
+	if (rt->rt6i_flags & RTF_GATEWAY) {
 		struct neighbour *neigh;
 		__u8 neigh_flags = 0;
 
@@ -1606,11 +1613,8 @@ static void rt6_age_examine_exception(st
 			rt6_remove_exception(bucket, rt6_ex);
 			return;
 		}
-	} else if (__rt6_check_expired(rt)) {
-		RT6_TRACE("purging expired route %p\n", rt);
-		rt6_remove_exception(bucket, rt6_ex);
-		return;
 	}
+
 	gc_args->more++;
 }
 
