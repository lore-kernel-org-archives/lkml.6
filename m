Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04376C5AE59
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 22:07:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD8882075A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 22:07:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZEP/iUW6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD8882075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936402AbeFRWHr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 18:07:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:44518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755326AbeFRWHp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 18:07:45 -0400
Received: from mail-wr0-f172.google.com (mail-wr0-f172.google.com [209.85.128.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A4C52083D
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 22:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529359665;
        bh=oyiCf7NGyStGctSTNVfXXDq0qubS+RvMuoC6ldd5AfU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZEP/iUW6kMfB1Jnh/KGIPv4HPqMgbZPTt/dzDyTjrc9Y8sKDp9qJjKBlGWcXQKhnC
         DW6cPVGZO/1M70DZRa0L1xQfr2dGx55bSMLqujGTees7U3/rfLeMEaOmq5qaTRmbzL
         c6XXm5OTG+WvwhMBAsuo6ucGya0BJX5Ylib+78uI=
Received: by mail-wr0-f172.google.com with SMTP id k16-v6so18404315wro.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 15:07:45 -0700 (PDT)
X-Gm-Message-State: APt69E14rQyWWGTX47wRVFyh0HeXOhlZe6DM9mOa7AvV2QkND8KiGnv6
        suv3k0PyFpAbD8RAab3IruhtMK8/R28O8MwKbYOUaw==
X-Google-Smtp-Source: ADUXVKLdeGdkWXQDFk9zaxrqjOaeMU1++e8Ee/xc8KbgO/FzK3y0xYzxdbAGyyspmxgybK6s+LDo2SiSypYkvt8SDuw=
X-Received: by 2002:adf:e084:: with SMTP id c4-v6mr11420382wri.199.1529359663803;
 Mon, 18 Jun 2018 15:07:43 -0700 (PDT)
MIME-Version: 1.0
References: <1528391168-22224-1-git-send-email-chang.seok.bae@intel.com> <1528391168-22224-7-git-send-email-chang.seok.bae@intel.com>
In-Reply-To: <1528391168-22224-7-git-send-email-chang.seok.bae@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 18 Jun 2018 15:07:31 -0700
X-Gmail-Original-Message-ID: <CALCETrUGnJZt_oxurMaxp02-Ui7c99chqKsUX2q2enjZCdKrZw@mail.gmail.com>
Message-ID: <CALCETrUGnJZt_oxurMaxp02-Ui7c99chqKsUX2q2enjZCdKrZw@mail.gmail.com>
Subject: Re: [PATCH v3 6/7] x86/vdso: Introduce CPU number helper functions
To:     "Bae, Chang Seok" <chang.seok.bae@intel.com>
Cc:     Andrew Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
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

On Thu, Jun 7, 2018 at 10:06 AM Chang S. Bae <chang.seok.bae@intel.com> wrote:
>
> CPU number initialization in vDSO is now a bit cleaned up by
> the new helper functions. The helper functions will take
> care of combing CPU and node number and reading each from
> the combined value.

This is great.

Acked-by: Andy Lutomirski <luto@kernel.org>
