Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DFEDC10F0B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 03:57:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4BD0217F5
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 03:57:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CQq89mON"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbfBZD5q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 22:57:46 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:58090 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbfBZD5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 22:57:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Quv3YfUmhrPNUMCgAXXUle+etixw9QKj9S3s9u17QdU=; b=CQq89mONXp+sgS1IH4jU4x/7M
        z9uV/INOoRLO9uYreGt8k7cDCF8YIM9b5VWF+OwyJs3EHLAzJzh9zox8WCMv29TfhKvQxy4Q4biIk
        jDDI3AuENHo11s2dqIWs/XWIUwZqF3/G4ER3vz7edVpga0Ovx/z3JcB6JTzpLFbzUo1soZvLkG/XM
        vfhz+DCCLyPXuTx3rdtNV+dZG/ds8CNAQHuAY7PYJREjEzD8giMzTvEHPjTyQ9UgzX2zMH5m/R/Tj
        QvgVTL2OH17oIiTHHyMUmouGNwhPaKgAoVOSKkCnzpbXkzBricMsGMjNQc1K/0HlXL8OjPDZgnOlA
        p+SR/DuRA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gyTsD-0006Xg-Df; Tue, 26 Feb 2019 03:57:41 +0000
Date:   Mon, 25 Feb 2019 19:57:41 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     David Miller <davem@davemloft.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable <stable@vger.kernel.org>,
        Changbin Du <changbin.du@gmail.com>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Andrew Lutomirski <luto@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Netdev <netdev@vger.kernel.org>, bpf@vger.kernel.org
Subject: Re: [PATCH 1/2 v2] kprobe: Do not use uaccess functions to access
 kernel memory that can fault
Message-ID: <20190226035741.GA14994@infradead.org>
References: <CAHk-=whNf_n1WXWW+ugAVeL5ZK0GcEP3cTYocju1nS85VtMjjQ@mail.gmail.com>
 <20190222192703.epvgxghwybte7gxs@ast-mbp.dhcp.thefacebook.com>
 <CAHk-=wib9VSbwbS+N82ZPNtvt4vrvYyHyQduhFimX8nyjCyZyA@mail.gmail.com>
 <20190222.133842.1637029078039923178.davem@davemloft.net>
 <CAHk-=wh9uWJaih5i6qBPer5rzcs=A+yb_ejU093b1esAhoFveQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wh9uWJaih5i6qBPer5rzcs=A+yb_ejU093b1esAhoFveQ@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2019 at 01:59:10PM -0800, Linus Torvalds wrote:
> On Fri, Feb 22, 2019 at 1:38 PM David Miller <davem@davemloft.net> wrote:
> >
> > Don't be surprised if we see more separation like this in the future too.
> 
> Yes, with the whole meltdown fiasco, there's actually more pressure to
> add more support for separation of kernel/user address spaces. As Andy
> pointed out, it's been discussed as a future wish-list for x86-64 too.

S/390 is another example.

I've also proposed a RISC-V extension for it, including prototypes
for Rocketchip and Qemu, and a Linux kernel support, but it didn't go
any way.
