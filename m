Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80391C43142
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 02:16:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3096A24D83
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 02:16:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3096A24D83
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=talpey.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751597AbeFXCQR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Jun 2018 22:16:17 -0400
Received: from p3plsmtpa12-06.prod.phx3.secureserver.net ([68.178.252.235]:33661
        "EHLO p3plsmtpa12-06.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751606AbeFXCQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jun 2018 22:16:15 -0400
Received: from [192.168.0.67] ([24.218.182.144])
        by :SMTPAUTH: with ESMTPSA
        id WuZafFgSeVxevWuZafzrMs; Sat, 23 Jun 2018 19:16:15 -0700
Subject: Re: [Patch v2 09/15] CIFS: SMBD: Support page offset in RDMA recv
To:     longli@microsoft.com, Steve French <sfrench@samba.org>,
        linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
References: <20180530194807.31657-1-longli@linuxonhyperv.com>
 <20180530194807.31657-10-longli@linuxonhyperv.com>
From:   Tom Talpey <tom@talpey.com>
Message-ID: <1e6b7cb0-98e8-d1fd-cb59-d3344fc70b19@talpey.com>
Date:   Sat, 23 Jun 2018 22:16:15 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180530194807.31657-10-longli@linuxonhyperv.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfJjtfXTqM0909Ps86VAfYG2L4yrmvSSS/GiveIofQEJI0tq02EXdIZGoO0uOOqz2YCgnA9h8UFwRXKrOvxguS3CYpjmUr/6BUPeym3zAMK3wkTWoImgH
 x3vsbz+vTGVW+oYHFZndykq/7NPdIWrV3Zqac8fyCU6o4OPeiHcF12OwUObFMbprQ2uVbMprvfl6mNIKceMW9WdKNVSk+Q4BsfW9Aq33lt+ZWH9deJCullho
 iYbjwhBU6KOSI/ZS/AkKeWbqf/H92mAB/VuioVmr0sYZpsgc1Sxq1kn9aWESDQ8kdnbk8cTNZt8ltYsBMDTye0aRYL3P7dxIArmRThYfdyzwxMD80MwcK0aw
 F2KkygVt
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/30/2018 3:48 PM, Long Li wrote:
> From: Long Li <longli@microsoft.com>
> 
> RDMA recv function needs to place data to the correct place starting at
> page offset.
> 
> Signed-off-by: Long Li <longli@microsoft.com>
> ---
>   fs/cifs/smbdirect.c | 18 +++++++++++-------
>   1 file changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/cifs/smbdirect.c b/fs/cifs/smbdirect.c
> index 6141e3c..ba53c52 100644
> --- a/fs/cifs/smbdirect.c
> +++ b/fs/cifs/smbdirect.c
> @@ -2004,10 +2004,12 @@ static int smbd_recv_buf(struct smbd_connection *info, char *buf,
>    * return value: actual data read
>    */
>   static int smbd_recv_page(struct smbd_connection *info,
> -		struct page *page, unsigned int to_read)
> +		struct page *page, unsigned int page_offset,
> +		unsigned int to_read)
>   {
>   	int ret;
>   	char *to_address;
> +	void *page_address;
>   
>   	/* make sure we have the page ready for read */
>   	ret = wait_event_interruptible(
> @@ -2015,16 +2017,17 @@ static int smbd_recv_page(struct smbd_connection *info,
>   		info->reassembly_data_length >= to_read ||
>   			info->transport_status != SMBD_CONNECTED);
>   	if (ret)
> -		return 0;
> +		return ret;
>   
>   	/* now we can read from reassembly queue and not sleep */
> -	to_address = kmap_atomic(page);
> +	page_address = kmap_atomic(page);
> +	to_address = (char *) page_address + page_offset;
>   
>   	log_read(INFO, "reading from page=%p address=%p to_read=%d\n",
>   		page, to_address, to_read);
>   
>   	ret = smbd_recv_buf(info, to_address, to_read);
> -	kunmap_atomic(to_address);
> +	kunmap_atomic(page_address);

Is "page" truly not mapped? This kmap/kunmap for each received 4KB is
very expensive. Is there not a way to keep a kva for the reassembly
queue segments?

>   
>   	return ret;
>   }
> @@ -2038,7 +2041,7 @@ int smbd_recv(struct smbd_connection *info, struct msghdr *msg)
>   {
>   	char *buf;
>   	struct page *page;
> -	unsigned int to_read;
> +	unsigned int to_read, page_offset;
>   	int rc;
>   
>   	info->smbd_recv_pending++;
> @@ -2052,15 +2055,16 @@ int smbd_recv(struct smbd_connection *info, struct msghdr *msg)
>   
>   	case READ | ITER_BVEC:
>   		page = msg->msg_iter.bvec->bv_page;
> +		page_offset = msg->msg_iter.bvec->bv_offset;
>   		to_read = msg->msg_iter.bvec->bv_len;
> -		rc = smbd_recv_page(info, page, to_read);
> +		rc = smbd_recv_page(info, page, page_offset, to_read);
>   		break;
>   
>   	default:
>   		/* It's a bug in upper layer to get there */
>   		cifs_dbg(VFS, "CIFS: invalid msg type %d\n",
>   			msg->msg_iter.type);
> -		rc = -EIO;
> +		rc = -EINVAL;
>   	}
>   
>   	info->smbd_recv_pending--;
> 
