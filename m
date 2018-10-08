Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A010C67879
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 23:16:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAA1D2145D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 23:16:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QndLFziC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAA1D2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbeJIGap (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 02:30:45 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35144 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725808AbeJIGap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 02:30:45 -0400
Received: by mail-pl1-f195.google.com with SMTP id f8-v6so10722657plb.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 16:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:to:from:in-reply-to:cc
         :references:message-id:user-agent:subject:date;
        bh=dxRbqOxjawrWfiIfqrlScYIvQVbOAvPxZiVdfspX5qA=;
        b=QndLFziC51ckK41ZM97QUD9KG26iwA1jKlu4hptzX/jUbCZASIJ8P7nApp/n/Z3Xne
         tndHU/+9w0GFPMjom/0WSaICefnhc3u7ZIWjfOnf6aF6WzRhjkt/mDdOV2nub6o2aNS5
         VLnkA9pCwMPWki1g5dvMcI3dXlaOVkb6Xegy0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:to:from
         :in-reply-to:cc:references:message-id:user-agent:subject:date;
        bh=dxRbqOxjawrWfiIfqrlScYIvQVbOAvPxZiVdfspX5qA=;
        b=EhyFXAw2HnQ/A/5Nei++1IwMlCfGodQqUiiZLmdCJv86uY8xPocQ7GDSBF7XFcRXeR
         BSVnEjra4s0R/pk0gAc025Q4QnVMzQjnO7isw4XnyohF1UeXUyCK0ScD1STfFFVwGBbd
         DZoxCObhpwz6Ck41wsX/2p3l/9WF2ZF34/2IPi87aJMjw4461OA4JyxgdM0CTUXaL9Rv
         sPk15g0RAipbVQtz+ijw2wH6Rs/OwAJV2B5TIDTyY2eHE/NFjMyRvKFT2+f0DBofCQYt
         0g8O9AbgrJGFndA0zkSgvq0mGIg4PLGkP1S4A9U3ZjUkArgw+sLFe/9r5ScKVYJ8ITqV
         uLzg==
X-Gm-Message-State: ABuFfohtyf6M+eCqE4pV21YDMWsXlv/tfM6WknKw+HIVF3/jDvR/JrYB
        fgBlpP/611I/FfVwBzoJVToxGg==
X-Google-Smtp-Source: ACcGV60xbr8cXt4s0J+8UNnN9YO1NW54a3g4zjKZhDwmiVEoZnqTmA9Pad3qVxUuJ1i0hDMU2YyPag==
X-Received: by 2002:a17:902:8205:: with SMTP id x5-v6mr26431925pln.55.1539040600300;
        Mon, 08 Oct 2018 16:16:40 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:fed3:9637:a13a:6c15])
        by smtp.gmail.com with ESMTPSA id 19-v6sm32321832pft.97.2018.10.08.16.16.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Oct 2018 16:16:39 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Mark Rutland <mark.rutland@arm.com>,
        Paul Menzel <pmenzel+linux-kernel@molgen.mpg.de>
From:   Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <20180720083102.4xo3yaatv56ky7fj@salmiak>
Cc:     Matthew Wilcox <mawilcox@microsoft.com>,
        linux-kernel@vger.kernel.org
References: <20180720083102.4xo3yaatv56ky7fj@salmiak>
Message-ID: <153904059900.119890.16426538034066391569@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: UBSAN: Undefined behaviour in lib/radix-tree.c:123:14: member access
 within null pointer of type 'const struct radix_tree_node'
Date:   Mon, 08 Oct 2018 16:16:39 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Mark Rutland (2018-07-20 01:31:02)
> In-Reply-To: <19427cc3-3372-9b02-4b92-096fbe328622@molgen.mpg.de>
> =

> On Fri, Jul 20, 2018 at 09:53:21AM +0200, Paul Menzel wrote:
> > Dear Linux folks,
> =

> Hi,
> =

> > Enabling the undefined behavior sanitizer and building GNU/Linux 4.18-r=
c5+
> > (with some unrelated commits) with GCC 8.1.0 from Debian Sid/unstable, =
the
> > warning below is shown.
> > =

> > > [    0.958688] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > [    0.959029] UBSAN: Undefined behaviour in lib/radix-tree.c:123:14
> =

> That's in get_slot_offset(), and I think this is addressed by the patch [=
1] I previously sent.
> =

> There are at least a couple of instances in the radix tree code, and I had
> intended to address them together, but I haven't had the chance over the =
last
> couple of weeks.
> =

> I will try to get back to that soon.

Do you have that reworked patch lying around somewhere? I ran into an
ubsan error in radix-tree today and patch [1] fixes things.

> [1] https://lkml.kernel.org/r/20180706134144.48446-1-mark.rutland@arm.com
