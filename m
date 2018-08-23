Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84A0DC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 05:11:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 348AE208EC
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 05:11:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 348AE208EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728495AbeHWIjP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 04:39:15 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52216 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726204AbeHWIjP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 04:39:15 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 90061804B9F4;
        Thu, 23 Aug 2018 05:11:22 +0000 (UTC)
Received: from [10.10.121.21] (ovpn-121-21.rdu2.redhat.com [10.10.121.21])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B2DD92166BA1;
        Thu, 23 Aug 2018 05:11:21 +0000 (UTC)
Subject: Re: [PATCH] iscsi-target: Don't use stack buffer for scatterlist
To:     Laura Abbott <labbott@redhat.com>,
        "Nicholas A. Bellinger" <nab@linux-iscsi.org>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Hannes Reinecke <hare@suse.com>
References: <20180822173709.5886-1-labbott@redhat.com>
Cc:     target-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Maurizio Lombardi <mlombard@redhat.com>
From:   Mike Christie <mchristi@redhat.com>
Message-ID: <5B7E41F9.4070101@redhat.com>
Date:   Thu, 23 Aug 2018 00:11:21 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <20180822173709.5886-1-labbott@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Thu, 23 Aug 2018 05:11:22 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Thu, 23 Aug 2018 05:11:22 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'mchristi@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ccing Maurizio because he was working on the same issue.

On 08/22/2018 12:37 PM, Laura Abbott wrote:
> Fedora got a bug report of a crash with iSCSI:
> 
> kernel BUG at include/linux/scatterlist.h:143!
> ...
> RIP: 0010:iscsit_do_crypto_hash_buf+0x154/0x180 [iscsi_target_mod]
> ...
>  Call Trace:
>   ? iscsi_target_tx_thread+0x200/0x200 [iscsi_target_mod]
>   iscsit_get_rx_pdu+0x4cd/0xa90 [iscsi_target_mod]
>   ? native_sched_clock+0x3e/0xa0
>   ? iscsi_target_tx_thread+0x200/0x200 [iscsi_target_mod]
>   iscsi_target_rx_thread+0x81/0xf0 [iscsi_target_mod]
>   kthread+0x120/0x140
>   ? kthread_create_worker_on_cpu+0x70/0x70
>   ret_from_fork+0x3a/0x50
> 
> This is a BUG_ON for using a stack buffer with a scatterlist.
> There are two cases that trigger this bug. Switch to using a
> dynamically allocated buffer for one case and do not assign
> a NULL buffer in another case.
> 
> Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=1615258
> Signed-off-by: Laura Abbott <labbott@redhat.com>
> ---
>  drivers/target/iscsi/iscsi_target.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/target/iscsi/iscsi_target.c b/drivers/target/iscsi/iscsi_target.c
> index 8e223799347a..8b40f0e99e2c 100644
> --- a/drivers/target/iscsi/iscsi_target.c
> +++ b/drivers/target/iscsi/iscsi_target.c
> @@ -1419,7 +1419,8 @@ static void iscsit_do_crypto_hash_buf(struct ahash_request *hash,
>  
>  	sg_init_table(sg, ARRAY_SIZE(sg));
>  	sg_set_buf(sg, buf, payload_length);
> -	sg_set_buf(sg + 1, pad_bytes, padding);
> +	if (padding)
> +		sg_set_buf(sg + 1, pad_bytes, padding);
>  
>  	ahash_request_set_crypt(hash, sg, data_crc, payload_length + padding);
>  
> @@ -3913,10 +3914,14 @@ static bool iscsi_target_check_conn_state(struct iscsi_conn *conn)
>  static void iscsit_get_rx_pdu(struct iscsi_conn *conn)
>  {
>  	int ret;
> -	u8 buffer[ISCSI_HDR_LEN], opcode;
> +	u8 *buffer, opcode;
>  	u32 checksum = 0, digest = 0;
>  	struct kvec iov;
>  
> +	buffer = kmalloc_array(ISCSI_HDR_LEN, sizeof(*buffer), GFP_KERNEL);
> +	if (!buffer)
> +		return;
> +
>  	while (!kthread_should_stop()) {
>  		/*
>  		 * Ensure that both TX and RX per connection kthreads
> @@ -3985,6 +3990,8 @@ static void iscsit_get_rx_pdu(struct iscsi_conn *conn)
>  		if (ret < 0)
>  			return;
>  	}

You need to also change all the returns to breaks between the kmalloc
above and kfree here.

> +	kfree(buffer);
>  }
>  
>  int iscsi_target_rx_thread(void *arg)
> 

