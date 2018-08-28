Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65033C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 21:07:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26884205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 21:07:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26884205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbeH2BBC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 21:01:02 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:57032 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbeH2BBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 21:01:02 -0400
Received: from localhost (unknown [104.129.192.188])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id C91C192F;
        Tue, 28 Aug 2018 21:07:35 +0000 (UTC)
Date:   Tue, 28 Aug 2018 14:07:33 -0700
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Todd Kjos <tkjos@android.com>
Cc:     tkjos@google.com, arve@android.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, maco@google.com,
        christian.brauner@canonical.com, ben@decadent.org.uk
Subject: Re: [PATCH v2] binder: use standard functions to allocate fds
Message-ID: <20180828210733.GB31143@kroah.com>
References: <20180828204625.232573-1-tkjos@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180828204625.232573-1-tkjos@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28, 2018 at 01:46:25PM -0700, Todd Kjos wrote:
> Binder uses internal fs interfaces to allocate and install fds:
> 
> __alloc_fd
> __fd_install
> __close_fd
> get_files_struct
> put_files_struct
> 
> These were used to support the passing of fds between processes
> as part of a transaction. The actual allocation and installation
> of the fds in the target process was handled by the sending
> process so the standard functions, alloc_fd() and fd_install()
> which assume task==current couldn't be used.
> 
> This patch refactors this mechanism so that the fds are
> allocated and installed by the target process allowing the
> standard functions to be used.
> 
> The sender now creates a list of fd fixups that contains the
> struct *file and the address to fixup with the new fd once
> it is allocated. This list is processed by the target process
> when the transaction is dequeued.
> 
> A new error case is introduced by this change. If an async
> transaction with file descriptors cannot allocate new
> fds in the target (probably due to out of file descriptors),
> the transaction is discarded with a log message. In the old
> implementation this would have been detected in the sender
> context and failed prior to sending.
> 
> Signed-off-by: Todd Kjos <tkjos@google.com>
> ---
> v2: use "%zu" printk format for size_t

Is this really v3?


