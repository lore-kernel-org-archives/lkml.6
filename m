Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5BDDC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 19:33:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2555B20855
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 19:33:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="G25Upoqn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2555B20855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbeK0G3F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 01:29:05 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:46886 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbeK0G3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 01:29:04 -0500
Received: by mail-ed1-f67.google.com with SMTP id o10so16851404edt.13
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 11:33:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Dhq9Wa8DxbKUhiU3QROo0wkZHkmKjBUi00KD1NSMmPk=;
        b=G25Upoqn4I+nd6KSceXUZR0X78iS6lZYv0F3w2AkkgAFyhD89slHzkaZ/ZPwbabHNB
         b3/Kw9J+ULBjPi+0AjRUADCicJbfgYqq4sLScOZPRswXRKE8IGmf9cf7Bg/LJ/T7fqh9
         FmWx/PYqXKAFbjO5u8x1ET4jb7gES2AWiUcto=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Dhq9Wa8DxbKUhiU3QROo0wkZHkmKjBUi00KD1NSMmPk=;
        b=fIfAiENmGf0OT2ZJgICoEcKzvG9oqvGGTedr3AJetP1kSXxVaEO9TpwTAQrmRlTtzA
         QNUeo3ezDcK/YAZq7qAV+xIV11BFBWjdMB3XSJD0mg+0Jm77PWMCOkm9trFGFhUYQX4+
         zJrzlh3HugLrsoVsRp+gYWZzmaetG6GRUUu1ByJQKJy5PFzB5cQLcXi1pEOQ9Ay5Fkqo
         dojGr+eWuTJH2PHrOyHoqNVPIQJzbjNNoMapsqqVfyxdV+0zuGd/vARYKptmM0I8DSaY
         5tdM8xk4AzFsk5GfojVDXnl1S4X2XpcTvk/6bbQ2fVjyQEophVesawcPqlkdoFkARgD9
         FanA==
X-Gm-Message-State: AGRZ1gI3DpV9vYCsWidwi7qCJJBlJjTNh0bHg+tZgkizzC4IP84dS0xk
        88/m51CJV7BDOAsnRNyehvg0jA==
X-Google-Smtp-Source: AJdET5e4BWNgwf3TBLNR4UD0ZZ+n4uZlMfVufKIcoINYntE/DqhpmDzpKwxMvV4YdFymNxt8ESg+NQ==
X-Received: by 2002:a17:906:32c6:: with SMTP id k6-v6mr21360129ejk.48.1543260835516;
        Mon, 26 Nov 2018 11:33:55 -0800 (PST)
Received: from andrea (dynamic-2a00-1028-8386-da8a-eacb-c188-78b9-634c.ipv6.broadband.iol.cz. [2a00:1028:8386:da8a:eacb:c188:78b9:634c])
        by smtp.gmail.com with ESMTPSA id w10sm384955eda.77.2018.11.26.11.33.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Nov 2018 11:33:54 -0800 (PST)
Date:   Mon, 26 Nov 2018 20:33:49 +0100
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     Will Deacon <will.deacon@arm.com>
Cc:     corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Laight <David.Laight@ACULAB.COM>,
        Alan Stern <stern@rowland.harvard.edu>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH] docs/memory-barriers.txt: Enforce heavy ordering for
 port I/O accesses
Message-ID: <20181126193349.GA3509@andrea>
References: <1543251134-29867-1-git-send-email-will.deacon@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1543251134-29867-1-git-send-email-will.deacon@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 04:52:14PM +0000, Will Deacon wrote:
> David Laight explains:
> 
>   | A long time ago there was a document from Intel that said that
>   | inb/outb weren't necessarily synchronised wrt memory accesses.
>   | (Might be P-pro era). However no processors actually behaved that
>   | way and more recent docs say that inb/outb are fully ordered.

No intention to diminish David Laight's authority of course, but I would
have really appreciated a reference to these "recent docs" (section, pg.
or the like, especially if a reference manual...) here...


> 
> This also reflects the situation on other architectures, the the port
> accessor macros tend to be implemented in terms of readX/writeX.
> 
> Update Documentation/memory-barriers.txt to reflect reality.

..., IOW, what do you mean by "reality"?

> 
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: David Laight <David.Laight@ACULAB.COM>
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>

Please Cc me on future patches to memory-barriers.txt (can not speak for
my co-maintainers, but I'm inclined to say that get_maintainers.pl knows
better...).

  Andrea


> ---
> 
> Just remembered I had this patch kicking around in my tree...
> 
>  Documentation/memory-barriers.txt | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
> index c1d913944ad8..0c34c5dac138 100644
> --- a/Documentation/memory-barriers.txt
> +++ b/Documentation/memory-barriers.txt
> @@ -2619,10 +2619,8 @@ functions:
>       intermediary bridges (such as the PCI host bridge) may not fully honour
>       that.
>  
> -     They are guaranteed to be fully ordered with respect to each other.
> -
> -     They are not guaranteed to be fully ordered with respect to other types of
> -     memory and I/O operation.
> +     They are guaranteed to be fully ordered with respect to each other and
> +     also with respect to other types of memory and I/O operation.
>  
>   (*) readX(), writeX():
>  
> -- 
> 2.1.4
> 
