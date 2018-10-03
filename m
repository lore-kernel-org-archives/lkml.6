Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64748C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 04:27:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D26921470
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 04:27:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="nVmct+cb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D26921470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbeJCLOO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 07:14:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:37006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726514AbeJCLOO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 07:14:14 -0400
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A7D502147D
        for <linux-kernel@vger.kernel.org>; Wed,  3 Oct 2018 04:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538540855;
        bh=MSexKNeAfYCbWNt0lqwBXI2m6MZAX2Z2x04Cwd1qKMw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nVmct+cbEA/nFaFDoXpWGMlS7l0nOsj2iOEkPINa2meSQIY4bECfPg63tVcAiGjW/
         tDNA9U2RmCZQtVMZ/qpJ4bZd5D0Wfdsog11fY1OTLYtF+EaEpHEgcMIiBpw2uScuRA
         AgFlJCSUAX/+YEG1ash1cNWbF5YLhP4v6LtnAeI0=
Received: by mail-wr1-f49.google.com with SMTP id 61-v6so3746932wrb.6
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 21:27:34 -0700 (PDT)
X-Gm-Message-State: ABuFfogL9f12ZMHEFKsKg8LcGWVEb3Q1L6ZEzt1e8jU4RCvhcDO6uoKF
        ipcj1bnOb36X3D9RzPbZ3BjcwJ7QAHkZxDYPvNbdwQ==
X-Google-Smtp-Source: ACcGV63DINBBuijR5bhTcMdYg3f/GRWXD9Dkt9rrs5IlRw2vDU7BcaXr0xFoj+1S1ycrl3gg/lYhPbWt6q9L2L+4Ug0=
X-Received: by 2002:adf:82e3:: with SMTP id 90-v6mr12031702wrc.131.1538540853032;
 Tue, 02 Oct 2018 21:27:33 -0700 (PDT)
MIME-Version: 1.0
References: <20180903165655.003605184@linuxfoundation.org> <20180903165701.245301231@linuxfoundation.org>
 <20181002080655.GV31855@pcnci.linuxbox.cz>
In-Reply-To: <20181002080655.GV31855@pcnci.linuxbox.cz>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 2 Oct 2018 21:27:21 -0700
X-Gmail-Original-Message-ID: <CALCETrXcJCNFJ3fbFnxvijk4ts_yoxHnqM7xbZTir0MrhnvceA@mail.gmail.com>
Message-ID: <CALCETrXcJCNFJ3fbFnxvijk4ts_yoxHnqM7xbZTir0MrhnvceA@mail.gmail.com>
Subject: Re: [PATCH 4.14 114/165] x86/vdso: Fix vDSO build if a retpoline is emitted
To:     nikola.ciprich@linuxbox.cz
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Andrew Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Matt Rickard <matt@softrans.com.au>,
        Borislav Petkov <bp@alien8.de>, jason.vas.dias@gmail.com,
        David Woodhouse <dwmw2@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andi Kleen <ak@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 2, 2018 at 1:21 AM Nikola Ciprich
<nikola.ciprich@linuxbox.cz> wrote:
>
> Hi Greg and others,
>
> sorry for reporting this so late, but still...
>
> this breaks build on older compilers, since it requires
> -mindirect-branch=thunk-inline -mindirect-branch-register even though
> retpoline support is disabled in kernel config.. is this expected?
>

Nope, my patch was buggy.  Can you test the fix I just sent?
