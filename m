Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BECE1C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 12:20:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89988206B2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 12:20:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89988206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bitron.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504186AbeKWXEY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 18:04:24 -0500
Received: from nov-007-i650.relay.mailchannels.net ([46.232.183.204]:34405
        "EHLO nov-007-i650.relay.mailchannels.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387923AbeKWXEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 18:04:24 -0500
X-Greylist: delayed 593 seconds by postgrey-1.27 at vger.kernel.org; Fri, 23 Nov 2018 18:04:20 EST
X-Sender-Id: novatrend|x-authuser|juerg@bitron.ch
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 04BAEBE050F;
        Fri, 23 Nov 2018 12:10:27 +0000 (UTC)
Received: from srv17.tophost.ch (swiss-ingress-1.ch.mailchannels.com [46.232.183.5])
        by relay.mailchannels.net (Postfix) with ESMTPA id 4A4B5BE00D9;
        Fri, 23 Nov 2018 12:10:19 +0000 (UTC)
X-Sender-Id: novatrend|x-authuser|juerg@bitron.ch
Received: from srv17.tophost.ch (srv17.tophost.ch [193.33.128.141])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384)
        by 0.0.0.0:2500 (trex/5.15.2);
        Fri, 23 Nov 2018 12:10:27 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: novatrend|x-authuser|juerg@bitron.ch
X-MailChannels-Auth-Id: novatrend
X-Share-Drop: 059264ac1b1d5ec2_1542975026764_388681693
X-MC-Loop-Signature: 1542975026764:3636178841
X-MC-Ingress-Time: 1542975026763
Received: from [80.219.231.201] (port=46298 helo=jzen.bitron.ch)
        by srv17.tophost.ch with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <j@bitron.ch>)
        id 1gQAHq-003RuN-0I; Fri, 23 Nov 2018 13:10:18 +0100
Message-ID: <1ce83cdf6e3168350b69f98f08aaa202bbaa682d.camel@bitron.ch>
Subject: Re: [PATCH v4 2/4] namei: O_BENEATH-style path resolution flags
From:   =?ISO-8859-1?Q?J=FCrg?= Billeter <j@bitron.ch>
To:     Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>
Cc:     Eric Biederman <ebiederm@xmission.com>,
        Christian Brauner <christian@brauner.io>,
        linux-api@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Jann Horn <jannh@google.com>,
        David Drysdale <drysdale@google.com>,
        Aleksa Sarai <asarai@suse.de>,
        containers@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Date:   Fri, 23 Nov 2018 13:10:17 +0100
In-Reply-To: <20181112142654.341-3-cyphar@cyphar.com>
References: <20181112142654.341-1-cyphar@cyphar.com>
         <20181112142654.341-3-cyphar@cyphar.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AuthUser: juerg@bitron.ch
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aleksa,

On Tue, 2018-11-13 at 01:26 +1100, Aleksa Sarai wrote:
> * O_BENEATH: Disallow "escapes" from the starting point of the
>   filesystem tree during resolution (you must stay "beneath" the
>   starting point at all times). Currently this is done by disallowing
>   ".." and absolute paths (either in the given path or found during
>   symlink resolution) entirely, as well as all "magic link" jumping.

With open_tree(2) and OPEN_TREE_CLONE, will O_BENEATH still be
necessary? As I understand it, O_BENEATH could be replaced by a much
simpler flag that only disallows absolute paths (incl. absolute
symlinks). And it would have the benefit that you can actually pass the
tree/directory fd to another process and escaping would not be possible
even if that other process doesn't use O_BENEATH (after calling
mount_setattr(2) to make sure it's locked down).

This approach would also make it easy to restrict writes via a cloned
tree/directory fd by marking it read-only via mount_setattr(2) (and
locking down the read-only flag). This would again be especially useful
when passing tree/directory fds across processes, or for voluntary
self-lockdown within a process for robustness against security bugs.

This wouldn't affect any of the other flags in this patch. And for full
equivalence to O_BENEATH you'd have to use O_NOMAGICLINKS in addition
to O_NOABSOLUTE, or whatever that new flag would be called.

Or is OPEN_TREE_CLONE too expensive for this use case? Or is there
anything else I'm missing?

Jürg

