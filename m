Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E930C04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 10:10:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA5E6206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 10:10:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dJ9arSXj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA5E6206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727850AbeLEKKZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 05:10:25 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37615 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727547AbeLEKKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 05:10:22 -0500
Received: by mail-lj1-f194.google.com with SMTP id e5-v6so17782959lja.4;
        Wed, 05 Dec 2018 02:10:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=r62MrpJX66i93GmARzE9Kvl65GC2p5x52kpOSU8Me8E=;
        b=dJ9arSXjGr31stBDtxr9oNF4WWeD3E+ky7Rym6BMr4Z1X4qEwlU2U+Ddyva05Mj1EW
         4xwhTsLbKCCcbA0TEjSCBIN0Hjin4yUP7mQHlvvEj5aDguuwx3FJAmW/78ykqPfdNlB1
         MXG29x7iukiORuswDfmuKHSK7xaceGqAxVchfv5vhV3lbpyGt8Uev48tmwTc0rwCc3BJ
         imhJ6SDubdFfSqaQTAcNUvsxs4y3O5NmZKmS/V+RmhD4RJzvL8lAVN42O9zVfuH0UcDE
         YShDsID4VWX24ZN7xLLlRG8BuFjoMfYe6Dmo3r9g3knGim3XEtBAoATt/AVjy2QIvpAB
         5RlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=r62MrpJX66i93GmARzE9Kvl65GC2p5x52kpOSU8Me8E=;
        b=ntZb26iwsAYhpTAKmehy2R4sf76UwSixMMEQmZwxt+Qr/6BkOTc1e5Ls7dxwZipgVt
         Beivwe0LRcbF1o7lvWmSh/08Sun8Ny7WaGLD1ZHnxesfOEPJ2vA7Qt/luiW83ZUJ+8Qs
         XCKBY2tXRc8GC0Y4C4WKE1zqlRh/I6hCW43ON9h0ZRldijkvZmvQ8jbKxiZuhsYvkJTZ
         Cw8gIH4c+7ocLZ22+4DDIeQE8NVZsoOMfGOPRdKH//9KKglTnNWF/9K6D7wWuzg5z/xm
         Skx0qYpG+y/IvE+b2sxPnvpjW5s3NsRgbJvwJFPCEPFBfsBUg735UuPInR+b6geHHMi8
         D6kA==
X-Gm-Message-State: AA+aEWah4My7rnCZqb1mxegBAbltIjhdOFGiDxjwRyHxeHj+nr3KJ0x/
        ARFn3mN/F0wQN0yRptSigf8pVQip
X-Google-Smtp-Source: AFSGD/Ugw5IViXzJzVbFj/9B2MQl9Zz7POQZyRFKTFlPRTkzsVzZzIeruiKh3CuTcYzwSpjGlpV6hA==
X-Received: by 2002:a2e:6109:: with SMTP id v9-v6mr14933730ljb.126.1544004619291;
        Wed, 05 Dec 2018 02:10:19 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id x11sm3847188lfd.81.2018.12.05.02.10.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 02:10:18 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1gUU8K-0004JQ-QR; Wed, 05 Dec 2018 11:10:20 +0100
Date:   Wed, 5 Dec 2018 11:10:20 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Johan Hovold <johan@kernel.org>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        linux-usb@vger.kernel.org, Jiri Slaby <jslaby@suse.com>,
        linux-kernel@vger.kernel.org, stable <stable@vger.kernel.org>,
        Florian Zumbiehl <florz@florz.de>
Subject: Re: [PATCH] USB: serial: console: fix reported terminal settings
Message-ID: <20181205101020.GB15689@localhost>
References: <20181204155904.GC18087@localhost>
 <20181204160036.24625-1-johan@kernel.org>
 <20181204161518.GA17941@kroah.com>
 <20181204163155.GD18087@localhost>
 <4e395eb4-739a-05df-e14d-e32f9cfefdd3@linux.intel.com>
 <20181205095049.GA15689@localhost>
 <20181205100545.GA23483@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181205100545.GA23483@kroah.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 05, 2018 at 11:05:45AM +0100, Greg Kroah-Hartman wrote:
> On Wed, Dec 05, 2018 at 10:50:49AM +0100, Johan Hovold wrote:

> > Note that the changes to tty are trivial; I'm just renaming and
> > exporting an existing helper.
> 
> Yeah, I have no objections to them.  We can take them in my usb tree.

Thanks. Can I add your ack to the patch as well?

Johan
