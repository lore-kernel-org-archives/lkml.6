Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6C88C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 03:36:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CCCF21523
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 03:36:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CCCF21523
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726215AbeHQGhy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 02:37:54 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:35722 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725769AbeHQGhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 02:37:53 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fqVYU-0003sX-Fu; Fri, 17 Aug 2018 03:36:06 +0000
Date:   Fri, 17 Aug 2018 04:36:06 +0100
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Srikanth Korangala Hari <srikanth.h@samsung.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "adobriyan@gmail.com" <adobriyan@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: Re: [PATCH 1/1] Preventive patch in the proc file-system to
 handle NULL check.
Message-ID: <20180817033606.GB6515@ZenIV.linux.org.uk>
References: <20180816131731.GB1457@garbanzo.do-not-panic.com>
 <1534412053-22457-1-git-send-email-srikanth.h@samsung.com>
 <CGME20180816093424epcas2p25ede075fec715ad31108360ddca9cce8@epcms5p8>
 <20180817032142epcms5p875c72643ea624e3b2d8f10e4abaf5182@epcms5p8>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180817032142epcms5p875c72643ea624e3b2d8f10e4abaf5182@epcms5p8>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 17, 2018 at 08:51:42AM +0530, Srikanth Korangala Hari wrote:
> > Thanks for the patch! Do you have a reproducer or is this theoretical?
> > This will affect if it should go to stable or not.
> 
> Dear Luis, this is theoretical as I observed in most of the call's to api - "proc_mkdir" the NULL check is being done. Hence I thought of adding one here.

Realistically, if you get allocation failures that early in the boot,
oops is the least of your problems - it won't get through mounting
the root or lauching init (or unpacking initramfs, etc.)

Sure, might as well check it there - nothing wrong with that, but do
keep in mind that
	* it's very certain to end up in panic() very shortly afterwards,
no matter what
	* the odds of exhausting memory (and that would be extremely
low-memory setup) precisely at that point (i.e. even getting to
proc_root_init()) are not high.

Might be interesting to try lower and lower mem=... values passed to the
kernel in attempt to step into this one; I wouldn't put large odds on
being able to hit precisely that place, but it would be educational anyway.
