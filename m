Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227rrjLFSr30GOooL9ye0ca2eLHsH5hsyAoz7cxlWZFNi1BiVuNbS5gqoqHbuO5P1Ml1NXaZ
ARC-Seal: i=1; a=rsa-sha256; t=1519412264; cv=none;
        d=google.com; s=arc-20160816;
        b=Mara6kaRkl6XYitPKmzeIujtnuNoMP2LcPn4qPJDBl0QT1RrktrJS/UzQIUpS16oTG
         GWEcmcRrI8X74ZlWLQ+mysCVh3prW8PFWRdXQgG6r5inq/J6QQA9Byj/v877/FiIqrum
         UVNu4kBgnJiFxLyrzqXdzmPvPpJpIDP9yBIkv7z/7AVdzoRIjl7Q3lhXHo0U2JZNv+zv
         xBs9k3WO0LHrawWoxpAKDpPG7BiQ2gTC8Egz3AB0OR3B0XOYsOYEuqm3z0On1kulfu9Q
         5ZJ/Qic0QZoToHNPaAOrZYJN7JTH4Y98fVeGj1NRbzbpWlE2XbAcbJW93QFVXne8iKew
         S/uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=k5ephP0mqIYX4nNvg1A/3LXFOkNpFu1AvWuWiZeFc20=;
        b=tyJdtbsKw7HFMX+tBLuOrXQwO/r2RuzXV4WWxKYqQOUL5es1Tc74ieClDz+uUiMNad
         nhK4mdG7eMmcIKGs/UZdVZiplDaKYZQ3p4vXe2texQAcwQSFkT86xo1/Cfl+7HeRPieJ
         XiTx/dugCG7DoyCPCJ0WivrafiMiVn2SMIxliRvWE4uM0Q/2j8QzBReB6+1t37clF8H4
         2cM+OBOE14JRTHaVZYPpG8nQce1iYrL6wV5QnxxVICCa60NUgp1/Qu/GLn00MyXYKY9k
         g2Djo+AAGYjdwYQ9Rn4HAsYDsGMUlnCuqzdWAHHQhFCxnfAFde4WRWoDDjemEoEGfem0
         qmqg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Willem de Bruijn <willemb@google.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.15 21/45] net: avoid skb_warn_bad_offload on IS_ERR
Date: Fri, 23 Feb 2018 19:29:00 +0100
Message-Id: <20180223170718.659713182@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170715.197760019@linuxfoundation.org>
References: <20180223170715.197760019@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593217549729214691?=
X-GMAIL-MSGID: =?utf-8?q?1593219235060050361?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Willem de Bruijn <willemb@google.com>

commit 8d74e9f88d65af8bb2e095aff506aa6eac755ada upstream.

skb_warn_bad_offload warns when packets enter the GSO stack that
require skb_checksum_help or vice versa. Do not warn on arbitrary
bad packets. Packet sockets can craft many. Syzkaller was able to
demonstrate another one with eth_type games.

In particular, suppress the warning when segmentation returns an
error, which is for reasons other than checksum offload.

See also commit 36c92474498a ("net: WARN if skb_checksum_help() is
called on skb requiring segmentation") for context on this warning.

Signed-off-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/core/dev.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -2815,7 +2815,7 @@ struct sk_buff *__skb_gso_segment(struct
 
 	segs = skb_mac_gso_segment(skb, features);
 
-	if (unlikely(skb_needs_check(skb, tx_path)))
+	if (unlikely(skb_needs_check(skb, tx_path) && !IS_ERR(segs)))
 		skb_warn_bad_offload(skb);
 
 	return segs;
