Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC9F1C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 18:35:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 963B22152C
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 18:35:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eBrM57gm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 963B22152C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727399AbeI0Atl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 20:49:41 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:36209 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725733AbeI0Atl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 20:49:41 -0400
Received: by mail-yw1-f65.google.com with SMTP id e201-v6so5178070ywa.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 11:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=xqg/CVetFeXQTY4DjT1EB9i5OooEB9rin8OAQqBGHzo=;
        b=eBrM57gmEuBUCJgvWR+FauV7mvo98YY+yLH4livL48BdJN/SaRFsCKrnJgs+cwpp9V
         8fIfNEMy29AGfwcssoo3cgyFrbjwYf9fqINcPNMZ2JhTk+xijfaL+SEQ8UfRKevqBn/B
         kSaxNkWsBnFIb/FaVHunbb0trfghPgoJ9wCYs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=xqg/CVetFeXQTY4DjT1EB9i5OooEB9rin8OAQqBGHzo=;
        b=IHG54hXpVo6d8f6kZv1ohlE/NkPtk1kImGt4DsxRvGmC4KjuHWtVE3kabtrd0ULh4A
         z4ieKHOoHillA9S2xnjjnrZZHPOqPDcpRm4J6Kz8ux2BD1bLGC7H9eLd42julqPCELAA
         z17fDPJK6uipK44GhkQ6y7Gju0F2+4jQZWhcHJkK+zcyXF/g8IZ6VKabmpyO8lD6nQd3
         xH8IsEZ6uB61EgM0nn+48SJ+pTZBDvM7Z/0Z7QVSAVWe03i34F3Ul4dOgOMl8WmUYwdw
         4PHWdtAUlkghiev7MD2HQLoUf/jt52BCXCSVa/mLZxP1hhLfM4RPktsA6HNAL9zgwO3E
         ygqg==
X-Gm-Message-State: ABuFfohgQ+1y+7xyXQczi+TZ/c/7k2D6lpxxZBMlWQztJ9zeskIwaJzh
        UmI2PQ4mJ/ImhjrImHH7uKeiP0s9JNw=
X-Google-Smtp-Source: ACcGV60cc/XhGXwWW1uqWGLz1JZzPGE/zgUFoW2FO1ybFpOaoa5EQSpO9ae5oOeMIlVdm7wtuZ3yKA==
X-Received: by 2002:a81:5b08:: with SMTP id p8-v6mr3937466ywb.251.1537986925288;
        Wed, 26 Sep 2018 11:35:25 -0700 (PDT)
Received: from mail-yw1-f47.google.com (mail-yw1-f47.google.com. [209.85.161.47])
        by smtp.gmail.com with ESMTPSA id o202-v6sm8265650ywo.38.2018.09.26.11.35.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Sep 2018 11:35:23 -0700 (PDT)
Received: by mail-yw1-f47.google.com with SMTP id m129-v6so5454554ywc.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 11:35:23 -0700 (PDT)
X-Received: by 2002:a81:98d7:: with SMTP id p206-v6mr3768461ywg.353.1537986923019;
 Wed, 26 Sep 2018 11:35:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:ab0a:0:0:0:0:0 with HTTP; Wed, 26 Sep 2018 11:35:21
 -0700 (PDT)
In-Reply-To: <20180926123522.4080d9eb@vmware.local.home>
References: <20180925001832.18322-1-keescook@chromium.org> <20180925001832.18322-5-keescook@chromium.org>
 <20180926123522.4080d9eb@vmware.local.home>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 26 Sep 2018 11:35:21 -0700
X-Gmail-Original-Message-ID: <CAGXu5jJyL7FuLRj1XxujpGs9=wUQgS4dRfeGB+HUBqy4mkEBhQ@mail.gmail.com>
Message-ID: <CAGXu5jJyL7FuLRj1XxujpGs9=wUQgS4dRfeGB+HUBqy4mkEBhQ@mail.gmail.com>
Subject: Re: [PATCH security-next v3 04/29] LSM: Remove initcall tracing
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Abderrahmane Benbachir <abderrahmane.benbachir@polymtl.ca>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        "Schaufler, Casey" <casey.schaufler@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 9:35 AM, Steven Rostedt <rostedt@goodmis.org> wrote:
> On Mon, 24 Sep 2018 17:18:07 -0700
> Kees Cook <keescook@chromium.org> wrote:
>
>> This partially reverts commit 58eacfffc417 ("init, tracing: instrument
>> security and console initcall trace events") since security init calls
>> are about to no longer resemble regular init calls.
>
> I'm not against the change, but how much are they going to "no longer
> resemble regular init calls"?

My take on "regular" init calls is that they're always run, link-time
ordered, etc. The changes proposed here will make it so not all
initialization are run depending on runtime configurations, ordering
will be flexible, etc.

-Kees

-- 
Kees Cook
Pixel Security
