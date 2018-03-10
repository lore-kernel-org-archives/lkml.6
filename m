Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELs5rPzoYbjQWiTJ2hNiz2mBBfKv8i6/tY1HH9oF309a1PIaGMduc9QLgynkONVDLvn+QNlW
ARC-Seal: i=1; a=rsa-sha256; t=1520641361; cv=none;
        d=google.com; s=arc-20160816;
        b=ck+o7/KXfQUroJCEe+oJLVS5BUFFMChvd3QChd4p2JDEpnQOtE7FsCnSfUGEkHlH3t
         2ROTxHwjCCZjoGW6dOOyhE2J3IBjYBq9Nm0tDGSyY6ceSnH9nXbzCuMCeztxCO2znN/A
         w8bNiNDAjDfFqzLa5+TSBJdN04yzCWke7E7ZP7M8TDaSuyUn6DqHecuBQaC+JEYOCvhh
         ARTh9JEzP9eEd9qvqN6HDX5pDjU8CyZ5KGBcrzECjPMD/hmBOfwxZeWOMptXFfr+15QG
         AsnVARHNoUylfOzRTh1Y3bwIcBgZTv136cgNl81+lYJs1mtDZasYGvshU8Cj4F8A8ziF
         nhCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=XD+bHhcUlO3BxM0FMDEfjashHITOpl7zPwjLq2qdozw=;
        b=SDEgD60a5ozooF7DGSRhMbYPE2pT4gbENB87aWcd/iInixgw6O+kL0Wb5OMZGhyaUg
         ZP226ixdSLybcTqi0PoWVb3u+1wMSaotSeJ3+7ojdCWJVGkUKCiadQpcVi7iIVfNggva
         Zvt/8SAOvX/yOs4VihTdpZbgAuyU5F2LO/zHx7GKOavMDd3RPZBC9L87VUy8vVf068vG
         cXEa6ywUsTbkkTX3u7Py/N78PtlvMYxE2xiBxjRoSUgorgCmUlS1Ah/DYmWSaUiSXoeZ
         AyPzyJx/phgYAddcIHJy5aiDwzVFkRKCHDGlNmkx3kWKaCb6MRAIzyEb9/HuRUWpWO+C
         YNRQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Alexey Kodanev <alexey.kodanev@oracle.com>,
	Marcelo Ricardo Leitner <marcelo.leinter@gmail.com>,
	Neil Horman <nhorman@tuxdriver.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 56/65] sctp: verify size of a new chunk in _sctp_make_chunk()
Date: Fri,  9 Mar 2018 16:18:56 -0800
Message-Id: <20180310001829.611094269@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180310001824.927996722@linuxfoundation.org>
References: <20180310001824.927996722@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594507831057879306?=
X-GMAIL-MSGID: =?utf-8?q?1594508036203425693?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexey Kodanev <alexey.kodanev@oracle.com>


[ Upstream commit 07f2c7ab6f8d0a7e7c5764c4e6cc9c52951b9d9c ]

When SCTP makes INIT or INIT_ACK packet the total chunk length
can exceed SCTP_MAX_CHUNK_LEN which leads to kernel panic when
transmitting these packets, e.g. the crash on sending INIT_ACK:

[  597.804948] skbuff: skb_over_panic: text:00000000ffae06e4 len:120168
               put:120156 head:000000007aa47635 data:00000000d991c2de
               tail:0x1d640 end:0xfec0 dev:<NULL>
...
[  597.976970] ------------[ cut here ]------------
[  598.033408] kernel BUG at net/core/skbuff.c:104!
[  600.314841] Call Trace:
[  600.345829]  <IRQ>
[  600.371639]  ? sctp_packet_transmit+0x2095/0x26d0 [sctp]
[  600.436934]  skb_put+0x16c/0x200
[  600.477295]  sctp_packet_transmit+0x2095/0x26d0 [sctp]
[  600.540630]  ? sctp_packet_config+0x890/0x890 [sctp]
[  600.601781]  ? __sctp_packet_append_chunk+0x3b4/0xd00 [sctp]
[  600.671356]  ? sctp_cmp_addr_exact+0x3f/0x90 [sctp]
[  600.731482]  sctp_outq_flush+0x663/0x30d0 [sctp]
[  600.788565]  ? sctp_make_init+0xbf0/0xbf0 [sctp]
[  600.845555]  ? sctp_check_transmitted+0x18f0/0x18f0 [sctp]
[  600.912945]  ? sctp_outq_tail+0x631/0x9d0 [sctp]
[  600.969936]  sctp_cmd_interpreter.isra.22+0x3be1/0x5cb0 [sctp]
[  601.041593]  ? sctp_sf_do_5_1B_init+0x85f/0xc30 [sctp]
[  601.104837]  ? sctp_generate_t1_cookie_event+0x20/0x20 [sctp]
[  601.175436]  ? sctp_eat_data+0x1710/0x1710 [sctp]
[  601.233575]  sctp_do_sm+0x182/0x560 [sctp]
[  601.284328]  ? sctp_has_association+0x70/0x70 [sctp]
[  601.345586]  ? sctp_rcv+0xef4/0x32f0 [sctp]
[  601.397478]  ? sctp6_rcv+0xa/0x20 [sctp]
...

Here the chunk size for INIT_ACK packet becomes too big, mostly
because of the state cookie (INIT packet has large size with
many address parameters), plus additional server parameters.

Later this chunk causes the panic in skb_put_data():

  skb_packet_transmit()
      sctp_packet_pack()
          skb_put_data(nskb, chunk->skb->data, chunk->skb->len);

'nskb' (head skb) was previously allocated with packet->size
from u16 'chunk->chunk_hdr->length'.

As suggested by Marcelo we should check the chunk's length in
_sctp_make_chunk() before trying to allocate skb for it and
discard a chunk if its size bigger than SCTP_MAX_CHUNK_LEN.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
Acked-by: Marcelo Ricardo Leitner <marcelo.leinter@gmail.com>
Acked-by: Neil Horman <nhorman@tuxdriver.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sctp/sm_make_chunk.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/net/sctp/sm_make_chunk.c
+++ b/net/sctp/sm_make_chunk.c
@@ -1373,9 +1373,14 @@ static struct sctp_chunk *_sctp_make_chu
 	sctp_chunkhdr_t *chunk_hdr;
 	struct sk_buff *skb;
 	struct sock *sk;
+	int chunklen;
+
+	chunklen = SCTP_PAD4(sizeof(*chunk_hdr) + paylen);
+	if (chunklen > SCTP_MAX_CHUNK_LEN)
+		goto nodata;
 
 	/* No need to allocate LL here, as this is only a chunk. */
-	skb = alloc_skb(SCTP_PAD4(sizeof(sctp_chunkhdr_t) + paylen), gfp);
+	skb = alloc_skb(chunklen, gfp);
 	if (!skb)
 		goto nodata;
 
