Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98E1AC169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:36:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D67221904
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:36:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tomli.me header.i=@tomli.me header.b="kcRSkV/p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728103AbfBCOgZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 09:36:25 -0500
Received: from tomli.me ([153.92.126.73]:45658 "EHLO tomli.me"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726905AbfBCOgZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 09:36:25 -0500
Received: from tomli.me (localhost [127.0.0.1])
        by tomli.me (OpenSMTPD) with ESMTP id 81e8da4f;
        Sun, 3 Feb 2019 14:36:21 +0000 (UTC)
X-HELO: localhost.localdomain
Authentication-Results: tomli.me; auth=pass (login) smtp.auth=tomli
Received: from Unknown (HELO localhost.localdomain) (123.117.70.80)
 by tomli.me (qpsmtpd/0.95) with ESMTPSA (DHE-RSA-CHACHA20-POLY1305 encrypted); Sun, 03 Feb 2019 14:36:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=tomli.me; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=1490979754; bh=/iBEBfWkUDwpNtrxot96T3rUpmHlMOViZpcbO8iGfkU=; b=kcRSkV/psMNJMCpbYD1YoMxI49ILEN+x6DSQV1NbbGEpP/XC1iATkQ67ZmK3YhainjaBaZBy26qrS1zzJ8BAYZKG5ux9p0Xnini8XV5w9nBf729O/+WJr8ZbiFU9mdW6NQLL/M6x6f790gTIjLJMon5NMLlqjNrjpMrRxzmZMP31Q5iQaB1jty/hlhV5uayZNToifiFA2UhJgsxekwcZ1uXhygeJQF32+rncgbRHFoIExElf7wDfNS+kiEzL7IOUC7g54JMumznOLAHyklC2o8+lmdwTuXe92XrnsotD2yVIKOYNZV2wrKSgTT8w33LeeQs72l+qG/+k1aEe6VJKJA==
Date:   Sun, 3 Feb 2019 22:35:44 +0800
From:   Tom Li <tomli@tomli.me>
To:     Chris Rankin <rankincj@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [BUG] What is "__ptrval__" in my dmesg logs? Bad "%p" expansion?
Message-ID: <20190203143544.GA24267@localhost.localdomain>
References: <CAK2bqV+YhN7L=NYOMEkOvzRSa7-p51RnsRxR_=inNt+6OcsKvw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK2bqV+YhN7L=NYOMEkOvzRSa7-p51RnsRxR_=inNt+6OcsKvw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is not a bug, rather, this is a security feature that fixes
the original behavior, which is now considered an infoleak vul-
nerability.

Currently, the address of internal data structures are protected
by Kernel Address Space Layout Randomization (KASLR), it forces
attackers to bruteforce the location they need to overwrite, thus
together with W^X mappings, increases the difficulty of exploiting
the kernel. However, showing values of raw pointers will reveal an
address of a known internal data structure, allowing an attacker to
calculate the location of critical data structure within the kernel,
therefore completely defeating the protection by ASLR. This is why
disallowing normal users to "dmesg" used to considered a way to
improve system security.

As a security measure, the value of "%p" is now hidden by default.

Happy Hacking,
Tom Li
