Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id Z0HRCT7kGVuoWQAAmS7hNA
	; Fri, 08 Jun 2018 02:04:51 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id AF7CC608C1; Fri,  8 Jun 2018 02:04:51 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 3A1A0606DD;
	Fri,  8 Jun 2018 02:04:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3A1A0606DD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752443AbeFHCEs (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 22:04:48 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44426 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752268AbeFHCEq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 22:04:46 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5AA2640200A0;
        Fri,  8 Jun 2018 02:04:46 +0000 (UTC)
Received: from localhost (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B0BA92026DEF;
        Fri,  8 Jun 2018 02:04:44 +0000 (UTC)
Date: Fri, 8 Jun 2018 10:04:41 +0800
From: Baoquan He <bhe@redhat.com>
To: Christopher Lameter <cl@linux.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org
Subject: Re: [PATCH] slab: Clean up the code comment in slab kmem_cache struct
Message-ID: <20180608020441.GA16231@MiWiFi-R3L-srv>
References: <20180603032402.27526-1-bhe@redhat.com>
 <01000163d0e8083c-096b06d6-7202-4ce2-b41c-0f33784afcda-000000@email.amazonses.com>
 <20180606012624.GA19425@MiWiFi-R3L-srv>
 <01000163d7803909-286c20d2-9928-4e07-94fc-ee6552e04c67-000000@email.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01000163d7803909-286c20d2-9928-4e07-94fc-ee6552e04c67-000000@email.amazonses.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Fri, 08 Jun 2018 02:04:46 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Fri, 08 Jun 2018 02:04:46 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'bhe@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/06/18 at 11:48pm, Christopher Lameter wrote:
> On Wed, 6 Jun 2018, Baoquan He wrote:
> 
> > I am back porting Thomas's sl[a|u]b freelist randomization feature to
> > our distros, need go through slab code for better understanding. From
> > git log history, they were 'obj_offset' and 'obj_size'. Later on
> > 'obj_size' was renamed to 'object_size' in commit 3b0efdfa1e("mm, sl[aou]b:
> > Extract common fields from struct kmem_cache") which is from your patch.
> > With my understanding, I guess you changed that on purpose because
> > object_size is size of each object, obj_offset is for the whole cache,
> > representing the offset the real object starts to be stored. And putting
> > them separately is for better desribing them in code comment and
> > distinction, e.g 'object_size' is in "4) cache creation/removal",
> > while 'obj_offset' is put alone to indicate it's for the whole.
> 
> obj_offset only applies when CONFIG_SLAB_DEBUG is set. Ok so that screwy
> name also indicates that something special goes on.

They are a little confusing when combine SLAB with SLUB, 

SLAB			SLUB
size                    size
object_size             object_size
obj_offset              offset

object_size also only applies when CONFIG_SLAB_DEBUG is set,
otherwise it's equal to size in SLAB case. Whereas SLUB always has
object plus freeptr for each object space.

Thought to add code comment to make them clearer, on second thought,
anyone who want to understand slab/slub code well, has to go through the
whole header file and souce code, this pain need be borne.
