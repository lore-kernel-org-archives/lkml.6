Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB91EC5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 16:11:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D2F72145D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 16:11:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D2F72145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deneb.enyo.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728517AbeJSANL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 20:13:11 -0400
Received: from albireo.enyo.de ([5.158.152.32]:59462 "EHLO albireo.enyo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727417AbeJSANL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 20:13:11 -0400
Received: from [172.17.203.2] (helo=deneb.enyo.de)
        by albireo.enyo.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1gDAtS-0007LR-Ue; Thu, 18 Oct 2018 16:11:27 +0000
Received: from fw by deneb.enyo.de with local (Exim 4.89)
        (envelope-from <fw@deneb.enyo.de>)
        id 1gDAtS-000432-OI; Thu, 18 Oct 2018 18:11:26 +0200
From:   Florian Weimer <fw@deneb.enyo.de>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org, David Howells <dhowells@redhat.com>,
        "Michael Kerrisk \(man-pages\)" <mtk.manpages@gmail.com>,
        Andreas Dilger <adilger@dilger.ca>
Subject: Re: [PATCH 2/3] uapi: get rid of STATX_ALL
References: <20181018131125.6303-1-mszeredi@redhat.com>
        <20181018131125.6303-2-mszeredi@redhat.com>
        <CAOQ4uxiFrtphwYhDMpsiENV8zkHHKmthb7cB2T0PKU5BA_YTWw@mail.gmail.com>
Date:   Thu, 18 Oct 2018 18:11:26 +0200
In-Reply-To: <CAOQ4uxiFrtphwYhDMpsiENV8zkHHKmthb7cB2T0PKU5BA_YTWw@mail.gmail.com>
        (Amir Goldstein's message of "Thu, 18 Oct 2018 17:51:54 +0300")
Message-ID: <87va5zw7yp.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Amir Goldstein:

> On Thu, Oct 18, 2018 at 4:11 PM Miklos Szeredi <mszeredi@redhat.com> wrote:
>>
>> Constants of the *_ALL type can be actively harmful due to the fact that
>> developers will usually fail to consider the possible effects of future
>> changes to the definition.
>>
>> Remove STATX_ALL from the uapi, while no damage has been done yet.
>>
>
> Look. When Linus says "let's see if somebody notices" and referring to ABI
> it means sooner or later someone will upgrade to newer kernel and complain
> if something breaks.
>
> But what does it mean with UAPI change?  How often do people
> re-build existing programs?  I, for one, build master for my
> testing, but never install uapi headers from master.  I just can't
> wrap my head around the backward compatibiltiy nightmare a change
> like this could create.

So it appears that people use #ifdef STATX_ALL to check for struct
statx availability.  So the backwards compatibility impact is that you
silently lose features in a consistent manner, which is very hard to
spot. 8-(

Probably not a good idea, then.
