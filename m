Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B57E0C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 21:18:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FB8D258EC
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 21:18:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FB8D258EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753473AbeGBVSP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 17:18:15 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36486 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753156AbeGBVSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 17:18:14 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.9.92])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 9481FD94;
        Mon,  2 Jul 2018 21:18:12 +0000 (UTC)
Date:   Mon, 2 Jul 2018 14:18:11 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Waiman Long <longman@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Larry Woodman <lwoodman@redhat.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        "Wangkai (Kevin,C)" <wangkai86@huawei.com>, linux-mm@kvack.org,
        Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH v5 0/6] fs/dcache: Track & limit # of negative dentries
Message-Id: <20180702141811.ef027fd7d8087b7fb2ba0cce@linux-foundation.org>
In-Reply-To: <CA+55aFyH6dHw-7R3364dn32J4p7kxT=TqmnuozCn9_Bz-MHhxQ@mail.gmail.com>
References: <1530510723-24814-1-git-send-email-longman@redhat.com>
        <CA+55aFyH6dHw-7R3364dn32J4p7kxT=TqmnuozCn9_Bz-MHhxQ@mail.gmail.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Jul 2018 12:34:00 -0700 Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Sun, Jul 1, 2018 at 10:52 PM Waiman Long <longman@redhat.com> wrote:
> >
> > A rogue application can potentially create a large number of negative
> > dentries in the system consuming most of the memory available if it
> > is not under the direct control of a memory controller that enforce
> > kernel memory limit.
> 
> I certainly don't mind the patch series, but I would like it to be
> accompanied with some actual example numbers, just to make it all a
> bit more concrete.
> 
> Maybe even performance numbers showing "look, I've filled the dentry
> lists with nasty negative dentries, now it's all slower because we
> walk those less interesting entries".
> 

(Please cc linux-mm@kvack.org on this work)

Yup.  The description of the user-visible impact of current behavior is
far too vague.

In the [5/6] changelog it is mentioned that a large number of -ve
dentries can lead to oom-killings.  This sounds bad - -ve dentries
should be trivially reclaimable and we shouldn't be oom-killing in such
a situation.

Dumb question: do we know that negative dentries are actually
worthwhile?  Has anyone checked in the past couple of decades?  Perhaps
our lookups are so whizzy nowadays that we don't need them?
