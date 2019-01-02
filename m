Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B605BC43444
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 09:34:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DCBD218A4
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 09:34:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728924AbfABJe4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 04:34:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35000 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726782AbfABJez (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 04:34:55 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7376DC059B8C;
        Wed,  2 Jan 2019 09:34:55 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-244.rdu2.redhat.com [10.10.120.244])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EB9E46013B;
        Wed,  2 Jan 2019 09:34:53 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20181226135618.12784-1-baijiaju1990@gmail.com>
References: <20181226135618.12784-1-baijiaju1990@gmail.com>
To:     Jia-Ju Bai <baijiaju1990@gmail.com>
Cc:     dhowells@redhat.com, benh@kernel.crashing.org, joel@jms.id.au,
        eajames@linux.vnet.ibm.com, andrew@aj.id.au,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fsi:fsi-sbefifo: Fix possible concurrency use-after-free bugs in sbefifo_user_release
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <26863.1546421693.1@warthog.procyon.org.uk>
Date:   Wed, 02 Jan 2019 09:34:53 +0000
Message-ID: <26864.1546421693@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Wed, 02 Jan 2019 09:34:55 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jia-Ju Bai <baijiaju1990@gmail.com> wrote:

> +	mutex_lock(&user->file_lock);
>  	sbefifo_release_command(user);
>  	free_page((unsigned long)user->cmd_page);
> +	mutex_unlock(&user->file_lock);

It shouldn't be necessary to do the free_page() call inside the locked
section.

David
