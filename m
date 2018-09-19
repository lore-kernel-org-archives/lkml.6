Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 567C2C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 20:21:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5BB921524
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 20:21:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="S8ZWMske"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5BB921524
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=arista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732422AbeITCB3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 22:01:29 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:36902 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732211AbeITCB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 22:01:29 -0400
Received: by mail-ed1-f65.google.com with SMTP id a20-v6so5981460edd.4
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 13:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S3RM4PCkDBbIRlWoN/Z43uGICSNCsaxORDR7oRanAZc=;
        b=S8ZWMskeYFGjf4S/d888l7Kdgdgj8nxyOBqzJlz75D8f9KXzvATs6nqwuCH4I0oJ5V
         ck6S40Rt47SuvTWxMNefbHsQB+BX2ISItz3lD+jYaFd6fIshZBucHEEtTZ2zMS6w+DGY
         iqyfK3hu14SzzhWIjI+QGtSqYhGsIDKJuMyDs1ZKZAMYYyvwloHy77x92gHgi2+Lr1Td
         TmkUUQQ8dLjqV/oIykS8H9+zRV0WnXHTPdjREq1VGhj5Rw0AxdDig+hgGEHOCNAGDyAG
         S/uiJj48owrubW/GhtzB/fIiq/G2ao9gXxGRzPISsPFIyuVhVAABZo02x+kGZcabz0uM
         DRFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S3RM4PCkDBbIRlWoN/Z43uGICSNCsaxORDR7oRanAZc=;
        b=RyB66nXVhgxB0KHpUwM/B+rhOHrC7MkPXIu6F1ZZIWdqG+d7ZIYq9xKO8hLzMX6mJk
         2Fn9wcfDKu3fbtyLPvx05H/RbkacNllnGv903NMAaptIexKIoVp7/Ve4T7fasNNCK2wA
         FZogbeNJq2+pHYMklSLKDqhEh9XlNgdHk5dcH+FIgwdMs+PJE3+h5RYi93ejUXdfFGc/
         fbsZSoRN9yxmGjWzu0utkRj5f5pRCS/uLHkza1DB9FuAeudcbI5JpAXdRlfyGPSiwuRv
         xffVQ8z8zWWgflweR70lbirB25Cp6Y0omjZXGTvnGFQ2w/r+19xnzS5Kiln51nYJ6uOY
         Nxrg==
X-Gm-Message-State: APzg51DwNZeljLPdOkj01oW+NL8lMloHv06QmxhNwgKWifJKWF/8s3FL
        rxk41WsgayugHpsV+HtaDyVqpA==
X-Google-Smtp-Source: ANB0Vda2BG0enAUH3zuPtx9MxOYKM1MI1WzvYHFEM8kLhehLSxhGT680WRO2WDbAlHJto3rLnr2xHA==
X-Received: by 2002:a50:ad5a:: with SMTP id z26-v6mr62449991edc.142.1537388514570;
        Wed, 19 Sep 2018 13:21:54 -0700 (PDT)
Received: from dhcp.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id h8-v6sm1742077edi.68.2018.09.19.13.21.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Sep 2018 13:21:53 -0700 (PDT)
Message-ID: <1537388512.21380.44.camel@arista.com>
Subject: Re: [PATCHv5 0/7] tty: Hold write ldisc sem in tty_reopen()
From:   Dmitry Safonov <dima@arista.com>
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Daniel Axtens <dja@axtens.net>,
        Dmitry Vyukov <dvyukov@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Neuling <mikey@neuling.org>,
        Nathan March <nathan@gt.net>,
        Pasi =?ISO-8859-1?Q?K=E4rkk=E4inen?= <pasik@iki.fi>,
        Peter Hurley <peter@hurleysoftware.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rong, Chen" <rong.a.chen@intel.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Tan Xiaojun <tanxiaojun@huawei.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        stable@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Jiri Slaby <jslaby@suse.cz>,
        syzbot+3aa9784721dfb90e984d@syzkaller.appspotmail.com
Date:   Wed, 19 Sep 2018 21:21:52 +0100
In-Reply-To: <alpine.LRH.2.02.1809191602230.16174@file01.intranet.prod.int.rdu2.redhat.com>
References: <20180917235258.5719-1-dima@arista.com>
          <alpine.LRH.2.02.1809191256060.9689@file01.intranet.prod.int.rdu2.redhat.com>
          <alpine.LRH.2.02.1809191330590.19146@file01.intranet.prod.int.rdu2.redhat.com>
         <1537379148.21380.16.camel@arista.com>
         <alpine.LRH.2.02.1809191602230.16174@file01.intranet.prod.int.rdu2.redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.24.6 (3.24.6-1.fc26) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-09-19 at 16:03 -0400, Mikulas Patocka wrote:
> 
> On Wed, 19 Sep 2018, Dmitry Safonov wrote:
> > Thanks much for the testing, Mikulas.
> > Could you try to bisect which of the patches causes it?
> > The most important are 1,2,3 - probably, one of them caused it..
> > I'll stare a bit into the code.
> 
> The patch 3 causes it.
> 
> The hangs during reboot take either 80 seconds, 3 minutes or 3:25.

Thanks much for that again.
Any chance you have sysrq enabled and could print: locks held in system
and kernel backtraces for applications?

I suppose, userspace hangs in n_tty_receive_buf_common(), which is
better of cause than null-ptr dereference, but I believe we can improve
it by stopping a reader earlier if there is any writer pending.

-- 
Thanks,
             Dmitry
