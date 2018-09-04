Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA218C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 19:03:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BE4D20645
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 19:03:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BE4D20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727988AbeIDXaB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 19:30:01 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54806 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727072AbeIDXaB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 19:30:01 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 00A1F40216E5;
        Tue,  4 Sep 2018 19:03:34 +0000 (UTC)
Received: from [10.10.122.126] (ovpn-122-126.rdu2.redhat.com [10.10.122.126])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3F501202704B;
        Tue,  4 Sep 2018 19:03:33 +0000 (UTC)
Subject: Re: [PATCHv3] iscsi-target: Don't use stack buffer for scatterlist
To:     Laura Abbott <labbott@redhat.com>,
        "Nicholas A. Bellinger" <nab@linux-iscsi.org>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Hannes Reinecke <hare@suse.com>,
        Maurizio Lombardi <mlombard@redhat.com>
References: <20180904184740.11102-1-labbott@redhat.com>
Cc:     target-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
From:   Mike Christie <mchristi@redhat.com>
Message-ID: <5B8ED704.9010601@redhat.com>
Date:   Tue, 4 Sep 2018 14:03:32 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <20180904184740.11102-1-labbott@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Tue, 04 Sep 2018 19:03:34 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Tue, 04 Sep 2018 19:03:34 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'mchristi@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/04/2018 01:47 PM, Laura Abbott wrote:
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
> Signed-off-by: Laura Abbott <labbott@redhat.com>
> ---
> v3: Switched to kcalloc to drop an extra memset call. I was asked
> offline about kmalloc vs. kmalloc_array and ended up asking about this
> at the security summit since I was there last week. The preferred style
> is kmalloc_array for all arrays, even those of one byte characters.
> I will also switch it if people feel really strongly about this or I've
> misunderstood the array guidelines.
> ---
>  drivers/target/iscsi/iscsi_target.c | 22 ++++++++++++++--------
>  1 file changed, 14 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/target/iscsi/iscsi_target.c b/drivers/target/iscsi/iscsi_target.c
> index 94bad43c41ff..2a586b58a011 100644
> --- a/drivers/target/iscsi/iscsi_target.c
> +++ b/drivers/target/iscsi/iscsi_target.c
> @@ -1416,7 +1416,8 @@ static void iscsit_do_crypto_hash_buf(struct ahash_request *hash,
>  
>  	sg_init_table(sg, ARRAY_SIZE(sg));
>  	sg_set_buf(sg, buf, payload_length);
> -	sg_set_buf(sg + 1, pad_bytes, padding);
> +	if (padding)
> +		sg_set_buf(sg + 1, pad_bytes, padding);
>  
>  	ahash_request_set_crypt(hash, sg, data_crc, payload_length + padding);
>  
> @@ -3910,10 +3911,14 @@ static bool iscsi_target_check_conn_state(struct iscsi_conn *conn)
>  static void iscsit_get_rx_pdu(struct iscsi_conn *conn)
>  {
>  	int ret;
> -	u8 buffer[ISCSI_HDR_LEN], opcode;
> +	u8 *buffer, opcode;
>  	u32 checksum = 0, digest = 0;
>  	struct kvec iov;
>  
> +	buffer = kcalloc(ISCSI_HDR_LEN, sizeof(*buffer), GFP_KERNEL);
> +	if (!buffer)
> +		return;
> +
>  	while (!kthread_should_stop()) {
>  		/*
>  		 * Ensure that both TX and RX per connection kthreads
> @@ -3921,7 +3926,6 @@ static void iscsit_get_rx_pdu(struct iscsi_conn *conn)
>  		 */
>  		iscsit_thread_check_cpumask(conn, current, 0);
>  
> -		memset(buffer, 0, ISCSI_HDR_LEN);
>  		memset(&iov, 0, sizeof(struct kvec));
>  
>  		iov.iov_base	= buffer;
> @@ -3930,7 +3934,7 @@ static void iscsit_get_rx_pdu(struct iscsi_conn *conn)
>  		ret = rx_data(conn, &iov, 1, ISCSI_HDR_LEN);
>  		if (ret != ISCSI_HDR_LEN) {
>  			iscsit_rx_thread_wait_for_tcp(conn);
> -			return;
> +			break;
>  		}
>  
>  		if (conn->conn_ops->HeaderDigest) {
> @@ -3940,7 +3944,7 @@ static void iscsit_get_rx_pdu(struct iscsi_conn *conn)
>  			ret = rx_data(conn, &iov, 1, ISCSI_CRC_LEN);
>  			if (ret != ISCSI_CRC_LEN) {
>  				iscsit_rx_thread_wait_for_tcp(conn);
> -				return;
> +				break;
>  			}
>  
>  			iscsit_do_crypto_hash_buf(conn->conn_rx_hash, buffer,
> @@ -3964,7 +3968,7 @@ static void iscsit_get_rx_pdu(struct iscsi_conn *conn)
>  		}
>  
>  		if (conn->conn_state == TARG_CONN_STATE_IN_LOGOUT)
> -			return;
> +			break;
>  
>  		opcode = buffer[0] & ISCSI_OPCODE_MASK;
>  
> @@ -3975,13 +3979,15 @@ static void iscsit_get_rx_pdu(struct iscsi_conn *conn)
>  			" while in Discovery Session, rejecting.\n", opcode);
>  			iscsit_add_reject(conn, ISCSI_REASON_PROTOCOL_ERROR,
>  					  buffer);
> -			return;
> +			break;
>  		}
>  
>  		ret = iscsi_target_rx_opcode(conn, buffer);
>  		if (ret < 0)
> -			return;
> +			break;
>  	}
> +
> +	kfree(buffer);
>  }
>  
>  int iscsi_target_rx_thread(void *arg)
> 

Ok.

Reviewed-by: Mike Christie <mchristi@redhat.com>
