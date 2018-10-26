Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D8D0ECDE44
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 20:41:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D289A20856
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 20:41:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aSfMHpzm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D289A20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbeJ0FUT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 01:20:19 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:43988 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725759AbeJ0FUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 01:20:18 -0400
Received: by mail-yb1-f196.google.com with SMTP id g75-v6so1010341yba.10
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 13:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=/oFUXqbUlULWkv8TQPpU3W+zt9ot6s8qj6/llzzBxgY=;
        b=aSfMHpzm4+375r3cGyqGXFm5Ej1A/zD7ntt92Kro0fxd99dEsSk/NdMNmuLXGIr+Js
         zXa3asBVjmTwBVuOcqFG97Qin7nhdT9/JBhowbfHqQXACUsqVuzXe2eF1tgivrHcSr69
         Rv7iRCv+odbSlE6oqQbpXky7rU177sXkgGUZo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=/oFUXqbUlULWkv8TQPpU3W+zt9ot6s8qj6/llzzBxgY=;
        b=iWjhOppjZ9dQG8Fz7Q1+q7mTD09w2VnGdtdgISK6GERmuk52S8OF00FEx3rijwOiO3
         b7Qv5eNEhrHo4uZF9YAxE1N2Zr+pbqK9CpIPNw4EJ1ZhALOXFmfbbLJEM/lKnJDSKskf
         RxurSTcgqqWKzKPkmLwV8G+Xh4aNzZQ+3PNZSjL0gt9soTfJvUcGDnrUYXCEXKdbrHki
         +DVyMTOD6rSJgdi+nDJb0LAVtwoEHlMBDKSiSFYppH0HhyrDUzdrMVNHFZ8zvs6P9WqA
         RZXLK4eFT9AvCjgq4k4oPr4+3Qgq5RfA0eWf4018bBm6+Nfs+ssP+BGzFTFxsc0Q4hdn
         iQxQ==
X-Gm-Message-State: AGRZ1gK2oxv4TQuBRg6bYJKNctRk/WrmnUaX3AoBTBBFHUK2jP0KIm8X
        OD145Cj21Ef3Wi7dO1wvylFIO5pU+fPg5w==
X-Google-Smtp-Source: AJdET5fqxiGz/SChwdYlFJPJMTM0IcmbqBqtXGPj4kg5Y41hpB4e2RmpQBK1KCUfnbHIbRpawK7B7w==
X-Received: by 2002:a25:4bc3:: with SMTP id y186-v6mr5031860yba.18.1540586508830;
        Fri, 26 Oct 2018 13:41:48 -0700 (PDT)
Received: from mail-yw1-f42.google.com (mail-yw1-f42.google.com. [209.85.161.42])
        by smtp.gmail.com with ESMTPSA id 123-v6sm3045263ywx.15.2018.10.26.13.41.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 13:41:47 -0700 (PDT)
Received: by mail-yw1-f42.google.com with SMTP id a128-v6so984763ywg.9
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 13:41:47 -0700 (PDT)
X-Received: by 2002:a81:98cb:: with SMTP id p194-v6mr5138497ywg.353.1540586507011;
 Fri, 26 Oct 2018 13:41:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:3990:0:0:0:0:0 with HTTP; Fri, 26 Oct 2018 13:41:46
 -0700 (PDT)
In-Reply-To: <20181026203514.GC129228@joelaf.mtv.corp.google.com>
References: <20181026180042.52199-1-joel@joelfernandes.org>
 <CAGXu5jLKLKDwVgRoMx57Y76V9FVJqQ+EeTHB2CnxAN5CnC2Jmw@mail.gmail.com> <20181026203514.GC129228@joelaf.mtv.corp.google.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Fri, 26 Oct 2018 21:41:46 +0100
X-Gmail-Original-Message-ID: <CAGXu5jLYSU-P+QQCwZ2D1Wr-6TcwdKLTVVR1_0hVdRA-qQWXWA@mail.gmail.com>
Message-ID: <CAGXu5jLYSU-P+QQCwZ2D1Wr-6TcwdKLTVVR1_0hVdRA-qQWXWA@mail.gmail.com>
Subject: Re: [RFC 1/6] pstore: map pstore types to names
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, kernel-team@android.com,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 26, 2018 at 9:35 PM, Joel Fernandes <joel@joelfernandes.org> wrote:
> But I have the index variable, so it would be cleaner to just return that? I
> believe I can just drop the cast and do that.

Yeah, that should be fine.

-- 
Kees Cook
