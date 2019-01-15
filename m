Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCA45C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 07:04:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85E0020578
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 07:04:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="sQ10sG35"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727699AbfAOHEe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 02:04:34 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:47060 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725840AbfAOHEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 02:04:34 -0500
Received: by mail-qk1-f193.google.com with SMTP id q1so956937qkf.13
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 23:04:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=t1UgGwc1d3HxCynXzh3txA+ATyFfqJWjhLLSOxZwXXI=;
        b=sQ10sG35TlSJruk4nTfqnMN/c2dS2e+pDdjz77SUQZKereX8og+tVrzgjxozqx1KJf
         kjJO4BJez2GO8uG3M3PCwO5VO0hLSBVriA4XQ0PC8+TGqaRto/UdfIsiqOc8CYO5ePe6
         vJaMqJcuY4n6J2N193zSqpusIqPz1NvmKNn1MHtv6QRRfObIImGj7lkzL4R1DCguwPw2
         jXSW+61UwgEZMoptpQz0CItGFoOi3e7sR8IpBHN73ZTFiPXQlwS1whF/KvVC82mNusHr
         Gpp2z+IxfGuIx4Eyf4vxS0Mbbk8LoIjirtFIBDYp5BXWFaYYewgOKW8awwip0ZzvQSPA
         O6gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=t1UgGwc1d3HxCynXzh3txA+ATyFfqJWjhLLSOxZwXXI=;
        b=e0fcx2wZKd/QsTeAjQQyaiMQTZGpQ/z94+XLybl1qMLkI1QHdDOd3Ev/bRUnpt+eSB
         NmSMg0XfpMuTw2iNlGR2xh1HGEJLhMlgvVcvrz2djwT8rmhu4QerLm3iwy/8qTyAPpn9
         DdHDZItVmvrVZbFjaydE8EOsJNNtAnKU7Jlwjgg1nkNrlUOQ+qHImDxNE9RT7TUlrDJR
         NnhoYam6oji1NhmMTex9kh9ah9Uq0ZcCpul44fSvKD8u5Q00haVg9jOwg6quHh1l9rF0
         xW3QmP3ymy/6sr9R1tRrb9Ii3SflPIGREDrU9hhKdp0CbXkVtCBolm6oQV12DROVI2ue
         Y3sQ==
X-Gm-Message-State: AJcUukf0b15wO6z1mRtzYUnrNefLnDi1yV67GX78mOxN0NGkuqF3HTc0
        7oFB3kt20HYEBNvL8PYpLjSRhV2uhSnmeQ==
X-Google-Smtp-Source: ALg8bN4KuS5aOPy9cDIEkumnMBEt0Urgq4le74uocBK/C5uIR9waaAwBOMHhGYKqUITPvaaREB1vNQ==
X-Received: by 2002:a37:5686:: with SMTP id k128mr1609257qkb.29.1547535873682;
        Mon, 14 Jan 2019 23:04:33 -0800 (PST)
Received: from ovpn-120-55.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id 128sm25169918qkn.77.2019.01.14.23.04.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Jan 2019 23:04:33 -0800 (PST)
Subject: Re: [PATCH] kvm: add proper frame pointer logic for vmx
To:     pbonzini@redhat.com, rkrcmar@redhat.com
Cc:     sean.j.christopherson@intel.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190115064459.70513-1-cai@lca.pw>
From:   Qian Cai <cai@lca.pw>
Message-ID: <a6477022-bbc0-fc00-2c8e-75007b468d3f@lca.pw>
Date:   Tue, 15 Jan 2019 02:04:31 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20190115064459.70513-1-cai@lca.pw>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/15/19 1:44 AM, Qian Cai wrote:
> compilation warning since v5.0-rc1,
> 
> arch/x86/kvm/vmx/vmx.o: warning: objtool: vmx_vcpu_run.part.17()+0x3171:
> call without frame pointer save/setup
> 
> Fixes: 453eafbe65f (KVM: VMX: Move VM-Enter + VM-Exit handling to
> non-inline sub-routines)

Oops, wrong fix. Back to square one.
