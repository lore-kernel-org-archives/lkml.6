Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2133C04AB8
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 21:51:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B673620881
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 21:51:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B673620881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728270AbeINDCT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 23:02:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39086 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727413AbeINDCT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 23:02:19 -0400
Received: from smtp.corp.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.27])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E32093082120;
        Thu, 13 Sep 2018 21:50:58 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-123-84.rdu2.redhat.com [10.10.123.84])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 914AE8B739;
        Thu, 13 Sep 2018 21:50:57 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <153685496637.16086.17825712088461188576.stgit@warthog.procyon.org.uk>
References: <153685496637.16086.17825712088461188576.stgit@warthog.procyon.org.uk> <153685493441.16086.3483582787020297039.stgit@warthog.procyon.org.uk>
Cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk,
        linux-afs@lists.infradead.org, keyrings@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] afs: Differentiate VL servers
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <14306.1536875456.1@warthog.procyon.org.uk>
Date:   Thu, 13 Sep 2018 22:50:56 +0100
Message-ID: <14307.1536875456@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.27
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Thu, 13 Sep 2018 21:50:59 +0000 (UTC)
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells <dhowells@redhat.com> wrote:

> +		ret = -EPROTONOSUPPORT;
> +		if (protocol != IPPROTO_UDP)
> +			goto error;

This needs to be:

		ret = -EPROTONOSUPPORT;
		if (protocol != IPPROTO_UDP && protocol != 0)
			goto error;

so that if the protocol is unspecified by the DNS upcall program, we choose
UDP.

David
