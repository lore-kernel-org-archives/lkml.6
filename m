Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 507DDC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 16:03:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D247222A3
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 16:03:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730743AbfBPQDB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Feb 2019 11:03:01 -0500
Received: from mail-vk1-f169.google.com ([209.85.221.169]:39940 "EHLO
        mail-vk1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727151AbfBPQDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Feb 2019 11:03:01 -0500
Received: by mail-vk1-f169.google.com with SMTP id v70so2940836vkv.7
        for <linux-kernel@vger.kernel.org>; Sat, 16 Feb 2019 08:03:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ur42kYMkGEQ3FHaUB+Wf4S4a96mg+tpVRLCFQYPDgNk=;
        b=WyD4zFph61oiz7qyUE+P2Ry9BhENIh/vaOgvWUtuyJYgn6FhI3ElxD67vQ3s081E2r
         hvWfPQ2Pu0ztx0+ZifRhEFUyu4ULWgkDyA8ihP23I6rR/O+hNpQb31yjX4WYWpvS8G1n
         1NcELO78bhML9WjMJQlh94jaoW7nDRj/cSKJCy8yaHAGDRr3TGuQxFJ4xVfYE8vGLvCu
         da8Z84zKbbYQ8o+4DewQypE5NuvSMDB7nTNEOAdPCil1zfF13jbdzjGtHUsVmjUwweXG
         S/iKH0gI27bdmOe6gcJOkdD6sOkx+Bu6v7I0PgJ77RNq2vf4GTEs1iPttleUsxqlQw9b
         BnTw==
X-Gm-Message-State: AHQUAuaIs2fthk6g/jGabL3neSnbcNfA4jYx9FqeT5oTPevcI5XETzbj
        qrvjfQcXtok0iWDwqBEuC9mBeeEcTqgRuvj3O9s=
X-Google-Smtp-Source: AHgI3IYeY7W7fD/W8+kqGYKhwnCpjgZZD0cmFtWg6MNU2uTwOHi6cGKacIjyemsPyrLy+CrHklwx6RWX+qJJ5pSHKJQ=
X-Received: by 2002:a1f:a689:: with SMTP id p131mr8083995vke.67.1550332979836;
 Sat, 16 Feb 2019 08:02:59 -0800 (PST)
MIME-Version: 1.0
References: <2e3222ec-3355-b3d9-8409-5dcdc8b6de0c@canonical.com>
In-Reply-To: <2e3222ec-3355-b3d9-8409-5dcdc8b6de0c@canonical.com>
From:   Ilia Mirkin <imirkin@alum.mit.edu>
Date:   Sat, 16 Feb 2019 11:02:49 -0500
Message-ID: <CAKb7UvgYJEw5xBjkXtomJwbMHLcTK0fr8pxiMODJ49Vv=3EF-w@mail.gmail.com>
Subject: Re: drm/nouveau/bios/ramcfg, setting of RON pull value
To:     Colin Ian King <colin.king@canonical.com>
Cc:     Roy Spliet <rspliet@eclipso.eu>, Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        nouveau <nouveau@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 16, 2019 at 10:02 AM Colin Ian King
<colin.king@canonical.com> wrote:
>
> Hi,
>
> Static Analysis with CoverityScan as detected an issue with the setting
> of the RON pull value in function nvkm_gddr3_calc in
> drm/nouveau/bios/ramcfg.c
>
> This was introduced by commit: c25bf7b6155cb ("drm/nouveau/bios/ramcfg:
> Separate out RON pull value")
>
> CoverityScan reports the issue as follows:
>
>  84        case 0x20:
>  85                CWL = (ram->next->bios.timing[1] & 0x00000f80) >> 7;
>  86                CL  = (ram->next->bios.timing[1] & 0x0000001f) >> 0;
>  87                WR  = (ram->next->bios.timing[2] & 0x007f0000) >> 16;
>  88                /* XXX: Get these values from the VBIOS instead */
>  89                DLL = !(ram->mr[1] & 0x1);
>
>    CID 1324005 (#1 of 1): Operands don't affect result
> (CONSTANT_EXPRESSION_RESULT)
>
> result_independent_of_operands: !(ram->mr[1] & 768) >> 8 is 0 regardless
> of the values of its operands. This occurs as the operand of assignment.
>
>  90                RON = !(ram->mr[1] & 0x300) >> 8;
>  91                break;
>
> Looking at this, I believe perhaps the correct setting could be:
>
> RON = !((ram->mr[1] & 0x300) >> 8);
>
> ..however I don't have the datasheet available for the H/W so I'm not
> sure if this a correct fix.

Actually looking at the code a bit, I suspect it should just be

RON = (ram->mr[1] & 0x300) >> 8;

since later on, when we recompose the MR (memory register) value, we do:

        ram->mr[1] |= (RON & 0x03) << 8;

(And the whole point here is that we don't know how to get the proper
RON value for that timing table version, so we just copy whatever used
to be there in that case.)

  -ilia
