Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,GAPPY_SUBJECT,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E570C04AB8
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 00:06:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7F5F20853
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 00:06:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WOlCcC7e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7F5F20853
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728288AbeINFSI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 01:18:08 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:34158 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727029AbeINFSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 01:18:07 -0400
Received: by mail-yb1-f194.google.com with SMTP id t10-v6so4088388ybb.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 17:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=c3GaHnmBJ6JA2RMDhGVHjKj61kys18PP5wtYMzCf4/U=;
        b=WOlCcC7eGw08PM/fFLMCs8gTbgosnd+QBO34WeanTSn1Q1oYxmjfgwvBjjbqZRFmW6
         YRjwoI7FKJ1eyA7B/x4KsRByTJgnOy+38vN69Z3if1dDXA+S/5g7Hjv8Y363R0I+VT56
         fNXM/q19+xuYPA9idS4JVN2s+xdhc3b2dxRTg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=c3GaHnmBJ6JA2RMDhGVHjKj61kys18PP5wtYMzCf4/U=;
        b=MFr4fvqrSwrJmlFXwWXVDlJE65lKf6qU4cH3seZiq2IFLz8avVRm03cRooYovwUcoV
         sLtB4xcLo5+0RA+uzzY9shVR7zyHvTfxr2EE/4hbAsUUQH9DmfzyMxBZTQ0EQ2LeRCsd
         ToepcSRIcwjHjlrX2qw0MauawNOSdfBVRmlSFob3UIM+GyLjZiIkPw5XOwQvJMlAN2Od
         RP4f3Juy+UdsDRbFDP3muZCs9hxCizkSRsmTTPN3L+LjAjWzzsmc0YieQKNtBk4YMf/0
         DX9DykOQZOLMXQ2oxrAyvyi/NIDOyZOAF6wpiw9zcNc4SlF2bfFGDfUOWLJjTcnMAb/i
         0mFQ==
X-Gm-Message-State: APzg51A3yTX14MByqRBwmx2MQ0E9KDPHXFMZAKcab1rpDgSrInrZ5bOU
        oVnayR7P1IoTW9LF/ixfrV8N2yDDBXs=
X-Google-Smtp-Source: ANB0VdbrsP6pxw/buqVThKMugdbzCgPbQ4Oj873C8qtjLG1GCPLd6BY6lWh7KazfHAs6t6SomngklQ==
X-Received: by 2002:a25:b05:: with SMTP id 5-v6mr4734091ybl.94.1536883580157;
        Thu, 13 Sep 2018 17:06:20 -0700 (PDT)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com. [209.85.219.177])
        by smtp.gmail.com with ESMTPSA id f82-v6sm2184227ywf.58.2018.09.13.17.06.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Sep 2018 17:06:17 -0700 (PDT)
Received: by mail-yb1-f177.google.com with SMTP id o17-v6so4077817yba.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 17:06:17 -0700 (PDT)
X-Received: by 2002:a25:2c3:: with SMTP id 186-v6mr124647ybc.421.1536883576941;
 Thu, 13 Sep 2018 17:06:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f04:0:0:0:0:0 with HTTP; Thu, 13 Sep 2018 17:06:16
 -0700 (PDT)
In-Reply-To: <a2ffa6b7-5d05-39a1-11c3-d715566e4d51@schaufler-ca.com>
References: <cbf848ae-a1ac-c5ab-f23b-bc9217fceebe@schaufler-ca.com>
 <99cb1ae7-8881-eb9a-a8cb-a787abe454e1@schaufler-ca.com> <CAGXu5jLONSfPHYYYTLSma-+arVHSQKaEWb9JxpOn6TNKtyLNhw@mail.gmail.com>
 <CAHC9VhQN0wq0zZS5BYU9jBomaWvCaJ_BqJjHF3AT7FG8Z0nLDQ@mail.gmail.com>
 <CAGXu5jJs6kmd6Tjgwqb2Zx7e-jNbHqfJ57poZuyz4Qj=AKVfmQ@mail.gmail.com>
 <CAHC9VhQ20tBAMwOJ9mg0tBHYUoxjh0Szr3d62HuPw2SyT4XDLw@mail.gmail.com>
 <CAGXu5jKec1JTsoqwKGThcJoamdL618AHu4jfFbqqQiauz1kjyg@mail.gmail.com>
 <CAHC9VhQwT4d3wC37cVrrX-hZq1L3e6=TEAse4m-YH9SiFnkieA@mail.gmail.com>
 <CAGXu5jLapViSK-j08Tq8cCZodiZXFsXze71xFPg6MQhDWDHDAA@mail.gmail.com>
 <CAGXu5j+j47FH5RF2vrJh95=YFX76oSBFo8O6GZqa0utcfE1AVA@mail.gmail.com>
 <0eb75e66-ed50-4013-6440-38bc2f814c6f@canonical.com> <CAGXu5jKZ7rquTux5fS+5tQ==0w_9rDTRaJWS_mS7C+Fy2dXRRQ@mail.gmail.com>
 <a2ffa6b7-5d05-39a1-11c3-d715566e4d51@schaufler-ca.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 13 Sep 2018 17:06:16 -0700
X-Gmail-Original-Message-ID: <CAGXu5j+PhwfRCg5PycrE-JReVxKMduGsoXStWZN6PfYB-NB1og@mail.gmail.com>
Message-ID: <CAGXu5j+PhwfRCg5PycrE-JReVxKMduGsoXStWZN6PfYB-NB1og@mail.gmail.com>
Subject: Re: [PATCH 10/10] LSM: Blob sharing support for S.A.R.A and LandLock
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     John Johansen <john.johansen@canonical.com>,
        Paul Moore <paul@paul-moore.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        LKML <linux-kernel@vger.kernel.org>,
        SE Linux <selinux@tycho.nsa.gov>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        "Schaufler, Casey" <casey.schaufler@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2018 at 5:03 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
> On 9/13/2018 4:51 PM, Kees Cook wrote:
>> So, before we can really make a decision, I think we have to decide:
>> should ordering be arbitrary for even this level of stacking?
>
> Do we have a case where it matters? I know that I could write a
> module that would have issues if one hook got called and another
> didn't because because a precursor module hook failed. I don't
> think that any of the existing modules have this problem.

FWIW, I prefer having explicit ordering that cannot be changed at
runtime. I'm just concerned about painting ourselves (further) into a
corner with security= suddenly gaining ordering semantics, but maybe I
can just ignore this and we can point and laugh at anyone who gets
burned by some future change to making it order-sensitive. :)

-Kees

-- 
Kees Cook
Pixel Security
