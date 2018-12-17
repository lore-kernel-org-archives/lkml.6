Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9538DC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 08:42:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AEEF206A2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 08:42:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731872AbeLQImy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 03:42:54 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45033 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbeLQImx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 03:42:53 -0500
Received: by mail-lj1-f196.google.com with SMTP id k19-v6so10184215lji.11;
        Mon, 17 Dec 2018 00:42:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lOpk3iokPq/ouQ0GXoJw7plcuOxVgghAfiwV38ljYsg=;
        b=d/k7MmNh1dajaObMIIrSbPAGTLG/kBH7za2Dh5d3p7Y4vqYsVQdribt3yIeAMewXlw
         aKzKcctRfpPSD+KqXrgg5mrAP0bQsBssIXlWShNb3Ng+u2oEqMK5GnV835+MMwnw1978
         Telf/5cVPRbq0B1uY7DPzIZtQXmKF/2mA0YucG/yIQcYuPy9LkQNEZf/ByHOy7VgtkI6
         g6v8ZkrJSbHJdVNnVNhAVd2ArfwN+yurVE/egw9s6cGsCfHMVrpfEHaCAEIOZtpYq/gG
         INShWasmPLtGmfR1HbAwo+KECCde48GLqkuXSU/5hGh7WJc0/MA1GFG8cssJUq5O3h+b
         JmDA==
X-Gm-Message-State: AA+aEWatvWufOumeuyL5b87hfTyn9USkd5AQ8bL9r1cZSny4bbDzWnJa
        GMY43Nc6Zfg+tCLPeuDmzxk=
X-Google-Smtp-Source: AFSGD/U5uFmojAza2dPCvnVpgAdNTplfgrV/p2+Z65iRErrnyyISjllOHMq7sKKj/Fmj6AVb5ZQDug==
X-Received: by 2002:a2e:5b1d:: with SMTP id p29-v6mr6927012ljb.176.1545036171627;
        Mon, 17 Dec 2018 00:42:51 -0800 (PST)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id q3sm2545192lff.42.2018.12.17.00.42.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Dec 2018 00:42:50 -0800 (PST)
Date:   Mon, 17 Dec 2018 10:42:48 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     mazziesaccount@gmail.com, gregkh@linuxfoundation.org,
        rafael@kernel.org, linus.walleij@linaro.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        heikki.haikola@fi.rohmeurope.com, mikko.mutanen@fi.rohmeurope.com,
        vladimir_zapolskiy@mentor.com, matti.vaittinen@fi.rohmeurope.com
Subject: Re: [RFC PATCH v2] regmap: regmap-irq/gpio-max77620: add level-irq
 support
Message-ID: <20181217084248.GC2477@localhost.localdomain>
References: <20181211140555.GA5872@localhost.localdomain>
 <20181213182026.GX10669@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181213182026.GX10669@sirena.org.uk>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Mark,

On Thu, Dec 13, 2018 at 06:20:26PM +0000, Mark Brown wrote:
> On Tue, Dec 11, 2018 at 04:05:55PM +0200, Matti Vaittinen wrote:
> 
> > One specific question hit me while doing this. Why does the regmap-irq
> > core do default trigger type configuration? I did leave this in the
> > patch - but to me it is strange. For me it would be unexpected that the
> > HW default trigger level is changed by common code. I would understand
> > if change was done by some board specific code, or code specific to a
> > chip - but 'core' doing this seems wrong to me. Should it be removed?
> 
> I can't remember and can't find any record of any discussion of it which
> is odd, might've been on IRC or something.  Let's just remove it and see
> what breaks, since we generally provide the type along with the request
> for the interrupt I'm not sure how often the default actually gets used.  
> Possibly safer as a second patch though in case there is a good reason
> that I missed so we can easily revert it.

So how do you see this - should the regmap_add_irq_chip read the current
type setting information from HW and populate the cached type values
based on the current HW configuration? (I think that would be corect
thing to do).

> Unfortunately this also collides with a change I applied earlier on from
> Bartosz which supports chips that use masks instead of a separate type
> register to handle types so it'll need respinning, sorry about that.

No problem - I'll fetch the latest changes from regulator tree and see
how to fit this in. It may be this will be done after the holidays
though - I'm not sure how my schedules are during the next few weeks...
Besides I have also this "main IRQ status" -thing ongoing.

>  It
> does look safe to me but it's possible I missed something.  Equally it
> only seems to be some quite old Tegra systems using the max77620 so
> perhaps mainline usage of affected devices is limited anyway...

Right. This makes me wonder if there is some other preferred approach on
this... How other drivers are doing the type configurations? Why they
are not using regmap-irq? Am I missing something? But what comes to
changing the regmap-irq type-setting this is definitely a good news =)
And... Thanks for all the feedback and support Mark!

Br,
	Matti Vaittinen

-- 
Matti Vaittinen
ROHM Semiconductors

~~~ "I don't think so," said Rene Descartes.  Just then, he vanished ~~~
