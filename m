Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934842AbeE2OQ3 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 10:16:29 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41122 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934158AbeE2OQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 10:16:28 -0400
Subject: Re: [PATCH -next] misc: ibmvmc: Use GFP_ATOMIC under spin lock
To: Wei Yongjun <weiyongjun1@huawei.com>,
        "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>,
        Steven Royer <seroyer@linux.vnet.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <1527327959-83701-1-git-send-email-weiyongjun1@huawei.com>
From: "Bryant G. Ly" <bryantly@linux.ibm.com>
Date: Tue, 29 May 2018 09:15:39 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1527327959-83701-1-git-send-email-weiyongjun1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18052914-0044-0000-0000-0000041F442B
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009096; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000264; SDB=6.01039394; UDB=6.00531969; IPR=6.00818522;
 MB=3.00021359; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-29 14:16:22
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18052914-0045-0000-0000-00000851685D
Message-Id: <995601ab-6fa5-4a72-fd49-337976755861@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-29_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805290163
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/26/18 4:45 AM, Wei Yongjun wrote:

> The function alloc_dma_buffer() is called from ibmvmc_add_buffer(),
> in which a spin lock be held here, so we should use GFP_ATOMIC when
> a lock is held.
>
> Fixes: 0eca353e7ae7 ("misc: IBM Virtual Management Channel Driver (VMC)")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  drivers/misc/ibmvmc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/misc/ibmvmc.c b/drivers/misc/ibmvmc.c
> index fb83d13..8f82bb9 100644
> --- a/drivers/misc/ibmvmc.c
> +++ b/drivers/misc/ibmvmc.c
> @@ -273,7 +273,7 @@ static void *alloc_dma_buffer(struct vio_dev *vdev, size_t size,
>  			      dma_addr_t *dma_handle)
>  {
>  	/* allocate memory */
> -	void *buffer = kzalloc(size, GFP_KERNEL);
> +	void *buffer = kzalloc(size, GFP_ATOMIC);
>
>  	if (!buffer) {
>  		*dma_handle = 0;
>
Reviewed-by: Bryant G. Ly <bryantly@linux.vnet.ibm.com>
