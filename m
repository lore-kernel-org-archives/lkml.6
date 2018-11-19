Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8952AC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 10:02:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A45320831
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 10:02:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A45320831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727727AbeKSU0E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 15:26:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44068 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726287AbeKSU0E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 15:26:04 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 91DBA3081247;
        Mon, 19 Nov 2018 10:02:56 +0000 (UTC)
Received: from gondolin (ovpn-116-165.ams2.redhat.com [10.36.116.165])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 21C9360139;
        Mon, 19 Nov 2018 10:02:50 +0000 (UTC)
Date:   Mon, 19 Nov 2018 11:02:48 +0100
From:   Cornelia Huck <cohuck@redhat.com>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        christian.ehrhardt@canonical.com, eric.auger@redhat.com
Subject: Re: [PATCH v2] vfio/pci: Parallelize device open and release
Message-ID: <20181119110248.68214069.cohuck@redhat.com>
In-Reply-To: <154238501981.17682.10484940408205923021.stgit@gimli.home>
References: <154238501981.17682.10484940408205923021.stgit@gimli.home>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Mon, 19 Nov 2018 10:02:56 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Nov 2018 09:18:41 -0700
Alex Williamson <alex.williamson@redhat.com> wrote:

> In commit 61d792562b53 ("vfio-pci: Use mutex around open, release, and
> remove") a mutex was added to freeze the refcnt for a device so that
> we can handle errors and perform bus resets on final close.  However,
> bus resets can be rather slow and a global mutex here is undesirable.
> Evaluating the potential locking granularity, a per-device mutex
> provides the best resolution but with multiple devices on a bus all
> released concurrently, they'll race to acquire each other's mutex,
> likely resulting in no reset at all if we use trylock.  We therefore
> lock at the granularity of the bus/slot reset as we're only attempting
> a single reset for this group of devices anyway.  This allows much
> greater scaling as we're bounded in the number of devices protected by
> a single reflck object.
> 
> Reported-by: Christian Ehrhardt <christian.ehrhardt@canonical.com>
> Tested-by: Christian Ehrhardt <christian.ehrhardt@canonical.com>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> ---
> 
> v2:
>  - Rolled in PTR_ERR_OR_ZERO suggestion from kbuild bot
>  - Updated commit log and comments per Eric's feedback
> 
>  drivers/vfio/pci/vfio_pci.c         |  160 ++++++++++++++++++++++++++++++-----
>  drivers/vfio/pci/vfio_pci_private.h |    6 +
>  2 files changed, 142 insertions(+), 24 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
