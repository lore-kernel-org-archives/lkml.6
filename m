Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D30E8ECDFAA
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 22:54:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86A3E208E3
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 22:54:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86A3E208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387538AbeGLXG0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 19:06:26 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44390 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387438AbeGLXG0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 19:06:26 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 878C54074475;
        Thu, 12 Jul 2018 22:54:43 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-149.rdu2.redhat.com [10.10.120.149])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 49FA0111AF3C;
        Thu, 12 Jul 2018 22:54:42 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20180712223223.GA28610@thunk.org>
References: <20180712223223.GA28610@thunk.org> <CA+55aFw1WyKY+-2dg62M-QT_F0-waCTCrba1DW4dStYz-f_fjA@mail.gmail.com> <153126248868.14533.9751473662727327569.stgit@warthog.procyon.org.uk> <153126264966.14533.3388004240803696769.stgit@warthog.procyon.org.uk> <686E805C-81F3-43D0-A096-50C644C57EE3@amacapital.net> <22370.1531293761@warthog.procyon.org.uk> <CALCETrU3kbh-ZRHDj7-Asq+OH-35dQ2p_erpHpYUvN5+BdAoVQ@mail.gmail.com> <7002.1531407244@warthog.procyon.org.uk> <CA+55aFx+xm333ZZ7d2Z39QuhDu=0XM6nTMChbHvWQOXNk32yxw@mail.gmail.com> <16699.1531426991@warthog.procyon.org.uk> <18233.1531430797@warthog.procyon.org.uk>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     dhowells@redhat.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Lutomirski <luto@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jann Horn <jannh@google.com>
Subject: Re: [PATCH 24/32] vfs: syscall: Add fsopen() to prepare for superblock creation [ver #9]
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <22104.1531436081.1@warthog.procyon.org.uk>
Date:   Thu, 12 Jul 2018 23:54:41 +0100
Message-ID: <22105.1531436081@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Thu, 12 Jul 2018 22:54:43 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Thu, 12 Jul 2018 22:54:43 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Theodore Y. Ts'o <tytso@mit.edu> wrote:

> So maybe the answer is that you open /dev/sda1 and /dev/sda2 and then
> pass the file descriptors to the fsopen object?  We can require that
> the fd's be opened with O_RDWR and O_EXCL, which has the benefit where
> if you have multiple block devices, you know *which* block device had
> a problem with being grabbed for an exclusive open.

Would that mean then that doing:

	mount /dev/sda3 /a
	mount /dev/sda3 /b

would then fail on the second command because /dev/sda3 is already open
exclusively?

David
