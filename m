Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61275C43142
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 02:59:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D2A020899
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 02:59:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="orqF3zE1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D2A020899
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726458AbeG2E2Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 00:28:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:34560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726016AbeG2E2Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 00:28:25 -0400
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C5572089A
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jul 2018 02:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532833179;
        bh=S10s21Yul33D3iHRcEy5Z9y6cznqX5z2Skj9eVch6B8=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=orqF3zE1W/fQjb/bJXru2Kckz9oC8M4PFe74nuvPsI38btUPkObKB0dwaUW5Xefj+
         4XanXmmXrUjhoPB0bQqeWrZyU6x1VLAIpRnBiMIH4uDJz/Ngwe3l4uaf4FFkqDcIEK
         vJ+CrwdGzRVzKrOTcEUxXj+s/t8RZCEjdCpjLSxk=
Received: by mail-wr1-f43.google.com with SMTP id v14-v6so8958525wro.5
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jul 2018 19:59:39 -0700 (PDT)
X-Gm-Message-State: AOUpUlElneeRZIDoai7Qb9feYelBhmz1mg8SQqHRqTmMaprd4oL2x1ki
        zeoXdf5akuobMiM/77DQmI5/R3jfB5k/GZXdaHXaKQ==
X-Google-Smtp-Source: AAOMgpcE0tcYG5ThJZ73o7f1KDBAdVBxqZ3ov8DJkKG5HY7sZybndYTUodekFAVIFwytoeLdZwnduCcJ+bhqzQlom/k=
X-Received: by 2002:adf:db11:: with SMTP id s17-v6mr6001657wri.221.1532833177668;
 Sat, 28 Jul 2018 19:59:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:548:0:0:0:0:0 with HTTP; Sat, 28 Jul 2018 19:59:17 -0700 (PDT)
In-Reply-To: <20180728215357.3249-3-riel@surriel.com>
References: <20180728215357.3249-1-riel@surriel.com> <20180728215357.3249-3-riel@surriel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sat, 28 Jul 2018 19:59:17 -0700
X-Gmail-Original-Message-ID: <CALCETrVRhuhEipEYWmJ7cLO5=_1fGMVogAiA8X9jvM_wEMasmg@mail.gmail.com>
Message-ID: <CALCETrVRhuhEipEYWmJ7cLO5=_1fGMVogAiA8X9jvM_wEMasmg@mail.gmail.com>
Subject: Re: [PATCH 02/10] smp: use __cpumask_set_cpu in on_each_cpu_cond
To:     Rik van Riel <riel@surriel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Mike Galbraith <efault@gmx.de>,
        Dave Hansen <dave.hansen@intel.com>, will.daecon@arm.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 28, 2018 at 2:53 PM, Rik van Riel <riel@surriel.com> wrote:
> The code in on_each_cpu_cond sets CPUs in a locally allocated bitmask,
> which should never be used by other CPUs simultaneously. There is no
> need to use locked memory accesses to set the bits in this bitmap.
>
> Switch to __cpumask_set_cpu.

Reviewed-by: Andy Lutomirski <luto@kernel.org>
