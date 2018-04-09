Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753499AbeDIRtV (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 13:49:21 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48938 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751942AbeDIRtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 13:49:19 -0400
Date: Mon, 9 Apr 2018 10:49:18 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Oliver O'Halloran" <oohall@gmail.com>
Cc: linux-kernel@vger.kernel.org, sfr@canb.auug.org.au,
        devicetree@vger.kernel.org, linux-nvdimm@lists.01.org,
        sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] drivers/of: Introduce ARCH_HAS_OWN_OF_NUMA
Message-ID: <20180409174918.GA4629@infradead.org>
References: <20180409074604.17671-1-oohall@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180409074604.17671-1-oohall@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 09, 2018 at 05:46:04PM +1000, Oliver O'Halloran wrote:
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
> 
> This patch remedies the problem by introducing the ARCH_HAS_OWN_OF_NUMA
> Kconfig option which is selected if an architecture provides an
> implementation of of_node_to_nid(). If a platform does not use it's own,
> or the generic OF_NUMA, then always use the inline fallback in of.h so
> we don't need to futz around with exports.

I'd rather have a specific kconfig symbol for the 'generic'
implementation, especially given that it doesn't appear to be all
that generic.
