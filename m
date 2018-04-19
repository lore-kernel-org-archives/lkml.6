Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3917498-1524169388-2-1136733958576630231
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='cz',
  MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Attached: 0001-fsnotify-Fix-fsnotify_mark_connector-race.patch
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524169387; b=tsXXK3/cOVnfvpO7xxnUwOl2h648GEyvndUtHU9fmGAY4VSGJk
    0S2Pv87Z3IvTJpL3sYQJoM+0hTsxNeGiWsSDxelWnlx6X6j8u7toWTnQVhHaW3eJ
    IXf3IsTRa6/rIcnBgj9MSaravy1PO/DmBpuxD+EsdFtr1aC7z+YdxAeCh6FcuW5R
    Tj1fCMQPsYpv7TL0UWelfcb25B+APbNFfDNfAcWh1+O1NtbGaBQNL+xU0RW+YZ+X
    rVTxwx1yd5ETl6502nf9DUFMXQl875sMNkl0hSpceOGxgdKwzPJmj99iSSEDP7Hb
    dOc4WCxDRWEACHsIUZ+d+RPqL0fRSwMoAwfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=fm2; t=1524169387; bh=VJ1AXaiMOe4
    jdOO1NNmy1r8Y/qQcPfBx+fIAC8LCeTc=; b=GVkkjLT8m4HqiYZlg3m0UXbccpv
    /Q67Fydfkk+8nwAG5Mff+SClOaieUQLLMD71vODuWRAiVEtMrLjM2iHyH29H7H/K
    mvyVqFjBQ0KrfkHdpqMxMwc1rtFRiNW5cskyl0V+8sQoqWiqjwY5ZWEtXb9K8M0V
    fmhMzuH6kLZR67rKi30UrLoHc739huhyO7VkkKZ1skSknbY5+OKBT+Qz7jNw8hO3
    NCdI4GwzP7EllikLvKa/2CZ2O0Kqi8AF12JnHLfDtJvieKnvjxBjN+5aJE/OLEvK
    H423TWaYsnkLYimtlu89lN901O0jSsditteKqWHSmwz1ZgiwVPvMVRJ6bNw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.cz header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.cz header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJuhnoFOpbtBDKmdfm68aKb9Jd/vtEof/2MCtRaFI5Wqj6qk56yodyBIUup0nvtMurhx8LV/Ya65YfaVD6jU5nrOQq16hYut5aPfVzpMjCLC7xF+2Av+
    MLfBYw/FPc5YLMgnCrd8WEcjdr+IVavYl/tAw7qOncM45fV7Yy2YqneDEkjIleMfcDgB11SmSPXi0QhxS2Zi6z6OvJgwGvrFqgRnv2kojABxI+AVF1HksYcd
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=iox4zFpeAAAA:8
    a=giP-0Ofc6_bTtBeSAFQA:9 a=QEXdDO2ut3YA:10 a=1XWaLZrsAAAA:8 a=VwQbUJbxAAAA:8
    a=oaXb9-GYITS9E5uqRKQA:9 a=CjuIK1q_8ugA:10 a=WzC6qhA0u3u7Ye7llzcV:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753179AbeDSUXF (ORCPT <rfc822;greg@kroah.com>);
        Thu, 19 Apr 2018 16:23:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:40652 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752962AbeDSUXE (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 19 Apr 2018 16:23:04 -0400
Date: Thu, 19 Apr 2018 22:23:02 +0200
From: Jan Kara <jack@suse.cz>
To: Pavlos Parissis <pavlos.parissis@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Guillaume Morin <guillaume@morinfr.org>,
        stable@vger.kernel.org, decui@microsoft.com, jack@suse.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mszeredi@redhat.com, Robert Kolchmeyer <rkolchmeyer@google.com>
Subject: Re: kernel panics with 4.14.X versions
Message-ID: <20180419202302.vj2eu43hy77g5mv7@quack2.suse.cz>
References: <20180416132550.d25jtdntdvpy55l3@bender.morinfr.org>
 <20180416144041.t2mt7ugzwqr56ka3@quack2.suse.cz>
 <9b11cfba-4bdc-8a3e-cd33-2f7e8d513bdf@gmail.com>
 <20180417121207.cs7eijrndovbplgz@quack2.suse.cz>
 <9cb08428-66ed-2306-d2f2-ae734863c68d@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="hhioe36qsbsvo2cy"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9cb08428-66ed-2306-d2f2-ae734863c68d@gmail.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--hhioe36qsbsvo2cy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed 18-04-18 10:32:21, Pavlos Parissis wrote:
> On 17/04/2018 02:12 μμ, Jan Kara wrote:
> > On Tue 17-04-18 01:31:24, Pavlos Parissis wrote:
> >> On 16/04/2018 04:40 μμ, Jan Kara wrote:
> > 
> > <snip>
> > 
> >>> How easily can you hit this?
> >>
> >> Very easily, I only need to wait 1-2 days for a crash to occur.
> > 
> > I wouldn't call that very easily but opinions may differ :). Anyway it's
> > good (at least for debugging) that it's reproducible.
> > 
> 
> Unfortunately, I can't reproduce it, so waiting 1-2 days is the only
> option I have.

Good news guys, Robert has just spotted a bug which looks like what I'd
expect can cause your lockups / crashes. I've merged his patch to my tree
and will push it to Linus for -rc3 so eventually it should land in
appropriate stable trees as well. If you are too eager to test it out, it
is attached for you to try.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

--hhioe36qsbsvo2cy
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="0001-fsnotify-Fix-fsnotify_mark_connector-race.patch"

>From d90a10e2444ba5a351fa695917258ff4c5709fa5 Mon Sep 17 00:00:00 2001
From: Robert Kolchmeyer <rkolchmeyer@google.com>
Date: Thu, 19 Apr 2018 10:44:33 -0700
Subject: [PATCH] fsnotify: Fix fsnotify_mark_connector race

fsnotify() acquires a reference to a fsnotify_mark_connector through
the SRCU-protected pointer to_tell->i_fsnotify_marks. However, it
appears that no precautions are taken in fsnotify_put_mark() to
ensure that fsnotify() drops its reference to this
fsnotify_mark_connector before assigning a value to its 'destroy_next'
field. This can result in fsnotify_put_mark() assigning a value
to a connector's 'destroy_next' field right before fsnotify() tries to
traverse the linked list referenced by the connector's 'list' field.
Since these two fields are members of the same union, this behavior
results in a kernel panic.

This issue is resolved by moving the connector's 'destroy_next' field
into the object pointer union. This should work since the object pointer
access is protected by both a spinlock and the value of the 'flags'
field, and the 'flags' field is cleared while holding the spinlock in
fsnotify_put_mark() before 'destroy_next' is updated. It shouldn't be
possible for another thread to accidentally read from the object pointer
after the 'destroy_next' field is updated.

The offending behavior here is extremely unlikely; since
fsnotify_put_mark() removes references to a connector (specifically,
it ensures that the connector is unreachable from the inode it was
formerly attached to) before updating its 'destroy_next' field, a
sizeable chunk of code in fsnotify_put_mark() has to execute in the
short window between when fsnotify() acquires the connector reference
and saves the value of its 'list' field. On the HEAD kernel, I've only
been able to reproduce this by inserting a udelay(1) in fsnotify().
However, I've been able to reproduce this issue without inserting a
udelay(1) anywhere on older unmodified release kernels, so I believe
it's worth fixing at HEAD.

References: https://bugzilla.kernel.org/show_bug.cgi?id=199437
Fixes: 08991e83b7286635167bab40927665a90fb00d81
CC: stable@vger.kernel.org
Signed-off-by: Robert Kolchmeyer <rkolchmeyer@google.com>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 include/linux/fsnotify_backend.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index 9f1edb92c97e..a3d13d874fd1 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -217,12 +217,10 @@ struct fsnotify_mark_connector {
 	union {	/* Object pointer [lock] */
 		struct inode *inode;
 		struct vfsmount *mnt;
-	};
-	union {
-		struct hlist_head list;
 		/* Used listing heads to free after srcu period expires */
 		struct fsnotify_mark_connector *destroy_next;
 	};
+	struct hlist_head list;
 };
 
 /*
-- 
2.13.6


--hhioe36qsbsvo2cy--
