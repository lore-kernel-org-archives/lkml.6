Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id AF338C07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 09:58:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C7E72087E
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 09:58:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C7E72087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mev.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754918AbeFNJ6p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 05:58:45 -0400
Received: from smtp65.iad3a.emailsrvr.com ([173.203.187.65]:48920 "EHLO
        smtp65.iad3a.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754633AbeFNJ6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 05:58:44 -0400
Received: from smtp17.relay.iad3a.emailsrvr.com (localhost [127.0.0.1])
        by smtp17.relay.iad3a.emailsrvr.com (SMTP Server) with ESMTP id 8B60A25FB1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jun 2018 05:58:43 -0400 (EDT)
Received: from smtp105.iad3b.emailsrvr.com (relay.iad3a.rsapps.net [172.27.255.110])
        by smtp17.relay.iad3a.emailsrvr.com (SMTP Server) with ESMTPS id 8533125F14
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jun 2018 05:58:43 -0400 (EDT)
Received: from smtp22.relay.iad3b.emailsrvr.com (localhost [127.0.0.1])
        by smtp22.relay.iad3b.emailsrvr.com (SMTP Server) with ESMTP id D095F60075;
        Thu, 14 Jun 2018 05:58:42 -0400 (EDT)
X-Auth-ID: siepeng@mev.co.uk
Received: by smtp22.relay.iad3b.emailsrvr.com (Authenticated sender: siepeng-AT-mev.co.uk) with ESMTPSA id 37E886006D;
        Thu, 14 Jun 2018 05:58:42 -0400 (EDT)
X-Sender-Id: siepeng@mev.co.uk
Received: from [10.0.0.185] (remote.quintadena.com [81.133.34.160])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA)
        by 0.0.0.0:465 (trex/5.7.12);
        Thu, 14 Jun 2018 05:58:42 -0400
Subject: Re: [PATCH] staging: comedi: add error handling for vmap
To:     Zhouyang Jia <jiazhouyang09@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     devel@driverdev.osuosl.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
References: <1528773937-38106-1-git-send-email-jiazhouyang09@gmail.com>
 <20180612115039.sz4zjgf7vrudpvyx@mwanda>
 <CABb2TxKVnC3KkCAs501ffzomOF8GLfLqDvWW=z7mHRf8UKc9YQ@mail.gmail.com>
From:   Ian Abbott <abbotti@mev.co.uk>
Organization: MEV Ltd.
Message-ID: <d1d5708b-23a8-f8d1-5f4a-799cd27a4304@mev.co.uk>
Date:   Thu, 14 Jun 2018 10:58:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CABb2TxKVnC3KkCAs501ffzomOF8GLfLqDvWW=z7mHRf8UKc9YQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/06/18 08:57, Zhouyang Jia wrote:
> Hi,
> 
> I reported this bug since more than 90% callsites of vmap are
> well handled in kernel. The caller function __comedi_buf_alloc
> has no return value, so I don't know how the error is handled in
> its caller.
> 
> I believe there would be a better error handling method, but I
> have limited domain knowledge, so I'm sorry I can't help here.
> 
> Thanks for your kind reply.
> 
> Best,
> Zhouyang

__comedi_buf_alloc is just a helper function factored out of, and called 
by comedi_buf_alloc.  __comedi_buf_alloc does not clean up after itself 
on error because it expects comedi_buf_alloc to detect the error and 
call __comedi_buf_free to clean up any partially allocated mess:

     __comedi_buf_alloc(dev, s, n_pages);
     if (!async->prealloc_buf) {
         /*
          * [This is not the actual comment in the code!]
          *
          * Error occured in __comedi_buf_alloc().
          * Buffer may be partially allocated.
          * Call __comedi_buf_free() to clean it up.
          */
         __comedi_buf_free(dev, s);
         return -ENOMEM;
     }

> 
> 
> 
> 2018-06-12 19:50 GMT+08:00 Dan Carpenter <dan.carpenter@oracle.com 
> <mailto:dan.carpenter@oracle.com>>:
> 
>     On Tue, Jun 12, 2018 at 11:25:35AM +0800, Zhouyang Jia wrote:
>     > When vmap fails, the lack of error-handling code may
>     > cause unexpected results.
>     > 
>     > This patch adds error-handling code after calling vmap.
>     > 
> 
>     Again, this is not error handling, this is just an error message.  This
>     error condition is handled in the caller.
> 
>     regards,
>     dan carpenter
> 
> 
> 


-- 
-=( Ian Abbott <abbotti@mev.co.uk> || Web: www.mev.co.uk )=-
-=( MEV Ltd. is a company registered in England & Wales. )=-
-=( Registered number: 02862268.  Registered address:    )=-
-=( 15 West Park Road, Bramhall, STOCKPORT, SK7 3JZ, UK. )=-
