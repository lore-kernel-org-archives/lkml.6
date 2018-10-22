Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A5CBC004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 23:23:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72732205F4
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 23:23:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YJkcWHQn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72732205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbeJWHoO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 03:44:14 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:51582 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbeJWHoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 03:44:14 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9MNJ1NM140817;
        Mon, 22 Oct 2018 23:23:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=kPEyeQSdPHe012wqN1z3jF4uJcp4DFzXBU8UWvUmZ1c=;
 b=YJkcWHQnPOrT8VYWoWJESxy50GhyTKMvLvc6OtYOTek6M3dNnVTtnOdI/SE+42vdEWdA
 iPJZ76NrjOagB1Oampck5HWu/M55DUfHxwpwc3APdH1pV6YEV9uLEZHeEqo88FmA2i1i
 A7Sc4u4V1wm3XNXYlH8aS/ys1IQyaG7RaI4tC9RolIwogw+qZ+EVMKQTeJUqCx/wMtgC
 gFPnrjqzCzqZ36JQkxWnPyjHXgmXnfgKFXiuQnKPcwhoc/S3pJjClc/qIkujTtVBmh0u
 KT8ennR1bGVCZLmynKRL2ktnZtXc8uroGcuJCKKDDJ5A4SkGeitp07VBur6o4JQeqjOv Ag== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2n7w0qhpaa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Oct 2018 23:23:11 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w9MNN5BR006632
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Oct 2018 23:23:05 GMT
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w9MNN40X025000;
        Mon, 22 Oct 2018 23:23:04 GMT
Received: from dhcp-10-132-91-181.usdhcp.oraclecorp.com (/10.132.91.181)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 22 Oct 2018 16:23:04 -0700
Subject: Re: [PATCH v2] KVM/nVMX: Do not validate that posted_intr_desc_addr
 is page aligned
To:     KarimAllah Ahmed <karahmed@amazon.de>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org
References: <1540071779-20848-1-git-send-email-karahmed@amazon.de>
 <1540075827-21270-1-git-send-email-karahmed@amazon.de>
From:   Krish Sadhukhan <krish.sadhukhan@oracle.com>
Message-ID: <57f63d5b-903c-4b28-da79-151528dc7316@oracle.com>
Date:   Mon, 22 Oct 2018 16:23:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <1540075827-21270-1-git-send-email-karahmed@amazon.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9054 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810220196
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/20/2018 03:50 PM, KarimAllah Ahmed wrote:
> The spec only requires the posted interrupt descriptor address to be
> 64-bytes aligned (i.e. bits[0:5] == 0). Using page_address_valid also
> forces the address to be page aligned.
>
> Only validate that the address does not cross the maximum physical address
> without enforcing a page alignment.
>
> v1 -> v2:
> - Add a missing parenthesis (dropped while merging!)
>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Radim Krčmář <rkrcmar@redhat.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: H. Peter Anvin <hpa@zytor.com>
> Cc: x86@kernel.org
> Cc: kvm@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Fixes: 6de84e581c0 ("nVMX x86: check posted-interrupt descriptor addresss on vmentry of L2")
> Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
> ---
>   arch/x86/kvm/vmx.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
> index 38f1a16..bb0fcdb 100644
> --- a/arch/x86/kvm/vmx.c
> +++ b/arch/x86/kvm/vmx.c
> @@ -11667,7 +11667,7 @@ static int nested_vmx_check_apicv_controls(struct kvm_vcpu *vcpu,
>   	    !nested_exit_intr_ack_set(vcpu) ||
>   	    (vmcs12->posted_intr_nv & 0xff00) ||
>   	    (vmcs12->posted_intr_desc_addr & 0x3f) ||
> -	    (!page_address_valid(vcpu, vmcs12->posted_intr_desc_addr))))
> +	    (vmcs12->posted_intr_desc_addr >> cpuid_maxphyaddr(vcpu))))
>   		return -EINVAL;
>   
>   	/* tpr shadow is needed by all apicv features. */

Reviewed-by: Krish Sadhuhan <krish.sadhukhan@oracle.com>
