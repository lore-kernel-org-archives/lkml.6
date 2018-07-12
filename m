Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 567F6E9A5F7
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 17:33:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DBBC213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 17:33:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="pMsd2c6A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DBBC213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbeGLRo2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 13:44:28 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:38592 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725967AbeGLRo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 13:44:28 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id B57898EE3D1;
        Thu, 12 Jul 2018 10:33:55 -0700 (PDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id FWM_1h14zIs3; Thu, 12 Jul 2018 10:33:55 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id CAA278EE02B;
        Thu, 12 Jul 2018 10:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1531416835;
        bh=P+0Y3CmrPjaP0qgRVVH0vxI/F3BD8twcnxEYeh9Mm9Q=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=pMsd2c6AJOGcK0wgTLAxS/qXvVqj8qmcqCvMjs3YuCcnlLgmWgd9WqaaZhowQOQJ9
         WylxiiGm+itvtc4kO2kDKs3gR+8ejveo6I2s2qjgRHNi7uMKSBp5IlTszpC5Ll2bGp
         c/w0aIZP9vZlym+Tfq46zFaUzPVa5Z96+edGSVJY=
Message-ID: <1531416833.18255.10.camel@HansenPartnership.com>
Subject: Re: [PATCH v6 0/7] fs/dcache: Track & limit # of negative dentries
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Waiman Long <longman@redhat.com>, Michal Hocko <mhocko@kernel.org>
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
        Matthew Wilcox <willy@infradead.org>,
        Larry Woodman <lwoodman@redhat.com>,
        "Wangkai (Kevin C)" <wangkai86@huawei.com>
Date:   Thu, 12 Jul 2018 10:33:53 -0700
In-Reply-To: <30ac8e9b-a48c-9c37-5a96-731ad214262b@redhat.com>
References: <1530905572-817-1-git-send-email-longman@redhat.com>
         <20180709081920.GD22049@dhcp22.suse.cz>
         <62275711-e01d-7dbe-06f1-bf094b618195@redhat.com>
         <20180710142740.GQ14284@dhcp22.suse.cz>
         <a2794bcc-9193-cbca-3a54-47420a2ab52c@redhat.com>
         <20180711102139.GG20050@dhcp22.suse.cz>
         <9f24c043-1fca-ee86-d609-873a7a8f7a64@redhat.com>
         <1531330947.3260.13.camel@HansenPartnership.com>
         <18c5cbfe-403b-bb2b-1d11-19d324ec6234@redhat.com>
         <1531336913.3260.18.camel@HansenPartnership.com>
         <4d49a270-23c9-529f-f544-65508b6b53cc@redhat.com>
         <1531411494.18255.6.camel@HansenPartnership.com>
         <30ac8e9b-a48c-9c37-5a96-731ad214262b@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-07-12 at 12:26 -0400, Waiman Long wrote:
> On 07/12/2018 12:04 PM, James Bottomley wrote:
> > On Thu, 2018-07-12 at 11:54 -0400, Waiman Long wrote:
> > > 
> > > It is not that dentry cache is harder to get rid of than the
> > > other memory. It is that the ability of generate unlimited number
> > > of negative dentries that will displace other useful memory from
> > > the system. What the patch is trying to do is to have a warning
> > > or notification system in place to spot unusual activities in
> > > regard to the number of negative dentries in the system. The
> > > system administrators can then decide on what to do next.
> > 
> > But every cache has this property: I can cause the same effect by
> > doing a streaming read on a multi gigabyte file: the page cache
> > will fill with the clean pages belonging to the file until I run
> > out of memory and it has to start evicting older cache
> > entries.  Once we hit the steady state of minimal free memory, the
> > mm subsytem tries to balance the cache requests (like my streaming
> > read) against the existing pool of cached objects.
> > 
> > The question I'm trying to get an answer to is why does the dentry
> > cache need special limits when the mm handling of the page cache
> > (and other mm caches) just works?
> > 
> > James
> > 
> 
> I/O activities can be easily tracked.

Tracked?  What do you mean tracked?  you mean we can control the page
cache through userfaultfd or something without resorting to cgroup
limits or something different?  I mean all caches are "tracked" because
otherwise we wouldn't know whether we have to retrieve/generate the
object or pull it from the cache.  If it's just about cache state,
what's wrong with /proc/sys/fs/dentry-state?

>  Generation of negative dentries, however, is more insidious. So the
> ability to track and be notified when too many negative dentries are
> created can be a useful tool for the system administrators. Besides,
> there are paranoid users out there who want to have control of as
> much as system parameters as possible.

To what end?  what problem are these administrators trying to solve? 
You keep coming back to the circular argument that the problem they're
trying to solve is limiting negative dentries, but I want to know what
issue they see in their systems that causes them to ask for this knob.

James

