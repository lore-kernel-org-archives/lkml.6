Return-Path: <ben.hutchings@codethink.co.uk>
X-Google-Smtp-Source: AG47ELvArDOlAhD+T5F/PJ5WPfpEbhvsnAS2P/LccdKSkoxNQ/Opaolv7F6SzOjcVsq9e5t2i3Gg
ARC-Seal: i=1; a=rsa-sha256; t=1521044644; cv=none;
        d=google.com; s=arc-20160816;
        b=J/Qyu8XQ84WWiY3abvoKO0ZluDNVtNDvO22TSXQq+7K7X9tLvDH5qKd9zxIFNSc1OF
         e0iWru5+Bt/S9ng5YqippRU9Wns5nyiQF1RBOUtVsIKxce9Kj1HOeWHEZPhhw2FQZeGp
         7cIWlfduogpGKKuYfHQlZR70a5DA000hz1iHUCXMM0Xk3A9aS+IpcDK2dsDtPA07/v8O
         iHb4SdmW8hEMixu9oQuDapDWAH2cC9NM5+xy4AoVFGtD6JA83NCEr2MdekZuQ8oBnOtG
         uq7M9A6FpjAo1woxmLbdhFcfz/UmDTUO7yaonrYpq4oeBLJ0jDpgkEfcCuaNXF86oi6H
         hQQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:date:cc:to:from:subject:message-id
         :arc-authentication-results;
        bh=RAZ/4+wwxz9nwO2DWwZojgVeIVhaLXmSCFROIw0fmt0=;
        b=MTG+3r0gVIc3qi/a+4AAjz9QnEKx/P8nzei2/W4BXREmdOEuAnfl7LWRyf9j8HMtSv
         u6QilHYmF9yFMrLNSN5D3pr+MZNrmtQg68XJGdFm9H73sQmEgvwjaC+gw8RNmzFUFT78
         Nycs88thlYYtMCfSIlE4urnLq59yODAmvcKOKHC5X1MAsCfp8FsXm99a8ohX0uyOASAw
         zVduUHKhMBUZhr/8FPqCvS2Ag94Z/kEm9O60Xh/ZtvJgK4W1JZYppaLwYN1mTo2CiWuM
         C+oUgN+iTfkZ1kTTot1T6sKfa6OmNdjqzhl4vS3h/XtrvyHypDm2UOTSnWfOSFj3LZEx
         wXmg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of ben.hutchings@codethink.co.uk designates 176.9.8.82 as permitted sender) smtp.mailfrom=ben.hutchings@codethink.co.uk;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=codethink.co.uk
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of ben.hutchings@codethink.co.uk designates 176.9.8.82 as permitted sender) smtp.mailfrom=ben.hutchings@codethink.co.uk;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=codethink.co.uk
Message-ID: <1521044638.23626.98.camel@codethink.co.uk>
Subject: Re: [PATCH 4.4 31/36] sctp: verify size of a new chunk in
 _sctp_make_chunk()
From: Ben Hutchings <ben.hutchings@codethink.co.uk>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, Alexey Kodanev
 <alexey.kodanev@oracle.com>, Marcelo Ricardo Leitner
 <marcelo.leinter@gmail.com>,  Neil Horman <nhorman@tuxdriver.com>, "David
 S. Miller" <davem@davemloft.net>
Date: Wed, 14 Mar 2018 16:23:58 +0000
In-Reply-To: <20180313095600.GA5131@kroah.com>
References: <20180310001807.213987241@linuxfoundation.org>
	 <20180310001809.079131255@linuxfoundation.org>
	 <1520902018.23626.90.camel@codethink.co.uk>
	 <20180313095600.GA5131@kroah.com>
Organization: Codethink Ltd.
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594507831057879306?=
X-GMAIL-MSGID: =?utf-8?q?1594930909431365341?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, 2018-03-13 at 10:56 +0100, Greg Kroah-Hartman wrote:
> On Tue, Mar 13, 2018 at 12:46:58AM +0000, Ben Hutchings wrote:
> > On Fri, 2018-03-09 at 16:18 -0800, Greg Kroah-Hartman wrote:
> > > 4.4-stable review patch.  If anyone has any objections, please
> > > let me know.
> > > 
> > > ------------------
> > > 
> > > From: Alexey Kodanev <alexey.kodanev@oracle.com>
> > > 
> > > 
> > > [ Upstream commit 07f2c7ab6f8d0a7e7c5764c4e6cc9c52951b9d9c ]
> > > 
> > > When SCTP makes INIT or INIT_ACK packet the total chunk length
> > > can exceed SCTP_MAX_CHUNK_LEN which leads to kernel panic when
> > > transmitting these packets, e.g. the crash on sending INIT_ACK:
> > > 
> > > [  597.804948] skbuff: skb_over_panic: text:00000000ffae06e4
> > > len:120168
> > >                put:120156 head:000000007aa47635
> > > data:00000000d991c2de
> > >                tail:0x1d640 end:0xfec0 dev:<NULL>
> > > ...
> > > [  597.976970] ------------[ cut here ]------------
> > > [  598.033408] kernel BUG at net/core/skbuff.c:104!
> > > [  600.314841] Call Trace:
> > > [  600.345829]  <IRQ>
> > > [  600.371639]  ? sctp_packet_transmit+0x2095/0x26d0 [sctp]
> > > [  600.436934]  skb_put+0x16c/0x200
> > > [  600.477295]  sctp_packet_transmit+0x2095/0x26d0 [sctp]
> > > [  600.540630]  ? sctp_packet_config+0x890/0x890 [sctp]
> > > [  600.601781]  ? __sctp_packet_append_chunk+0x3b4/0xd00 [sctp]
> > > [  600.671356]  ? sctp_cmp_addr_exact+0x3f/0x90 [sctp]
> > > [  600.731482]  sctp_outq_flush+0x663/0x30d0 [sctp]
> > > [  600.788565]  ? sctp_make_init+0xbf0/0xbf0 [sctp]
> > > [  600.845555]  ? sctp_check_transmitted+0x18f0/0x18f0 [sctp]
> > > [  600.912945]  ? sctp_outq_tail+0x631/0x9d0 [sctp]
> > > [  600.969936]  sctp_cmd_interpreter.isra.22+0x3be1/0x5cb0 [sctp]
> > > [  601.041593]  ? sctp_sf_do_5_1B_init+0x85f/0xc30 [sctp]
> > > [  601.104837]  ? sctp_generate_t1_cookie_event+0x20/0x20 [sctp]
> > > [  601.175436]  ? sctp_eat_data+0x1710/0x1710 [sctp]
> > > [  601.233575]  sctp_do_sm+0x182/0x560 [sctp]
> > > [  601.284328]  ? sctp_has_association+0x70/0x70 [sctp]
> > > [  601.345586]  ? sctp_rcv+0xef4/0x32f0 [sctp]
> > > [  601.397478]  ? sctp6_rcv+0xa/0x20 [sctp]
> > > ...
> > > 
> > > Here the chunk size for INIT_ACK packet becomes too big, mostly
> > > because of the state cookie (INIT packet has large size with
> > > many address parameters), plus additional server parameters.
> > > 
> > > Later this chunk causes the panic in skb_put_data():
> > > 
> > >   skb_packet_transmit()
> > >       sctp_packet_pack()
> > >           skb_put_data(nskb, chunk->skb->data, chunk->skb->len);
> > > 
> > > 'nskb' (head skb) was previously allocated with packet->size
> > > from u16 'chunk->chunk_hdr->length'.
> > > 
> > > As suggested by Marcelo we should check the chunk's length in
> > > _sctp_make_chunk() before trying to allocate skb for it and
> > > discard a chunk if its size bigger than SCTP_MAX_CHUNK_LEN.
> > > 
> > > > Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
> > > > Acked-by: Marcelo Ricardo Leitner <marcelo.leinter@gmail.com>
> > > > Acked-by: Neil Horman <nhorman@tuxdriver.com>
> > > > Signed-off-by: David S. Miller <davem@davemloft.net>
> > > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > 
> > > ---
> > >  net/sctp/sm_make_chunk.c |    8 ++++++--
> > >  1 file changed, 6 insertions(+), 2 deletions(-)
> > > 
> > > --- a/net/sctp/sm_make_chunk.c
> > > +++ b/net/sctp/sm_make_chunk.c
> > > @@ -1367,10 +1367,14 @@ static struct sctp_chunk *_sctp_make_chu
> > >  	sctp_chunkhdr_t *chunk_hdr;
> > >  	struct sk_buff *skb;
> > >  	struct sock *sk;
> > > +	int chunklen;
> > > +
> > > +	chunklen = sizeof(*chunk_hdr) + paylen;
> > 
> > I think this length still needs to be rounded up (with WORD_ROUND
> > here,
> > instead of SCTP_PAD4 upstream).
> 
> Ah, good point, how's this patch:

LGTM.

Ben.

> diff --git a/net/sctp/sm_make_chunk.c b/net/sctp/sm_make_chunk.c
> index 4ca31e052dd8..509e9426a056 100644
> --- a/net/sctp/sm_make_chunk.c
> +++ b/net/sctp/sm_make_chunk.c
> @@ -1369,7 +1369,7 @@ static struct sctp_chunk
> *_sctp_make_chunk(const struct sctp_association *asoc,
>  	struct sock *sk;
>  	int chunklen;
>  
> -	chunklen = sizeof(*chunk_hdr) + paylen;
> +	chunklen = WORD_ROUND(sizeof(*chunk_hdr) + paylen);
>  	if (chunklen > SCTP_MAX_CHUNK_LEN)
>  		goto nodata;
>  
> 
-- 
Ben Hutchings
Software Developer, Codethink Ltd.
