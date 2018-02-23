Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224AtddpK/XebQfhL13fqwIrSrf4OiCLxEMRIOtIy9OYoYYVZrnPgWNd4J6/7l2qs291CG4N
ARC-Seal: i=1; a=rsa-sha256; t=1519411848; cv=none;
        d=google.com; s=arc-20160816;
        b=fW1iCyDTTxPXhK27sSuQ4Bm2LKmXXCsKUZ5B6dncWTnnA5epIs/FEqPJpK/Pge8Ivc
         qyhgr5DcPg13Ui8D5sE/ACbBTOAV4f51DtiNo/mPOUn/LbwjKp59zt2kzj1lHqMGywjG
         ZerxMDNMXCVLcQXBsOPPkGz88yRPYJVFQlUnVtraYPMzykHs5fUSf5ltrRv+ykMzoS+L
         2A9J62LEAolgqQePm6zkAw8/OsZoThtSsUv9DhzmV/S/daKq+ASvWF+pghky6wIF33iy
         31kigUhFAUCwsqJQfRpQkRvs/il124wv5tX3ESWFoFlWT9QqTkyX8me45Rns5t3ylf0b
         0oQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=z3EixmaILFh/4ahG3aVOAya7q9fBu5TVGSJ+8dYvRKQ=;
        b=wT/UM9eZiMzZ6FWipd4k+aetM2hRa6ahDKKGqXs8Lc61JjklftYaX3uXeLdb8dBPCk
         0dctSiDL6/tuz+3mKY1G2NLwUK8HI9fIYtyRTZh4xS4pyz92SETH5XrmCFKqBHyMKPFs
         yqbjmbs39YGX6pIFKcapUgdJP036RDP3fJluYOnTjcgDUJhRIXfTiX2kt0pbi/ou6IMU
         LkcvZbaoZawMb0R2nnXu8k2VFm2Vq4QGVwpdRVEDRNy20fvI0E2093+Ed1PPTyEWfRHT
         0MuDRvc1JTrSeMlMC9wPzW5O2mSY9EzwJ7l7be8alMluUPyndFO75MgjZ0dNJ6Q/oTtw
         hZTA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	syzbot+82bbd65569c49c6c0c4d@syzkaller.appspotmail.com,
	Steffen Klassert <steffen.klassert@secunet.com>
Subject: [PATCH 4.14 008/159] esp: Fix GRO when the headers not fully in the linear part of the skb.
Date: Fri, 23 Feb 2018 19:25:16 +0100
Message-Id: <20180223170744.204315864@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170743.086611315@linuxfoundation.org>
References: <20180223170743.086611315@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593218799101377250?=
X-GMAIL-MSGID: =?utf-8?q?1593218799101377250?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Steffen Klassert <steffen.klassert@secunet.com>

commit 374d1b5a81f7f9cc5e7f095ac3d5aff3f6600376 upstream.

The GRO layer does not necessarily pull the complete headers
into the linear part of the skb, a part may remain on the
first page fragment. This can lead to a crash if we try to
pull the headers, so make sure we have them on the linear
part before pulling.

Fixes: 7785bba299a8 ("esp: Add a software GRO codepath")
Reported-by: syzbot+82bbd65569c49c6c0c4d@syzkaller.appspotmail.com
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/ipv4/esp4_offload.c |    3 ++-
 net/ipv6/esp6_offload.c |    3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

--- a/net/ipv4/esp4_offload.c
+++ b/net/ipv4/esp4_offload.c
@@ -38,7 +38,8 @@ static struct sk_buff **esp4_gro_receive
 	__be32 spi;
 	int err;
 
-	skb_pull(skb, offset);
+	if (!pskb_pull(skb, offset))
+		return NULL;
 
 	if ((err = xfrm_parse_spi(skb, IPPROTO_ESP, &spi, &seq)) != 0)
 		goto out;
--- a/net/ipv6/esp6_offload.c
+++ b/net/ipv6/esp6_offload.c
@@ -60,7 +60,8 @@ static struct sk_buff **esp6_gro_receive
 	int nhoff;
 	int err;
 
-	skb_pull(skb, offset);
+	if (!pskb_pull(skb, offset))
+		return NULL;
 
 	if ((err = xfrm_parse_spi(skb, IPPROTO_ESP, &spi, &seq)) != 0)
 		goto out;
