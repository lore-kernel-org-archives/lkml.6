Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFE97C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 07:56:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83B832083C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 07:56:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h/ZJkqUO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83B832083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728830AbeJAOcv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 10:32:51 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51358 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728593AbeJAOcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 10:32:50 -0400
Received: by mail-wm1-f67.google.com with SMTP id y25-v6so7666269wmi.1;
        Mon, 01 Oct 2018 00:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=/RtgW5/+TvLiJIyzS1OHcJ7mhMnCnbH2trYHFNY/r84=;
        b=h/ZJkqUORwnzx0CtQE3MLAy7w9YcGih3C08gE/7+rys5ISKpp1R6y6G1XW6uCOnymh
         pAS2srs3gIxdt9RHWsTxj3SpeBNotOqV/pQEhPMgxCJnDFl4HX4hTLICCrMMsNkU6W3w
         m+bq9YH3w3d5GgW89N5gyFthGOhA1KUec6xiGKK3ZLDKW6cHJ3B++lmQGZQUMggbdaBE
         p5RzhDVbwdiy22O4kjFL5OmfOWvWV7GJ48PxEg3Mq0XUPhT4H6ak+u2doSynffcMzjay
         /5J89C/9E+3m0zRgTF26Nel2Mz29Rq/Q+X+RH0iEk1sVe+TOUacw/UA7WLe3vNxqLIYA
         7KTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=/RtgW5/+TvLiJIyzS1OHcJ7mhMnCnbH2trYHFNY/r84=;
        b=jA+mqij2kLscXvnjmuvo4z5CwnOPK4yD6FrFzNqV/+kIrKCB9Yx2fym7Mes2Wu7Zxw
         ir7I4fzTAHagglkSaB1rlATgtk3KXZ5XMzInRrz8LOA45Ng1Rm0Bsdxk9frzz1dm7PJq
         24pD9gYHLFQ8k8mGj/UzcY0OAGchNhGqV6Gs7cUFQ6jcmwtAJSirb3k4F+Zjx7D1jcIj
         VrFJ5dQRgnPjedWpMVjD+BuM66itFKaUNMOh6FbQeWnGLVVfvpstpH/LsTtCBzzi1DVD
         lReWwlvXvLGthAO9ZG5qVtO7dMFJzLVH8TSkmm8X0P3bRqzZtyZpyU6B0oXjjgfpWs5x
         msyQ==
X-Gm-Message-State: ABuFfog/ybbyWCLtbUCooviyE3LbC4gGXiHnk/1qxVT9YZ46wx/fzHVM
        N6LIxBb+y3w2voBi1/zVYpw=
X-Google-Smtp-Source: ACcGV61wDZFHb6QwFpfVWBbnlqM6b22sFecUKAM0T2FknqyWlFLXn/DxcJg+5ljn4laAQn3ntUMsgQ==
X-Received: by 2002:a1c:1d6:: with SMTP id 205-v6mr8257262wmb.151.1538380581790;
        Mon, 01 Oct 2018 00:56:21 -0700 (PDT)
Received: from rric.localdomain (x55b4fbbb.dyn.telefonica.de. [85.180.251.187])
        by smtp.gmail.com with ESMTPSA id m2-v6sm7473453wrj.80.2018.10.01.00.56.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 00:56:21 -0700 (PDT)
Date:   Mon, 1 Oct 2018 09:56:07 +0200
From:   Robert Richter <rric@kernel.org>
To:     Leonardo =?iso-8859-1?Q?Br=E1s?= <leobras.c@gmail.com>
Cc:     lkcamp@lists.libreplanetbr.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Finn Thain <fthain@telegraphics.com.au>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        oprofile-list@lists.sf.net, linux-parisc@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH v3 0/7]  Remove errors building drivers/DRIVERNAME
Message-ID: <20181001075607.GA3776@rric.localdomain>
References: <20180928020816.11251-1-leobras.c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180928020816.11251-1-leobras.c@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.09.18 23:08:09, Leonardo Brás wrote:
> This Patchset changes some driver's Makefile to allow them building
> using the command 'make drivers/DRIVERNAME', if compatible.
> 
> The changed drivers would return error if the above command was run
> on them, after an x86 allyesconfig.

I don't see what you are trying to achieve here. Why shouldn't the
command fail if it is not the intended way to call it? There are a
couple of use cases where drivers/ is used to share common code over
different archs and it is not always the intention to build them in
drivers/ directly.

> 
> The main reason of this patchset is to allow building lists of
> drivers looking for warnings and errors to be fixed.

If a list is the intention here, aren't there other ways to create it
other than using drivers/*?

-Robert

> 
> I see this change as a new feature, not a bugfix. I understand
> the default bahavior may be building with a simple 'make', but I
> believe adding this new possibility will not be harmful.
> 
> My main objective is to allow developers with low processing power
> to do changes in the kernel and look bugs using free services like
> GiltabCI, before submitting to community.
> 
> If there is any interest helping/using this, I have a prototype in:
> https://gitlab.com/LeoBras/linux-next
