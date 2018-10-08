Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB0C6C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:47:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F2962087D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:47:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bn8TqaAy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F2962087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbeJHW7V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 18:59:21 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:35581 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726391AbeJHW7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 18:59:21 -0400
Received: by mail-lf1-f67.google.com with SMTP id r191-v6so14291976lff.2;
        Mon, 08 Oct 2018 08:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Vi2/uku5IYxNJTJmia6m4ECLtTso7nN62ecI51I0Nyw=;
        b=Bn8TqaAyVPIU8ZwVyHby1iPr3zyePtz8X9zn+LKTWsCSgm3zEpGOoMtTW6RjBTC2e7
         k7iK4UWG9H/tgOYNMokCCCSZcCQXQi9y1MCaMQJidnIiTsFWe01bKv5i+iD3UKvq4BkG
         WJv0vDX55rRnBEubufOZFt0YbwfXmH+YoLqKo7lGy5xhTScyyO6E8extIjlUpAJsh1+L
         QJa2pV762is809d6srBcHZn0K0Xy61WVHy+nScOOT05+6turQjRf/tqDB46PF3fN28G7
         QXZ0vXO/3WS+Gc3hz8Ekei8CJaoPOOgbrDRkMJAHaPzZEkr5BKONE/2Mlfp1dlcFivja
         m0sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Vi2/uku5IYxNJTJmia6m4ECLtTso7nN62ecI51I0Nyw=;
        b=qJ5nOWuG5D7PgatngjOCdISlye7nOJI79SoUvz2+4cWndo9YVWubDWQe1C9P6rx4Mq
         Newh47lQB4mQrFVkGde/RXMo+uC4t81Bb/GbQE1qdymq8cjXAYHMii+VGIZBiHeESXLe
         DMN1hoPzn+uYtwAUzrMuhPjnxHr0hXGwNGrUTcHrhvTosZyqHFN4j7ev2LgfYlsdMOc+
         ajKdqyCVmLw9ypM9smnZ2EWQl+QaAW50PXd4TC67zOLI3i0fO0Z8AeWsWzQVBbvrrntx
         RPU3aezcA9CpY4c+CEkUM5AMOXv3Fr/57qwiM6hqxwkTA+gjWIqv9Jy1hibeiGtevUI8
         M5Wg==
X-Gm-Message-State: ABuFfogfUlg8qoSQXv62oOMJE+q5F1qXU8KzPUHxc/5Jb4FoDyC+53RV
        yiw5uSXEKOkFGeanECPeV5A=
X-Google-Smtp-Source: ACcGV62WvMAt4MbuORc0ByGhPQgRKVoU02VOrRdVAYrI8+2zGwg396lAiybNvJvVXPkSzNMz9bi2kg==
X-Received: by 2002:a19:a501:: with SMTP id o1-v6mr12728776lfe.41.1539013616835;
        Mon, 08 Oct 2018 08:46:56 -0700 (PDT)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id v85-v6sm3592107lfa.18.2018.10.08.08.46.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Oct 2018 08:46:55 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1g9XkF-00035j-7q; Mon, 08 Oct 2018 17:46:56 +0200
Date:   Mon, 8 Oct 2018 17:46:55 +0200
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
Subject: Re: [PATCH stable v2 2/2] termios, tty/tty_baudrate.c: simplify,
 auto-generate baud table
Message-ID: <20181008154655.GE3332@localhost>
References: <20181008040620.1248277-1-hpa@zytor.com>
 <20181008040620.1248277-3-hpa@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181008040620.1248277-3-hpa@zytor.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 07, 2018 at 09:06:20PM -0700, H. Peter Anvin wrote:
> From: "H. Peter Anvin (Intel)" <hpa@zytor.com>
> 
> Now when all architectures define BOTHER and IBSHIFT, we can
> unconditionally rely on these constants. Furthermore, the code can be
> significantly simplified in a number of places.
> 
> Rather than having two tables and needing to be able to keep them in
> sync at all times, have one auto-generated table. This also lets us
> avoid the fact that architectures that have CBAUDEX == 0 have BOTHER
> in a different location that those that don't.
> 
> The code for masking CBAUDEX as a fallback is never exercised on any
> architecture, because for all architectures, either the baud rate
> table is completely defined for all CBAUD values, or CBAUDEX == 0, so
> we can just remove it.
> 
> Finally, this patch avoids overrunning the baud_table[] for
> architectures with CBAUDEX == 0.

So we need a minimal fix for this only as this patch in particular
should not be backported to stable.

I'm not sure when I'll have time to review this one thoroughly, so
perhaps others can chime in meanwhile.

Johan
