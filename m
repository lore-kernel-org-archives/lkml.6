Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753919AbeEaEmj (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 00:42:39 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37688 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751890AbeEaEmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 00:42:36 -0400
Subject: Re: [PATCH v5 5/7] ocxl: Expose the thread_id needed for wait on
 POWER9
To: "Alastair D'Silva" <alastair@au1.ibm.com>,
        linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        mikey@neuling.org, vaibhav@linux.vnet.ibm.com,
        aneesh.kumar@linux.vnet.ibm.com, malat@debian.org,
        felix@linux.vnet.ibm.com, pombredanne@nexb.com,
        sukadev@linux.vnet.ibm.com, npiggin@gmail.com,
        gregkh@linuxfoundation.org, arnd@arndb.de, fbarrat@linux.vnet.ibm.com,
        corbet@lwn.net, "Alastair D'Silva" <alastair@d-silva.org>
References: <20180511061303.10728-1-alastair@au1.ibm.com>
 <20180511061303.10728-6-alastair@au1.ibm.com>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Thu, 31 May 2018 14:42:28 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180511061303.10728-6-alastair@au1.ibm.com>
Content-Language: en-AU
X-TM-AS-GCONF: 00
x-cbid: 18053104-0016-0000-0000-000001D63537
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18053104-0017-0000-0000-00003228ABD1
Message-Id: <fc2184c1-eb0f-0116-8565-b2eac4354379@au1.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-31_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1805310051
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/05/18 16:13, Alastair D'Silva wrote:
> From: Alastair D'Silva <alastair@d-silva.org>
> 
> In order to successfully issue as_notify, an AFU needs to know the TID
> to notify, which in turn means that this information should be
> available in userspace so it can be communicated to the AFU.
> 
> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>

Acked-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

Comments below.

> +#ifdef CONFIG_PPC64
> +static long afu_ioctl_enable_p9_wait(struct ocxl_context *ctx,
> +		struct ocxl_ioctl_p9_wait __user *uarg)
> +{
> +	struct ocxl_ioctl_p9_wait arg;
> +
> +	memset(&arg, 0, sizeof(arg));
> +
> +	if (cpu_has_feature(CPU_FTR_P9_TIDR)) {
> +		enum ocxl_context_status status;
> +
> +		// Locks both status & tidr
> +		mutex_lock(&ctx->status_mutex);
> +		if (!ctx->tidr) {
> +			if (set_thread_tidr(current))
> +				return -ENOENT;
> +
> +			ctx->tidr = current->thread.tidr;
> +		}
> +
> +		status = ctx->status;
> +		mutex_unlock(&ctx->status_mutex);
> +
> +		if (status == ATTACHED) {
> +			int rc;
> +			struct link *link = ctx->afu->fn->link;
> +
> +			rc = ocxl_link_update_pe(link, ctx->pasid, ctx->tidr);
> +			if (rc)
> +				return rc;
> +		}
> +
> +		arg.thread_id = ctx->tidr;
> +	} else
> +		return -ENOENT;

I didn't pick this up before - please please please use braces on both 
sides of the if here.

> +
> +	if (copy_to_user(uarg, &arg, sizeof(arg)))
> +		return -EFAULT;
> +
> +	return 0;
> +}
> +#endif

> diff --git a/include/misc/ocxl.h b/include/misc/ocxl.h
> index 51ccf76db293..9ff6ddc28e22 100644
> --- a/include/misc/ocxl.h
> +++ b/include/misc/ocxl.h
> @@ -188,6 +188,15 @@ extern int ocxl_link_add_pe(void *link_handle, int pasid, u32 pidr, u32 tidr,
>   		void (*xsl_err_cb)(void *data, u64 addr, u64 dsisr),
>   		void *xsl_err_data);
>   
> +/**
> + * Update values within a Process Element
> + *
> + * link_handle: the link handle associated with the process element
> + * pasid: the PASID for the AFU context
> + * tid: the new thread id for the process element
> + */
> +extern int ocxl_link_update_pe(void *link_handle, int pasid, __u16 tid);

My earlier comment about __u16 vs u16 applies for this declaration (and 
the body declaration) as well

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
