Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AED95ECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 21:55:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6152821535
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 21:55:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZH6YgTV3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6152821535
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388682AbeIUDla (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 23:41:30 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:43651 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728347AbeIUDla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 23:41:30 -0400
Received: by mail-yb1-f194.google.com with SMTP id w80-v6so4594176ybe.10
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 14:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=O7Ju11CnqlQ65JFs+cTZJv3B3c6e6mPVZbOA0gUwNI4=;
        b=ZH6YgTV35xB6RLGtVB9NFWyayApUadyAJZqoaXzB8L7jiyi7nZBjp9epd9ph4stATt
         HvmBCFP7BNeh5us4l8G4HQcdRRo5uUp0nIly2eTZw/zQiqc5mkI9F0aCTznwlp0QWeD/
         Ljw6PWcwqbB8gIYHo416NTf7opDyY+8sUmat0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=O7Ju11CnqlQ65JFs+cTZJv3B3c6e6mPVZbOA0gUwNI4=;
        b=GPm+RwKgshDOfTsIqvkM1GUBqKFs3ElB4DoGI6FwyqEjPhOfF2x6vjB0iGzqY55gUL
         j6UFaH4+KOGUujzuqea/U/e9rDAS8nySqoHKnUizkU4jfRrm4mz51+DnEDoeQ50O6vgl
         WNGSHgEtJ4lBFkVnhmKVZv/blkaCxRyLAQZ410iG/UIJWgOLLxaWElyjuAYw0arRhIiD
         aYBBlGEttXXY/LmZfbd2ITt0+wQsH2+xIRf+Er/ba6x0MhJHYXz1u+Y8he++nceqxz9I
         cT2hJ4SDilXxOEiYNVe5Obv+LfqUyy6nNhjnHw0tyv8FVGWqBltsg+scrSjWG5AiIqWk
         jJ7A==
X-Gm-Message-State: APzg51DC5LxzX0j9hLVa2rwIvDa2J6sVBd2ZSte9EETFKNck1ExJQgVu
        bNQU76vIr130HqopG4vLbUg9Zf4xcyw=
X-Google-Smtp-Source: ANB0VdbY1aF+dPdVLrZk5jLoAQ8Y53LBkc7JSWfIR/vjHt88eNxee3N6hWudX+wXT7MDKzO8h2mUxQ==
X-Received: by 2002:a25:9702:: with SMTP id d2-v6mr19747978ybo.77.1537480554175;
        Thu, 20 Sep 2018 14:55:54 -0700 (PDT)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id z193-v6sm5366882ywd.90.2018.09.20.14.55.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 14:55:53 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id p74-v6so4017239ybc.9
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 14:55:53 -0700 (PDT)
X-Received: by 2002:a25:3617:: with SMTP id d23-v6mr12372664yba.141.1537480553100;
 Thu, 20 Sep 2018 14:55:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f04:0:0:0:0:0 with HTTP; Thu, 20 Sep 2018 14:55:52
 -0700 (PDT)
In-Reply-To: <1898403.NNy4ELVaME@merkaba>
References: <20180920162338.21060-1-keescook@chromium.org> <1898403.NNy4ELVaME@merkaba>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 20 Sep 2018 14:55:52 -0700
X-Gmail-Original-Message-ID: <CAGXu5jJfp2ezmODaQgj_gROdpr=_Dc4_h=ujPeR-ggTZ8AUciQ@mail.gmail.com>
Message-ID: <CAGXu5jJfp2ezmODaQgj_gROdpr=_Dc4_h=ujPeR-ggTZ8AUciQ@mail.gmail.com>
Subject: Re: [PATCH security-next v2 00/26] LSM: Explict LSM ordering
To:     Martin Steigerwald <martin@lichtvoll.de>
Cc:     James Morris <jmorris@namei.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        "Schaufler, Casey" <casey.schaufler@intel.com>,
        LSM <linux-security-module@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2018 at 1:14 PM, Martin Steigerwald <martin@lichtvoll.de> w=
rote:
> Kees Cook - 20.09.18, 18:23:
>> v2:
>> - add "lsm.order=3D" and CONFIG_LSM_ORDER instead of overloading
>> "security=3D" - reorganize introduction of ordering logic code
>>
>> Updated cover letter:
>>
>> This refactors the LSM registration and initialization infrastructure
>> to more centrally support different LSM types. What was considered a
>> "major" LSM is kept for legacy use of the "security=3D" boot parameter,
>> and now overlaps with the new class of "exclusive" LSMs for the future
>> blob sharing (to be added later). The "minor" LSMs become more well
>> defined as a result of the refactoring.
>>
>> Instead of continuing to (somewhat improperly) overload the kernel's
>> initcall system, this changes the LSM infrastructure to store a
>> registration structure (struct lsm_info) table instead, where metadata
>> about each LSM can be recorded (name, flags, order, enable flag, init
>> function). This can be extended in the future to include things like
>> required blob size for the coming "blob sharing" LSMs.
>
> I read the cover letter and still don=C2=B4t know what this is about. Now=
 I
> am certainly not engaged deeply with LSM. I bet my main missing piece
> is: What is a "blob sharing" LSM.
>
> I think it would improve the cover letter greatly if it explains briefly
> what is a major LSM, what is a minor LSM and what is a "blob sharing"
> LSM.
>
> Why those are all needed? What is the actual security or end user
> benefit of this work? The questions are not to question your work. I bet
> it makes all perfect sense. I just did not understand its sense from
> reading the cover letter.

Sure, thanks! I'll include more details for any later versions. This
is mainly related to some internal refactoring the LSM is doing to
support additional LSM that need more extensive "stacking" of the
kernel internals. I aimed this at linux-doc@ and linux-arch@ to get
feedback on the Documentation/ and linker script changes,
respectively. In theory, users don't need to know anything about
minor/major nor blob-sharing, as that should normally be all an
internal issue.

Thanks!

-Kees

--=20
Kees Cook
Pixel Security
