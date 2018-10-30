Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE04EC2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 09:44:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B4182080A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 09:44:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="aECUkXh+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B4182080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbeJ3Sg4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 14:36:56 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38796 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726225AbeJ3Sg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 14:36:56 -0400
Received: by mail-ed1-f67.google.com with SMTP id c1-v6so9868205ede.5
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 02:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=EMI8ijDWJjyJR+8arWfKlS2x1Y3OW9bwd9ZalBi1s1o=;
        b=aECUkXh+ySpOTYSXOzKPvm4av9rQULlpiJd+mTF4SOLE6+TsI1bl+LbKsyq9GBLMKr
         cluj1dRxyJLVEHupPM7HGuKYH0ayRci+lJlCpWzCG3cEc20xgU9HOY2VoHVsA9eFcyRb
         Ws6l6QNpHwQ6VCMWtLRyP2E+pvd5KMoKMtgT4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=EMI8ijDWJjyJR+8arWfKlS2x1Y3OW9bwd9ZalBi1s1o=;
        b=TpUy1BMjGLPoXRPKgETVQwDnYeW5NPty2Xw7szikHf3VUNvtRtZ+5a4GlmUXGpaUe6
         VB9Aktnqc0OE9efj0Ny/lAXPqgih3QUJgZE4JJDWk3RGwL4zpZcrFLurj3YkO/agJSFJ
         CMdIxYvr0as8JyyPPaK7CmO2wTH+dV+wDycqVzE3/dH2Jw6CF5DuUcokopE/g2byNzil
         n7lAYkHzlyY9xoW6G7Z4x8ZSg0Ab7FMQvXO7HpDT2FZTlOvOP/vyNdycN0KQhSXz2Ict
         eLeYuEbyC9EOz0LYPyBCIPZsV/eg6rxJUEFIs/AaIF3NFZhJKIoyavGhvIg4ukL+hRUF
         dt3A==
X-Gm-Message-State: AGRZ1gLqRvTlLdfueQVoiei348UwWrvquiTrMqii/G6YiLHPrGjPd15N
        6eqcnT2VuaUEQUedm6v+Ywgglw==
X-Google-Smtp-Source: AJdET5fI+bO+R+iNqFxecI4WIui7mnNqy5s7tO6664OcjQp32FU/wpVUG46X/IBYi4wsqkmhj8/9TA==
X-Received: by 2002:a50:90a7:: with SMTP id c36-v6mr15793267eda.31.1540892651496;
        Tue, 30 Oct 2018 02:44:11 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id t19-v6sm7381286edd.68.2018.10.30.02.44.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Oct 2018 02:44:10 -0700 (PDT)
Date:   Tue, 30 Oct 2018 10:44:08 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>, Gerd Hoffmann <kraxel@redhat.com>,
        David Airlie <airlied@linux.ie>,
        David Airlie <airlied@redhat.com>,
        open list <linux-kernel@vger.kernel.org>,
        dri-devel@lists.freedesktop.org,
        "open list:DRM DRIVER FOR BOCHS VIRTUAL GPU" 
        <virtualization@lists.linux-foundation.org>
Subject: Re: [PATCH v3] drm/bochs: add edid support.
Message-ID: <20181030094408.GR21967@phenom.ffwll.local>
Mail-Followup-To: Jani Nikula <jani.nikula@linux.intel.com>,
        Gerd Hoffmann <kraxel@redhat.com>, David Airlie <airlied@linux.ie>,
        David Airlie <airlied@redhat.com>,
        open list <linux-kernel@vger.kernel.org>,
        dri-devel@lists.freedesktop.org,
        "open list:DRM DRIVER FOR BOCHS VIRTUAL GPU" <virtualization@lists.linux-foundation.org>
References: <20181029134507.7775-1-kraxel@redhat.com>
 <87in1kejgj.fsf@intel.com>
 <20181029200520.jfnmvbkng2er5qbc@sirius.home.kraxel.org>
 <20181030090632.GJ21967@phenom.ffwll.local>
 <87y3afokav.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y3afokav.fsf@intel.com>
X-Operating-System: Linux phenom 4.18.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2018 at 11:28:24AM +0200, Jani Nikula wrote:
> On Tue, 30 Oct 2018, Daniel Vetter <daniel@ffwll.ch> wrote:
> > On Mon, Oct 29, 2018 at 09:05:20PM +0100, Gerd Hoffmann wrote:
> >> On Mon, Oct 29, 2018 at 07:44:28PM +0200, Jani Nikula wrote:
> >> > On Mon, 29 Oct 2018, Gerd Hoffmann <kraxel@redhat.com> wrote:
> >> > > Recent qemu (latest master branch, upcoming 3.1 release) got support
> >> > > for EDID data.  This patch adds guest driver support.
> >> > >
> >> > > EDID support in qemu is not (yet) enabled by default, so please use
> >> > > 'qemu -device VGA,edid=on' for testing.
> >> > 
> >> > Any chance of making this use drm_get_edid() (requires an i2c_adapter)
> >> > or at least drm_do_get_edid()?
> >> 
> >> I'll have a look at using drm_do_get_edid().  drm_get_edid() will not
> >> fly as there is no i2c adapter in the first place.
> >
> > Hm, not sure that makes sense. drm_do_get_edid is to handle the real-world
> > flakiness of sinks (it's where all the retry logic resides), if you don't
> > have a i2c_adapater (because the hw has some magic "give me an edid"
> > block). For virtual hw we hopefully don't randomly drop bits on the floor
> > between the guest and host. Imo totally fine as-is.
> >
> > E.g. we also don't feed the VBT edid through drm_do_get_edid either.
> 
> But nowadays we do handle the debugfs EDID override and the EDID
> firmware loading in drm_do_get_edid(), so using that gives you those
> features.

Oh, missed that. Would be good to clarify the kernel doc and mention this
in e.g. both drm_add_edid_modes() and &drm_connector_helper_funcs.get_modes?

And maybe make it more obvious that drm_do_get_edid is also for virtual
drivers, atm the kerneldoc talks a lot about DDC and everything hw.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
