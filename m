Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB915ECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 17:45:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F555214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 17:45:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="bnpYVwNA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F555214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=arista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732519AbeISXYv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 19:24:51 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:41572 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728197AbeISXYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 19:24:51 -0400
Received: by mail-ed1-f67.google.com with SMTP id f38-v6so5609299edd.8
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 10:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i116NP0kmiRCyPVEbtUgi4ogmRLi/k9IFurz0RMHBYs=;
        b=bnpYVwNAJLoyvUyq+OSp+WQL8EP7RUFNvtzNxRhI8frEWgRKyEmOjjfAMRBUkTjYXS
         /9hZ5khwoOwwBRXQnKhsUbc/np8ntae2E/U7CcXP/DFU3Bi3MGXJ372Hsz/p6JEz9vse
         poBpDMpc/Pf7G1Q8HQ713MRmmzqD63Dj8+HQNHiA13dY6/OR58xRb4shHNjqO+7/JqoO
         zxXJ8r98pgtygiMsGcfb5U0GJescvIcsvl7yQBd2hmkSwo4sTSg6jsHRLWcruN1ieI4Q
         iMSl9z5yBXmXpSo0JYFJ9zDhhhhVbhOuLXxmlh715RbeYEfqF32vNKBAYvbfDlKgPrQZ
         9gCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i116NP0kmiRCyPVEbtUgi4ogmRLi/k9IFurz0RMHBYs=;
        b=o1ZJhZgsB+3nPU3wIPwA9ElXvyYQxvuB0etHQAKSkFTLD+uZ0y5pf14HJ+I1aWXDWF
         YV4qBW1UTtrNhMkDsVMx3GJ/eYZ5kK2zSbgEGe9uzJbn3HouXPE5CcgJv4akxaTqRSgN
         TguofrjoDgMuBnEyEeOHXt130XTcmAHmriVIQJOLCoYHAl8IUi2LErLEf8AVI/RZ0aV0
         cILyChVC8nIQjDSvuf22J76LMxtFVapurbjIntsbtPbZhWuOGHCBUykSomd+8hKip2O6
         idjITj8OiZ4/3I5fqiH3QnA/IOwMipAogBeusX7EGGMpAOD8Yy2T1Uh81Nv9JRb/7ejC
         aWDg==
X-Gm-Message-State: APzg51CZuCxS58ldoMkipl31WU6rDv8XNZMcLWlOvPr8JHtFwY8dBni/
        ntK+gKHjqh+8KkC9c87piZdOgg==
X-Google-Smtp-Source: ANB0VdY3Nzg7xtjhM+psck18UfkLO2oDHcUhgHmLWPpEBQzfYhVicaVjSr+qUWyKOHhx4twM5CowCg==
X-Received: by 2002:a50:b687:: with SMTP id d7-v6mr60370590ede.283.1537379150652;
        Wed, 19 Sep 2018 10:45:50 -0700 (PDT)
Received: from dhcp.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id b20-v6sm2028255edc.30.2018.09.19.10.45.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Sep 2018 10:45:50 -0700 (PDT)
Message-ID: <1537379148.21380.16.camel@arista.com>
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
Date:   Wed, 19 Sep 2018 18:45:48 +0100
In-Reply-To: <alpine.LRH.2.02.1809191330590.19146@file01.intranet.prod.int.rdu2.redhat.com>
References: <20180917235258.5719-1-dima@arista.com>
         <alpine.LRH.2.02.1809191256060.9689@file01.intranet.prod.int.rdu2.redhat.com>
         <alpine.LRH.2.02.1809191330590.19146@file01.intranet.prod.int.rdu2.redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.24.6 (3.24.6-1.fc26) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-09-19 at 13:35 -0400, Mikulas Patocka wrote:
> 
> On Wed, 19 Sep 2018, Mikulas Patocka wrote:
> 
> > 
> > 
> > On Tue, 18 Sep 2018, Dmitry Safonov wrote:
> > 
> > > Hi all,
> > > 
> > > Three fixes that worth to have in the @stable, as they were hit
> by
> > > different people, including Arista on v4.9 stable.
> > > 
> > > And for linux-next - adding lockdep asserts for line discipline
> changing
> > > code, verifying that write ldisc sem will be held forthwith.
> > > 
> > > The last patch is an optional and probably, timeout can be
> dropped for
> > > read_lock(). I'll do it if everyone agrees.
> > > (Or as per discussion with Peter in v3, just convert ldisc to
> > > a regular rwsem).
> > > 
> > > Thanks,
> > > Dima
> > 
> > I confirm that this patch series fixes the crash for me.
> > 
> > Tested-by: Mikulas Patocka <mpatocka@redhat.com>
> 
> I was too quick to acknowledge this patchset. It doesn't work.
> 
> This patchset fixes the crash, but it introduces another bug - when I
> type 
> 'reboot' on the console, it prints 'INIT: Switching to runlevel: 6'
> and 
> then it gets stuck for 80 seconds before proceeding with the reboot.
> When 
> I revert this patchset 'reboot' reboots the machine without any
> delay. 
> This bug was reproduced on Debian 5 userspace on pa-risc.

Thanks much for the testing, Mikulas.
Could you try to bisect which of the patches causes it?
The most important are 1,2,3 - probably, one of them caused it..
I'll stare a bit into the code.

-- 
Thanks,
             Dmitry
