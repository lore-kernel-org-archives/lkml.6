Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id oFEUMd5gGFsdQAAAmS7hNA
	; Wed, 06 Jun 2018 22:32:00 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 675A6608D2; Wed,  6 Jun 2018 22:31:59 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 66595608FD;
	Wed,  6 Jun 2018 22:31:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 66595608FD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=codethink.co.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932148AbeFFWbz (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 18:31:55 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:48112 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932068AbeFFWby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 18:31:54 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126] helo=xylophone)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1fQgy3-00019a-Oe; Wed, 06 Jun 2018 23:31:47 +0100
Message-ID: <1528324307.2289.61.camel@codethink.co.uk>
Subject: Re: [PATCH 4.4 19/92] sctp: delay the authentication for the
 duplicated cookie-echo chunk
From: Ben Hutchings <ben.hutchings@codethink.co.uk>
To: Xin Long <lucien.xin@gmail.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>
Cc: stable@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Date: Wed, 06 Jun 2018 23:31:47 +0100
In-Reply-To: <20180524093200.931521036@linuxfoundation.org>
References: <20180524093159.286472249@linuxfoundation.org>
         <20180524093200.931521036@linuxfoundation.org>
Organization: Codethink Ltd.
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-05-24 at 11:37 +0200, Greg Kroah-Hartman wrote:
> 4.4-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Xin Long <lucien.xin@gmail.com>
> 
> [ Upstream commit 59d8d4434f429b4fa8a346fd889058bda427a837 ]
> 
> Now sctp only delays the authentication for the normal cookie-echo
> chunk by setting chunk->auth_chunk in sctp_endpoint_bh_rcv(). But
> for the duplicated one with auth, in sctp_assoc_bh_rcv(), it does
> authentication first based on the old asoc, which will definitely
> fail due to the different auth info in the old asoc.
[...]
> --- a/net/sctp/associola.c
> +++ b/net/sctp/associola.c
> @@ -1000,9 +1000,10 @@ static void sctp_assoc_bh_rcv(struct wor
>  	struct sctp_endpoint *ep;
>  	struct sctp_chunk *chunk;
>  	struct sctp_inq *inqueue;
> -	int state;
>  	sctp_subtype_t subtype;
> +	int first_time = 1;	/* is this the first time through the loop */
>  	int error = 0;
> +	int state;
>  
>  	/* The association should be held so we should be safe. */
>  	ep = asoc->ep;
> @@ -1013,6 +1014,30 @@ static void sctp_assoc_bh_rcv(struct wor
>  		state = asoc->state;
>  		subtype = SCTP_ST_CHUNK(chunk->chunk_hdr->type);
>  
> +		/* If the first chunk in the packet is AUTH, do special
> +		 * processing specified in Section 6.3 of SCTP-AUTH spec
> +		 */
> +		if (first_time && subtype.chunk == SCTP_CID_AUTH) {
> +			struct sctp_chunkhdr *next_hdr;
> +
> +			next_hdr = sctp_inq_peek(inqueue);
> +			if (!next_hdr)
> +				goto normal;
> +
> +			/* If the next chunk is COOKIE-ECHO, skip the AUTH
> +			 * chunk while saving a pointer to it so we can do
> +			 * Authentication later (during cookie-echo
> +			 * processing).
> +			 */
> +			if (next_hdr->type == SCTP_CID_COOKIE_ECHO) {
> +				chunk->auth_chunk = skb_clone(chunk->skb,
> +							      GFP_ATOMIC);
> +				chunk->auth = 1;

Doesn't the first_time flag need to be cleared here (and before the
other continue statement in this loop)?

Ben.

> +				continue;
> +			}
> +		}
> +
> +normal:
[...]

-- 
Ben Hutchings, Software Developer                         Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom
