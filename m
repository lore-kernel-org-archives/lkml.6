Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C645C476E8
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 16:56:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4C9520864
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 16:56:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VOTxOErV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4C9520864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732443AbeGLRGk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 13:06:40 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43474 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726925AbeGLRGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 13:06:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Ezivkyy8DR9jRLwZAdh5OgweEpGw7Q6hWS2sAOWJCPY=; b=VOTxOErVvIOAHF1j8dc82gob9
        Nhgy47DdV0U8UU7DXT0TNRwv2S7QfIJjIJcoa1/WboEsxX45kArv+mvlEZJFz5nkbHymOX3RAOzHx
        6f6EQjQXuD02Ke49SJp9089OIdzVRnzumlmh0DwFNanB/sUOpQbNDQimfx32g0AQ8kYAI4GyeZYme
        kgJc+BcdRXgsjGGWVI+/I5fJJwe2aJjsGWBLgh6foedG7/S0/YdUHYxWs0ajh/wNMB7aIOuK1eSYQ
        O2lQCvfURicxL5w0Zf54ZPwK77WMcMj8UPeZfDFQ1YYRY607eOg5d9+87TdwlK4aT4fTxbWksQgjd
        ojtn3dEpA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fdesv-0001ZN-7E; Thu, 12 Jul 2018 16:56:05 +0000
Date:   Thu, 12 Jul 2018 09:56:05 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Jonathan Corbet <corbet@lwn.net>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-doc@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jan Kara <jack@suse.cz>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Larry Woodman <lwoodman@redhat.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        "Wangkai (Kevin C)" <wangkai86@huawei.com>,
        Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH v7 3/6] fs/dcache: Add sysctl parameter neg-dentry-limit
 as a soft limit on negative dentries
Message-ID: <20180712165605.GB3475@bombadil.infradead.org>
References: <1531413965-5401-1-git-send-email-longman@redhat.com>
 <1531413965-5401-4-git-send-email-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531413965-5401-4-git-send-email-longman@redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 12:46:02PM -0400, Waiman Long wrote:
> +int neg_dentry_limit;
> +EXPORT_SYMBOL_GPL(neg_dentry_limit);

Why are you exporting it?  What module needs this?
