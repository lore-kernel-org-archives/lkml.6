Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34442ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 00:46:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C403620BED
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 00:46:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C403620BED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codewreck.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730875AbeGQBPw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 21:15:52 -0400
Received: from nautica.notk.org ([91.121.71.147]:55050 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729827AbeGQBPw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 21:15:52 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 9261BC009; Tue, 17 Jul 2018 02:45:57 +0200 (CEST)
Date:   Tue, 17 Jul 2018 02:45:42 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Chirantan Ekbote <chirantan@chromium.org>
Cc:     groug@kaod.org, linux-kernel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net, dgreid@chromium.org,
        groeck@chromium.org
Subject: Re: [PATCH v2] Fix zero-copy path in the 9p virtio transport
Message-ID: <20180717004542.GA8102@nautica>
References: <20180717003529.114368-1-chirantan@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180717003529.114368-1-chirantan@chromium.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Chirantan Ekbote wrote on Mon, Jul 16, 2018:
> The zero-copy optimization when reading or writing large chunks of data
> is quite useful.  However, the 9p messages created through the zero-copy
> write path have an incorrect message size: it should be the size of the
> header + size of the data being written but instead it's just the size
> of the header.
> 
> This only works if the server ignores the size field of the message and
> otherwise breaks the framing of the protocol. Fix this by re-writing the
> message size field with the correct value.
> 
> Tested by running `dd if=/dev/zero of=out bs=4k count=1` inside a
> virtio-9p mount.
> 
> Signed-off-by: Chirantan Ekbote <chirantan@chromium.org>
> Reviewed-by: Greg Kurz <groug@kaod.org>
> Tested-by: Greg Kurz <groug@kaod.org>

Ack, I've added this to my queue for 4.19

Thanks for moving the memcpy and the updated comment, it makes it more
clear that these are different fields of the message.

> ---
>  net/9p/trans_virtio.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/net/9p/trans_virtio.c b/net/9p/trans_virtio.c
> index 05006cbb3361..65761381c58f 100644
> --- a/net/9p/trans_virtio.c
> +++ b/net/9p/trans_virtio.c
> @@ -406,6 +406,7 @@ p9_virtio_zc_request(struct p9_client *client, struct p9_req_t *req,
>  	p9_debug(P9_DEBUG_TRANS, "virtio request\n");
>  
>  	if (uodata) {
> +		__le32 sz;
>  		int n = p9_get_mapped_pages(chan, &out_pages, uodata,
>  					    outlen, &offs, &need_drop);
>  		if (n < 0)
> @@ -416,6 +417,12 @@ p9_virtio_zc_request(struct p9_client *client, struct p9_req_t *req,
>  			memcpy(&req->tc->sdata[req->tc->size - 4], &v, 4);
>  			outlen = n;
>  		}
> +		/* The size field of the message must include the length of the
> +		 * header and the length of the data.  We didn't actually know
> +		 * the length of the data until this point so add it in now.
> +		 */
> +		sz = cpu_to_le32(req->tc->size + outlen);
> +		memcpy(&req->tc->sdata[0], &sz, sizeof(sz));
>  	} else if (uidata) {
>  		int n = p9_get_mapped_pages(chan, &in_pages, uidata,
>  					    inlen, &offs, &need_drop);

-- 
Dominique Martinet
