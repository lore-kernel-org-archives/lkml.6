Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A402C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 20:54:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6EDC206B8
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 20:54:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KYA1GWYh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6EDC206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727281AbeI2DUI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 23:20:08 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:46597 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727244AbeI2DUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 23:20:07 -0400
Received: by mail-yb1-f196.google.com with SMTP id o8-v6so3211177ybk.13
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 13:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=eo/Y9cUiTa2FJkL9XobLvlA6LGBEt5Rqn8JaEc6iKEA=;
        b=KYA1GWYhgim1f3rgeiEzJeYK5w0RKRABJKgJw/mdcckCmjBKBWlUUf1wI6wwy6iBoR
         huHD9F3KL9DOvLGb6Tfn98L8B1ReFdxqUwNKbkJTv8wZA+0aXOY3uhP48jJD/wBMpNCA
         8XRevKKdGAEElqKAfmwnjKOMyv/urFmzixK5w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=eo/Y9cUiTa2FJkL9XobLvlA6LGBEt5Rqn8JaEc6iKEA=;
        b=Pj7BwgomXxQ3Ed5rQAa/HrgbWU8HKTSfqQOv+BCq2VTVRdQIb3ffftD9xq5HCgoK9K
         EWBzY8XSXPjc4VfsEqgjFsQ9KPlE7F3U+TkVZl0r65fgdGpQ6wOl/tTlzK6ahVmJ7cnJ
         LSJDmCxtp/l0QhkkWYzFB34F8CA7Sh6HUkuOXa2b4YeOse/mMMdcUqe+oH6T9L3L9c90
         TQWGfIyt0MKcDn7LRpiERANzTn+NdaFrvRdfYCgwSbwSPsBUEDjY5E0YqtWGjc/zK/CY
         032J76a2pwMmbZloPcf8zdShGUdNjR+6BaSgpfkZ63GO23Qwlbqx9s53PZnRHe0+EXES
         rCRA==
X-Gm-Message-State: ABuFfoiu9uRkJlx+fMgFFNFaEkVAKathCPMac+7gbHnsRu20ZpeHrfGt
        eNoVAjhEveBe/rNu32JlMezPrVgvIWc=
X-Google-Smtp-Source: ACcGV6190zDINXbatmuxt/OYv1nOBsjRYrTNVZbCo3MAh0u9ovKDfF4ruDVHWo81x46/nFiFvRbyjA==
X-Received: by 2002:a25:f605:: with SMTP id t5-v6mr214597ybd.83.1538168077249;
        Fri, 28 Sep 2018 13:54:37 -0700 (PDT)
Received: from mail-yw1-f48.google.com (mail-yw1-f48.google.com. [209.85.161.48])
        by smtp.gmail.com with ESMTPSA id r12-v6sm2301042ywg.67.2018.09.28.13.54.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Sep 2018 13:54:34 -0700 (PDT)
Received: by mail-yw1-f48.google.com with SMTP id k66-v6so3191331ywa.10
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 13:54:34 -0700 (PDT)
X-Received: by 2002:a81:2288:: with SMTP id i130-v6mr224963ywi.288.1538168074051;
 Fri, 28 Sep 2018 13:54:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d116:0:0:0:0:0 with HTTP; Fri, 28 Sep 2018 13:54:33
 -0700 (PDT)
In-Reply-To: <145fab48-969f-0aed-74e8-ac0a5bb1c79b@tycho.nsa.gov>
References: <20180925001832.18322-1-keescook@chromium.org> <e6122c7d-bd29-d081-3c1e-96b7c369d4fe@schaufler-ca.com>
 <CAGXu5jKQVDW8Wp0ESv2raa0xJnHCCMNqFCzZ5jSVXQ=Dp7FF8A@mail.gmail.com>
 <cb49b4c4-a379-7a8e-41a6-6e6a4afb6fe5@tycho.nsa.gov> <145fab48-969f-0aed-74e8-ac0a5bb1c79b@tycho.nsa.gov>
From:   Kees Cook <keescook@chromium.org>
Date:   Fri, 28 Sep 2018 13:54:33 -0700
X-Gmail-Original-Message-ID: <CAGXu5jKX9VCFqRrchr55_977kOA=1WzdB+YcEZq0y5CPcsp7Zw@mail.gmail.com>
Message-ID: <CAGXu5jKX9VCFqRrchr55_977kOA=1WzdB+YcEZq0y5CPcsp7Zw@mail.gmail.com>
Subject: Re: [PATCH security-next v3 00/29] LSM: Explict LSM ordering
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        James Morris <jmorris@namei.org>,
        John Johansen <john.johansen@canonical.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Paul Moore <paul@paul-moore.com>,
        "Schaufler, Casey" <casey.schaufler@intel.com>,
        LSM <linux-security-module@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2018 at 1:33 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 09/28/2018 04:25 PM, Stephen Smalley wrote:
>>
>> On 09/28/2018 04:01 PM, Kees Cook wrote:
>>>
>>> On Fri, Sep 28, 2018 at 8:55 AM, Casey Schaufler <casey@schaufler-ca.com>
>>> wrote:
>>>>
>>>> On 9/24/2018 5:18 PM, Kees Cook wrote:
>>>>>
>>>>> v3:
>>>>> - add CONFIG_LSM_ENABLE and refactor resulting logic
>>>>
>>>>
>>>> Kees, you can add my
>>>>
>>>>          Reviewed-by:Casey Schaufler <casey@schaufler-ca.com>
>>>>
>>>> for this entire patch set. Thank you for taking this on, it's
>>>> a significant and important chunk of the LSM infrastructure
>>>> update.
>>>
>>>
>>> Thanks!
>>>
>>> John, you'd looked at this a bit too -- do the results line up with
>>> your expectations?
>>>
>>> Any thoughts from SELinux, TOMOYO, or IMA folks?
>>
>>
>> What's it relative to?  First patch fails for me on current security/next.
>
> Never mind - user error ;)

FWIW, it's against v4.19-rc2.

>> Is there a branch in your repo that has the v3 patches?
>
> But still wondered about this one.

Oops! Sorry, I didn't push to kernel.org. Now pushed!

https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/log/?h=lsm/ordering-v3

(and "preview" v4 also with Reviewed-bys added and a cosmetic fix.)

-Kees

-- 
Kees Cook
Pixel Security
