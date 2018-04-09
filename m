Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754284AbeDIUxC (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 16:53:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:48552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752422AbeDIUxA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 16:53:00 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAC232183A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=robh@kernel.org
X-Google-Smtp-Source: AIpwx49vTRNFBIYHnMhW/i167x6ud6gF0fTRQRfHi+Bz8ufCXLxHofSlWtt6XptmTPcjJT2t2R9Z08mz6QlIyu7CFYY=
MIME-Version: 1.0
In-Reply-To: <20180409074604.17671-1-oohall@gmail.com>
References: <20180409074604.17671-1-oohall@gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Mon, 9 Apr 2018 15:52:38 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+ho2QhmNmPZMDJcfSxposJd=jYDvjhXH8cMAtVFP7n4A@mail.gmail.com>
Message-ID: <CAL_Jsq+ho2QhmNmPZMDJcfSxposJd=jYDvjhXH8cMAtVFP7n4A@mail.gmail.com>
Subject: Re: [PATCH] drivers/of: Introduce ARCH_HAS_OWN_OF_NUMA
To: "Oliver O'Halloran" <oohall@gmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>, linux-nvdimm@lists.01.org,
        devicetree@vger.kernel.org, sparclinux@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 9, 2018 at 2:46 AM, Oliver O'Halloran <oohall@gmail.com> wrote:
> Some OF platforms (pseries and some SPARC systems) has their own
> implementations of NUMA affinity detection rather than using the generic
> OF_NUMA driver, which mainly exists for arm64. For other platforms one
> of two fallbacks provided by the base OF driver are used depending on
> CONFIG_NUMA.
>
> In the CONFIG_NUMA=n case the fallback is an inline function in of.h.
> In the =y case the fallback is a real function which is defined as a
> weak symbol so that it may be overwritten by the architecture if desired.
>
> The problem with this arrangement is that the real implementations all
> export of_node_to_nid(). Unfortunately it's not possible to export the
> fallback since it would clash with the non-weak version. As a result
> we get build failures when:
>
> a) CONFIG_NUMA=y && CONFIG_OF=y, and
> b) The platform doesn't implement of_node_to_nid(), and
> c) A module uses of_node_to_nid()
>
> Given b) will be true for most platforms this is fairly easy to hit
> and has been observed on ia64 and x86.

How specifically do we hit this? The only module I see using
of_node_to_nid in mainline is Cell EDAC driver.

> This patch remedies the problem by introducing the ARCH_HAS_OWN_OF_NUMA
> Kconfig option which is selected if an architecture provides an
> implementation of of_node_to_nid(). If a platform does not use it's own,
> or the generic OF_NUMA, then always use the inline fallback in of.h so
> we don't need to futz around with exports.

I'm more inclined to figure out how to remove the export and provide a
non DT specific function if drivers need to know this.

Rob
