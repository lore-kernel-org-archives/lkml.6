Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1DA3C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 06:58:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 955ED2083E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 06:58:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QyLuna4M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 955ED2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbeJYP31 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 11:29:27 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40595 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726538AbeJYP31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 11:29:27 -0400
Received: by mail-wm1-f65.google.com with SMTP id b203-v6so306843wme.5
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 23:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=ABTNPdKRb0fqfK5oURC51XYb4y8hDH4Z1w4LHREJZMg=;
        b=QyLuna4MzRVLskbLlcgQzYJC4zctInqPVBVz8iFVRncFaU+AnOd8B9j2kYMLudJW5P
         b6EKZuBkRZn3kvsWY0BnW/iJUIJi0tY3ULDe+ZXh14g1MUGfbrwzqjATfw3/mnFYniZE
         c5z0GtjFQ05Cl8zZ2FMqVaCfiXAxllHdYss9g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ABTNPdKRb0fqfK5oURC51XYb4y8hDH4Z1w4LHREJZMg=;
        b=bLwKXAcbXh175/UV3MEzcJ0kqpkkqhBAqE/gw9hvm7uozSvbMRMadSy9POC/Pb/xiM
         OoHB7O+q+l24BmoHX4EV1ccA09/zYWD2ay6uDwuhyrbOy0hSXnNI+udqNhHPMFYjoYvt
         aUJu7xTLYjvpXdfDr0Q2NHsr3D8PET+4osqnvgK1XYq/74lePvSKPi3uYAv/xDoSfC2W
         cdR3Zmay1c0VgcdL9WqpttfhP02En+6v69Cf8DUPJV6UJGPA+9DL4hWUclE2/DJTLpyx
         Ee9+wB+J3nEokSz6OqqHNScTYMo6Ei2XAtes+kDJINrONU/bMTu2ee2ahMJXJLA2MK4S
         t4mw==
X-Gm-Message-State: AGRZ1gLOPTYRXRHbs1GFSC9RlvP35GYHetecZ7dgnypH96MxLZmS1A2s
        lOOmmbwy9jW0FOpPgJBwUVClpg==
X-Google-Smtp-Source: AJdET5cbXb1XV289VQq6At7Cr7QgQd+m2vqkUKnsR0CsTUP7Lbu1Vb7nUWzGAqAsDk601Dd4PH7XJw==
X-Received: by 2002:a1c:b082:: with SMTP id z124-v6mr447623wme.129.1540450682005;
        Wed, 24 Oct 2018 23:58:02 -0700 (PDT)
Received: from dell ([2.31.167.182])
        by smtp.gmail.com with ESMTPSA id t198-v6sm306971wmd.9.2018.10.24.23.58.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Oct 2018 23:58:01 -0700 (PDT)
Date:   Thu, 25 Oct 2018 07:57:59 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mfd: remove redundant 'default n' from Kconfig
Message-ID: <20181025065759.GE4939@dell>
References: <CGME20181010145127eucas1p2fcd5b5f91fa3ac7f763a51c0d5e8b3cb@eucas1p2.samsung.com>
 <20181010145127eucas1p2fcd5b5f91fa3ac7f763a51c0d5e8b3cb~cRtzjSAO11833118331eucas1p2t@eucas1p2.samsung.com>
 <20181011054806.GS4939@dell>
 <20181012120851eucas1p27177441e71df4665a87d0a5d87a61796~c2yaPCm9h0943209432eucas1p2Q@eucas1p2.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181012120851eucas1p27177441e71df4665a87d0a5d87a61796~c2yaPCm9h0943209432eucas1p2Q@eucas1p2.samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Oct 2018, Bartlomiej Zolnierkiewicz wrote:
> On 10/11/2018 07:48 AM, Lee Jones wrote:
> > On Wed, 10 Oct 2018, Bartlomiej Zolnierkiewicz wrote:
> > 
> >> 'default n' is the default value for any bool or tristate Kconfig
> >> setting so there is no need to write it explicitly.
> >>
> >> Also since commit f467c5640c29 ("kconfig: only write '# CONFIG_FOO
> >> is not set' for visible symbols") the Kconfig behavior is the same
> >> regardless of 'default n' being present or not:
> >>
> >>     ...
> >>     One side effect of (and the main motivation for) this change is making
> >>     the following two definitions behave exactly the same:
> >>     
> >>         config FOO
> >>                 bool
> >>     
> >>         config FOO
> >>                 bool
> >>                 default n
> >>     
> >>     With this change, neither of these will generate a
> >>     '# CONFIG_FOO is not set' line (assuming FOO isn't selected/implied).
> >>     That might make it clearer to people that a bare 'default n' is
> >>     redundant.
> >>     ...
> >>
> >> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> >> ---
> >>  drivers/mfd/Kconfig |    6 ------
> >>  1 file changed, 6 deletions(-)
> > 
> > The change looks okay to me, but I would also like you to include the
> > Maintainers/Reviewers for the affected source files.
> 
> Could you please explain in more details what do you mean?
> 
> The only affected source file is drivers/mfd/Kconfig:
> 
> $ ./scripts/get_maintainer.pl -f drivers/mfd/Kconfig 
> Lee Jones <lee.jones@linaro.org> (supporter:MULTIFUNCTION DEVICES (MFD))
> linux-kernel@vger.kernel.org (open list)

You need to run get_maintainer.pl on each of the source files this
patch affects.

> > Also, I assume you are not just submitting these changes to the MFD
> > subsystem.  My suggesting is to change each subsystem per patch (as
> > you have done here), and submit them in one patch-set with each of the
> > subsystem Maintainers included, so each of us has some visibility into
> > how the general idea is being received.
> 
> The general idea is trivial - remove redundant "default n" from Kconfig
> files and as a result cut ~700 LOC kernel wide. I assume that this is so
> trivial change that there is no need for longer deliberations.

I agree that the patch looks fairly inert.

> Also I'm sorry but I simply cannot invest few days straight in preparing
> the full patchset. OTOH investing few minutes a day or a week is fine so
> this is why I'm doing this change incrementally.

However, converting a few subsystems at a time doesn't sound like a
great hardship.  It allows other Maintainers to see how the idea is
being received generally - rather than doing them all independently
which disallows shared interest/discussion.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
