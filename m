Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B42EEC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 21:27:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68564206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 21:27:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="n6m8hFzq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68564206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730527AbeKVIDH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 03:03:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:47570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726791AbeKVIDH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 03:03:07 -0500
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 05812204FD;
        Wed, 21 Nov 2018 21:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542835623;
        bh=gSL/H5c9xKKDOSMUwcppq1BCKMWh0ATl6JTwoKzpTr4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n6m8hFzqde83KBTpBqwf2n4AvqYJqi44jq9D4PMC/nXL/pW7SNl4oPC+OhHBL5gr1
         aFV8uZsP2nTWM/PGmg7izirv/Bf9m0svJXVqTZc9bYAAm5F3fvNokwuqwmek6LjREJ
         WK6o+U+Oc+GdrRwonVovR/iIWknVX5jVh2MWIwLM=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id A1C191443D9; Wed, 21 Nov 2018 18:26:59 -0300 (-03)
Date:   Wed, 21 Nov 2018 18:26:59 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Eric Saint-Etienne <eric.saint.etienne@oracle.com>
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.co>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Shaggy <dave.kleikamp@oracle.com>,
        David Aldridge <david.j.aldridge@oracle.com>,
        Rob Gardner <rob.gardner@oracle.com>,
        Eric Saint-Etienne <eric.saintetienne@gmail.com>
Subject: Re: [PATCH] perf symbols: fix slowness due to -ffunction-section
Message-ID: <20181121212659.GA3067@kernel.org>
References: <1542822679-25591-1-git-send-email-eric.saint.etienne@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1542822679-25591-1-git-send-email-eric.saint.etienne@oracle.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Nov 21, 2018 at 09:51:19AM -0800, Eric Saint-Etienne escreveu:
> Perf can take minutes to parse an image when -ffunction-section is used.
> This is especially true with the kernel image when it is compiled this way,
> which is the arm64 default since the patcheset "Enable deadcode elimination
> at link time".
> 
> Perf organize maps using a rbtree. Whenever perf finds a new symbols, it
> first searches this rbtree for the map it belongs to, by strcmp()'aring
> section names.  When it finds the map with the right name, it uses it to
> add the symbol. With a usual image there aren't so many maps but when using
> -ffunction-section there's basically one map per function.
> With the kernel image that's north of 40,000 maps. For most symbols perf
> has to parses the entire rbtree to eventually create a new map and add it.
> Consequently perf spends most of the time browsing a rbtree that keeps
> getting larger.
> 
> This performance fix introduces a secondary rbtree that indexes maps based
> on the section name.
> 
> Signed-off-by: Eric Saint-Etienne <eric.saint.etienne@oracle.com>
> Reviewed-by: Dave Kleikamp <dave.kleikamp@oracle.com>
> Reviewed-by: David Aldridge <david.aldridge@oracle.com>
> Reviewed-by: Rob Gardner <rob.gardner@oracle.com>

Looks sane, thanks to the multiple reviewers, really appreciated,

Applied.

- Arnaldo
