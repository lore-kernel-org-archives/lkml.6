Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3B7CC2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 09:06:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 629FF2082B
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 09:06:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="ibjVK2ib"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 629FF2082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727323AbeJ3R7M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 13:59:12 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:40183 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726225AbeJ3R7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 13:59:12 -0400
Received: by mail-ed1-f68.google.com with SMTP id z12-v6so3993876edp.7
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 02:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=mzvpAFWx/LsMaRdJjNP9WPzWgKKJHxsd6pvEYizodPc=;
        b=ibjVK2ibqiO8na5eVq1JUCPkvqPoEeg2RuuGD+hG/MQtxfnhgR1qzXl68oobRrhhUZ
         pLndvlUTTfpKu9N8+3SfcGrOkkUCeU+0WkkgS+DQ+bXPpefK9NhAEYlY9PT/TCAsVzhF
         7xqnbVAU4/RAruZELP5ClSbPekFhzWRCqmxa4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=mzvpAFWx/LsMaRdJjNP9WPzWgKKJHxsd6pvEYizodPc=;
        b=GxidkZWPDyjMPeS6sjR/HNLD/+HdlNCjPWyx4D+vaDyyhfvHeUE1sShYqVu5bZTmUz
         AEk4/KrfKHKEJcCGxBKac3AnpHOfc+xC/J416bJU3CWqJaA0KRuY012EhjoY59Ks6xSz
         BktTtQa2N2A6rkGQr+q0o99QJ0ZhKIV5Nyptw8hvQ7Z3SVQGDfGyF/YCbWi3QySxHels
         34I+QkaXknOHmxMCAL4faG+ECGzc2Dt2uFVfk88n9gZmpoV1DhWIcLvu6pzpUwC4UR12
         7NvdTyj0tK2o/Fnns9A6ytKaaymyA7eFS+Yjigi820ObqdAFtZWNG+NxnfSGf4k7nyTm
         WcIg==
X-Gm-Message-State: AGRZ1gI0Kez3fplQaS2nZBCboUHzxxwIAGMlhkI49sTpcWtqbRwS48Er
        yf0m5ZXmjee4sMq1MS+q6ybmEQ==
X-Google-Smtp-Source: AJdET5fbfjT2XGgvJ33VL7Eqt1+dDn8UsPaAvd/ePAykiV0M9VczyKtM1RaOnc7zA1vRF6FyAkrWGw==
X-Received: by 2002:a50:a689:: with SMTP id e9-v6mr16041702edc.77.1540890395658;
        Tue, 30 Oct 2018 02:06:35 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id i38-v6sm8687555ede.83.2018.10.30.02.06.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Oct 2018 02:06:34 -0700 (PDT)
Date:   Tue, 30 Oct 2018 10:06:32 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        David Airlie <airlied@redhat.com>,
        open list <linux-kernel@vger.kernel.org>,
        dri-devel@lists.freedesktop.org,
        "open list:DRM DRIVER FOR BOCHS VIRTUAL GPU" 
        <virtualization@lists.linux-foundation.org>
Subject: Re: [PATCH v3] drm/bochs: add edid support.
Message-ID: <20181030090632.GJ21967@phenom.ffwll.local>
Mail-Followup-To: Gerd Hoffmann <kraxel@redhat.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        David Airlie <airlied@linux.ie>, David Airlie <airlied@redhat.com>,
        open list <linux-kernel@vger.kernel.org>,
        dri-devel@lists.freedesktop.org,
        "open list:DRM DRIVER FOR BOCHS VIRTUAL GPU" <virtualization@lists.linux-foundation.org>
References: <20181029134507.7775-1-kraxel@redhat.com>
 <87in1kejgj.fsf@intel.com>
 <20181029200520.jfnmvbkng2er5qbc@sirius.home.kraxel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181029200520.jfnmvbkng2er5qbc@sirius.home.kraxel.org>
X-Operating-System: Linux phenom 4.18.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2018 at 09:05:20PM +0100, Gerd Hoffmann wrote:
> On Mon, Oct 29, 2018 at 07:44:28PM +0200, Jani Nikula wrote:
> > On Mon, 29 Oct 2018, Gerd Hoffmann <kraxel@redhat.com> wrote:
> > > Recent qemu (latest master branch, upcoming 3.1 release) got support
> > > for EDID data.  This patch adds guest driver support.
> > >
> > > EDID support in qemu is not (yet) enabled by default, so please use
> > > 'qemu -device VGA,edid=on' for testing.
> > 
> > Any chance of making this use drm_get_edid() (requires an i2c_adapter)
> > or at least drm_do_get_edid()?
> 
> I'll have a look at using drm_do_get_edid().  drm_get_edid() will not
> fly as there is no i2c adapter in the first place.

Hm, not sure that makes sense. drm_do_get_edid is to handle the real-world
flakiness of sinks (it's where all the retry logic resides), if you don't
have a i2c_adapater (because the hw has some magic "give me an edid"
block). For virtual hw we hopefully don't randomly drop bits on the floor
between the guest and host. Imo totally fine as-is.

E.g. we also don't feed the VBT edid through drm_do_get_edid either.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
