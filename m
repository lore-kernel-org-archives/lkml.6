Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2E24C43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 19:46:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAD77206B2
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 19:46:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PPu01VWs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAD77206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728015AbeI3CQc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 22:16:32 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38078 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727405AbeI3CQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 22:16:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=d+Pi6r1Xb+XbBfameMEsWsdZZO+w1ilk/ee61pLllTo=; b=PPu01VWsmZCdrM/rcgdEM3Cdu
        iu2NiBA4bqfMDkHUgm5EGmXYNQeUm0xsCUQRfYd4w4mPY8KaeoCQ/u7EV/uFwZI0u18DtwG/ju4Vm
        odl35rs99dqF8g4wt+q+gibdq9Aog+KUaKOxQxAb1B/narPjSYJ4tvUGKHjcCJ4zEGoQjGw6B+Dnc
        uh4t8IZR7xc00AMqpiGCrbt+kVyxG3+xJdMR+7yX/WQKKg0MlKo1ZdwCYXeXyCs6AQtku43D3Lcuj
        qPV94fCwoiE8tS0A5pJrFatZBWgRnkSvMQz+aEt2hslIV5mxBc8AuvNvWnvnTQKMt1Gk+D5lIPOe6
        y8OXUKafQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g6LAD-0002dY-Ip; Sat, 29 Sep 2018 19:44:29 +0000
Date:   Sat, 29 Sep 2018 12:44:29 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Aleksa Sarai <cyphar@cyphar.com>, Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>, Shuah Khan <shuah@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Brauner <christian@brauner.io>,
        Eric Biederman <ebiederm@xmission.com>,
        Tycho Andersen <tycho@tycho.ws>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kselftest@vger.kernel.org, dev@opencontainers.org,
        containers@lists.linux-foundation.org
Subject: Re: [PATCH 0/3] namei: implement various scoping AT_* flags
Message-ID: <20180929194429.GA1702@bombadil.infradead.org>
References: <20180929103453.12025-1-cyphar@cyphar.com>
 <1EE20CA2-4C8B-4A80-B613-0277D92B376D@amacapital.net>
 <20180929154551.jsi6dt3xjxdxoqeh@ryuk>
 <9D01A225-05BE-4B4A-873A-94168D17F687@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9D01A225-05BE-4B4A-873A-94168D17F687@amacapital.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 29, 2018 at 09:34:24AM -0700, Andy Lutomirski wrote:
> Also, as a perhaps-silly suggestion: if you end up adding a new
> syscall, I can see a use for a mode that does the path walk but, rather
> than failing on a disallowed link, stops early and indicates where it
> stopped. Then web servers, samba, etc can more efficiently implement
> custom behavior when links are encountered.  And it may also be useful
> to have a variant of AT_THIS_ROOT where trying to escape is an error
> instead of having it just get stuck at the root.

AT_USER_LINKS indicating that userspace wants to resolve symlinks
themselves?
