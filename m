Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54470C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 07:08:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19E762084D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 07:08:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19E762084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728277AbeJEOGL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 10:06:11 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43836 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727185AbeJEOGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 10:06:11 -0400
Received: by mail-wr1-f66.google.com with SMTP id n1-v6so12376694wrt.10;
        Fri, 05 Oct 2018 00:08:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KqQzeVZYtmVkFZOaqknZA3xIVwZZa1gZvkCWFceOmmo=;
        b=P9AilerVlUnyyyk4PxFKbC0mXXlTegC4DXmvKQpFT2zob+AuRYqU5aWXJMbVerUv0E
         IUFae/0/v49P5Pcir35f4BrnAz2p3+OLoxwUBH3JWm8TG1Db4jISEK+NnEwvZSoW9woa
         qpgw8kD6TR4PZFobw2IV3E/4eBrqtWhBFyLrOy/T7Vqrl/05hmtRjx4SGevsiznd9Lbg
         LCRJC+1VJ8O7RWCqiclYK4CJoUQi6EF0y3d2r6gUmmgqgqr7uePEIZT/KHPLlFSQP/jp
         kzirPlmHkGlWbwL1GStmf4f3X5/VfTVqmq8pAyyiooyKtiEj3IK4GAGPuE5PSb3haYUm
         gKcA==
X-Gm-Message-State: ABuFfoh0Sc5mIx/FFDzB6QAph7it5riivu9nN3QQLM6/++pFcd1v8NBt
        ldyc+1Wh/j2LKKgDu6YDixY=
X-Google-Smtp-Source: ACcGV616tnx56WJhiIzmz9oIWdZhcimyd3YS7JE3nmf5t+adonBlGtww9uMP29FazXKwUQBOXjm+cg==
X-Received: by 2002:adf:dd4c:: with SMTP id u12-v6mr6959548wrm.2.1538723328611;
        Fri, 05 Oct 2018 00:08:48 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id r134-v6sm1172743wmg.9.2018.10.05.00.08.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Oct 2018 00:08:47 -0700 (PDT)
Received: by techadventures.net (Postfix, from userid 1000)
        id 53B0D125824; Fri,  5 Oct 2018 09:08:47 +0200 (CEST)
Date:   Fri, 5 Oct 2018 09:08:47 +0200
From:   Oscar Salvador <osalvador@techadventures.net>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-acpi@vger.kernel.org, xen-devel@lists.xenproject.org,
        devel@linuxdriverproject.org, Jonathan Corbet <corbet@lwn.net>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3 6/6] memory-hotplug.txt: Add some details about
 locking internals
Message-ID: <20181005070847.GB27754@techadventures.net>
References: <20180927092554.13567-1-david@redhat.com>
 <20180927092554.13567-7-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180927092554.13567-7-david@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 11:25:54AM +0200, David Hildenbrand wrote:
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Reviewed-by: Pavel Tatashin <pavel.tatashin@microsoft.com>
> Reviewed-by: Rashmica Gupta <rashmica.g@gmail.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Oscar Salvador <osalvador@suse.de>

-- 
Oscar Salvador
SUSE L3
