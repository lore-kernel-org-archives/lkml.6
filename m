Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA15FECE562
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 07:18:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EE53214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 07:18:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EE53214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730959AbeISMzZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 08:55:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:37706 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725973AbeISMzY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 08:55:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AF21CAE41;
        Wed, 19 Sep 2018 07:18:48 +0000 (UTC)
Received: by unicorn.suse.cz (Postfix, from userid 1000)
        id 1BF6CA0FD9; Wed, 19 Sep 2018 09:18:47 +0200 (CEST)
Date:   Wed, 19 Sep 2018 09:18:47 +0200
From:   Michal Kubecek <mkubecek@suse.cz>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        David Miller <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>,
        netfilter-devel@vger.kernel.org, Fabian Vogt <fvogt@suse.com>
Subject: Re: bpfilter breaks IPT_SO_GET_INFO
Message-ID: <20180919071847.GE3876@unicorn.suse.cz>
References: <CACT4Y+YS55tk5xoPmscBXcgSbLrgWFSLAz1MUEjby0XT8eanmQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+YS55tk5xoPmscBXcgSbLrgWFSLAz1MUEjby0XT8eanmQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 17, 2018 at 03:36:21PM +0200, Dmitry Vyukov wrote:
> Hi,
> 
> I am having some problem with upstream kernel and bpfilter. The
> manifestation is that IPT_SO_GET_INFO on an ipv4 socket works, then
> something (that I can't fully localize but can reproduce) happens and
> then IPT_SO_GET_INFO starts permanently returning 256.
...
> Now the litmus program always fails with:
> 
> getsockopt(3, SOL_IP, 0x40 /* IP_??? */,
> "filter\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., [84])
> = 256
> 
> I am currently on upstream commit
> 28619527b8a712590c93d0a9e24b4425b9376a8c, my .config is attached. I
> don't know what is bpfilter, I see it mentions some umh, if it
> requires some additional setup I don't it, i.e. I don't install any
> userspace modules/helpers.

This looks similar to the fallback issue described here:

  https://bugzilla.suse.com/show_bug.cgi?id=1106751#c1

Unfortunately I didn't have time to look into it more closely yet.

Michal Kubecek
