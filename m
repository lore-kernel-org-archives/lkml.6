Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D218AC28CF8
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 09:04:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E88420835
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 09:04:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E88420835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbeJMQlJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 12:41:09 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:48870 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726123AbeJMQlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 12:41:09 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gBFqa-0006TX-Vq; Sat, 13 Oct 2018 09:04:33 +0000
Date:   Sat, 13 Oct 2018 10:04:32 +0100
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     Aleksa Sarai <asarai@suse.de>, Jann Horn <jannh@google.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>, jlayton@kernel.org,
        Bruce Fields <bfields@fieldses.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        David Howells <dhowells@redhat.com>, christian@brauner.io,
        Tycho Andersen <tycho@tycho.ws>,
        David Drysdale <drysdale@google.com>, dev@opencontainers.org,
        containers@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH v3 3/3] namei: aggressively check for nd->root escape on
 ".." resolution
Message-ID: <20181013090432.GV32577@ZenIV.linux.org.uk>
References: <20181009070230.12884-1-cyphar@cyphar.com>
 <20181009070230.12884-4-cyphar@cyphar.com>
 <CAG48ez3Ae5b20g2UquekfBNaUw1tLt4nWy2pYm-LNRMbDVpHfA@mail.gmail.com>
 <20181009153728.2altaqxclntvyc7b@mikami>
 <20181013082210.GU32577@ZenIV.linux.org.uk>
 <20181013085326.gx6rvgqbbyuntfvv@ryuk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181013085326.gx6rvgqbbyuntfvv@ryuk>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 13, 2018 at 07:53:26PM +1100, Aleksa Sarai wrote:

> I didn't know about path_is_under() -- I just checked and it appears to
> not take &rename_lock? From my understanding, in order to protect
> against the rename attack you need to take &rename_lock (or check
> against &rename_lock at least and retry if it changed).
> 
> I could definitely use path_is_under() if you prefer, though I think
> that in this case we'd need to take &rename_lock (right?). Also is there
> a speed issue with taking the write-side of a seqlock when we are just
> reading -- is this more efficient than doing a retry like in __d_path?

???

1) it uses is_subdir(), which does deal with rename_lock
2) what it does is taking mount_lock.lock.  I.e. the same
thing as the second retry in __d_path().  _If_ it shows
up in profiles, we can switch it to read_seqbegin_or_lock(),
but I'd like to see the profiling data first.
