Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B6B7C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 14:20:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2D64208B1
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 14:20:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2D64208B1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388309AbeG0PmX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 11:42:23 -0400
Received: from Chamillionaire.breakpoint.cc ([146.0.238.67]:57908 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730376AbeG0PmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 11:42:22 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.89)
        (envelope-from <fw@strlen.de>)
        id 1fj3ai-0003oY-8v; Fri, 27 Jul 2018 16:19:36 +0200
Date:   Fri, 27 Jul 2018 16:19:36 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Dmitry Safonov <dima@arista.com>
Cc:     Steffen Klassert <steffen.klassert@secunet.com>,
        Florian Westphal <fw@strlen.de>, linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Dmitry Safonov <0x7f454c46@gmail.com>, netdev@vger.kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        John Stultz <john.stultz@linaro.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-efi@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        Eric Paris <eparis@redhat.com>,
        Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Paul Moore <paul@paul-moore.com>, coreteam@netfilter.org,
        linux-audit@redhat.com, netfilter-devel@vger.kernel.org,
        Fan Du <fan.du@intel.com>
Subject: Re: [PATCH 00/18] xfrm: Add compat layer
Message-ID: <20180727141936.uze6ohordx7ue3no@breakpoint.cc>
References: <20180726023144.31066-1-dima@arista.com>
 <20180726084959.pzjvflfjq6a76du6@breakpoint.cc>
 <20180727073747.h27dtojlnmc3k25v@gauss3.secunet.de>
 <1532700173.2679.18.camel@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1532700173.2679.18.camel@arista.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Safonov <dima@arista.com> wrote:
> 1. It will double copy netlink messages, making it O(n) instead of
> O(1), where n - is number of bind()s.. Probably we don't care much.

About those bind() patches, I don't understand why they are needed.

Why can't you just add the compat skb to the native skb when doing
the multicast call?

skb_shinfo(skb)->frag_list = compat_skb;
xfrm_nlmsg_multicast(net, skb, 0, ...
