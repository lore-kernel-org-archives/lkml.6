Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752429AbeBFIms (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 03:42:48 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40272 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752203AbeBFImk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 03:42:40 -0500
Subject: Re: [PATCH 02/10] tooling headers: Synchronize updated s390 kvm UAPI
 headers
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Wang Nan <wangnan0@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20180205195620.9010-1-acme@kernel.org>
 <20180205195620.9010-3-acme@kernel.org>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 6 Feb 2018 09:42:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180205195620.9010-3-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18020608-0008-0000-0000-000004C9D7FF
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18020608-0009-0000-0000-00001E5D8371
Message-Id: <b2534b23-ea52-4721-e2cb-f838a931b405@de.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-06_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802060108
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnaldo

what is the proposed way of forwarding kvm uapi changes to the perf copy?
Are you going to detect and fixup that yourself? Do you want to be notified?
Or do you even want to have a patch?


On 02/05/2018 08:56 PM, Arnaldo Carvalho de Melo wrote:
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> The 35b3fde6203b ("KVM: s390: wire up bpb feature") was noticed by the
> perf build process:
> 
>   Warning: Kernel ABI header at 'tools/arch/s390/include/uapi/asm/kvm.h' differs from latest version at 'arch/s390/include/uapi/asm/kvm.h'
> 
> The changes in this cset don't cause or require changes in tools/perf/,
> so just update the copy to silence the build warning.
> 
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> Cc: David Ahern <dsahern@gmail.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Radim Krčmář <rkrcmar@redhat.com>
> Cc: Wang Nan <wangnan0@huawei.com>
> Link: https://lkml.kernel.org/n/tip-kif2fdkcaewj8iqw6lwyil8s@git.kernel.org
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/arch/s390/include/uapi/asm/kvm.h | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/arch/s390/include/uapi/asm/kvm.h b/tools/arch/s390/include/uapi/asm/kvm.h
> index 38535a57fef8..4cdaa55fabfe 100644
> --- a/tools/arch/s390/include/uapi/asm/kvm.h
> +++ b/tools/arch/s390/include/uapi/asm/kvm.h
> @@ -224,6 +224,7 @@ struct kvm_guest_debug_arch {
>  #define KVM_SYNC_RICCB  (1UL << 7)
>  #define KVM_SYNC_FPRS   (1UL << 8)
>  #define KVM_SYNC_GSCB   (1UL << 9)
> +#define KVM_SYNC_BPBC   (1UL << 10)
>  /* length and alignment of the sdnx as a power of two */
>  #define SDNXC 8
>  #define SDNXL (1UL << SDNXC)
> @@ -247,7 +248,9 @@ struct kvm_sync_regs {
>  	};
>  	__u8  reserved[512];	/* for future vector expansion */
>  	__u32 fpc;		/* valid on KVM_SYNC_VRS or KVM_SYNC_FPRS */
> -	__u8 padding1[52];	/* riccb needs to be 64byte aligned */
> +	__u8 bpbc : 1;		/* bp mode */
> +	__u8 reserved2 : 7;
> +	__u8 padding1[51];	/* riccb needs to be 64byte aligned */
>  	__u8 riccb[64];		/* runtime instrumentation controls block */
>  	__u8 padding2[192];	/* sdnx needs to be 256byte aligned */
>  	union {
> 
