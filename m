Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96CB9C1B0F1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 23:36:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EB2320836
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 23:36:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EB2320836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752838AbeFSXgx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 19:36:53 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:43274 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751955AbeFSXgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 19:36:49 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.9.92])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E3720106B;
        Tue, 19 Jun 2018 23:36:48 +0000 (UTC)
Date:   Tue, 19 Jun 2018 16:36:47 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Michal Suchanek <msuchanek@suse.de>
Cc:     Jonathan Corbet <corbet@lwn.net>, Arnd Bergmann <arnd@arndb.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Aaron Wu <Aaron.Wu@analog.com>,
        Tony Luck <tony.luck@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Steven Rostedt," <rostedt@goodmis.org>,
        Laura Abbott <lauraa@codeaurora.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Baoquan He <bhe@redhat.com>,
        Ilya Matveychikov <matvejchikov@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 0/5] Kernel parameter parser cleanup/enhancement
Message-Id: <20180619163647.23c8a5d7370258c9e43141c3@linux-foundation.org>
In-Reply-To: <cover.1528215659.git.msuchanek@suse.de>
References: <cover.1528215659.git.msuchanek@suse.de>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  5 Jun 2018 18:43:07 +0200 Michal Suchanek <msuchanek@suse.de> wrote:

> due to work on the fadump_extra_args I looked at the kernel parameter parser
> and found its grammar rather curious.
> 
> It supports double quotes but not any other quoting characters so double quotes
> cannot be quoted. What's more, the quotes can be anywhere in the parameter
> name or value and are interpteted but are removed only from start and end of
> the parameter value.
> 
> These are the patches not specific to fadump which somewhat straighten the
> qouting grammar to make it on par with common shell interpreters.
> 
> Specifically double and single quotes can be used for quoting as well as
> backslashes with the usual shell semantic. All quoting characters are removed
> while the parameters are parsed.

Well.  It's nice.  I guess.  Is there any demand for these
capabilities?  I don't recall ever having seen a complaint - kernel
parameters tend to be pretty simple things.


Also, the break_arg_end() and squash_char() macros make me want to cry.
A macro which changes control flow hidden inside another macro!  Are
they reeeealy necessary?  Can't be done with some C helpers?  Maybe put
inquote, backslash, args, i into a new struct parser_state and pass a
pointer to that around the place?  At the very least, those macros
should be apologetically documented :(


