Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25E50C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 07:46:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9767206BB
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 07:46:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbfAGHqn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 02:46:43 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35438 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725550AbfAGHqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 02:46:42 -0500
Received: by mail-wm1-f68.google.com with SMTP id t200so6541631wmt.0
        for <linux-kernel@vger.kernel.org>; Sun, 06 Jan 2019 23:46:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2JpkdjLTUq7bQubuFYx96iZehFrzWw/Wgxlqu/gy7DA=;
        b=QqCHECMLSr35ECDJKwvyYnBd+UJL0u/CtB1sHz4uAfu1qyc3I2Mzs2U1pR1qyrixEL
         z3YfYDawJpnaJZc1sLJWuv8QOkvOl9gW7hhf0B5AGiglZAE0LxMTFDNVNvWCG9Z/DWsA
         NrAITGtjTeaU0kcrEYo/FU7xA6YxG3pUYi7hB/f0PuwAVMpvB8mv52vkhPJrF/nEQALn
         7kh6GRHKr/P/cQVAndZttpvgSeQo5Xu6adMTe2LiL2Y/eGcQMQI62td4sY2WDrzhjpyt
         WP83TYGJ+TZtYUqxVMWE73gPBjhId1nZlKJbVVwhZeymMPOIfqD52NaqajenlIkjZJkU
         A3Zg==
X-Gm-Message-State: AJcUukeQMWDvXdHKlCs2+g5x39lR7a2ZWPuXigi0JwSJwc6py9DtOEuB
        TzWWeC2xC/1zyUzWk7DE+Yk5uA==
X-Google-Smtp-Source: ALg8bN4Ls+Vug/2M+orhIAZW0jwN9W3he00mW6moJi3YTyDDeayKkM+3e1V5gMnYkNqec5YiB05mOw==
X-Received: by 2002:a1c:22c5:: with SMTP id i188mr7848282wmi.39.1546847200839;
        Sun, 06 Jan 2019 23:46:40 -0800 (PST)
Received: from localhost.localdomain ([151.15.254.62])
        by smtp.gmail.com with ESMTPSA id v8sm72098024wrq.53.2019.01.06.23.46.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 06 Jan 2019 23:46:40 -0800 (PST)
Date:   Mon, 7 Jan 2019 08:46:38 +0100
From:   Juri Lelli <juri.lelli@redhat.com>
To:     luca abeni <luca.abeni@santannapisa.it>
Cc:     syzbot <syzbot+119ba87189432ead09b4@syzkaller.appspotmail.com>,
        bp@alien8.de, bristot@redhat.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, luto@kernel.org, mingo@redhat.com,
        peterz@infradead.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, x86@kernel.org
Subject: Re: WARNING in enqueue_task_dl
Message-ID: <20190107074638.GC7213@localhost.localdomain>
References: <000000000000b5e346057af4da06@google.com>
 <0000000000001f4fee057e52b284@google.com>
 <20190102101518.1d21ba0c@sweethome>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190102101518.1d21ba0c@sweethome>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 02/01/19 10:15, luca abeni wrote:
> Hi all,
> (and, happy new year to everyone!)
> 
> this looks similar to a bug we have seen some time ago (a task
> switching from SCHED_OTHER to SCHED_DEADLINE while inheriting a
> deadline from a SCHED_DEADLINE task triggers the warning)...
> 
> Juri, I think you found a fix for such a bug; has it been committed?

Looks similar to the one I proposed this fix for:

https://lore.kernel.org/lkml/20181119153201.GB2119@localhost.localdomain/

AFAIK it hasn't been reviewed/tested yet. Could you (or someone) please
have a look?

Best,

- Juri
