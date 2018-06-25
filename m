Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3243AC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 23:17:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCA72219DB
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 23:17:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCA72219DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755740AbeFYXRT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 19:17:19 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37916 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755543AbeFYXRS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 19:17:18 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7329383207;
        Mon, 25 Jun 2018 23:17:17 +0000 (UTC)
Received: from crecklin.bos.csb (ovpn-121-147.rdu2.redhat.com [10.10.121.147])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 727322166B5D;
        Mon, 25 Jun 2018 23:17:16 +0000 (UTC)
Reply-To: crecklin@redhat.com
Subject: Re: [PATCH] add param that allows bootline control of hardened
 usercopy
To:     Kees Cook <keescook@chromium.org>
Cc:     Laura Abbott <labbott@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
References: <1529939300-27461-1-git-send-email-crecklin@redhat.com>
 <d110c9af-cb68-5a3c-bc70-0c7650edb0d4@redhat.com>
 <cfd52ae6-6fea-1a5a-b2dd-4dfdd65acd15@redhat.com>
 <2e4d9686-835c-f4be-2647-2344899e3cd4@redhat.com>
 <CAGXu5jJGqxKjcWGyAnbkmFebtPor0PEQ+2qpoMCGtjjdYRTHDw@mail.gmail.com>
From:   Christoph von Recklinghausen <crecklin@redhat.com>
Organization: Red Hat
Message-ID: <53edba5a-1652-d1c2-12c9-7f3cda746f5f@redhat.com>
Date:   Mon, 25 Jun 2018 19:17:16 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAGXu5jJGqxKjcWGyAnbkmFebtPor0PEQ+2qpoMCGtjjdYRTHDw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Mon, 25 Jun 2018 23:17:17 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Mon, 25 Jun 2018 23:17:17 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'crecklin@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/25/2018 06:35 PM, Kees Cook wrote:
> On Mon, Jun 25, 2018 at 3:29 PM, Christoph von Recklinghausen
> <crecklin@redhat.com> wrote:
>> I have a small set of customers that want CONFIG_HARDENED_USERCOPY
>> enabled, and a large number of customers who would be impacted by its
>> default behavior (before my change).  The desire was to have the smaller
>> number of users need to change their boot lines to get the behavior they
>> wanted. Adding CONFIG_HUC_DEFAULT_OFF was an attempt to preserve the
>> default behavior of existing users of CONFIG_HARDENED_USERCOPY (default
>> enabled) and allowing that to coexist with the desires of the greater
>> number of my customers (default disabled).
>>
>> If folks think that it's better to have it enabled by default and the
>> command line option to turn it off I can do that (it is simpler). Does
>> anyone else have opinions one way or the other?
> I would prefer to isolate the actual problem case, and fix it if
> possible. (i.e. try to make the copy fixed-length, etc) Barring that,
> yes, a kernel command line to disable the protection would be okay.
>
> Note that the test needs to be inside __check_object_size() otherwise
> the inline optimization with __builtin_constant_p() gets broken and
> makes everyone slower. :)
>
> -Kees
>
Thanks Kees,

I'll make that change and retest.

Chris

