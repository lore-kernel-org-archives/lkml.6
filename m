Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751956AbeB0VTE (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 16:19:04 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:53718 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751550AbeB0VTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 16:19:02 -0500
Subject: Re: [PATCH] pvcalls-front: 64-bit align flags
To: Stefano Stabellini <sstabellini@kernel.org>, jgross@suse.com
Cc: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
References: <alpine.DEB.2.10.1802271150020.4239@sstabellini-ThinkPad-X260>
From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Message-ID: <b7ec592a-bbd1-48d3-1a1f-92a8ed4a1e48@oracle.com>
Date: Tue, 27 Feb 2018 16:19:33 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.10.1802271150020.4239@sstabellini-ThinkPad-X260>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8817 signatures=668681
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=914
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802270263
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/27/2018 02:54 PM, Stefano Stabellini wrote:
> We are using test_and_* operations on the status and flag fields of
> struct sock_mapping. However, these functions require the operand to be
> 64-bit aligned on arm64. Currently, only status is 64-bit aligned.
>
> Make flags 64-bit aligned by introducing an explicit padding field.
>
> Signed-off-by: Stefano Stabellini <stefano@aporeto.com>
>
> diff --git a/drivers/xen/pvcalls-front.c b/drivers/xen/pvcalls-front.c
> index ca5b773..aa07b2a 100644
> --- a/drivers/xen/pvcalls-front.c
> +++ b/drivers/xen/pvcalls-front.c
> @@ -78,6 +78,7 @@ struct sock_mapping {
>  #define PVCALLS_STATUS_BIND          1
>  #define PVCALLS_STATUS_LISTEN        2
>  			uint8_t status;
> +			uint8_t pad[7];

Does this guarantee alignment (for either status or flag)?

-boris

>  		/*
>  		 * Internal state-machine flags.
>  		 * Only one accept operation can be inflight for a socket.
