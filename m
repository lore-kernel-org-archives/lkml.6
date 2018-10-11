Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9075DC32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:14:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F3112085B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:14:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hGmW4Qvy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F3112085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727975AbeJKWmG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 18:42:06 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:43496 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbeJKWmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 18:42:05 -0400
Received: by mail-yb1-f195.google.com with SMTP id w80-v6so3731374ybe.10
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 08:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=vhHOhK6qIvD03E5j82CJydF0koblL9qnnu+X5reyDNk=;
        b=hGmW4Qvy01/0H+oeR2sl6jaevIREHbKsBEeL0KgYGYQVDxkg3lguRP1SCw0IB6mIEM
         lcd9gOlmm+cx38qOiw+KFjaAweXG14NOjliA2sDOs3WJoL7RKDrGdDEFBEwiDMjwPNDH
         CUSMpMk/UmVS/aA67+3zE8Mn15lZsTiNbaGas=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=vhHOhK6qIvD03E5j82CJydF0koblL9qnnu+X5reyDNk=;
        b=pEur3xcUrxf/G/Asb0UK/ajgc/Dc9KziAPDI9uhrE8o1MRAFTLujrtLPPH+gvZi7HQ
         aqeZlht7enV1Lrwdgo8DNfkz7NUF1NWlZSoveKgb5MrvxAUGIK2m1Z5hMZrTCP7BgYDt
         bZiYMFW/X8aEE531nvY9k7jRTUhUqqh8IVyZkZ66stn70fLhSegnW6Dr6dfuVYsXwgqu
         yhCbfSfyvXPh7t1PwrSXOEtPZyzTauARklGEIgAAbyHvuzy0MVSCB77spTfR82+MRWBL
         AVUgrj5+TjFRPy9FDT3BOCGvMj8eT41hzz/bJYuQYOBPRSXiCEWHG28+e0l/kbJ3OnaJ
         Uv1w==
X-Gm-Message-State: ABuFfohRTvtWHt0lLwL4mqLEQf7NSyVxmY+fvK/QqTsxhJZhHSdj6ZW2
        jiq+iSD7LHkjAgOYmFrNMQMud7WI6kQ=
X-Google-Smtp-Source: ACcGV60JysIjZXAp83cC4KoT5ZsXTrzhwTJePQkkI+UNaDA3Y4jhts8qbNP+sDnBBy46wDnB2XnVuw==
X-Received: by 2002:a25:d947:: with SMTP id q68-v6mr1028829ybg.262.1539270868194;
        Thu, 11 Oct 2018 08:14:28 -0700 (PDT)
Received: from mail-yw1-f52.google.com (mail-yw1-f52.google.com. [209.85.161.52])
        by smtp.gmail.com with ESMTPSA id w201-v6sm22431005ywa.79.2018.10.11.08.14.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Oct 2018 08:14:26 -0700 (PDT)
Received: by mail-yw1-f52.google.com with SMTP id 135-v6so3715195ywo.8
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 08:14:26 -0700 (PDT)
X-Received: by 2002:a81:98cb:: with SMTP id p194-v6mr1074104ywg.353.1539270865726;
 Thu, 11 Oct 2018 08:14:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d116:0:0:0:0:0 with HTTP; Thu, 11 Oct 2018 08:14:24
 -0700 (PDT)
In-Reply-To: <alpine.LRH.2.21.1810111443500.25845@namei.org>
References: <20181011001846.30964-1-keescook@chromium.org> <alpine.LRH.2.21.1810111443500.25845@namei.org>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 11 Oct 2018 08:14:24 -0700
X-Gmail-Original-Message-ID: <CAGXu5jLzsYY1Ja8onnNdHXbenZ6vPrat_L8U_sbcCic0qk--qQ@mail.gmail.com>
Message-ID: <CAGXu5jLzsYY1Ja8onnNdHXbenZ6vPrat_L8U_sbcCic0qk--qQ@mail.gmail.com>
Subject: Re: [PATCH security-next v5 00/30] LSM: Explict ordering
To:     James Morris <jmorris@namei.org>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Paul Moore <paul@paul-moore.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jordan Glover <Golden_Miller83@protonmail.ch>,
        LSM <linux-security-module@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2018 at 8:45 PM, James Morris <jmorris@namei.org> wrote:
> On Wed, 10 Oct 2018, Kees Cook wrote:
>
>> v5:
>> - redesigned to use CONFIG_LSM= and lsm= for both ordering and enabling
>> - dropped various Reviewed-bys due to rather large refactoring
>
> Patches 1-10 applied to
> git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-general
> and next-testing.

Very cool; thanks!

As for the rest, I could post some examples of how the new CONFIG_LSM
and "lsm=..." work (and how they mix with the "legacy" options). Would
that be helpful?

-Kees

-- 
Kees Cook
Pixel Security
