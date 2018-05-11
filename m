Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752811AbeEKJ1x (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 05:27:53 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44250 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752165AbeEKJ1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 05:27:51 -0400
Subject: Re: [PATCH v5 6/7] ocxl: Add an IOCTL so userspace knows what OCXL
 features are available
To: "Alastair D'Silva" <alastair@au1.ibm.com>,
        linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        mikey@neuling.org, vaibhav@linux.vnet.ibm.com,
        aneesh.kumar@linux.vnet.ibm.com, malat@debian.org,
        felix@linux.vnet.ibm.com, pombredanne@nexb.com,
        sukadev@linux.vnet.ibm.com, npiggin@gmail.com,
        gregkh@linuxfoundation.org, arnd@arndb.de,
        andrew.donnellan@au1.ibm.com, fbarrat@linux.vnet.ibm.com,
        corbet@lwn.net, "Alastair D'Silva" <alastair@d-silva.org>
References: <20180511061303.10728-1-alastair@au1.ibm.com>
 <20180511061303.10728-7-alastair@au1.ibm.com>
From: Frederic Barrat <fbarrat@linux.ibm.com>
Date: Fri, 11 May 2018 11:27:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180511061303.10728-7-alastair@au1.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18051109-0012-0000-0000-000005D5962E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18051109-0013-0000-0000-000019529D93
Message-Id: <78d387c5-0bf9-4891-7342-e703195d379a@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-11_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805110091
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 11/05/2018 à 08:13, Alastair D'Silva a écrit :
> From: Alastair D'Silva <alastair@d-silva.org>
> 
> In order for a userspace AFU driver to call the POWER9 specific
> OCXL_IOCTL_ENABLE_P9_WAIT, it needs to verify that it can actually
> make that call.
> 
> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> ---

Acked-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>


>   drivers/misc/ocxl/file.c | 25 +++++++++++++++++++++++++
>   include/uapi/misc/ocxl.h |  6 ++++++
>   2 files changed, 31 insertions(+)
> 
> diff --git a/drivers/misc/ocxl/file.c b/drivers/misc/ocxl/file.c
> index eb409a469f21..33ae46ce0a8a 100644
> --- a/drivers/misc/ocxl/file.c
> +++ b/drivers/misc/ocxl/file.c
> @@ -168,12 +168,32 @@ static long afu_ioctl_enable_p9_wait(struct ocxl_context *ctx,
>   }
>   #endif
> 
> +
> +static long afu_ioctl_get_features(struct ocxl_context *ctx,
> +		struct ocxl_ioctl_features __user *uarg)
> +{
> +	struct ocxl_ioctl_features arg;
> +
> +	memset(&arg, 0, sizeof(arg));
> +
> +#ifdef CONFIG_PPC64
> +	if (cpu_has_feature(CPU_FTR_P9_TIDR))
> +		arg.flags[0] |= OCXL_IOCTL_FEATURES_FLAGS0_P9_WAIT;
> +#endif
> +
> +	if (copy_to_user(uarg, &arg, sizeof(arg)))
> +		return -EFAULT;
> +
> +	return 0;
> +}
> +
>   #define CMD_STR(x) (x == OCXL_IOCTL_ATTACH ? "ATTACH" :			\
>   			x == OCXL_IOCTL_IRQ_ALLOC ? "IRQ_ALLOC" :	\
>   			x == OCXL_IOCTL_IRQ_FREE ? "IRQ_FREE" :		\
>   			x == OCXL_IOCTL_IRQ_SET_FD ? "IRQ_SET_FD" :	\
>   			x == OCXL_IOCTL_GET_METADATA ? "GET_METADATA" :	\
>   			x == OCXL_IOCTL_ENABLE_P9_WAIT ? "ENABLE_P9_WAIT" :	\
> +			x == OCXL_IOCTL_GET_FEATURES ? "GET_FEATURES" :	\
>   			"UNKNOWN")
> 
>   static long afu_ioctl(struct file *file, unsigned int cmd,
> @@ -239,6 +259,11 @@ static long afu_ioctl(struct file *file, unsigned int cmd,
>   		break;
>   #endif
> 
> +	case OCXL_IOCTL_GET_FEATURES:
> +		rc = afu_ioctl_get_features(ctx,
> +				(struct ocxl_ioctl_features __user *) args);
> +		break;
> +
>   	default:
>   		rc = -EINVAL;
>   	}
> diff --git a/include/uapi/misc/ocxl.h b/include/uapi/misc/ocxl.h
> index 561e6f0dfcb7..97937cfa3baa 100644
> --- a/include/uapi/misc/ocxl.h
> +++ b/include/uapi/misc/ocxl.h
> @@ -55,6 +55,11 @@ struct ocxl_ioctl_p9_wait {
>   	__u64 reserved3[3];
>   };
> 
> +#define OCXL_IOCTL_FEATURES_FLAGS0_P9_WAIT	0x01
> +struct ocxl_ioctl_features {
> +	__u64 flags[4];
> +};
> +
>   struct ocxl_ioctl_irq_fd {
>   	__u64 irq_offset;
>   	__s32 eventfd;
> @@ -70,5 +75,6 @@ struct ocxl_ioctl_irq_fd {
>   #define OCXL_IOCTL_IRQ_SET_FD	_IOW(OCXL_MAGIC, 0x13, struct ocxl_ioctl_irq_fd)
>   #define OCXL_IOCTL_GET_METADATA _IOR(OCXL_MAGIC, 0x14, struct ocxl_ioctl_metadata)
>   #define OCXL_IOCTL_ENABLE_P9_WAIT	_IOR(OCXL_MAGIC, 0x15, struct ocxl_ioctl_p9_wait)
> +#define OCXL_IOCTL_GET_FEATURES _IOR(OCXL_MAGIC, 0x16, struct ocxl_ioctl_features)
> 
>   #endif /* _UAPI_MISC_OCXL_H */
> 
