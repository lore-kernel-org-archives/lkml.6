Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63532C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 17:34:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28BB72075E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 17:34:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28BB72075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=opteya.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727711AbeIEWF7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 18:05:59 -0400
Received: from ou.quest-ce.net ([195.154.187.82]:42229 "EHLO ou.quest-ce.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726497AbeIEWF6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 18:05:58 -0400
X-Greylist: delayed 1320 seconds by postgrey-1.27 at vger.kernel.org; Wed, 05 Sep 2018 18:05:56 EDT
Received: from [37.169.125.128] (helo=test.quest-ce.net)
        by ou.quest-ce.net with esmtpsa (TLS1.1:RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <ydroneaud@opteya.com>)
        id 1fxbgY-000DnC-H1; Wed, 05 Sep 2018 19:33:46 +0200
Message-ID: <a1efae8d26cc5b73b180e9521d6b62590c55aa86.camel@opteya.com>
From:   Yann Droneaud <ydroneaud@opteya.com>
To:     Greg KH <greg@kroah.com>, David Howells <dhowells@redhat.com>
Cc:     linux-api@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>,
        dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        keyrings@vger.kernel.org, David Airlie <airlied@linux.ie>,
        linux-nilfs@vger.kernel.org, linux-nvdimm@lists.01.org,
        "Michael S. Tsirkin" <mst@redhat.com>, codalist@coda.cs.cmu.edu,
        coda@cs.cmu.edu, coreteam@netfilter.org,
        Rob Clark <robdclark@gmail.com>, linux-arm-msm@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Takashi Iwai <tiwai@suse.com>, linux-bcache@vger.kernel.org,
        Coly Li <colyli@suse.de>, Jaroslav Kysela <perex@perex.cz>,
        Jan Harkes <jaharkes@cs.cmu.edu>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Ryusuke Konishi <konishi.ryusuke@lab.ntt.co.jp>,
        Jason Wang <jasowang@redhat.com>,
        Mat Martineau <mathew.j.martineau@linux.intel.com>,
        netfilter-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        moderated for non-subscribers <alsa-devel@alsa-project.org>,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date:   Wed, 05 Sep 2018 19:33:38 +0200
In-Reply-To: <20180905165552.GB25206@kroah.com>
References: <153616286704.23468.584491117180383924.stgit@warthog.procyon.org.uk>
         <20180905165552.GB25206@kroah.com>
Organization: OPTEYA
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 37.169.125.128
X-SA-Exim-Mail-From: ydroneaud@opteya.com
Subject: Re: [RFC] UAPI: Check headers by compiling all together as C++
X-SA-Exim-Version: 4.2.1 (built Mon, 26 Dec 2011 16:24:06 +0000)
X-SA-Exim-Scanned: Yes (on ou.quest-ce.net)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le mercredi 05 septembre 2018 à 18:55 +0200, Greg KH a écrit :
> On Wed, Sep 05, 2018 at 04:54:27PM +0100, David Howells wrote:
> > 
> > Here's a set of patches that inserts a step into the build process to make
> > sure that the UAPI headers can all be built together with C++ (if the
> > compiler being used supports C++).  All but the final patch perform fixups,
> > including:
> 
> Wait, why do we care?  What has recently changed to start to directly
> import kernel uapi files into C++ code?
> 
> And if userspace wants to do this, can't they do the C namespace trick
> themselves when they do the import?  That must be how they are doing it
> today, right?
> 

They can't.


Adding extern "C" { } doesn't magically make "class" a non keyword.
Even if it was the case, writing C++ code using whatever->class would
probably broke because class is a keyword in C++.

-- 
Yann Droneaud
OPTEYA


