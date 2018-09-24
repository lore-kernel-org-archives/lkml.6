Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 268BCC43382
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 22:22:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF985206B8
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 22:22:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF985206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727817AbeIYE0c convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 00:26:32 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:58027 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726161AbeIYE0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 00:26:32 -0400
X-Originating-IP: 99.0.85.34
Received: from jarnos-mbp.lan (unknown [99.0.85.34])
        (Authenticated sender: jarno@ovn.org)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 649D11C0007;
        Mon, 24 Sep 2018 22:22:03 +0000 (UTC)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [Regression] openvswitch: Add eventmask support to CT action.
From:   Jarno Rajahalme <jarno@ovn.org>
In-Reply-To: <0d69e5b1-ac17-52c4-04f9-34ad1eb9f2eb@canonical.com>
Date:   Mon, 24 Sep 2018 15:21:59 -0700
Cc:     gvrose8192@gmail.com, joe@ovn.org, davem@davemloft.net,
        pshelar@ovn.org, netdev@vger.kernel.org,
        ovs dev <dev@openvswitch.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        james.page@canonical.com, christian.ehrhardt@canonical.com,
        1736390@bugs.launchpad.net
Content-Transfer-Encoding: 8BIT
Message-Id: <E891AED6-8406-4914-BDC3-92248F77C63B@ovn.org>
References: <0d69e5b1-ac17-52c4-04f9-34ad1eb9f2eb@canonical.com>
To:     Joseph Salisbury <joseph.salisbury@canonical.com>
X-Mailer: Apple Mail (2.3273)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Sep 21, 2018, at 2:37 AM, Joseph Salisbury <joseph.salisbury@canonical.com> wrote:
> 
> Hi Jarno,
> 
> A kernel bug report was opened against Ubuntu [0].  This bug is a
> regression introduced in v4.12-rc1.  The latest mainline kernel was
> tested and still exhibits the bug.  The following commit was identified
> as the cause of the regression:
> 
>     120645513f55 ("openvswitch: Add eventmask support to CT action.")
> 
> I was hoping to get your feedback, since you are the patch author.  Do
> you think gathering any additional data will help diagnose this issue?
> 
> 
> Thanks,
> 
> Joe
> 
> http://pad.lv/1736390
> 

I spent a while looking what could cause an i386-only issue like reported due to this commit, but could not come up with anything solid. Essentially the commit is setting the ‘ctmask’ field of a CT eceche extension. The purpose of the ‘ctmask’ is to limit the type of conntrack events for which a report Is delivered to any monitors in userspace. With a non-default (default is all-ones) ‘ctmask’ the code paths taken in nf_conntrack_eventmask_report() and nf_ct_deliver_cached_events() are changed to skip the generation of event reports for some event types. While it is hard to see how this could manifest as a bug in i386, this should be the only effect of the commit referred to above.

OVS probes for the kernel support of this feature and only uses the OVS_CT_ATTR_EVENTMASK attribute if support for it in the kernel is detected. The option of reverting the commit will cause additional CPU use and potential buffering issues for CT event monitors in userspace. If you need to revert the commit please try to do so only for the affected architecture (i386).

However, while reviewing all the uses of ‘ctmask’ and the associated nf_ct_ecache_ext_add() calls in the kernel with Joe we figured it would be worth trying a change where ‘ctmask’ is set in the CT template instead on the actual CT entry directly. This is a long shot in the sense of changing the behavior, but the only thing we could come up now. I have attached the patch below, please try it in your test rig.

commit a717743bd355b3a25a83b196403db9d010b311b2 (HEAD -> ovs-set-ctmask-in-template)
Author: Jarno Rajahalme <jarno@covalent.io>
Date:   Mon Sep 24 14:34:26 2018 -0700

    openvswitch: Set CT mask in template
    
    Set the conntrack event mask in the template rather than on the conntrack
    entry itself. init_conntrack() (called via nf_conntrack_in()) will pick
    the event mask from the template.
    
    Signed-off-by: Jarno Rajahalme <jarno@ovn.org>

diff --git a/net/openvswitch/conntrack.c b/net/openvswitch/conntrack.c
index 86a75105af1a..ae1fb06828da 100644
--- a/net/openvswitch/conntrack.c
+++ b/net/openvswitch/conntrack.c
@@ -1169,21 +1169,6 @@ static int ovs_ct_commit(struct net *net, struct sw_flow_key *key,
                }
        }
 #endif
-
-       /* Set the conntrack event mask if given.  NEW and DELETE events have
-        * their own groups, but the NFNLGRP_CONNTRACK_UPDATE group listener
-        * typically would receive many kinds of updates.  Setting the event
-        * mask allows those events to be filtered.  The set event mask will
-        * remain in effect for the lifetime of the connection unless changed
-        * by a further CT action with both the commit flag and the eventmask
-        * option. */
-       if (info->have_eventmask) {
-               struct nf_conntrack_ecache *cache = nf_ct_ecache_find(ct);
-
-               if (cache)
-                       cache->ctmask = info->eventmask;
-       }
-
        /* Apply changes before confirming the connection so that the initial
         * conntrack NEW netlink event carries the values given in the CT
         * action.
@@ -1625,6 +1610,20 @@ int ovs_ct_copy_action(struct net *net, const struct nlattr *attr,
                return -ENOMEM;
        }
 
+       /* Set the conntrack event mask if given.  NEW and DELETE events have
+        * their own groups, but the NFNLGRP_CONNTRACK_UPDATE group listener
+        * typically would receive many kinds of updates.  Setting the event
+        * mask allows those events to be filtered.  The set event mask will
+        * remain in effect for the lifetime of the connection unless changed
+        * by a further CT action with both the commit flag and the eventmask
+        * option. */
+       if (ct_info.have_eventmask) {
+               if (!nf_ct_ecache_ext_add(ct_info.ct, ct_info.eventmask, 0, GFP_KERNEL)) {
+                       OVS_NLERR(log, "Failed to allocate ecache for conntrack template");
+                       return -ENOMEM;
+               }
+       }
+
        __set_bit(IPS_CONFIRMED_BIT, &ct_info.ct->status);
        nf_conntrack_get(&ct_info.ct->ct_general);
 

