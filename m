Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C37C9C5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 18:03:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 955B02081F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 18:03:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 955B02081F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728973AbeLJSDb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 13:03:31 -0500
Received: from mfb01-md.ns.itscom.net ([175.177.155.109]:39361 "EHLO
        mfb01-md.ns.itscom.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727190AbeLJSDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 13:03:31 -0500
X-Greylist: delayed 412 seconds by postgrey-1.27 at vger.kernel.org; Mon, 10 Dec 2018 13:03:30 EST
Received: from mail05-md.ns.itscom.net (mail05-md.ns.itscom.net [175.177.155.115])
        by mfb01-md.ns.itscom.net (Postfix) with ESMTP id 55FC5238C21
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 02:56:38 +0900 (JST)
Received: from scan26-mds.s.noc.itscom.net (scan26-md.ns.itscom.net [175.177.155.80])
        by mail05-md-outgoing.ns.itscom.net (Postfix) with ESMTP id A8374658562;
        Tue, 11 Dec 2018 02:56:36 +0900 (JST)
Received: from unknown (HELO mail04-md-outgoing.ns.itscom.net) ([175.177.155.114])
  by scan26-mds.s.noc.itscom.net with ESMTP; 11 Dec 2018 02:56:36 +0900
Received: from jromail.nowhere (h219-110-198-186.catv02.itscom.jp [219.110.198.186])
        by mail04-md-outgoing.ns.itscom.net (Postfix) with ESMTP;
        Tue, 11 Dec 2018 02:56:36 +0900 (JST)
Received: from jro by jrobl id 1gWPnI-0000EC-9P ; Tue, 11 Dec 2018 02:56:36 +0900
From:   "J. R. Okajima" <hooanon05g@gmail.com>
To:     mingo@redhat.com, arjan@linux.intel.com
Cc:     linux-kernel@vger.kernel.org
Subject: Q. re-using lock_classes[]
Date:   Tue, 11 Dec 2018 02:56:36 +0900
Message-ID: <879.1544464596@jrobl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

"Troubleshooting" section in Documentation/locking/lockdep-design.txt
describes
----------------------------------------
1.	Repeated module loading and unloading while running the validator
	will result in lock-class leakage.  The issue here is that each
	load of the module will create a new set of lock classes for
	that module's locks, but module unloading does not remove old
	classes (see below discussion of reuse of lock classes for why).
	Therefore, if that module is loaded and unloaded repeatedly,
	the number of lock classes will eventually reach the maximum.
:::
One might argue that the validator should be modified to allow
lock classes to be reused.  However, if you are tempted to make this
argument, first review the code and think through the changes that would
be required, keeping in mind that the lock classes to be removed are
likely to be linked into the lock-dependency graph.  This turns out to
be harder to do than to say.
----------------------------------------

I am wondering these
	"module unloading does not remove old classes"
	"the lock classes to be removed are likely to be linked into the
	lock-dependency graph"
sentences are still valid?
Does "the lock-dependency graph" mean
	class->hash_entry
	class->lock_entry
	and/or
	list_entries[]?
Those are handled by zap_class() at unloading the module.

Here is my question.
Doesn't zap_class() make the slot in lock_classes[] logically unused?
If so, can we re-use the unused slot by searchng and testing some
members in struct lock_class?  For example,

bool test_unused(class)
{
	return !rcu_access_pointer(class->name)
		&& !rcu_access_pointer(class->key)
		&& list_empty(&class->lock_entry)
		&& hlist_unhashed(&class->hash_entry);
}

Though a new function list_del_init_rcu() for zap_class() will be
necessary.


J. R. Okajima
