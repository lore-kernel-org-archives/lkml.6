Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 316B1C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 20:12:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CC7A20842
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 20:12:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727433AbfBYUMf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 15:12:35 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52287 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726888AbfBYUMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 15:12:35 -0500
Received: by mail-wm1-f68.google.com with SMTP id m1so226253wml.2;
        Mon, 25 Feb 2019 12:12:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FBP+QY4s5FKTBC+L09HRVNJKEu4rGsu0W/QQVKCzLXI=;
        b=Yv0eRGhJkyScRt0DswwdJ2DHksoM+dBeFmqyUEUVJbT2aho/9L+8fF+LYpcqJinBZ4
         fFyFU1hHc8xqccxxpsBepABjRHpRJC5tw+/rOdtBgkuWj14tYyvJyjCNLr29lIaoB8FP
         BfeKaHfyTfQDaBEY904428O+dJdZOn9vo8PEMMt2wF7CBfMeDXja1PHmkv4/dFEP++H2
         zNJh5djhEoW2ScUG8mWRWq/TY0lfnKSSIdIwGmY1KuZtgiySCOWTgimbeUFqGQXIJ03K
         Xvu2l9xqfu8HMwvqtasmu/ZauSqs+HqnUYElRqL8KaguyPavuJNcvTDee1JodwfjayM6
         MpkQ==
X-Gm-Message-State: AHQUAub1abPFW2Q4rNe4JAAUEirs0SsiwBDzL7tCqIzNOAR4okNd8vGf
        QfBLeCRjB1uFn2vd6+/2IDM=
X-Google-Smtp-Source: AHgI3IZ2/OGIvQ80WgwhO6lOeuaf2kAesioDCFb+Xpw2QlveYESpRX1+WmSu2+4a3rpfy85QR5dI4g==
X-Received: by 2002:a1c:9c0a:: with SMTP id f10mr322279wme.73.1551125553266;
        Mon, 25 Feb 2019 12:12:33 -0800 (PST)
Received: from timur-laptop.fritz.box (dslb-146-060-168-212.146.060.pools.vodafone-ip.de. [146.60.168.212])
        by smtp.gmail.com with ESMTPSA id w10sm13607825wru.5.2019.02.25.12.12.32
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 25 Feb 2019 12:12:32 -0800 (PST)
Date:   Mon, 25 Feb 2019 21:12:30 +0100
From:   Timur Celik <mail@timurcelik.de>
To:     David Miller <davem@davemloft.net>
Cc:     eric.dumazet@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tun: fix blocking read
Message-ID: <20190225201230.GA29884@timur-laptop.fritz.box>
References: <20190223115313.15064-1-mail@timurcelik.de>
 <20190224.221236.905722532971991928.davem@davemloft.net>
 <b727b3bb-ec46-12bf-dd38-0363c9ca5854@gmail.com>
 <20190225.102548.247362521843809607.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190225.102548.247362521843809607.davem@davemloft.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 25, 2019 at 10:25:48AM -0800, David Miller wrote:
> From: Eric Dumazet <eric.dumazet@gmail.com>
> Date: Mon, 25 Feb 2019 07:53:08 -0800
> 
>> 
>> 
>> On 02/24/2019 10:12 PM, David Miller wrote:
>>> From: Timur Celik <mail@timurcelik.de>
>>> Date: Sat, 23 Feb 2019 12:53:13 +0100
>>> 
>>>> This patch moves setting of the current state into the loop. Otherwise
>>>> the task may end up in a busy wait loop if none of the break conditions
>>>> are met.
>>>>
>>>> Signed-off-by: Timur Celik <mail@timurcelik.de>
>>> 
>>> Applied and queued up for -stable, thanks.
>>> 
>> 
>> First part of the patch was matching the changelog, however
>> the second change was not really needed, or should have used 
>> 
>> __set_current_state(TASK_RUNNING);
> 
> Timur, please followup.

Thanks for taking a look at this. Eric is right of course.
