Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BBA0C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 21:35:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AE2E2087A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 21:35:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AE2E2087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727650AbeJ3GZr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 02:25:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52362 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726568AbeJ3GZr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 02:25:47 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BC6933001975;
        Mon, 29 Oct 2018 21:35:16 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-8.bos.redhat.com [10.18.17.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 15C9F2BFEF;
        Mon, 29 Oct 2018 21:35:16 +0000 (UTC)
Subject: Re: [PATCH] fs/proc: introduce /proc/stat2 file
To:     Vito Caputo <vcaputo@pengaru.com>
Cc:     Davidlohr Bueso <dave@stgolabs.net>, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dbueso@suse.de>
References: <20181029192521.23059-1-dave@stgolabs.net>
 <0afed890-7c5a-93ee-cdb9-e30775bd9cf1@redhat.com>
 <20181029200050.iejuxckzbm742dmw@linux-r8p5>
 <3c5ba85b-5114-c751-0114-ac2cb64c02ea@redhat.com>
 <20181029203818.pot26ewxbncfrnua@linux-r8p5>
 <b40690db-273f-ff67-01bf-de0111deb499@redhat.com>
 <20181029212314.nwruqg6au23ebqlu@shells.gnugeneration.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <492f93c1-e062-f699-8c8c-c2277fd3fbb0@redhat.com>
Date:   Mon, 29 Oct 2018 17:35:15 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20181029212314.nwruqg6au23ebqlu@shells.gnugeneration.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Mon, 29 Oct 2018 21:35:16 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/29/2018 05:23 PM, Vito Caputo wrote:
> On Mon, Oct 29, 2018 at 04:59:03PM -0400, Waiman Long wrote:
>> On 10/29/2018 04:38 PM, Davidlohr Bueso wrote:
>>> On Mon, 29 Oct 2018, Waiman Long wrote:
>>>
>>>> BTW, since you are making stat2 compatible with stat, will that be
>>>> easier from the user API perspective if we use a sysctl parameter to
>>>> turn on and off IRQs reporting for /proc/stat, for example?
>>> For one /proc/stat is also common for debugging envs (ie: performance)
>>> and I fear that if a tunnable modifies the behavior of the output, we
>>> it might never be usable again (at least not without having users also
>>> now consider the systctl parameter). Making it dynamic I think is not
>>> worth it.
>>>
>>> Thanks,
>>> Davidlohr
>> This is just a matter if it is easier for users to modify their code to
>> use /proc/stat2 or turning on a sysctl parameter. Again, this will
>> certainly depend on the circumstances.
>>
> I wonder if it makes sense to introduce a more general mechanism for
> toggling subfields in proc files.  Extended attributes could probably be
> abused to key the subfields, write a 1 or 0 to well-known names for
> toggling them on a per-fd basis via fsetxattr.
>
> For this particular case the program would just have to add code like:
>
> int	zero = 0;
> fsetxattr(proc_stat_fd, "intr", &zero, sizeof(zero), XATTR_REPLACE);
>
> Just putting it out there.  I've certainly wanted an ability to noop
> fields before where I was polling proc frequently and skipping the bulk
> of what was there but syscpu was still rather high.
>
> I'm definitely not in favor of just adding another stat file that is the
> same format as the existing one with the intrs zeroed out.  It's a dirty
> hack; fine for your local needs but too gross for upstream IMHO.
>
> Regards,
> Vito Caputo

Does procfs allow extended attributes? I am not sure if using extended
attributes is a usual practice for doing this kind of control on a
procfs file.

Cheers,
Longman

