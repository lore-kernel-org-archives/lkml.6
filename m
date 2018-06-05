Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751906AbeFEM5L (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 08:57:11 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33190 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751622AbeFEM5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 08:57:09 -0400
Subject: Re: [PATCH -next] ocxl: Fix missing unlock on error in
 afu_ioctl_enable_p9_wait()
To: Wei Yongjun <weiyongjun1@huawei.com>,
        Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Alastair D'Silva" <alastair@d-silva.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <1528190181-15745-1-git-send-email-weiyongjun1@huawei.com>
From: Frederic Barrat <fbarrat@linux.ibm.com>
Date: Tue, 5 Jun 2018 14:57:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1528190181-15745-1-git-send-email-weiyongjun1@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18060512-0016-0000-0000-000001D85A2B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18060512-0017-0000-0000-0000322B6020
Message-Id: <eb4f541f-cd2a-2af6-0770-fc8cc4f4063b@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-05_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806050150
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 05/06/2018 à 11:16, Wei Yongjun a écrit :
> Add the missing unlock before return from function
> afu_ioctl_enable_p9_wait() in the error handling case.
> 
> Fixes: e948e06fc63a ("ocxl: Expose the thread_id needed for wait on POWER9")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>   drivers/misc/ocxl/file.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/ocxl/file.c b/drivers/misc/ocxl/file.c
> index 33ae46c..e6a6074 100644
> --- a/drivers/misc/ocxl/file.c
> +++ b/drivers/misc/ocxl/file.c
> @@ -139,8 +139,10 @@ static long afu_ioctl_enable_p9_wait(struct ocxl_context *ctx,
>   		// Locks both status & tidr
>   		mutex_lock(&ctx->status_mutex);
>   		if (!ctx->tidr) {
> -			if (set_thread_tidr(current))
> +			if (set_thread_tidr(current)) {
> +				mutex_unlock(&ctx->status_mutex);
>   				return -ENOENT;
> +			}

O_o   Thanks for fixing it

Acked-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>


>   			ctx->tidr = current->thread.tidr;
>   		}
> 
