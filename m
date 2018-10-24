Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0375ECDE46
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 16:38:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E1D320838
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 16:38:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="iI0iiFSA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E1D320838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbeJYBH1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 21:07:27 -0400
Received: from mail-lj1-f177.google.com ([209.85.208.177]:33288 "EHLO
        mail-lj1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726575AbeJYBH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 21:07:27 -0400
Received: by mail-lj1-f177.google.com with SMTP id z21-v6so5417897ljz.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 09:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=asR137CGe0OJmeuI8vgcjoOpXVpKeRRDH6rzw+Q+lYo=;
        b=iI0iiFSA7knLWHiD6RXesJZ/Yx3k0DuNgai31v1q+2idah1febPaqIFAN+i2l4hPxu
         frEFbNlYHtVzpzLxnyHQPw2Z9V9+9UhgUTdq19QxPtfCnzvQwHUkgbfgMNkB2+n63HMS
         gZEsdjuEOZtJF5cIvB9YhCW3b0vHleIiCMKyY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=asR137CGe0OJmeuI8vgcjoOpXVpKeRRDH6rzw+Q+lYo=;
        b=DENtRhafnrpzRl0G09UGpaJrn3VpwXCekCOK+uCLlZHV9p4ToY+Sbq31A3HZ37xzO6
         2lWdFbR+q6VChY6YkbYGWWXsn9HBp39sOeiK2S3Mq4mqC0Omjq9Uv8wTbafTT4dVHpV8
         kS1BdA1dcaY6Hrukx5TpevpymDNxrE0tiR/69shTnn25QPRqTM13j4LzPgNMlR5k48iO
         h1u9d7ZDl4G5mzJua/LighIW96eFqbQ+0iLWsChWpVNOa9GKlVpU6xXTsOvUGIxkSjAN
         GqgArJ+wF1XkX0EBBKKzg6sVABvN6J7N7KvgTBfe4jYgc5cjlPo+Yo52nye9S+/DXOsV
         plzw==
X-Gm-Message-State: AGRZ1gKPXaNH/rFO6+lNM1be5FXX/PsaoOJakIMWcwMa1HFYi5/Bu8/u
        pmCcxIVVzvElbwnTvM1yzlMOMrVWo9Icj2qE
X-Google-Smtp-Source: AJdET5cDlu5dx/Dnx/ldmBacUWcQR7j30dpx/MoK1DHs5Ppp7gt5Gon+O4r503cqGn47SSFtBywkOw==
X-Received: by 2002:a2e:82c9:: with SMTP id n9-v6mr2200401ljh.137.1540399118994;
        Wed, 24 Oct 2018 09:38:38 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id n195-v6sm804029lfb.26.2018.10.24.09.38.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Oct 2018 09:38:38 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id q6-v6so3753630lfh.9
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 09:38:37 -0700 (PDT)
X-Received: by 2002:a19:1cc3:: with SMTP id c186-v6mr14615635lfc.16.1540399117472;
 Wed, 24 Oct 2018 09:38:37 -0700 (PDT)
MIME-Version: 1.0
References: <20181024000022.GP18822@dastard>
In-Reply-To: <20181024000022.GP18822@dastard>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 24 Oct 2018 17:38:21 +0100
X-Gmail-Original-Message-ID: <CAHk-=wgEzhDFQ4TpEWhD=EELTjodWQjiRjVp66PUtt-RHirNCQ@mail.gmail.com>
Message-ID: <CAHk-=wgEzhDFQ4TpEWhD=EELTjodWQjiRjVp66PUtt-RHirNCQ@mail.gmail.com>
Subject: Re: [GIT PULL] xfs: 4.20 merge
To:     david@fromorbit.com
Cc:     djwong@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-xfs@vger.kernel.org, sandeen@sandeen.net
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 24, 2018 at 1:01 AM Dave Chinner <david@fromorbit.com> wrote:
>
> Can you please pull the XFS 4.20 update from the tag listed below?

Pulled, thanks,

             Linus
