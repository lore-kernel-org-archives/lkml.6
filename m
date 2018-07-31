Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AEDAC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 07:39:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4553520862
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 07:39:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4553520862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729779AbeGaJSq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 05:18:46 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:53370 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727015AbeGaJSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 05:18:46 -0400
Received: by mail-wm0-f66.google.com with SMTP id s9-v6so1914354wmh.3
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 00:39:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=jgRDtggHzm/CR3uWk1gOXzgKiCDBo6/ammRJs9dHz4Q=;
        b=htU37/wmYzUKkA54cSbrxT6SvEzizpbYvo4vnxCxRx9cSwenVfFB+km60lxEUwUyJQ
         Yy+/7unEqqswwrFlEfCXaf6qZ1znW4NfuuIUF7HRPewtU4idEtYCJk7/KmsmJo+GnQLe
         BUdOZEk8Y9LfCBruaKnMjq+JVcb2BwHA85R9g+vm+PwYGLm3d1DvwgIbHVtp6CcEMN2k
         rr4AU/AwXo5CPmZfou6XCTtd/TNttwdDVF1IfmABMS7Ec10T/G0H1tZVzSP98Tr5HjDy
         920nwDCmROFHE2x9FdjX4Flc/zpRyny8pGoDO/kJOhCkrm24pL4N4piI5v8Mp9f1ygK7
         cEPg==
X-Gm-Message-State: AOUpUlFknnILz24POf4WLBTL1bYVbFkX5JEOxbX+d5D9/aCopuDodWGF
        UKWM0THRDgXeHXyPuXEWXSA9ng==
X-Google-Smtp-Source: AAOMgpclb6VvA1+0n805KZqS5+oTKihXPaSVz4fy8BZ+RiG/wlyyU9Br+R1Q1v0DWqctYI7oVa2Ixg==
X-Received: by 2002:a1c:3314:: with SMTP id z20-v6mr1376011wmz.95.1533022784321;
        Tue, 31 Jul 2018 00:39:44 -0700 (PDT)
Received: from [192.168.10.150] (94-36-184-250.adsl-ull.clienti.tiscali.it. [94.36.184.250])
        by smtp.gmail.com with ESMTPSA id a2-v6sm1295300wmb.6.2018.07.31.00.39.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Jul 2018 00:39:43 -0700 (PDT)
Subject: Re: [PATCH 09/10] KVM: nVMX: include shadow vmcs12 in nested state
To:     Jim Mattson <jmattson@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>,
        Liran Alon <liran.alon@oracle.com>,
        KarimAllah Ahmed <karahmed@amazon.de>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
References: <1532819412-51357-1-git-send-email-pbonzini@redhat.com>
 <1532819412-51357-10-git-send-email-pbonzini@redhat.com>
 <CALMp9eSj+rmgvcEb8=W1M+Z0S4m5hKYjXvxTd6DhQe+SLCi=Kw@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=pbonzini@redhat.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <21c6f364-d2e8-df22-ec7f-3d76c1a0f2be@redhat.com>
Date:   Tue, 31 Jul 2018 09:39:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CALMp9eSj+rmgvcEb8=W1M+Z0S4m5hKYjXvxTd6DhQe+SLCi=Kw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/07/2018 21:11, Jim Mattson wrote:
> Does this work with CONFIG_HARDENED_USERCOPY?

Yes, kmalloc objects are exempt from the check (see new_kmalloc_cache).

> Is VMCS12_SIZE better than sizeof(*vmcs12)? What if we are migrating
> to a destination where sizeof(*vmcs12) is larger than it is on the
> source?

Either those fields won't be used by the destination due to the VMX MSR
values, or migration should have failed due to invalid VMX MSR values.

VMCS12_SIZE is consistent with handle_vmptrld and nested_release_vmcs12.
 If we use sizeof(*vmcs12) in vmx_get_nested_state, we will have to
adjust the copy from/to cached_vmcs12 and cached_shadow_vmcs12 to also
use sizeof(*vmcs12), otherwise:

1) nested_release_vmcs12 can leak arbitrary kernel data to userspace,
because the cached_vmcs12 and cached_shadow_vmcs12 are not zeroed when
allocated.

2) even if we zeroed the allocation in enter_vmx_operation, the guest
could observe a migration because it would change the padding at the end
of the VMCS changes to zeroes; this is strictly speaking not an issue,
but it's ugly.

Paolo

> If userspace doesn't zero the buffer before calling the ioctl,
> then the destination may interpret nonsense as actual VMCS field
> values. However, if we copy the entire page from the kernel, then we
> know that anything beyond the source's sizeof(*vmcs12) will be zero.
