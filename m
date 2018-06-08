Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 0oRUHm6WGlvZEgAAmS7hNA
	; Fri, 08 Jun 2018 14:45:23 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 43FB06089E; Fri,  8 Jun 2018 14:45:23 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id BB943606FA;
	Fri,  8 Jun 2018 14:45:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BB943606FA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752758AbeFHOpU (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 10:45:20 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48804 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752328AbeFHOpS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 10:45:18 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4472B8A6FA;
        Fri,  8 Jun 2018 14:45:18 +0000 (UTC)
Received: from gondolin (dhcp-192-215.str.redhat.com [10.33.192.215])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0F7C52026609;
        Fri,  8 Jun 2018 14:45:16 +0000 (UTC)
Date: Fri, 8 Jun 2018 16:45:14 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: Pierre Morel <pmorel@linux.ibm.com>,
        Dong Jia Shi <bjsdjshi@linux.ibm.com>,
        linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, qemu-s390x@nongnu.org,
        qemu-devel@nongnu.org
Subject: Re: [PATCH RFC 2/2] vfio-ccw: support for halt/clear subchannel
Message-ID: <20180608164514.2e8248f4.cohuck@redhat.com>
In-Reply-To: <d68340a2-bb1b-cef9-e394-f0d55983c0bb@linux.ibm.com>
References: <20180509154822.23510-1-cohuck@redhat.com>
        <20180509154822.23510-3-cohuck@redhat.com>
        <c18f9b9f-da00-1a0b-8ef0-7ac223c73d1a@linux.ibm.com>
        <20180515181006.0cb1dfc2.cohuck@redhat.com>
        <a5d08fb7-d9c1-b230-fe0c-acebbda2ba65@linux.ibm.com>
        <20180522145208.310143ea.cohuck@redhat.com>
        <4e4001cc-540e-0f2b-bbd1-1f82ca594bb3@linux.ibm.com>
        <20180605151449.22aafbfc.cohuck@redhat.com>
        <e73038ff-fb2d-5865-8b84-e775990f3983@linux.ibm.com>
        <20180606142131.74ea2eb7.cohuck@redhat.com>
        <5b77ec9c-41b8-2e32-ce79-d9005b93fdd0@linux.ibm.com>
        <20180607115442.6a779ed9.cohuck@redhat.com>
        <86d57698-3ea7-a390-2217-07c6d41ca9ed@linux.ibm.com>
        <20180608142022.7dd6a658.cohuck@redhat.com>
        <d68340a2-bb1b-cef9-e394-f0d55983c0bb@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Fri, 08 Jun 2018 14:45:18 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Fri, 08 Jun 2018 14:45:18 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'cohuck@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Jun 2018 15:13:28 +0200
Halil Pasic <pasic@linux.ibm.com> wrote:

> On 06/08/2018 02:20 PM, Cornelia Huck wrote:
> >>> My proposal is to do the same
> >>> copying to scsw(r) again, which would mean we get a request with both
> >>> the halt and the start bit set. The vfio code now needs to do a hsch
> >>> (instead of a ssch). The real channel subsystem should figure this out,
> >>> as we can't reliably check whether the start function has concluded
> >>> already (there's always a race window).  
> >> This I do not agree scsw(r) is part of the driver.
> >> The interface here is not a device interface anymore but a driver
> >> interface.
> >> SCSW is a status, it is at its place in QEMU device interface with the
> >> guest
> >> but here pwrite() sends a command.  
> > Hm, I rather consider that "we write a status, and the backend figures
> > out what to do based on that status".
> >   
> 
> The status of what? Kind of a target status?
> 
> I think this approach is the source of lots of complications. For instance
> take xsch. How are we supposed to react to a guest xsch (in QEMU and
> in the kernel module)? My guess is that the right thing to do is to issue
> an xsch in the vfio-ccw kernel module on the passed through subchannel.
> But there is no bit in fctl for cancel.
> 
> Bottom line is: I'm not happy with the current design but I'm not sure
> if it's practical to do something about it (i.e. change it radically).

It might make sense to keep this for ssch, maybe reuse it for hsch/csch,
and think about something else for other things we want to handle
(xsch, channel monitoring, the path handling stuff for which we already
had a prototype etc.) It's probably not practical to do radical surgery
on the existing code.

[Speaking of which: Is there any current effort on the path handling
things?]
