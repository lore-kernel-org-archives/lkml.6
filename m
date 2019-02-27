Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,TRACKER_ID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E3D5C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 04:25:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 404D221852
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 04:25:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729722AbfB0EY6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 23:24:58 -0500
Received: from gateway30.websitewelcome.com ([192.185.193.11]:40041 "EHLO
        gateway30.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729128AbfB0EY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 23:24:58 -0500
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
        by gateway30.websitewelcome.com (Postfix) with ESMTP id 210EB10273
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 22:24:57 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id yqm9guTBldnCeyqm9gqroP; Tue, 26 Feb 2019 22:24:57 -0600
X-Authority-Reason: nr=8
Received: from [189.250.127.169] (port=49164 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gyqm8-0048v3-LN; Tue, 26 Feb 2019 22:24:56 -0600
Date:   Tue, 26 Feb 2019 22:24:54 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Cliff Whickman <cpw@sgi.com>, Robin Holt <robinmholt@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>
Subject: [sgi-xp] Missing break or false positive?
Message-ID: <20190227042454.GA29535@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.127.169
X-Source-L: No
X-Exim-ID: 1gyqm8-0048v3-LN
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.127.169]:49164
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 5
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I'm taking a look into the following piece of code in drivers/misc/sgi-xp/xpc_uv.c:

 561         case XPC_ACTIVATE_MQ_MSG_CHCTL_OPENCOMPLETE_UV: {
 562                 struct xpc_activate_mq_msg_chctl_opencomplete_uv *msg;
 563 
 564                 if (!part_setup)
 565                         break;
 566 
 567                 msg = container_of(msg_hdr, struct
 568                                 xpc_activate_mq_msg_chctl_opencomplete_uv, hdr);
 569                 spin_lock_irqsave(&part->chctl_lock, irq_flags);
 570                 part->chctl.flags[msg->ch_number] |= XPC_CHCTL_OPENCOMPLETE;
 571                 spin_unlock_irqrestore(&part->chctl_lock, irq_flags);
 572 
 573                 xpc_wakeup_channel_mgr(part);
 574         }

and I'm trying to figure out if the following warning is due to a missing break
at the end of the case, or if this is just a false positive and a /* fall through */
annotation should be added:

drivers/misc/sgi-xp/xpc_uv.c: In function ‘xpc_handle_activate_mq_msg_uv’:
drivers/misc/sgi-xp/xpc_uv.c:573:3: warning: this statement may fall through [-Wimplicit-fallthrough=]
   xpc_wakeup_channel_mgr(part);
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/misc/sgi-xp/xpc_uv.c:575:2: note: here
  case XPC_ACTIVATE_MQ_MSG_MARK_ENGAGED_UV:
  ^~~~

The piece of code above was introduced by the following commit in 2009:

efdd06ed181a88a11e612238c1ac04668e665395

The cases are pretty similar, and the fact that this code was introduced
in the middle of the switch statement and not at the end or the beginning,
leads me to believe that this is a false positive.  On the other hand,
all the other cases end with a break or a return but this one.  So, I
better ask your opinions about this.

Thanks
--
Gustavo
