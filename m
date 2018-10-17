Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1888ECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 16:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B455B2150D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 16:19:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QDWbmzLv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B455B2150D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbeJRAPh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 20:15:37 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34714 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727051AbeJRAPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 20:15:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=VI1Qdbwi/o19MQVRo5sVTBsked/3pxY1dx0t2OlCEUE=; b=QDWbmzLvrDflgKfLjoMNAauO2
        g/91upaqaq+8/FrY+ZbNtjjcK71QaK+Az8AnHvSHRhwXQkdRg4g+MWltrhfuC4xIbRU6cgeKIzQT4
        mA4+vtJWrROSO60LOE3ENACZ8sQE+VRBouw8ALg6W16tisWZ3IrX73bndBtRgxn52NFZzdMXdQoqi
        fcyWma7GXjJZBBap4oy2K2xKfcSlVdAa0UUDpn+R0gV4mXpRXAXEsbcK2dEC70t4YLzCGv3iczBf1
        u2t22vcvwmThSyOi2UdjOJ3hXydbvjY0HYJlMUgA1vWDwkzEO77ggT22tPH4FwFIth1c8sE5IwjMi
        CyYJQE3RQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gCoXL-0001P8-4k; Wed, 17 Oct 2018 16:19:07 +0000
Date:   Wed, 17 Oct 2018 09:19:06 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Daniel Colascione <dancol@google.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kernel-team@android.com, John Reck <jreck@google.com>,
        John Stultz <john.stultz@linaro.org>,
        Todd Kjos <tkjos@google.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Jeff Layton <jlayton@kernel.org>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm <linux-mm@kvack.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Minchan Kim <minchan@google.com>, Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH v2 1/2] mm: Add an F_SEAL_FS_WRITE seal to memfd
Message-ID: <20181017161906.GA5096@infradead.org>
References: <20181009222042.9781-1-joel@joelfernandes.org>
 <20181017095155.GA354@infradead.org>
 <20181017103958.GB230639@joelaf.mtv.corp.google.com>
 <20181017120829.GA19731@infradead.org>
 <CAKOZuesr_8vrob-XfEpGmyeKFEhWWXZo4BEC0PixfjT2ibaRZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKOZuesr_8vrob-XfEpGmyeKFEhWWXZo4BEC0PixfjT2ibaRZQ@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 08:44:01AM -0700, Daniel Colascione wrote:
> > Even if no one changes these specific flags we still need a lock due
> > to rmw cycles on the field.  For example fadvise can set or clear
> > FMODE_RANDOM.  It seems to use file->f_lock for synchronization.
> 
> Compare-and-exchange will suffice, right?

Only if all users use the compare and exchange, and right now they
don't.
