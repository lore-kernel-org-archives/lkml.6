Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D74DC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 16:45:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 365922098B
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 16:45:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Kt+mfLjt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 365922098B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbeHWUQW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 16:16:22 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:56477 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726423AbeHWUQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 16:16:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1535042747; x=1566578747;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CoHMPlhqugTAQYgBkznbRxMsxGgtSPczhTyqxLEVLqE=;
  b=Kt+mfLjtihunTet/G7uKTOrqQJ38IVHp2P5yxKzVu1iZxlkiyVw+ODo9
   NR7IpCSksePMuHxt9HJpN1wGXuCZE7WlwwFCnfp3U+f8/T7+0cJUD4Wgn
   DvA9JPTAjZFPhVcJBoBzSsTFxYUHUE2bR7kevcVGAfCb3kr+0T1VNeTtf
   4=;
X-IronPort-AV: E=Sophos;i="5.53,278,1531785600"; 
   d="scan'208";a="755549947"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-1a-67b371d8.us-east-1.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 23 Aug 2018 16:41:14 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1a-67b371d8.us-east-1.amazon.com (8.14.7/8.14.7) with ESMTP id w7NGcntq102245
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Thu, 23 Aug 2018 16:38:53 GMT
Received: from EX13D01UWB002.ant.amazon.com (10.43.161.136) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 23 Aug 2018 16:38:53 +0000
Received: from EX13MTAUWB001.ant.amazon.com (10.43.161.207) by
 EX13d01UWB002.ant.amazon.com (10.43.161.136) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 23 Aug 2018 16:38:53 +0000
Received: from localhost (10.55.160.47) by mail-relay.amazon.com
 (10.43.161.249) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Thu, 23 Aug 2018 16:38:52 +0000
Date:   Thu, 23 Aug 2018 09:38:52 -0700
From:   Eduardo Valentin <eduval@amazon.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
CC:     <kvm@vger.kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/kvm/nVMX: avoid redundant double assignment of
 nested_run_pending
Message-ID: <20180823163852.GA31976@u40b0340c692b58f6553c.ant.amazon.com>
References: <20180823162424.13282-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180823162424.13282-1-vkuznets@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 23, 2018 at 06:24:24PM +0200, Vitaly Kuznetsov wrote:
> nested_run_pending is set 20 lines above and check_vmentry_prereqs()/
> check_vmentry_postreqs() don't seem to be resetting it (the later, however,
> checks it).
> 

Reviewed-by: Eduardo Valentin <eduval@amazon.com>

> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  arch/x86/kvm/vmx.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
> index 6c3514750d0c..8a63b8cf9458 100644
> --- a/arch/x86/kvm/vmx.c
> +++ b/arch/x86/kvm/vmx.c
> @@ -14221,9 +14221,6 @@ static int vmx_set_nested_state(struct kvm_vcpu *vcpu,
>  	    check_vmentry_postreqs(vcpu, vmcs12, &exit_qual))
>  		return -EINVAL;
>  
> -	if (kvm_state->flags & KVM_STATE_NESTED_RUN_PENDING)
> -		vmx->nested.nested_run_pending = 1;
> -
>  	vmx->nested.dirty_vmcs12 = true;
>  	ret = enter_vmx_non_root_mode(vcpu, NULL);
>  	if (ret)
> -- 
> 2.14.4
> 
> 

-- 
All the best,
Eduardo Valentin
