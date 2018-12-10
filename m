Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B15BDC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 20:08:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B26C2082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 20:08:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B26C2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729788AbeLJUIq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 15:08:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40288 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727146AbeLJUIq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 15:08:46 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 97229811DC;
        Mon, 10 Dec 2018 20:08:45 +0000 (UTC)
Received: from localhost (ovpn-116-63.gru2.redhat.com [10.97.116.63])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1B5D060BF1;
        Mon, 10 Dec 2018 20:08:44 +0000 (UTC)
Date:   Mon, 10 Dec 2018 18:08:43 -0200
From:   Eduardo Habkost <ehabkost@redhat.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?iso-8859-1?Q?J=F6rg_R=F6del?= <joro@8bytes.org>,
        Andre Przywara <andre.przywara@arm.com>,
        kvm ML <kvm@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Daniel P. Berrange" <berrange@redhat.com>,
        Eric Blake <eblake@redhat.com>
Subject: Re: kvm: RDTSCP on AMD
Message-ID: <20181210200843.GN4669@habkost.net>
References: <20181210181328.GA762@zn.tnic>
 <20181210183730.GJ4669@habkost.net>
 <20181210184153.GB5482@zn.tnic>
 <20181210190600.GK4669@habkost.net>
 <20181210194258.GD5482@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181210194258.GD5482@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Mon, 10 Dec 2018 20:08:45 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 10, 2018 at 08:42:58PM +0100, Borislav Petkov wrote:
> On Mon, Dec 10, 2018 at 05:06:00PM -0200, Eduardo Habkost wrote:
> > I mean documenting it.  We already have code that will print
> > warnings if a feature isn't available.
> > 
> > See my previous attempt to document the minimum kernel version
> > at <https://www.mail-archive.com/qemu-devel@nongnu.org/msg486559.html>.
> 
> Something like this?
> 
> I still have no clue how to add RDTSCP on pc-*-4.0 and newer.

qemu.git master have no PC_COMPAT_3_1 and pc-*-4.0 machine-types
yet.  I've sent another reply with additional pointers.

> 
> Thx.
> 
> ---
> diff --git a/qemu-doc.texi b/qemu-doc.texi
> index f7ad1dfe4b69..913b2ef68d54 100644
> --- a/qemu-doc.texi
> +++ b/qemu-doc.texi
> @@ -37,6 +37,7 @@
>  * QEMU System emulator for non PC targets::
>  * QEMU Guest Agent::
>  * QEMU User space emulator::
> +* System requirements::
>  * Implementation notes::
>  * Deprecated features::
>  * Supported build platforms::
> @@ -2813,6 +2814,13 @@ Act as if the host page size was 'pagesize' bytes
>  Run the emulation in single step mode.
>  @end table
>  
> +@node System requirements
> +@chapter System requirements
> +
> +@section KVM kernel module
> +
> +On x86_64 hosts, the default set of CPU features enabled by the KVM accelerator
> +require the host to be running Linux v4.5 or newer.
>  

Sounds good, but it would be nice to document what exactly makes
Linux 4.5+ necessary.  e.g.:

| On x86_64 hosts, it is recommended to run Linux 4.5 or newer on
| the host when using the KVM accelerator.
| 
| The Opteron_G2, OpteronG3, Opteron_G4, and Opteron_G5 CPU
| models require KVM support for RDTSCP, which was added on
| Linux 4.5.

I'm CCing some people who may help review English grammar and
style.

-- 
Eduardo
