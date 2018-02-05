Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753388AbeBESBl (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 13:01:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:34180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753028AbeBESBe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 13:01:34 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5C7E2172D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sstabellini@kernel.org
Date: Mon, 5 Feb 2018 10:01:32 -0800 (PST)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@sstabellini-ThinkPad-X260
To: Boris Ostrovsky <boris.ostrovsky@oracle.com>
cc: Stefano Stabellini <sstabellini@kernel.org>, jgross@suse.com,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pvcalls-back: do not return error on inet_accept
 EAGAIN
In-Reply-To: <936e4d18-3f0d-3fc5-2272-c1ad9a5c7022@oracle.com>
Message-ID: <alpine.DEB.2.10.1802050953570.10160@sstabellini-ThinkPad-X260>
References: <alpine.DEB.2.10.1802021728420.10160@sstabellini-ThinkPad-X260> <936e4d18-3f0d-3fc5-2272-c1ad9a5c7022@oracle.com>
User-Agent: Alpine 2.10 (DEB 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1047736138-1517853694=:10160"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1047736138-1517853694=:10160
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Sun, 4 Feb 2018, Boris Ostrovsky wrote:
> On 02/02/2018 08:34 PM, Stefano Stabellini wrote:
> > When the client sends a regular blocking accept request, the backend is
> > expected to return only when the accept is completed, simulating a
> > blocking behavior, or return an error.
> > 
> > Specifically, on EAGAIN from inet_accept, the backend shouldn't return
> > "EAGAIN" to the client. Instead, it should simply continue the wait.
> > Otherwise, the client will send another accept request, which will cause
> > another EAGAIN to be sent back, which is a waste of resources and not
> > conforming to the expected behavior. Change the behavior by turning the
> > "goto error" into a return.
> > 
> > Signed-off-by: Stefano Stabellini <stefano@aporeto.com>
> 
> 
> I am looking at SYSCALL_DEFINE4(accept4) and sock->ops->accept (which *I
> think* is inet_accept, at least in some cases) passes all errors (including
> EAGAIN)  back to the caller. Is this a different case?

Hi Boris,

I didn't explain myself well. You are right that inet_accept passes all
errors back to the caller, but this is different: not only it would be a
waste of resources to do so, but the different behavior is specified in
the PVCalls spec:

"The backend will reply to the request only when a new connection is
successfully accepted, i.e. the backend does not return EAGAIN or
EWOULDBLOCK."

https://xenbits.xen.org/docs/unstable/misc/pvcalls.html

Look under the "Accept" sub-chapter.

Cheers,

Stefano
--8323329-1047736138-1517853694=:10160--
