Return-Path: <SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZp0niFYIVFZTyzHNulZVbbxvFYywfUpZGd3FB/Uq56uzFfzhYHdYUSeP2n1N1b9Lo1dJ6zN
ARC-Seal: i=1; a=rsa-sha256; t=1527155999; cv=none;
        d=google.com; s=arc-20160816;
        b=LSXkuwlVk3S9ERWGmIFUUHOBDd5KJDOH8tt+kCkjh5IY0oUNRqjaROGQ3Xk6xSqWHS
         bHLs/5Y0HjVifY7+OyB6smWk6xT2AuPz+SaLrmYISzELeFQLPTeCT4VxFCRB7n209M5B
         UgTpmwOPBjPiCMva4o8saW8/5Qw4bRm/r0K/4SIdTT32cb8O8EcixQ1S5aZMQgqzXAkl
         6q0M+z1kT++xER9cy/IFxkwTAgHB16zYN8pqV/1mRef1Y2SFmVYJnCAWAkBXDg8bSXp3
         qpYIF95oxMghhalKrHwnoECWoa4lVuuU0ofg6BR5c9atgNQCHetV8iXdvz1N5tcENqRP
         bcHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=/UsMwv1tDO6lEPIV5BmeOG/T7/X3+BPvO+Lr/aNT/6Q=;
        b=HIZFL/OypifkNMGpWcbOd4HHTVY7Mqbz35MOtGqtnmrjQhaWRZKmfSYp02UD2NRR2W
         PETHtrZtxguUtgPJTa1yVB0A8QSWwNgi1DVLTXN3D9i23w3Ehbd2aG9gzKjccAiHDngk
         XzDV95hviOYsvApn5wY0nQpLFtCfR/dnetjTe3fJimYk0lgj4lialuWeUAxgC/EHijWM
         7OJfklm+4h41VC6/cgWM3f9YrpMyisZfCjYnjP9Jx5fcQTS39AR2/T+kg9/pfrd6UrUt
         rIBvoO7Mbl1yf9oiFkyERL7Ebk/o1OwxyFYRmCJTEqExKzYv+M1SDOhi37a3bHQ6AwVj
         Ad1g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=j2n1vO8e;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=j2n1vO8e;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	syzbot+71d74a5406d02057d559@syzkaller.appspotmail.com,
	Willem de Bruijn <willemb@google.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.16 008/161] packet: in packet_snd start writing at link layer allocation
Date: Thu, 24 May 2018 11:37:13 +0200
Message-Id: <20180524093019.375532134@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093018.331893860@linuxfoundation.org>
References: <20180524093018.331893860@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601338239482107484?=
X-GMAIL-MSGID: =?utf-8?q?1601339129180717775?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Willem de Bruijn <willemb@google.com>

[ Upstream commit b84bbaf7a6c8cca24f8acf25a2c8e46913a947ba ]

Packet sockets allow construction of packets shorter than
dev->hard_header_len to accommodate protocols with variable length
link layer headers. These packets are padded to dev->hard_header_len,
because some device drivers interpret that as a minimum packet size.

packet_snd reserves dev->hard_header_len bytes on allocation.
SOCK_DGRAM sockets call skb_push in dev_hard_header() to ensure that
link layer headers are stored in the reserved range. SOCK_RAW sockets
do the same in tpacket_snd, but not in packet_snd.

Syzbot was able to send a zero byte packet to a device with massive
116B link layer header, causing padding to cross over into skb_shinfo.
Fix this by writing from the start of the llheader reserved range also
in the case of packet_snd/SOCK_RAW.

Update skb_set_network_header to the new offset. This also corrects
it for SOCK_DGRAM, where it incorrectly double counted reserve due to
the skb_push in dev_hard_header.

Fixes: 9ed988cd5915 ("packet: validate variable length ll headers")
Reported-by: syzbot+71d74a5406d02057d559@syzkaller.appspotmail.com
Signed-off-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/packet/af_packet.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -2903,13 +2903,15 @@ static int packet_snd(struct socket *soc
 	if (skb == NULL)
 		goto out_unlock;
 
-	skb_set_network_header(skb, reserve);
+	skb_reset_network_header(skb);
 
 	err = -EINVAL;
 	if (sock->type == SOCK_DGRAM) {
 		offset = dev_hard_header(skb, dev, ntohs(proto), addr, NULL, len);
 		if (unlikely(offset < 0))
 			goto out_free;
+	} else if (reserve) {
+		skb_push(skb, reserve);
 	}
 
 	/* Returns -EFAULT on error */
