Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9801CC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 05:27:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49A8720850
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 05:27:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49A8720850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754455AbeFRF13 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 01:27:29 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34092 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752361AbeFRF12 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 01:27:28 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AA56E40201A5;
        Mon, 18 Jun 2018 05:27:27 +0000 (UTC)
Received: from llong.remote.csb (ovpn-121-11.rdu2.redhat.com [10.10.121.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2371A2166BB0;
        Mon, 18 Jun 2018 05:27:25 +0000 (UTC)
Subject: Re: [PATCH] ipc: Limit sysctl value to IPCMNI
To:     Andrew Morton <akpm@linux-foundation.org>,
        Takashi Iwai <tiwai@suse.de>
Cc:     Davidlohr Bueso <dbueso@suse.de>, linux-kernel@vger.kernel.org
References: <20180608134949.12672-1-tiwai@suse.de>
 <20180608141659.8a517b128c756b4d0b813c9e@linux-foundation.org>
 <s5ha7s43167.wl-tiwai@suse.de>
 <20180611161845.6164d3a6c2df353fe11895bf@linux-foundation.org>
 <s5htvq8zf2n.wl-tiwai@suse.de>
 <20180612163601.bef7f58dadda2832b36db3f6@linux-foundation.org>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <b4162bb3-3cb2-bd86-63f5-da4f92079745@redhat.com>
Date:   Mon, 18 Jun 2018 13:27:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180612163601.bef7f58dadda2832b36db3f6@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Mon, 18 Jun 2018 05:27:27 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Mon, 18 Jun 2018 05:27:27 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'longman@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/13/2018 07:36 AM, Andrew Morton wrote:
> On Tue, 12 Jun 2018 08:36:32 +0200 Takashi Iwai <tiwai@suse.de> wrote:
>
>>> Well the present behaviour is to convert higher values downwards, yes?
>>>
>>> int ipc_addid(struct ipc_ids *ids, struct kern_ipc_perm *new, int limit)
>>> {
>>> 	kuid_t euid;
>>> 	kgid_t egid;
>>> 	int id, err;
>>>
>>> 	if (limit > IPCMNI)
>>> 		limit = IPCMNI;
>>>
>>> So if someone out there is presently setting this to 999999 then their
>>> kernel will work just fine.  After your proposed change, it will no
>>> longer do so - the tuning attempt will fail with -EINVAL.
>>>
>>> It really does us no good to say "you shouldn't have been doing that". 
>>> The fact that they *are* doing it and that it works OK is the kernel
>>> developers' fault for not applying suitable checking on day one.  I
>>> think we're stuck with continuing to accept such input.
>> Hm, that's one concern, yes.
>>
>> OTOH, we do secretly ignore the input value, and this isn't what's
>> expected by user, either.  Moreover, user-space has no slightest idea
>> which value can be accepted and which not.
>>
>> Actually I posted it just because of requests from customers who
>> needed to raise the bar, but didn't notice the effect.

My patchset actually contains patch to increase the IPC limit to over 32k.

>>
>> Maybe another possible solution would be to add another proc entry to
>> handle this correctly, and make the old one only for compatibility.
> Yes, I guess so.  Just leave the old tunable alone.  Possibly we
> could add a printk_once("please switch to the new interface").

A problem with that is the fact that those sysctl parameters have been
there for so long that it may be hard to persuade users to use the new
sysctl parameters. Earlier version of the patchset had added a clamping
minmax function to address that issue. However, it was deemed overkill
for adding quite a lot of code with not that much benefit.

Another alternative is to add a new sysctl parameter to turn on compat
mode where no error will be reported if it exceeds the limit just like
before. So a sysadmin can turn on compat mode if reporting range error
is an issue for existing applications.

Cheers,
Longman


