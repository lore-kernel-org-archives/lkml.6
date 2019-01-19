Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D7D0C61CE8
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 10:11:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB3522086A
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 10:11:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QvrCIKkY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727790AbfASKLY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 05:11:24 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:57296 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727716AbfASKLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 05:11:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Du82R+DEIpEf8ousaba7lveRYIKww7TofVK6LWT0DzE=; b=QvrCIKkYGaDGOC2AdmX/zObKU
        PzGTgoK5j3ZtqZJw8AnRvZYH2X098mRzQykl33hnN6DHXbMsZ8E44VVpXoQfrbZrkYC/xQ6nCOSnT
        Gtl8rs+OlN2beC0ZRZ9LuztJ55t9OqRqfiWmehY048vd1J8b41sdTpsUx55UdidMLI24RzL80K/8T
        xL3EKd2zzvUWvneRGYErkyVfkibrCkdw/ovGdHM0FC7JsV6lhvf9Fh4Bh9hIuZPfJqOZp2dMUFleh
        vVLTvk419VoDfvVBtItPbW2/95Pk+E7bMXmuuD6w5/0dmwOnwCswTAJQrSoPwp0073aVnHKoJQB7q
        +35FVlqPA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gknax-0001t8-2i; Sat, 19 Jan 2019 10:11:19 +0000
Date:   Sat, 19 Jan 2019 02:11:18 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Laura Abbott <labbott@redhat.com>
Cc:     "Andrew F. Davis" <afd@ti.com>, Liam Mark <lmark@codeaurora.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH 13/14] staging: android: ion: Do not sync CPU cache on
 map/unmap
Message-ID: <20190119101118.GA2127@infradead.org>
References: <20190111180523.27862-14-afd@ti.com>
 <alpine.DEB.2.10.1901140910130.23879@lmark-linux.qualcomm.com>
 <79eb70f6-00b0-2939-5ec9-65e196ab4987@ti.com>
 <alpine.DEB.2.10.1901150937280.4046@lmark-linux.qualcomm.com>
 <cfcd3daf-bd1d-0dbc-7b5c-8e504d179564@ti.com>
 <b6cb5596-6beb-73e0-0d8c-d9a13466d626@redhat.com>
 <99ca0b08-02bd-64fd-d43c-c330f0d11639@ti.com>
 <alpine.DEB.2.10.1901161441280.10666@lmark-linux.qualcomm.com>
 <7620534f-b749-76f9-0f53-f73e3f12e9a9@ti.com>
 <fd33986f-ec26-c028-32c2-19c8cc0aba15@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fd33986f-ec26-c028-32c2-19c8cc0aba15@redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2019 at 12:31:34PM -0800, Laura Abbott wrote:
> I thought about doing that, the problem is it becomes an ABI break for
> existing users which I really didn't want to do again. If it
> ends up being the last thing we do before moving out of staging,
> I'd consider doing it.

This is staging code, so any existing users by defintion do not matter.
Let's not drag Linux development down over this.
