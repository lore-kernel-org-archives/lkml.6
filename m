Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6F47C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 13:31:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7305D20684
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 13:31:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="feuwCoJq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7305D20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbeJCUTo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 16:19:44 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51820 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726720AbeJCUTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 16:19:44 -0400
Received: by mail-wm1-f67.google.com with SMTP id 143-v6so5720848wmf.1;
        Wed, 03 Oct 2018 06:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rH9ynS46NxJai8mT4TKM5mTN++Id+gWYJ71S5lXOGcc=;
        b=feuwCoJqCGMp38g0eBwmETIedIPq3hTdGUP2TuomDoIbAt/vXYVRXXhyGKnmIyWx+Z
         oZOC9Gah0H3IV3bgidL5OxKXOxIiWVeL/QXGQN11xnpZ6bb9IN75gwu+D3KLQ9CUcVAY
         f/w7aO6obR9d1xQVGuJvCt5H15xJ2shcZKMItZZZ2w86e97cpNQouYyHFeBQYrmiZEtO
         t2UP56zcAFjpDqhhDMzkqZdnPKtSD7+hwWkiATmRWDquhopFHmy/W5+TUEMPkM0j49qj
         VHFS8FzmP7RpNmqhi3ci1K1POKza/Xye1eUix3YseP5+dN3a3V32dbQ28vYxeqpd8mMS
         ZxEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rH9ynS46NxJai8mT4TKM5mTN++Id+gWYJ71S5lXOGcc=;
        b=CJC6aXUPcomLvE6tqFmpeFD34uYPN5MNmYAJ1hMMLNdeIkj65GuEZ/oeFEjRtSjali
         +nJbzVQNGQX6lsBs59sN4eZewwh682tvfZhSP/aGF7WzYJawR5aJrrsdQePYh5QEsHXN
         eaFK7hgHZhawtSErKQccIgDKABMsDiAT1EbMatF5Wt0qaRCIAtvCO666eNfh8FxF3gT7
         uvKV4T8e55ZRXnjlxjx4AhzQq8VeHgE8wj6ivzCO2DXWxlssXdO4CH2ThTSuNTPIkGyA
         DZP29FG6VrTlpKH3HxMgEBOxVYV/SiFyW9pfaxxwTPHCHIiRQMvSC8vAe5Ny3jya8ll+
         5yPg==
X-Gm-Message-State: ABuFfog4pRZrFLJpnmRAVpZ5V0D724FQvJbZg+v7vGhHoW3FX8glyhMO
        kOLB/0zVmGFChxsjUDw/WWS4mpTs
X-Google-Smtp-Source: ACcGV63bqBReLITiXiFxfLWR1v8xlRhThMneNTQBm9Qa732cmHOfNqoS5ynOrcEyF5jjs2n/nSntCA==
X-Received: by 2002:a1c:9616:: with SMTP id y22-v6mr1477426wmd.72.1538573476761;
        Wed, 03 Oct 2018 06:31:16 -0700 (PDT)
Received: from ltop.local ([2a02:a03f:4027:2900:31b9:7883:54ea:2f25])
        by smtp.gmail.com with ESMTPSA id v76-v6sm2771425wmd.32.2018.10.03.06.31.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Oct 2018 06:31:15 -0700 (PDT)
Date:   Wed, 3 Oct 2018 15:31:12 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dmitry Vyukov <dvyukov@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Chintan Pandya <cpandya@codeaurora.org>
Subject: Re: [PATCH v7 0/8] arm64: untag user pointers passed to the kernel
Message-ID: <20181003133110.4y3xhexjrvffivff@ltop.local>
References: <cover.1538485901.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1538485901.git.andreyknvl@google.com>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 02, 2018 at 03:12:35PM +0200, Andrey Konovalov wrote:
...

> Changes in v7:
> - Rebased onto 17b57b18 (4.19-rc6).
> - Dropped the "arm64: untag user address in __do_user_fault" patch, since
>   the existing patches already handle user faults properly.
> - Dropped the "usb, arm64: untag user addresses in devio" patch, since the
>   passed pointer must come from a vma and therefore be untagged.
> - Dropped the "arm64: annotate user pointers casts detected by sparse"
>   patch (see the discussion to the replies of the v6 of this patchset).
> - Added more context to the cover letter.
> - Updated Documentation/arm64/tagged-pointers.txt.

Hi,

I'm quite hapy now with what concerns me (sparse).
Please, feel free to add my:
Reviewed-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>


Cheers,
-- Luc Van Oostenryck
