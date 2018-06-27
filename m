Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ECA9C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 09:15:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F16D02671D
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 09:15:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="SLQDOBDc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F16D02671D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933995AbeF0JP2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 05:15:28 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38040 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932877AbeF0JPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 05:15:25 -0400
Received: by mail-ed1-f67.google.com with SMTP id a5-v6so2648235edt.5
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 02:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=ski9bcVTStW4Ks3f/BVI8QJdbGUjZk0lqYAzJFroNpQ=;
        b=SLQDOBDcxYCA/8mSU5GYJdgy6W5PLeTIsvo9+/MBv+NhU/aGXaErM1tWLOQxeDkaQN
         OYRu+AWDiEB5PAixTmj65AxacmGKHd26ZrMlW97Fx5aAoEPWIpFJBl3CI+j/zOb28392
         V8KbXaOyHhjWJw+7KXrOb5mMGKxPr9R8BHIEg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=ski9bcVTStW4Ks3f/BVI8QJdbGUjZk0lqYAzJFroNpQ=;
        b=XFJTfKPdrF53XxpS/vDXT1JT28bxgc8YufXeFbH34iCsTTWG8F0lG/LznL/PgJmkFG
         FS6Y7EJXux7uNMEmwZ6kZbeoGYbTTlBfowVq7KBnvWV0w619IcVCq7mb3Ib4wh1U+lfo
         tEMWy9vBwwimjHvrlgN6v6A6ITPd7Uo7BADcNKH8xxxm/n6jflgP6ok1nb6rUyNPVP7t
         6Qdt3DVcdREKkUxkgJXyR+UXptPnnbGUia59FYjY226whGS3EbY+x+2ieMZMFyv+TJe/
         rzKxQwpg4nfmL6OEUQ2NRMBX4T0M+hTR6hfUp+aZr1kUUvkCZSxryEq9kG/ZUgf/RHw6
         4Z2A==
X-Gm-Message-State: APt69E0GGFDSLt4UWehixGyKickYfAjRZqPlLwYtP18ea7/PCp75NigG
        Zvc8fRVh/QLR04FDVyj45Kt8jg==
X-Google-Smtp-Source: AAOMgpeBdDshqN46/YEKWXPnGJBHmFgy1nPjI6Fi/raTl/hgxIEYrlAtRMr4oh98/JVN9mmY3/z0Gw==
X-Received: by 2002:a50:88c2:: with SMTP id d60-v6mr4766610edd.281.1530090924271;
        Wed, 27 Jun 2018 02:15:24 -0700 (PDT)
Received: from phenom.ffwll.local (212-51-149-109.fiber7.init7.net. [212.51.149.109])
        by smtp.gmail.com with ESMTPSA id m10-v6sm1714053edp.57.2018.06.27.02.15.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Jun 2018 02:15:23 -0700 (PDT)
Date:   Wed, 27 Jun 2018 11:15:20 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-fbdev@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/3] console/fbcon: Add support for deferred console
 takeover
Message-ID: <20180627091520.GI13978@phenom.ffwll.local>
Mail-Followup-To: Hans de Goede <hdegoede@redhat.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-fbdev@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20180626183612.321-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180626183612.321-1-hdegoede@redhat.com>
X-Operating-System: Linux phenom 4.16.0-2-amd64 
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2018 at 08:36:09PM +0200, Hans de Goede wrote:
> Hi All,
> 
> Here is v4 of my patch-set, to delay fbcon taking over the console (and
> binding to fbdev devices) until there actually is some text output to the
> console. This is intended for use with the "quiet" cmdline option, in
> combination with a bootloader which leaves the vendor's logo /
> EFI bootgraphics put up by the firmware intact on the EFI framebuffer.
> 
> The end goal here is a boot where the firmware shows its boot graphics
> and these stay in place for a couple of seconds until the GUI loads and
> the GUI then smoothly takes over the framebuffer without any distruptions.
> 
> This patch-set spans 2 subsystems.
> 
> Petr, the printk subsys change is really trivial (1 line addition) can we
> get your Acked-by for merging all 3 patches through the fbdev tree?
> 
> Changelog:
> 
> Changes in v4:
> -Keep the comments about which fbcon functions need locks in place
> 
> Changes in v3:
> -Export is_console_locke() for use in modules (as fbcon may be built as a .ko)
> -Use WARN_CONSOLE_UNLOCKED() in several places in the fbcon code to assert
>  proper locking (requested by Daniel)
> -Unregister the fbcon-dummycon-output-notifier on fbcon_exit() (req. by Daniel)
> -Document the fbcon=nodefer commandline option (req. by Emil)
> 
> Changes in v2:
> -Check the whole string when checking for erases in putcs, instead of just
>  the first char
> -Make dummycon_blank return 1, so that a redraw gets triggered and any text
>  rendered while blanked gets output so that it can trigger a deferred
>  takeover if one is pending

Wrt merging I think it'd be best if we stuff this into drm-misc-next -
that will increase testing by gpu drivers a lot, instead of a suprise when
the fbdev pull lands in upstream.

Bart, is that ok with you?

Hans, if Bart acks this you can directly push this imo.
-Daniel

> 
> Regards,
> 
> Hans
>  
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
