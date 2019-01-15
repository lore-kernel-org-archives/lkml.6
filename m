Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD269C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 12:08:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93F5620657
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 12:08:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="j7W25dp2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728874AbfAOMIl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 07:08:41 -0500
Received: from mail-ed1-f44.google.com ([209.85.208.44]:45914 "EHLO
        mail-ed1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727410AbfAOMIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 07:08:40 -0500
Received: by mail-ed1-f44.google.com with SMTP id d39so2302170edb.12
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 04:08:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=wxsBuE3uFDdYPwjLe/NErkZlL/+zM6EmNNsc06No2mQ=;
        b=j7W25dp2Fm98zteNLMVKEMEU3sa/w+jX3M1yO329mj4Et+zSak/INoufiJUzErLY1z
         zQb+z2Qc8BXxRXuB4ygatf4WZTuwhoPF5yrqUe6yjlBaZTMS0RFC3WVE870l/jc14vKA
         31VwnrYa5nogLQdwzRWrm5hZUZLP4XPMvIGT0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=wxsBuE3uFDdYPwjLe/NErkZlL/+zM6EmNNsc06No2mQ=;
        b=ROcFvPPBzE/289L99iIP9PlT67HUz5UaLpob5PBoMqr5hza7jTSuCtSIcD16OrzZCr
         damHW9n8Fwyb3bIHCEZwzIn7fUEycq0HXe3VN+TjiErKUXixMXjRl8scILv5sX/KHaSx
         5z0fTVUP69QlC6fN3M20Lz6erE8in3KbOZWXgsP9+mWhh3V91uPhUqyONwSW46hSO0vZ
         SNj0jSO0dANLWEV5Ohl+RL/2Z1lZumjmBV8lzIixZ4pbEP0PeYA6bJsqZDScnHg3H4hr
         MHGeRixM5CYl6p5RbSAz3j97zDESDM/lie2V6s40xq3lnvTQM3uol75pgtIwlkqmeegD
         xi2Q==
X-Gm-Message-State: AJcUukfE/gg/beuXTeLAJfMwwdmFlvYtERAVMYe0Ej19tbabDDumxav7
        +D3E0Bmpeq7D8o+scSoZwXhN+A==
X-Google-Smtp-Source: ALg8bN6qecpRvwiZLNOBK6R30N9+YVS7CuITeZ8Lgs9iC7+GiV0Vn/1ZR1tQYutD4MZpg/YPlpVejA==
X-Received: by 2002:a50:93c5:: with SMTP id o63mr3141979eda.20.1547554118918;
        Tue, 15 Jan 2019 04:08:38 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id e51sm4841245edd.35.2019.01.15.04.08.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 Jan 2019 04:08:38 -0800 (PST)
Date:   Tue, 15 Jan 2019 13:08:36 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Liviu Dudau <Liviu.Dudau@arm.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Dave Airlie <airlied@linux.ie>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        "James Qian Wang (Arm Technology China)" <james.qian.wang@arm.com>
Subject: Re: linux-next: build failure after merge of the mali-dp tree
Message-ID: <20190115120836.GN10517@phenom.ffwll.local>
Mail-Followup-To: Liviu Dudau <Liviu.Dudau@arm.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Dave Airlie <airlied@linux.ie>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        "James Qian Wang (Arm Technology China)" <james.qian.wang@arm.com>
References: <20190115104619.516be4b9@canb.auug.org.au>
 <20190115101219.GP20661@e110455-lin.cambridge.arm.com>
 <20190115214725.360798cf@canb.auug.org.au>
 <20190115105102.GQ20661@e110455-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190115105102.GQ20661@e110455-lin.cambridge.arm.com>
X-Operating-System: Linux phenom 4.19.0-1-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2019 at 10:51:02AM +0000, Liviu Dudau wrote:
> On Tue, Jan 15, 2019 at 09:47:25PM +1100, Stephen Rothwell wrote:
> > Hi Liviu,
> > 
> > On Tue, 15 Jan 2019 10:12:19 +0000 Liviu Dudau <Liviu.Dudau@arm.com> wrote:
> > >
> > > That looks like the right fix, thank you for that!
> > 
> > Thanks for your verification.
> > 
> > > I will roll your patch into my tree.
> > 
> > You can only do that when your tree is merged with the drm tree (and
> > it should be part of the merge resolution).
> 
> I can also rebase on top of the latest drm-next tree, that should not be
> a problem.

If you have a lot of patches already rebasing is kinda discouraged. There
might be other stuff that's conflicting and then making your entire tree
non-bisectable (maybe just on one platform that you missed in testing).

In that case just send out a pull for drm-next and include the merge
resolution in the pull request so Dave/I can double-check we did it right.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
