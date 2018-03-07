Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsZiV2TnZfVJrZv8N9d4pYtX8ZKwN8TUdiNz+yuqtA4VPbq9rXqWkEF4QlgrJioamZDZBdt
ARC-Seal: i=1; a=rsa-sha256; t=1520451717; cv=none;
        d=google.com; s=arc-20160816;
        b=pQrkzTfClR1ykGA9wHZI8BHYxgZxqQyBxxjaCde3NO88+HsSvtG6YSwN6cN3yDWHop
         65lmDJiS7g1jnGyfG+nM6sZaWg82QeaKBHhsEvRJIUwZR7j5Y6Ohs9OA5PvDdK2M945y
         WMLjeM0hXU4gVctaIxyH7IYl/pVjbbW9p5eltiuiI5MIB3dg6ifJsY1qig7YxrMkPNyd
         Uy6uWx4uzFo8MQt64odNFDulvGSePEct5dn3anQvOW3phdpyeKgpHpKJtTKvkwTbbMa0
         WOIi5heAdcYce1Q1/EJQ86Docg37nAIuPCLbnVXuvrvhQW4SEWFZ2VhClc4la36ZkqAc
         JLsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Zmp1vpmimU1gE0qJ84w8vMl+NjqDQyipM3OOa9XgDEE=;
        b=slVYN1AzfVjtSz7kMU/e1oJPXIzS9KecWE+FSuWI+5uwHPriRSMLdaGRoODocK0I/V
         728W+/0BPibC8DpgCb4kBm/ffT8a27FtZ5vr23v2mxdeXKfkfofI031QH5/jAR8EUvKm
         IhCLG+ZzRL4XLNUmp67ogwstbkFzlJg2MndFR2MRccuYS/bVztJLgJ5F5V/JfdkPFKFQ
         D+h83YmZJQlcysofxhfShuTRcSP9weio4b8s3+k2LLQCCzLFpgCV9OCQfaj4PlaAgpGw
         QjsNs8OaE5pkw/eap2n8pGdFAMdbNfWS/Vv6Q9XzDvkRm9GmKR55bIhSILX4Ks9fYk4g
         JEQw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Ido Schimmel <idosch@idosch.org>,
	David Ahern <dsahern@gmail.com>,
	Nikolay Aleksandrov <nikolay@cumulusnetworks.com>,
	Ido Schimmel <idosch@mellanox.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.15 066/122] net: ipv4: Set addr_type in hash_keys for forwarded case
Date: Wed,  7 Mar 2018 11:37:58 -0800
Message-Id: <20180307191738.892964775@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191729.190879024@linuxfoundation.org>
References: <20180307191729.190879024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594309179524668168?=
X-GMAIL-MSGID: =?utf-8?q?1594309179524668168?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Ahern <dsahern@gmail.com>


[ Upstream commit 1fe4b1184c2ae2bfbf9e8b14c9c0c1945c98f205 ]

The result of the skb flow dissect is copied from keys to hash_keys to
ensure only the intended data is hashed. The original L4 hash patch
overlooked setting the addr_type for this case; add it.

Fixes: bf4e0a3db97eb ("net: ipv4: add support for ECMP hash policy choice")
Reported-by: Ido Schimmel <idosch@idosch.org>
Signed-off-by: David Ahern <dsahern@gmail.com>
Acked-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Reviewed-by: Ido Schimmel <idosch@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/route.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -1832,6 +1832,8 @@ int fib_multipath_hash(const struct fib_
 				return skb_get_hash_raw(skb) >> 1;
 			memset(&hash_keys, 0, sizeof(hash_keys));
 			skb_flow_dissect_flow_keys(skb, &keys, flag);
+
+			hash_keys.control.addr_type = FLOW_DISSECTOR_KEY_IPV4_ADDRS;
 			hash_keys.addrs.v4addrs.src = keys.addrs.v4addrs.src;
 			hash_keys.addrs.v4addrs.dst = keys.addrs.v4addrs.dst;
 			hash_keys.ports.src = keys.ports.src;
