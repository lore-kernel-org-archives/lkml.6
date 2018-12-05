Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 116D5C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 10:33:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4B0D2064D
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 10:33:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W2l5iwGn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4B0D2064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727390AbeLEKda (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 05:33:30 -0500
Received: from mail-lj1-f178.google.com ([209.85.208.178]:42815 "EHLO
        mail-lj1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726874AbeLEKda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 05:33:30 -0500
Received: by mail-lj1-f178.google.com with SMTP id l15-v6so17822617lja.9;
        Wed, 05 Dec 2018 02:33:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=R7f+GfVmfgCTzIg4wkP/dSZOx1qA7GlRykMQh4neAVo=;
        b=W2l5iwGn02cBIzP3eAeqRsx4lzxJ7gdRnfSvVEj7uWeXYCasd6vsOiPy2LLseRFVNK
         7E/LKy3yE649UVpUquRw4NBBvUmUMy59oLuzLBK5niv4wMaPhzS7aeYL1AcA7+11Cg5i
         0jGUEdkaJLKjVMbbhXnxhp0zHlwaDoSUEe8bzvJa9Bv/10vjCNijryF6uk2fqQ3OcAW4
         CA+YeA7+Tk3x+IUQ5J8p9IfxoQzkH7dTjbwpYFg5sVm5xHcy1ghDgLtwRGcBWegcFUOj
         PHpuYkTpikhzIo0D5ASCZQjgD+BiQl+pnbDUx7Wp1KlSvb0LgWAOLdT62M9SROhqX35D
         r6sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=R7f+GfVmfgCTzIg4wkP/dSZOx1qA7GlRykMQh4neAVo=;
        b=JJj2TVbg+vWl63flvMS6XltWZSLMac0r32ep5s3scAH49CspzxhJZz7QwofPzntmDw
         zJNpQZy1OqaR6RRRVT9mOd4O6aRVN0TzTge4ZRKO8Iaa90YqcOpbMSKvOTxiY8zLyARE
         zpOceC+7NykORFJXgxesguE9ANJ83BfNegvoOedeiJLuSkUys+iXw6SYPkRiHNk9f+BU
         BA8EdLwYtRP16U3aUfw/2NuVCEuyDswxwwCq3viYXPX3YdI18psZ3W/KDVnktWymfehw
         3mdpBhEl9z7f0t3gJ6ud8pNGhlYCjEh8H16EBZaPYKvLw11lUew32tUDHMJc49pQJKj2
         EP8w==
X-Gm-Message-State: AA+aEWa/jt5RMsX0gQVFVkVnLN6WomAOsg+vXpCsAgVoH4+opg5UKkhC
        z3exB5GOVMH+tCRSnPUDyZQ=
X-Google-Smtp-Source: AFSGD/VFonn0Lgx2GVWRapB8ASVndRke04H5q/ZRlEni2prKMlf/sKVWGnpXgkIkIoVp2DcTIQG1SA==
X-Received: by 2002:a2e:9bc3:: with SMTP id w3-v6mr11966827ljj.70.1544006007902;
        Wed, 05 Dec 2018 02:33:27 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id y12-v6sm3693855ljy.76.2018.12.05.02.33.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 02:33:27 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1gUUUj-00080N-K2; Wed, 05 Dec 2018 11:33:29 +0100
Date:   Wed, 5 Dec 2018 11:33:29 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Johan Hovold <johan@kernel.org>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        linux-usb@vger.kernel.org, Jiri Slaby <jslaby@suse.com>,
        linux-kernel@vger.kernel.org, stable <stable@vger.kernel.org>,
        Florian Zumbiehl <florz@florz.de>
Subject: Re: [PATCH] USB: serial: console: fix reported terminal settings
Message-ID: <20181205103329.GC15689@localhost>
References: <20181204155904.GC18087@localhost>
 <20181204160036.24625-1-johan@kernel.org>
 <20181204161518.GA17941@kroah.com>
 <20181204163155.GD18087@localhost>
 <4e395eb4-739a-05df-e14d-e32f9cfefdd3@linux.intel.com>
 <20181205095049.GA15689@localhost>
 <20181205100545.GA23483@kroah.com>
 <20181205101020.GB15689@localhost>
 <20181205101850.GA736@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181205101850.GA736@kroah.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 05, 2018 at 11:18:50AM +0100, Greg Kroah-Hartman wrote:
> On Wed, Dec 05, 2018 at 11:10:20AM +0100, Johan Hovold wrote:
> > On Wed, Dec 05, 2018 at 11:05:45AM +0100, Greg Kroah-Hartman wrote:
> > > On Wed, Dec 05, 2018 at 10:50:49AM +0100, Johan Hovold wrote:
> > 
> > > > Note that the changes to tty are trivial; I'm just renaming and
> > > > exporting an existing helper.
> > > 
> > > Yeah, I have no objections to them.  We can take them in my usb tree.
> > 
> > Thanks. Can I add your ack to the patch as well?
> 
> Please do:
> 
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Thanks, now applied.

Johan
