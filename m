Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7C4EC43610
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 15:50:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91973213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 15:50:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TJwVUSmS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91973213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728975AbeK3C4F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 21:56:05 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44665 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728423AbeK3C4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 21:56:04 -0500
Received: by mail-pg1-f195.google.com with SMTP id t13so1095155pgr.11;
        Thu, 29 Nov 2018 07:50:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=R9ojwXtGLJ0kBNjQNivlCNXdGwCukYCYcLRKd6jStKg=;
        b=TJwVUSmSXTVL9M/QnHbZ267jM1JUHH1PZHW6+plntsRw6wppULN/RBwAhv9jRy/ydQ
         Kl9LfSStC/InThTinEQ4wfhdPhrttPt7oEevFSrVzCm9J9hqRpUoNwM9MVbomJ9bfh+Z
         ss2HSO0vYjS2c4JidXRyLYSxya1u5E18gtj9Dj+076Ind2nWFjPWWVYQpzuIGBghkSTP
         HDNrvn1aPBtbHMRC3w9K7fdXcSXplj1isRwrRjppHCBVx/dU7b2I76GFiN0pgUu7jOR/
         /P1kO2swXmogfLAhCcXWnMezlnfi/2Nz435df+8phRW1f96DI/SW+tLIw9iotpgW7jVW
         u9aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=R9ojwXtGLJ0kBNjQNivlCNXdGwCukYCYcLRKd6jStKg=;
        b=DcW0/QmvQpyhxlQal2vtfTUVxY81BZPFR/E7994YiCF5NX5rUL+liiqLaidZ5ZSiiF
         v4fBpjVtGXcsCamlp1r9q0Qhcan6OsWehM/YGHuv7lFVVKz1mLiTWjS/dDKvZfceuPoy
         +t2AwkHr3itjgrORwoRPJSgKnmwnQzw+HsgwxaEXPFLrTJCg/6xbcXUjYoQn7pvTqYaK
         RIL4Ua50p7qNzybbT3jNXttnP5yQV4wYo6v3odZkb7TcxuzMdsfZe4OmbnhSMCCdgeld
         LXP5WSH5RVu68XjtongPfspE3z7+It30xJ/CDvaR9w8pv5jFDhVPcmbhv41AuePL+GFP
         HPdQ==
X-Gm-Message-State: AA+aEWbt0gLyH+Y7uREMOYoM0sUoASOWaO4uXPLuxylzuOCHdjeBEldP
        59VMgdIDGCyVhQYsNMWO66aYITckrQ0=
X-Google-Smtp-Source: AFSGD/V0yc4l5qqENI9Vmajm0foesPT4+547/5syTblxzfJoTMLOy7dH996OeXu2nDIKhLDXlMyDNA==
X-Received: by 2002:a63:fc05:: with SMTP id j5mr1698946pgi.434.1543506616322;
        Thu, 29 Nov 2018 07:50:16 -0800 (PST)
Received: from pi ([12.219.193.5])
        by smtp.gmail.com with ESMTPSA id t5sm4180403pfb.60.2018.11.29.07.50.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 07:50:14 -0800 (PST)
X-Google-Original-Sender: <johan@kernel.org>
Received: from johan by pi with local (Exim 4.91)
        (envelope-from <johan@pi>)
        id 1gSOYp-0000lo-Ij; Thu, 29 Nov 2018 07:49:03 -0800
Date:   Thu, 29 Nov 2018 07:49:03 -0800
From:   Johan Hovold <johan@kernel.org>
To:     JackyChou <jackychou@asix.com.tw>
Cc:     johan@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        louis@asix.com.tw
Subject: Re: [PATCH 1/2] USB: serial: mos7840: Adjust port settings for read
 and write registers
Message-ID: <20181129154903.GA2161@localhost>
References: <20181129064728.11830-1-jackychou@asix.com.tw>
 <005801d487af$f9517a00$ebf46e00$@asix.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <005801d487af$f9517a00$ebf46e00$@asix.com.tw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 02:51:36PM +0800, JackyChou wrote:
> 
> From: JackyChou <jackychou@asix.com.tw>
> 
> In the read/write function, set port 2 independently in the 2-port case.
> 
> When setting the offset of port registers, the offset between port 1 and
> other ports is different, so port 1 is set independently.
> Then in the rest of ports, the port 2 between 2-ports case and 4-ports case
> is different, so port 2 in 2-ports case is set independently.
> 
> Signed-off-by: JackyChou <jackychou@asix.com.tw>
> ---

Thanks for the update. Unfortunately the patches are still white-space
damaged. You may want to take a look at:

	Documentation/process/email-clients.rst

and verify if its your mail client or server that corrupts the patches.

Either way, try sending them to yourself first and run checkpatch on the
result.

Also, remember to include a changelog when you resend (here below the
cut-off, ---, line, and increase the patch revision (e.g. this is really
v4?).

Thanks,
Johan
