Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753313AbeAaVnc (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 16:43:32 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:43862 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752098AbeAaVna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 16:43:30 -0500
X-Google-Smtp-Source: AH8x227bst94a37z3xzLs5or6xCWhaxqKTdxBCV2mLsBZ+85NIV5kpgYR2mqa/dK4KtdvV2JBx5VwA==
Subject: Re: [PATCH] of: cache phandle nodes to decrease cost of
 of_find_node_by_phandle()
From: Frank Rowand <frowand.list@gmail.com>
To: Rob Herring <robh+dt@kernel.org>, cpandya@codeaurora.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1517429142-25727-1-git-send-email-frowand.list@gmail.com>
Message-ID: <5dd35d8f-c430-237e-9863-2e73556f92ec@gmail.com>
Date: Wed, 31 Jan 2018 13:43:27 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1517429142-25727-1-git-send-email-frowand.list@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/31/18 12:05, frowand.list@gmail.com wrote:
> From: Frank Rowand <frank.rowand@sony.com>
> 
> Create a cache of the nodes that contain a phandle property.  Use this
> cache to find the node for a given phandle value instead of scanning
> the devicetree to find the node.  If the phandle value is not found
> in the cache, of_find_node_by_phandle() will fall back to the tree
> scan algorithm.
> 
> The cache is initialized in of_core_init().
> 
> The cache is freed via a late_initcall_sync().
> 
> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
> ---
> 
> Some of_find_by_phandle() calls may occur before the cache is
> initialized or after it is freed.  For example, for the qualcomm
> qcom-apq8074-dragonboard, 11 calls occur before the initialization
> and 80 occur after the cache is freed (out of 516 total calls.)
> 
> 
>  drivers/of/base.c       | 85 ++++++++++++++++++++++++++++++++++++++++++++++---
>  drivers/of/of_private.h |  5 +++
>  drivers/of/resolver.c   | 21 ------------
>  3 files changed, 86 insertions(+), 25 deletions(-)

Some observations....

The size of the cache for a normal device tree would be a couple of
words of overhead for the cache, plus one pointer per devicetree node
that contains a phandle property.  This will be less space than
would be used by adding a hash field to each device node.  It is
also less space than was used by the older algorithm (long gone)
that added a linked list through the nodes that contained a
phandle property.

This is assuming that the values of the phandle properties are
the default ones created by the dtc compiler.  In the case
where a very large phandle property value is hand-coded in
a devicetree source, the size of the cache is capped at one
entry per node.  In this case, a little bit of space will be
wasted -- but this is just a sanity fallback, it should not
be encountered, and can be fixed by fixing the devicetree
source.
