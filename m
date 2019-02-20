Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DACBEC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 04:11:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A58112183F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 04:11:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="fuaOegiy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730224AbfBTELu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 23:11:50 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:43975 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727424AbfBTELt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 23:11:49 -0500
Received: by mail-lf1-f67.google.com with SMTP id j1so16499664lfb.10
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 20:11:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=db6rNe8FXqzsar+Of4OlqOzZTp/jEx1xhLf6TcXLfvQ=;
        b=fuaOegiyQG/ppLU7U/HkS3Fqp5fmTeS/dQnPC6emwcCsg8QeE2i6xA+9D2Z0Ja81uI
         PmIxUNBF/qKQ9kUP28Fs3UWerXDtY93/1MH023gPd3R1MCYnFYziNw4O2hWxe8hC7ZkT
         hZ0GaVgDa8TWJTwZVCq4w9YA2kjPRunZJm2jE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=db6rNe8FXqzsar+Of4OlqOzZTp/jEx1xhLf6TcXLfvQ=;
        b=UjMQPgh4gaxO2X2yNay91hkzSzmmCrPE9LUU6UY8eNlXjyIKze3EUIan9Xqn+U4YuP
         gHxmE+rSoQFNTA4riBM/xFNfopeLyualjqNBEm0PX9mVw32NSUJvQ1X27AU4gtJ0Phzs
         uu+6D9/ybmHbmIBzbqsx3jxHxDYYJ0/kbQpbKRE/SVIwPVwD7eMX8guGsfWdv76J3VBW
         8hU/BKN+OV+LWCBHWBCK1oL9LdWL92OBDOuxu1/ESDi7821PNNFkstpskG+dp41rMgjO
         gCL99W+SG3XAy7QJ0+ESb5LSiGZTlbofNXEnahtkXu/KqRTdgznhnpUDDWhQA7X4JOe9
         XgOw==
X-Gm-Message-State: AHQUAuY71KJyS4wyf75+iy3+zHkvICRi+TsJK5SL5xq6nTQJ6sss2sPG
        HgODOcyZLKy/Wea31ufKJUyNjaUbP2xPwdBM6ovfwAaY
X-Google-Smtp-Source: AHgI3IZgLGOicKs820B9PCtpmESxrwPnr+mJbTFZsy9LKzbID33x7DWDeZ35zwucBMjh1mzCivqwtxYr4iyMqRyfKww=
X-Received: by 2002:a19:d250:: with SMTP id j77mr18855692lfg.21.1550635907264;
 Tue, 19 Feb 2019 20:11:47 -0800 (PST)
MIME-Version: 1.0
References: <20190220040827.136184-1-joel@joelfernandes.org>
In-Reply-To: <20190220040827.136184-1-joel@joelfernandes.org>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Tue, 19 Feb 2019 20:11:36 -0800
Message-ID: <CAEXW_YRasK=os37QxCwoAY+DXKVD3bBTvR4qH3jaSJB3rP5a-Q@mail.gmail.com>
Subject: Re: [RFC 0/5] RCU fixes for rcu_assign_pointer usage
To:     LKML <linux-kernel@vger.kernel.org>, rcu@vger.kernel.org
Cc:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 19, 2019 at 8:08 PM Joel Fernandes (Google)
<joel@joelfernandes.org> wrote:
>
> These patches fix various RCU API usage issues found due to sparse errors as a
> result of the recent check to add rcu_check_sparse() to rcu_assign_pointer().
>
> This is very early RFC stage, and is only build tested. I am also only sending
> to the RCU group for initial review before sending to LKML. Thanks for any feedback!
>
> There are still more usages that cause errors such as rbtree which I am
> looking into.
>

Looks like it got sent to LKML anyway, ;-) That's Ok since it is
prefixed as RFC.
