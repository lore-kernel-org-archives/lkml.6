Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF065C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 20:19:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D9C3216C4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 20:19:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D9C3216C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=profihost.ag
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728529AbeI1Ci6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 22:38:58 -0400
Received: from cloud1-vm154.de-nserver.de ([178.250.10.56]:21045 "EHLO
        cloud1-vm154.de-nserver.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727265AbeI1Ci6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 22:38:58 -0400
Received: (qmail 23768 invoked from network); 27 Sep 2018 22:18:56 +0200
X-Fcrdns: No
Received: from phoffice.de-nserver.de (HELO [10.242.2.3]) (185.39.223.5)
  (smtp-auth username hostmaster@profihost.com, mechanism plain)
  by cloud1-vm154.de-nserver.de (qpsmtpd/0.92) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) ESMTPSA; Thu, 27 Sep 2018 22:18:56 +0200
From:   Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: [PATCH] bcache: add separate workqueue for journal_write to avoid
 deadlock
To:     Eddie Chapman <eddie@ehuk.net>
Cc:     Coly Li <colyli@suse.de>, guoju <fangguoju@gmail.com>,
        kent.overstreet@gmail.com, linux-bcache@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1538055919-5757-1-git-send-email-fangguoju@gmail.com>
 <bda92f58-d321-d4db-c73f-0ceecbfd9c38@suse.de>
 <9b1abe65-c6f5-77b4-290e-e6af21723cfc@ehuk.net>
Message-ID: <b5a258f4-2d58-04ad-96f7-22cd42588a3c@profihost.ag>
Date:   Thu, 27 Sep 2018 22:18:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <9b1abe65-c6f5-77b4-290e-e6af21723cfc@ehuk.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: de-DE
X-User-Auth: Auth by hostmaster@profihost.com through 185.39.223.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Coly,

is this the deadlock I reported some weeks ago?

Greets,
Stefan

Excuse my typo sent from my mobile phone.

Am 27.09.2018 um 17:53 schrieb Eddie Chapman <eddie@ehuk.net
<mailto:eddie@ehuk.net>>:

> On 27/09/18 16:23, Coly Li wrote:
>> On 9/27/18 9:45 PM, guoju wrote:
>>> After write SSD completed, bcache schedule journal_write work to
>>> system_wq, that is a public workqueue in system, without WQ_MEM_RECLAIM
>>> flag. system_wq is also a bound wq, and there may be no idle kworker on
>>> current processor. Creating a new kworker may unfortunately need to
>>> reclaim memory first, by shrinking cache and slab used by vfs, which
>>> depends on bcache device. That's a deadlock.
>>>
>>> This patch create a new workqueue for journal_write with WQ_MEM_RECLAIM
>>> flag. It's rescuer thread will work to avoid the deadlock.
>>>
>>> Signed-off-by: guoju <fangguoju@gmail.com <mailto:fangguoju@gmail.com>>
>> Nice catch, this fix is quite important. I will try to submit to Jens
>> ASAP.
>> Thanks.
>> Coly Li
>
> Once this goes into 4.19, would this be a candidate for backporting to
> any stable kernels, or does it only fix something introduced in this
> cycle?
>
> thanks,
> Eddie
