Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB51BC6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 12:14:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 634E720844
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 12:14:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dfg/ucnh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 634E720844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728966AbeGYN0S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 09:26:18 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:40246 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728762AbeGYN0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 09:26:17 -0400
Received: by mail-wm0-f65.google.com with SMTP id y9-v6so4976406wma.5;
        Wed, 25 Jul 2018 05:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:openpgp:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=343G3UEz0KHY0uip0lgGFLNWQFtwrjP7j7tnpZS81H8=;
        b=dfg/ucnhj4nAzuKRKbLAoSYGq+Y4ndDYdeTm0wNzCzi6vgb8J4bwxyt//wNwc3mSH9
         VpJSJTPvTjflKev1vssomc8UrQx6EfCAfgEwQqcJkWkqa3XegDFUXOCFMqrup++2GWEU
         h+ZTIzjjp1ZHYOYD+O82/dXXvrqDBxIDXBiV14z/QZoDBipAgKpRZ4/SAfiIZ87m+HyF
         KBe633odANhgDwLHupalf26/IW5yDlQ2EMfjOCsSsUid4CTgkTJjdVQvEAq0MdCJlA+q
         m1EDhYIxOWOFwzhw59hAuPasf3EjIrwfY8yPWZI3EeDorzYrPuwPfPdnIqbbXLLypz2G
         Na0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:openpgp
         :autocrypt:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=343G3UEz0KHY0uip0lgGFLNWQFtwrjP7j7tnpZS81H8=;
        b=PABy8Mda6/7oADKBs9ljrKr5cx4EQCwASHsZIO8RKcYhWYtvI1hliSFIR3ZJuStW/f
         iOniFk6wQDAieWgBlx1r8U+iWYS4/Dq8ktkteXxKPHcYwYIhB5ATrbPkFyG2A2jMBYBE
         ir5/AwJ/lCzjZUOFGF98E93FuVi4Mw5/U2SQySd/DUN7hqN180BY6cynbEQW47CK6OfM
         bVphPafmPlabjZiuLQchFZG3FH8GBHL1c+kvUhXItWzlhZ7N5AcPoNBlJa02PwSAGVHv
         /mGfh2XKF7AGYvT4tcqYXGicZFeGnAksOQqXwHADctgwFv5s0pHhi82LqRG5j6QoCU25
         gedw==
X-Gm-Message-State: AOUpUlGSO8VjoIE/sqUb526jp1mvv9EbMOtT4dhDGZr+mUoCk8GUdM4e
        ZjqLtJ0xQaNPCMUPFGiYcdw=
X-Google-Smtp-Source: AAOMgpeVp2+H93XUyzkOUuKzpJGv9j6OuadLZa8M0Ff5Ed4ydtq0N2RjFpzGIKfNhQhooY6Ph6YrEg==
X-Received: by 2002:a1c:207:: with SMTP id 7-v6mr4634214wmc.146.1532520891447;
        Wed, 25 Jul 2018 05:14:51 -0700 (PDT)
Received: from [10.32.181.50] (nat-pool-mxp-t.redhat.com. [149.6.153.186])
        by smtp.googlemail.com with ESMTPSA id t1-v6sm5660495wmt.40.2018.07.25.05.14.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Jul 2018 05:14:50 -0700 (PDT)
Subject: Re: [PATCH v2 6/6] KVM: nVMX: optimize prepare_vmcs02{,_full} for
 Enlightened VMCS case
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     kvm@vger.kernel.org,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Roman Kagan <rkagan@virtuozzo.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        Mohammed Gamal <mmorsy@redhat.com>,
        Cathy Avery <cavery@redhat.com>, linux-kernel@vger.kernel.org,
        Jim Mattson <jmattson@google.com>,
        Liran Alon <liran.alon@oracle.com>
References: <20180621123046.29606-1-vkuznets@redhat.com>
 <20180621123046.29606-7-vkuznets@redhat.com>
 <a826fd88-0199-8e7b-ebfc-290e936b5efc@redhat.com>
 <87va93pv6w.fsf@vitty.brq.redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
Message-ID: <46052d1e-9ee1-8cee-3f7c-cf27b1cd0373@redhat.com>
Date:   Wed, 25 Jul 2018 14:14:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <87va93pv6w.fsf@vitty.brq.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/07/2018 10:37, Vitaly Kuznetsov wrote:
>> Why is this needed?  If it weren't for it, you could pass hv_evmcs
>> directly to evmcs_needs_write, which would simplify the code a bit in
>> the caller.
> This is an equivalent of prepare_vmcs02()/prepare_vmcs02_full() split
> for eVMCS case: when we switch from L2 guest A to L2 guest B we need to
> write the whole VMCS so evmcs_needs_write() needs to return true.

Right, I missed the dirty_vmcs12 assignment in patch 5.

But is L0 allowed to write to hv_clean_fields?  One possibility is to
add a dirty_evmcs field to struct nested_vmx, and "OR" ~hv_clean_fields
into it at the beginning of prepare_vmcs02.

Something like

	if (vmx->nested.hv_evmcs) {
		vmx->nested.dirty_evmcs |=
			~vmx->nested.hv_evmcs->hv_clean_fields;
		prepare_vmcs02_full(vcpu, vmcs12,
				    vmx->nested.dirty_evmcs);
	} else if (vmx->nested.dirty_vmcs12) {
		prepare_vmcs02_full(vcpu, vmcs12, ~0);
	}

	...
	vmx->nested.dirty_evmcs = 0;
	vmx->nested.dirty_vmcs12 = false;

?

Paolo

> We can, however, make an optimisation: forcefuly reset hv_clean_fields
> mask on enlightened vmptrld making 'dirty_vmcs12' check redundant.

