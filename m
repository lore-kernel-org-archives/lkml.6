Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31C10C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 10:30:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2D8D20883
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 10:30:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jdRh3Yi1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2D8D20883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728073AbeIJPXn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 11:23:43 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40692 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727614AbeIJPXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 11:23:42 -0400
Received: by mail-lj1-f194.google.com with SMTP id j19-v6so17422772ljc.7;
        Mon, 10 Sep 2018 03:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9R6VeQ/UilrNnhvU86LyZibygdbqWTKLCmddq85L+7c=;
        b=jdRh3Yi1dVc1j9UV9ZwrB8gU/eMHJ/p7cFNgX7W2b2Ox8TulFZia0O4QY7guQiTSRy
         zr8dprGmh/gyjHzUzSdRehdTVVFU6xAuwUxo5UE9AOeo0Dg3K/xjwaSfuXbcG3rorQ4H
         fAQLDMd0xZzwIS5JtdVBIaNOvxgMz1HAwU2cc9DbWqMgWIttExmsE6T4ndpT+EkG9BYe
         tkMxv0Bl3TiFoJdtlcb/QGEnzx9QiCyguKMzrUHsSsNTxQb/Vbk7pvv8BQlsAPeUshDS
         r36Cw074YXv6jlpXjQ19KTe6Lx9wDhpWrHopppShdFtBZKHI6rqr9iy1f8oeoTwlCawl
         dqkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=9R6VeQ/UilrNnhvU86LyZibygdbqWTKLCmddq85L+7c=;
        b=qUTX5eEgD7q7xkNF2aFukSMP44M8GWvATlEvU++gwh6I2D8jb7gqlV3h/Z94Ncld52
         ulAOCo6SUrI8sHf35lVKFyEs8r9x68DqydYtaTXvLtz8zrcBEz0WwefVpJ2Q0RSj1v+n
         tJz4FWV8rS8Ou00Bk+oS6GtcUnYkqURMO+Oj0tylVjiawEhfMNQ8EYU4sME0WU4pBBFi
         1BXdXU40/2Rx+vCFnICzN4OeaXirurPTqKwWY64Na+LPTpBdzDQy9LJKpJJ1rnyvaxC5
         fnYUbXyTHQ675mwG2YE3nFfCmXnNEEo3GTsZA/8yK9vP88Z+J2DigOD5fXqakVW/u1nW
         Zi7Q==
X-Gm-Message-State: APzg51CJJKB88x5owNhBFF/8Loa3FSRw6TykzLsIYRsJbADeEd0QSv6E
        lcUGsST/eKtbj/5L2acg/jdkZSwZ
X-Google-Smtp-Source: ANB0VdbwnXOrVOFgWC6StFudMobuGV/n9eAJciaciKM6UyfsTSarVYwP3Vt+rgC45p245vtWO2MT1g==
X-Received: by 2002:a2e:44c6:: with SMTP id b67-v6mr11855660ljf.102.1536575417623;
        Mon, 10 Sep 2018 03:30:17 -0700 (PDT)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id m12-v6sm2721506ljh.24.2018.09.10.03.30.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Sep 2018 03:30:16 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1fzJSY-0005wt-V4; Mon, 10 Sep 2018 12:30:23 +0200
Date:   Mon, 10 Sep 2018 12:30:22 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Kristian Evensen <kristian.evensen@gmail.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] option: Improve Quectel EP06 detection
Message-ID: <20180910103022.GR1089@localhost>
References: <20180908125754.1947-1-kristian.evensen@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180908125754.1947-1-kristian.evensen@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 08, 2018 at 02:57:54PM +0200, Kristian Evensen wrote:
> The Quectel EP06 (and EM06/EG06) LTE modem supports updating the USB
> configuration, without the VID/PID or configuration number changing.
> When the configuration is updated and interfaces are added/removed, the
> interface numbers are updated. This causes our current code for matching
> EP06 not to work as intended, as the assumption about reserved
> interfaces no longer holds. If for example the diagnostic (first)
> interface is removed, option will (try to) bind to the QMI interface.
> 
> This patch improves EP06 detection by replacing the current match with
> two matches, and those matches check class, subclass and protocol as
> well as VID and PID. The diag interface exports class, subclass and
> protocol as 0xff. For the other serial interfaces, class is 0xff and
> subclass and protocol are both 0x0.
> 
> The modem can export the following devices and always in this order:
> diag, nmea, at, ppp. qmi and adb. This means that diag can only ever be
> interface 0, and interface numbers 1-5 should be marked as reserved. The
> three other serial devices can have interface numbers 0-3, but I have
> not marked any interfaces as reserved. The reason is that the serial
> devices are the only interfaces exported by the device where subclass
> and protocol is 0x0.
> 
> QMI exports the same class, subclass and protocol values as the diag
> interface. However, the two interfaces have different number of
> endpoints, QMI has three and diag two. I have added a check for number
> of interfaces if VID/PID matches the EP06, and we ignore the device if
> number of interfaces equals three (and subclass is set).
> 
> Signed-off-by: Kristian Evensen <kristian.evensen@gmail.com>

What a mess.

Please provide the output of usb-devices (or lsusb -v) for both
"configurations". How do you update the configuration by the way?

Thanks,
Johan
