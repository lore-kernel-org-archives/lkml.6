Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7DEDC65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:38:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E3DA20644
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:38:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CzhGkfS7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E3DA20644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727670AbeJHWvD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 18:51:03 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:41272 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727279AbeJHWvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 18:51:01 -0400
Received: by mail-lf1-f66.google.com with SMTP id q39-v6so14243760lfi.8;
        Mon, 08 Oct 2018 08:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3JUtAQSBvnjsHhi7rzPs7uiH357XflzdvnRYKkxs2FA=;
        b=CzhGkfS7sr5utty3opPM2ISYy6qslUxUacgK4yonPZMisnVW/2p06EECzsZ6L6A6ge
         j1LZwxJ87zLj4x4drX29pz0GFEoRH9lmWMtmhodJA3cpRljnpiRiIiw8+LWo1kkpsIM1
         Es4cOtZKAhycJjYIyh/J33Wa6hYqz8Uz9J1i+u2TEqhTFOl+gDPJ1qIVWENXDVwpoQLD
         i3FJWWMkKCf7bOHUQGxhTqMnhSud8GudfNKu1l68D0Z1V1gt3ggGHdACKdX+2SbB/kFM
         2R+TeAd1bS9/cbLIMf2/vK/2eGMKv6siiRmZdajG4T9Vcxduq0ZpiJ0CktKWQkWDBHGQ
         Jxvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=3JUtAQSBvnjsHhi7rzPs7uiH357XflzdvnRYKkxs2FA=;
        b=r0fKiVyDUnbooM1RkVukkRUf7MrhKKhRZPymalHoh1nmDb4IjcTujy74ZZ8KVaVYww
         a3n9Ex+PIidCzpwdSbONt7LoxkErTPPHuJzdH1qxkqNM1k/y9dsWqoVmZx8WXUBTvh+n
         2PObC9V5nRDhYFQdk1DGPGXHOadL2itYQRMIgkhoiZnIsDDtv9egG+t74/FC79rfGci0
         hnxQa9A/JIDHGXM9p4VrR/yJl0EDuboIgmXvRCvBC2VGcPZrw32VphLgTU/jarM7fFNR
         NoxtH0ljKaoegD+Q21YO6rY0QOpA9gAWan6wacMDrAL+3/YCEVHVm3vqctHWhQbNjvE8
         n2Zg==
X-Gm-Message-State: ABuFfoj1l36MmD/ApysTweniLjockRUVPC4yepnipyGk+thRCyMBlg6I
        RrF4Q4BKxCzttp+DtkQkK1c=
X-Google-Smtp-Source: ACcGV60s36LHnbeZOComXCGk4Y9W3++zag6nEsDzN0gA3B6Pf252TgoFMbCX+AU7132NC/T8u/EvsQ==
X-Received: by 2002:a19:f817:: with SMTP id a23-v6mr7202228lff.67.1539013120560;
        Mon, 08 Oct 2018 08:38:40 -0700 (PDT)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id u70-v6sm3542882lff.60.2018.10.08.08.38.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Oct 2018 08:38:39 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1g9XcG-00033u-2x; Mon, 08 Oct 2018 17:38:40 +0200
Date:   Mon, 8 Oct 2018 17:38:40 +0200
From:   Johan Hovold <johan@kernel.org>
To:     "H. Peter Anvin" <hpa@zytor.com>
Cc:     linux-kernel@vger.kernel.org,
        Tobias Klausmann <klausman@schwarzvogel.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        linux-alpha@vger.kernel.org, linux-serial@vger.kernel.org,
        Johan Hovold <johan@kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, stable@vger.kernel.org
Subject: Re: [PATCH stable v2 1/2] arch/alpha, termios: implement BOTHER,
 IBSHIFT and termios2
Message-ID: <20181008153840.GD3332@localhost>
References: <20181008040620.1248277-1-hpa@zytor.com>
 <20181008040620.1248277-2-hpa@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181008040620.1248277-2-hpa@zytor.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 07, 2018 at 09:06:19PM -0700, H. Peter Anvin wrote:
> From: "H. Peter Anvin (Intel)" <hpa@zytor.com>
> 
> Alpha has had c_ispeed and c_ospeed, but still set speeds in c_cflags
> using arbitrary flags. Because BOTHER is not defined, the general
> Linux code doesn't allow setting arbitrary baud rates, and because
> CBAUDEX == 0, we can have an array overrun of the baud_rate[] table in
> drivers/tty/tty_baudrate.c if (c_cflags & CBAUD) == 037.
> 
> Resolve both problems by #defining BOTHER to 037 on Alpha.
> 
> However, userspace still needs to know if setting BOTHER is actually
> safe given legacy kernels (does anyone actually care about that on
> Alpha anymore?), so enable the TCGETS2/TCSETS*2 ioctls on Alpha, even
> though they use the same structure. Define struct termios2 just for
> compatibility; it is the exact same structure as struct termios. In a
> future patchset, this will be cleaned up so the uapi headers are
> usable from libc.

Is this really needed? By defining BOTHER (and IBSHIFT which you forgot
to mention here) you are enabling arbitrary rates also through TCSETS on
alpha, right?

Johan
