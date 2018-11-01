Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10AECC0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 22:32:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACE98204FD
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 22:32:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="T8Jvo/XG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACE98204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727802AbeKBHhn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 03:37:43 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41542 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727115AbeKBHhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 03:37:43 -0400
Received: by mail-lj1-f195.google.com with SMTP id z80-v6so44995ljb.8
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 15:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bmb61KaE3nVV/km7pxh+AG3gjbCBwkcZpKgeNbBOiNg=;
        b=T8Jvo/XGlN9+Y7FRYd3AA/hg5sr0rzpTQzpmCfaCnCJNqSZP3GFuKqa0hlKHp91pys
         a7bedABRU8E8xj2zOz+8AYnwkpBCgyEexDSfK7q7asawHkwxTyHq71NdJJmmKc3OuGKJ
         fFN0xfv+eygXQaon6UUISluJ49+UR5RBpMo6o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bmb61KaE3nVV/km7pxh+AG3gjbCBwkcZpKgeNbBOiNg=;
        b=Rb4pWC6H8Ju3Dc5GLIsCThxQjzJRVHs6UABfLHAasr2L+NpAA8EHPfuRKAqSFFROy3
         huHRCCJ9yFK4Bzy1b0b/JLIktHxTRQCalPqZMZp86U9e9on9fxZ8RnKdf8UxhLE31Pu7
         eiMHItds3JmqLzEF0Q0HFE5D7mZkPQ91NEaepIXJip0kpvcUWIduTHhVG+71y7cKGc/1
         CL604EQ9kKcYVqivBioXe59GnrqJS/Wl0g83b3YkY+1dNcJ+TbvueXfIcFzMr37dQsmS
         k/y2FEFaz0E4R3fnNOmumoW5RfZOwOVKI8MLAC0i715jOwWNjk2YV0X4PWfeyw6KpwVq
         BYJQ==
X-Gm-Message-State: AGRZ1gIlW30Op4ogr5rnh5bNNISiCO/SeG31zW0LKcCJ8CoQbCHPBq4s
        DJqWS8yF1A+DM9mNYdjv0FaWorkn7n9ziA==
X-Google-Smtp-Source: AJdET5dELAnCIEOrSHYRpBNgY8nwOojPaQD23CtkZuLBF2iqzOiAqI/l6qjXPtL0oVCcrsR3sqQ5oA==
X-Received: by 2002:a2e:7c13:: with SMTP id x19-v6mr6023535ljc.83.1541111565513;
        Thu, 01 Nov 2018 15:32:45 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id n24-v6sm561191lfl.44.2018.11.01.15.32.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Nov 2018 15:32:44 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id x85-v6so72529ljb.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 15:32:44 -0700 (PDT)
X-Received: by 2002:a2e:3e06:: with SMTP id l6-v6mr2868322lja.148.1541111563482;
 Thu, 01 Nov 2018 15:32:43 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LRH.2.21.1810262033270.5228@namei.org>
In-Reply-To: <alpine.LRH.2.21.1810262033270.5228@namei.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 1 Nov 2018 15:32:27 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgiWxgsvmSs=BewWpfLB=vjCJ4U3yzaKzDsZVFA0L3Xtw@mail.gmail.com>
Message-ID: <CAHk-=wgiWxgsvmSs=BewWpfLB=vjCJ4U3yzaKzDsZVFA0L3Xtw@mail.gmail.com>
Subject: Re: [GIT PULL] security: keys updates for v4.20
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 26, 2018 at 2:36 AM James Morris <jmorris@namei.org> wrote:
>
> From David: "Provide five new operations in the key_type struct that can
> be used to provide access to asymmetric key operations.  These will be
> implemented for the asymmetric key type in a later patch and may refer to
> a key retained in RAM by the kernel or a key retained in crypto hardware.

Pulled.

However. I really would have expected some of the TPM people to have
acked these, or at least looked at them. There was no sign of that in
any of the tpm commits that I could see..

Hmm?

               Linus
