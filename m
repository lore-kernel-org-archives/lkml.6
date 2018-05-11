Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752774AbeEKIqr (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 04:46:47 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40012 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750806AbeEKIqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 04:46:46 -0400
Subject: Re: [PATCH v5 2/7] powerpc: Use TIDR CPU feature to control TIDR
 allocation
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
 <20180511061303.10728-3-alastair@au1.ibm.com>
From: Frederic Barrat <fbarrat@linux.ibm.com>
Date: Fri, 11 May 2018 10:46:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180511061303.10728-3-alastair@au1.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18051108-0040-0000-0000-000004387FC2
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18051108-0041-0000-0000-0000263CC7CE
Message-Id: <bde93f43-92b8-d3c8-a5c5-eb1a7495b765@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-11_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805110084
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 11/05/2018 à 08:12, Alastair D'Silva a écrit :
> From: Alastair D'Silva <alastair@d-silva.org>
> 
> Switch the use of TIDR on it's CPU feature, rather than assuming it
> is available based on architecture.
> 
> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> ---

Reviewed-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>


>   arch/powerpc/kernel/process.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
> index 1237f13fed51..3b00da47699b 100644
> --- a/arch/powerpc/kernel/process.c
> +++ b/arch/powerpc/kernel/process.c
> @@ -1154,7 +1154,7 @@ static inline void restore_sprs(struct thread_struct *old_thread,
>   			mtspr(SPRN_TAR, new_thread->tar);
>   	}
> 
> -	if (cpu_has_feature(CPU_FTR_ARCH_300) &&
> +	if (cpu_has_feature(CPU_FTR_P9_TIDR) &&
>   	    old_thread->tidr != new_thread->tidr)
>   		mtspr(SPRN_TIDR, new_thread->tidr);
>   #endif
> @@ -1570,7 +1570,7 @@ void clear_thread_tidr(struct task_struct *t)
>   	if (!t->thread.tidr)
>   		return;
> 
> -	if (!cpu_has_feature(CPU_FTR_ARCH_300)) {
> +	if (!cpu_has_feature(CPU_FTR_P9_TIDR)) {
>   		WARN_ON_ONCE(1);
>   		return;
>   	}
> @@ -1593,7 +1593,7 @@ int set_thread_tidr(struct task_struct *t)
>   {
>   	int rc;
> 
> -	if (!cpu_has_feature(CPU_FTR_ARCH_300))
> +	if (!cpu_has_feature(CPU_FTR_P9_TIDR))
>   		return -EINVAL;
> 
>   	if (t != current)
> 
