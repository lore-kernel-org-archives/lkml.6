Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtRzUpQ5fotn7vFXBLCOTw3iNd3sbJoQxhh8h4KLim2nr2UqoTXtKaw2D2mwRW1ptD4Cgq4
ARC-Seal: i=1; a=rsa-sha256; t=1520641159; cv=none;
        d=google.com; s=arc-20160816;
        b=CDhH82LQGzuqdkW/t/YqpzyJkOeJEl3mSewdiFEqjpvEf8/cnSyyuWCOiXnE5UWAoG
         ZYDlEk0SueRcDslri1RMvafdm4pb6H7fVwuF5XhK7bd4O5ylf8kvmjWjvhSPS7D2tjFU
         XzF1UayWBzKRX7fauM7kLEuW8v80bHbeCNzpJ93kXwxxWarZkAFZEnIIbRvGPogZJFDH
         mcWTxTMJ1dptyNyYeyDmN53utn7E5u5bDXnwymWur1AG+7zQz3JjzUsNDkkGLyOjs8SM
         8bEFJnq8Lu+TiCOL7tpnkGXCbLUs7Cn7OldwBFOIwPxg0uSXi7PgBtvU7wfUg8FdSEVF
         650g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=rD2nMsXz1LzDisLAWI06qgt1Bu8DTPoayMowdSTvZGQ=;
        b=VvUW8LuUEuohxYypSfWxILWkLdHceGfdlBjtNKzm4B2ND65MXsbCNAJqbjLtLHmTuA
         BMlC7gaP5DNsePtOfP6dBiRWvGbJ+SY6hpOgSdssnbs95W7h/QBvS9sY5dSNvnJPaBa1
         ftMpAlQTrxm7vWij9rtf56CqFd3ujlo88hPNRKjAtD0fqY9SEI8QCO36+MhORSEYlSon
         +dFIAy3y6NfEY6h6aAnOOhv/o1rmLTXE15NrKvYlWaC2fLXQI9zaufe1Vor0SOf7V5dv
         8rWEXfTPP8+rnrXea0tBSAAI63/4iW8TYxW53ruH7OTmJN58UbbxZi9l+hrmY69T7Bvm
         wE3A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Alexey Kodanev <alexey.kodanev@oracle.com>,
	Neil Horman <nhorman@tuxdriver.com>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 3.18 15/21] sctp: fix dst refcnt leak in sctp_v6_get_dst()
Date: Fri,  9 Mar 2018 16:18:37 -0800
Message-Id: <20180310001801.988711805@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180310001801.045114869@linuxfoundation.org>
References: <20180310001801.045114869@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594507824174857982?=
X-GMAIL-MSGID: =?utf-8?q?1594507824174857982?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexey Kodanev <alexey.kodanev@oracle.com>


[ Upstream commit 957d761cf91cdbb175ad7d8f5472336a4d54dbf2 ]

When going through the bind address list in sctp_v6_get_dst() and
the previously found address is better ('matchlen > bmatchlen'),
the code continues to the next iteration without releasing currently
held destination.

Fix it by releasing 'bdst' before continue to the next iteration, and
instead of introducing one more '!IS_ERR(bdst)' check for dst_release(),
move the already existed one right after ip6_dst_lookup_flow(), i.e. we
shouldn't proceed further if we get an error for the route lookup.

Fixes: dbc2b5e9a09e ("sctp: fix src address selection if using secondary addresses for ipv6")
Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
Acked-by: Neil Horman <nhorman@tuxdriver.com>
Acked-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sctp/ipv6.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

--- a/net/sctp/ipv6.c
+++ b/net/sctp/ipv6.c
@@ -323,8 +323,10 @@ static void sctp_v6_get_dst(struct sctp_
 		final_p = fl6_update_dst(fl6, rcu_dereference(np->opt), &final);
 		bdst = ip6_dst_lookup_flow(sk, fl6, final_p);
 
-		if (!IS_ERR(bdst) &&
-		    ipv6_chk_addr(dev_net(bdst->dev),
+		if (IS_ERR(bdst))
+			continue;
+
+		if (ipv6_chk_addr(dev_net(bdst->dev),
 				  &laddr->a.v6.sin6_addr, bdst->dev, 1)) {
 			if (!IS_ERR_OR_NULL(dst))
 				dst_release(dst);
@@ -333,8 +335,10 @@ static void sctp_v6_get_dst(struct sctp_
 		}
 
 		bmatchlen = sctp_v6_addr_match_len(daddr, &laddr->a);
-		if (matchlen > bmatchlen)
+		if (matchlen > bmatchlen) {
+			dst_release(bdst);
 			continue;
+		}
 
 		if (!IS_ERR_OR_NULL(dst))
 			dst_release(dst);
