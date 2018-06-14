Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 5AEE3C07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 20:33:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A105208D4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 20:33:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A105208D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935945AbeFNUdf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 16:33:35 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44068 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754819AbeFNUde (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 16:33:34 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5729C401CB89;
        Thu, 14 Jun 2018 20:33:34 +0000 (UTC)
Received: from madcap2.tricolour.ca (ovpn-112-45.rdu2.redhat.com [10.10.112.45])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EB344111762F;
        Thu, 14 Jun 2018 20:33:27 +0000 (UTC)
Date:   Thu, 14 Jun 2018 16:31:57 -0400
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        Steve Grubb <sgrubb@redhat.com>,
        Eric Paris <eparis@parisplace.org>
Subject: audit trim and audit make_equiv
Message-ID: <20180614203157.frgundev7li7uj3a@madcap2.tricolour.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180512
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Thu, 14 Jun 2018 20:33:34 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Thu, 14 Jun 2018 20:33:34 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'rgb@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Al,

I'm trying to trigger records for all the instances of
AUDIT_CONFIG_CHANGE, but I'm having trouble with a few.

AUDIT_TRIM ("auditctl -t": Trim the subtrees after a mount command.):

My reading is that should trigger at least one message (which it does)
and potentially more depending on existing tree watches and mounts via
audit_trim_trees().  I've not been able to trigger any additional ones.
What I've tried to do to trigger additional ones is to mount a
filesystem, create a subdirectory within it, set a watch on that
subdirectory, unmount the filesystem and then run a trim command.  I've
also tried the other way around, which I didn't expect to work, creating
a subdirectory, set a watch on that subdirectory, mount a filesystem on
its parent, then run a trim command.


AUDIT_MAKE_EQUIV ("auditctl -q mount-point,subtree": Make subtree
equivalent under mount point.):

The way I read this code is it should trigger at least one message
(which it does) and potentially more depending on failures of
iterate_mounts() in audit_tag_tree().  I don't know how to trigger the
latter.  Are you able to prescribe a recipe to do so?


Any insights?  Thanks!


- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635
