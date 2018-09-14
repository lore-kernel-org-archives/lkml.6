Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D8C2ECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 15:26:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 574162083A
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 15:26:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JvdK7IPt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 574162083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728208AbeINUli (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 16:41:38 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:44454 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726902AbeINUli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 16:41:38 -0400
Received: by mail-lf1-f68.google.com with SMTP id g24-v6so2973974lfb.11
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 08:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XDM0YUWc9KRhvTe9BAwDRkLdtQ3OcKYKYy0uYXBl4IM=;
        b=JvdK7IPt22JW3IDyAsSOxMCQd+jrRS3BRXSIbySf2s2cVrQoaK3VPZ+6QYNnh4slh+
         tGmZUHEjaMT8Q4i3YpV8/ssLrgDI8iRqKNa3UWQTXtrp37MZOUPq47FAlrEz4STI47pB
         pPZgofzX9nlpHx0JaZQMlJ38raqIyvLNg0pkLzVS6TTQG6XrU+pKZWBbA1QXT7Yy4H2x
         eHWuNzxufvh/v/uptQNBkmOztMeFH4jUHigFdSN8tnV9adzzGLVFyQojElhkhpn617Ej
         wM7pP57UDNaYwVsK2EaTbSTJ7VVKJgpwFCAd2RnP3KSekJdDRxFULRe4yjo11cE1jits
         3KMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=XDM0YUWc9KRhvTe9BAwDRkLdtQ3OcKYKYy0uYXBl4IM=;
        b=UrCGBREDlqAtxayhfOwfFGDmUtng8s1N5AfVEvO0+axQqf9yiz5ZX+H3qcxQBhCbJR
         RvKL8xBqSyfHYCpsAwHBsUknv3vhRSQZhGrVmONC24MgixFXhVbYCKj/ZovPyumzJsaP
         UF5gIbJCJv8Ay6eYQepm3SsUH9ZjB2NvgWR3fEzeiFLPIIdSZmlQHElaVYB85f6/gEX4
         sKp8zBmSyApkQYelra0b+R7IrBWESXhuIC85oh8TrusO+MMFUZx+wb3AAoVDlIXbcCii
         ix8FAHEBSRovINLIVDmdgg/p4VZ8Vban2CZPp/Ylk0zNt2pwp5PRUATiFYwLGuLz/Lcs
         QBCw==
X-Gm-Message-State: APzg51DUWxgTCnzHQu6KwR/jJKoby7SjlwFGeVDySycWnoNzSkGhTOc7
        TahGiaB/VMg8nKahEVmRMjI=
X-Google-Smtp-Source: ANB0VdZBr0a8eiyV9e5lu8NI7rTM2r7Rof57iKzl432ZNOrH0DunpUVd/Nb90mcARnrLXJeKwMgNzg==
X-Received: by 2002:a19:115b:: with SMTP id g88-v6mr8780286lfi.57.1536938795993;
        Fri, 14 Sep 2018 08:26:35 -0700 (PDT)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id n99-v6sm544284lfi.96.2018.09.14.08.26.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Sep 2018 08:26:35 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1g0pzQ-00065R-TS; Fri, 14 Sep 2018 17:26:37 +0200
Date:   Fri, 14 Sep 2018 17:26:36 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     Johan Hovold <johan@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 17/50] usb-serial: begin switching to ->[sg]et_serial()
Message-ID: <20180914152636.GX1362@localhost>
References: <20180913023119.GQ19965@ZenIV.linux.org.uk>
 <20180913024049.24567-1-viro@ZenIV.linux.org.uk>
 <20180913024049.24567-17-viro@ZenIV.linux.org.uk>
 <20180914133930.GF1362@localhost>
 <20180914152352.GB19965@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180914152352.GB19965@ZenIV.linux.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 14, 2018 at 04:23:52PM +0100, Al Viro wrote:
> On Fri, Sep 14, 2018 at 03:39:30PM +0200, Johan Hovold wrote:
> > > +	if (port->serial->type->get_serial)
> > > +		return port->serial->type->get_serial(tty, ss);
> > > +	return -ENOIOCTLCMD;
> > > +}
> > > +
> > > +static int serial_set_serial(struct tty_struct *tty, struct serial_struct *ss)
> > > +{
> > > +	struct usb_serial_port *port = tty->driver_data;
> > 
> > And here.
> > 
> > > +	if (port->serial->type->set_serial)
> > > +		return port->serial->type->get_serial(tty, ss);
> 
> ... and another cut'n'paste braino - it's set_serial, of course.

Bah, I thought I'd checked them all. :)

Thanks,
Johan
