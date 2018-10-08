Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94E69C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 16:54:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FAEB214DA
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 16:54:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FAEB214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbeJIAGt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 20:06:49 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:46803 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbeJIAGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 20:06:49 -0400
Received: from birne.hi.pengutronix.de ([2001:67c:670:100:feaa:14ff:fe28:e6f5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1g9YnK-0001pp-IQ; Mon, 08 Oct 2018 18:54:10 +0200
Subject: Re: [PATCH RFC] proc: Don't retain negative dentries
To:     Andrew Morton <akpm@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>
Cc:     David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Florian Westphal <fw@strlen.de>, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
References: <20181008165009.21890-1-a.fatoum@pengutronix.de>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
Message-ID: <011efbc0-39fe-76f2-2325-3252680228d0@pengutronix.de>
Date:   Mon, 8 Oct 2018 18:54:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181008165009.21890-1-a.fatoum@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:feaa:14ff:fe28:e6f5
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/8/18 6:50 PM, Ahmad Fatoum wrote:
> The referenced commit 1da4d377f94 ("proc: revalidate misc dentries")
> caused following userspace code to access a stale /proc/net/dev
> after the network namespace was changed:
> 
>     system("ip netns add testns");
> 
>     printf("default:\n"); {
>         int devinfd = open("/proc/net/dev", O_RDONLY);
>         sendfile(STDOUT_FILENO, devinfd, NULL, 4096);
>         close(devinfd);
>     }
> 
>     printf("testns:\n"); {
>         int ns_fd = open("/var/run/netns/testns", O_RDONLY);
>         setns(ns_fd, 0);
> 
>         int devinfd = open("/proc/net/dev", O_RDONLY);
>         sendfile(STDOUT_FILENO, devinfd, NULL, 4096);
>         close(devinfd);
> 
>         close(ns_fd);
>     }
> 
> Despite switching the network namespace, the read access from the
> newly opened file gave back what the very first read in the default
> network namespace returned.
> 
> This doesn't occur if /proc/net/dev is opened within a new process,
> which might explain why this wasn't noticed previously.
> 
> As I don't see a reason why one would keep negative dentries for procfs
> at all, amend the code not to do this anymore.
> 
> Fixes: 1da4d377f94 ("proc: Don't retain negative dentries")

This should read

Fixes: 1da4d377f94 ("proc: revalidate misc dentries") 

instead...
