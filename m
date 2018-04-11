Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49x2h1frPab3sZ7L4K3/xMicHWCPcPSfY31a71rdREUx7HTAEDzMYS1wxWE22OTMHDy9YfL
ARC-Seal: i=1; a=rsa-sha256; t=1523472732; cv=none;
        d=google.com; s=arc-20160816;
        b=tlLu+ePzAhEmeJuhM+YdfvqoPNaifsu5xKIFOecQTohmZk07Qmm7edeqUaWzpAK3x7
         3vmZCyZ1Tgi/Fx1aMst04/u0lG+bv2p/O7pvderX7QZaOOp2r2ogE3zkCrwxVH/jpaxs
         WNwe8iSokKSiZ2EAw4yjxGtEKjY4KF1FzyimtqOEexBfTIFdsfT7MD6znbng79mW5Ck4
         hV8IUeyDW7jkSXlFaoWjjAC3cRFlBsuhlpE6GwnRPmSBV5K+BVeRk/6jd5Hg2BCM3Rm/
         mxEuiEnm0a8cf9oyxkT5def+c6YKBA9j2H35xwFWqJTtKRGdnSnnLSHLNhAfBhkz88Oc
         0lxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=cPwELSDHdHHEEzTXcPzJBnzyRaM0XPKpoxtq9mYhD+4=;
        b=BFDG2xkdgJzNKzualVar+mVtv3/jZA1f1ZfxdXI5WNjcRdUrQIDVZr9LhJqcsNHdEp
         Mdtw74L0kR7oM9X6HMxy9Dw9A/P8efbxxloFy/ZKnOdtfk2l7PehtKCEIrDpUnyU3Twn
         vTgy5gmyiuU+bLFJ9abMsrZ2qP5o5r+oAOgYqDiv2voubvd6hHnnFTlYNvjFY8sh5trX
         vaeR8oHmkh3K4FD5M/SFiApTSB7ccstulBmiq91nZQ5KkKgdEs/D2a4uQQXawtKiDa08
         RdGkiVLvLfZM9Qncwis1TDIDsi088SR2jhccAsVwfXSfdL3afLRwFEeA24kTa47i+EcH
         AUmw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Miguel Fadon Perlines <mfadon@teldat.com>,
	David Ahern <dsahern@gmail.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 190/190] vrf: Fix use after free and double free in vrf_finish_output
Date: Wed, 11 Apr 2018 20:37:16 +0200
Message-Id: <20180411183604.662211905@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183550.114495991@linuxfoundation.org>
References: <20180411183550.114495991@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476943629198552?=
X-GMAIL-MSGID: =?utf-8?q?1597476943629198552?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Ahern <dsahern@gmail.com>

commit 82dd0d2a9a76fc8fa2b18d80b987d455728bf83a upstream.

Miguel reported an skb use after free / double free in vrf_finish_output
when neigh_output returns an error. The vrf driver should return after
the call to neigh_output as it takes over the skb on error path as well.

Patch is a simplified version of Miguel's patch which was written for 4.9,
and updated to top of tree.

Fixes: 8f58336d3f78a ("net: Add ethernet header for pass through VRF device")
Signed-off-by: Miguel Fadon Perlines <mfadon@teldat.com>
Signed-off-by: David Ahern <dsahern@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
[ backport to 4.4 and 4.9 dropped the sock_confirm_neigh and
  changed neigh_output to dst_neigh_output ]
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/vrf.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

--- a/drivers/net/vrf.c
+++ b/drivers/net/vrf.c
@@ -550,13 +550,15 @@ static int vrf_finish_output(struct net
 	neigh = __ipv4_neigh_lookup_noref(dev, nexthop);
 	if (unlikely(!neigh))
 		neigh = __neigh_create(&arp_tbl, &nexthop, dev, false);
-	if (!IS_ERR(neigh))
+	if (!IS_ERR(neigh)) {
 		ret = dst_neigh_output(dst, neigh, skb);
+		rcu_read_unlock_bh();
+		return ret;
+	}
 
 	rcu_read_unlock_bh();
 err:
-	if (unlikely(ret < 0))
-		vrf_tx_error(skb->dev, skb);
+	vrf_tx_error(skb->dev, skb);
 	return ret;
 }
 
