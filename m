Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BFA5C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 20:06:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B103420843
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 20:06:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B103420843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730445AbeGYVTy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 17:19:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:58824 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729529AbeGYVTy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 17:19:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2E56AACA8;
        Wed, 25 Jul 2018 20:06:39 +0000 (UTC)
Date:   Wed, 25 Jul 2018 13:06:33 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     jbaron@akamai.com, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org, Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH -next] fs/epoll: simply CONFIG_NET_RX_BUSY_POLL ifdefery
Message-ID: <20180725200633.c36cdaf4ymgscump@linux-r8p5>
References: <20180725185620.11020-1-dave@stgolabs.net>
 <20180725123513.5f36a6b787d06c8066a24ade@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20180725123513.5f36a6b787d06c8066a24ade@linux-foundation.org>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Jul 2018, Andrew Morton wrote:

>On Wed, 25 Jul 2018 11:56:20 -0700 Davidlohr Bueso <dave@stgolabs.net> wrote:
>
>> ... 'tis easier on the eye.
>
>true, but.
>
>> +#else
>> +#define ep_busy_loop(ep, nonblock)		do { } while (0)
>> +#define ep_reset_busy_poll_napi_id(ep)		do { } while (0)
>> +#define ep_set_busy_poll_napi_id(epi)		do { } while (0)
>> +
>> +#endif /* CONFIG_NET_RX_BUSY_POLL */
>
>inlines are preferred.  Because macros are fugly and can cause
>unused-var warnings when the stub versions are used.

Fair enough.

>This?

Do you want me to send a v2 or will you fold in the below?

Thanks,
Davidlohr

>
>--- a/fs/eventpoll.c~fs-epoll-simply-config_net_rx_busy_poll-ifdefery-fix
>+++ a/fs/eventpoll.c
>@@ -449,9 +449,18 @@ static inline void ep_set_busy_poll_napi
> }
>
> #else
>-#define ep_busy_loop(ep, nonblock)		do { } while (0)
>-#define ep_reset_busy_poll_napi_id(ep)		do { } while (0)
>-#define ep_set_busy_poll_napi_id(epi)		do { } while (0)
>+
>+static inline void ep_busy_loop(struct eventpoll *ep, int nonblock)
>+{
>+}
>+
>+static inline void ep_reset_busy_poll_napi_id(struct eventpoll *ep)
>+{
>+}
>+
>+static inline void ep_set_busy_poll_napi_id(struct epitem *epi)
>+{
>+}
>
> #endif /* CONFIG_NET_RX_BUSY_POLL */
>
>_
>
