Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBE86C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 22:54:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 770E82086E
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 22:54:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="GQ1GKRQV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 770E82086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726284AbeIZFDv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 01:03:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:40568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725999AbeIZFDv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 01:03:51 -0400
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5181C2089D
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 22:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537916042;
        bh=/n7+qciOD4NhE9DYgfSYN15DDayjfU8GY9wPFHnKQmQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=GQ1GKRQVlGed7oB+LIHXYCIQ2WVSvWjF8/q8Vi/8Iwv4LELbXiqAd3SCJ8qGw9vxs
         mqMjNmZXpNHpiNRutey9SPi6nA2ikCjOfu8uCLHxx8fLQe3QXpvKuN3HX0XzzFsP3o
         9mwBR4hdryK/QZ97jwUm9adXRnDSNzr2icM8XKEg=
Received: by mail-wr1-f43.google.com with SMTP id j15-v6so20890667wrt.8
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 15:54:02 -0700 (PDT)
X-Gm-Message-State: ABuFfoiYOMdWbjvP+hMm41FTrcUwKn9GLQStr0bdaJY/uizCNxWMNQm6
        FfnLVC1kBrijWAgIS1/NB//U087vkR+JJs1i6p7VPA==
X-Google-Smtp-Source: ACcGV604eHWvIGnBLvHU308Mg84noYLW0OrnQd5QP2Fr3JQVekiava8yximWbqFpemm78psi1irVihRN7gzfhSCd5Kg=
X-Received: by 2002:adf:c98d:: with SMTP id f13-v6mr2782183wrh.148.1537916040736;
 Tue, 25 Sep 2018 15:54:00 -0700 (PDT)
MIME-Version: 1.0
References: <20180925130845.9962-1-jarkko.sakkinen@linux.intel.com> <20180925130845.9962-10-jarkko.sakkinen@linux.intel.com>
In-Reply-To: <20180925130845.9962-10-jarkko.sakkinen@linux.intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 25 Sep 2018 15:53:48 -0700
X-Gmail-Original-Message-ID: <CALCETrVAhiwv+g5fzVO3ZSHZgcQKbeeG8r3HUcXO9k7Gi94NdQ@mail.gmail.com>
Message-ID: <CALCETrVAhiwv+g5fzVO3ZSHZgcQKbeeG8r3HUcXO9k7Gi94NdQ@mail.gmail.com>
Subject: Re: [PATCH v14 09/19] x86/mm: x86/sgx: Signal SEGV_SGXERR for #PFs w/ PF_SGX
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     X86 ML <x86@kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        "Christopherson, Sean J" <sean.j.christopherson@intel.com>,
        nhorman@redhat.com, npmccallum@redhat.com,
        "Ayoun, Serge" <serge.ayoun@intel.com>, shay.katz-zamir@intel.com,
        linux-sgx@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Minor nit:

On Tue, Sep 25, 2018 at 6:12 AM Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> From: Sean Christopherson <sean.j.christopherson@intel.com>
>

> by (c) as the kernel doesn't really have any other reasonable option,
> e.g. we could kill the task or panic, but neither is warranted.

Not killing the task is quite nice, but...

> +       /*
> +        * Access is blocked by the Enclave Page Cache Map (EPCM),
> +        * i.e. the access is allowed by the PTE but not the EPCM.
> +        * This usually happens when the EPCM is yanked out from
> +        * under us, e.g. by hardware after a suspend/resume cycle.
> +        * In any case, there is nothing that can be done by the
> +        * kernel to resolve the fault (short of killing the task).

Maybe s/killing the task/sending a signal/?

--Andy
