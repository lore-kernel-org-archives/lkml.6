Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E17B2ECDFB0
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 22:32:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87B062087C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 22:32:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="NH0MoP2/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87B062087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733235AbeGLWoH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 18:44:07 -0400
Received: from imap.thunk.org ([74.207.234.97]:36656 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732240AbeGLWoG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 18:44:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=vfPnEpp+H+H84JqdRBOieBEdfnjzEGVQB1H7VxLkfEQ=; b=NH0MoP2/E3qeaESfP5AVpBJGqC
        45vVIWpINRxLc72PEH4fzWdAOc2p5kBtc5BoycSe8xTk7GNQLdf23MPnaCaAh4jHr3Cfg5Vkg8+Ru
        uZWO5YQSj81n1PKhlYhsW+d48hWKcaSpqG2LoKjqS7ya55QOZVcNoQyspNqdWzRDFlkM=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1fdk8O-0005tl-P7; Thu, 12 Jul 2018 22:32:24 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 7EF0F7A55D2; Thu, 12 Jul 2018 18:32:23 -0400 (EDT)
Date:   Thu, 12 Jul 2018 18:32:23 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     David Howells <dhowells@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Lutomirski <luto@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jann Horn <jannh@google.com>
Subject: Re: [PATCH 24/32] vfs: syscall: Add fsopen() to prepare for
 superblock creation [ver #9]
Message-ID: <20180712223223.GA28610@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Lutomirski <luto@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jann Horn <jannh@google.com>
References: <CA+55aFw1WyKY+-2dg62M-QT_F0-waCTCrba1DW4dStYz-f_fjA@mail.gmail.com>
 <153126248868.14533.9751473662727327569.stgit@warthog.procyon.org.uk>
 <153126264966.14533.3388004240803696769.stgit@warthog.procyon.org.uk>
 <686E805C-81F3-43D0-A096-50C644C57EE3@amacapital.net>
 <22370.1531293761@warthog.procyon.org.uk>
 <CALCETrU3kbh-ZRHDj7-Asq+OH-35dQ2p_erpHpYUvN5+BdAoVQ@mail.gmail.com>
 <7002.1531407244@warthog.procyon.org.uk>
 <CA+55aFx+xm333ZZ7d2Z39QuhDu=0XM6nTMChbHvWQOXNk32yxw@mail.gmail.com>
 <16699.1531426991@warthog.procyon.org.uk>
 <18233.1531430797@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18233.1531430797@warthog.procyon.org.uk>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 10:26:37PM +0100, David Howells wrote:
> The problem is that there's more than one actual "open" involved.
> 
> 	fd = fsopen("ext4");				<--- #1
> 	whatever_interface(fd, "s /dev/sda1");
> 	whatever_interface(fd, "o journal_path=/dev/sda2");
> 	do_the_create_thing(fd);			<--- #2 and #3
> 
> The initial check to see whether you can mount or not is done at #1.
> 
> But later there are two nested file opens.  Internally, deep down inside the
> block layer, /dev/sda1 and /dev/sda2 are opened and further permissions checks
> are done, whether you like it or not.  But these have no access to the creds
> attached to fd as things currently stand.

So maybe the answer is that you open /dev/sda1 and /dev/sda2 and then
pass the file descriptors to the fsopen object?  We can require that
the fd's be opened with O_RDWR and O_EXCL, which has the benefit where
if you have multiple block devices, you know *which* block device had
a problem with being grabbed for an exclusive open.

Just a thought.

						- Ted
