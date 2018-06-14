Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id BCB09C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:56:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 736B1208DA
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:56:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kssmkVSP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 736B1208DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936354AbeFNOz7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 10:55:59 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:34669 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936213AbeFNOz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 10:55:56 -0400
Received: by mail-lf0-f67.google.com with SMTP id o9-v6so9920699lfk.1;
        Thu, 14 Jun 2018 07:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fqFk7fkj047VJb5w1EpmLPuaaaUzgZlCAfDuYI18AAI=;
        b=kssmkVSPrNxhrFrJ13MMmbCNf5o4u10xf1Wkd4eq2Jp97c9BmwQAmckWa6fqVXOi+J
         /E0oYAzpjJd9ri41q8HvWWqrhBfwO+pu3piaty5fhgnoBDV7wJ054orw3hKM0SEbCgPK
         zRjIaHpqOINnL7NWi/QGqjpiox+dSNFLYRcCC7AHSFhQF7aqHxmB0zSThZnASj/eK35/
         oL1Lkq2eoHbVSfLbg2Z/cXGrox2gwnp20akLuYmtNgeO3CLAg09A6Da2Exg7bkB9yU7A
         32HayvMbdwFa6jxQ+1yKAN0hkRShE1Hsye72cAJcVXxi5dgxOr04ya925c2PYjxv/JYn
         q9dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=fqFk7fkj047VJb5w1EpmLPuaaaUzgZlCAfDuYI18AAI=;
        b=tBNmoI8NvwC8L/fAE/2qBvhykZfO+Vmj3DsX5/mwyqiNvnOGjdm/cfG5l4oyUJcuU4
         BgqrGteJhVQNXGB04ax7qgGU8g6BzskeHrQ8t9XJzkAlntzCdj6gmWpBxWF/i2pibbED
         ZftkSXIrWq9ncPZCWNwKtb9yGcqutBA8HOwDwqf4YVJDC5zDh02BQQpzr4l2q/rQ4Pjt
         f7AUGizb3z5Bq+4K3PqvD0BhNdedW/uW7s9LWzsFLDysDJYXAQ6jxZV//ruax1ajVUpC
         7ISh3tHL6QiUa4ccIYa5b0H1g9qhOqujmpwOWn9WLuDt2qCLaYQlxdpbqCnC6QuUitGg
         mPVg==
X-Gm-Message-State: APt69E2gYnkhHv+MtcuHpvUVfWja6zedOoTwVPdVpFplEoQePwHDh9zs
        QS/lu63GXcQ4lp6sflI+KUI=
X-Google-Smtp-Source: ADUXVKJdhVkJ5JaVlvO/Llr8FiBFJJ6JbjNst8ZVGu9LPX02r1go4qr4sFMDm4eRbiBb/6rworH2jg==
X-Received: by 2002:a2e:1155:: with SMTP id f82-v6mr1993743lje.75.1528988154832;
        Thu, 14 Jun 2018 07:55:54 -0700 (PDT)
Received: from xi.terra (c-8bb2e655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.178.139])
        by smtp.gmail.com with ESMTPSA id d19-v6sm1102587lfl.82.2018.06.14.07.55.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Jun 2018 07:55:54 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.90_1)
        (envelope-from <johan@kernel.org>)
        id 1fTTet-0003m1-Vp; Thu, 14 Jun 2018 16:55:32 +0200
Date:   Thu, 14 Jun 2018 16:55:31 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Cc:     Johan Hovold <johan@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Rob Herring <robh@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2 00/19] Dynamically load/remove serdev devices via
 sysfs*
Message-ID: <20180614145531.GE32411@localhost>
References: <20180611115240.32606-1-ricardo.ribalda@gmail.com>
 <20180614104820.GC32411@localhost>
 <CAPybu_0TSdQFOL1ptv67-aKktAftYWPwnSnevmBd_b1T0W7LYg@mail.gmail.com>
 <20180614133341.GD32411@localhost>
 <CAPybu_3=KhPB_ymtRNSZfcyP57LPD2SbLUPoFO0YdjkzAsdaTA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPybu_3=KhPB_ymtRNSZfcyP57LPD2SbLUPoFO0YdjkzAsdaTA@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 14, 2018 at 04:06:18PM +0200, Ricardo Ribalda Delgado wrote:
> Hi Johan,
> On Thu, Jun 14, 2018 at 3:34 PM Johan Hovold <johan@kernel.org> wrote:

> > And there are more issues with the series which are less apparent than
> > the rx (and partial tx) regression.
> 
> Any hints about this? What else should I change on the series?

There are implementation issues and there's the more fundamental
question about whether your approach to this is the right one.

Like Rob, I'm not sure we want to have the device topology depend on a
kernel config symbol (serdev and your ttydev driver). We may need to
explore Rob's sibling-device idea further.

I also want to make sure that this can be used for discoverable buses
(e.g. the USB CEC device the I've used as an example before).

As for the current implementation there are both larger and smaller
issues, like for example:

 - the fact that your sysfs and lookup interface does not use any
   locking whatsoever and thus is susceptible to races

 - your ttyport driver currently breaks the sysfs interface for all
   serial (core) devices by ignoring the attribute groups

 - the ttyport driver is arguably a hack with layering issues (which
   admittedly may be hard to avoid given the retrofitting of serdev into
   the tty layer)

Again, I suggest you submit a subset of your series (aim at 10 patches
or so) as an RFC which can be used as a basis for further discussion. No
point in discussing every implementation detail if the underlying
approach needs to be revised.

> > It's legacy as in old, and to be used for one-off hacks and such. But
> > sure, that is also what this series aims at even if that doesn't mean
> > you *have to* copy the interface.
> 
> It is not only one-off hack. It is the ONLY way to use i2c devices
> that are not enumerated.
> 
> The same way as today we do not have any way of using serdev on non
> enumerated devices.

You're missing the point: none of that means you have to copy the
interface.

Johan
