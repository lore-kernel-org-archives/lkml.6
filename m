Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BDA7C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 20:45:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE8EB20834
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 20:45:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE8EB20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lxorguk.ukuu.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbeLDUpq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 15:45:46 -0500
Received: from www.llwyncelyn.cymru ([82.70.14.225]:38422 "EHLO fuzix.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725874AbeLDUpq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 15:45:46 -0500
Received: from alans-desktop (82-70-14-226.dsl.in-addr.zen.co.uk [82.70.14.226])
        by fuzix.org (8.15.2/8.15.2) with ESMTP id wB4Kj9MP024700;
        Tue, 4 Dec 2018 20:45:10 GMT
Date:   Tue, 4 Dec 2018 20:45:08 +0000
From:   Alan Cox <gnomes@lxorguk.ukuu.org.uk>
To:     Jian-Hong Pan <starnight@g.ncu.edu.tw>
Cc:     Andreas =?UTF-8?B?RsOkcmJlcg==?= <afaerber@suse.de>,
        "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Marcel Holtmann <marcel@holtmann.org>,
        Dollar Chen <dollar.chen@wtmec.com>,
        Ken Yu <ken.yu@rakwireless.com>, linux-wpan@vger.kernel.org,
        Stefan Schmidt <stefan@datenfreihafen.org>
Subject: Re: [PATCH V4 5/6] net: maclorawan: Implement maclorawan class
 module
Message-ID: <20181204204508.3ebead06@alans-desktop>
In-Reply-To: <20181204141341.4353-6-starnight@g.ncu.edu.tw>
References: <CAC=mGzhs0smXzRxn1k9jDFsaLNAkpCd7rMs--E-SafQVTob7JQ@mail.gmail.com>
        <20181204141341.4353-6-starnight@g.ncu.edu.tw>
Organization: Intel Corporation
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +void
> +lrw_parse_frame(struct lrw_session *ss, struct sk_buff *skb)
> +{
> +	struct lrw_fhdr *fhdr = &ss->rx_fhdr;
> +	__le16 *p_fcnt;
> +
> +	pr_debug("%s: %s\n", LORAWAN_MODULE_NAME, __func__);
> +
> +	/* Get message type */
> +	fhdr->mtype = skb->data[0];
> +	skb_pull(skb, LRW_MHDR_LEN);

This does not seem robust. There is no point at which you actually check
the message size is valid etc

> +	fhdr->fopts_len = fhdr->fctrl & 0xF;
> +	if (fhdr->fopts_len > 0) {
> +		memcpy(fhdr->fopts, skb->data, fhdr->fopts_len);
> +		skb_pull(skb, fhdr->fopts_len);
> +	}

In fact you appear to copy random kernel memory into a buffer
> +
> +	/* TODO: Parse frame options */
> +
> +	/* Remove message integrity code */
> +	skb_trim(skb, skb->len - LRW_MIC_LEN);

and then try and trim the buffer to a negative size ?

Alan
