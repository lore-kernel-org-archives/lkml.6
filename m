Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65AB6C41536
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 17:39:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3140420684
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 17:39:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Tv+IJpr8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3140420684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729298AbeKUEJf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 23:09:35 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:60860 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729143AbeKUEJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 23:09:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ObZd+2EAI/2J8E0S2Wv13fI9xuoKlVew8XcoQeC5j/4=; b=Tv+IJpr8CPpzFfehFjbBjdRb/
        OaKzzc0bj9mdT3kc2xzyXbwqCoReDDPX7rxId5rRqMcOAm5a0qNhlzWnQH4Mtgrj1Nw+8Fpj4KO3s
        bT7L4EsSPmS8LJTixx4khS4ErYT+StLQDyUAlQszY8+GQOMHurf3OC8j+gtXzyQZ4rsdzRq1h+Saa
        THqk3rJwYgXp2JnGm344LMXbNy3EL2H+WXTD/xt2IJE9ptOlb8LPAqdpG/KJeTz6Jca/PvMfbpaH0
        Q6aAQ+VPajLkbMMFVMurwZ6UWI6KwLaU+jpsWjNvtDdX9E4/xESOeMHXYP5GQc/HlVRlcykMEn61X
        JGLhNmnLA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gP9zU-0003Be-QJ; Tue, 20 Nov 2018 17:39:12 +0000
Date:   Tue, 20 Nov 2018 09:39:12 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Daniel Colascione <dancol@google.com>,
        linux-kernel@vger.kernel.org, rppt@linux.ibm.com,
        timmurray@google.com, joelaf@google.com, surenb@google.com,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>,
        Prashant Dhamdhere <pdhamdhe@redhat.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v2] Document /proc/pid PID reuse behavior
Message-ID: <20181120173912.GD3065@bombadil.infradead.org>
References: <20181031150625.147369-1-dancol@google.com>
 <20181105132205.138695-1-dancol@google.com>
 <20181119105426.GD28607@amd>
 <1c5caa66-3c61-cb57-754a-f099200c73b2@suse.cz>
 <20181120091829.GD16916@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181120091829.GD16916@amd>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2018 at 10:18:29AM +0100, Pavel Machek wrote:
> > would ever rely on the pid being reused while having the descriptor
> > open. How would that make sense?
> 
> I agree this is corner space, but users might be surprised that
> keeping FDs of /proc/pid/X would lead to PID space exhaustion, for
> example.

We have a limit on the number of FDs a process can have open for a reason.
Well, for many reasons.

