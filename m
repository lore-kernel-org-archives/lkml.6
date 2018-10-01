Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BE8AC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 22:03:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBFAC208AE
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 22:03:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lgiy8jMh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBFAC208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbeJBEnh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 00:43:37 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:33125 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbeJBEnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 00:43:37 -0400
Received: by mail-yw1-f66.google.com with SMTP id m127-v6so2595447ywb.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 15:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=G4WcYotR03OEiNZiei9M0bOlxNlJjM/PINeXng+gx/M=;
        b=lgiy8jMhzBgIGEBGrPZhMcj8TTB261UftqDh5TzpBimaxjJ1FIwdJ/GRff2r1AC6Bc
         B5R4sUiLA/1U83AoKpyhFreRdDY0RNHuj0RFSKVOEkB10C6Ds1DjNO2Xam/Tt18aLhDT
         cltTpHVsiCm5bW317fIcdRaho9chmr7VjzWhc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=G4WcYotR03OEiNZiei9M0bOlxNlJjM/PINeXng+gx/M=;
        b=lHGfG/XqmAIypxQz5sVlrFvY8L92zfXQa+z+F6x0VEsiGo8zzWdtriiLeJE34lMzmV
         /iHNfX2JEQzATcQ2qsD/fIAjOKiRz1UZEyzmtuTiv7XP/5rCLEaD2mErkhYIUPcNSgBy
         oTUWsMOlbmJ3kHvgLkhIIImcye+16D8SOYiNVPUiplHYHBsU8mbPs1lKljtA1XL1NNgU
         SKT4KPOVnhj9EW/2ffbHs2jRYLXoDmBTdmHC6M3W44Sruw1KJ9skFv7UFuKJLoGNZ+V+
         NrSKCh6hEPqJ+RouMpaOsWamG/8DDwRQrDevpq19qomaK8hxocjEPI7pfljEdVPQWXu+
         viQQ==
X-Gm-Message-State: ABuFfog5j9pwcEoikI/IQ+hQrY+eoQUOFBRcsLFgqE897f8sqtrFOXvO
        Le2Dd2rGEYyzKJqWH+GGz208r/Aeduk=
X-Google-Smtp-Source: ACcGV63PT9vSdSKUcRy5btuuuz3CDUcOMgD3PmvEoPAq2soNH760rlCURqsMwF8tsRoSMu/DEPRaJg==
X-Received: by 2002:a0d:ce87:: with SMTP id q129-v6mr7040213ywd.50.1538431421792;
        Mon, 01 Oct 2018 15:03:41 -0700 (PDT)
Received: from mail-yw1-f48.google.com (mail-yw1-f48.google.com. [209.85.161.48])
        by smtp.gmail.com with ESMTPSA id d6-v6sm5465048ywa.85.2018.10.01.15.03.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 15:03:40 -0700 (PDT)
Received: by mail-yw1-f48.google.com with SMTP id m129-v6so6219070ywc.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 15:03:40 -0700 (PDT)
X-Received: by 2002:a0d:fec6:: with SMTP id o189-v6mr7157668ywf.237.1538431419933;
 Mon, 01 Oct 2018 15:03:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d116:0:0:0:0:0 with HTTP; Mon, 1 Oct 2018 15:03:39 -0700 (PDT)
In-Reply-To: <110c9903-0fbb-8d6f-1fd0-7731402d600f@canonical.com>
References: <20180925001832.18322-1-keescook@chromium.org> <20180925001832.18322-13-keescook@chromium.org>
 <110c9903-0fbb-8d6f-1fd0-7731402d600f@canonical.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 1 Oct 2018 15:03:39 -0700
X-Gmail-Original-Message-ID: <CAGXu5jK+WT-1QkapORpzBJDCeZSAXUf_tN0mwRU+cWy=phRdgA@mail.gmail.com>
Message-ID: <CAGXu5jK+WT-1QkapORpzBJDCeZSAXUf_tN0mwRU+cWy=phRdgA@mail.gmail.com>
Subject: Re: [PATCH security-next v3 12/29] LSM: Provide separate ordered initialization
To:     John Johansen <john.johansen@canonical.com>
Cc:     James Morris <jmorris@namei.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
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
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 1, 2018 at 2:17 PM, John Johansen
<john.johansen@canonical.com> wrote:
> On 09/24/2018 05:18 PM, Kees Cook wrote:
>> This provides a place for ordered LSMs to be initialized, separate from
>> the "major" LSMs. This is mainly a copy/paste from major_lsm_init() to
>> ordered_lsm_init(), but it will change drastically in later patches.
>>
>> What is not obvious in the patch is that this change moves the integrity
>> LSM from major_lsm_init() into ordered_lsm_init(), since it is not marked
>> with the LSM_FLAG_LEGACY_MAJOR. As it is the only LSM in the "ordered"
>> list, there is no reordering yet created.
>>
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>
> I know its already being done, but I don't like splitting the init
> order

Can you describe what you mean here? Do you mean having two init
functions? This is only done temporarily while the other pieces are
reorganized. The later patches reintegrate this. (Before this series,
we effectively had three implicit init paths: minor, major, and
integrity, so even this patch "alone" is an improvement IMO.)

Thanks for the reviews!

-Kees

-- 
Kees Cook
Pixel Security
