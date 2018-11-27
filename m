Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FREEMAIL_REPLYTO_END_DIGIT,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64F40C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 09:10:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ADAE208E7
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 09:10:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="HuGOIGk4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2ADAE208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730042AbeK0UHP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 15:07:15 -0500
Received: from m12-17.163.com ([220.181.12.17]:47411 "EHLO m12-17.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729710AbeK0UHO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 15:07:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Message-ID:MIME-Version; bh=e+Sga
        RuchEamvc2B0Ens4lpXjRc1+x4osTlly3rXMa8=; b=HuGOIGk4rWNCjrFgQfbBu
        t9/CtIjq+TXlsMWihthz6xKM730NUKD2CQEnxgU01s25CfRPMo6z2+NTgiGWlmJo
        X75YpuzfBW6t40drqXDioFyu/rYA4BghIDmzg8KcFK9CWPXw+s/AYgHAmQIJjJtu
        ZYFUIqbZg9XIigbJf3CKHI=
Received: from bp (unknown [106.120.213.96])
        by smtp13 (Coremail) with SMTP id EcCowAA3kWzeCf1biNVEBw--.39431S2;
        Tue, 27 Nov 2018 17:09:50 +0800 (CST)
Date:   Tue, 27 Nov 2018 17:09:52 +0800
From:   PanBian <bianpan2016@163.com>
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc:     Ilya Dryomov <idryomov@gmail.com>, "Yan, Zheng" <zyan@redhat.com>,
        Sage Weil <sage@redhat.com>, DavidS.Miller@bp,
        ceph-devel@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] libceph: fix use after free
Message-ID: <20181127090952.GA23643@bp>
Reply-To: PanBian <bianpan2016@163.com>
References: <1543302127-14435-1-git-send-email-bianpan2016@163.com>
 <54c1bcc5-6df5-ba24-2774-98f6333c57b3@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54c1bcc5-6df5-ba24-2774-98f6333c57b3@cogentembedded.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-CM-TRANSID: EcCowAA3kWzeCf1biNVEBw--.39431S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Gw4xXr4UXw15Kry8Kw47XFb_yoW3JFg_ua
        yvyrn2kw4I9a13A3W7GrZxZrs7Wa4xuF13KrykGrZ3Z34rXFZ8uwnF9w1rZ34fGFsrZrsx
        uF4Ygay5JryIvjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUeqYLDUUUUU==
X-Originating-IP: [106.120.213.96]
X-CM-SenderInfo: held01tdqsiiqw6rljoofrz/1tbiVAoMclUMGLSKQwAAsc
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27, 2018 at 11:47:56AM +0300, Sergei Shtylyov wrote:
> Hello!
> 
> On 27.11.2018 10:02, Pan Bian wrote:
> 
> >The function ceph_monc_handle_map calls kfree(old) to free the old
> >monitor map, old points to monc->monmap. However, after that, it reads
> >monc->monmap->epoch and passes it to __ceph_monc_got_map. This result in
> >a use-after-free bug. The patch moves the free operation after the call
> >to __ceph_monc_got_map.
> >
> >Fixes: 82dcabad750("libceph: revamp subs code, switch to SUBSCRIBE2
> 
>    Space needed before (.
> 
> >protocol")
> 
>    Never break up the commit summary in this tag.

Thanks for the guidance, I will correct it.

> 
> >Signed-off-by: Pan Bian <bianpan2016@163.com>
> [...]
> 
> MBR, Sergei

