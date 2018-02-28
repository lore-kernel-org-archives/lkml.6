Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752291AbeB1LkP (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 06:40:15 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42244 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752183AbeB1LkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 06:40:13 -0500
Subject: Re: [PATCH v2 03/15] s390: zcrypt: externalize AP instructions
 available function
To: Tony Krowiak <akrowiak@linux.vnet.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com,
        bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com,
        alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com,
        alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com,
        jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com,
        fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com
References: <1519741693-17440-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1519741693-17440-4-git-send-email-akrowiak@linux.vnet.ibm.com>
From: Harald Freudenberger <freude@linux.vnet.ibm.com>
Date: Wed, 28 Feb 2018 12:40:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1519741693-17440-4-git-send-email-akrowiak@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18022811-0012-0000-0000-000005B6651E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18022811-0013-0000-0000-0000193273FE
Message-Id: <5a786bdd-44d9-ebca-eb39-2c3d05b7d4be@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-28_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802280141
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/27/2018 03:28 PM, Tony Krowiak wrote:
> If the AP instructions are not available on the linux host, then
> AP devices can not be interpreted by the SIE. The AP bus has a
> function it uses to determine if the AP instructions are
> available. This patch provides a new function that wraps the
> AP bus's function to externalize it for use by KVM.
>
> Signed-off-by: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
> Reviewed-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
> ---
>  arch/s390/include/asm/ap.h   |    7 +++++++
>  drivers/s390/crypto/ap_bus.c |    6 ++++++
>  2 files changed, 13 insertions(+), 0 deletions(-)
>
> diff --git a/arch/s390/include/asm/ap.h b/arch/s390/include/asm/ap.h
> index cfce683..1df6b59 100644
> --- a/arch/s390/include/asm/ap.h
> +++ b/arch/s390/include/asm/ap.h
> @@ -120,4 +120,11 @@ struct ap_queue_status ap_queue_irq_ctrl(ap_qid_t qid,
>  					 struct ap_qirq_ctrl qirqctrl,
>  					 void *ind);
>
> +/**
> + * ap_instructions_installed() - Tests whether AP instructions are installed
> + *
> + * Returns 1 if the AP instructions are installed, otherwise; returns 0
> + */
> +int ap_instructions_installed(void);
> +
>  #endif /* _ASM_S390_AP_H_ */
> diff --git a/drivers/s390/crypto/ap_bus.c b/drivers/s390/crypto/ap_bus.c
> index 48d55dc..089b1cf 100644
> --- a/drivers/s390/crypto/ap_bus.c
> +++ b/drivers/s390/crypto/ap_bus.c
> @@ -211,6 +211,12 @@ int ap_query_configuration(struct ap_config_info *info)
>  }
>  EXPORT_SYMBOL(ap_query_configuration);
>
> +int ap_instructions_installed(void)
> +{
> +	return (ap_instructions_available() == 0);
> +}
> +EXPORT_SYMBOL(ap_instructions_installed);
> +
>  /**
>   * ap_init_configuration(): Allocate and query configuration array.
>   */
Reviewed-by: Harald Freudenberger <freude@linux.vnet.ibm.com>
