Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6AADC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 12:47:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 735E2213A2
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 12:47:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbfBYMrK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 07:47:10 -0500
Received: from charlotte.tuxdriver.com ([70.61.120.58]:54936 "EHLO
        smtp.tuxdriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726819AbfBYMrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 07:47:09 -0500
Received: from cpe-2606-a000-111b-405a-9816-2c85-c514-8f7a.dyn6.twc.com ([2606:a000:111b:405a:9816:2c85:c514:8f7a] helo=localhost)
        by smtp.tuxdriver.com with esmtpsa (TLSv1:AES256-SHA:256)
        (Exim 4.63)
        (envelope-from <nhorman@tuxdriver.com>)
        id 1gyFee-00033M-Iz; Mon, 25 Feb 2019 07:47:05 -0500
Date:   Mon, 25 Feb 2019 07:46:14 -0500
From:   Neil Horman <nhorman@tuxdriver.com>
To:     Xin Long <lucien.xin@gmail.com>
Cc:     linux-kernel@vger.kernel.org, network dev <netdev@vger.kernel.org>,
        linux-sctp@vger.kernel.org, davem@davemloft.net,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Subject: Re: [PATCH net] sctp: get sctphdr by offset in sctp_compute_cksum
Message-ID: <20190225124614.GB30699@hmswarspite.think-freely.org>
References: <2aee76766861ac9e46b7acf123d5d6e8f2adf8e0.1551093937.git.lucien.xin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2aee76766861ac9e46b7acf123d5d6e8f2adf8e0.1551093937.git.lucien.xin@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 25, 2019 at 07:25:37PM +0800, Xin Long wrote:
> sctp_hdr(skb) only works when skb->transport_header is set properly.
> 
> But in the path of nf_conntrack_in: sctp_packet() -> sctp_error()
> 
> skb->transport_header is not guaranteed to be right value for sctp.
> It will cause to fail to check the checksum for sctp packets.
> 
> So fix it by using offset, which is always right in all places.
> 
> Fixes: e6d8b64b34aa ("net: sctp: fix and consolidate SCTP checksumming code")
> Reported-by: Li Shuang <shuali@redhat.com>
> Signed-off-by: Xin Long <lucien.xin@gmail.com>
> ---
>  include/net/sctp/checksum.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/net/sctp/checksum.h b/include/net/sctp/checksum.h
> index 32ee65a..1c6e6c0 100644
> --- a/include/net/sctp/checksum.h
> +++ b/include/net/sctp/checksum.h
> @@ -61,7 +61,7 @@ static inline __wsum sctp_csum_combine(__wsum csum, __wsum csum2,
>  static inline __le32 sctp_compute_cksum(const struct sk_buff *skb,
>  					unsigned int offset)
>  {
> -	struct sctphdr *sh = sctp_hdr(skb);
> +	struct sctphdr *sh = (struct sctphdr *)(skb->data + offset);
>  	const struct skb_checksum_ops ops = {
>  		.update  = sctp_csum_update,
>  		.combine = sctp_csum_combine,
> -- 
> 2.1.0
> 
> 
Shouldn't you use skb_set_transport_header and skb_transport_header here?

Neil

