Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 191ECECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 13:15:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4BBD20645
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 13:15:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4BBD20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727214AbeJQVKw convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 17:10:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33376 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727000AbeJQVKw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 17:10:52 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CB974317C40B;
        Wed, 17 Oct 2018 13:15:13 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-250.rdu2.redhat.com [10.10.120.250])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3EED519E26;
        Wed, 17 Oct 2018 13:15:02 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <68a2107f-bf70-055b-86cf-1ba2ba9422bf@gmail.com>
References: <68a2107f-bf70-055b-86cf-1ba2ba9422bf@gmail.com> <153754740781.17872.7869536526927736855.stgit@warthog.procyon.org.uk> <153754766004.17872.9829232103614083565.stgit@warthog.procyon.org.uk> <9b8bf436-65de-13b9-0002-0479d11c18ca@gmail.com> <20181013061141.GR32577@ZenIV.linux.org.uk>
To:     Alan Jenkins <alan.christopher.jenkins@gmail.com>
Cc:     dhowells@redhat.com, Al Viro <viro@ZenIV.linux.org.uk>,
        linux-api@vger.kernel.org, torvalds@linux-foundation.org,
        ebiederm@xmission.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, mszeredi@redhat.com
Subject: Re: [PATCH 31/34] vfs: syscall: Add fspick() to select a superblock for reconfiguration [ver #12]
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Date:   Wed, 17 Oct 2018 14:15:01 +0100
Message-ID: <19866.1539782101@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Wed, 17 Oct 2018 13:15:14 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Jenkins <alan.christopher.jenkins@gmail.com> wrote:

> Sorry, I guess SB_NOUSER was the wrong word.  I was trying find if anything
> stopped things like
> 
> int memfd = memfd_create("foo", 0);
> int fsfd = fspick(memfd, "", FSPICK_EMPTY_PATH);
> 
> fsconfig(fsfd, FSCONFIG_SET_FLAG, "ro", NULL, 0);
> fsconfig(fsfd, FSCONFIG_SET_STRING, "size", "100M", 0);
> fsconfig(fsfd, FSCONFIG_CMD_RECONFIGURE, NULL, NULL, 0);
> 
> So far I'm getting -EBUSY if I try to apply the "ro", -EINVAL if I try to
> apply the "size=100M".  But if I don't apply either, then
> FSCONFIG_CMD_RECONFIGURE succeeds.

I should probably check that the picked point is actually a mountpoint.

David
