Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56FA9C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 07:38:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EDB4204FD
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 07:38:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="vmYUA4vw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EDB4204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729564AbeKEQ5A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 11:57:00 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:59574 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728671AbeKEQ5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 11:57:00 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wA57XwJj189553;
        Mon, 5 Nov 2018 07:38:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=07kIGKlmWAbwMeARQ0vQBDdBwBtVuNDiAifp9+wSuf4=;
 b=vmYUA4vwB+ivXyTsvm/ipNzmUmK+Cs4M70J8pV9UDCVqaF9dmQu12R1jIPZp98fU20zj
 pHxxoQNWbtFsbJsFVDXoZfl35JTHuMEshNRgID2luf6kA+rt/W0W1o0n+R9vOQ4r+MIV
 axS6z3ii6ghVGCucAbBjkTgaID3mVljCwHmpEIhKd5NUIchCF28RVpRHpFhqcZIvFelB
 QCkIu9Z77gbCOawYFY82TA+gp3ZweNR9beVacqzN+Tl9gOOG5M0jE0Tz9X5nnB4SK4lR
 HtYmT3Ky5nbh0SQ1mvCk2NrYw+u7q1AAq2LfLfq/m7QtDj0PpNTNl0ioe27ATOp9vxiC 1g== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2nh33tn1w4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Nov 2018 07:38:36 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wA57cZrh024726
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 5 Nov 2018 07:38:35 GMT
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wA57cYYw012392;
        Mon, 5 Nov 2018 07:38:34 GMT
Received: from [10.159.211.29] (/10.159.211.29)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 04 Nov 2018 23:38:34 -0800
Subject: Re: [PATCH 4.18 093/150] rds: RDS (tcp) hangs on sendto() to
 unresponding address
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org,
        Santosh Shilimkar <santosh.shilimkar@oracle.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
References: <20181102182902.250560510@linuxfoundation.org>
 <20181102182909.932793629@linuxfoundation.org>
From:   Ka-Cheong Poon <ka-cheong.poon@oracle.com>
Organization: Oracle Corporation
Message-ID: <e1f81ca0-3f7c-cdc9-cd9c-12af15005cdb@oracle.com>
Date:   Mon, 5 Nov 2018 15:38:25 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181102182909.932793629@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9067 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1811050070
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/3/18 2:34 AM, Greg Kroah-Hartman wrote:
> 4.18-stable review patch.  If anyone has any objections, please let me know.


This patch has a problem.  I am working on a fix for that.  Please
do not include it in the stable release.  Thanks.


> ------------------
> 
> [ Upstream commit 9a4890bd6d6325a1c88564a20ab310b2d56f6094 ]
> 
> In rds_send_mprds_hash(), if the calculated hash value is non-zero and
> the MPRDS connections are not yet up, it will wait.  But it should not
> wait if the send is non-blocking.  In this case, it should just use the
> base c_path for sending the message.
> 
> Signed-off-by: Ka-Cheong Poon <ka-cheong.poon@oracle.com>
> Acked-by: Santosh Shilimkar <santosh.shilimkar@oracle.com>
> Signed-off-by: David S. Miller <davem@davemloft.net>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>   net/rds/send.c | 13 ++++++++++---
>   1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/net/rds/send.c b/net/rds/send.c
> index 59f17a2335f4..0e54ca0f4e9e 100644
> --- a/net/rds/send.c
> +++ b/net/rds/send.c
> @@ -1006,7 +1006,8 @@ static int rds_cmsg_send(struct rds_sock *rs, struct rds_message *rm,
>   	return ret;
>   }
>   
> -static int rds_send_mprds_hash(struct rds_sock *rs, struct rds_connection *conn)
> +static int rds_send_mprds_hash(struct rds_sock *rs,
> +			       struct rds_connection *conn, int nonblock)
>   {
>   	int hash;
>   
> @@ -1022,10 +1023,16 @@ static int rds_send_mprds_hash(struct rds_sock *rs, struct rds_connection *conn)
>   		 * used.  But if we are interrupted, we have to use the zero
>   		 * c_path in case the connection ends up being non-MP capable.
>   		 */
> -		if (conn->c_npaths == 0)
> +		if (conn->c_npaths == 0) {
> +			/* Cannot wait for the connection be made, so just use
> +			 * the base c_path.
> +			 */
> +			if (nonblock)
> +				return 0;
>   			if (wait_event_interruptible(conn->c_hs_waitq,
>   						     conn->c_npaths != 0))
>   				hash = 0;
> +		}
>   		if (conn->c_npaths == 1)
>   			hash = 0;
>   	}
> @@ -1170,7 +1177,7 @@ int rds_sendmsg(struct socket *sock, struct msghdr *msg, size_t payload_len)
>   	}
>   
>   	if (conn->c_trans->t_mp_capable)
> -		cpath = &conn->c_path[rds_send_mprds_hash(rs, conn)];
> +		cpath = &conn->c_path[rds_send_mprds_hash(rs, conn, nonblock)];
>   	else
>   		cpath = &conn->c_path[0];
>   
> 


-- 
K. Poon
ka-cheong.poon@oracle.com


