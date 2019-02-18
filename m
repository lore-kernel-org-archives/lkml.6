Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F5E0C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 18:01:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BA7B21736
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 18:01:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391803AbfBRSBq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 13:01:46 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:35642 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389649AbfBRSBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 13:01:45 -0500
Received: by mail-qk1-f196.google.com with SMTP id w204so10505653qka.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 10:01:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=n+lUg0FjYKjVVNOiBok5yuGwwfOjuaZM6OCfyQUBVQU=;
        b=U6g5U+HhqHa1d4/Z3CEe0eiQ5hSCRFahP6/l8oCu3X006ZJ9QCuFjpcKDOC6SNA/Il
         C8faS8yD/u+BN18Xw+0pFR7GxaN0x2/mvIqTgYG1b+uOVjS1y7OZvsObSeTozAhfVKLG
         VIOIwGeptjNyRA8/MlQ6Slf6hUdxf+VjbNTNd8I6V4glkwHmsw6/MWxT36z0kRfrCcTd
         Zzln1l7rFAUs4xXjDDfSL7nELMoIGMtN/gbNK2orEi1+iY+5hd8wGtQa/QbKa7tjqPhd
         x7uiGPl77I8OtuFARF/0/zlet4Bd3L5Q92B06cJA1tuE6wOkZEyfbfKQkCw1LcEiR6tP
         BYkQ==
X-Gm-Message-State: AHQUAubKb/YlVNS7p18h7CgBWwnl6GNFhLeS7r7xxYcqrRuWjDeWyeXZ
        3LAtDyHJbTMlBUB3BeK0uY74WA==
X-Google-Smtp-Source: AHgI3IZTyy+MV/wZQfYIyq6KSc0oc0+h3xBl7Ogtr4q/u7Lm4aax6aNJccYgDytciZLV2ydkm/p3mg==
X-Received: by 2002:a37:80b:: with SMTP id 11mr17314698qki.131.1550512904816;
        Mon, 18 Feb 2019 10:01:44 -0800 (PST)
Received: from redhat.com (pool-173-76-246-42.bstnma.fios.verizon.net. [173.76.246.42])
        by smtp.gmail.com with ESMTPSA id z63sm7503030qkc.42.2019.02.18.10.01.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Feb 2019 10:01:43 -0800 (PST)
Date:   Mon, 18 Feb 2019 13:01:41 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Alexander Duyck <alexander.duyck@gmail.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Nitesh Narayan Lal <nitesh@redhat.com>,
        kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>, lcapitulino@redhat.com,
        pagupta@redhat.com, wei.w.wang@intel.com,
        Yang Zhang <yang.zhang.wz@gmail.com>,
        Rik van Riel <riel@surriel.com>, dodgen@google.com,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        dhildenb@redhat.com, Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [RFC][Patch v8 0/7] KVM: Guest Free Page Hinting
Message-ID: <20190218125552-mutt-send-email-mst@kernel.org>
References: <20190204201854.2328-1-nitesh@redhat.com>
 <af4430fd-0a2c-8f35-b767-3f93fc6db270@redhat.com>
 <20190218114601-mutt-send-email-mst@kernel.org>
 <44740a29-bb14-e6e6-2992-98d0ae58e994@redhat.com>
 <CAKgT0UcHv0S1-ZUpAZ9w=GTLRtG8=-cuoT3fa4Ej2A==aky5dg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKgT0UcHv0S1-ZUpAZ9w=GTLRtG8=-cuoT3fa4Ej2A==aky5dg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 18, 2019 at 09:31:13AM -0800, Alexander Duyck wrote:
> > Optimization of space comes with a price (here: execution time).
> 
> One thing to keep in mind though is that if you are already having to
> pull pages in and out of swap on the host in order be able to provide
> enough memory for the guests the free page hinting should be a
> significant win in terms of performance.

Absolutely and I think that's the point of the hinting right?
To cut out swap/IO on the host.

-- 
MST
