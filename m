Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 607AFC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 10:58:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C0B520846
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 10:58:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C0B520846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754085AbeFTK6f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 06:58:35 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39136 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752750AbeFTK6e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 06:58:34 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DC30616987;
        Wed, 20 Jun 2018 10:58:33 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-94.rdu2.redhat.com [10.10.120.94])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A9B737C25;
        Wed, 20 Jun 2018 10:58:31 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20180620083339.766780-1-arnd@arndb.de>
References: <20180620083339.766780-1-arnd@arndb.de>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     dhowells@redhat.com, y2038@lists.linaro.org,
        linux-cachefs@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cachefiles: avoid deprecated get_seconds()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5488.1529492311.1@warthog.procyon.org.uk>
Date:   Wed, 20 Jun 2018 11:58:31 +0100
Message-ID: <5489.1529492311@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Wed, 20 Jun 2018 10:58:33 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Wed, 20 Jun 2018 10:58:33 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann <arnd@arndb.de> wrote:

> -	sprintf(nbuffer, "%08x%08x",
> -		(uint32_t) get_seconds(),
> +	sprintf(nbuffer, "%08llx%08x",
> +		(uint64_t) ktime_get_real_seconds(),

It's not necessary to expand the 'time' field of the name.  It's not
interpreted by userspace, it's just there to prevent collisions when moving
directories about.  If your cache goes weird in the future because there was a
collision with an object that was moved to the graveyard 68 years ago and not
cleaned up, then that's probably a bug in cachefilesd.

But I've no objection to using ktime_get_real_seconds() and truncating the
value.

David
