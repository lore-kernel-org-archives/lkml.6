Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934818AbeBMQZj (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 11:25:39 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:38786 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933927AbeBMQZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 11:25:37 -0500
X-Google-Smtp-Source: AH8x224yOXD/W98wJNNXi+gFo8c7NAFQRigBwcqTh2oJBnvssjApbYkJy5gpknQBweHw8DnLGrUucA==
Subject: Re: [RFC PATCH 1/2] KVM: x86: Add a framework for supporting
 MSR-based features
To: Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: Joerg Roedel <joro@8bytes.org>, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
References: <20180208225833.22074.25995.stgit@tlendack-t1.amdoffice.net>
 <20180208225846.22074.70944.stgit@tlendack-t1.amdoffice.net>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1105042a-327b-9be9-c0be-5f07f7110852@redhat.com>
Date: Tue, 13 Feb 2018 17:25:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180208225846.22074.70944.stgit@tlendack-t1.amdoffice.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/02/2018 23:58, Tom Lendacky wrote:
> +bool kvm_valid_msr_feature(u32 msr, u64 data)
> +{
> +	unsigned int i;
> +
> +	for (i = 0; i < num_msr_based_features; i++) {
> +		struct kvm_msr_based_features *m = msr_based_features + i;
> +
> +		if (msr != m->msr)
> +			continue;
> +
> +		/* Make sure not trying to change unsupported bits */
> +		return (data & ~m->mask) ? false : true;
> +	}
> +
> +	return false;
> +}
> +EXPORT_SYMBOL_GPL(kvm_valid_msr_feature);
> +

This is probably unnecessary too (the allowed values are a bit more
complicated for, you just guessed it, VMX capability MSRs) and you can
just check bits other than LFENCE in svm_set_msr.

Paolo
