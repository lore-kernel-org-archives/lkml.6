Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9038C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 14:39:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83EEF2077C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 14:39:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V3ibOBGR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83EEF2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727682AbeIETJx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 15:09:53 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:44736 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbeIETJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 15:09:53 -0400
Received: by mail-ed1-f65.google.com with SMTP id s10-v6so6257740edb.11;
        Wed, 05 Sep 2018 07:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VmhHOhFFd7KMAcq1YtPj9++7Fos2s3vyhqMpoJfIdGQ=;
        b=V3ibOBGRA4QR94pgYXUSYTMbCf6B7BXbHvv+GE64ktH7Q8ffa8ofWW/LsoNGBB5LVE
         rI2tWxchNpZiT6bpeA9LsCMqzp/e2jnT08uKuB0pdXw3qye9XOAmCPX8BkTxoJAH0dGF
         /BrQo5nWfwM/0mX1q9KkcJMObf4q7rM4TBG5BHgi4Qx1Wy0q5fuGDX/gg4uKB5wL1eAi
         n41Js1zH1NcvcyD84DZ5ITgBKIm2FEqCkmvf0XyXape2MULVWjLPczEyfHqS+TjHhjl4
         s66Ox/qwJr8y4IHUyVzAzzxzWL/VFLMeOZ/J1sCuIm5wMpAOBH6wHVGFuTuLbdVxa3/r
         9cYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=VmhHOhFFd7KMAcq1YtPj9++7Fos2s3vyhqMpoJfIdGQ=;
        b=aykHz8Xyl3wsAkOSY4MvwUShQNt6Rwva7bX5g3uWh9cgkkC+o1jjaV8mfaCaSykqV6
         HCczO5bE2fi3gqaXgXB6FXLYq6w2EbZNJ0Ux01T8v6Zb+F+cf8M5B0WrO2wxaDAIlIJP
         iIwOjwlcoNu+HLYyAE8qN+jCCvbfd8SAPYfidFBu0mF+3/POhjz2KkZT/qs4pCaFobly
         qpti5q4+c/oI2OKNiriHSekwIKxvdgenhhyIsch4I3d28KsaX3y6lQQLdDUIbUUKdMnD
         1cRbIUqMtDCwPv9sF5xddEu+6pffNQpYz2RBGmH09+xP0r4qFEhJTxu1LYcskrY3srPX
         io/g==
X-Gm-Message-State: APzg51BY13I8l2adVe1GzjYYErseMl55Mdrev8zKUBZDrCt91OJg92nb
        AqYCHtpZAUSXX9owdmQmv5U=
X-Google-Smtp-Source: ANB0VdaBK/G8P8wAmEUq8MELvr8gp0jTxyJK/uDV9dod4nw4/e5Zd+LVLPSiGa84Ms9YPcrUbTcTtg==
X-Received: by 2002:a50:adaa:: with SMTP id a39-v6mr42543416edd.194.1536158362843;
        Wed, 05 Sep 2018 07:39:22 -0700 (PDT)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id e38-v6sm1317112eda.74.2018.09.05.07.39.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Sep 2018 07:39:22 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1fxYxx-0004dd-7A; Wed, 05 Sep 2018 16:39:33 +0200
Date:   Wed, 5 Sep 2018 16:39:33 +0200
From:   Johan Hovold <johan@kernel.org>
To:     "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>
Cc:     johan@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        peter_hong@fintek.com.tw, hpeter+linux_kernel@gmail.com,
        Oliver Neukum <oneukum@suse.com>
Subject: Re: [PATCH V2 1/4] USB: serial: f81232: clear overrun flag
Message-ID: <20180905143933.GC1089@localhost>
References: <1535593634-22004-1-git-send-email-hpeter+linux_kernel@gmail.com>
 <1535593634-22004-2-git-send-email-hpeter+linux_kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1535593634-22004-2-git-send-email-hpeter+linux_kernel@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2018 at 09:47:10AM +0800, Ji-Ze Hong (Peter Hong) wrote:
> The F81232 will report data and LSR with bulk like following format:
> bulk-in data: [LSR(1Byte)+DATA(1Byte)][LSR(1Byte)+DATA(1Byte)]...
> 
> LSR will auto clear frame/parity/break error flag when reading by H/W,
> but overrrun will only cleared when reading LSR. So this patch add a
> worker to read LSR when OE.
> 
> Cc: Oliver Neukum <oneukum@suse.com>
> Signed-off-by: Ji-Ze Hong (Peter Hong) <hpeter+linux_kernel@gmail.com>
> ---
> v2:
>         1: Add flush_work(&port_priv->lsr_work) in f81232_close().
>            Thanks for notice by Oliver Neukum

Looks like you ignored Oliver's comment that you needed to take care of
any pending lsr work both and close and suspend.

Johan
