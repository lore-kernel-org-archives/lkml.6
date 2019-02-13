Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B620C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 07:32:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 363F2222C7
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 07:32:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Yj9LduyX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387898AbfBMHcl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 02:32:41 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:42017 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729911AbfBMHcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 02:32:41 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id B3AEF21B55;
        Wed, 13 Feb 2019 02:32:40 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 13 Feb 2019 02:32:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=+/C6EaNfq8gXsgMCYQEEr71KXJaPBdUxGSd0IfnMF
        lg=; b=Yj9LduyXHslYA/Z15hx4F+BD9rpMYQe0GyOUczRGa0oq4CiMjFVoxHNeR
        iRBfQ+PkL085aBsS5OQA6H7iWl+Hf3WNeV3HYtIyefbIsrFhF1cjCoNIwLTOOf91
        V+N7wTMT2jJpy3vMqYEJM4FOX0t5u2reM4tUSqpizWoTLLLhZxcYIT5gY7ESWnp7
        hYgUFaqSzokVqZMHSrD6YfTLukZl53sl5aOwHaXS8qSj2xNKYz2oAq9EFRttLRHO
        MNpo5drdyFeDvRm64RnR7GxvpmzT1KVtQuwKIDxgq7im7oYvW41uniiH8pdnrSAx
        aWp65UCyad2yJC9zrLOK5ejloPScg==
X-ME-Sender: <xms:F8hjXJE1YfvwsBLDsCIcm8h3CsRZBFToz8djiyugQUWt0ov4QBjTYg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedtledruddtvddgudduudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfhuthenuceurghilhhouhhtmecu
    fedttdenucenucfjughrpefuvfhfhffkffgfgggjtgfgsehtjeertddtfeejnecuhfhroh
    hmpefrvghkkhgrucfgnhgsvghrghcuoehpvghnsggvrhhgsehikhhirdhfiheqnecukfhp
    peekledrvdejrdeffedrudejfeenucfrrghrrghmpehmrghilhhfrhhomhepphgvnhgsvg
    hrghesihhkihdrfhhinecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:F8hjXDCY4J0KLplMsgbReh1ul9H7rh2QsBr8v-8QvME3L9v3em1g7A>
    <xmx:F8hjXLZUilAPAMEFyP3qvI8cmDOyzpSWosbtbJnKWrDDOQuG26PvWg>
    <xmx:F8hjXDPSiYl7tKrgZgKflPCeUVhDaQC-5Mh0bh9PSLKBlb42PEcL5w>
    <xmx:GMhjXKWLRqKKSKgsQEXUAQaZd0uaXfHLh3j2TrwoNQfxWHB-X1n7mw>
Received: from Pekka-MacBook.local (89-27-33-173.bb.dnainternet.fi [89.27.33.173])
        by mail.messagingengine.com (Postfix) with ESMTPA id 91A47E412E;
        Wed, 13 Feb 2019 02:32:37 -0500 (EST)
Subject: Re: [PATCH] slub: untag object before slab end
To:     Qian Cai <cai@lca.pw>, akpm@linux-foundation.org, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com
Cc:     andreyknvl@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20190213020550.82453-1-cai@lca.pw>
From:   Pekka Enberg <penberg@iki.fi>
Message-ID: <eeac3e54-c31a-a583-b185-b2d36d7debed@iki.fi>
Date:   Wed, 13 Feb 2019 09:32:32 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:60.0)
 Gecko/20100101 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190213020550.82453-1-cai@lca.pw>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13/02/2019 4.05, Qian Cai wrote:
> get_freepointer() could return NULL if there is no more free objects in
> the slab. However, it could return a tagged pointer (like
> 0x2200000000000000) with KASAN_SW_TAGS which would escape the NULL
> object checking in check_valid_pointer() and trigger errors below, so
> untag the object before checking for a NULL object there.

Reviewed-by: Pekka Enberg <penberg@kernel.org>
