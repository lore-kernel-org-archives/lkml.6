Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 817B2C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 15:48:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 174C8208A3
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 15:48:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="GXYAB65L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 174C8208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389842AbeHARfI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 13:35:08 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36216 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389619AbeHARfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 13:35:08 -0400
Received: by mail-wm0-f67.google.com with SMTP id w24-v6so6114705wmc.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 08:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=X0+BmBR1+8mYh7bQdg9io0ovUtaOQ843XUfVsGgkYZk=;
        b=GXYAB65LOBIXCa3BeAril47kyzINDAZg7nn/HUW8Y6xJRuFxRCJdV4nugAvhaI95eM
         CgZ6y4WsNcmf4VeCEKlTkh/e76fccL5zoCbkm6AoL+WKSeyqgzW0ls3xLP1z841GJZ5+
         Z8paraOhq6qQijTmOF7m4zjC4kzWQPQUsvqanxKtX92EZZaBtWm25eT6lCf6fR/UCp36
         pZzfDxYjBFLqowzGTTQxZs7PeVHljfB/JO8MMZXtDa8gV7w/3zkA0NqMtg5gS2KYXOXd
         g6mrxdwmxm6BjvcEGXdL3ME2iFkEuhLuoIJj/eth4bvEvLVhqTrOVYlbVICLYDXOVBEe
         Pf3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=X0+BmBR1+8mYh7bQdg9io0ovUtaOQ843XUfVsGgkYZk=;
        b=DaWHXmkWKwonU5W/0EzWdgwMpc7mvnaRQy/bLOcnzJyukiYIi1ZzeKEWEYhfhF9kQB
         7Q9yxDII65O9yH+H9eHTqn7atj2+FpUQ3DEmdchuhOwEZffpJQouRMnigOj/2SjzsKgU
         02+eXriwVj0bNr2RJMot90Zre6Y28DXm90+dJoQiO8GCYNdljAqBLs46rlCuLDumSf98
         Qd62omiz3tv0O6uGrn6Tb9GEjUqA3DjUtRtG4MWDJZzJZtj/ty9wl8NrpzEq8kS8RoGJ
         eM6Q9vS3FHBFCBEaepyFQGN/wVeN7RB1vfgUNcH/RmVU+HV2PKiCKEq90lGpqGLEvyoH
         em5g==
X-Gm-Message-State: AOUpUlG/iat511/QgWaDhqYameL50p955zU6STNlb+7hdnV9oNALw260
        /mHtxf6s2xaFE0bb8zhZF9TYOg==
X-Google-Smtp-Source: AAOMgpdfJVOEi+CMn3OyiL4KcSP/uYMWTGuWna6HxGdUWocKGju7CdVvpHqtoCABDvFqVzYWjsOCxw==
X-Received: by 2002:a1c:b984:: with SMTP id j126-v6mr3017782wmf.25.1533138527004;
        Wed, 01 Aug 2018 08:48:47 -0700 (PDT)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id m207-v6sm6958118wma.31.2018.08.01.08.48.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Aug 2018 08:48:46 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.86_2)
        (envelope-from <jgg@ziepe.ca>)
        id 1fktMf-0003Pv-UN; Wed, 01 Aug 2018 09:48:41 -0600
Date:   Wed, 1 Aug 2018 09:48:41 -0600
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Leon Romanovsky <leonro@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        Bart Van Assche <Bart.VanAssche@wdc.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] overflow.h: Add arithmetic shift helper
Message-ID: <20180801154841.GA10824@ziepe.ca>
References: <20180801000039.44314-1-keescook@chromium.org>
 <20180801000039.44314-2-keescook@chromium.org>
 <20180801075744.qpppbaywp5dklxul@mwanda>
 <20180801080724.2vgzagooda56aypw@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180801080724.2vgzagooda56aypw@mwanda>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 01, 2018 at 11:07:24AM +0300, Dan Carpenter wrote:
> On Wed, Aug 01, 2018 at 10:57:44AM +0300, Dan Carpenter wrote:
> > The idea is nice, but I don't like the API.  The "_overflow" feels too
> > specific because maybe we could check for other things in the future.
> > Normally boolean macros should say they are boolean in the name and I
> > would prefer if it returned zero on failure.
> > 
> > 	if (!checked_shift(dest, mask, shift)) {
> > 	if (!shift_ok(dest, mask, shift)) {
> > 	if (!safe_shift(dest, mask, shift)) {
> 
> Huh...  It turns out I put the argument order different as well.
> 
> If we wanted to keep it returning 1 on failure then some other names
> are:
> 
> 	if (shift_failed(dest, mask, shift)) {
> 	if (shift_error(dest, mask, shift)) {
> 	if (shift_overflow(dest, mask, shift)) {

I think this ship has sailed, the convention for these tests is
already established in overflow.h. ie:

check_add_overflow
check_sub_overflow
check_mul_overflow

Jason
