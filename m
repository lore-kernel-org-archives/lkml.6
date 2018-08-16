Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58890C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 01:49:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ECFD21475
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 01:49:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="MqwWcHj1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3ECFD21475
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387545AbeHPEoI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 00:44:08 -0400
Received: from mail-it0-f42.google.com ([209.85.214.42]:50904 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732878AbeHPEoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 00:44:04 -0400
Received: by mail-it0-f42.google.com with SMTP id j81-v6so4312638ite.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Aug 2018 18:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j5NsPbHgAEp0ie8k6FKk5ZGuBp1q0PUH7RRkIu/Zi64=;
        b=MqwWcHj1hPHVXpMwIRnALvOqjCww/QxhbtgCBVWjG/2KgqCf6qieTc32nFGYa4lMyL
         EIRQOaBJKzKK/SogwuyTrxeJXq/aZS5ow3Dp/Se25trPJq2htooOIWU96a5k2Dwa4Hm5
         RYl/rrbniOQAf1XyvfSo/5fHFj2nDH01JKBSE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j5NsPbHgAEp0ie8k6FKk5ZGuBp1q0PUH7RRkIu/Zi64=;
        b=laX83SDJcSQiiYr2h9xTO/0ebAyf0pnZT//4YMqF7ix0ZJhVxxpT7zGY4vgODgfjei
         igw+W1H35UAMKMt5EoJLaFaBS/9xtIpQbgWJUByih/Wikw4Dpf1pzpGmGi/FPHFqcgl4
         coDWu2uDOLiF/GRV0OLnx7tuEyG2xIEZbxdIp5PKJ7EGkvM0SPHU/XnpNIm03XjgE+UK
         hOC5WGL0ivlj43KKqwd4DJt6WAvSKFNnAbf68lNsBKNIJaKcCTIKd8ZFuAIsk/28YReZ
         kMZgB8za1RFK/CJLtL235WIG2s2ki250P81dYAA8a5H0ovM/G31Hm8u9iKWI1khmI34w
         fU+Q==
X-Gm-Message-State: AOUpUlFHmFvbMP2IZcdojnplSQzbmUjS6n9AFEFdMoCp8pnCEX3bTGW3
        yRQl/SUD1RJ0r5Bb+l3fH3pb5Bx9mzNuIJPb5vU=
X-Google-Smtp-Source: AA+uWPyig0hedLgEj9ZM76V8XhutsU5H8r635fr8B8/5hQ0OJ9ZMyBSLeK52uClZex5/Tlpb8fqj0c2AoGvMaW8uGi4=
X-Received: by 2002:a24:94f:: with SMTP id 76-v6mr19701279itm.113.1534384148700;
 Wed, 15 Aug 2018 18:49:08 -0700 (PDT)
MIME-Version: 1.0
References: <s5h36vhazyp.wl-tiwai@suse.de> <CA+55aFx_ZgBBGoFCqQDCBTs6jq7t4SmVpzc1zzvd-B2E65mJEw@mail.gmail.com>
 <CA+55aFy5GGpyxQCZoWxOooGu+i5psz7OogvzGpWmuEJ1g7OYgA@mail.gmail.com>
In-Reply-To: <CA+55aFy5GGpyxQCZoWxOooGu+i5psz7OogvzGpWmuEJ1g7OYgA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 15 Aug 2018 18:48:57 -0700
Message-ID: <CA+55aFy_48--5j+ODQMCni1s-BvUCOKi+mD7qw3bEdABA15MtQ@mail.gmail.com>
Subject: Re: [GIT PULL] sound updates for 4.19-rc1
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 15, 2018 at 6:27 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> It still seems to revert cleanly, so I will double-check that a revert
> fixes it on current master.

Yes. A revert fixes things.

            Linus
