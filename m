Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9221FC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 06:07:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 483CB2098A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 06:07:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 483CB2098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=talpey.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731068AbeISLna (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 07:43:30 -0400
Received: from p3plsmtpa06-07.prod.phx3.secureserver.net ([173.201.192.108]:37627
        "EHLO p3plsmtpa06-07.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731052AbeISLna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 07:43:30 -0400
Received: from [172.20.1.132] ([50.235.29.93])
        by :SMTPAUTH: with ESMTPSA
        id 2VWhguSHRrtGy2VWhgOGEs; Tue, 18 Sep 2018 22:59:52 -0700
Subject: Re: [Patch v7 21/22] CIFS: SMBD: Upper layer performs SMB read via
 RDMA write through memory registration
To:     Long Li <longli@exchange.microsoft.com>,
        Steve French <sfrench@samba.org>, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Tom Talpey <ttalpey@microsoft.com>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>
Cc:     Long Li <longli@microsoft.com>
References: <20171107085514.12693-1-longli@exchange.microsoft.com>
 <20171107085514.12693-22-longli@exchange.microsoft.com>
From:   Tom Talpey <tom@talpey.com>
Message-ID: <9b02dadb-d21b-7a8d-7803-910041f66047@talpey.com>
Date:   Tue, 18 Sep 2018 22:59:50 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20171107085514.12693-22-longli@exchange.microsoft.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfAS1IWOXLvbN15IWhnLiiLYPIgj3njHghlZ739UQ7I3KKR0ehxxgZ4L0XwQ6rDRqgcKOIcxzNJCrJQzazoFgcuNqVffAGBumLiW6835KED+B6gGX3Wti
 xZwoq2pLYEpvc3xpVLPwdNNA5m/JTvlx8dmToZ6jA8Xem3qCB9GchEc/C5kamtcThxwR1AlloVRpDyS0Vq3RGQmpmhN9dgNz0BZjF0LjO7oz7qUlxacDLA5L
 /SWU7ZgwceMbUXLuB/F6LZ74GdAp64tZyqxnnCEn1h3BumWWdwB2WRbJ9ySU0PPG3DiMwQf8unV2Ojq6MBrgxHOZtbxjzOmCzZWidP0GJTxELd2hJhFVq7Z7
 hKsMMQkdiV2cRGNB5mjoi63wbPxFLsA+qHMXFjCIauLuYyrp3Az9BSEJA7rzkmycF6FAbvbVRYWfNXOuJQEa4HEXzCX2yhA2jcGdqGvl5Kb5bRffCh8tKWK1
 H7h7mHXiQUFZv4qaDilJEzY7zVBsHL6Xd8yAf+GfH6g11eIypjc669ezWc4=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replying to a very old message, but it's something we
discussed today at the IOLab event so to capture it:

On 11/7/2017 12:55 AM, Long Li wrote:
> From: Long Li <longli@microsoft.com>
> 
> ---
>   fs/cifs/file.c    | 17 +++++++++++++++--
>   fs/cifs/smb2pdu.c | 45 ++++++++++++++++++++++++++++++++++++++++++++-
>   2 files changed, 59 insertions(+), 3 deletions(-)
> ...
> diff --git a/fs/cifs/smb2pdu.c b/fs/cifs/smb2pdu.c
> index c8afb83..8a5ff90 100644
> --- a/fs/cifs/smb2pdu.c
> +++ b/fs/cifs/smb2pdu.c
> @@ -2379,7 +2379,40 @@ smb2_new_read_req(void **buf, unsigned int *total_len,
>   	req->MinimumCount = 0;
>   	req->Length = cpu_to_le32(io_parms->length);
>   	req->Offset = cpu_to_le64(io_parms->offset);
> +#ifdef CONFIG_CIFS_SMB_DIRECT
> +	/*
> +	 * If we want to do a RDMA write, fill in and append
> +	 * smbd_buffer_descriptor_v1 to the end of read request
> +	 */
> +	if (server->rdma && rdata &&
> +		rdata->bytes >= server->smbd_conn->rdma_readwrite_threshold) {
> +
> +		struct smbd_buffer_descriptor_v1 *v1;
> +		bool need_invalidate =
> +			io_parms->tcon->ses->server->dialect == SMB30_PROT_ID;
> +
> +		rdata->mr = smbd_register_mr(
> +				server->smbd_conn, rdata->pages,
> +				rdata->nr_pages, rdata->tailsz,
> +				true, need_invalidate);
> +		if (!rdata->mr)
> +			return -ENOBUFS;
> +
> +		req->Channel = SMB2_CHANNEL_RDMA_V1_INVALIDATE;
> +		if (need_invalidate)
> +			req->Channel = SMB2_CHANNEL_RDMA_V1;
> +		req->ReadChannelInfoOffset =
> +			offsetof(struct smb2_read_plain_req, Buffer);
> +		req->ReadChannelInfoLength =
> +			sizeof(struct smbd_buffer_descriptor_v1);
> +		v1 = (struct smbd_buffer_descriptor_v1 *) &req->Buffer[0];
> +		v1->offset = rdata->mr->mr->iova;

It's unnecessary, and possibly leaking kernel information, to use
the IOVA as the offset of a memory region which is registered using
an FRWR. Because such regions are based on the exact bytes targeted
by the memory handle, the offset can be set to any value, typically
zero, but nearly arbitrary. As long as the (offset + length) does
not wrap or otherwise overflow, offset can be set to anything
convenient.

Since SMB reads and writes range up to 8MB, I'd suggest zeroing the
least significant 23 bits, which should guarantee it. The other 41
bits, party on. You could randomize them, pass some clever identifier
such as MID sequence, whatever.

Tom.

> +		v1->token = rdata->mr->mr->rkey;
> +		v1->length = rdata->mr->mr->length;
