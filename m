Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1043CC43144
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 02:27:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7904824D85
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 02:27:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7904824D85
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=talpey.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752117AbeFXC1V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Jun 2018 22:27:21 -0400
Received: from p3plsmtpa12-04.prod.phx3.secureserver.net ([68.178.252.233]:59044
        "EHLO p3plsmtpa12-04.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751895AbeFXC1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jun 2018 22:27:19 -0400
Received: from [192.168.0.67] ([24.218.182.144])
        by :SMTPAUTH: with ESMTPSA
        id WukIfzN2dOIAfWukIfWpdM; Sat, 23 Jun 2018 19:27:19 -0700
Subject: Re: [Patch v2 11/15] CIFS: Pass page offset for calculating signature
To:     longli@microsoft.com, Steve French <sfrench@samba.org>,
        linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
References: <20180530194807.31657-1-longli@linuxonhyperv.com>
 <20180530194807.31657-12-longli@linuxonhyperv.com>
From:   Tom Talpey <tom@talpey.com>
Message-ID: <7a9ee28d-4c18-c4fd-259b-1feeeb3fb83b@talpey.com>
Date:   Sat, 23 Jun 2018 22:27:18 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180530194807.31657-12-longli@linuxonhyperv.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfAfAxpIvNvhcES6ZUP6NUJqlXrsi8CXxl9zi+d+wOKvNHv3U7Clr2UkeuyIAkIMxiVoyVrEm5Cfrbj222JT5rxyHyb7z8Xn7HVC7lC8J+AlWHKK0HXHH
 9KFIBiguNIyz3/TlQTJWUTmOl6z2EtAWMqWOleYOCNfwnNe4CiEW0IEWofOVyYcuEZYBU36tws3POtiZH3Ti9dZWv0nNjq0zxOjk6MYSrQiIyQbFC5PyJqfo
 4y/zQOtRA7QmWwQHoT3u/dG+787iDkeUdZLkpac4MgkE0e5U+4YmzYDaba519bct8o+PP69rGBcaAzDgJcTk2bfBC9+FC3k9NFblMSDiVLs7XoVz7+eFy4te
 qLsutaKv
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/30/2018 3:48 PM, Long Li wrote:
> From: Long Li <longli@microsoft.com>
> 
> When calculating signature for the packet, it needs to read into the
> correct page offset for the data.
> 
> Signed-off-by: Long Li <longli@microsoft.com>
> ---
>   fs/cifs/cifsencrypt.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/cifs/cifsencrypt.c b/fs/cifs/cifsencrypt.c
> index a6ef088..e88303c 100644
> --- a/fs/cifs/cifsencrypt.c
> +++ b/fs/cifs/cifsencrypt.c
> @@ -68,11 +68,12 @@ int __cifs_calc_signature(struct smb_rqst *rqst,
>   
>   	/* now hash over the rq_pages array */
>   	for (i = 0; i < rqst->rq_npages; i++) {
> -		void *kaddr = kmap(rqst->rq_pages[i]);
> -		size_t len = rqst->rq_pagesz;
> +		void *kaddr;
> +		unsigned int len, offset;
>   
> -		if (i == rqst->rq_npages - 1)
> -			len = rqst->rq_tailsz;
> +		rqst_page_get_length(rqst, i, &len, &offset);
> +
> +		kaddr = (char *) kmap(rqst->rq_pages[i]) + offset;

I suppose it's more robust to map a page at a time, but it's pretty
expensive. Is this the only way to iterate over a potentially very
large block of data? For example, a 1MB segment means 256 kmap/kunmaps.

Tom.

>   
>   		crypto_shash_update(shash, kaddr, len);
>   
> 
