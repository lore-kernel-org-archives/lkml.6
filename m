Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48B45ECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:28:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEB6E2088F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:28:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HQmOVkKU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEB6E2088F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728579AbeIRE6F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 00:58:05 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:34553 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725826AbeIRE6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 00:58:04 -0400
Received: by mail-yw1-f67.google.com with SMTP id y134-v6so34606ywg.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 16:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Wqw1mHOWISrN/Oge4Z1zXObzhGP/4Fq26F67aygbpV4=;
        b=HQmOVkKUyeFTkw+0Pe3Uyl5Gebfc4kXPUJ5zt1tH9fyFIN+QcYtLTs1P7/Fu39J3mL
         27dpYZrJq3XZ+S5fRKxGMBa7CSBMcUb3NyixSEAY3F3yWki6vRYcSysjbH3fNFIls4yP
         PDSlCzGTrA69YA6qJvsuiEk6laIljee4DdL/Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Wqw1mHOWISrN/Oge4Z1zXObzhGP/4Fq26F67aygbpV4=;
        b=jAss86SFG8hvO98CAF89T4YvXAUA7ebSQQMP0YZzip91wdJ12gOtg/CoO39VkomqMh
         yCHKdU4RuFzxdI6xZPj+fQUEqmI5dFwIORFlOVjAFKFSuY2hBqlWptGMGlmx9E1TSIoI
         WvwcnfygQzUktJoQJQSVZCx+E+QN7PP44jmm/6AlhZfcO+zqO06mjHNOCbhA3u38zBPA
         3G3sPI2F78u6y61Sy3uuHVvxdfTPGcNFGx1bEppjwp+NizqZGk05UFXjnHfboHV8OtHs
         KiOEqb732qIOfEw38Cyubxdvfl4GdBO5+C5Xhxyyh+Tzrk/L8j1LJy9axpt2eoAQfzIu
         cGZw==
X-Gm-Message-State: APzg51AR159hmxAfKXiaQubGCoFtyfMzB0YW6MTKN7AJ42JlkDibrHWG
        4DBo/CAVcVheJLChmKLTpzB6h9Zm048=
X-Google-Smtp-Source: ANB0VdYsdcs/ej7h8CATywD8JREm5zSoyA3V7sQJy1kBYsC1/l0MvmZTVIoH4KtQOG8YGICQSWX9XA==
X-Received: by 2002:a0d:cd43:: with SMTP id p64-v6mr11178139ywd.12.1537226907974;
        Mon, 17 Sep 2018 16:28:27 -0700 (PDT)
Received: from mail-yw1-f46.google.com (mail-yw1-f46.google.com. [209.85.161.46])
        by smtp.gmail.com with ESMTPSA id o74-v6sm933901ywo.54.2018.09.17.16.28.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Sep 2018 16:28:27 -0700 (PDT)
Received: by mail-yw1-f46.google.com with SMTP id z143-v6so23922ywa.7
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 16:28:25 -0700 (PDT)
X-Received: by 2002:a0d:db10:: with SMTP id d16-v6mr11703284ywe.124.1537226905257;
 Mon, 17 Sep 2018 16:28:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f04:0:0:0:0:0 with HTTP; Mon, 17 Sep 2018 16:28:24
 -0700 (PDT)
In-Reply-To: <060150b2-4bb4-bdcb-760a-5aa5e1ade381@canonical.com>
References: <20180916003059.1046-1-keescook@chromium.org> <20180916003059.1046-17-keescook@chromium.org>
 <84e1a5a8-8997-829f-cf09-1d29895a3f99@schaufler-ca.com> <CAGXu5jK5CzXUii97q_yk3KzBTw0SOmoc=-zcm+3jAqEHe76AgQ@mail.gmail.com>
 <35b0af5b-e37e-e192-73b5-0d0b37d9e37f@schaufler-ca.com> <CAGXu5jJ71RLGh0nDgOaN3vCXFGE0poXFU2Gb9o+20aO+AEdOvw@mail.gmail.com>
 <8f0bd39b-29a6-325d-4558-d9f484249c22@schaufler-ca.com> <CAGXu5jLeTfwEXAZLz_H1PCx0ySWZcRhXQMfnE14TG8BvxY46JA@mail.gmail.com>
 <53377892-695f-6336-8574-54c7aa0a4201@schaufler-ca.com> <7ecfffc3-d2a4-3ff7-4bf5-db3029d73c59@canonical.com>
 <fbdc2a75-8364-c743-f9c3-9dcd2570c569@schaufler-ca.com> <e9292d89-12bd-2c4a-9ca2-5758de790f2f@canonical.com>
 <a51a4d34-7077-bfbe-5979-00e79680f514@digikod.net> <CAGXu5jLfCNSDWDV-MX6Kyyz3AcMBwubH8YAzZ=28xe9kwNCw4g@mail.gmail.com>
 <060150b2-4bb4-bdcb-760a-5aa5e1ade381@canonical.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 17 Sep 2018 16:28:24 -0700
X-Gmail-Original-Message-ID: <CAGXu5j+haqMgKxkH12M3O358oBR-jU0uWTZSrCrm462mtgf26A@mail.gmail.com>
Message-ID: <CAGXu5j+haqMgKxkH12M3O358oBR-jU0uWTZSrCrm462mtgf26A@mail.gmail.com>
Subject: Re: [PATCH 16/18] LSM: Allow arbitrary LSM ordering
To:     John Johansen <john.johansen@canonical.com>
Cc:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>,
        Casey Schaufler <casey@schaufler-ca.com>,
        James Morris <jmorris@namei.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        "Schaufler, Casey" <casey.schaufler@intel.com>,
        LSM <linux-security-module@vger.kernel.org>,
        LKLM <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 17, 2018 at 4:26 PM, John Johansen
<john.johansen@canonical.com> wrote:
> On 09/17/2018 04:20 PM, Kees Cook wrote:
>> On Mon, Sep 17, 2018 at 4:10 PM, Micka=C3=ABl Sala=C3=BCn <mic@digikod.n=
et> wrote:
>>> Landlock, because it target unprivileged users, should only be called
>>> after all other major (access-control) LSMs. The admin or distro must
>>> not be able to change that order in any way. This constraint doesn't
>>> apply to current LSMs, though.
>>
>> Good point! It will be easy to add LSM_ORDER_LAST, though, given the
>> machinery introduced in this series.
>>
>
> And when we have two LSMs that want to use that?

We'll cross that bridge when we come to it, but perhaps "last
exclusive"? (lsm.enable/disable to choose)

-Kees

--=20
Kees Cook
Pixel Security
