Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78148C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 19:35:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A279205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 19:35:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A279205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730178AbeGYUsV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 16:48:21 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55296 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729213AbeGYUsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 16:48:21 -0400
Received: from localhost.localdomain (c-24-4-125-7.hsd1.ca.comcast.net [24.4.125.7])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id AB701CE5;
        Wed, 25 Jul 2018 19:35:14 +0000 (UTC)
Date:   Wed, 25 Jul 2018 12:35:13 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     jbaron@akamai.com, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org, Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH -next] fs/epoll: simply CONFIG_NET_RX_BUSY_POLL ifdefery
Message-Id: <20180725123513.5f36a6b787d06c8066a24ade@linux-foundation.org>
In-Reply-To: <20180725185620.11020-1-dave@stgolabs.net>
References: <20180725185620.11020-1-dave@stgolabs.net>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Jul 2018 11:56:20 -0700 Davidlohr Bueso <dave@stgolabs.net> wrote:

> ... 'tis easier on the eye.

true, but.

> +#else
> +#define ep_busy_loop(ep, nonblock)		do { } while (0)
> +#define ep_reset_busy_poll_napi_id(ep)		do { } while (0)
> +#define ep_set_busy_poll_napi_id(epi)		do { } while (0)
> +
> +#endif /* CONFIG_NET_RX_BUSY_POLL */

inlines are preferred.  Because macros are fugly and can cause
unused-var warnings when the stub versions are used.

This?

--- a/fs/eventpoll.c~fs-epoll-simply-config_net_rx_busy_poll-ifdefery-fix
+++ a/fs/eventpoll.c
@@ -449,9 +449,18 @@ static inline void ep_set_busy_poll_napi
 }
 
 #else
-#define ep_busy_loop(ep, nonblock)		do { } while (0)
-#define ep_reset_busy_poll_napi_id(ep)		do { } while (0)
-#define ep_set_busy_poll_napi_id(epi)		do { } while (0)
+
+static inline void ep_busy_loop(struct eventpoll *ep, int nonblock)
+{
+}
+
+static inline void ep_reset_busy_poll_napi_id(struct eventpoll *ep)
+{
+}
+
+static inline void ep_set_busy_poll_napi_id(struct epitem *epi)
+{
+}
 
 #endif /* CONFIG_NET_RX_BUSY_POLL */
 
_

