Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,SPOOF_COM2OTH,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7180DC43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 01:35:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 447042184B
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 01:35:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727853AbfADBfX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 20:35:23 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:58138 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727196AbfADBfW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 20:35:22 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 5E47C1F6A9;
        Fri,  4 Jan 2019 01:35:22 +0000 (UTC)
Date:   Fri, 4 Jan 2019 01:35:22 +0000
From:   Eric Wong <e@80x24.org>
To:     Joey Pabalinas <joeypabalinas@gmail.com>
Cc:     linux-kernel@vger.kernel.org, kernelnewbies@kernelnewbies.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [RFC] LKML Archive in Maildir Format
Message-ID: <20190104013522.stng6gwauwnr6wbi@starla>
References: <20181216190639.6safwjqwdphkce67@gmail.com>
 <20181216194649.GA7732@pure.paranoia.local>
 <20181216195343.idnt2y5y5wjky5gu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181216195343.idnt2y5y5wjky5gu@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Joey Pabalinas <joeypabalinas@gmail.com> wrote:
> My only comment on the public-mailbox choice is that the documentation
> is very sparse and erratic. Myself and a couple other people just
> couldn't figure out how to convert that format to Maildir or some other
> format you could feed into a reader like neomutt.

Sorry, I didn't notice this before.  I started making some attempts
at improving documentation (among other things, when time permits)
to public-inbox:

  https://public-inbox.org/meta/20190102083305.30473-1-e@80x24.org/

And without knowing anything about git or public-inbox, you can
get NNTP messages into Maildir or mboxrd pretty easily.  Nothing
new to learn :)

I wrote a one-off Ruby years ago (before public-inbox) for
converting slrnspools to Maildir (sample slrnpull.conf below).
But yeah, I wouldn't recommend 3M+ messages in a Maildir...

==> slrnspool2maildir <==
#!/usr/bin/ruby
require 'socket'
require 'fileutils'
HOSTNAME = Socket.gethostname

usage = "Usage #$0 <spooldir> <maildir>"
spooldir = ARGV[0] or abort usage
maildir = ARGV[1] or abort usage

f = base = nil
nr = 0
%w(cur new tmp).each { |x| FileUtils.mkpath("#{maildir}/#{x}") }
Dir.glob("#{spooldir}/*").each do |src|
  File.file?(src) or next
  base = File.basename(src)
  dest = "#{maildir}/new/#{Time.now.to_i}_#{base}_0.#{HOSTNAME}:2,"
  begin
    File.link(src, dest)
  rescue Errno::EEXIST
    warn "#{dest} already exists"
    next
  end
  File.unlink(src)
end
__END__
==> slrnpull.conf <==
# group_name                         max        expire     headers_only
inbox.com.example.news.group.name    1000000000 1000000000 0
# usage: slrnpull -d $PWD -h news.example.com --no-post

# Wouldn't be hard to script something using Net::NNTP in Perl
# to write directly to Maildirs, either.
