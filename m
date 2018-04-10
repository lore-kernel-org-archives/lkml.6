Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48NV5vzTQJvUWjaEskf1gu384asHhbakYTMp1aNKr5T1V/AEC22StblYc0ZzSI6nFWpLL8K
ARC-Seal: i=1; a=rsa-sha256; t=1523399594; cv=none;
        d=google.com; s=arc-20160816;
        b=RimYK4A+QfBbjLWKfOBd+71HCwE338AuO+xGdugdNxn5LY4ze5UR2BElOkYwFlUhcW
         miMGe/osfJMeeI3RrMSQPrWTxGUbmyYRCLdEWTVxWmfsVMFw9nszrFTw5sjKG0PvS+J+
         qNQZ3KEOv8xHiOSpLHi5WvALtmgUrN70dv1sscP6AspigM3wJBuzMnVqUr5Y8eom8pqf
         ymrsTajW9/+ch0+tdHW3jsgx3Nr3ty/JEMay5wAwvWFJ4T0TnH+0iiZoOlCvjALG/1Fl
         e7ITQd4ZQGelKCoWmKz+Xy6FzWfds0pSDi1QH3rHHk06JBzW2lxXDKfCOFSLcFUMnrvb
         HL0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=/Bb1c+m3WbOvdTpYMqgjy8FP6fNzBq71s1v2ab+GIYA=;
        b=Y/dAfDvgSrz+cx/7fzXkLj27UrkCorTXngrkrmlD+Mdrvywh6mad+c7oajQNnRe/dH
         /ZCtT2sWLF2KA6mJ2Spp8GgsLnjJWSfbOddfhsWUIs4ae2tg9wdOV9YZ7ghI2SXyfTvL
         vADUxm4dKWrtkxXZe/QbEqeX5l95H3KdDCj2xvvL7VOV9wKm8YEvTGXpULxrTLJPSyeU
         n2pactkl6hGHrBQpVek20WGrA//2jNwFF7CYd6pBvduPUvOEfjc+Jh0LLrB6H0/nu3uT
         nGq84Ke1w/io80nWvgbuxMfCzy30hKyvXjTFyL6e6UrZ5AXuag0IXWT2NHLgSbTMHyu9
         aiMA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jianlin Shi <jishi@redhat.com>,
	Xin Long <lucien.xin@gmail.com>,
	David Ahern <dsa@cumulusnetworks.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.15 165/168] route: check sysctl_fib_multipath_use_neigh earlier than hash
Date: Wed, 11 Apr 2018 00:25:07 +0200
Message-Id: <20180410212808.247986797@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212800.144079021@linuxfoundation.org>
References: <20180410212800.144079021@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597400252666806621?=
X-GMAIL-MSGID: =?utf-8?q?1597400252666806621?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xin Long <lucien.xin@gmail.com>


[ Upstream commit 6174a30df1b902e1fedbd728f5343937e83e64e6 ]

Prior to this patch, when one packet is hashed into path [1]
(hash <= nh_upper_bound) and it's neigh is dead, it will try
path [2]. However, if path [2]'s neigh is alive but it's
hash > nh_upper_bound, it will not return this alive path.
This packet will never be sent even if path [2] is alive.

 3.3.3.1/24:
  nexthop via 1.1.1.254 dev eth1 weight 1 <--[1] (dead neigh)
  nexthop via 2.2.2.254 dev eth2 weight 1 <--[2]

With sysctl_fib_multipath_use_neigh set is supposed to find an
available path respecting to the l3/l4 hash. But if there is
no available route with this hash, it should at least return
an alive route even with other hash.

This patch is to fix it by processing fib_multipath_use_neigh
earlier than the hash check, so that it will at least return
an alive route if there is when fib_multipath_use_neigh is
enabled. It's also compatible with before when there are alive
routes with the l3/l4 hash.

Fixes: a6db4494d218 ("net: ipv4: Consider failed nexthops in multipath routes")
Reported-by: Jianlin Shi <jishi@redhat.com>
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Acked-by: David Ahern <dsa@cumulusnetworks.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/fib_semantics.c |   20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

--- a/net/ipv4/fib_semantics.c
+++ b/net/ipv4/fib_semantics.c
@@ -1746,18 +1746,20 @@ void fib_select_multipath(struct fib_res
 	bool first = false;
 
 	for_nexthops(fi) {
+		if (net->ipv4.sysctl_fib_multipath_use_neigh) {
+			if (!fib_good_nh(nh))
+				continue;
+			if (!first) {
+				res->nh_sel = nhsel;
+				first = true;
+			}
+		}
+
 		if (hash > atomic_read(&nh->nh_upper_bound))
 			continue;
 
-		if (!net->ipv4.sysctl_fib_multipath_use_neigh ||
-		    fib_good_nh(nh)) {
-			res->nh_sel = nhsel;
-			return;
-		}
-		if (!first) {
-			res->nh_sel = nhsel;
-			first = true;
-		}
+		res->nh_sel = nhsel;
+		return;
 	} endfor_nexthops(fi);
 }
 #endif
