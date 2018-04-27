Return-Path: <SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpiRhfxpswhvNerBNueIUi1Xckh2BdiYK6ffpMvS70V7hML7ya/c3BexC0z0/x+Vto/ZpRI
ARC-Seal: i=1; a=rsa-sha256; t=1524838306; cv=none;
        d=google.com; s=arc-20160816;
        b=wqc1aWBkQtjOc3OnxBGnga7HI8ZCN/WbUc6Pl2oQpLrnZndElqSinBDIA/0BOALz6l
         CM3O4ISOjHbJdrUxY20f/jLVoMrmpMKBXg0htBK6ofF2iggbRJ4boo5eRyZcFHNJcr05
         GWCqH6UTSN0K7aHY1RnpoQi7tVodYWz7V+BcKHZC3wa8hxT+AiE4QOLL027TnU0bYFvg
         ogOe87F697N62nuNZTevOdKxFVFJKZYFJw2Of/0ajJq/G7+tAHUVbZhUBptxfmbeK79V
         vbagH7P/l0xQboZEpOEF4KyNk7kNW0XoA3+oro3wbbyZCxROGkg57D+tylbmPAf6kaAx
         8L0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=+n0/QmuS4Flv0caZC0Vdr3GzUChIK5y1tjTwaIMpEJg=;
        b=H4k5DKtqwMXrApIUIIJkSwMpm7+fblpiwwePPVEVHZst9H60s837az7Ui2SO81VmAS
         GPUxjdHkn2bvSMaARqrmatjY8hdrARInXqG04pVBtaG0onDKCy06cQ8c4WJZntj7OFXV
         5oiLENMMk6ld3Bfyr2v7cMMJwxegCBasEFdWxFKrgpyzKuuLrrTIOhEsw8Qr8vdAxhgw
         Y4Uc6/rXZaJ9APOgHUn6qJkgcQzyNVKqyvnCvOPpSoJqfDKXDkIikXR4C3FYOnnTxpyS
         LVGHZ6Ci0SOgZsn5hNe9h0PODn83S0c+XM6I4r7ElUu3XpuMqS2xVVh+ZxGcKonU30Mi
         c4DQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02F3421892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jason Wang <jasowang@redhat.com>,
	=?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.16 56/81] tun: fix vlan packet truncation
Date: Fri, 27 Apr 2018 15:58:58 +0200
Message-Id: <20180427135746.547013427@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135743.216853156@linuxfoundation.org>
References: <20180427135743.216853156@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598908852055639941?=
X-GMAIL-MSGID: =?utf-8?q?1598908852055639941?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "Bjørn Mork" <bjorn@mork.no>


[ Upstream commit 81c895072d29cd70eea5be1a8587cd6461c3715a ]

Bogus trimming in tun_net_xmit() causes truncated vlan packets.

skb->len is correct whether or not skb_vlan_tag_present() is true. There
is no more reason to adjust the skb length on xmit in this driver than
any other driver. tun_put_user() adds 4 bytes to the total for tagged
packets because it transmits the tag inline to userspace.  This is
similar to a nic transmitting the tag inline on the wire.

Reproducing the bug by sending any tagged packet through back-to-back
connected tap interfaces:

 socat TUN,tun-type=tap,iff-up,tun-name=in TUN,tun-type=tap,iff-up,tun-name=out &
 ip link add link in name in.20 type vlan id 20
 ip addr add 10.9.9.9/24 dev in.20
 ip link set in.20 up
 tshark -nxxi in -f arp -c1 2>/dev/null &
 tshark -nxxi out -f arp -c1 2>/dev/null &
 ping -c 1 10.9.9.5 >/dev/null 2>&1

The output from the 'in' and 'out' interfaces are different when the
bug is present:

 Capturing on 'in'
 0000  ff ff ff ff ff ff 76 cf 76 37 d5 0a 81 00 00 14   ......v.v7......
 0010  08 06 00 01 08 00 06 04 00 01 76 cf 76 37 d5 0a   ..........v.v7..
 0020  0a 09 09 09 00 00 00 00 00 00 0a 09 09 05         ..............

 Capturing on 'out'
 0000  ff ff ff ff ff ff 76 cf 76 37 d5 0a 81 00 00 14   ......v.v7......
 0010  08 06 00 01 08 00 06 04 00 01 76 cf 76 37 d5 0a   ..........v.v7..
 0020  0a 09 09 09 00 00 00 00 00 00                     ..........

Fixes: aff3d70a07ff ("tun: allow to attach ebpf socket filter")
Cc: Jason Wang <jasowang@redhat.com>
Signed-off-by: BjÃ¸rn Mork <bjorn@mork.no>
Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/tun.c |    7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -1094,12 +1094,7 @@ static netdev_tx_t tun_net_xmit(struct s
 		goto drop;
 
 	len = run_ebpf_filter(tun, skb, len);
-
-	/* Trim extra bytes since we may insert vlan proto & TCI
-	 * in tun_put_user().
-	 */
-	len -= skb_vlan_tag_present(skb) ? sizeof(struct veth) : 0;
-	if (len <= 0 || pskb_trim(skb, len))
+	if (len == 0 || pskb_trim(skb, len))
 		goto drop;
 
 	if (unlikely(skb_orphan_frags_rx(skb, GFP_ATOMIC)))
