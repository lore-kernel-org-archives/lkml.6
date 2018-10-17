Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE52BECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:38:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B17B62150F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:38:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="K3MxQ+T9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B17B62150F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727665AbeJQXee (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 19:34:34 -0400
Received: from a9-112.smtp-out.amazonses.com ([54.240.9.112]:40964 "EHLO
        a9-112.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727048AbeJQXee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 19:34:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ug7nbtf4gccmlpwj322ax3p6ow6yfsug; d=amazonses.com; t=1539790699;
        h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type:Feedback-ID;
        bh=kFeDuZF+WukdfWtOGS/vzeuUzjLlBoNKTmu0Zujw1SQ=;
        b=K3MxQ+T9o2WtwioM86fWIgB1JfMmDhoLHnm9tL7okDN1s847t2jyhVRtBKXa1phG
        /Ya9M5kk4MaTmJm9sFL/Jr3bnGfF6PyIdsIPZrCzsTxWfnBSX6ugeeTpj/cAwsksklD
        LGKRRf3A2UlvY//msD03hbnzlbzWYSJQ3eOc3OA8=
Date:   Wed, 17 Oct 2018 15:38:19 +0000
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To:     Vlastimil Babka <vbabka@suse.cz>
cc:     David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [patch] mm, slab: avoid high-order slab pages when it does not
 reduce waste
In-Reply-To: <8eaaa366-415a-5d72-7720-82468d853efd@suse.cz>
Message-ID: <0100016682ad79b9-b1dafb6b-98e2-4d43-835d-fded2028840d-000000@email.amazonses.com>
References: <alpine.DEB.2.21.1810121424420.116562@chino.kir.corp.google.com> <20181012151341.286cd91321cdda9b6bde4de9@linux-foundation.org> <0100016679e3c96f-c78df4e2-9ab8-48db-8796-271c4b439f16-000000@email.amazonses.com> <alpine.DEB.2.21.1810151715220.21338@chino.kir.corp.google.com>
 <010001667d7476a2-f91dcf12-5e90-4ade-97e8-9fd651f7bf17-000000@email.amazonses.com> <8eaaa366-415a-5d72-7720-82468d853efd@suse.cz>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-SES-Outgoing: 2018.10.17-54.240.9.112
Feedback-ID: 1.us-east-1.fQZZZ0Xtj2+TD7V5apTT/NrT6QKuPgzCT/IC7XYgDKI=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Oct 2018, Vlastimil Babka wrote:

> I.e. the benefits vs drawbacks of higher order allocations for SLAB are
> out of scope here. It would be nice if somebody evaluated them, but the
> potential resulting change would be much larger than what concerns this
> patch. But it would arguably also make SLAB more like SLUB, which you
> already questioned at some point...

Well if this leads to more code going into mm/slab_common.c then I would
certainly welcome that.

