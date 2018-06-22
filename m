Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEC5EC43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 22:02:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 550B32493D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 22:02:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="K8O8I/Qa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 550B32493D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933724AbeFVWCp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 18:02:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:48578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933127AbeFVWCo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 18:02:44 -0400
Received: from mail-wm0-f53.google.com (mail-wm0-f53.google.com [74.125.82.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 57E9924945
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 22:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529704963;
        bh=pQNWU/bYNwQoDGYvR7WwtrYhpLcuG6zSIMSign/K+WY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=K8O8I/Qag2Ix8h6RWDOg5mZImAJCNcKhObxD5F5imZ1MI+WvxUOrcsAg9o8mLqzoU
         VaSN9DlwzpU953x0I+3+BFLP2h6JhQ0Fybml4LymHYfNnjhaGicFgmdPB3UlOAgQWv
         I+452WTeVr6cmv5QWE0gDqHbckzy02bVLPfv3k34=
Received: by mail-wm0-f53.google.com with SMTP id p11-v6so4087734wmc.4
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 15:02:43 -0700 (PDT)
X-Gm-Message-State: APt69E0TxxsCYvrQuKoEU+ic/0+ZkimA2/iiduLgJuMH2Q+8JWkQGY9g
        3LLly87z5g1tLNeDsGspnXN2kVI9ulQHRU1vjZwFrg==
X-Google-Smtp-Source: AAOMgpeP6CHl8+JqFWx9ZZJJntfznYHDPWF3eGOqsIuWbJ3uoncOtHtlIEMlN426+4YS4wP0YDlIWMUp/4iN/uRd1Kg=
X-Received: by 2002:a1c:34c9:: with SMTP id b192-v6mr3019376wma.21.1529704961786;
 Fri, 22 Jun 2018 15:02:41 -0700 (PDT)
MIME-Version: 1.0
References: <1529536506-26237-1-git-send-email-chang.seok.bae@intel.com>
 <1529536506-26237-8-git-send-email-chang.seok.bae@intel.com>
 <alpine.DEB.2.21.1806221714260.2402@nanos.tec.linutronix.de>
 <80C1F514-1B4D-4CDC-BD46-6C3AA9601446@amacapital.net> <alpine.DEB.2.21.1806221817280.2402@nanos.tec.linutronix.de>
 <C9BB696F3A938947B10DCAD29FAB8FFA66BDB78B@CRSMSX101.amr.corp.intel.com>
In-Reply-To: <C9BB696F3A938947B10DCAD29FAB8FFA66BDB78B@CRSMSX101.amr.corp.intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 22 Jun 2018 15:02:30 -0700
X-Gmail-Original-Message-ID: <CALCETrU5yUFiY09yqzbZV3gYyMyqGPBPs2n31PRNkhyYZsNrgA@mail.gmail.com>
Message-ID: <CALCETrU5yUFiY09yqzbZV3gYyMyqGPBPs2n31PRNkhyYZsNrgA@mail.gmail.com>
Subject: Re: [PATCH v4 7/7] x86/vdso: Move out the CPU number store
To:     "Bae, Chang Seok" <chang.seok.bae@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Andrew Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Metzger, Markus T" <markus.t.metzger@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 11:02 AM Bae, Chang Seok
<chang.seok.bae@intel.com> wrote:
>
> > Still setup_cpu_number() sucks.
>
> How about setup_cpu_and_node_number()?

setup_fast_cpu_node_nr()?  setup_cpunr_regs()?  I don't have any
brilliant ideas.  Thomas?
