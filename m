Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966768AbeE2UqA (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 16:46:00 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42724 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S966767AbeE2Up6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 16:45:58 -0400
Subject: Re: [PATCH v4 5/7] scsi: ipr: Eliminate duplicate barriers on
 weakly-ordered archs
To: Sinan Kaya <okaya@codeaurora.org>, linux-scsi@vger.kernel.org,
        timur@codeaurora.org, sulrich@codeaurora.org
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Brian King <brking@us.ibm.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org
References: <1521514207-10695-1-git-send-email-okaya@codeaurora.org>
 <1521514207-10695-6-git-send-email-okaya@codeaurora.org>
From: Brian King <brking@linux.ibm.com>
Date: Tue, 29 May 2018 15:45:52 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1521514207-10695-6-git-send-email-okaya@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18052920-0016-0000-0000-000008D403A0
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009097; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000264; SDB=6.01039523; UDB=6.00532045; IPR=6.00818652;
 MB=3.00021362; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-29 20:45:56
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18052920-0017-0000-0000-00003EFC8DE1
Message-Id: <a10fa941-1729-2890-50cb-59c4a5b5e596@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-29_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=801 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1805290219
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/19/2018 09:50 PM, Sinan Kaya wrote:
> Code includes barrier() followed by writel(). writel() already has a
> barrier
> on some architectures like arm64.
> 
> This ends up CPU observing two barriers back to back before executing the
> register write.
> 
> Since code already has an explicit barrier call, changing writeX() to
> writeX_relaxed().
> 
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> ---
>  drivers/scsi/ipr.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/scsi/ipr.c b/drivers/scsi/ipr.c
> index e07dd99..209adac 100644
> --- a/drivers/scsi/ipr.c
> +++ b/drivers/scsi/ipr.c
> @@ -762,9 +762,9 @@ static void ipr_mask_and_clear_interrupts(struct ipr_ioa_cfg *ioa_cfg,
> 
>  	/* Set interrupt mask to stop all new interrupts */
>  	if (ioa_cfg->sis64)
> -		writeq(~0, ioa_cfg->regs.set_interrupt_mask_reg);
> +		writeq_relaxed(~0, ioa_cfg->regs.set_interrupt_mask_reg);
>  	else
> -		writel(~0, ioa_cfg->regs.set_interrupt_mask_reg);
> +		writel_relaxed(~0, ioa_cfg->regs.set_interrupt_mask_reg);
> 
>  	/* Clear any pending interrupts */
>  	if (ioa_cfg->sis64)
> @@ -8435,7 +8435,8 @@ static int ipr_reset_enable_ioa(struct ipr_cmnd *ipr_cmd)
>  	wmb();
>  	if (ioa_cfg->sis64) {
>  		/* Set the adapter to the correct endian mode. */
> -		writel(IPR_ENDIAN_SWAP_KEY, ioa_cfg->regs.endian_swap_reg);
> +		writel_relaxed(IPR_ENDIAN_SWAP_KEY,
> +			       ioa_cfg->regs.endian_swap_reg);
>  		int_reg = readl(ioa_cfg->regs.endian_swap_reg);
>  	}
> 

Looks fine to me. Thanks.

Acked-by: Brian King <brking@linux.vnet.ibm.com>

-- 
Brian King
Power Linux I/O
IBM Linux Technology Center
